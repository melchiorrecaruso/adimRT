{
  Description: ADim Run-time library.

  Copyright (C) 2024-2025 Melchiorre Caruso <melchiorrecaruso@gmail.com>

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
{$modeswitch advancedrecords}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function's return value.

{
  ADim Run-time library built on 13-04-2025.

  Number of base units: 639
  Number of factored units: 125
}

interface

uses
  SysUtils;

type
  { Prefix }
  TPrefix = (pQuetta, pRonna, pYotta, pZetta, pExa, pPeta, pTera, pGiga, pMega, pKilo, pHecto, pDeca,
    pNone, pDeci, pCenti, pMilli, pMicro, pNano, pPico, pFemto, pAtto, pZepto, pYocto, pRonto, pQuecto);

  { Prefixes }
  TPrefixes = array of TPrefix;

  { Exponents }
  TExponents = array of longint;

  { TQuantities }

  {$I scalar.inc}
  {$I complex.inc}
  {$I matrix.inc}
  {$I vector.inc}
  {$I cl3.inc}
  {$I helper.inc}
  {$I extra.inc}

type

  { TUnit }

  TUnit = record
  private
    FID: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    // Real numbers
    class operator *(const AQuantity: double; const ASelf: TUnit): TQuantity; inline;
    class operator /(const AQuantity: double; const ASelf: TUnit): TQuantity; inline;
    // Complex numbers
    class operator *(const AQuantity: TComplex; const ASelf: TUnit): TComplexQuantity; inline;
    class operator /(const AQuantity: TComplex; const ASelf: TUnit): TComplexQuantity; inline;
    class operator *(const ASelf: TUnit; const AQuantity: TComplex): TComplexQuantity; inline;
    class operator /(const ASelf: TUnit; const AQuantity: TComplex): TComplexQuantity; inline;
    // R3 vector space
    class operator *(const AQuantity: TR3Vector; const ASelf: TUnit): TR3VecQuantity; inline;
    class operator /(const AQuantity: TR3Vector; const ASelf: TUnit): TR3VecQuantity; inline;
    // CL3 vector space, Clifford algebra
    class operator *(const AQuantity: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;
    class operator /(const AQuantity: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;
    class operator *(const AQuantity: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;
    class operator /(const AQuantity: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;
    class operator *(const AQuantity: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;
    class operator /(const AQuantity: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;
    class operator *(const AQuantity: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;
    class operator /(const AQuantity: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;
  {$IFNDEF ADIMOFF}
    // Real numbers
    class operator *(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
    class operator /(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
    // Complex numbers
    class operator *(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;
    class operator /(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;
    class operator *(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
    // R3 vector space
    class operator *(const AQuantity: TR3VecQuantity; const ASelf: TUnit): TR3VecQuantity; inline;
    class operator /(const AQuantity: TR3VecQuantity; const ASelf: TUnit): TR3VecQuantity; inline;
    // CL3 vector space, Clifford algebra
    class operator *(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;
    class operator /(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;
    class operator *(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;
    class operator /(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;
    class operator *(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;
    class operator /(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;
    class operator *(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;
    class operator /(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;
  {$ENDIF}
  end;

  { TFactoredUnit }

  TFactoredUnit = record
  private
    FID: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
    FFactor: double;
  public
    // Real numbers
    class operator *(const AQuantity: double; const ASelf: TFactoredUnit): TQuantity; inline;
    class operator /(const AQuantity: double; const ASelf: TFactoredUnit): TQuantity; inline;
    // R3 vector space
    class operator *(const AQuantity: TR3Vector; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
    class operator /(const AQuantity: TR3Vector; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
    // CL3 vector space, Clifford algebra
    class operator *(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
    class operator /(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
    class operator *(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
    class operator /(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
    class operator *(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
    class operator /(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
    class operator *(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
    class operator /(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
  {$IFNDEF ADIMOFF}
    // Real numbers
    class operator *(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
    class operator /(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
    // R3 vector space
    class operator *(const AQuantity: TR3VecQuantity; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
    class operator /(const AQuantity: TR3VecQuantity; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
    // CL3 vector space, Clifford algebra
    class operator *(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
    class operator /(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
    class operator *(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
    class operator /(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
    class operator *(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
    class operator /(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
    class operator *(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
    class operator /(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
  {$ENDIF}
  end;

  { TDegreeCelsiusUnit }

  TDegreeCelsiusUnit = record
  private
    FID: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    class operator *(const AQuantity: double; const ASelf: TDegreeCelsiusUnit): TQuantity; inline;
  end;

  { TDegreeFahrenheitUnit }

  TDegreeFahrenheitUnit = record
  private
    FID: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    class operator *(const AQuantity: double; const ASelf: TDegreeFahrenheitUnit): TQuantity; inline;
  end;

 { TUnitHelper }

  TUnitHelper = record helper for TUnit
  public
    function GetName(Prefixes: TPrefixes): string;
    function GetPluralName(Prefixes: TPrefixes): string;
    function GetSymbol(Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
  public
    // Real numbers
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
    // Complex numbers
    function ToComplex(const AQuantity: TComplexQuantity): TComplex;
    function ToString(const AQuantity: TComplexQuantity): string;
    function ToVerboseString(const AQuantity: TComplexQuantity): string;
    // Complex matrix
    function ToString(const AQuantity: TC2MatrixQuantity): string;
    function ToVerboseString(const AQuantity: TC2MatrixQuantity): string;
    // Vector space
    function ToString(const AQuantity: TC2VecQuantity): string;
    function ToVerboseString(const AQuantity: TC2VecQuantity): string;

    function ToVector(const AQuantity: TR3VecQuantity): TR3Vector;
    function ToString(const AQuantity: TR3VecQuantity): string;
    function ToVerboseString(const AQuantity: TR3VecQuantity): string;
    // CL3 vector space, Clifford algebra
    function ToString(const AQuantity: TCL3VecQuantity): string;
    function ToString(const AQuantity: TCL3BivecQuantity): string;
    function ToString(const AQuantity: TCL3TrivecQuantity): string;
    function ToString(const AQuantity: TCL3MultivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3VecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3BivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;
  end;

 { TFactoredUnitHelper }

  TFactoredUnitHelper = record helper for TFactoredUnit
  public
    function GetName(Prefixes: TPrefixes): string;
    function GetPluralName(Prefixes: TPrefixes): string;
    function GetSymbol(Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
  public
    // Real numbers
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
    // Complex numbers
    function ToString(const AQuantity: TComplexQuantity): string;
    function ToVerboseString(const AQuantity: TComplexQuantity): string;
    // R3 vector space
    function ToString(const AQuantity: TR3VecQuantity): string;
    function ToVerboseString(const AQuantity: TR3VecQuantity): string;
    // CL3 vector space, Clifford algebra
    function ToString(const AQuantity: TCL3VecQuantity): string;
    function ToString(const AQuantity: TCL3BivecQuantity): string;
    function ToString(const AQuantity: TCL3TrivecQuantity): string;
    function ToString(const AQuantity: TCL3MultivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3VecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3BivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;
  end;

 { TDegreeCelsiusUnitHelper }

  TDegreeCelsiusUnitHelper = record helper for TDegreeCelsiusUnit
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
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
  end;

 { TDegreeFahrenheitUnitHelper }

  TDegreeFahrenheitUnitHelper = record helper for TDegreeFahrenheitUnit
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
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
  end;

{ TScalar }

resourcestring
  rsScalarSymbol = '';
  rsScalarName = '';
  rsScalarPluralName = '';

const
  ScalarID = 0;
  ScalarUnit : TUnit = (
    FID         : ScalarID;
    FSymbol     : rsScalarSymbol;
    FName       : rsScalarName;
    FPluralName : rsScalarPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TRadian }

resourcestring
  rsRadianSymbol = 'rad';
  rsRadianName = 'radian';
  rsRadianPluralName = 'radians';

const
  RadianUnit : TUnit = (
    FID         : ScalarID;
    FSymbol     : rsRadianSymbol;
    FName       : rsRadianName;
    FPluralName : rsRadianPluralName;
    FPrefixes   : ();
    FExponents  : ());

var
  rad : TUnit absolute RadianUnit;

{ TDegree }

resourcestring
  rsDegreeSymbol = '°';
  rsDegreeName = 'degree';
  rsDegreePluralName = 'degrees';

const
  DegreeUnit : TFactoredUnit = (
    FID         : ScalarID;
    FSymbol     : rsDegreeSymbol;
    FName       : rsDegreeName;
    FPluralName : rsDegreePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (Pi/180));

var
  deg : TFactoredUnit absolute DegreeUnit;

{ TSteradian }

resourcestring
  rsSteradianSymbol = 'sr';
  rsSteradianName = 'steradian';
  rsSteradianPluralName = 'steradians';

const
  SteradianID = 37860;
  SteradianUnit : TUnit = (
    FID         : SteradianID;
    FSymbol     : rsSteradianSymbol;
    FName       : rsSteradianName;
    FPluralName : rsSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

var
  sr : TUnit absolute SteradianUnit;

{ TSecond }

resourcestring
  rsSecondSymbol = '%ss';
  rsSecondName = '%ssecond';
  rsSecondPluralName = '%sseconds';

const
  SecondID = 34860;
  SecondUnit : TUnit = (
    FID         : SecondID;
    FSymbol     : rsSecondSymbol;
    FName       : rsSecondName;
    FPluralName : rsSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  s : TUnit absolute SecondUnit;

const
  ds         : TQuantity = {$IFNDEF ADIMOFF} (FID: SecondID; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cs         : TQuantity = {$IFNDEF ADIMOFF} (FID: SecondID; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  ms         : TQuantity = {$IFNDEF ADIMOFF} (FID: SecondID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  mis        : TQuantity = {$IFNDEF ADIMOFF} (FID: SecondID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  ns         : TQuantity = {$IFNDEF ADIMOFF} (FID: SecondID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  ps         : TQuantity = {$IFNDEF ADIMOFF} (FID: SecondID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TDay }

resourcestring
  rsDaySymbol = 'd';
  rsDayName = 'day';
  rsDayPluralName = 'days';

const
  DayUnit : TFactoredUnit = (
    FID         : SecondID;
    FSymbol     : rsDaySymbol;
    FName       : rsDayName;
    FPluralName : rsDayPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (86400));

var
  day : TFactoredUnit absolute DayUnit;

{ THour }

resourcestring
  rsHourSymbol = 'h';
  rsHourName = 'hour';
  rsHourPluralName = 'hours';

const
  HourUnit : TFactoredUnit = (
    FID         : SecondID;
    FSymbol     : rsHourSymbol;
    FName       : rsHourName;
    FPluralName : rsHourPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (3600));

var
  hr : TFactoredUnit absolute HourUnit;

{ TMinute }

resourcestring
  rsMinuteSymbol = 'min';
  rsMinuteName = 'minute';
  rsMinutePluralName = 'minutes';

const
  MinuteUnit : TFactoredUnit = (
    FID         : SecondID;
    FSymbol     : rsMinuteSymbol;
    FName       : rsMinuteName;
    FPluralName : rsMinutePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (60));

var
  minute : TFactoredUnit absolute MinuteUnit;

{ TSquareSecond }

resourcestring
  rsSquareSecondSymbol = '%ss²';
  rsSquareSecondName = 'square %ssecond';
  rsSquareSecondPluralName = 'square %sseconds';

const
  SquareSecondID = 69720;
  SquareSecondUnit : TUnit = (
    FID         : SquareSecondID;
    FSymbol     : rsSquareSecondSymbol;
    FName       : rsSquareSecondName;
    FPluralName : rsSquareSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  s2 : TUnit absolute SquareSecondUnit;

const
  ds2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareSecondID; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cs2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareSecondID; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  ms2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareSecondID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mis2       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareSecondID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  ns2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareSecondID; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ps2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareSecondID; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareDay }

resourcestring
  rsSquareDaySymbol = 'd²';
  rsSquareDayName = 'square day';
  rsSquareDayPluralName = 'square days';

const
  SquareDayUnit : TFactoredUnit = (
    FID         : SquareSecondID;
    FSymbol     : rsSquareDaySymbol;
    FName       : rsSquareDayName;
    FPluralName : rsSquareDayPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (7464960000));

var
  day2 : TFactoredUnit absolute SquareDayUnit;

{ TSquareHour }

resourcestring
  rsSquareHourSymbol = 'h²';
  rsSquareHourName = 'square hour';
  rsSquareHourPluralName = 'square hours';

const
  SquareHourUnit : TFactoredUnit = (
    FID         : SquareSecondID;
    FSymbol     : rsSquareHourSymbol;
    FName       : rsSquareHourName;
    FPluralName : rsSquareHourPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (12960000));

var
  hr2 : TFactoredUnit absolute SquareHourUnit;

{ TSquareMinute }

resourcestring
  rsSquareMinuteSymbol = 'min²';
  rsSquareMinuteName = 'square minute';
  rsSquareMinutePluralName = 'square minutes';

const
  SquareMinuteUnit : TFactoredUnit = (
    FID         : SquareSecondID;
    FSymbol     : rsSquareMinuteSymbol;
    FName       : rsSquareMinuteName;
    FPluralName : rsSquareMinutePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (3600));

var
  minute2 : TFactoredUnit absolute SquareMinuteUnit;

{ TCubicSecond }

resourcestring
  rsCubicSecondSymbol = '%ss³';
  rsCubicSecondName = 'cubic %ssecond';
  rsCubicSecondPluralName = 'cubic %sseconds';

const
  CubicSecondID = 104580;
  CubicSecondUnit : TUnit = (
    FID         : CubicSecondID;
    FSymbol     : rsCubicSecondSymbol;
    FName       : rsCubicSecondName;
    FPluralName : rsCubicSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

var
  s3 : TUnit absolute CubicSecondUnit;

const
  ds3        : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicSecondID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  cs3        : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicSecondID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  ms3        : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicSecondID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  mis3       : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicSecondID; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ns3        : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicSecondID; FValue: 1E-27); {$ELSE} (1E-27); {$ENDIF}
  ps3        : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicSecondID; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}

{ TQuarticSecond }

resourcestring
  rsQuarticSecondSymbol = '%ss⁴';
  rsQuarticSecondName = 'quartic %ssecond';
  rsQuarticSecondPluralName = 'quartic %sseconds';

const
  QuarticSecondID = 139440;
  QuarticSecondUnit : TUnit = (
    FID         : QuarticSecondID;
    FSymbol     : rsQuarticSecondSymbol;
    FName       : rsQuarticSecondName;
    FPluralName : rsQuarticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (4));

var
  s4 : TUnit absolute QuarticSecondUnit;

const
  ds4        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuarticSecondID; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cs4        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuarticSecondID; FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  ms4        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuarticSecondID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mis4       : TQuantity = {$IFNDEF ADIMOFF} (FID: QuarticSecondID; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  ns4        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuarticSecondID; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  ps4        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuarticSecondID; FValue: 1E-48); {$ELSE} (1E-48); {$ENDIF}

{ TQuinticSecond }

resourcestring
  rsQuinticSecondSymbol = '%ss⁵';
  rsQuinticSecondName = 'quintic %ssecond';
  rsQuinticSecondPluralName = 'quintic %sseconds';

const
  QuinticSecondID = 174300;
  QuinticSecondUnit : TUnit = (
    FID         : QuinticSecondID;
    FSymbol     : rsQuinticSecondSymbol;
    FName       : rsQuinticSecondName;
    FPluralName : rsQuinticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

var
  s5 : TUnit absolute QuinticSecondUnit;

const
  ds5        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuinticSecondID; FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  cs5        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuinticSecondID; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  ms5        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuinticSecondID; FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}
  mis5       : TQuantity = {$IFNDEF ADIMOFF} (FID: QuinticSecondID; FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}
  ns5        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuinticSecondID; FValue: 1E-45); {$ELSE} (1E-45); {$ENDIF}
  ps5        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuinticSecondID; FValue: 1E-60); {$ELSE} (1E-60); {$ENDIF}

{ TSexticSecond }

resourcestring
  rsSexticSecondSymbol = '%ss⁶';
  rsSexticSecondName = 'sextic %ssecond';
  rsSexticSecondPluralName = 'sextic %sseconds';

const
  SexticSecondID = 209160;
  SexticSecondUnit : TUnit = (
    FID         : SexticSecondID;
    FSymbol     : rsSexticSecondSymbol;
    FName       : rsSexticSecondName;
    FPluralName : rsSexticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (6));

var
  s6 : TUnit absolute SexticSecondUnit;

const
  ds6        : TQuantity = {$IFNDEF ADIMOFF} (FID: SexticSecondID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  cs6        : TQuantity = {$IFNDEF ADIMOFF} (FID: SexticSecondID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  ms6        : TQuantity = {$IFNDEF ADIMOFF} (FID: SexticSecondID; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  mis6       : TQuantity = {$IFNDEF ADIMOFF} (FID: SexticSecondID; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  ns6        : TQuantity = {$IFNDEF ADIMOFF} (FID: SexticSecondID; FValue: 1E-54); {$ELSE} (1E-54); {$ENDIF}
  ps6        : TQuantity = {$IFNDEF ADIMOFF} (FID: SexticSecondID; FValue: 1E-72); {$ELSE} (1E-72); {$ENDIF}

{ TMeter }

resourcestring
  rsMeterSymbol = '%sm';
  rsMeterName = '%smeter';
  rsMeterPluralName = '%smeters';

const
  MeterID = 39780;
  MeterUnit : TUnit = (
    FID         : MeterID;
    FSymbol     : rsMeterSymbol;
    FName       : rsMeterName;
    FPluralName : rsMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  m : TUnit absolute MeterUnit;

const
  km         : TQuantity = {$IFNDEF ADIMOFF} (FID: MeterID; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  dm         : TQuantity = {$IFNDEF ADIMOFF} (FID: MeterID; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cm         : TQuantity = {$IFNDEF ADIMOFF} (FID: MeterID; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mm         : TQuantity = {$IFNDEF ADIMOFF} (FID: MeterID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  mim        : TQuantity = {$IFNDEF ADIMOFF} (FID: MeterID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nm         : TQuantity = {$IFNDEF ADIMOFF} (FID: MeterID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pm         : TQuantity = {$IFNDEF ADIMOFF} (FID: MeterID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TAstronomical }

resourcestring
  rsAstronomicalSymbol = 'au';
  rsAstronomicalName = 'astronomical unit';
  rsAstronomicalPluralName = 'astronomical units';

const
  AstronomicalUnit : TFactoredUnit = (
    FID         : MeterID;
    FSymbol     : rsAstronomicalSymbol;
    FName       : rsAstronomicalName;
    FPluralName : rsAstronomicalPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (149597870691));

var
  au : TFactoredUnit absolute AstronomicalUnit;

{ TInch }

resourcestring
  rsInchSymbol = 'in';
  rsInchName = 'inch';
  rsInchPluralName = 'inches';

const
  InchUnit : TFactoredUnit = (
    FID         : MeterID;
    FSymbol     : rsInchSymbol;
    FName       : rsInchName;
    FPluralName : rsInchPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.0254));

var
  inch : TFactoredUnit absolute InchUnit;

{ TFoot }

resourcestring
  rsFootSymbol = 'ft';
  rsFootName = 'foot';
  rsFootPluralName = 'feet';

const
  FootUnit : TFactoredUnit = (
    FID         : MeterID;
    FSymbol     : rsFootSymbol;
    FName       : rsFootName;
    FPluralName : rsFootPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.3048));

var
  ft : TFactoredUnit absolute FootUnit;

{ TYard }

resourcestring
  rsYardSymbol = 'yd';
  rsYardName = 'yard';
  rsYardPluralName = 'yards';

const
  YardUnit : TFactoredUnit = (
    FID         : MeterID;
    FSymbol     : rsYardSymbol;
    FName       : rsYardName;
    FPluralName : rsYardPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.9144));

var
  yd : TFactoredUnit absolute YardUnit;

{ TMile }

resourcestring
  rsMileSymbol = 'mi';
  rsMileName = 'mile';
  rsMilePluralName = 'miles';

const
  MileUnit : TFactoredUnit = (
    FID         : MeterID;
    FSymbol     : rsMileSymbol;
    FName       : rsMileName;
    FPluralName : rsMilePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (1609.344));

var
  mi : TFactoredUnit absolute MileUnit;

{ TNauticalMile }

resourcestring
  rsNauticalMileSymbol = 'nmi';
  rsNauticalMileName = 'nautical mile';
  rsNauticalMilePluralName = 'nautical miles';

const
  NauticalMileUnit : TFactoredUnit = (
    FID         : MeterID;
    FSymbol     : rsNauticalMileSymbol;
    FName       : rsNauticalMileName;
    FPluralName : rsNauticalMilePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (1852));

var
  nmi : TFactoredUnit absolute NauticalMileUnit;

{ TAngstrom }

resourcestring
  rsAngstromSymbol = '%sÅ';
  rsAngstromName = '%sangstrom';
  rsAngstromPluralName = '%sangstroms';

const
  AngstromUnit : TFactoredUnit = (
    FID         : MeterID;
    FSymbol     : rsAngstromSymbol;
    FName       : rsAngstromName;
    FPluralName : rsAngstromPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (1E-10));

var
  angstrom : TFactoredUnit absolute AngstromUnit;

{ TSquareRootMeter }

resourcestring
  rsSquareRootMeterSymbol = '√%sm';
  rsSquareRootMeterName = 'square root %smeter';
  rsSquareRootMeterPluralName = 'square root %smeters';

const
  SquareRootMeterID = 19890;
  SquareRootMeterUnit : TUnit = (
    FID         : SquareRootMeterID;
    FSymbol     : rsSquareRootMeterSymbol;
    FName       : rsSquareRootMeterName;
    FPluralName : rsSquareRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareMeter }

resourcestring
  rsSquareMeterSymbol = '%sm²';
  rsSquareMeterName = 'square %smeter';
  rsSquareMeterPluralName = 'square %smeters';

const
  SquareMeterID = 79560;
  SquareMeterUnit : TUnit = (
    FID         : SquareMeterID;
    FSymbol     : rsSquareMeterSymbol;
    FName       : rsSquareMeterName;
    FPluralName : rsSquareMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  m2 : TUnit absolute SquareMeterUnit;

const
  km2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterID; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  dm2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterID; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cm2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterID; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mm2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mim2       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nm2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterID; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  pm2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterID; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareInch }

resourcestring
  rsSquareInchSymbol = 'in²';
  rsSquareInchName = 'square inch';
  rsSquareInchPluralName = 'square inches';

const
  SquareInchUnit : TFactoredUnit = (
    FID         : SquareMeterID;
    FSymbol     : rsSquareInchSymbol;
    FName       : rsSquareInchName;
    FPluralName : rsSquareInchPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.00064516));

var
  inch2 : TFactoredUnit absolute SquareInchUnit;

{ TSquareFoot }

resourcestring
  rsSquareFootSymbol = 'ft²';
  rsSquareFootName = 'square foot';
  rsSquareFootPluralName = 'square feet';

const
  SquareFootUnit : TFactoredUnit = (
    FID         : SquareMeterID;
    FSymbol     : rsSquareFootSymbol;
    FName       : rsSquareFootName;
    FPluralName : rsSquareFootPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.09290304));

var
  ft2 : TFactoredUnit absolute SquareFootUnit;

{ TSquareYard }

resourcestring
  rsSquareYardSymbol = 'yd²';
  rsSquareYardName = 'square yard';
  rsSquareYardPluralName = 'square yards';

const
  SquareYardUnit : TFactoredUnit = (
    FID         : SquareMeterID;
    FSymbol     : rsSquareYardSymbol;
    FName       : rsSquareYardName;
    FPluralName : rsSquareYardPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.83612736));

var
  yd2 : TFactoredUnit absolute SquareYardUnit;

{ TSquareMile }

resourcestring
  rsSquareMileSymbol = 'mi²';
  rsSquareMileName = 'square mile';
  rsSquareMilePluralName = 'square miles';

const
  SquareMileUnit : TFactoredUnit = (
    FID         : SquareMeterID;
    FSymbol     : rsSquareMileSymbol;
    FName       : rsSquareMileName;
    FPluralName : rsSquareMilePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (2589988.110336));

var
  mi2 : TFactoredUnit absolute SquareMileUnit;

{ TCubicMeter }

resourcestring
  rsCubicMeterSymbol = '%sm³';
  rsCubicMeterName = 'cubic %smeter';
  rsCubicMeterPluralName = 'cubic %smeters';

const
  CubicMeterID = 119340;
  CubicMeterUnit : TUnit = (
    FID         : CubicMeterID;
    FSymbol     : rsCubicMeterSymbol;
    FName       : rsCubicMeterName;
    FPluralName : rsCubicMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

var
  m3 : TUnit absolute CubicMeterUnit;

const
  km3        : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicMeterID; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  dm3        : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicMeterID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  cm3        : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicMeterID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mm3        : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicMeterID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  mim3       : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicMeterID; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  nm3        : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicMeterID; FValue: 1E-27); {$ELSE} (1E-27); {$ENDIF}
  pm3        : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicMeterID; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}

{ TCubicInch }

resourcestring
  rsCubicInchSymbol = 'in³';
  rsCubicInchName = 'cubic inch';
  rsCubicInchPluralName = 'cubic inches';

const
  CubicInchUnit : TFactoredUnit = (
    FID         : CubicMeterID;
    FSymbol     : rsCubicInchSymbol;
    FName       : rsCubicInchName;
    FPluralName : rsCubicInchPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.000016387064));

var
  inch3 : TFactoredUnit absolute CubicInchUnit;

{ TCubicFoot }

resourcestring
  rsCubicFootSymbol = 'ft³';
  rsCubicFootName = 'cubic foot';
  rsCubicFootPluralName = 'cubic feet';

const
  CubicFootUnit : TFactoredUnit = (
    FID         : CubicMeterID;
    FSymbol     : rsCubicFootSymbol;
    FName       : rsCubicFootName;
    FPluralName : rsCubicFootPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.028316846592));

var
  ft3 : TFactoredUnit absolute CubicFootUnit;

{ TCubicYard }

resourcestring
  rsCubicYardSymbol = 'yd³';
  rsCubicYardName = 'cubic yard';
  rsCubicYardPluralName = 'cubic yards';

const
  CubicYardUnit : TFactoredUnit = (
    FID         : CubicMeterID;
    FSymbol     : rsCubicYardSymbol;
    FName       : rsCubicYardName;
    FPluralName : rsCubicYardPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.764554857984));

var
  yd3 : TFactoredUnit absolute CubicYardUnit;

{ TLitre }

resourcestring
  rsLitreSymbol = '%sL';
  rsLitreName = '%slitre';
  rsLitrePluralName = '%slitres';

const
  LitreUnit : TFactoredUnit = (
    FID         : CubicMeterID;
    FSymbol     : rsLitreSymbol;
    FName       : rsLitreName;
    FPluralName : rsLitrePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (1E-03));

var
  L : TFactoredUnit absolute LitreUnit;

const
  dL         : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicMeterID; FValue: 1E-03 * 1E-01); {$ELSE} (1E-03 * 1E-01); {$ENDIF}
  cL         : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicMeterID; FValue: 1E-03 * 1E-02); {$ELSE} (1E-03 * 1E-02); {$ENDIF}
  mL         : TQuantity = {$IFNDEF ADIMOFF} (FID: CubicMeterID; FValue: 1E-03 * 1E-03); {$ELSE} (1E-03 * 1E-03); {$ENDIF}

{ TGallon }

resourcestring
  rsGallonSymbol = 'gal';
  rsGallonName = 'gallon';
  rsGallonPluralName = 'gallons';

const
  GallonUnit : TFactoredUnit = (
    FID         : CubicMeterID;
    FSymbol     : rsGallonSymbol;
    FName       : rsGallonName;
    FPluralName : rsGallonPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.0037854119678));

var
  gal : TFactoredUnit absolute GallonUnit;

{ TQuarticMeter }

resourcestring
  rsQuarticMeterSymbol = '%sm⁴';
  rsQuarticMeterName = 'quartic %smeter';
  rsQuarticMeterPluralName = 'quartic %smeters';

const
  QuarticMeterID = 159120;
  QuarticMeterUnit : TUnit = (
    FID         : QuarticMeterID;
    FSymbol     : rsQuarticMeterSymbol;
    FName       : rsQuarticMeterName;
    FPluralName : rsQuarticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (4));

var
  m4 : TUnit absolute QuarticMeterUnit;

const
  km4        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuarticMeterID; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  dm4        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuarticMeterID; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cm4        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuarticMeterID; FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  mm4        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuarticMeterID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mim4       : TQuantity = {$IFNDEF ADIMOFF} (FID: QuarticMeterID; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  nm4        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuarticMeterID; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  pm4        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuarticMeterID; FValue: 1E-48); {$ELSE} (1E-48); {$ENDIF}

{ TQuinticMeter }

resourcestring
  rsQuinticMeterSymbol = '%sm⁵';
  rsQuinticMeterName = 'quintic %smeter';
  rsQuinticMeterPluralName = 'quintic %smeters';

const
  QuinticMeterID = 198900;
  QuinticMeterUnit : TUnit = (
    FID         : QuinticMeterID;
    FSymbol     : rsQuinticMeterSymbol;
    FName       : rsQuinticMeterName;
    FPluralName : rsQuinticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

var
  m5 : TUnit absolute QuinticMeterUnit;

const
  km5        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuinticMeterID; FValue: 1E+15); {$ELSE} (1E+15); {$ENDIF}
  dm5        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuinticMeterID; FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  cm5        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuinticMeterID; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  mm5        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuinticMeterID; FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}
  mim5       : TQuantity = {$IFNDEF ADIMOFF} (FID: QuinticMeterID; FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}
  nm5        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuinticMeterID; FValue: 1E-45); {$ELSE} (1E-45); {$ENDIF}
  pm5        : TQuantity = {$IFNDEF ADIMOFF} (FID: QuinticMeterID; FValue: 1E-60); {$ELSE} (1E-60); {$ENDIF}

{ TSexticMeter }

resourcestring
  rsSexticMeterSymbol = '%sm⁶';
  rsSexticMeterName = 'sextic %smeter';
  rsSexticMeterPluralName = 'sextic %smeters';

const
  SexticMeterID = 238680;
  SexticMeterUnit : TUnit = (
    FID         : SexticMeterID;
    FSymbol     : rsSexticMeterSymbol;
    FName       : rsSexticMeterName;
    FPluralName : rsSexticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (6));

var
  m6 : TUnit absolute SexticMeterUnit;

const
  km6        : TQuantity = {$IFNDEF ADIMOFF} (FID: SexticMeterID; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  dm6        : TQuantity = {$IFNDEF ADIMOFF} (FID: SexticMeterID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  cm6        : TQuantity = {$IFNDEF ADIMOFF} (FID: SexticMeterID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mm6        : TQuantity = {$IFNDEF ADIMOFF} (FID: SexticMeterID; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  mim6       : TQuantity = {$IFNDEF ADIMOFF} (FID: SexticMeterID; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  nm6        : TQuantity = {$IFNDEF ADIMOFF} (FID: SexticMeterID; FValue: 1E-54); {$ELSE} (1E-54); {$ENDIF}
  pm6        : TQuantity = {$IFNDEF ADIMOFF} (FID: SexticMeterID; FValue: 1E-72); {$ELSE} (1E-72); {$ENDIF}

{ TKilogram }

resourcestring
  rsKilogramSymbol = '%sg';
  rsKilogramName = '%sgram';
  rsKilogramPluralName = '%sgrams';

const
  KilogramID = 9060;
  KilogramUnit : TUnit = (
    FID         : KilogramID;
    FSymbol     : rsKilogramSymbol;
    FName       : rsKilogramName;
    FPluralName : rsKilogramPluralName;
    FPrefixes   : (pKilo);
    FExponents  : (1));

var
  kg : TUnit absolute KilogramUnit;

const
  hg         : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramID; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  dag        : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramID; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  g          : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  dg         : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramID; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cg         : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramID; FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  mg         : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mig        : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  ng         : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  pg         : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramID; FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}

{ TTonne }

resourcestring
  rsTonneSymbol = '%st';
  rsTonneName = '%stonne';
  rsTonnePluralName = '%stonnes';

const
  TonneUnit : TFactoredUnit = (
    FID         : KilogramID;
    FSymbol     : rsTonneSymbol;
    FName       : rsTonneName;
    FPluralName : rsTonnePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (1E+03));

var
  tonne : TFactoredUnit absolute TonneUnit;

const
  gigatonne  : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramID; FValue: 1E+03 * 1E+09); {$ELSE} (1E+03 * 1E+09); {$ENDIF}
  megatonne  : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramID; FValue: 1E+03 * 1E+06); {$ELSE} (1E+03 * 1E+06); {$ENDIF}
  kilotonne  : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramID; FValue: 1E+03 * 1E+03); {$ELSE} (1E+03 * 1E+03); {$ENDIF}

{ TPound }

resourcestring
  rsPoundSymbol = 'lb';
  rsPoundName = 'pound';
  rsPoundPluralName = 'pounds';

const
  PoundUnit : TFactoredUnit = (
    FID         : KilogramID;
    FSymbol     : rsPoundSymbol;
    FName       : rsPoundName;
    FPluralName : rsPoundPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.45359237));

var
  lb : TFactoredUnit absolute PoundUnit;

{ TOunce }

resourcestring
  rsOunceSymbol = 'oz';
  rsOunceName = 'ounce';
  rsOuncePluralName = 'ounces';

const
  OunceUnit : TFactoredUnit = (
    FID         : KilogramID;
    FSymbol     : rsOunceSymbol;
    FName       : rsOunceName;
    FPluralName : rsOuncePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.028349523125));

var
  oz : TFactoredUnit absolute OunceUnit;

{ TStone }

resourcestring
  rsStoneSymbol = 'st';
  rsStoneName = 'stone';
  rsStonePluralName = 'stones';

const
  StoneUnit : TFactoredUnit = (
    FID         : KilogramID;
    FSymbol     : rsStoneSymbol;
    FName       : rsStoneName;
    FPluralName : rsStonePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (6.35029318));

var
  st : TFactoredUnit absolute StoneUnit;

{ TTon }

resourcestring
  rsTonSymbol = 'ton';
  rsTonName = 'ton';
  rsTonPluralName = 'tons';

const
  TonUnit : TFactoredUnit = (
    FID         : KilogramID;
    FSymbol     : rsTonSymbol;
    FName       : rsTonName;
    FPluralName : rsTonPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (907.18474));

var
  ton : TFactoredUnit absolute TonUnit;

{ TElectronvoltPerSquareSpeedOfLight }

resourcestring
  rsElectronvoltPerSquareSpeedOfLightSymbol = '%seV/c²';
  rsElectronvoltPerSquareSpeedOfLightName = '%selectronvolt per squared speed of light';
  rsElectronvoltPerSquareSpeedOfLightPluralName = '%selectronvolts per squared speed of light';

const
  ElectronvoltPerSquareSpeedOfLightUnit : TFactoredUnit = (
    FID         : KilogramID;
    FSymbol     : rsElectronvoltPerSquareSpeedOfLightSymbol;
    FName       : rsElectronvoltPerSquareSpeedOfLightName;
    FPluralName : rsElectronvoltPerSquareSpeedOfLightPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (1.7826619216279E-36));

{ TSquareKilogram }

resourcestring
  rsSquareKilogramSymbol = '%sg²';
  rsSquareKilogramName = 'square %sgram';
  rsSquareKilogramPluralName = 'square %sgrams';

const
  SquareKilogramID = 18120;
  SquareKilogramUnit : TUnit = (
    FID         : SquareKilogramID;
    FSymbol     : rsSquareKilogramSymbol;
    FName       : rsSquareKilogramName;
    FPluralName : rsSquareKilogramPluralName;
    FPrefixes   : (pKilo);
    FExponents  : (2));

var
  kg2 : TUnit absolute SquareKilogramUnit;

const
  hg2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareKilogramID; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  dag2       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareKilogramID; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  g2         : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareKilogramID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  dg2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareKilogramID; FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  cg2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareKilogramID; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  mg2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareKilogramID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mig2       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareKilogramID; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ng2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareKilogramID; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  pg2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareKilogramID; FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}

{ TAmpere }

resourcestring
  rsAmpereSymbol = '%sA';
  rsAmpereName = '%sampere';
  rsAmperePluralName = '%samperes';

const
  AmpereID = 24300;
  AmpereUnit : TUnit = (
    FID         : AmpereID;
    FSymbol     : rsAmpereSymbol;
    FName       : rsAmpereName;
    FPluralName : rsAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  A : TUnit absolute AmpereUnit;

const
  kA         : TQuantity = {$IFNDEF ADIMOFF} (FID: AmpereID; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hA         : TQuantity = {$IFNDEF ADIMOFF} (FID: AmpereID; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daA        : TQuantity = {$IFNDEF ADIMOFF} (FID: AmpereID; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}
  dA         : TQuantity = {$IFNDEF ADIMOFF} (FID: AmpereID; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cA         : TQuantity = {$IFNDEF ADIMOFF} (FID: AmpereID; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mA         : TQuantity = {$IFNDEF ADIMOFF} (FID: AmpereID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miA        : TQuantity = {$IFNDEF ADIMOFF} (FID: AmpereID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nA         : TQuantity = {$IFNDEF ADIMOFF} (FID: AmpereID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  picoA      : TQuantity = {$IFNDEF ADIMOFF} (FID: AmpereID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TSquareAmpere }

resourcestring
  rsSquareAmpereSymbol = '%sA²';
  rsSquareAmpereName = 'square %sampere';
  rsSquareAmperePluralName = 'square %samperes';

const
  SquareAmpereID = 48600;
  SquareAmpereUnit : TUnit = (
    FID         : SquareAmpereID;
    FSymbol     : rsSquareAmpereSymbol;
    FName       : rsSquareAmpereName;
    FPluralName : rsSquareAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  A2 : TUnit absolute SquareAmpereUnit;

const
  kA2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareAmpereID; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hA2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareAmpereID; FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daA2       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareAmpereID; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  dA2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareAmpereID; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cA2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareAmpereID; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mA2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareAmpereID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  miA2       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareAmpereID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nA2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareAmpereID; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  picoA2     : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareAmpereID; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TKelvin }

resourcestring
  rsKelvinSymbol = '%sK';
  rsKelvinName = '%skelvin';
  rsKelvinPluralName = '%skelvins';

const
  KelvinID = 19020;
  KelvinUnit : TUnit = (
    FID         : KelvinID;
    FSymbol     : rsKelvinSymbol;
    FName       : rsKelvinName;
    FPluralName : rsKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  K : TUnit absolute KelvinUnit;

{ TDegreeCelsius }

resourcestring
  rsDegreeCelsiusSymbol = '°C';
  rsDegreeCelsiusName = 'degree Celsius';
  rsDegreeCelsiusPluralName = 'degrees Celsius';

const
  DegreeCelsiusUnit : TDegreeCelsiusUnit = (
    FID         : KelvinID;
    FSymbol     : rsDegreeCelsiusSymbol;
    FName       : rsDegreeCelsiusName;
    FPluralName : rsDegreeCelsiusPluralName;
    FPrefixes   : ();
    FExponents  : ());

var
  degC : TDegreeCelsiusUnit absolute DegreeCelsiusUnit;

{ TDegreeFahrenheit }

resourcestring
  rsDegreeFahrenheitSymbol = '°F';
  rsDegreeFahrenheitName = 'degree Fahrenheit';
  rsDegreeFahrenheitPluralName = 'degrees Fahrenheit';

const
  DegreeFahrenheitUnit : TDegreeFahrenheitUnit = (
    FID : KelvinID;
    FSymbol            : rsDegreeFahrenheitSymbol;
    FName              : rsDegreeFahrenheitName;
    FPluralName        : rsDegreeFahrenheitPluralName;
    FPrefixes          : ();
    FExponents         : ());

var
  degF : TDegreeFahrenheitUnit absolute DegreeFahrenheitUnit;

{ TSquareKelvin }

resourcestring
  rsSquareKelvinSymbol = '%sK²';
  rsSquareKelvinName = 'square %skelvin';
  rsSquareKelvinPluralName = 'square %skelvins';

const
  SquareKelvinID = 38040;
  SquareKelvinUnit : TUnit = (
    FID         : SquareKelvinID;
    FSymbol     : rsSquareKelvinSymbol;
    FName       : rsSquareKelvinName;
    FPluralName : rsSquareKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  K2 : TUnit absolute SquareKelvinUnit;

{ TCubicKelvin }

resourcestring
  rsCubicKelvinSymbol = '%sK³';
  rsCubicKelvinName = 'cubic %skelvin';
  rsCubicKelvinPluralName = 'cubic %skelvins';

const
  CubicKelvinID = 57060;
  CubicKelvinUnit : TUnit = (
    FID         : CubicKelvinID;
    FSymbol     : rsCubicKelvinSymbol;
    FName       : rsCubicKelvinName;
    FPluralName : rsCubicKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

var
  K3 : TUnit absolute CubicKelvinUnit;

{ TQuarticKelvin }

resourcestring
  rsQuarticKelvinSymbol = '%sK⁴';
  rsQuarticKelvinName = 'quartic %skelvin';
  rsQuarticKelvinPluralName = 'quartic %skelvins';

const
  QuarticKelvinID = 76080;
  QuarticKelvinUnit : TUnit = (
    FID         : QuarticKelvinID;
    FSymbol     : rsQuarticKelvinSymbol;
    FName       : rsQuarticKelvinName;
    FPluralName : rsQuarticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (4));

var
  K4 : TUnit absolute QuarticKelvinUnit;

{ TMole }

resourcestring
  rsMoleSymbol = '%smol';
  rsMoleName = '%smole';
  rsMolePluralName = '%smoles';

const
  MoleID = 34680;
  MoleUnit : TUnit = (
    FID         : MoleID;
    FSymbol     : rsMoleSymbol;
    FName       : rsMoleName;
    FPluralName : rsMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  mol : TUnit absolute MoleUnit;

const
  kmol       : TQuantity = {$IFNDEF ADIMOFF} (FID: MoleID; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hmol       : TQuantity = {$IFNDEF ADIMOFF} (FID: MoleID; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  damol      : TQuantity = {$IFNDEF ADIMOFF} (FID: MoleID; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}

{ TCandela }

resourcestring
  rsCandelaSymbol = '%scd';
  rsCandelaName = '%scandela';
  rsCandelaPluralName = '%scandelas';

const
  CandelaID = 39960;
  CandelaUnit : TUnit = (
    FID         : CandelaID;
    FSymbol     : rsCandelaSymbol;
    FName       : rsCandelaName;
    FPluralName : rsCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  cd : TUnit absolute CandelaUnit;

{ THertz }

resourcestring
  rsHertzSymbol = '%sHz';
  rsHertzName = '%shertz';
  rsHertzPluralName = '%shertz';

const
  HertzID = -34860;
  HertzUnit : TUnit = (
    FID         : HertzID;
    FSymbol     : rsHertzSymbol;
    FName       : rsHertzName;
    FPluralName : rsHertzPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  Hz : TUnit absolute HertzUnit;

const
  THz        : TQuantity = {$IFNDEF ADIMOFF} (FID: HertzID; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GHz        : TQuantity = {$IFNDEF ADIMOFF} (FID: HertzID; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MHz        : TQuantity = {$IFNDEF ADIMOFF} (FID: HertzID; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kHz        : TQuantity = {$IFNDEF ADIMOFF} (FID: HertzID; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TReciprocalSecond }

resourcestring
  rsReciprocalSecondSymbol = '1/%ss';
  rsReciprocalSecondName = 'reciprocal %ssecond';
  rsReciprocalSecondPluralName = 'reciprocal %sseconds';

const
  ReciprocalSecondUnit : TUnit = (
    FID         : HertzID;
    FSymbol     : rsReciprocalSecondSymbol;
    FName       : rsReciprocalSecondName;
    FPluralName : rsReciprocalSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TRadianPerSecond }

resourcestring
  rsRadianPerSecondSymbol = 'rad/%ss';
  rsRadianPerSecondName = 'radian per %ssecond';
  rsRadianPerSecondPluralName = 'radians per %ssecond';

const
  RadianPerSecondUnit : TUnit = (
    FID         : HertzID;
    FSymbol     : rsRadianPerSecondSymbol;
    FName       : rsRadianPerSecondName;
    FPluralName : rsRadianPerSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TSquareHertz }

resourcestring
  rsSquareHertzSymbol = '%sHz²';
  rsSquareHertzName = 'square %shertz';
  rsSquareHertzPluralName = 'square %shertz';

const
  SquareHertzID = -69720;
  SquareHertzUnit : TUnit = (
    FID         : SquareHertzID;
    FSymbol     : rsSquareHertzSymbol;
    FName       : rsSquareHertzName;
    FPluralName : rsSquareHertzPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  Hz2 : TUnit absolute SquareHertzUnit;

const
  THz2       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareHertzID; FValue: 1E+24); {$ELSE} (1E+24); {$ENDIF}
  GHz2       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareHertzID; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MHz2       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareHertzID; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kHz2       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareHertzID; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}

{ TReciprocalSquareSecond }

resourcestring
  rsReciprocalSquareSecondSymbol = '1/%ss²';
  rsReciprocalSquareSecondName = 'reciprocal square %ssecond';
  rsReciprocalSquareSecondPluralName = 'reciprocal square %sseconds';

const
  ReciprocalSquareSecondUnit : TUnit = (
    FID         : SquareHertzID;
    FSymbol     : rsReciprocalSquareSecondSymbol;
    FName       : rsReciprocalSquareSecondName;
    FPluralName : rsReciprocalSquareSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TRadianPerSquareSecond }

resourcestring
  rsRadianPerSquareSecondSymbol = 'rad/%ss²';
  rsRadianPerSquareSecondName = 'radian per square %ssecond';
  rsRadianPerSquareSecondPluralName = 'radians per square %ssecond';

const
  RadianPerSquareSecondUnit : TUnit = (
    FID         : SquareHertzID;
    FSymbol     : rsRadianPerSquareSecondSymbol;
    FName       : rsRadianPerSquareSecondName;
    FPluralName : rsRadianPerSquareSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TSteradianPerSquareSecond }

resourcestring
  rsSteradianPerSquareSecondSymbol = 'sr/%ss²';
  rsSteradianPerSquareSecondName = 'steradian per square %ssecond';
  rsSteradianPerSquareSecondPluralName = 'steradians per square %ssecond';

const
  SteradianPerSquareSecondID = -31860;
  SteradianPerSquareSecondUnit : TUnit = (
    FID         : SteradianPerSquareSecondID;
    FSymbol     : rsSteradianPerSquareSecondSymbol;
    FName       : rsSteradianPerSquareSecondName;
    FPluralName : rsSteradianPerSquareSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TMeterPerSecond, unit of measurement for speed. }

resourcestring
  rsMeterPerSecondSymbol = '%sm/%ss';
  rsMeterPerSecondName = '%smeter per %ssecond';
  rsMeterPerSecondPluralName = '%smeters per %ssecond';

const
  MeterPerSecondID = 4920;
  MeterPerSecondUnit : TUnit = (
    FID         : MeterPerSecondID;
    FSymbol     : rsMeterPerSecondSymbol;
    FName       : rsMeterPerSecondName;
    FPluralName : rsMeterPerSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TMeterPerHour }

resourcestring
  rsMeterPerHourSymbol = '%sm/h';
  rsMeterPerHourName = '%smeter per hour';
  rsMeterPerHourPluralName = '%smeters per hour';

const
  MeterPerHourUnit : TFactoredUnit = (
    FID         : MeterPerSecondID;
    FSymbol     : rsMeterPerHourSymbol;
    FName       : rsMeterPerHourName;
    FPluralName : rsMeterPerHourPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (1/3600));

{ TMilePerHour }

resourcestring
  rsMilePerHourSymbol = 'mi/h';
  rsMilePerHourName = 'mile per hour';
  rsMilePerHourPluralName = 'miles per hour';

const
  MilePerHourUnit : TFactoredUnit = (
    FID         : MeterPerSecondID;
    FSymbol     : rsMilePerHourSymbol;
    FName       : rsMilePerHourName;
    FPluralName : rsMilePerHourPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.44704));

{ TNauticalMilePerHour }

resourcestring
  rsNauticalMilePerHourSymbol = 'nmi/h';
  rsNauticalMilePerHourName = 'nautical mile per hour';
  rsNauticalMilePerHourPluralName = 'nautical miles per hour';

const
  NauticalMilePerHourUnit : TFactoredUnit = (
    FID         : MeterPerSecondID;
    FSymbol     : rsNauticalMilePerHourSymbol;
    FName       : rsNauticalMilePerHourName;
    FPluralName : rsNauticalMilePerHourPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (463/900));

{ TMeterPerSquareSecond, unit of measurement for acceleration. }

resourcestring
  rsMeterPerSquareSecondSymbol = '%sm/%ss²';
  rsMeterPerSquareSecondName = '%smeter per %ssecond squared';
  rsMeterPerSquareSecondPluralName = '%smeters per %ssecond squared';

const
  MeterPerSquareSecondID = -29940;
  MeterPerSquareSecondUnit : TUnit = (
    FID         : MeterPerSquareSecondID;
    FSymbol     : rsMeterPerSquareSecondSymbol;
    FName       : rsMeterPerSquareSecondName;
    FPluralName : rsMeterPerSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TMeterPerSecondPerSecond }

resourcestring
  rsMeterPerSecondPerSecondSymbol = '%sm/%ss/%ss';
  rsMeterPerSecondPerSecondName = '%smeter per %ssecond per %ssecond';
  rsMeterPerSecondPerSecondPluralName = '%smeters per %ssecond per %ssecond';

const
  MeterPerSecondPerSecondUnit : TUnit = (
    FID         : MeterPerSquareSecondID;
    FSymbol     : rsMeterPerSecondPerSecondSymbol;
    FName       : rsMeterPerSecondPerSecondName;
    FPluralName : rsMeterPerSecondPerSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TMeterPerHourPerSecond }

resourcestring
  rsMeterPerHourPerSecondSymbol = '%sm/h/%ss';
  rsMeterPerHourPerSecondName = '%smeter per hour per %ssecond';
  rsMeterPerHourPerSecondPluralName = '%smeters per hour per %ssecond';

const
  MeterPerHourPerSecondUnit : TFactoredUnit = (
    FID         : MeterPerSquareSecondID;
    FSymbol     : rsMeterPerHourPerSecondSymbol;
    FName       : rsMeterPerHourPerSecondName;
    FPluralName : rsMeterPerHourPerSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1);
    FFactor     : (1/3600));

{ TMeterPerCubicSecond }

resourcestring
  rsMeterPerCubicSecondSymbol = '%sm/%ss³';
  rsMeterPerCubicSecondName = '%smeter per cubic %ssecond';
  rsMeterPerCubicSecondPluralName = '%smeters per cubic %ssecond';

const
  MeterPerCubicSecondID = -64800;
  MeterPerCubicSecondUnit : TUnit = (
    FID         : MeterPerCubicSecondID;
    FSymbol     : rsMeterPerCubicSecondSymbol;
    FName       : rsMeterPerCubicSecondName;
    FPluralName : rsMeterPerCubicSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TMeterPerQuarticSecond }

resourcestring
  rsMeterPerQuarticSecondSymbol = '%sm/%ss⁴';
  rsMeterPerQuarticSecondName = '%smeter per quartic %ssecond';
  rsMeterPerQuarticSecondPluralName = '%smeters per quartic %ssecond';

const
  MeterPerQuarticSecondID = -99660;
  MeterPerQuarticSecondUnit : TUnit = (
    FID         : MeterPerQuarticSecondID;
    FSymbol     : rsMeterPerQuarticSecondSymbol;
    FName       : rsMeterPerQuarticSecondName;
    FPluralName : rsMeterPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -4));

{ TMeterPerQuinticSecond }

resourcestring
  rsMeterPerQuinticSecondSymbol = '%sm/%ss⁵';
  rsMeterPerQuinticSecondName = '%smeter per quintic %ssecond';
  rsMeterPerQuinticSecondPluralName = '%smeters per quintic %ssecond';

const
  MeterPerQuinticSecondID = -134520;
  MeterPerQuinticSecondUnit : TUnit = (
    FID         : MeterPerQuinticSecondID;
    FSymbol     : rsMeterPerQuinticSecondSymbol;
    FName       : rsMeterPerQuinticSecondName;
    FPluralName : rsMeterPerQuinticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -5));

{ TMeterPerSexticSecond }

resourcestring
  rsMeterPerSexticSecondSymbol = '%sm/%ss⁶';
  rsMeterPerSexticSecondName = '%smeter per sextic %ssecond';
  rsMeterPerSexticSecondPluralName = '%smeters per sextic %ssecond';

const
  MeterPerSexticSecondID = -169380;
  MeterPerSexticSecondUnit : TUnit = (
    FID         : MeterPerSexticSecondID;
    FSymbol     : rsMeterPerSexticSecondSymbol;
    FName       : rsMeterPerSexticSecondName;
    FPluralName : rsMeterPerSexticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -6));

{ TSquareMeterPerSquareSecond }

resourcestring
  rsSquareMeterPerSquareSecondSymbol = '%sm²/%ss²';
  rsSquareMeterPerSquareSecondName = 'square %smeter per square %ssecond';
  rsSquareMeterPerSquareSecondPluralName = 'square %smeters per square %ssecond';

const
  SquareMeterPerSquareSecondID = 9840;
  SquareMeterPerSquareSecondUnit : TUnit = (
    FID         : SquareMeterPerSquareSecondID;
    FSymbol     : rsSquareMeterPerSquareSecondSymbol;
    FName       : rsSquareMeterPerSquareSecondName;
    FPluralName : rsSquareMeterPerSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TJoulePerKilogram }

resourcestring
  rsJoulePerKilogramSymbol = '%sJ/%sg';
  rsJoulePerKilogramName = '%sjoule per %sgram';
  rsJoulePerKilogramPluralName = '%sjoules per %sgram';

const
  JoulePerKilogramUnit : TUnit = (
    FID         : SquareMeterPerSquareSecondID;
    FSymbol     : rsJoulePerKilogramSymbol;
    FName       : rsJoulePerKilogramName;
    FPluralName : rsJoulePerKilogramPluralName;
    FPrefixes   : (pNone, pKilo);
    FExponents  : (1, -1));

{ TGray }

resourcestring
  rsGraySymbol = '%sGy';
  rsGrayName = '%sgray';
  rsGrayPluralName = '%sgrays';

const
  GrayUnit : TUnit = (
    FID         : SquareMeterPerSquareSecondID;
    FSymbol     : rsGraySymbol;
    FName       : rsGrayName;
    FPluralName : rsGrayPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  Gy : TUnit absolute GrayUnit;

const
  kGy        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterPerSquareSecondID; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mGy        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterPerSquareSecondID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miGy       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterPerSquareSecondID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nGy        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterPerSquareSecondID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TSievert }

resourcestring
  rsSievertSymbol = '%sSv';
  rsSievertName = '%ssievert';
  rsSievertPluralName = '%ssieverts';

const
  SievertUnit : TUnit = (
    FID         : SquareMeterPerSquareSecondID;
    FSymbol     : rsSievertSymbol;
    FName       : rsSievertName;
    FPluralName : rsSievertPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  Sv : TUnit absolute SievertUnit;

const
  kSv        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterPerSquareSecondID; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mSv        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterPerSquareSecondID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miSv       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterPerSquareSecondID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nSv        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterPerSquareSecondID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TMeterSecond }

resourcestring
  rsMeterSecondSymbol = '%sm∙%ss';
  rsMeterSecondName = '%smeter %ssecond';
  rsMeterSecondPluralName = '%smeter %sseconds';

const
  MeterSecondID = 74640;
  MeterSecondUnit : TUnit = (
    FID         : MeterSecondID;
    FSymbol     : rsMeterSecondSymbol;
    FName       : rsMeterSecondName;
    FPluralName : rsMeterSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TKilogramMeter }

resourcestring
  rsKilogramMeterSymbol = '%sg∙%sm';
  rsKilogramMeterName = '%sgram %smeter';
  rsKilogramMeterPluralName = '%sgram %smeters';

const
  KilogramMeterID = 48840;
  KilogramMeterUnit : TUnit = (
    FID         : KilogramMeterID;
    FSymbol     : rsKilogramMeterSymbol;
    FName       : rsKilogramMeterName;
    FPluralName : rsKilogramMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, 1));

{ TKilogramPerSecond }

resourcestring
  rsKilogramPerSecondSymbol = '%sg/%ss';
  rsKilogramPerSecondName = '%sgram per %ssecond';
  rsKilogramPerSecondPluralName = '%sgrams per %ssecond';

const
  KilogramPerSecondID = -25800;
  KilogramPerSecondUnit : TUnit = (
    FID         : KilogramPerSecondID;
    FSymbol     : rsKilogramPerSecondSymbol;
    FName       : rsKilogramPerSecondName;
    FPluralName : rsKilogramPerSecondPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, -1));

{ TJoulePerSquareMeterPerHertz }

resourcestring
  rsJoulePerSquareMeterPerHertzSymbol = '%sJ/%sm²/%sHz';
  rsJoulePerSquareMeterPerHertzName = '%sjoule per square %smeter per %shertz';
  rsJoulePerSquareMeterPerHertzPluralName = '%sjoules per square %smeter per %shertz';

const
  JoulePerSquareMeterPerHertzUnit : TUnit = (
    FID         : KilogramPerSecondID;
    FSymbol     : rsJoulePerSquareMeterPerHertzSymbol;
    FName       : rsJoulePerSquareMeterPerHertzName;
    FPluralName : rsJoulePerSquareMeterPerHertzPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -1));

{ TKilogramMeterPerSecond }

resourcestring
  rsKilogramMeterPerSecondSymbol = '%sg∙%sm/%ss';
  rsKilogramMeterPerSecondName = '%sgram %smeter per %ssecond';
  rsKilogramMeterPerSecondPluralName = '%sgram %smeters per %ssecond';

const
  KilogramMeterPerSecondID = 13980;
  KilogramMeterPerSecondUnit : TUnit = (
    FID         : KilogramMeterPerSecondID;
    FSymbol     : rsKilogramMeterPerSecondSymbol;
    FName       : rsKilogramMeterPerSecondName;
    FPluralName : rsKilogramMeterPerSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TNewtonSecond }

resourcestring
  rsNewtonSecondSymbol = '%sN∙%ss';
  rsNewtonSecondName = '%snewton %ssecond';
  rsNewtonSecondPluralName = '%snewton %sseconds';

const
  NewtonSecondUnit : TUnit = (
    FID         : KilogramMeterPerSecondID;
    FSymbol     : rsNewtonSecondSymbol;
    FName       : rsNewtonSecondName;
    FPluralName : rsNewtonSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TSquareKilogramSquareMeterPerSquareSecond }

resourcestring
  rsSquareKilogramSquareMeterPerSquareSecondSymbol = '%sg²∙%sm²/%ss²';
  rsSquareKilogramSquareMeterPerSquareSecondName = 'square%sgram square%smeter per square%ssecond';
  rsSquareKilogramSquareMeterPerSquareSecondPluralName = 'square%sgram square%smeters per square%ssecond';

const
  SquareKilogramSquareMeterPerSquareSecondID = 27960;
  SquareKilogramSquareMeterPerSquareSecondUnit : TUnit = (
    FID         : SquareKilogramSquareMeterPerSquareSecondID;
    FSymbol     : rsSquareKilogramSquareMeterPerSquareSecondSymbol;
    FName       : rsSquareKilogramSquareMeterPerSquareSecondName;
    FPluralName : rsSquareKilogramSquareMeterPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (2, 2, -2));

{ TReciprocalSquareRootMeter }

resourcestring
  rsReciprocalSquareRootMeterSymbol = '1/√%sm';
  rsReciprocalSquareRootMeterName = 'reciprocal square root %smeter';
  rsReciprocalSquareRootMeterPluralName = 'reciprocal square root %smeters';

const
  ReciprocalSquareRootMeterID = -19890;
  ReciprocalSquareRootMeterUnit : TUnit = (
    FID         : ReciprocalSquareRootMeterID;
    FSymbol     : rsReciprocalSquareRootMeterSymbol;
    FName       : rsReciprocalSquareRootMeterName;
    FPluralName : rsReciprocalSquareRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalMeter }

resourcestring
  rsReciprocalMeterSymbol = '1/%sm';
  rsReciprocalMeterName = 'reciprocal %smeter';
  rsReciprocalMeterPluralName = 'reciprocal %smeters';

const
  ReciprocalMeterID = -39780;
  ReciprocalMeterUnit : TUnit = (
    FID         : ReciprocalMeterID;
    FSymbol     : rsReciprocalMeterSymbol;
    FName       : rsReciprocalMeterName;
    FPluralName : rsReciprocalMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TDioptre }

resourcestring
  rsDioptreSymbol = 'dpt';
  rsDioptreName = '%sdioptre';
  rsDioptrePluralName = '%sdioptres';

const
  DioptreUnit : TUnit = (
    FID         : ReciprocalMeterID;
    FSymbol     : rsDioptreSymbol;
    FName       : rsDioptreName;
    FPluralName : rsDioptrePluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalSquareRootCubicMeter }

resourcestring
  rsReciprocalSquareRootCubicMeterSymbol = '1/√%sm³';
  rsReciprocalSquareRootCubicMeterName = 'reciprocal square root cubic %smeter';
  rsReciprocalSquareRootCubicMeterPluralName = 'reciprocal square root cubic %smeters';

const
  ReciprocalSquareRootCubicMeterID = -59670;
  ReciprocalSquareRootCubicMeterUnit : TUnit = (
    FID         : ReciprocalSquareRootCubicMeterID;
    FSymbol     : rsReciprocalSquareRootCubicMeterSymbol;
    FName       : rsReciprocalSquareRootCubicMeterName;
    FPluralName : rsReciprocalSquareRootCubicMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareMeter }

resourcestring
  rsReciprocalSquareMeterSymbol = '1/%sm²';
  rsReciprocalSquareMeterName = 'reciprocal square %smeter';
  rsReciprocalSquareMeterPluralName = 'reciprocal square %smeters';

const
  ReciprocalSquareMeterID = -79560;
  ReciprocalSquareMeterUnit : TUnit = (
    FID         : ReciprocalSquareMeterID;
    FSymbol     : rsReciprocalSquareMeterSymbol;
    FName       : rsReciprocalSquareMeterName;
    FPluralName : rsReciprocalSquareMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TReciprocalCubicMeter }

resourcestring
  rsReciprocalCubicMeterSymbol = '1/%sm³';
  rsReciprocalCubicMeterName = 'reciprocal cubic %smeter';
  rsReciprocalCubicMeterPluralName = 'reciprocal cubic %smeters';

const
  ReciprocalCubicMeterID = -119340;
  ReciprocalCubicMeterUnit : TUnit = (
    FID         : ReciprocalCubicMeterID;
    FSymbol     : rsReciprocalCubicMeterSymbol;
    FName       : rsReciprocalCubicMeterName;
    FPluralName : rsReciprocalCubicMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalQuarticMeter }

resourcestring
  rsReciprocalQuarticMeterSymbol = '1/%sm⁴';
  rsReciprocalQuarticMeterName = 'reciprocal quartic %smeter';
  rsReciprocalQuarticMeterPluralName = 'reciprocal quartic %smeters';

const
  ReciprocalQuarticMeterID = -159120;
  ReciprocalQuarticMeterUnit : TUnit = (
    FID         : ReciprocalQuarticMeterID;
    FSymbol     : rsReciprocalQuarticMeterSymbol;
    FName       : rsReciprocalQuarticMeterName;
    FPluralName : rsReciprocalQuarticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-4));

{ TKilogramSquareMeter }

resourcestring
  rsKilogramSquareMeterSymbol = '%sg∙%sm²';
  rsKilogramSquareMeterName = '%sgram square %smeter';
  rsKilogramSquareMeterPluralName = '%sgram square %smeters';

const
  KilogramSquareMeterID = 88620;
  KilogramSquareMeterUnit : TUnit = (
    FID         : KilogramSquareMeterID;
    FSymbol     : rsKilogramSquareMeterSymbol;
    FName       : rsKilogramSquareMeterName;
    FPluralName : rsKilogramSquareMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, 2));

{ TKilogramSquareMeterPerSecond }

resourcestring
  rsKilogramSquareMeterPerSecondSymbol = '%sg∙%sm²/%ss';
  rsKilogramSquareMeterPerSecondName = '%sgram square %smeter per %ssecond';
  rsKilogramSquareMeterPerSecondPluralName = '%sgram square %smeters per %ssecond';

const
  KilogramSquareMeterPerSecondID = 53760;
  KilogramSquareMeterPerSecondUnit : TUnit = (
    FID         : KilogramSquareMeterPerSecondID;
    FSymbol     : rsKilogramSquareMeterPerSecondSymbol;
    FName       : rsKilogramSquareMeterPerSecondName;
    FPluralName : rsKilogramSquareMeterPerSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TNewtonMeterSecond }

resourcestring
  rsNewtonMeterSecondSymbol = '%sN∙%sm∙%ss';
  rsNewtonMeterSecondName = '%snewton %smeter %ssecond';
  rsNewtonMeterSecondPluralName = '%snewton %smeter %sseconds';

const
  NewtonMeterSecondUnit : TUnit = (
    FID         : KilogramSquareMeterPerSecondID;
    FSymbol     : rsNewtonMeterSecondSymbol;
    FName       : rsNewtonMeterSecondName;
    FPluralName : rsNewtonMeterSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, 1));

{ TSecondPerMeter }

resourcestring
  rsSecondPerMeterSymbol = '%ss/%sm';
  rsSecondPerMeterName = '%ssecond per %smeter';
  rsSecondPerMeterPluralName = '%sseconds per %smeter';

const
  SecondPerMeterID = -4920;
  SecondPerMeterUnit : TUnit = (
    FID         : SecondPerMeterID;
    FSymbol     : rsSecondPerMeterSymbol;
    FName       : rsSecondPerMeterName;
    FPluralName : rsSecondPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TKilogramPerMeter }

resourcestring
  rsKilogramPerMeterSymbol = '%sg/%sm';
  rsKilogramPerMeterName = '%sgram per %smeter';
  rsKilogramPerMeterPluralName = '%sgrams per %smeter';

const
  KilogramPerMeterID = -30720;
  KilogramPerMeterUnit : TUnit = (
    FID         : KilogramPerMeterID;
    FSymbol     : rsKilogramPerMeterSymbol;
    FName       : rsKilogramPerMeterName;
    FPluralName : rsKilogramPerMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, -1));

{ TKilogramPerSquareMeter }

resourcestring
  rsKilogramPerSquareMeterSymbol = '%sg/%sm²';
  rsKilogramPerSquareMeterName = '%sgram per square %smeter';
  rsKilogramPerSquareMeterPluralName = '%sgrams per square %smeter';

const
  KilogramPerSquareMeterID = -70500;
  KilogramPerSquareMeterUnit : TUnit = (
    FID         : KilogramPerSquareMeterID;
    FSymbol     : rsKilogramPerSquareMeterSymbol;
    FName       : rsKilogramPerSquareMeterName;
    FPluralName : rsKilogramPerSquareMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, -2));

{ TKilogramPerCubicMeter }

resourcestring
  rsKilogramPerCubicMeterSymbol = '%sg/%sm³';
  rsKilogramPerCubicMeterName = '%sgram per cubic %smeter';
  rsKilogramPerCubicMeterPluralName = '%sgrams per cubic %smeter';

const
  KilogramPerCubicMeterID = -110280;
  KilogramPerCubicMeterUnit : TUnit = (
    FID         : KilogramPerCubicMeterID;
    FSymbol     : rsKilogramPerCubicMeterSymbol;
    FName       : rsKilogramPerCubicMeterName;
    FPluralName : rsKilogramPerCubicMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, -3));

{ TPoundPerCubicInch }

resourcestring
  rsPoundPerCubicInchSymbol = 'lb/in³';
  rsPoundPerCubicInchName = 'pound per cubic inch';
  rsPoundPerCubicInchPluralName = 'pounds per cubic inch';

const
  PoundPerCubicInchUnit : TFactoredUnit = (
    FID         : KilogramPerCubicMeterID;
    FSymbol     : rsPoundPerCubicInchSymbol;
    FName       : rsPoundPerCubicInchName;
    FPluralName : rsPoundPerCubicInchPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (27679.9047102031));

{ TNewton }

resourcestring
  rsNewtonSymbol = '%sN';
  rsNewtonName = '%snewton';
  rsNewtonPluralName = '%snewtons';

const
  NewtonID = -20880;
  NewtonUnit : TUnit = (
    FID         : NewtonID;
    FSymbol     : rsNewtonSymbol;
    FName       : rsNewtonName;
    FPluralName : rsNewtonPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  N : TUnit absolute NewtonUnit;

const
  GN         : TQuantity = {$IFNDEF ADIMOFF} (FID: NewtonID; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MN         : TQuantity = {$IFNDEF ADIMOFF} (FID: NewtonID; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kN         : TQuantity = {$IFNDEF ADIMOFF} (FID: NewtonID; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hN         : TQuantity = {$IFNDEF ADIMOFF} (FID: NewtonID; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daN        : TQuantity = {$IFNDEF ADIMOFF} (FID: NewtonID; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}

{ TPoundForce }

resourcestring
  rsPoundForceSymbol = 'lbf';
  rsPoundForceName = 'pound-force';
  rsPoundForcePluralName = 'pounds-force';

const
  PoundForceUnit : TFactoredUnit = (
    FID         : NewtonID;
    FSymbol     : rsPoundForceSymbol;
    FName       : rsPoundForceName;
    FPluralName : rsPoundForcePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (4.4482216152605));

var
  lbf : TFactoredUnit absolute PoundForceUnit;

{ TKilogramMeterPerSquareSecond }

resourcestring
  rsKilogramMeterPerSquareSecondSymbol = '%sg∙%sm/%ss²';
  rsKilogramMeterPerSquareSecondName = '%sgram %smeter per square %ssecond';
  rsKilogramMeterPerSquareSecondPluralName = '%sgram %smeters per square %ssecond';

const
  KilogramMeterPerSquareSecondUnit : TUnit = (
    FID         : NewtonID;
    FSymbol     : rsKilogramMeterPerSquareSecondSymbol;
    FName       : rsKilogramMeterPerSquareSecondName;
    FPluralName : rsKilogramMeterPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 1, -2));

{ TNewtonRadian }

resourcestring
  rsNewtonRadianSymbol = '%sN∙%srad';
  rsNewtonRadianName = '%snewton %sradian';
  rsNewtonRadianPluralName = '%snewton %sradians';

const
  NewtonRadianUnit : TUnit = (
    FID         : NewtonID;
    FSymbol     : rsNewtonRadianSymbol;
    FName       : rsNewtonRadianName;
    FPluralName : rsNewtonRadianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TSquareNewton }

resourcestring
  rsSquareNewtonSymbol = '%sN²';
  rsSquareNewtonName = 'square %snewton';
  rsSquareNewtonPluralName = 'square %snewtons';

const
  SquareNewtonID = -41760;
  SquareNewtonUnit : TUnit = (
    FID         : SquareNewtonID;
    FSymbol     : rsSquareNewtonSymbol;
    FName       : rsSquareNewtonName;
    FPluralName : rsSquareNewtonPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  N2 : TUnit absolute SquareNewtonUnit;

const
  GN2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareNewtonID; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MN2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareNewtonID; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kN2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareNewtonID; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hN2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareNewtonID; FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daN2       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareNewtonID; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}

{ TSquareKilogramSquareMeterPerQuarticSecond }

resourcestring
  rsSquareKilogramSquareMeterPerQuarticSecondSymbol = '%sg²∙%sm²/%ss⁴';
  rsSquareKilogramSquareMeterPerQuarticSecondName = 'square %sgram square %smeter per quartic %ssecond';
  rsSquareKilogramSquareMeterPerQuarticSecondPluralName = 'square %sgram square %smeters per quartic %ssecond';

const
  SquareKilogramSquareMeterPerQuarticSecondUnit : TUnit = (
    FID         : SquareNewtonID;
    FSymbol     : rsSquareKilogramSquareMeterPerQuarticSecondSymbol;
    FName       : rsSquareKilogramSquareMeterPerQuarticSecondName;
    FPluralName : rsSquareKilogramSquareMeterPerQuarticSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (2, 2, -4));

{ TPascal }

resourcestring
  rsPascalSymbol = '%sPa';
  rsPascalName = '%spascal';
  rsPascalPluralName = '%spascals';

const
  PascalID = -100440;
  PascalUnit : TUnit = (
    FID         : PascalID;
    FSymbol     : rsPascalSymbol;
    FName       : rsPascalName;
    FPluralName : rsPascalPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  Pa : TUnit absolute PascalUnit;

const
  TPa        : TQuantity = {$IFNDEF ADIMOFF} (FID: PascalID; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GPa        : TQuantity = {$IFNDEF ADIMOFF} (FID: PascalID; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MPa        : TQuantity = {$IFNDEF ADIMOFF} (FID: PascalID; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kPa        : TQuantity = {$IFNDEF ADIMOFF} (FID: PascalID; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TNewtonPerSquareMeter }

resourcestring
  rsNewtonPerSquareMeterSymbol = '%sN/%sm²';
  rsNewtonPerSquareMeterName = '%snewton per square %smeter';
  rsNewtonPerSquareMeterPluralName = '%snewtons per square %smeter';

const
  NewtonPerSquareMeterUnit : TUnit = (
    FID         : PascalID;
    FSymbol     : rsNewtonPerSquareMeterSymbol;
    FName       : rsNewtonPerSquareMeterName;
    FPluralName : rsNewtonPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TBar }

resourcestring
  rsBarSymbol = '%sbar';
  rsBarName = '%sbar';
  rsBarPluralName = '%sbars';

const
  BarUnit : TFactoredUnit = (
    FID         : PascalID;
    FSymbol     : rsBarSymbol;
    FName       : rsBarName;
    FPluralName : rsBarPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (1E+05));

var
  bar : TFactoredUnit absolute BarUnit;

const
  kbar       : TQuantity = {$IFNDEF ADIMOFF} (FID: PascalID; FValue: 1E+05 * 1E+03); {$ELSE} (1E+05 * 1E+03); {$ENDIF}
  mbar       : TQuantity = {$IFNDEF ADIMOFF} (FID: PascalID; FValue: 1E+05 * 1E-03); {$ELSE} (1E+05 * 1E-03); {$ENDIF}

{ TPoundPerSquareInch }

resourcestring
  rsPoundPerSquareInchSymbol = '%spsi';
  rsPoundPerSquareInchName = '%spound per square inch';
  rsPoundPerSquareInchPluralName = '%spounds per square inch';

const
  PoundPerSquareInchUnit : TFactoredUnit = (
    FID         : PascalID;
    FSymbol     : rsPoundPerSquareInchSymbol;
    FName       : rsPoundPerSquareInchName;
    FPluralName : rsPoundPerSquareInchPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (6894.75729316836));

var
  psi : TFactoredUnit absolute PoundPerSquareInchUnit;

const
  kpsi       : TQuantity = {$IFNDEF ADIMOFF} (FID: PascalID; FValue: 6894.75729316836 * 1E+03); {$ELSE} (6894.75729316836 * 1E+03); {$ENDIF}

{ TJoulePerCubicMeter }

resourcestring
  rsJoulePerCubicMeterSymbol = '%sJ/%sm³';
  rsJoulePerCubicMeterName = '%sjoule per cubic %smeter';
  rsJoulePerCubicMeterPluralName = '%sjoules per cubic %smeter';

const
  JoulePerCubicMeterUnit : TUnit = (
    FID         : PascalID;
    FSymbol     : rsJoulePerCubicMeterSymbol;
    FName       : rsJoulePerCubicMeterName;
    FPluralName : rsJoulePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TKilogramPerMeterPerSquareSecond }

resourcestring
  rsKilogramPerMeterPerSquareSecondSymbol = '%sg/%sm/%ss²';
  rsKilogramPerMeterPerSquareSecondName = '%sgram per %smeter per square %ssecond';
  rsKilogramPerMeterPerSquareSecondPluralName = '%sgrams per %smeter per square %ssecond';

const
  KilogramPerMeterPerSquareSecondUnit : TUnit = (
    FID         : PascalID;
    FSymbol     : rsKilogramPerMeterPerSquareSecondSymbol;
    FName       : rsKilogramPerMeterPerSquareSecondName;
    FPluralName : rsKilogramPerMeterPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TJoule }

resourcestring
  rsJouleSymbol = '%sJ';
  rsJouleName = '%sjoule';
  rsJoulePluralName = '%sjoules';

const
  JouleID = 18900;
  JouleUnit : TUnit = (
    FID         : JouleID;
    FSymbol     : rsJouleSymbol;
    FName       : rsJouleName;
    FPluralName : rsJoulePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  J : TUnit absolute JouleUnit;

const
  TJ         : TQuantity = {$IFNDEF ADIMOFF} (FID: JouleID; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GJ         : TQuantity = {$IFNDEF ADIMOFF} (FID: JouleID; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MJ         : TQuantity = {$IFNDEF ADIMOFF} (FID: JouleID; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kJ         : TQuantity = {$IFNDEF ADIMOFF} (FID: JouleID; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TWattHour }

resourcestring
  rsWattHourSymbol = '%sW∙h';
  rsWattHourName = '%swatt hour';
  rsWattHourPluralName = '%swatt hours';

const
  WattHourUnit : TFactoredUnit = (
    FID         : JouleID;
    FSymbol     : rsWattHourSymbol;
    FName       : rsWattHourName;
    FPluralName : rsWattHourPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (3600));

{ TWattSecond }

resourcestring
  rsWattSecondSymbol = '%sW∙%ss';
  rsWattSecondName = '%swatt %ssecond';
  rsWattSecondPluralName = '%swatt %sseconds';

const
  WattSecondUnit : TUnit = (
    FID         : JouleID;
    FSymbol     : rsWattSecondSymbol;
    FName       : rsWattSecondName;
    FPluralName : rsWattSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TWattPerHertz }

resourcestring
  rsWattPerHertzSymbol = '%sW/%shz';
  rsWattPerHertzName = '%swatt per %shertz';
  rsWattPerHertzPluralName = '%swatts per %shertz';

const
  WattPerHertzUnit : TUnit = (
    FID         : JouleID;
    FSymbol     : rsWattPerHertzSymbol;
    FName       : rsWattPerHertzName;
    FPluralName : rsWattPerHertzPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TElectronvolt }

resourcestring
  rsElectronvoltSymbol = '%seV';
  rsElectronvoltName = '%selectronvolt';
  rsElectronvoltPluralName = '%selectronvolts';

const
  ElectronvoltUnit : TFactoredUnit = (
    FID         : JouleID;
    FSymbol     : rsElectronvoltSymbol;
    FName       : rsElectronvoltName;
    FPluralName : rsElectronvoltPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (1.602176634E-019));

var
  eV : TFactoredUnit absolute ElectronvoltUnit;

const
  TeV        : TQuantity = {$IFNDEF ADIMOFF} (FID: JouleID; FValue: 1.602176634E-019 * 1E+12); {$ELSE} (1.602176634E-019 * 1E+12); {$ENDIF}
  GeV        : TQuantity = {$IFNDEF ADIMOFF} (FID: JouleID; FValue: 1.602176634E-019 * 1E+09); {$ELSE} (1.602176634E-019 * 1E+09); {$ENDIF}
  MeV        : TQuantity = {$IFNDEF ADIMOFF} (FID: JouleID; FValue: 1.602176634E-019 * 1E+06); {$ELSE} (1.602176634E-019 * 1E+06); {$ENDIF}
  keV        : TQuantity = {$IFNDEF ADIMOFF} (FID: JouleID; FValue: 1.602176634E-019 * 1E+03); {$ELSE} (1.602176634E-019 * 1E+03); {$ENDIF}

{ TNewtonMeter }

resourcestring
  rsNewtonMeterSymbol = '%sN∙%sm';
  rsNewtonMeterName = '%snewton %smeter';
  rsNewtonMeterPluralName = '%snewton %smeters';

const
  NewtonMeterUnit : TUnit = (
    FID         : JouleID;
    FSymbol     : rsNewtonMeterSymbol;
    FName       : rsNewtonMeterName;
    FPluralName : rsNewtonMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TPoundForceInch }

resourcestring
  rsPoundForceInchSymbol = 'lbf∙in';
  rsPoundForceInchName = 'pound-force inch';
  rsPoundForceInchPluralName = 'pound-force inches';

const
  PoundForceInchUnit : TFactoredUnit = (
    FID         : JouleID;
    FSymbol     : rsPoundForceInchSymbol;
    FName       : rsPoundForceInchName;
    FPluralName : rsPoundForceInchPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.112984829027617));

{ TRydberg }

resourcestring
  rsRydbergSymbol = '%sRy';
  rsRydbergName = '%srydberg';
  rsRydbergPluralName = '%srydbergs';

const
  RydbergUnit : TFactoredUnit = (
    FID         : JouleID;
    FSymbol     : rsRydbergSymbol;
    FName       : rsRydbergName;
    FPluralName : rsRydbergPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (2.1798723611035E-18));

var
  Ry : TFactoredUnit absolute RydbergUnit;

{ TCalorie }

resourcestring
  rsCalorieSymbol = '%scal';
  rsCalorieName = '%scalorie';
  rsCaloriePluralName = '%scalories';

const
  CalorieUnit : TFactoredUnit = (
    FID         : JouleID;
    FSymbol     : rsCalorieSymbol;
    FName       : rsCalorieName;
    FPluralName : rsCaloriePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (4.184));

var
  cal : TFactoredUnit absolute CalorieUnit;

const
  Mcal       : TQuantity = {$IFNDEF ADIMOFF} (FID: JouleID; FValue: 4.184 * 1E+06); {$ELSE} (4.184 * 1E+06); {$ENDIF}
  kcal       : TQuantity = {$IFNDEF ADIMOFF} (FID: JouleID; FValue: 4.184 * 1E+03); {$ELSE} (4.184 * 1E+03); {$ENDIF}

{ TKilogramSquareMeterPerSquareSecond }

resourcestring
  rsKilogramSquareMeterPerSquareSecondSymbol = '%sg∙%sm²/%ss²';
  rsKilogramSquareMeterPerSquareSecondName = '%sgram square %smeter per square %ssecond';
  rsKilogramSquareMeterPerSquareSecondPluralName = '%sgram square %smeters per square %ssecond';

const
  KilogramSquareMeterPerSquareSecondUnit : TUnit = (
    FID         : JouleID;
    FSymbol     : rsKilogramSquareMeterPerSquareSecondSymbol;
    FName       : rsKilogramSquareMeterPerSquareSecondName;
    FPluralName : rsKilogramSquareMeterPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 2, -2));

{ TJoulePerRadian }

resourcestring
  rsJoulePerRadianSymbol = '%sJ/rad';
  rsJoulePerRadianName = '%sjoule per radian';
  rsJoulePerRadianPluralName = '%sjoules per radian';

const
  JoulePerRadianUnit : TUnit = (
    FID         : JouleID;
    FSymbol     : rsJoulePerRadianSymbol;
    FName       : rsJoulePerRadianName;
    FPluralName : rsJoulePerRadianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TJoulePerDegree }

resourcestring
  rsJoulePerDegreeSymbol = '%sJ/°';
  rsJoulePerDegreeName = '%sjoule per degree';
  rsJoulePerDegreePluralName = '%sjoules per degree';

const
  JoulePerDegreeUnit : TFactoredUnit = (
    FID         : JouleID;
    FSymbol     : rsJoulePerDegreeSymbol;
    FName       : rsJoulePerDegreeName;
    FPluralName : rsJoulePerDegreePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (180/Pi));

{ TNewtonMeterPerRadian }

resourcestring
  rsNewtonMeterPerRadianSymbol = '%sN∙%sm/rad';
  rsNewtonMeterPerRadianName = '%snewton %smeter per radian';
  rsNewtonMeterPerRadianPluralName = '%snewton %smeters per radian';

const
  NewtonMeterPerRadianUnit : TUnit = (
    FID         : JouleID;
    FSymbol     : rsNewtonMeterPerRadianSymbol;
    FName       : rsNewtonMeterPerRadianName;
    FPluralName : rsNewtonMeterPerRadianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TNewtonMeterPerDegree }

resourcestring
  rsNewtonMeterPerDegreeSymbol = '%sN∙%sm/°';
  rsNewtonMeterPerDegreeName = '%snewton %smeter per degree';
  rsNewtonMeterPerDegreePluralName = '%snewton %smeters per degree';

const
  NewtonMeterPerDegreeUnit : TFactoredUnit = (
    FID         : JouleID;
    FSymbol     : rsNewtonMeterPerDegreeSymbol;
    FName       : rsNewtonMeterPerDegreeName;
    FPluralName : rsNewtonMeterPerDegreePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1);
    FFactor     : (180/Pi));

{ TPoundForceInchPerRadian }

resourcestring
  rsPoundForceInchPerRadianSymbol = 'lbf∙in/rad';
  rsPoundForceInchPerRadianName = 'pound-force inch per radian';
  rsPoundForceInchPerRadianPluralName = 'pound-force inches per radian';

const
  PoundForceInchPerRadianUnit : TFactoredUnit = (
    FID         : JouleID;
    FSymbol     : rsPoundForceInchPerRadianSymbol;
    FName       : rsPoundForceInchPerRadianName;
    FPluralName : rsPoundForceInchPerRadianPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.112984829027617));

{ TPoundForceInchPerDegree }

resourcestring
  rsPoundForceInchPerDegreeSymbol = 'lbf∙in/°';
  rsPoundForceInchPerDegreeName = 'pound-force inch per degree';
  rsPoundForceInchPerDegreePluralName = 'pound-force inches per degree';

const
  PoundForceInchPerDegreeUnit : TFactoredUnit = (
    FID         : JouleID;
    FSymbol     : rsPoundForceInchPerDegreeSymbol;
    FName       : rsPoundForceInchPerDegreeName;
    FPluralName : rsPoundForceInchPerDegreePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (6.47355385228963));

{ TKilogramSquareMeterPerSquareSecondPerRadian }

resourcestring
  rsKilogramSquareMeterPerSquareSecondPerRadianSymbol = '%sg∙%sm²/%ss²/rad';
  rsKilogramSquareMeterPerSquareSecondPerRadianName = '%sgram square %smeter per square %ssecond per radian';
  rsKilogramSquareMeterPerSquareSecondPerRadianPluralName = '%sgram square %smeters per square %ssecond per radian';

const
  KilogramSquareMeterPerSquareSecondPerRadianUnit : TUnit = (
    FID         : JouleID;
    FSymbol     : rsKilogramSquareMeterPerSquareSecondPerRadianSymbol;
    FName       : rsKilogramSquareMeterPerSquareSecondPerRadianName;
    FPluralName : rsKilogramSquareMeterPerSquareSecondPerRadianPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 2, -2));

{ TWatt }

resourcestring
  rsWattSymbol = '%sW';
  rsWattName = '%swatt';
  rsWattPluralName = '%swatts';

const
  WattID = -15960;
  WattUnit : TUnit = (
    FID         : WattID;
    FSymbol     : rsWattSymbol;
    FName       : rsWattName;
    FPluralName : rsWattPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  W : TUnit absolute WattUnit;

const
  TW         : TQuantity = {$IFNDEF ADIMOFF} (FID: WattID; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GW         : TQuantity = {$IFNDEF ADIMOFF} (FID: WattID; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MW         : TQuantity = {$IFNDEF ADIMOFF} (FID: WattID; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kW         : TQuantity = {$IFNDEF ADIMOFF} (FID: WattID; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  milliW     : TQuantity = {$IFNDEF ADIMOFF} (FID: WattID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

{ TKilogramSquareMeterPerCubicSecond }

resourcestring
  rsKilogramSquareMeterPerCubicSecondSymbol = '%sg∙%sm²/%ss³';
  rsKilogramSquareMeterPerCubicSecondName = '%sgram square %smeter per cubic %ssecond';
  rsKilogramSquareMeterPerCubicSecondPluralName = '%sgram square %smeters per cubic %ssecond';

const
  KilogramSquareMeterPerCubicSecondUnit : TUnit = (
    FID         : WattID;
    FSymbol     : rsKilogramSquareMeterPerCubicSecondSymbol;
    FName       : rsKilogramSquareMeterPerCubicSecondName;
    FPluralName : rsKilogramSquareMeterPerCubicSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 2, -3));

{ TCoulomb }

resourcestring
  rsCoulombSymbol = '%sC';
  rsCoulombName = '%scoulomb';
  rsCoulombPluralName = '%scoulombs';

const
  CoulombID = 59160;
  CoulombUnit : TUnit = (
    FID         : CoulombID;
    FSymbol     : rsCoulombSymbol;
    FName       : rsCoulombName;
    FPluralName : rsCoulombPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  C : TUnit absolute CoulombUnit;

const
  kC         : TQuantity = {$IFNDEF ADIMOFF} (FID: CoulombID; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hC         : TQuantity = {$IFNDEF ADIMOFF} (FID: CoulombID; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daC        : TQuantity = {$IFNDEF ADIMOFF} (FID: CoulombID; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}
  dC         : TQuantity = {$IFNDEF ADIMOFF} (FID: CoulombID; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cC         : TQuantity = {$IFNDEF ADIMOFF} (FID: CoulombID; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mC         : TQuantity = {$IFNDEF ADIMOFF} (FID: CoulombID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miC        : TQuantity = {$IFNDEF ADIMOFF} (FID: CoulombID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nC         : TQuantity = {$IFNDEF ADIMOFF} (FID: CoulombID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pC         : TQuantity = {$IFNDEF ADIMOFF} (FID: CoulombID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TAmpereHour }

resourcestring
  rsAmpereHourSymbol = '%sA∙h';
  rsAmpereHourName = '%sampere hour';
  rsAmpereHourPluralName = '%sampere hours';

const
  AmpereHourUnit : TFactoredUnit = (
    FID         : CoulombID;
    FSymbol     : rsAmpereHourSymbol;
    FName       : rsAmpereHourName;
    FPluralName : rsAmpereHourPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (3600));

{ TAmpereSecond }

resourcestring
  rsAmpereSecondSymbol = '%sA∙%ss';
  rsAmpereSecondName = '%sampere %ssecond';
  rsAmpereSecondPluralName = '%sampere %sseconds';

const
  AmpereSecondUnit : TUnit = (
    FID         : CoulombID;
    FSymbol     : rsAmpereSecondSymbol;
    FName       : rsAmpereSecondName;
    FPluralName : rsAmpereSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TSquareCoulomb }

resourcestring
  rsSquareCoulombSymbol = '%sC²';
  rsSquareCoulombName = 'square %scoulomb';
  rsSquareCoulombPluralName = 'square %scoulombs';

const
  SquareCoulombID = 118320;
  SquareCoulombUnit : TUnit = (
    FID         : SquareCoulombID;
    FSymbol     : rsSquareCoulombSymbol;
    FName       : rsSquareCoulombName;
    FPluralName : rsSquareCoulombPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  C2 : TUnit absolute SquareCoulombUnit;

const
  kC2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareCoulombID; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hC2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareCoulombID; FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daC2       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareCoulombID; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  dC2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareCoulombID; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cC2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareCoulombID; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mC2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareCoulombID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  miC2       : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareCoulombID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nC2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareCoulombID; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  pC2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareCoulombID; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareAmpereSquareSecond }

resourcestring
  rsSquareAmpereSquareSecondSymbol = '%sA²∙%ss²';
  rsSquareAmpereSquareSecondName = 'square %sampere square %ssecond';
  rsSquareAmpereSquareSecondPluralName = 'square %sampere square %sseconds';

const
  SquareAmpereSquareSecondUnit : TUnit = (
    FID         : SquareCoulombID;
    FSymbol     : rsSquareAmpereSquareSecondSymbol;
    FName       : rsSquareAmpereSquareSecondName;
    FPluralName : rsSquareAmpereSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 2));

{ TCoulombMeter }

resourcestring
  rsCoulombMeterSymbol = '%sC∙%sm';
  rsCoulombMeterName = '%scoulomb %smeter';
  rsCoulombMeterPluralName = '%scoulomb %smeters';

const
  CoulombMeterID = 98940;
  CoulombMeterUnit : TUnit = (
    FID         : CoulombMeterID;
    FSymbol     : rsCoulombMeterSymbol;
    FName       : rsCoulombMeterName;
    FPluralName : rsCoulombMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TVolt }

resourcestring
  rsVoltSymbol = '%sV';
  rsVoltName = '%svolt';
  rsVoltPluralName = '%svolts';

const
  VoltID = -40260;
  VoltUnit : TUnit = (
    FID         : VoltID;
    FSymbol     : rsVoltSymbol;
    FName       : rsVoltName;
    FPluralName : rsVoltPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  V : TUnit absolute VoltUnit;

const
  kV         : TQuantity = {$IFNDEF ADIMOFF} (FID: VoltID; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mV         : TQuantity = {$IFNDEF ADIMOFF} (FID: VoltID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

{ TJoulePerCoulomb }

resourcestring
  rsJoulePerCoulombSymbol = '%sJ/%sC';
  rsJoulePerCoulombName = '%sJoule per %scoulomb';
  rsJoulePerCoulombPluralName = '%sJoules per %scoulomb';

const
  JoulePerCoulombUnit : TUnit = (
    FID         : VoltID;
    FSymbol     : rsJoulePerCoulombSymbol;
    FName       : rsJoulePerCoulombName;
    FPluralName : rsJoulePerCoulombPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TKilogramSquareMeterPerAmperePerCubicSecond }

resourcestring
  rsKilogramSquareMeterPerAmperePerCubicSecondSymbol = '%sg∙%sm²/%sA/%ss³';
  rsKilogramSquareMeterPerAmperePerCubicSecondName = '%sgram square %smeter per %sampere per cubic %ssecond';
  rsKilogramSquareMeterPerAmperePerCubicSecondPluralName = '%sgram square %smeters per %sampere per cubic %ssecond';

const
  KilogramSquareMeterPerAmperePerCubicSecondUnit : TUnit = (
    FID         : VoltID;
    FSymbol     : rsKilogramSquareMeterPerAmperePerCubicSecondSymbol;
    FName       : rsKilogramSquareMeterPerAmperePerCubicSecondName;
    FPluralName : rsKilogramSquareMeterPerAmperePerCubicSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (1, 2, -1, -3));

{ TSquareVolt }

resourcestring
  rsSquareVoltSymbol = '%sV²';
  rsSquareVoltName = 'square %svolt';
  rsSquareVoltPluralName = 'square %svolts';

const
  SquareVoltID = -80520;
  SquareVoltUnit : TUnit = (
    FID         : SquareVoltID;
    FSymbol     : rsSquareVoltSymbol;
    FName       : rsSquareVoltName;
    FPluralName : rsSquareVoltPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  V2 : TUnit absolute SquareVoltUnit;

const
  kV2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareVoltID; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  mV2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareVoltID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}

{ TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecond }

resourcestring
  rsSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondSymbol = '%sg²∙%sm³/%sA²/%ss⁶';
  rsSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondName = 'square %sgram quartic %smeter per square %sampere per sextic %ssecond';
  rsSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondPluralName = 'square %sgram quartic %smeters per square %sampere per sextic %ssecond';

const
  SquareKilogramQuarticMeterPerSquareAmperePerSexticSecondUnit : TUnit = (
    FID         : SquareVoltID;
    FSymbol     : rsSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondSymbol;
    FName       : rsSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondName;
    FPluralName : rsSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (2, 3, -2, -6));

{ TFarad }

resourcestring
  rsFaradSymbol = '%sF';
  rsFaradName = '%sfarad';
  rsFaradPluralName = '%sfarads';

const
  FaradID = 99420;
  FaradUnit : TUnit = (
    FID         : FaradID;
    FSymbol     : rsFaradSymbol;
    FName       : rsFaradName;
    FPluralName : rsFaradPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  F : TUnit absolute FaradUnit;

const
  mF         : TQuantity = {$IFNDEF ADIMOFF} (FID: FaradID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miF        : TQuantity = {$IFNDEF ADIMOFF} (FID: FaradID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nF         : TQuantity = {$IFNDEF ADIMOFF} (FID: FaradID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pF         : TQuantity = {$IFNDEF ADIMOFF} (FID: FaradID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TCoulombPerVolt }

resourcestring
  rsCoulombPerVoltSymbol = '%sC/%sV';
  rsCoulombPerVoltName = '%scoulomb per %svolt';
  rsCoulombPerVoltPluralName = '%scoulombs per %svolt';

const
  CoulombPerVoltUnit : TUnit = (
    FID         : FaradID;
    FSymbol     : rsCoulombPerVoltSymbol;
    FName       : rsCoulombPerVoltName;
    FPluralName : rsCoulombPerVoltPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareAmpereQuarticSecondPerKilogramPerSquareMeter }

resourcestring
  rsSquareAmpereQuarticSecondPerKilogramPerSquareMeterSymbol = '%sA²∙%ss⁴/%sg/%sm²';
  rsSquareAmpereQuarticSecondPerKilogramPerSquareMeterName = 'square %sampere quartic %ssecond per %sgram per square %smeter';
  rsSquareAmpereQuarticSecondPerKilogramPerSquareMeterPluralName = 'square %sampere quartic %sseconds per %sgram per square %smeter';

const
  SquareAmpereQuarticSecondPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : FaradID;
    FSymbol     : rsSquareAmpereQuarticSecondPerKilogramPerSquareMeterSymbol;
    FName       : rsSquareAmpereQuarticSecondPerKilogramPerSquareMeterName;
    FPluralName : rsSquareAmpereQuarticSecondPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pKilo, pNone);
    FExponents  : (2, 4, -1, -2));

{ TOhm }

resourcestring
  rsOhmSymbol = '%sΩ';
  rsOhmName = '%sohm';
  rsOhmPluralName = '%sohms';

const
  OhmID = -64560;
  OhmUnit : TUnit = (
    FID         : OhmID;
    FSymbol     : rsOhmSymbol;
    FName       : rsOhmName;
    FPluralName : rsOhmPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  ohm : TUnit absolute OhmUnit;

const
  Gohm       : TQuantity = {$IFNDEF ADIMOFF} (FID: OhmID; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  megaohm    : TQuantity = {$IFNDEF ADIMOFF} (FID: OhmID; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kohm       : TQuantity = {$IFNDEF ADIMOFF} (FID: OhmID; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mohm       : TQuantity = {$IFNDEF ADIMOFF} (FID: OhmID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miohm      : TQuantity = {$IFNDEF ADIMOFF} (FID: OhmID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nohm       : TQuantity = {$IFNDEF ADIMOFF} (FID: OhmID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TKilogramSquareMeterPerSquareAmperePerCubicSecond }

resourcestring
  rsKilogramSquareMeterPerSquareAmperePerCubicSecondSymbol = '%sg∙%sm²/%sA/%ss³';
  rsKilogramSquareMeterPerSquareAmperePerCubicSecondName = '%sgram square %smeter per square %sampere per cubic %ssecond';
  rsKilogramSquareMeterPerSquareAmperePerCubicSecondPluralName = '%sgram square %smeters per square %sampere per cubic %ssecond';

const
  KilogramSquareMeterPerSquareAmperePerCubicSecondUnit : TUnit = (
    FID         : OhmID;
    FSymbol     : rsKilogramSquareMeterPerSquareAmperePerCubicSecondSymbol;
    FName       : rsKilogramSquareMeterPerSquareAmperePerCubicSecondName;
    FPluralName : rsKilogramSquareMeterPerSquareAmperePerCubicSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (1, 2, -1, -3));

{ TSiemens }

resourcestring
  rsSiemensSymbol = '%sS';
  rsSiemensName = '%ssiemens';
  rsSiemensPluralName = '%ssiemens';

const
  SiemensID = 64560;
  SiemensUnit : TUnit = (
    FID         : SiemensID;
    FSymbol     : rsSiemensSymbol;
    FName       : rsSiemensName;
    FPluralName : rsSiemensPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  siemens : TUnit absolute SiemensUnit;

const
  millisiemens : TQuantity = {$IFNDEF ADIMOFF} (FID: SiemensID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  microsiemens : TQuantity = {$IFNDEF ADIMOFF} (FID: SiemensID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
   nanosiemens : TQuantity = {$IFNDEF ADIMOFF} (FID: SiemensID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TSquareAmpereCubicSecondPerKilogramPerSquareMeter }

resourcestring
  rsSquareAmpereCubicSecondPerKilogramPerSquareMeterSymbol = '%sA²∙%ss³/%sg/%sm²';
  rsSquareAmpereCubicSecondPerKilogramPerSquareMeterName = 'square %sampere cubic %ssecond per %sgram per square %smeter';
  rsSquareAmpereCubicSecondPerKilogramPerSquareMeterPluralName = 'square %sampere cubic %sseconds per %sgram per square %smeter';

const
  SquareAmpereCubicSecondPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : SiemensID;
    FSymbol     : rsSquareAmpereCubicSecondPerKilogramPerSquareMeterSymbol;
    FName       : rsSquareAmpereCubicSecondPerKilogramPerSquareMeterName;
    FPluralName : rsSquareAmpereCubicSecondPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pKilo, pNone);
    FExponents  : (2, 3, -1, -2));

{ TSiemensPerMeter }

resourcestring
  rsSiemensPerMeterSymbol = '%sS/%sm';
  rsSiemensPerMeterName = '%ssiemens per %smeter';
  rsSiemensPerMeterPluralName = '%ssiemens per %smeter';

const
  SiemensPerMeterID = 24780;
  SiemensPerMeterUnit : TUnit = (
    FID         : SiemensPerMeterID;
    FSymbol     : rsSiemensPerMeterSymbol;
    FName       : rsSiemensPerMeterName;
    FPluralName : rsSiemensPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TTesla }

resourcestring
  rsTeslaSymbol = '%sT';
  rsTeslaName = '%stesla';
  rsTeslaPluralName = '%steslas';

const
  TeslaID = -84960;
  TeslaUnit : TUnit = (
    FID         : TeslaID;
    FSymbol     : rsTeslaSymbol;
    FName       : rsTeslaName;
    FPluralName : rsTeslaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  T : TUnit absolute TeslaUnit;

const
  mT         : TQuantity = {$IFNDEF ADIMOFF} (FID: TeslaID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miT        : TQuantity = {$IFNDEF ADIMOFF} (FID: TeslaID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nT         : TQuantity = {$IFNDEF ADIMOFF} (FID: TeslaID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TWeberPerSquareMeter }

resourcestring
  rsWeberPerSquareMeterSymbol = '%sWb/%m²';
  rsWeberPerSquareMeterName = '%sweber per square %smeter';
  rsWeberPerSquareMeterPluralName = '%swebers per square %smeter';

const
  WeberPerSquareMeterUnit : TUnit = (
    FID         : TeslaID;
    FSymbol     : rsWeberPerSquareMeterSymbol;
    FName       : rsWeberPerSquareMeterName;
    FPluralName : rsWeberPerSquareMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TKilogramPerAmperePerSquareSecond }

resourcestring
  rsKilogramPerAmperePerSquareSecondSymbol = '%sg/%sA/%ss²';
  rsKilogramPerAmperePerSquareSecondName = '%sgram per %sampere per square %ssecond';
  rsKilogramPerAmperePerSquareSecondPluralName = '%sgrams per %sampere per square %ssecond';

const
  KilogramPerAmperePerSquareSecondUnit : TUnit = (
    FID         : TeslaID;
    FSymbol     : rsKilogramPerAmperePerSquareSecondSymbol;
    FName       : rsKilogramPerAmperePerSquareSecondName;
    FPluralName : rsKilogramPerAmperePerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TWeber }

resourcestring
  rsWeberSymbol = '%sWb';
  rsWeberName = '%sweber';
  rsWeberPluralName = '%swebers';

const
  WeberID = -5400;
  WeberUnit : TUnit = (
    FID         : WeberID;
    FSymbol     : rsWeberSymbol;
    FName       : rsWeberName;
    FPluralName : rsWeberPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  Wb : TUnit absolute WeberUnit;

{ TKilogramSquareMeterPerAmperePerSquareSecond }

resourcestring
  rsKilogramSquareMeterPerAmperePerSquareSecondSymbol = '%sg∙%sm²/%sA/%ss²';
  rsKilogramSquareMeterPerAmperePerSquareSecondName = '%sgram square %smeter per %sampere per square %ssecond';
  rsKilogramSquareMeterPerAmperePerSquareSecondPluralName = '%sgram square %smeters per %sampere per square %ssecond';

const
  KilogramSquareMeterPerAmperePerSquareSecondUnit : TUnit = (
    FID         : WeberID;
    FSymbol     : rsKilogramSquareMeterPerAmperePerSquareSecondSymbol;
    FName       : rsKilogramSquareMeterPerAmperePerSquareSecondName;
    FPluralName : rsKilogramSquareMeterPerAmperePerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (1, 2, -1, -2));

{ THenry }

resourcestring
  rsHenrySymbol = '%sH';
  rsHenryName = '%shenry';
  rsHenryPluralName = '%shenries';

const
  HenryID = -29700;
  HenryUnit : TUnit = (
    FID         : HenryID;
    FSymbol     : rsHenrySymbol;
    FName       : rsHenryName;
    FPluralName : rsHenryPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  H : TUnit absolute HenryUnit;

const
  mH         : TQuantity = {$IFNDEF ADIMOFF} (FID: HenryID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miH        : TQuantity = {$IFNDEF ADIMOFF} (FID: HenryID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nH         : TQuantity = {$IFNDEF ADIMOFF} (FID: HenryID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TKilogramSquareMeterPerSquareAmperePerSquareSecond }

resourcestring
  rsKilogramSquareMeterPerSquareAmperePerSquareSecondSymbol = '%sg∙%sm²/%sA²/%ss²';
  rsKilogramSquareMeterPerSquareAmperePerSquareSecondName = '%sgram square %smeter per square %sampere per square %ssecond';
  rsKilogramSquareMeterPerSquareAmperePerSquareSecondPluralName = '%sgram square %smeters per square %sampere per square %ssecond';

const
  KilogramSquareMeterPerSquareAmperePerSquareSecondUnit : TUnit = (
    FID         : HenryID;
    FSymbol     : rsKilogramSquareMeterPerSquareAmperePerSquareSecondSymbol;
    FName       : rsKilogramSquareMeterPerSquareAmperePerSquareSecondName;
    FPluralName : rsKilogramSquareMeterPerSquareAmperePerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (1, 2, -2, -2));

{ TReciprocalHenry }

resourcestring
  rsReciprocalHenrySymbol = '1/%sH';
  rsReciprocalHenryName = 'reciprocal %shenry';
  rsReciprocalHenryPluralName = 'reciprocal %shenries';

const
  ReciprocalHenryID = 29700;
  ReciprocalHenryUnit : TUnit = (
    FID         : ReciprocalHenryID;
    FSymbol     : rsReciprocalHenrySymbol;
    FName       : rsReciprocalHenryName;
    FPluralName : rsReciprocalHenryPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TLumen }

resourcestring
  rsLumenSymbol = '%slm';
  rsLumenName = '%slumen';
  rsLumenPluralName = '%slumens';

const
  LumenID = 77820;
  LumenUnit : TUnit = (
    FID         : LumenID;
    FSymbol     : rsLumenSymbol;
    FName       : rsLumenName;
    FPluralName : rsLumenPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  lm : TUnit absolute LumenUnit;

{ TCandelaSteradian }

resourcestring
  rsCandelaSteradianSymbol = '%scd∙%ssr';
  rsCandelaSteradianName = '%scandela %ssteradian';
  rsCandelaSteradianPluralName = '%scandela %ssteradians';

const
  CandelaSteradianUnit : TUnit = (
    FID         : LumenID;
    FSymbol     : rsCandelaSteradianSymbol;
    FName       : rsCandelaSteradianName;
    FPluralName : rsCandelaSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TLumenSecond }

resourcestring
  rsLumenSecondSymbol = '%slm∙%ss';
  rsLumenSecondName = '%slumen %ssecond';
  rsLumenSecondPluralName = '%slumen %sseconds';

const
  LumenSecondID = 112680;
  LumenSecondUnit : TUnit = (
    FID         : LumenSecondID;
    FSymbol     : rsLumenSecondSymbol;
    FName       : rsLumenSecondName;
    FPluralName : rsLumenSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TLumenSecondPerCubicMeter }

resourcestring
  rsLumenSecondPerCubicMeterSymbol = '%slm∙%ss/%sm³';
  rsLumenSecondPerCubicMeterName = '%slumen %ssecond per cubic meter';
  rsLumenSecondPerCubicMeterPluralName = '%slumen %sseconds per cubic meter';

const
  LumenSecondPerCubicMeterID = -6660;
  LumenSecondPerCubicMeterUnit : TUnit = (
    FID         : LumenSecondPerCubicMeterID;
    FSymbol     : rsLumenSecondPerCubicMeterSymbol;
    FName       : rsLumenSecondPerCubicMeterName;
    FPluralName : rsLumenSecondPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -3));

{ TLux }

resourcestring
  rsLuxSymbol = '%slx';
  rsLuxName = '%slux';
  rsLuxPluralName = '%slux';

const
  LuxID = -1740;
  LuxUnit : TUnit = (
    FID         : LuxID;
    FSymbol     : rsLuxSymbol;
    FName       : rsLuxName;
    FPluralName : rsLuxPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  lx : TUnit absolute LuxUnit;

{ TCandelaSteradianPerSquareMeter }

resourcestring
  rsCandelaSteradianPerSquareMeterSymbol = '%scd∙%ssr/%sm²';
  rsCandelaSteradianPerSquareMeterName = '%scandela %ssteradian per square %smeter';
  rsCandelaSteradianPerSquareMeterPluralName = '%scandela %ssteradians per square %smeter';

const
  CandelaSteradianPerSquareMeterUnit : TUnit = (
    FID         : LuxID;
    FSymbol     : rsCandelaSteradianPerSquareMeterSymbol;
    FName       : rsCandelaSteradianPerSquareMeterName;
    FPluralName : rsCandelaSteradianPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -2));

{ TLuxSecond }

resourcestring
  rsLuxSecondSymbol = '%slx∙%ss';
  rsLuxSecondName = '%slux %ssecond';
  rsLuxSecondPluralName = '%slux %sseconds';

const
  LuxSecondID = 33120;
  LuxSecondUnit : TUnit = (
    FID         : LuxSecondID;
    FSymbol     : rsLuxSecondSymbol;
    FName       : rsLuxSecondName;
    FPluralName : rsLuxSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TBequerel }

resourcestring
  rsBequerelSymbol = '%sBq';
  rsBequerelName = '%sbequerel';
  rsBequerelPluralName = '%sbequerels';

const
  BequerelUnit : TUnit = (
    FID         : HertzID;
    FSymbol     : rsBequerelSymbol;
    FName       : rsBequerelName;
    FPluralName : rsBequerelPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  Bq : TUnit absolute BequerelUnit;

const
  kBq        : TQuantity = {$IFNDEF ADIMOFF} (FID: HertzID; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mBq        : TQuantity = {$IFNDEF ADIMOFF} (FID: HertzID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miBq       : TQuantity = {$IFNDEF ADIMOFF} (FID: HertzID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nBq        : TQuantity = {$IFNDEF ADIMOFF} (FID: HertzID; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pBq        : TQuantity = {$IFNDEF ADIMOFF} (FID: HertzID; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TKatal }

resourcestring
  rsKatalSymbol = '%skat';
  rsKatalName = '%skatal';
  rsKatalPluralName = '%skatals';

const
  KatalID = -180;
  KatalUnit : TUnit = (
    FID         : KatalID;
    FSymbol     : rsKatalSymbol;
    FName       : rsKatalName;
    FPluralName : rsKatalPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  kat : TUnit absolute KatalUnit;

{ TMolePerSecond }

resourcestring
  rsMolePerSecondSymbol = '%smol/%ss';
  rsMolePerSecondName = '%smole per %ssecond';
  rsMolePerSecondPluralName = '%smoles per %ssecond';

const
  MolePerSecondUnit : TUnit = (
    FID         : KatalID;
    FSymbol     : rsMolePerSecondSymbol;
    FName       : rsMolePerSecondName;
    FPluralName : rsMolePerSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TNewtonPerCubicMeter }

resourcestring
  rsNewtonPerCubicMeterSymbol = '%sN/%sm³';
  rsNewtonPerCubicMeterName = '%snewton per cubic %smeter';
  rsNewtonPerCubicMeterPluralName = '%snewtons per cubic %smeter';

const
  NewtonPerCubicMeterID = -140220;
  NewtonPerCubicMeterUnit : TUnit = (
    FID         : NewtonPerCubicMeterID;
    FSymbol     : rsNewtonPerCubicMeterSymbol;
    FName       : rsNewtonPerCubicMeterName;
    FPluralName : rsNewtonPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TPascalPerMeter }

resourcestring
  rsPascalPerMeterSymbol = '%sPa/%sm';
  rsPascalPerMeterName = '%spascal per %smeter';
  rsPascalPerMeterPluralName = '%spascals per %smeter';

const
  PascalPerMeterUnit : TUnit = (
    FID         : NewtonPerCubicMeterID;
    FSymbol     : rsPascalPerMeterSymbol;
    FName       : rsPascalPerMeterName;
    FPluralName : rsPascalPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TKilogramPerSquareMeterPerSquareSecond }

resourcestring
  rsKilogramPerSquareMeterPerSquareSecondSymbol = '%sg/%sm²/%ss²';
  rsKilogramPerSquareMeterPerSquareSecondName = '%sgram per square %smeter per square %ssecond';
  rsKilogramPerSquareMeterPerSquareSecondPluralName = '%sgrams per square %smeter per square %ssecond';

const
  KilogramPerSquareMeterPerSquareSecondUnit : TUnit = (
    FID         : NewtonPerCubicMeterID;
    FSymbol     : rsKilogramPerSquareMeterPerSquareSecondSymbol;
    FName       : rsKilogramPerSquareMeterPerSquareSecondName;
    FPluralName : rsKilogramPerSquareMeterPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, -2, -2));

{ TNewtonPerMeter }

resourcestring
  rsNewtonPerMeterSymbol = '%sN/%sm';
  rsNewtonPerMeterName = '%snewton per %smeter';
  rsNewtonPerMeterPluralName = '%snewtons per %smeter';

const
  NewtonPerMeterID = -60660;
  NewtonPerMeterUnit : TUnit = (
    FID         : NewtonPerMeterID;
    FSymbol     : rsNewtonPerMeterSymbol;
    FName       : rsNewtonPerMeterName;
    FPluralName : rsNewtonPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TJoulePerSquareMeter }

resourcestring
  rsJoulePerSquareMeterSymbol = '%sJ/%sm²';
  rsJoulePerSquareMeterName = '%sjoule per square %smeter';
  rsJoulePerSquareMeterPluralName = '%sjoules per square %smeter';

const
  JoulePerSquareMeterUnit : TUnit = (
    FID         : NewtonPerMeterID;
    FSymbol     : rsJoulePerSquareMeterSymbol;
    FName       : rsJoulePerSquareMeterName;
    FPluralName : rsJoulePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TWattPerSquareMeterPerHertz }

resourcestring
  rsWattPerSquareMeterPerHertzSymbol = '%sW/%sm²/%sHz';
  rsWattPerSquareMeterPerHertzName = '%swatt per square %smeter per %shertz';
  rsWattPerSquareMeterPerHertzPluralName = '%swatts per square %smeter per %shertz';

const
  WattPerSquareMeterPerHertzUnit : TUnit = (
    FID         : NewtonPerMeterID;
    FSymbol     : rsWattPerSquareMeterPerHertzSymbol;
    FName       : rsWattPerSquareMeterPerHertzName;
    FPluralName : rsWattPerSquareMeterPerHertzPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -1));

{ TPoundForcePerInch }

resourcestring
  rsPoundForcePerInchSymbol = 'lbf/in';
  rsPoundForcePerInchName = 'pound-force per inch';
  rsPoundForcePerInchPluralName = 'pounds-force per inch';

const
  PoundForcePerInchUnit : TFactoredUnit = (
    FID         : NewtonPerMeterID;
    FSymbol     : rsPoundForcePerInchSymbol;
    FName       : rsPoundForcePerInchName;
    FPluralName : rsPoundForcePerInchPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (175.126835246476));

{ TKilogramPerSquareSecond }

resourcestring
  rsKilogramPerSquareSecondSymbol = '%sg/%ss²';
  rsKilogramPerSquareSecondName = '%sgram per square %ssecond';
  rsKilogramPerSquareSecondPluralName = '%sgrams per square %ssecond';

const
  KilogramPerSquareSecondUnit : TUnit = (
    FID         : NewtonPerMeterID;
    FSymbol     : rsKilogramPerSquareSecondSymbol;
    FName       : rsKilogramPerSquareSecondName;
    FPluralName : rsKilogramPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, -2));

{ TCubicMeterPerSecond }

resourcestring
  rsCubicMeterPerSecondSymbol = '%sm³/%ss';
  rsCubicMeterPerSecondName = 'cubic %smeter per %ssecond';
  rsCubicMeterPerSecondPluralName = 'cubic %smeters per %ssecond';

const
  CubicMeterPerSecondID = 84480;
  CubicMeterPerSecondUnit : TUnit = (
    FID         : CubicMeterPerSecondID;
    FSymbol     : rsCubicMeterPerSecondSymbol;
    FName       : rsCubicMeterPerSecondName;
    FPluralName : rsCubicMeterPerSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TPoiseuille }

resourcestring
  rsPoiseuilleSymbol = '%sPl';
  rsPoiseuilleName = '%spoiseuille';
  rsPoiseuillePluralName = '%spoiseuilles';

const
  PoiseuilleID = -65580;
  PoiseuilleUnit : TUnit = (
    FID         : PoiseuilleID;
    FSymbol     : rsPoiseuilleSymbol;
    FName       : rsPoiseuilleName;
    FPluralName : rsPoiseuillePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  Pl : TUnit absolute PoiseuilleUnit;

const
  cPl        : TQuantity = {$IFNDEF ADIMOFF} (FID: PoiseuilleID; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mPl        : TQuantity = {$IFNDEF ADIMOFF} (FID: PoiseuilleID; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miPl       : TQuantity = {$IFNDEF ADIMOFF} (FID: PoiseuilleID; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}

{ TPascalSecond }

resourcestring
  rsPascalSecondSymbol = '%sPa∙%ss';
  rsPascalSecondName = '%spascal %ssecond';
  rsPascalSecondPluralName = '%spascal %sseconds';

const
  PascalSecondUnit : TUnit = (
    FID         : PoiseuilleID;
    FSymbol     : rsPascalSecondSymbol;
    FName       : rsPascalSecondName;
    FPluralName : rsPascalSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TKilogramPerMeterPerSecond }

resourcestring
  rsKilogramPerMeterPerSecondSymbol = '%sg/%sm/%ss';
  rsKilogramPerMeterPerSecondName = '%sgram per %smeter per %ssecond';
  rsKilogramPerMeterPerSecondPluralName = '%sgrams per %smeter per %ssecond';

const
  KilogramPerMeterPerSecondUnit : TUnit = (
    FID         : PoiseuilleID;
    FSymbol     : rsKilogramPerMeterPerSecondSymbol;
    FName       : rsKilogramPerMeterPerSecondName;
    FPluralName : rsKilogramPerMeterPerSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TSquareMeterPerSecond }

resourcestring
  rsSquareMeterPerSecondSymbol = '%sm²/%ss';
  rsSquareMeterPerSecondName = 'square %smeter per %ssecond';
  rsSquareMeterPerSecondPluralName = 'square %smeters per %ssecond';

const
  SquareMeterPerSecondID = 44700;
  SquareMeterPerSecondUnit : TUnit = (
    FID         : SquareMeterPerSecondID;
    FSymbol     : rsSquareMeterPerSecondSymbol;
    FName       : rsSquareMeterPerSecondName;
    FPluralName : rsSquareMeterPerSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TKilogramPerQuarticMeter }

resourcestring
  rsKilogramPerQuarticMeterSymbol = '%sg/%sm⁴';
  rsKilogramPerQuarticMeterName = '%sgram per quartic %smeter';
  rsKilogramPerQuarticMeterPluralName = '%sgrams per quartic %smeter';

const
  KilogramPerQuarticMeterID = -150060;
  KilogramPerQuarticMeterUnit : TUnit = (
    FID         : KilogramPerQuarticMeterID;
    FSymbol     : rsKilogramPerQuarticMeterSymbol;
    FName       : rsKilogramPerQuarticMeterName;
    FPluralName : rsKilogramPerQuarticMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, -4));

{ TQuarticMeterSecond }

resourcestring
  rsQuarticMeterSecondSymbol = '%sm⁴∙%ss';
  rsQuarticMeterSecondName = 'quartic %smeter %ssecond';
  rsQuarticMeterSecondPluralName = 'quartic %smeter %sseconds';

const
  QuarticMeterSecondID = 193980;
  QuarticMeterSecondUnit : TUnit = (
    FID         : QuarticMeterSecondID;
    FSymbol     : rsQuarticMeterSecondSymbol;
    FName       : rsQuarticMeterSecondName;
    FPluralName : rsQuarticMeterSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, 1));

{ TKilogramPerQuarticMeterPerSecond }

resourcestring
  rsKilogramPerQuarticMeterPerSecondSymbol = '%sg/%sm⁴/%ss';
  rsKilogramPerQuarticMeterPerSecondName = '%sgram per quartic %smeter per %ssecond';
  rsKilogramPerQuarticMeterPerSecondPluralName = '%sgrams per quartic %smeter per %ssecond';

const
  KilogramPerQuarticMeterPerSecondID = -184920;
  KilogramPerQuarticMeterPerSecondUnit : TUnit = (
    FID         : KilogramPerQuarticMeterPerSecondID;
    FSymbol     : rsKilogramPerQuarticMeterPerSecondSymbol;
    FName       : rsKilogramPerQuarticMeterPerSecondName;
    FPluralName : rsKilogramPerQuarticMeterPerSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, -4, -1));

{ TCubicMeterPerKilogram }

resourcestring
  rsCubicMeterPerKilogramSymbol = '%sm³/%sg';
  rsCubicMeterPerKilogramName = 'cubic %smeter per %sgram';
  rsCubicMeterPerKilogramPluralName = 'cubic %smeters per %sgram';

const
  CubicMeterPerKilogramID = 110280;
  CubicMeterPerKilogramUnit : TUnit = (
    FID         : CubicMeterPerKilogramID;
    FSymbol     : rsCubicMeterPerKilogramSymbol;
    FName       : rsCubicMeterPerKilogramName;
    FPluralName : rsCubicMeterPerKilogramPluralName;
    FPrefixes   : (pNone, pKilo);
    FExponents  : (3, -1));

{ TKilogramSquareSecond }

resourcestring
  rsKilogramSquareSecondSymbol = '%sg∙%ss²';
  rsKilogramSquareSecondName = '%sgram square %ssecond';
  rsKilogramSquareSecondPluralName = '%sgram square %sseconds';

const
  KilogramSquareSecondID = 78780;
  KilogramSquareSecondUnit : TUnit = (
    FID         : KilogramSquareSecondID;
    FSymbol     : rsKilogramSquareSecondSymbol;
    FName       : rsKilogramSquareSecondName;
    FPluralName : rsKilogramSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, 2));

{ TCubicMeterPerSquareSecond }

resourcestring
  rsCubicMeterPerSquareSecondSymbol = '%sm³/%ss²';
  rsCubicMeterPerSquareSecondName = 'cubic %smeter per square %ssecond';
  rsCubicMeterPerSquareSecondPluralName = 'cubic %smeters per square %ssecond';

const
  CubicMeterPerSquareSecondID = 49620;
  CubicMeterPerSquareSecondUnit : TUnit = (
    FID         : CubicMeterPerSquareSecondID;
    FSymbol     : rsCubicMeterPerSquareSecondSymbol;
    FName       : rsCubicMeterPerSquareSecondName;
    FPluralName : rsCubicMeterPerSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -2));

{ TNewtonSquareMeter }

resourcestring
  rsNewtonSquareMeterSymbol = '%sN∙%sm²';
  rsNewtonSquareMeterName = '%snewton square %smeter';
  rsNewtonSquareMeterPluralName = '%snewton square %smeters';

const
  NewtonSquareMeterID = 58680;
  NewtonSquareMeterUnit : TUnit = (
    FID         : NewtonSquareMeterID;
    FSymbol     : rsNewtonSquareMeterSymbol;
    FName       : rsNewtonSquareMeterName;
    FPluralName : rsNewtonSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 2));

{ TKilogramCubicMeterPerSquareSecond }

resourcestring
  rsKilogramCubicMeterPerSquareSecondSymbol = '%sg∙%sm³/%ss²';
  rsKilogramCubicMeterPerSquareSecondName = '%sgram cubic %smeter per square %ssecond';
  rsKilogramCubicMeterPerSquareSecondPluralName = '%sgram cubic %smeters per square %ssecond';

const
  KilogramCubicMeterPerSquareSecondUnit : TUnit = (
    FID         : NewtonSquareMeterID;
    FSymbol     : rsKilogramCubicMeterPerSquareSecondSymbol;
    FName       : rsKilogramCubicMeterPerSquareSecondName;
    FPluralName : rsKilogramCubicMeterPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 3, -2));

{ TNewtonCubicMeter }

resourcestring
  rsNewtonCubicMeterSymbol = '%sN∙%sm³';
  rsNewtonCubicMeterName = '%snewton cubic %smeter';
  rsNewtonCubicMeterPluralName = '%snewton cubic %smeters';

const
  NewtonCubicMeterID = 98460;
  NewtonCubicMeterUnit : TUnit = (
    FID         : NewtonCubicMeterID;
    FSymbol     : rsNewtonCubicMeterSymbol;
    FName       : rsNewtonCubicMeterName;
    FPluralName : rsNewtonCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 3));

{ TKilogramQuarticMeterPerSquareSecond }

resourcestring
  rsKilogramQuarticMeterPerSquareSecondSymbol = '%sg∙%sm⁴/%ss²';
  rsKilogramQuarticMeterPerSquareSecondName = '%sgram quartic %smeter per square %ssecond';
  rsKilogramQuarticMeterPerSquareSecondPluralName = '%sgram quartic %smeters per square %ssecond';

const
  KilogramQuarticMeterPerSquareSecondUnit : TUnit = (
    FID         : NewtonCubicMeterID;
    FSymbol     : rsKilogramQuarticMeterPerSquareSecondSymbol;
    FName       : rsKilogramQuarticMeterPerSquareSecondName;
    FPluralName : rsKilogramQuarticMeterPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 4, -2));

{ TNewtonPerSquareKilogram }

resourcestring
  rsNewtonPerSquareKilogramSymbol = '%sN/%sg²';
  rsNewtonPerSquareKilogramName = '%snewton per square %sgram';
  rsNewtonPerSquareKilogramPluralName = '%snewtons per square %sgram';

const
  NewtonPerSquareKilogramID = -39000;
  NewtonPerSquareKilogramUnit : TUnit = (
    FID         : NewtonPerSquareKilogramID;
    FSymbol     : rsNewtonPerSquareKilogramSymbol;
    FName       : rsNewtonPerSquareKilogramName;
    FPluralName : rsNewtonPerSquareKilogramPluralName;
    FPrefixes   : (pNone, pKilo);
    FExponents  : (1, -2));

{ TMeterPerKilogramPerSquareSecond }

resourcestring
  rsMeterPerKilogramPerSquareSecondSymbol = '%sm/%sg/%ss²';
  rsMeterPerKilogramPerSquareSecondName = '%smeter per %sgram per square %ssecond';
  rsMeterPerKilogramPerSquareSecondPluralName = '%smeters per %sgram per square %ssecond';

const
  MeterPerKilogramPerSquareSecondUnit : TUnit = (
    FID         : NewtonPerSquareKilogramID;
    FSymbol     : rsMeterPerKilogramPerSquareSecondSymbol;
    FName       : rsMeterPerKilogramPerSquareSecondName;
    FPluralName : rsMeterPerKilogramPerSquareSecondPluralName;
    FPrefixes   : (pNone, pKilo, pNone);
    FExponents  : (1, -1, -2));

{ TSquareKilogramPerMeter }

resourcestring
  rsSquareKilogramPerMeterSymbol = '%sg²/%sm';
  rsSquareKilogramPerMeterName = 'square %sgram per %smeter';
  rsSquareKilogramPerMeterPluralName = 'square %sgrams per %smeter';

const
  SquareKilogramPerMeterID = -21660;
  SquareKilogramPerMeterUnit : TUnit = (
    FID         : SquareKilogramPerMeterID;
    FSymbol     : rsSquareKilogramPerMeterSymbol;
    FName       : rsSquareKilogramPerMeterName;
    FPluralName : rsSquareKilogramPerMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (2, -1));

{ TSquareKilogramPerSquareMeter }

resourcestring
  rsSquareKilogramPerSquareMeterSymbol = '%sg²/%sm²';
  rsSquareKilogramPerSquareMeterName = 'square %sgram per square %smeter';
  rsSquareKilogramPerSquareMeterPluralName = 'square %sgrams per square %smeter';

const
  SquareKilogramPerSquareMeterID = -61440;
  SquareKilogramPerSquareMeterUnit : TUnit = (
    FID         : SquareKilogramPerSquareMeterID;
    FSymbol     : rsSquareKilogramPerSquareMeterSymbol;
    FName       : rsSquareKilogramPerSquareMeterName;
    FPluralName : rsSquareKilogramPerSquareMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (2, -2));

{ TSquareMeterPerSquareKilogram }

resourcestring
  rsSquareMeterPerSquareKilogramSymbol = '%sm²/%sg²';
  rsSquareMeterPerSquareKilogramName = 'square %smeter per square %sgram';
  rsSquareMeterPerSquareKilogramPluralName = 'square %smeters per square %sgram';

const
  SquareMeterPerSquareKilogramID = 61440;
  SquareMeterPerSquareKilogramUnit : TUnit = (
    FID         : SquareMeterPerSquareKilogramID;
    FSymbol     : rsSquareMeterPerSquareKilogramSymbol;
    FName       : rsSquareMeterPerSquareKilogramName;
    FPluralName : rsSquareMeterPerSquareKilogramPluralName;
    FPrefixes   : (pNone, pKilo);
    FExponents  : (2, -2));

{ TNewtonSquareMeterPerSquareKilogram }

resourcestring
  rsNewtonSquareMeterPerSquareKilogramSymbol = '%sN∙%sm²/%sg²';
  rsNewtonSquareMeterPerSquareKilogramName = '%snewton square %smeter per square %sgram';
  rsNewtonSquareMeterPerSquareKilogramPluralName = '%snewton square %smeters per square %sgram';

const
  NewtonSquareMeterPerSquareKilogramID = 40560;
  NewtonSquareMeterPerSquareKilogramUnit : TUnit = (
    FID         : NewtonSquareMeterPerSquareKilogramID;
    FSymbol     : rsNewtonSquareMeterPerSquareKilogramSymbol;
    FName       : rsNewtonSquareMeterPerSquareKilogramName;
    FPluralName : rsNewtonSquareMeterPerSquareKilogramPluralName;
    FPrefixes   : (pNone, pNone, pKilo);
    FExponents  : (1, 2, -2));

{ TCubicMeterPerKilogramPerSquareSecond }

resourcestring
  rsCubicMeterPerKilogramPerSquareSecondSymbol = '%sm³/%sg/%ss²';
  rsCubicMeterPerKilogramPerSquareSecondName = 'cubic %smeter per %sgram per square %ssecond';
  rsCubicMeterPerKilogramPerSquareSecondPluralName = 'cubic %smeters per %sgram per square %ssecond';

const
  CubicMeterPerKilogramPerSquareSecondUnit : TUnit = (
    FID         : NewtonSquareMeterPerSquareKilogramID;
    FSymbol     : rsCubicMeterPerKilogramPerSquareSecondSymbol;
    FName       : rsCubicMeterPerKilogramPerSquareSecondName;
    FPluralName : rsCubicMeterPerKilogramPerSquareSecondPluralName;
    FPrefixes   : (pNone, pKilo, pNone);
    FExponents  : (3, -1, -2));

{ TReciprocalKelvin }

resourcestring
  rsReciprocalKelvinSymbol = '1/%sK';
  rsReciprocalKelvinName = 'reciprocal %skelvin';
  rsReciprocalKelvinPluralName = 'reciprocal %skelvin';

const
  ReciprocalKelvinID = -19020;
  ReciprocalKelvinUnit : TUnit = (
    FID         : ReciprocalKelvinID;
    FSymbol     : rsReciprocalKelvinSymbol;
    FName       : rsReciprocalKelvinName;
    FPluralName : rsReciprocalKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TKilogramKelvin }

resourcestring
  rsKilogramKelvinSymbol = '%sg∙%sK';
  rsKilogramKelvinName = '%sgram %skelvin';
  rsKilogramKelvinPluralName = '%sgram %skelvins';

const
  KilogramKelvinID = 28080;
  KilogramKelvinUnit : TUnit = (
    FID         : KilogramKelvinID;
    FSymbol     : rsKilogramKelvinSymbol;
    FName       : rsKilogramKelvinName;
    FPluralName : rsKilogramKelvinPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, 1));

{ TJoulePerKelvin }

resourcestring
  rsJoulePerKelvinSymbol = '%sJ/%sK';
  rsJoulePerKelvinName = '%sjoule per %skelvin';
  rsJoulePerKelvinPluralName = '%sjoules per %skelvin';

const
  JoulePerKelvinID = -120;
  JoulePerKelvinUnit : TUnit = (
    FID         : JoulePerKelvinID;
    FSymbol     : rsJoulePerKelvinSymbol;
    FName       : rsJoulePerKelvinName;
    FPluralName : rsJoulePerKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TKilogramSquareMeterPerSquareSecondPerKelvin }

resourcestring
  rsKilogramSquareMeterPerSquareSecondPerKelvinSymbol = '%sg∙%sm²/%ss²/%sK';
  rsKilogramSquareMeterPerSquareSecondPerKelvinName = '%sgram square %smeter per square %ssecond per %skelvin';
  rsKilogramSquareMeterPerSquareSecondPerKelvinPluralName = '%sgram square %smeters per square %ssecond per %skelvin';

const
  KilogramSquareMeterPerSquareSecondPerKelvinUnit : TUnit = (
    FID         : JoulePerKelvinID;
    FSymbol     : rsKilogramSquareMeterPerSquareSecondPerKelvinSymbol;
    FName       : rsKilogramSquareMeterPerSquareSecondPerKelvinName;
    FPluralName : rsKilogramSquareMeterPerSquareSecondPerKelvinPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (1, 2, -2, -1));

{ TJoulePerKilogramPerKelvin }

resourcestring
  rsJoulePerKilogramPerKelvinSymbol = '%sJ/%sg/%sK';
  rsJoulePerKilogramPerKelvinName = '%sjoule per %sgram per %skelvin';
  rsJoulePerKilogramPerKelvinPluralName = '%sjoules per %sgram per %skelvin';

const
  JoulePerKilogramPerKelvinID = -9180;
  JoulePerKilogramPerKelvinUnit : TUnit = (
    FID         : JoulePerKilogramPerKelvinID;
    FSymbol     : rsJoulePerKilogramPerKelvinSymbol;
    FName       : rsJoulePerKilogramPerKelvinName;
    FPluralName : rsJoulePerKilogramPerKelvinPluralName;
    FPrefixes   : (pNone, pKilo, pNone);
    FExponents  : (1, -1, -1));

{ TSquareMeterPerSquareSecondPerKelvin }

resourcestring
  rsSquareMeterPerSquareSecondPerKelvinSymbol = '%sm²/%ss²/%sK';
  rsSquareMeterPerSquareSecondPerKelvinName = 'square %smeter per square %ssecond per %skelvin';
  rsSquareMeterPerSquareSecondPerKelvinPluralName = 'square %smeters per square %ssecond per %skelvin';

const
  SquareMeterPerSquareSecondPerKelvinUnit : TUnit = (
    FID         : JoulePerKilogramPerKelvinID;
    FSymbol     : rsSquareMeterPerSquareSecondPerKelvinSymbol;
    FName       : rsSquareMeterPerSquareSecondPerKelvinName;
    FPluralName : rsSquareMeterPerSquareSecondPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -2, -1));

{ TMeterKelvin }

resourcestring
  rsMeterKelvinSymbol = '%sm∙%sK';
  rsMeterKelvinName = '%smeter %skelvin';
  rsMeterKelvinPluralName = '%smeter %skelvins';

const
  MeterKelvinID = 58800;
  MeterKelvinUnit : TUnit = (
    FID         : MeterKelvinID;
    FSymbol     : rsMeterKelvinSymbol;
    FName       : rsMeterKelvinName;
    FPluralName : rsMeterKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TKelvinPerMeter }

resourcestring
  rsKelvinPerMeterSymbol = '%sK/%sm';
  rsKelvinPerMeterName = '%skelvin per %smeter';
  rsKelvinPerMeterPluralName = '%skelvins per %smeter';

const
  KelvinPerMeterID = -20760;
  KelvinPerMeterUnit : TUnit = (
    FID         : KelvinPerMeterID;
    FSymbol     : rsKelvinPerMeterSymbol;
    FName       : rsKelvinPerMeterName;
    FPluralName : rsKelvinPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TWattPerMeter }

resourcestring
  rsWattPerMeterSymbol = '%sW/%sm';
  rsWattPerMeterName = '%swatt per %smeter';
  rsWattPerMeterPluralName = '%swatts per %smeter';

const
  WattPerMeterID = -55740;
  WattPerMeterUnit : TUnit = (
    FID         : WattPerMeterID;
    FSymbol     : rsWattPerMeterSymbol;
    FName       : rsWattPerMeterName;
    FPluralName : rsWattPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TKilogramMeterPerCubicSecond }

resourcestring
  rsKilogramMeterPerCubicSecondSymbol = '%sg∙%sm/%ss³';
  rsKilogramMeterPerCubicSecondName = '%sgram %smeter per cubic %ssecond';
  rsKilogramMeterPerCubicSecondPluralName = '%sgram %smeters per cubic %ssecond';

const
  KilogramMeterPerCubicSecondUnit : TUnit = (
    FID         : WattPerMeterID;
    FSymbol     : rsKilogramMeterPerCubicSecondSymbol;
    FName       : rsKilogramMeterPerCubicSecondName;
    FPluralName : rsKilogramMeterPerCubicSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 1, -3));

{ TWattPerSquareMeter }

resourcestring
  rsWattPerSquareMeterSymbol = '%sW/%sm²';
  rsWattPerSquareMeterName = '%swatt per square %smeter';
  rsWattPerSquareMeterPluralName = '%swatts per square %smeter';

const
  WattPerSquareMeterID = -95520;
  WattPerSquareMeterUnit : TUnit = (
    FID         : WattPerSquareMeterID;
    FSymbol     : rsWattPerSquareMeterSymbol;
    FName       : rsWattPerSquareMeterName;
    FPluralName : rsWattPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TKilogramPerCubicSecond }

resourcestring
  rsKilogramPerCubicSecondSymbol = '%sg/%ss³';
  rsKilogramPerCubicSecondName = '%sgram per cubic %ssecond';
  rsKilogramPerCubicSecondPluralName = '%sgrams per cubic %ssecond';

const
  KilogramPerCubicSecondUnit : TUnit = (
    FID         : WattPerSquareMeterID;
    FSymbol     : rsKilogramPerCubicSecondSymbol;
    FName       : rsKilogramPerCubicSecondName;
    FPluralName : rsKilogramPerCubicSecondPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, -3));

{ TWattPerCubicMeter }

resourcestring
  rsWattPerCubicMeterSymbol = '%sW/%sm³';
  rsWattPerCubicMeterName = '%swatt per cubic %smeter';
  rsWattPerCubicMeterPluralName = '%swatts per cubic %smeter';

const
  WattPerCubicMeterID = -135300;
  WattPerCubicMeterUnit : TUnit = (
    FID         : WattPerCubicMeterID;
    FSymbol     : rsWattPerCubicMeterSymbol;
    FName       : rsWattPerCubicMeterName;
    FPluralName : rsWattPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TWattPerKelvin }

resourcestring
  rsWattPerKelvinSymbol = '%sW/%sK';
  rsWattPerKelvinName = '%swatt per %skelvin';
  rsWattPerKelvinPluralName = '%swatts per %skelvin';

const
  WattPerKelvinID = -34980;
  WattPerKelvinUnit : TUnit = (
    FID         : WattPerKelvinID;
    FSymbol     : rsWattPerKelvinSymbol;
    FName       : rsWattPerKelvinName;
    FPluralName : rsWattPerKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TKilogramSquareMeterPerCubicSecondPerKelvin }

resourcestring
  rsKilogramSquareMeterPerCubicSecondPerKelvinSymbol = '%sg∙%sm²/%ss³/%sK';
  rsKilogramSquareMeterPerCubicSecondPerKelvinName = '%sgram square %smeter per cubic %ssecond per %skelvin';
  rsKilogramSquareMeterPerCubicSecondPerKelvinPluralName = '%sgram square %smeters per cubic %ssecond per %skelvin';

const
  KilogramSquareMeterPerCubicSecondPerKelvinUnit : TUnit = (
    FID         : WattPerKelvinID;
    FSymbol     : rsKilogramSquareMeterPerCubicSecondPerKelvinSymbol;
    FName       : rsKilogramSquareMeterPerCubicSecondPerKelvinName;
    FPluralName : rsKilogramSquareMeterPerCubicSecondPerKelvinPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (1, 2, -3, -1));

{ TWattPerMeterPerKelvin }

resourcestring
  rsWattPerMeterPerKelvinSymbol = '%sW/%sm/%sK';
  rsWattPerMeterPerKelvinName = '%swatt per %smeter per %skelvin';
  rsWattPerMeterPerKelvinPluralName = '%swatts per %smeter per %skelvin';

const
  WattPerMeterPerKelvinID = -74760;
  WattPerMeterPerKelvinUnit : TUnit = (
    FID         : WattPerMeterPerKelvinID;
    FSymbol     : rsWattPerMeterPerKelvinSymbol;
    FName       : rsWattPerMeterPerKelvinName;
    FPluralName : rsWattPerMeterPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TKilogramMeterPerCubicSecondPerKelvin }

resourcestring
  rsKilogramMeterPerCubicSecondPerKelvinSymbol = '%sg∙%sm/%ss³/%sK';
  rsKilogramMeterPerCubicSecondPerKelvinName = '%sgram %smeter per cubic %ssecond per %skelvin';
  rsKilogramMeterPerCubicSecondPerKelvinPluralName = '%sgram %smeters per cubic %ssecond per %skelvin';

const
  KilogramMeterPerCubicSecondPerKelvinUnit : TUnit = (
    FID         : WattPerMeterPerKelvinID;
    FSymbol     : rsKilogramMeterPerCubicSecondPerKelvinSymbol;
    FName       : rsKilogramMeterPerCubicSecondPerKelvinName;
    FPluralName : rsKilogramMeterPerCubicSecondPerKelvinPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (1, 1, -3, -1));

{ TKelvinPerWatt }

resourcestring
  rsKelvinPerWattSymbol = '%sK/%sW';
  rsKelvinPerWattName = '%skelvin per %swatt';
  rsKelvinPerWattPluralName = '%skelvins per %swatt';

const
  KelvinPerWattID = 34980;
  KelvinPerWattUnit : TUnit = (
    FID         : KelvinPerWattID;
    FSymbol     : rsKelvinPerWattSymbol;
    FName       : rsKelvinPerWattName;
    FPluralName : rsKelvinPerWattPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TMeterPerWatt }

resourcestring
  rsMeterPerWattSymbol = '%sm/%sW';
  rsMeterPerWattName = '%smeter per %swatt';
  rsMeterPerWattPluralName = '%smeters per %swatts';

const
  MeterPerWattID = 55740;
  MeterPerWattUnit : TUnit = (
    FID         : MeterPerWattID;
    FSymbol     : rsMeterPerWattSymbol;
    FName       : rsMeterPerWattName;
    FPluralName : rsMeterPerWattPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TMeterKelvinPerWatt }

resourcestring
  rsMeterKelvinPerWattSymbol = '%sK∙%sm/%sW';
  rsMeterKelvinPerWattName = '%skelvin %smeter per %swatt';
  rsMeterKelvinPerWattPluralName = '%skelvin %smeters per %swatt';

const
  MeterKelvinPerWattID = 74760;
  MeterKelvinPerWattUnit : TUnit = (
    FID         : MeterKelvinPerWattID;
    FSymbol     : rsMeterKelvinPerWattSymbol;
    FName       : rsMeterKelvinPerWattName;
    FPluralName : rsMeterKelvinPerWattPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TSquareMeterKelvin }

resourcestring
  rsSquareMeterKelvinSymbol = '%sm²∙%sK';
  rsSquareMeterKelvinName = 'square %smeter %skelvin';
  rsSquareMeterKelvinPluralName = 'square %smeter %skelvins';

const
  SquareMeterKelvinID = 98580;
  SquareMeterKelvinUnit : TUnit = (
    FID         : SquareMeterKelvinID;
    FSymbol     : rsSquareMeterKelvinSymbol;
    FName       : rsSquareMeterKelvinName;
    FPluralName : rsSquareMeterKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 1));

{ TWattPerSquareMeterPerKelvin }

resourcestring
  rsWattPerSquareMeterPerKelvinSymbol = '%sW/%sm²/%sK';
  rsWattPerSquareMeterPerKelvinName = '%swatt per square %smeter per %skelvin';
  rsWattPerSquareMeterPerKelvinPluralName = '%swatts per square %smeter per %skelvin';

const
  WattPerSquareMeterPerKelvinID = -114540;
  WattPerSquareMeterPerKelvinUnit : TUnit = (
    FID         : WattPerSquareMeterPerKelvinID;
    FSymbol     : rsWattPerSquareMeterPerKelvinSymbol;
    FName       : rsWattPerSquareMeterPerKelvinName;
    FPluralName : rsWattPerSquareMeterPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -1));

{ TKilogramPerCubicSecondPerKelvin }

resourcestring
  rsKilogramPerCubicSecondPerKelvinSymbol = '%sg/%ss³/%sK';
  rsKilogramPerCubicSecondPerKelvinName = '%sgram per cubic %ssecond per %skelvin';
  rsKilogramPerCubicSecondPerKelvinPluralName = '%sgrams per cubic %ssecond per %skelvin';

const
  KilogramPerCubicSecondPerKelvinUnit : TUnit = (
    FID         : WattPerSquareMeterPerKelvinID;
    FSymbol     : rsKilogramPerCubicSecondPerKelvinSymbol;
    FName       : rsKilogramPerCubicSecondPerKelvinName;
    FPluralName : rsKilogramPerCubicSecondPerKelvinPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, -3, -1));

{ TSquareMeterQuarticKelvin }

resourcestring
  rsSquareMeterQuarticKelvinSymbol = '%sm²∙%sK⁴';
  rsSquareMeterQuarticKelvinName = 'square %smeter quartic %skelvin';
  rsSquareMeterQuarticKelvinPluralName = 'square %smeter quartic %skelvins';

const
  SquareMeterQuarticKelvinID = 155640;
  SquareMeterQuarticKelvinUnit : TUnit = (
    FID         : SquareMeterQuarticKelvinID;
    FSymbol     : rsSquareMeterQuarticKelvinSymbol;
    FName       : rsSquareMeterQuarticKelvinName;
    FPluralName : rsSquareMeterQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 4));

{ TWattPerQuarticKelvin }

resourcestring
  rsWattPerQuarticKelvinSymbol = '%sW/%sK⁴';
  rsWattPerQuarticKelvinName = '%swatt per quartic %skelvin';
  rsWattPerQuarticKelvinPluralName = '%swatts per quartic %skelvin';

const
  WattPerQuarticKelvinID = -92040;
  WattPerQuarticKelvinUnit : TUnit = (
    FID         : WattPerQuarticKelvinID;
    FSymbol     : rsWattPerQuarticKelvinSymbol;
    FName       : rsWattPerQuarticKelvinName;
    FPluralName : rsWattPerQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -4));

{ TWattPerSquareMeterPerQuarticKelvin }

resourcestring
  rsWattPerSquareMeterPerQuarticKelvinSymbol = '%sW/%sm²/%sK⁴';
  rsWattPerSquareMeterPerQuarticKelvinName = '%swatt per square %smeter per quartic %skelvin';
  rsWattPerSquareMeterPerQuarticKelvinPluralName = '%swatts per square %smeter per quartic %skelvin';

const
  WattPerSquareMeterPerQuarticKelvinID = -171600;
  WattPerSquareMeterPerQuarticKelvinUnit : TUnit = (
    FID         : WattPerSquareMeterPerQuarticKelvinID;
    FSymbol     : rsWattPerSquareMeterPerQuarticKelvinSymbol;
    FName       : rsWattPerSquareMeterPerQuarticKelvinName;
    FPluralName : rsWattPerSquareMeterPerQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -4));

{ TJoulePerMole }

resourcestring
  rsJoulePerMoleSymbol = '%sJ/%smol';
  rsJoulePerMoleName = '%sjoule per %smole';
  rsJoulePerMolePluralName = '%sjoules per %smole';

const
  JoulePerMoleID = -15780;
  JoulePerMoleUnit : TUnit = (
    FID         : JoulePerMoleID;
    FSymbol     : rsJoulePerMoleSymbol;
    FName       : rsJoulePerMoleName;
    FPluralName : rsJoulePerMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TMoleKelvin }

resourcestring
  rsMoleKelvinSymbol = '%smol∙%sK';
  rsMoleKelvinName = '%smole %skelvin';
  rsMoleKelvinPluralName = '%smole %skelvins';

const
  MoleKelvinID = 53700;
  MoleKelvinUnit : TUnit = (
    FID         : MoleKelvinID;
    FSymbol     : rsMoleKelvinSymbol;
    FName       : rsMoleKelvinName;
    FPluralName : rsMoleKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TJoulePerMolePerKelvin }

resourcestring
  rsJoulePerMolePerKelvinSymbol = '%sJ/%smol/%sK';
  rsJoulePerMolePerKelvinName = '%sjoule per %smole per %skelvin';
  rsJoulePerMolePerKelvinPluralName = '%sjoules per %smole per %skelvin';

const
  JoulePerMolePerKelvinID = -34800;
  JoulePerMolePerKelvinUnit : TUnit = (
    FID         : JoulePerMolePerKelvinID;
    FSymbol     : rsJoulePerMolePerKelvinSymbol;
    FName       : rsJoulePerMolePerKelvinName;
    FPluralName : rsJoulePerMolePerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TOhmMeter }

resourcestring
  rsOhmMeterSymbol = '%sΩ∙%sm';
  rsOhmMeterName = '%sohm %smeter';
  rsOhmMeterPluralName = '%sohm %smeters';

const
  OhmMeterID = -24780;
  OhmMeterUnit : TUnit = (
    FID         : OhmMeterID;
    FSymbol     : rsOhmMeterSymbol;
    FName       : rsOhmMeterName;
    FPluralName : rsOhmMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TVoltPerMeter }

resourcestring
  rsVoltPerMeterSymbol = '%sV/%sm';
  rsVoltPerMeterName = '%svolt per %smeter';
  rsVoltPerMeterPluralName = '%svolts per %smeter';

const
  VoltPerMeterID = -80040;
  VoltPerMeterUnit : TUnit = (
    FID         : VoltPerMeterID;
    FSymbol     : rsVoltPerMeterSymbol;
    FName       : rsVoltPerMeterName;
    FPluralName : rsVoltPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TNewtonPerCoulomb }

resourcestring
  rsNewtonPerCoulombSymbol = '%sN/%sC';
  rsNewtonPerCoulombName = '%snewton per %scoulomb';
  rsNewtonPerCoulombPluralName = '%snewtons per %scoulomb';

const
  NewtonPerCoulombUnit : TUnit = (
    FID         : VoltPerMeterID;
    FSymbol     : rsNewtonPerCoulombSymbol;
    FName       : rsNewtonPerCoulombName;
    FPluralName : rsNewtonPerCoulombPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TCoulombPerMeter }

resourcestring
  rsCoulombPerMeterSymbol = '%sC/%sm';
  rsCoulombPerMeterName = '%scoulomb per %smeter';
  rsCoulombPerMeterPluralName = '%scoulombs per %smeter';

const
  CoulombPerMeterID = 19380;
  CoulombPerMeterUnit : TUnit = (
    FID         : CoulombPerMeterID;
    FSymbol     : rsCoulombPerMeterSymbol;
    FName       : rsCoulombPerMeterName;
    FPluralName : rsCoulombPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareCoulombPerMeter }

resourcestring
  rsSquareCoulombPerMeterSymbol = '%sC²/%sm';
  rsSquareCoulombPerMeterName = 'square %scoulomb per %smeter';
  rsSquareCoulombPerMeterPluralName = 'square %scoulombs per %smeter';

const
  SquareCoulombPerMeterID = 78540;
  SquareCoulombPerMeterUnit : TUnit = (
    FID         : SquareCoulombPerMeterID;
    FSymbol     : rsSquareCoulombPerMeterSymbol;
    FName       : rsSquareCoulombPerMeterName;
    FPluralName : rsSquareCoulombPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TCoulombPerSquareMeter }

resourcestring
  rsCoulombPerSquareMeterSymbol = '%sC/%sm²';
  rsCoulombPerSquareMeterName = '%scoulomb per square %smeter';
  rsCoulombPerSquareMeterPluralName = '%scoulombs per square %smeter';

const
  CoulombPerSquareMeterID = -20400;
  CoulombPerSquareMeterUnit : TUnit = (
    FID         : CoulombPerSquareMeterID;
    FSymbol     : rsCoulombPerSquareMeterSymbol;
    FName       : rsCoulombPerSquareMeterName;
    FPluralName : rsCoulombPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TSquareMeterPerSquareCoulomb }

resourcestring
  rsSquareMeterPerSquareCoulombSymbol = '%sm²/%sC²';
  rsSquareMeterPerSquareCoulombName = 'square %smeter per square %scoulomb';
  rsSquareMeterPerSquareCoulombPluralName = 'square %smeters per square %scoulomb';

const
  SquareMeterPerSquareCoulombID = -38760;
  SquareMeterPerSquareCoulombUnit : TUnit = (
    FID         : SquareMeterPerSquareCoulombID;
    FSymbol     : rsSquareMeterPerSquareCoulombSymbol;
    FName       : rsSquareMeterPerSquareCoulombName;
    FPluralName : rsSquareMeterPerSquareCoulombPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TNewtonPerSquareCoulomb }

resourcestring
  rsNewtonPerSquareCoulombSymbol = '%sN/%sC²';
  rsNewtonPerSquareCoulombName = '%snewton per square %scoulomb';
  rsNewtonPerSquareCoulombPluralName = '%snewtons per square %scoulomb';

const
  NewtonPerSquareCoulombID = -139200;
  NewtonPerSquareCoulombUnit : TUnit = (
    FID         : NewtonPerSquareCoulombID;
    FSymbol     : rsNewtonPerSquareCoulombSymbol;
    FName       : rsNewtonPerSquareCoulombName;
    FPluralName : rsNewtonPerSquareCoulombPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TNewtonSquareMeterPerSquareCoulomb }

resourcestring
  rsNewtonSquareMeterPerSquareCoulombSymbol = '%sN∙%sm²/%sC²';
  rsNewtonSquareMeterPerSquareCoulombName = '%snewton square %smeter per square %scoulomb';
  rsNewtonSquareMeterPerSquareCoulombPluralName = '%snewton square %smeters per square %scoulomb';

const
  NewtonSquareMeterPerSquareCoulombID = -59640;
  NewtonSquareMeterPerSquareCoulombUnit : TUnit = (
    FID         : NewtonSquareMeterPerSquareCoulombID;
    FSymbol     : rsNewtonSquareMeterPerSquareCoulombSymbol;
    FName       : rsNewtonSquareMeterPerSquareCoulombName;
    FPluralName : rsNewtonSquareMeterPerSquareCoulombPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -2));

{ TVoltMeter }

resourcestring
  rsVoltMeterSymbol = '%sV∙%sm';
  rsVoltMeterName = '%svolt %smeter';
  rsVoltMeterPluralName = '%svolt %smeters';

const
  VoltMeterID = -480;
  VoltMeterUnit : TUnit = (
    FID         : VoltMeterID;
    FSymbol     : rsVoltMeterSymbol;
    FName       : rsVoltMeterName;
    FPluralName : rsVoltMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TNewtonSquareMeterPerCoulomb }

resourcestring
  rsNewtonSquareMeterPerCoulombSymbol = '%sN∙%sm²/%sC';
  rsNewtonSquareMeterPerCoulombName = '%snewton square %smeter per %scoulomb';
  rsNewtonSquareMeterPerCoulombPluralName = '%snewton square %smeters per %scoulomb';

const
  NewtonSquareMeterPerCoulombUnit : TUnit = (
    FID         : VoltMeterID;
    FSymbol     : rsNewtonSquareMeterPerCoulombSymbol;
    FName       : rsNewtonSquareMeterPerCoulombName;
    FPluralName : rsNewtonSquareMeterPerCoulombPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TVoltMeterPerSecond }

resourcestring
  rsVoltMeterPerSecondSymbol = '%sV∙%sm/%ss';
  rsVoltMeterPerSecondName = '%svolt %smeter per %ssecond';
  rsVoltMeterPerSecondPluralName = '%svolt %smeters per %ssecond';

const
  VoltMeterPerSecondID = -35340;
  VoltMeterPerSecondUnit : TUnit = (
    FID         : VoltMeterPerSecondID;
    FSymbol     : rsVoltMeterPerSecondSymbol;
    FName       : rsVoltMeterPerSecondName;
    FPluralName : rsVoltMeterPerSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TFaradPerMeter }

resourcestring
  rsFaradPerMeterSymbol = '%sF/%sm';
  rsFaradPerMeterName = '%sfarad per %smeter';
  rsFaradPerMeterPluralName = '%sfarads per %smeter';

const
  FaradPerMeterID = 59640;
  FaradPerMeterUnit : TUnit = (
    FID         : FaradPerMeterID;
    FSymbol     : rsFaradPerMeterSymbol;
    FName       : rsFaradPerMeterName;
    FPluralName : rsFaradPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TAmperePerMeter }

resourcestring
  rsAmperePerMeterSymbol = '%sA/%sm';
  rsAmperePerMeterName = '%sampere per %smeter';
  rsAmperePerMeterPluralName = '%samperes per %smeter';

const
  AmperePerMeterID = -15480;
  AmperePerMeterUnit : TUnit = (
    FID         : AmperePerMeterID;
    FSymbol     : rsAmperePerMeterSymbol;
    FName       : rsAmperePerMeterName;
    FPluralName : rsAmperePerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TMeterPerAmpere }

resourcestring
  rsMeterPerAmpereSymbol = '%sm/%sA';
  rsMeterPerAmpereName = '%smeter per %sampere';
  rsMeterPerAmperePluralName = '%smeters per %sampere';

const
  MeterPerAmpereID = 15480;
  MeterPerAmpereUnit : TUnit = (
    FID         : MeterPerAmpereID;
    FSymbol     : rsMeterPerAmpereSymbol;
    FName       : rsMeterPerAmpereName;
    FPluralName : rsMeterPerAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TTeslaMeter }

resourcestring
  rsTeslaMeterSymbol = '%sT∙%sm';
  rsTeslaMeterName = '%stesla %smeter';
  rsTeslaMeterPluralName = '%stesla %smeters';

const
  TeslaMeterID = -45180;
  TeslaMeterUnit : TUnit = (
    FID         : TeslaMeterID;
    FSymbol     : rsTeslaMeterSymbol;
    FName       : rsTeslaMeterName;
    FPluralName : rsTeslaMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TNewtonPerAmpere }

resourcestring
  rsNewtonPerAmpereSymbol = '%sN/%sA';
  rsNewtonPerAmpereName = '%snewton per %sampere';
  rsNewtonPerAmperePluralName = '%snewtons per %sampere';

const
  NewtonPerAmpereUnit : TUnit = (
    FID         : TeslaMeterID;
    FSymbol     : rsNewtonPerAmpereSymbol;
    FName       : rsNewtonPerAmpereName;
    FPluralName : rsNewtonPerAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TTeslaPerAmpere }

resourcestring
  rsTeslaPerAmpereSymbol = '%sT/%sA';
  rsTeslaPerAmpereName = '%stesla per %sampere';
  rsTeslaPerAmperePluralName = '%steslas per %sampere';

const
  TeslaPerAmpereID = -109260;
  TeslaPerAmpereUnit : TUnit = (
    FID         : TeslaPerAmpereID;
    FSymbol     : rsTeslaPerAmpereSymbol;
    FName       : rsTeslaPerAmpereName;
    FPluralName : rsTeslaPerAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ THenryPerMeter }

resourcestring
  rsHenryPerMeterSymbol = '%sH/%sm';
  rsHenryPerMeterName = '%shenry per %smeter';
  rsHenryPerMeterPluralName = '%shenries per %smeter';

const
  HenryPerMeterID = -69480;
  HenryPerMeterUnit : TUnit = (
    FID         : HenryPerMeterID;
    FSymbol     : rsHenryPerMeterSymbol;
    FName       : rsHenryPerMeterName;
    FPluralName : rsHenryPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TTeslaMeterPerAmpere }

resourcestring
  rsTeslaMeterPerAmpereSymbol = '%sT∙%sm/%sA';
  rsTeslaMeterPerAmpereName = '%stesla %smeter per %sampere';
  rsTeslaMeterPerAmperePluralName = '%stesla %smeters per %sampere';

const
  TeslaMeterPerAmpereUnit : TUnit = (
    FID         : HenryPerMeterID;
    FSymbol     : rsTeslaMeterPerAmpereSymbol;
    FName       : rsTeslaMeterPerAmpereName;
    FPluralName : rsTeslaMeterPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TNewtonPerSquareAmpere }

resourcestring
  rsNewtonPerSquareAmpereSymbol = '%sN/%sA²';
  rsNewtonPerSquareAmpereName = '%snewton per square %sampere';
  rsNewtonPerSquareAmperePluralName = '%snewtons per square %sampere';

const
  NewtonPerSquareAmpereUnit : TUnit = (
    FID         : HenryPerMeterID;
    FSymbol     : rsNewtonPerSquareAmpereSymbol;
    FName       : rsNewtonPerSquareAmpereName;
    FPluralName : rsNewtonPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TRadianPerMeter }

resourcestring
  rsRadianPerMeterSymbol = 'rad/%sm';
  rsRadianPerMeterName = 'radian per %smeter';
  rsRadianPerMeterPluralName = 'radians per %smeter';

const
  RadianPerMeterUnit : TUnit = (
    FID         : ReciprocalMeterID;
    FSymbol     : rsRadianPerMeterSymbol;
    FName       : rsRadianPerMeterName;
    FPluralName : rsRadianPerMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TSquareKilogramPerSquareSecond }

resourcestring
  rsSquareKilogramPerSquareSecondSymbol = '%sg²/%ss²';
  rsSquareKilogramPerSquareSecondName = 'square %sgram per square %ssecond';
  rsSquareKilogramPerSquareSecondPluralName = 'square %sgrams per square %ssecond';

const
  SquareKilogramPerSquareSecondID = -51600;
  SquareKilogramPerSquareSecondUnit : TUnit = (
    FID         : SquareKilogramPerSquareSecondID;
    FSymbol     : rsSquareKilogramPerSquareSecondSymbol;
    FName       : rsSquareKilogramPerSquareSecondName;
    FPluralName : rsSquareKilogramPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (2, -2));

{ TSquareSecondPerSquareMeter }

resourcestring
  rsSquareSecondPerSquareMeterSymbol = '%ss²/%sm²';
  rsSquareSecondPerSquareMeterName = 'square %ssecond per square %smeter';
  rsSquareSecondPerSquareMeterPluralName = 'square %sseconds per square %smeter';

const
  SquareSecondPerSquareMeterID = -9840;
  SquareSecondPerSquareMeterUnit : TUnit = (
    FID         : SquareSecondPerSquareMeterID;
    FSymbol     : rsSquareSecondPerSquareMeterSymbol;
    FName       : rsSquareSecondPerSquareMeterName;
    FPluralName : rsSquareSecondPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TSquareJoule }

resourcestring
  rsSquareJouleSymbol = '%sJ²';
  rsSquareJouleName = 'square %sjoule';
  rsSquareJoulePluralName = 'square %sjoules';

const
  SquareJouleID = 37800;
  SquareJouleUnit : TUnit = (
    FID         : SquareJouleID;
    FSymbol     : rsSquareJouleSymbol;
    FName       : rsSquareJouleName;
    FPluralName : rsSquareJoulePluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  J2 : TUnit absolute SquareJouleUnit;

const
  TJ2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareJouleID; FValue: 1E+24); {$ELSE} (1E+24); {$ENDIF}
  GJ2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareJouleID; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MJ2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareJouleID; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kJ2        : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareJouleID; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}

{ TJouleSecond }

resourcestring
  rsJouleSecondSymbol = '%sJ∙%ss';
  rsJouleSecondName = '%sjoule %ssecond';
  rsJouleSecondPluralName = '%sjoule %sseconds';

const
  JouleSecondUnit : TUnit = (
    FID         : KilogramSquareMeterPerSecondID;
    FSymbol     : rsJouleSecondSymbol;
    FName       : rsJouleSecondName;
    FPluralName : rsJouleSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TJoulePerHertz }

resourcestring
  rsJoulePerHertzSymbol = '%sJ/%sHz';
  rsJoulePerHertzName = '%sjoule per %shertz';
  rsJoulePerHertzPluralName = '%sjoules per %shertz';

const
  JoulePerHertzUnit : TUnit = (
    FID         : KilogramSquareMeterPerSecondID;
    FSymbol     : rsJoulePerHertzSymbol;
    FName       : rsJoulePerHertzName;
    FPluralName : rsJoulePerHertzPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TElectronvoltSecond }

resourcestring
  rsElectronvoltSecondSymbol = '%seV∙%ss';
  rsElectronvoltSecondName = '%selectronvolt %ssecond';
  rsElectronvoltSecondPluralName = '%selectronvolt %sseconds';

const
  ElectronvoltSecondUnit : TFactoredUnit = (
    FID         : KilogramSquareMeterPerSecondID;
    FSymbol     : rsElectronvoltSecondSymbol;
    FName       : rsElectronvoltSecondName;
    FPluralName : rsElectronvoltSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1);
    FFactor     : (1.60217742320523E-019));

{ TElectronvoltMeterPerSpeedOfLight }

resourcestring
  rsElectronvoltMeterPerSpeedOfLightSymbol = '%seV∙%sm/c';
  rsElectronvoltMeterPerSpeedOfLightName = '%selectronvolt %smeter per speed of  light';
  rsElectronvoltMeterPerSpeedOfLightPluralName = '%selectronvolt %smeters per speed of  light';

const
  ElectronvoltMeterPerSpeedOfLightUnit : TFactoredUnit = (
    FID         : KilogramSquareMeterPerSecondID;
    FSymbol     : rsElectronvoltMeterPerSpeedOfLightSymbol;
    FName       : rsElectronvoltMeterPerSpeedOfLightName;
    FPluralName : rsElectronvoltMeterPerSpeedOfLightPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1);
    FFactor     : (1.7826619216279E-36));

{ TSquareJouleSquareSecond }

resourcestring
  rsSquareJouleSquareSecondSymbol = '%sJ²∙%ss²';
  rsSquareJouleSquareSecondName = 'square %sjoule square %ssecond';
  rsSquareJouleSquareSecondPluralName = 'square %sjoule square %sseconds';

const
  SquareJouleSquareSecondID = 107520;
  SquareJouleSquareSecondUnit : TUnit = (
    FID         : SquareJouleSquareSecondID;
    FSymbol     : rsSquareJouleSquareSecondSymbol;
    FName       : rsSquareJouleSquareSecondName;
    FPluralName : rsSquareJouleSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 2));

{ TCoulombPerKilogram }

resourcestring
  rsCoulombPerKilogramSymbol = '%sC/%sg';
  rsCoulombPerKilogramName = '%scoulomb per %sgram';
  rsCoulombPerKilogramPluralName = '%scoulombs per %sgram';

const
  CoulombPerKilogramID = 50100;
  CoulombPerKilogramUnit : TUnit = (
    FID         : CoulombPerKilogramID;
    FSymbol     : rsCoulombPerKilogramSymbol;
    FName       : rsCoulombPerKilogramName;
    FPluralName : rsCoulombPerKilogramPluralName;
    FPrefixes   : (pNone, pKilo);
    FExponents  : (1, -1));

{ TSquareMeterAmpere }

resourcestring
  rsSquareMeterAmpereSymbol = '%sm²∙%sA';
  rsSquareMeterAmpereName = 'square %smeter %sampere';
  rsSquareMeterAmperePluralName = 'square %smeter %samperes';

const
  SquareMeterAmpereID = 103860;
  SquareMeterAmpereUnit : TUnit = (
    FID         : SquareMeterAmpereID;
    FSymbol     : rsSquareMeterAmpereSymbol;
    FName       : rsSquareMeterAmpereName;
    FPluralName : rsSquareMeterAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 1));

{ TJoulePerTesla }

resourcestring
  rsJoulePerTeslaSymbol = '%sJ/%sT';
  rsJoulePerTeslaName = '%sjoule per %stesla';
  rsJoulePerTeslaPluralName = '%sjoules per %stesla';

const
  JoulePerTeslaUnit : TUnit = (
    FID         : SquareMeterAmpereID;
    FSymbol     : rsJoulePerTeslaSymbol;
    FName       : rsJoulePerTeslaName;
    FPluralName : rsJoulePerTeslaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TLumenPerWatt }

resourcestring
  rsLumenPerWattSymbol = '%slm/%sW';
  rsLumenPerWattName = '%slumen per %swatt';
  rsLumenPerWattPluralName = '%slumens per %swatt';

const
  LumenPerWattID = 93780;
  LumenPerWattUnit : TUnit = (
    FID         : LumenPerWattID;
    FSymbol     : rsLumenPerWattSymbol;
    FName       : rsLumenPerWattName;
    FPluralName : rsLumenPerWattPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TReciprocalMole }

resourcestring
  rsReciprocalMoleSymbol = '1/%smol';
  rsReciprocalMoleName = 'reciprocal %smole';
  rsReciprocalMolePluralName = 'reciprocal %smoles';

const
  ReciprocalMoleID = -34680;
  ReciprocalMoleUnit : TUnit = (
    FID         : ReciprocalMoleID;
    FSymbol     : rsReciprocalMoleSymbol;
    FName       : rsReciprocalMoleName;
    FPluralName : rsReciprocalMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TAmperePerSquareMeter }

resourcestring
  rsAmperePerSquareMeterSymbol = '%sA/%sm²';
  rsAmperePerSquareMeterName = '%sampere per square %smeter';
  rsAmperePerSquareMeterPluralName = '%samperes per square %smeter';

const
  AmperePerSquareMeterID = -55260;
  AmperePerSquareMeterUnit : TUnit = (
    FID         : AmperePerSquareMeterID;
    FSymbol     : rsAmperePerSquareMeterSymbol;
    FName       : rsAmperePerSquareMeterName;
    FPluralName : rsAmperePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TMolePerCubicMeter }

resourcestring
  rsMolePerCubicMeterSymbol = '%smol/%sm³';
  rsMolePerCubicMeterName = '%smole per cubic %smeter';
  rsMolePerCubicMeterPluralName = '%smoles per cubic %smeter';

const
  MolePerCubicMeterID = -84660;
  MolePerCubicMeterUnit : TUnit = (
    FID         : MolePerCubicMeterID;
    FSymbol     : rsMolePerCubicMeterSymbol;
    FName       : rsMolePerCubicMeterName;
    FPluralName : rsMolePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TCandelaPerSquareMeter }

resourcestring
  rsCandelaPerSquareMeterSymbol = '%scd/%sm²';
  rsCandelaPerSquareMeterName = '%scandela per square %smeter';
  rsCandelaPerSquareMeterPluralName = '%scandelas per square %smeter';

const
  CandelaPerSquareMeterID = -39600;
  CandelaPerSquareMeterUnit : TUnit = (
    FID         : CandelaPerSquareMeterID;
    FSymbol     : rsCandelaPerSquareMeterSymbol;
    FName       : rsCandelaPerSquareMeterName;
    FPluralName : rsCandelaPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TCoulombPerCubicMeter }

resourcestring
  rsCoulombPerCubicMeterSymbol = '%sC/%sm³';
  rsCoulombPerCubicMeterName = '%scoulomb per cubic %smeter';
  rsCoulombPerCubicMeterPluralName = '%scoulombs per cubic %smeter';

const
  CoulombPerCubicMeterID = -60180;
  CoulombPerCubicMeterUnit : TUnit = (
    FID         : CoulombPerCubicMeterID;
    FSymbol     : rsCoulombPerCubicMeterSymbol;
    FName       : rsCoulombPerCubicMeterName;
    FPluralName : rsCoulombPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TGrayPerSecond }

resourcestring
  rsGrayPerSecondSymbol = '%sGy/%ss';
  rsGrayPerSecondName = '%sgray per %ssecond';
  rsGrayPerSecondPluralName = '%sgrays per %ssecond';

const
  GrayPerSecondID = -25020;
  GrayPerSecondUnit : TUnit = (
    FID         : GrayPerSecondID;
    FSymbol     : rsGrayPerSecondSymbol;
    FName       : rsGrayPerSecondName;
    FPluralName : rsGrayPerSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSteradianHertz }

resourcestring
  rsSteradianHertzSymbol = 'sr∙%sHz';
  rsSteradianHertzName = 'steradian %shertz';
  rsSteradianHertzPluralName = 'steradian %shertz';

const
  SteradianHertzID = 3000;
  SteradianHertzUnit : TUnit = (
    FID         : SteradianHertzID;
    FSymbol     : rsSteradianHertzSymbol;
    FName       : rsSteradianHertzName;
    FPluralName : rsSteradianHertzPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TMeterSteradian }

resourcestring
  rsMeterSteradianSymbol = '%sm∙sr';
  rsMeterSteradianName = '%smeter steradian';
  rsMeterSteradianPluralName = '%smeter steradians';

const
  MeterSteradianID = 77640;
  MeterSteradianUnit : TUnit = (
    FID         : MeterSteradianID;
    FSymbol     : rsMeterSteradianSymbol;
    FName       : rsMeterSteradianName;
    FPluralName : rsMeterSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareMeterSteradian }

resourcestring
  rsSquareMeterSteradianSymbol = '%sm²∙sr';
  rsSquareMeterSteradianName = 'square %smeter steradian';
  rsSquareMeterSteradianPluralName = 'square %smeter steradians';

const
  SquareMeterSteradianID = 117420;
  SquareMeterSteradianUnit : TUnit = (
    FID         : SquareMeterSteradianID;
    FSymbol     : rsSquareMeterSteradianSymbol;
    FName       : rsSquareMeterSteradianName;
    FPluralName : rsSquareMeterSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

{ TCubicMeterSteradian }

resourcestring
  rsCubicMeterSteradianSymbol = '%sm³∙sr';
  rsCubicMeterSteradianName = 'cubic %smeter steradian';
  rsCubicMeterSteradianPluralName = 'cubic %smeter steradians';

const
  CubicMeterSteradianID = 157200;
  CubicMeterSteradianUnit : TUnit = (
    FID         : CubicMeterSteradianID;
    FSymbol     : rsCubicMeterSteradianSymbol;
    FName       : rsCubicMeterSteradianName;
    FPluralName : rsCubicMeterSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareMeterSteradianHertz }

resourcestring
  rsSquareMeterSteradianHertzSymbol = '%sm²∙sr∙%shertz';
  rsSquareMeterSteradianHertzName = 'square %smeter steradian %shertz';
  rsSquareMeterSteradianHertzPluralName = 'square %smeter steradian %shertz';

const
  SquareMeterSteradianHertzID = 82560;
  SquareMeterSteradianHertzUnit : TUnit = (
    FID         : SquareMeterSteradianHertzID;
    FSymbol     : rsSquareMeterSteradianHertzSymbol;
    FName       : rsSquareMeterSteradianHertzName;
    FPluralName : rsSquareMeterSteradianHertzPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 1));

{ TWattPerSteradian }

resourcestring
  rsWattPerSteradianSymbol = '%sW/sr';
  rsWattPerSteradianName = '%swatt per steradian';
  rsWattPerSteradianPluralName = '%swatts per steradian';

const
  WattPerSteradianID = -53820;
  WattPerSteradianUnit : TUnit = (
    FID         : WattPerSteradianID;
    FSymbol     : rsWattPerSteradianSymbol;
    FName       : rsWattPerSteradianName;
    FPluralName : rsWattPerSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TWattPerSteradianPerHertz }

resourcestring
  rsWattPerSteradianPerHertzSymbol = '%sW/sr/%sHz';
  rsWattPerSteradianPerHertzName = '%swatt per steradian per %shertz';
  rsWattPerSteradianPerHertzPluralName = '%swatts per steradian per %shertz';

const
  WattPerSteradianPerHertzID = -18960;
  WattPerSteradianPerHertzUnit : TUnit = (
    FID         : WattPerSteradianPerHertzID;
    FSymbol     : rsWattPerSteradianPerHertzSymbol;
    FName       : rsWattPerSteradianPerHertzName;
    FPluralName : rsWattPerSteradianPerHertzPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TWattPerMeterPerSteradian }

resourcestring
  rsWattPerMeterPerSteradianSymbol = '%sW/sr/%sm';
  rsWattPerMeterPerSteradianName = '%swatt per steradian per %smeter';
  rsWattPerMeterPerSteradianPluralName = '%swatts per steradian per %smeter';

const
  WattPerMeterPerSteradianID = -93600;
  WattPerMeterPerSteradianUnit : TUnit = (
    FID         : WattPerMeterPerSteradianID;
    FSymbol     : rsWattPerMeterPerSteradianSymbol;
    FName       : rsWattPerMeterPerSteradianName;
    FPluralName : rsWattPerMeterPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TWattPerSquareMeterPerSteradian }

resourcestring
  rsWattPerSquareMeterPerSteradianSymbol = '%sW/%sm²/sr';
  rsWattPerSquareMeterPerSteradianName = '%swatt per square %smeter per steradian';
  rsWattPerSquareMeterPerSteradianPluralName = '%swatts per square %smeter per steradian';

const
  WattPerSquareMeterPerSteradianID = -133380;
  WattPerSquareMeterPerSteradianUnit : TUnit = (
    FID         : WattPerSquareMeterPerSteradianID;
    FSymbol     : rsWattPerSquareMeterPerSteradianSymbol;
    FName       : rsWattPerSquareMeterPerSteradianName;
    FPluralName : rsWattPerSquareMeterPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TWattPerCubicMeterPerSteradian }

resourcestring
  rsWattPerCubicMeterPerSteradianSymbol = '%sW/%sm³/sr';
  rsWattPerCubicMeterPerSteradianName = '%swatt per cubic %smeter per steradian';
  rsWattPerCubicMeterPerSteradianPluralName = '%swatts per cubic %smeter per steradian';

const
  WattPerCubicMeterPerSteradianID = -173160;
  WattPerCubicMeterPerSteradianUnit : TUnit = (
    FID         : WattPerCubicMeterPerSteradianID;
    FSymbol     : rsWattPerCubicMeterPerSteradianSymbol;
    FName       : rsWattPerCubicMeterPerSteradianName;
    FPluralName : rsWattPerCubicMeterPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TWattPerSquareMeterPerSteradianPerHertz }

resourcestring
  rsWattPerSquareMeterPerSteradianPerHertzSymbol = '%sW/%sm²/sr/%sHz';
  rsWattPerSquareMeterPerSteradianPerHertzName = '%swatt per square %smeter per steradian per %shertz';
  rsWattPerSquareMeterPerSteradianPerHertzPluralName = '%swatts per square %smeter per steradian per %shertz';

const
  WattPerSquareMeterPerSteradianPerHertzID = -98520;
  WattPerSquareMeterPerSteradianPerHertzUnit : TUnit = (
    FID         : WattPerSquareMeterPerSteradianPerHertzID;
    FSymbol     : rsWattPerSquareMeterPerSteradianPerHertzSymbol;
    FName       : rsWattPerSquareMeterPerSteradianPerHertzName;
    FPluralName : rsWattPerSquareMeterPerSteradianPerHertzPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -1));

{ TKatalPerCubicMeter }

resourcestring
  rsKatalPerCubicMeterSymbol = '%skat/%sm³';
  rsKatalPerCubicMeterName = '%skatal per cubic %smeter';
  rsKatalPerCubicMeterPluralName = '%skatals per cubic %smeter';

const
  KatalPerCubicMeterID = -119520;
  KatalPerCubicMeterUnit : TUnit = (
    FID         : KatalPerCubicMeterID;
    FSymbol     : rsKatalPerCubicMeterSymbol;
    FName       : rsKatalPerCubicMeterName;
    FPluralName : rsKatalPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TCoulombPerMole }

resourcestring
  rsCoulombPerMoleSymbol = '%sC/%smol';
  rsCoulombPerMoleName = '%scoulomb per %smole';
  rsCoulombPerMolePluralName = '%scoulombs per %smole';

const
  CoulombPerMoleID = 24480;
  CoulombPerMoleUnit : TUnit = (
    FID         : CoulombPerMoleID;
    FSymbol     : rsCoulombPerMoleSymbol;
    FName       : rsCoulombPerMoleName;
    FPluralName : rsCoulombPerMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TReciprocalNewton }

resourcestring
  rsReciprocalNewtonSymbol = '1/%sN';
  rsReciprocalNewtonName = 'reciprocal %snewton';
  rsReciprocalNewtonPluralName = 'reciprocal %snewtons';

const
  ReciprocalNewtonID = 20880;
  ReciprocalNewtonUnit : TUnit = (
    FID         : ReciprocalNewtonID;
    FSymbol     : rsReciprocalNewtonSymbol;
    FName       : rsReciprocalNewtonName;
    FPluralName : rsReciprocalNewtonPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalTesla }

resourcestring
  rsReciprocalTeslaSymbol = '1/%sT';
  rsReciprocalTeslaName = 'reciprocal %stesla';
  rsReciprocalTeslaPluralName = 'reciprocal %steslas';

const
  ReciprocalTeslaID = 84960;
  ReciprocalTeslaUnit : TUnit = (
    FID         : ReciprocalTeslaID;
    FSymbol     : rsReciprocalTeslaSymbol;
    FName       : rsReciprocalTeslaName;
    FPluralName : rsReciprocalTeslaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalPascal }

resourcestring
  rsReciprocalPascalSymbol = '1/%sPa';
  rsReciprocalPascalName = 'reciprocal %spascal';
  rsReciprocalPascalPluralName = 'reciprocal %spascals';

const
  ReciprocalPascalID = 100440;
  ReciprocalPascalUnit : TUnit = (
    FID         : ReciprocalPascalID;
    FSymbol     : rsReciprocalPascalSymbol;
    FName       : rsReciprocalPascalName;
    FPluralName : rsReciprocalPascalPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalWeber }

resourcestring
  rsReciprocalWeberSymbol = '1/%sWb';
  rsReciprocalWeberName = 'reciprocal %sweber';
  rsReciprocalWeberPluralName = 'reciprocal %swebers';

const
  ReciprocalWeberID = 5400;
  ReciprocalWeberUnit : TUnit = (
    FID         : ReciprocalWeberID;
    FSymbol     : rsReciprocalWeberSymbol;
    FName       : rsReciprocalWeberName;
    FPluralName : rsReciprocalWeberPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalWatt }

resourcestring
  rsReciprocalWattSymbol = '1/%sW';
  rsReciprocalWattName = 'reciprocal %swatt';
  rsReciprocalWattPluralName = 'reciprocal %swatts';

const
  ReciprocalWattID = 15960;
  ReciprocalWattUnit : TUnit = (
    FID         : ReciprocalWattID;
    FSymbol     : rsReciprocalWattSymbol;
    FName       : rsReciprocalWattName;
    FPluralName : rsReciprocalWattPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalRadian }

resourcestring
  rsReciprocalRadianSymbol = '1/%srad';
  rsReciprocalRadianName = 'reciprocal %sradian';
  rsReciprocalRadianPluralName = 'reciprocal %sradians';

const
  ReciprocalRadianUnit : TUnit = (
    FID         : ScalarID;
    FSymbol     : rsReciprocalRadianSymbol;
    FName       : rsReciprocalRadianName;
    FPluralName : rsReciprocalRadianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TMeterPerVolt }

resourcestring
  rsMeterPerVoltSymbol = '%sm/%sV';
  rsMeterPerVoltName = '%smeter per %svolt';
  rsMeterPerVoltPluralName = '%smeters per %svolt';

const
  MeterPerVoltID = 80040;
  MeterPerVoltUnit : TUnit = (
    FID         : MeterPerVoltID;
    FSymbol     : rsMeterPerVoltSymbol;
    FName       : rsMeterPerVoltName;
    FPluralName : rsMeterPerVoltPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSecondPerRadian }

resourcestring
  rsSecondPerRadianSymbol = '%ss/rad';
  rsSecondPerRadianName = '%ssecond per radian';
  rsSecondPerRadianPluralName = '%sseconds per radian';

const
  SecondPerRadianUnit : TUnit = (
    FID         : SecondID;
    FSymbol     : rsSecondPerRadianSymbol;
    FName       : rsSecondPerRadianName;
    FPluralName : rsSecondPerRadianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootKilogram }

resourcestring
  rsQuarticRootKilogramSymbol = '∜%skg';
  rsQuarticRootKilogramName = 'quartic root %skilogram';
  rsQuarticRootKilogramPluralName = 'quartic root %skilograms';

const
  QuarticRootKilogramID = 2265;
  QuarticRootKilogramUnit : TUnit = (
    FID         : QuarticRootKilogramID;
    FSymbol     : rsQuarticRootKilogramSymbol;
    FName       : rsQuarticRootKilogramName;
    FPluralName : rsQuarticRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TCubicRootKilogram }

resourcestring
  rsCubicRootKilogramSymbol = '∛%skg';
  rsCubicRootKilogramName = 'cubic root %skilogram';
  rsCubicRootKilogramPluralName = 'cubic root %skilograms';

const
  CubicRootKilogramID = 3020;
  CubicRootKilogramUnit : TUnit = (
    FID         : CubicRootKilogramID;
    FSymbol     : rsCubicRootKilogramSymbol;
    FName       : rsCubicRootKilogramName;
    FPluralName : rsCubicRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootKilogram }

resourcestring
  rsSquareRootKilogramSymbol = '√%skg';
  rsSquareRootKilogramName = 'square root %skilogram';
  rsSquareRootKilogramPluralName = 'square root %skilograms';

const
  SquareRootKilogramID = 4530;
  SquareRootKilogramUnit : TUnit = (
    FID         : SquareRootKilogramID;
    FSymbol     : rsSquareRootKilogramSymbol;
    FName       : rsSquareRootKilogramName;
    FPluralName : rsSquareRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootCubicKilogram }

resourcestring
  rsSquareRootCubicKilogramSymbol = '√%skg³';
  rsSquareRootCubicKilogramName = 'square root cubic %skilogram';
  rsSquareRootCubicKilogramPluralName = 'square root cubic %skilograms';

const
  SquareRootCubicKilogramID = 13590;
  SquareRootCubicKilogramUnit : TUnit = (
    FID         : SquareRootCubicKilogramID;
    FSymbol     : rsSquareRootCubicKilogramSymbol;
    FName       : rsSquareRootCubicKilogramName;
    FPluralName : rsSquareRootCubicKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootQuinticKilogram }

resourcestring
  rsSquareRootQuinticKilogramSymbol = '√%skg⁵';
  rsSquareRootQuinticKilogramName = 'square root quintic %skilogram';
  rsSquareRootQuinticKilogramPluralName = 'square root quintic %skilograms';

const
  SquareRootQuinticKilogramID = 22650;
  SquareRootQuinticKilogramUnit : TUnit = (
    FID         : SquareRootQuinticKilogramID;
    FSymbol     : rsSquareRootQuinticKilogramSymbol;
    FName       : rsSquareRootQuinticKilogramName;
    FPluralName : rsSquareRootQuinticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TCubicKilogram }

resourcestring
  rsCubicKilogramSymbol = '%skg³';
  rsCubicKilogramName = 'cubic %skilogram';
  rsCubicKilogramPluralName = 'cubic %skilograms';

const
  CubicKilogramID = 27180;
  CubicKilogramUnit : TUnit = (
    FID         : CubicKilogramID;
    FSymbol     : rsCubicKilogramSymbol;
    FName       : rsCubicKilogramName;
    FPluralName : rsCubicKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TQuarticKilogram }

resourcestring
  rsQuarticKilogramSymbol = '%skg⁴';
  rsQuarticKilogramName = 'quartic %skilogram';
  rsQuarticKilogramPluralName = 'quartic %skilograms';

const
  QuarticKilogramID = 36240;
  QuarticKilogramUnit : TUnit = (
    FID         : QuarticKilogramID;
    FSymbol     : rsQuarticKilogramSymbol;
    FName       : rsQuarticKilogramName;
    FPluralName : rsQuarticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (4));

{ TQuinticKilogram }

resourcestring
  rsQuinticKilogramSymbol = '%skg⁵';
  rsQuinticKilogramName = 'quintic %skilogram';
  rsQuinticKilogramPluralName = 'quintic %skilograms';

const
  QuinticKilogramID = 45300;
  QuinticKilogramUnit : TUnit = (
    FID         : QuinticKilogramID;
    FSymbol     : rsQuinticKilogramSymbol;
    FName       : rsQuinticKilogramName;
    FPluralName : rsQuinticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TSexticKilogram }

resourcestring
  rsSexticKilogramSymbol = '%skg⁶';
  rsSexticKilogramName = 'sextic %skilogram';
  rsSexticKilogramPluralName = 'sextic %skilograms';

const
  SexticKilogramID = 54360;
  SexticKilogramUnit : TUnit = (
    FID         : SexticKilogramID;
    FSymbol     : rsSexticKilogramSymbol;
    FName       : rsSexticKilogramName;
    FPluralName : rsSexticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (6));

{ TQuarticRootMeter }

resourcestring
  rsQuarticRootMeterSymbol = '∜%sm';
  rsQuarticRootMeterName = 'quartic root %smeter';
  rsQuarticRootMeterPluralName = 'quartic root %smeters';

const
  QuarticRootMeterID = 9945;
  QuarticRootMeterUnit : TUnit = (
    FID         : QuarticRootMeterID;
    FSymbol     : rsQuarticRootMeterSymbol;
    FName       : rsQuarticRootMeterName;
    FPluralName : rsQuarticRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TCubicRootMeter }

resourcestring
  rsCubicRootMeterSymbol = '∛%sm';
  rsCubicRootMeterName = 'cubic root %smeter';
  rsCubicRootMeterPluralName = 'cubic root %smeters';

const
  CubicRootMeterID = 13260;
  CubicRootMeterUnit : TUnit = (
    FID         : CubicRootMeterID;
    FSymbol     : rsCubicRootMeterSymbol;
    FName       : rsCubicRootMeterName;
    FPluralName : rsCubicRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootCubicMeter }

resourcestring
  rsSquareRootCubicMeterSymbol = '√%sm³';
  rsSquareRootCubicMeterName = 'square root cubic %smeter';
  rsSquareRootCubicMeterPluralName = 'square root cubic %smeters';

const
  SquareRootCubicMeterID = 59670;
  SquareRootCubicMeterUnit : TUnit = (
    FID         : SquareRootCubicMeterID;
    FSymbol     : rsSquareRootCubicMeterSymbol;
    FName       : rsSquareRootCubicMeterName;
    FPluralName : rsSquareRootCubicMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootQuinticMeter }

resourcestring
  rsSquareRootQuinticMeterSymbol = '√%sm⁵';
  rsSquareRootQuinticMeterName = 'square root quintic %smeter';
  rsSquareRootQuinticMeterPluralName = 'square root quintic %smeters';

const
  SquareRootQuinticMeterID = 99450;
  SquareRootQuinticMeterUnit : TUnit = (
    FID         : SquareRootQuinticMeterID;
    FSymbol     : rsSquareRootQuinticMeterSymbol;
    FName       : rsSquareRootQuinticMeterName;
    FPluralName : rsSquareRootQuinticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TQuarticRootSecond }

resourcestring
  rsQuarticRootSecondSymbol = '∜%ss';
  rsQuarticRootSecondName = 'quartic root %ssecond';
  rsQuarticRootSecondPluralName = 'quartic root %sseconds';

const
  QuarticRootSecondID = 8715;
  QuarticRootSecondUnit : TUnit = (
    FID         : QuarticRootSecondID;
    FSymbol     : rsQuarticRootSecondSymbol;
    FName       : rsQuarticRootSecondName;
    FPluralName : rsQuarticRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TCubicRootSecond }

resourcestring
  rsCubicRootSecondSymbol = '∛%ss';
  rsCubicRootSecondName = 'cubic root %ssecond';
  rsCubicRootSecondPluralName = 'cubic root %sseconds';

const
  CubicRootSecondID = 11620;
  CubicRootSecondUnit : TUnit = (
    FID         : CubicRootSecondID;
    FSymbol     : rsCubicRootSecondSymbol;
    FName       : rsCubicRootSecondName;
    FPluralName : rsCubicRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootSecond }

resourcestring
  rsSquareRootSecondSymbol = '√%ss';
  rsSquareRootSecondName = 'square root %ssecond';
  rsSquareRootSecondPluralName = 'square root %sseconds';

const
  SquareRootSecondID = 17430;
  SquareRootSecondUnit : TUnit = (
    FID         : SquareRootSecondID;
    FSymbol     : rsSquareRootSecondSymbol;
    FName       : rsSquareRootSecondName;
    FPluralName : rsSquareRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootCubicSecond }

resourcestring
  rsSquareRootCubicSecondSymbol = '√%ss³';
  rsSquareRootCubicSecondName = 'square root cubic %ssecond';
  rsSquareRootCubicSecondPluralName = 'square root cubic %sseconds';

const
  SquareRootCubicSecondID = 52290;
  SquareRootCubicSecondUnit : TUnit = (
    FID         : SquareRootCubicSecondID;
    FSymbol     : rsSquareRootCubicSecondSymbol;
    FName       : rsSquareRootCubicSecondName;
    FPluralName : rsSquareRootCubicSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootQuinticSecond }

resourcestring
  rsSquareRootQuinticSecondSymbol = '√%ss⁵';
  rsSquareRootQuinticSecondName = 'square root quintic %ssecond';
  rsSquareRootQuinticSecondPluralName = 'square root quintic %sseconds';

const
  SquareRootQuinticSecondID = 87150;
  SquareRootQuinticSecondUnit : TUnit = (
    FID         : SquareRootQuinticSecondID;
    FSymbol     : rsSquareRootQuinticSecondSymbol;
    FName       : rsSquareRootQuinticSecondName;
    FPluralName : rsSquareRootQuinticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TQuarticRootAmpere }

resourcestring
  rsQuarticRootAmpereSymbol = '∜%sA';
  rsQuarticRootAmpereName = 'quartic root %sampere';
  rsQuarticRootAmperePluralName = 'quartic root %samperes';

const
  QuarticRootAmpereID = 6075;
  QuarticRootAmpereUnit : TUnit = (
    FID         : QuarticRootAmpereID;
    FSymbol     : rsQuarticRootAmpereSymbol;
    FName       : rsQuarticRootAmpereName;
    FPluralName : rsQuarticRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TCubicRootAmpere }

resourcestring
  rsCubicRootAmpereSymbol = '∛%sA';
  rsCubicRootAmpereName = 'cubic root %sampere';
  rsCubicRootAmperePluralName = 'cubic root %samperes';

const
  CubicRootAmpereID = 8100;
  CubicRootAmpereUnit : TUnit = (
    FID         : CubicRootAmpereID;
    FSymbol     : rsCubicRootAmpereSymbol;
    FName       : rsCubicRootAmpereName;
    FPluralName : rsCubicRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootAmpere }

resourcestring
  rsSquareRootAmpereSymbol = '√%sA';
  rsSquareRootAmpereName = 'square root %sampere';
  rsSquareRootAmperePluralName = 'square root %samperes';

const
  SquareRootAmpereID = 12150;
  SquareRootAmpereUnit : TUnit = (
    FID         : SquareRootAmpereID;
    FSymbol     : rsSquareRootAmpereSymbol;
    FName       : rsSquareRootAmpereName;
    FPluralName : rsSquareRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootCubicAmpere }

resourcestring
  rsSquareRootCubicAmpereSymbol = '√%sA³';
  rsSquareRootCubicAmpereName = 'square root cubic %sampere';
  rsSquareRootCubicAmperePluralName = 'square root cubic %samperes';

const
  SquareRootCubicAmpereID = 36450;
  SquareRootCubicAmpereUnit : TUnit = (
    FID         : SquareRootCubicAmpereID;
    FSymbol     : rsSquareRootCubicAmpereSymbol;
    FName       : rsSquareRootCubicAmpereName;
    FPluralName : rsSquareRootCubicAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootQuinticAmpere }

resourcestring
  rsSquareRootQuinticAmpereSymbol = '√%sA⁵';
  rsSquareRootQuinticAmpereName = 'square root quintic %sampere';
  rsSquareRootQuinticAmperePluralName = 'square root quintic %samperes';

const
  SquareRootQuinticAmpereID = 60750;
  SquareRootQuinticAmpereUnit : TUnit = (
    FID         : SquareRootQuinticAmpereID;
    FSymbol     : rsSquareRootQuinticAmpereSymbol;
    FName       : rsSquareRootQuinticAmpereName;
    FPluralName : rsSquareRootQuinticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TCubicAmpere }

resourcestring
  rsCubicAmpereSymbol = '%sA³';
  rsCubicAmpereName = 'cubic %sampere';
  rsCubicAmperePluralName = 'cubic %samperes';

const
  CubicAmpereID = 72900;
  CubicAmpereUnit : TUnit = (
    FID         : CubicAmpereID;
    FSymbol     : rsCubicAmpereSymbol;
    FName       : rsCubicAmpereName;
    FPluralName : rsCubicAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TQuarticAmpere }

resourcestring
  rsQuarticAmpereSymbol = '%sA⁴';
  rsQuarticAmpereName = 'quartic %sampere';
  rsQuarticAmperePluralName = 'quartic %samperes';

const
  QuarticAmpereID = 97200;
  QuarticAmpereUnit : TUnit = (
    FID         : QuarticAmpereID;
    FSymbol     : rsQuarticAmpereSymbol;
    FName       : rsQuarticAmpereName;
    FPluralName : rsQuarticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (4));

{ TQuinticAmpere }

resourcestring
  rsQuinticAmpereSymbol = '%sA⁵';
  rsQuinticAmpereName = 'quintic %sampere';
  rsQuinticAmperePluralName = 'quintic %samperes';

const
  QuinticAmpereID = 121500;
  QuinticAmpereUnit : TUnit = (
    FID         : QuinticAmpereID;
    FSymbol     : rsQuinticAmpereSymbol;
    FName       : rsQuinticAmpereName;
    FPluralName : rsQuinticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TSexticAmpere }

resourcestring
  rsSexticAmpereSymbol = '%sA⁶';
  rsSexticAmpereName = 'sextic %sampere';
  rsSexticAmperePluralName = 'sextic %samperes';

const
  SexticAmpereID = 145800;
  SexticAmpereUnit : TUnit = (
    FID         : SexticAmpereID;
    FSymbol     : rsSexticAmpereSymbol;
    FName       : rsSexticAmpereName;
    FPluralName : rsSexticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (6));

{ TQuarticRootKelvin }

resourcestring
  rsQuarticRootKelvinSymbol = '∜%sK';
  rsQuarticRootKelvinName = 'quartic root %skelvin';
  rsQuarticRootKelvinPluralName = 'quartic root %skelvins';

const
  QuarticRootKelvinID = 4755;
  QuarticRootKelvinUnit : TUnit = (
    FID         : QuarticRootKelvinID;
    FSymbol     : rsQuarticRootKelvinSymbol;
    FName       : rsQuarticRootKelvinName;
    FPluralName : rsQuarticRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TCubicRootKelvin }

resourcestring
  rsCubicRootKelvinSymbol = '∛%sK';
  rsCubicRootKelvinName = 'cubic root %skelvin';
  rsCubicRootKelvinPluralName = 'cubic root %skelvins';

const
  CubicRootKelvinID = 6340;
  CubicRootKelvinUnit : TUnit = (
    FID         : CubicRootKelvinID;
    FSymbol     : rsCubicRootKelvinSymbol;
    FName       : rsCubicRootKelvinName;
    FPluralName : rsCubicRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootKelvin }

resourcestring
  rsSquareRootKelvinSymbol = '√%sK';
  rsSquareRootKelvinName = 'square root %skelvin';
  rsSquareRootKelvinPluralName = 'square root %skelvins';

const
  SquareRootKelvinID = 9510;
  SquareRootKelvinUnit : TUnit = (
    FID         : SquareRootKelvinID;
    FSymbol     : rsSquareRootKelvinSymbol;
    FName       : rsSquareRootKelvinName;
    FPluralName : rsSquareRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootCubicKelvin }

resourcestring
  rsSquareRootCubicKelvinSymbol = '√%sK³';
  rsSquareRootCubicKelvinName = 'square root cubic %skelvin';
  rsSquareRootCubicKelvinPluralName = 'square root cubic %skelvins';

const
  SquareRootCubicKelvinID = 28530;
  SquareRootCubicKelvinUnit : TUnit = (
    FID         : SquareRootCubicKelvinID;
    FSymbol     : rsSquareRootCubicKelvinSymbol;
    FName       : rsSquareRootCubicKelvinName;
    FPluralName : rsSquareRootCubicKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootQuinticKelvin }

resourcestring
  rsSquareRootQuinticKelvinSymbol = '√%sK⁵';
  rsSquareRootQuinticKelvinName = 'square root quintic %skelvin';
  rsSquareRootQuinticKelvinPluralName = 'square root quintic %skelvins';

const
  SquareRootQuinticKelvinID = 47550;
  SquareRootQuinticKelvinUnit : TUnit = (
    FID         : SquareRootQuinticKelvinID;
    FSymbol     : rsSquareRootQuinticKelvinSymbol;
    FName       : rsSquareRootQuinticKelvinName;
    FPluralName : rsSquareRootQuinticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TQuinticKelvin }

resourcestring
  rsQuinticKelvinSymbol = '%sK⁵';
  rsQuinticKelvinName = 'quintic %skelvin';
  rsQuinticKelvinPluralName = 'quintic %skelvins';

const
  QuinticKelvinID = 95100;
  QuinticKelvinUnit : TUnit = (
    FID         : QuinticKelvinID;
    FSymbol     : rsQuinticKelvinSymbol;
    FName       : rsQuinticKelvinName;
    FPluralName : rsQuinticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TSexticKelvin }

resourcestring
  rsSexticKelvinSymbol = '%sK⁶';
  rsSexticKelvinName = 'sextic %skelvin';
  rsSexticKelvinPluralName = 'sextic %skelvins';

const
  SexticKelvinID = 114120;
  SexticKelvinUnit : TUnit = (
    FID         : SexticKelvinID;
    FSymbol     : rsSexticKelvinSymbol;
    FName       : rsSexticKelvinName;
    FPluralName : rsSexticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (6));

{ TQuarticRootMole }

resourcestring
  rsQuarticRootMoleSymbol = '∜%smol';
  rsQuarticRootMoleName = 'quartic root %smole';
  rsQuarticRootMolePluralName = 'quartic root %smoles';

const
  QuarticRootMoleID = 8670;
  QuarticRootMoleUnit : TUnit = (
    FID         : QuarticRootMoleID;
    FSymbol     : rsQuarticRootMoleSymbol;
    FName       : rsQuarticRootMoleName;
    FPluralName : rsQuarticRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TCubicRootMole }

resourcestring
  rsCubicRootMoleSymbol = '∛%smol';
  rsCubicRootMoleName = 'cubic root %smole';
  rsCubicRootMolePluralName = 'cubic root %smoles';

const
  CubicRootMoleID = 11560;
  CubicRootMoleUnit : TUnit = (
    FID         : CubicRootMoleID;
    FSymbol     : rsCubicRootMoleSymbol;
    FName       : rsCubicRootMoleName;
    FPluralName : rsCubicRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootMole }

resourcestring
  rsSquareRootMoleSymbol = '√%smol';
  rsSquareRootMoleName = 'square root %smole';
  rsSquareRootMolePluralName = 'square root %smoles';

const
  SquareRootMoleID = 17340;
  SquareRootMoleUnit : TUnit = (
    FID         : SquareRootMoleID;
    FSymbol     : rsSquareRootMoleSymbol;
    FName       : rsSquareRootMoleName;
    FPluralName : rsSquareRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootCubicMole }

resourcestring
  rsSquareRootCubicMoleSymbol = '√%smol³';
  rsSquareRootCubicMoleName = 'square root cubic %smole';
  rsSquareRootCubicMolePluralName = 'square root cubic %smoles';

const
  SquareRootCubicMoleID = 52020;
  SquareRootCubicMoleUnit : TUnit = (
    FID         : SquareRootCubicMoleID;
    FSymbol     : rsSquareRootCubicMoleSymbol;
    FName       : rsSquareRootCubicMoleName;
    FPluralName : rsSquareRootCubicMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareMole }

resourcestring
  rsSquareMoleSymbol = '%smol²';
  rsSquareMoleName = 'square %smole';
  rsSquareMolePluralName = 'square %smoles';

const
  SquareMoleID = 69360;
  SquareMoleUnit : TUnit = (
    FID         : SquareMoleID;
    FSymbol     : rsSquareMoleSymbol;
    FName       : rsSquareMoleName;
    FPluralName : rsSquareMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

{ TSquareRootQuinticMole }

resourcestring
  rsSquareRootQuinticMoleSymbol = '√%smol⁵';
  rsSquareRootQuinticMoleName = 'square root quintic %smole';
  rsSquareRootQuinticMolePluralName = 'square root quintic %smoles';

const
  SquareRootQuinticMoleID = 86700;
  SquareRootQuinticMoleUnit : TUnit = (
    FID         : SquareRootQuinticMoleID;
    FSymbol     : rsSquareRootQuinticMoleSymbol;
    FName       : rsSquareRootQuinticMoleName;
    FPluralName : rsSquareRootQuinticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TCubicMole }

resourcestring
  rsCubicMoleSymbol = '%smol³';
  rsCubicMoleName = 'cubic %smole';
  rsCubicMolePluralName = 'cubic %smoles';

const
  CubicMoleID = 104040;
  CubicMoleUnit : TUnit = (
    FID         : CubicMoleID;
    FSymbol     : rsCubicMoleSymbol;
    FName       : rsCubicMoleName;
    FPluralName : rsCubicMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TQuarticMole }

resourcestring
  rsQuarticMoleSymbol = '%smol⁴';
  rsQuarticMoleName = 'quartic %smole';
  rsQuarticMolePluralName = 'quartic %smoles';

const
  QuarticMoleID = 138720;
  QuarticMoleUnit : TUnit = (
    FID         : QuarticMoleID;
    FSymbol     : rsQuarticMoleSymbol;
    FName       : rsQuarticMoleName;
    FPluralName : rsQuarticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (4));

{ TQuinticMole }

resourcestring
  rsQuinticMoleSymbol = '%smol⁵';
  rsQuinticMoleName = 'quintic %smole';
  rsQuinticMolePluralName = 'quintic %smoles';

const
  QuinticMoleID = 173400;
  QuinticMoleUnit : TUnit = (
    FID         : QuinticMoleID;
    FSymbol     : rsQuinticMoleSymbol;
    FName       : rsQuinticMoleName;
    FPluralName : rsQuinticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TSexticMole }

resourcestring
  rsSexticMoleSymbol = '%smol⁶';
  rsSexticMoleName = 'sextic %smole';
  rsSexticMolePluralName = 'sextic %smoles';

const
  SexticMoleID = 208080;
  SexticMoleUnit : TUnit = (
    FID         : SexticMoleID;
    FSymbol     : rsSexticMoleSymbol;
    FName       : rsSexticMoleName;
    FPluralName : rsSexticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (6));

{ TQuarticRootCandela }

resourcestring
  rsQuarticRootCandelaSymbol = '∜%scd';
  rsQuarticRootCandelaName = 'quartic root %scandela';
  rsQuarticRootCandelaPluralName = 'quartic root %scandelas';

const
  QuarticRootCandelaID = 9990;
  QuarticRootCandelaUnit : TUnit = (
    FID         : QuarticRootCandelaID;
    FSymbol     : rsQuarticRootCandelaSymbol;
    FName       : rsQuarticRootCandelaName;
    FPluralName : rsQuarticRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TCubicRootCandela }

resourcestring
  rsCubicRootCandelaSymbol = '∛%scd';
  rsCubicRootCandelaName = 'cubic root %scandela';
  rsCubicRootCandelaPluralName = 'cubic root %scandelas';

const
  CubicRootCandelaID = 13320;
  CubicRootCandelaUnit : TUnit = (
    FID         : CubicRootCandelaID;
    FSymbol     : rsCubicRootCandelaSymbol;
    FName       : rsCubicRootCandelaName;
    FPluralName : rsCubicRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootCandela }

resourcestring
  rsSquareRootCandelaSymbol = '√%scd';
  rsSquareRootCandelaName = 'square root %scandela';
  rsSquareRootCandelaPluralName = 'square root %scandelas';

const
  SquareRootCandelaID = 19980;
  SquareRootCandelaUnit : TUnit = (
    FID         : SquareRootCandelaID;
    FSymbol     : rsSquareRootCandelaSymbol;
    FName       : rsSquareRootCandelaName;
    FPluralName : rsSquareRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootCubicCandela }

resourcestring
  rsSquareRootCubicCandelaSymbol = '√%scd³';
  rsSquareRootCubicCandelaName = 'square root cubic %scandela';
  rsSquareRootCubicCandelaPluralName = 'square root cubic %scandelas';

const
  SquareRootCubicCandelaID = 59940;
  SquareRootCubicCandelaUnit : TUnit = (
    FID         : SquareRootCubicCandelaID;
    FSymbol     : rsSquareRootCubicCandelaSymbol;
    FName       : rsSquareRootCubicCandelaName;
    FPluralName : rsSquareRootCubicCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareCandela }

resourcestring
  rsSquareCandelaSymbol = '%scd²';
  rsSquareCandelaName = 'square %scandela';
  rsSquareCandelaPluralName = 'square %scandelas';

const
  SquareCandelaID = 79920;
  SquareCandelaUnit : TUnit = (
    FID         : SquareCandelaID;
    FSymbol     : rsSquareCandelaSymbol;
    FName       : rsSquareCandelaName;
    FPluralName : rsSquareCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

{ TSquareRootQuinticCandela }

resourcestring
  rsSquareRootQuinticCandelaSymbol = '√%scd⁵';
  rsSquareRootQuinticCandelaName = 'square root quintic %scandela';
  rsSquareRootQuinticCandelaPluralName = 'square root quintic %scandelas';

const
  SquareRootQuinticCandelaID = 99900;
  SquareRootQuinticCandelaUnit : TUnit = (
    FID         : SquareRootQuinticCandelaID;
    FSymbol     : rsSquareRootQuinticCandelaSymbol;
    FName       : rsSquareRootQuinticCandelaName;
    FPluralName : rsSquareRootQuinticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TCubicCandela }

resourcestring
  rsCubicCandelaSymbol = '%scd³';
  rsCubicCandelaName = 'cubic %scandela';
  rsCubicCandelaPluralName = 'cubic %scandelas';

const
  CubicCandelaID = 119880;
  CubicCandelaUnit : TUnit = (
    FID         : CubicCandelaID;
    FSymbol     : rsCubicCandelaSymbol;
    FName       : rsCubicCandelaName;
    FPluralName : rsCubicCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TQuarticCandela }

resourcestring
  rsQuarticCandelaSymbol = '%scd⁴';
  rsQuarticCandelaName = 'quartic %scandela';
  rsQuarticCandelaPluralName = 'quartic %scandelas';

const
  QuarticCandelaID = 159840;
  QuarticCandelaUnit : TUnit = (
    FID         : QuarticCandelaID;
    FSymbol     : rsQuarticCandelaSymbol;
    FName       : rsQuarticCandelaName;
    FPluralName : rsQuarticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (4));

{ TQuinticCandela }

resourcestring
  rsQuinticCandelaSymbol = '%scd⁵';
  rsQuinticCandelaName = 'quintic %scandela';
  rsQuinticCandelaPluralName = 'quintic %scandelas';

const
  QuinticCandelaID = 199800;
  QuinticCandelaUnit : TUnit = (
    FID         : QuinticCandelaID;
    FSymbol     : rsQuinticCandelaSymbol;
    FName       : rsQuinticCandelaName;
    FPluralName : rsQuinticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TSexticCandela }

resourcestring
  rsSexticCandelaSymbol = '%scd⁶';
  rsSexticCandelaName = 'sextic %scandela';
  rsSexticCandelaPluralName = 'sextic %scandelas';

const
  SexticCandelaID = 239760;
  SexticCandelaUnit : TUnit = (
    FID         : SexticCandelaID;
    FSymbol     : rsSexticCandelaSymbol;
    FName       : rsSexticCandelaName;
    FPluralName : rsSexticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (6));

{ TQuarticRootSteradian }

resourcestring
  rsQuarticRootSteradianSymbol = '∜sr';
  rsQuarticRootSteradianName = 'quartic root steradian';
  rsQuarticRootSteradianPluralName = 'quartic root steradian';

const
  QuarticRootSteradianID = 9465;
  QuarticRootSteradianUnit : TUnit = (
    FID         : QuarticRootSteradianID;
    FSymbol     : rsQuarticRootSteradianSymbol;
    FName       : rsQuarticRootSteradianName;
    FPluralName : rsQuarticRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TCubicRootSteradian }

resourcestring
  rsCubicRootSteradianSymbol = '∛sr';
  rsCubicRootSteradianName = 'cubic root steradian';
  rsCubicRootSteradianPluralName = 'cubic root steradian';

const
  CubicRootSteradianID = 12620;
  CubicRootSteradianUnit : TUnit = (
    FID         : CubicRootSteradianID;
    FSymbol     : rsCubicRootSteradianSymbol;
    FName       : rsCubicRootSteradianName;
    FPluralName : rsCubicRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TSquareRootSteradian }

resourcestring
  rsSquareRootSteradianSymbol = '√sr';
  rsSquareRootSteradianName = 'square root steradian';
  rsSquareRootSteradianPluralName = 'square root steradian';

const
  SquareRootSteradianID = 18930;
  SquareRootSteradianUnit : TUnit = (
    FID         : SquareRootSteradianID;
    FSymbol     : rsSquareRootSteradianSymbol;
    FName       : rsSquareRootSteradianName;
    FPluralName : rsSquareRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TSquareRootCubicSteradian }

resourcestring
  rsSquareRootCubicSteradianSymbol = '√sr³';
  rsSquareRootCubicSteradianName = 'square root cubic steradian';
  rsSquareRootCubicSteradianPluralName = 'square root cubic steradian';

const
  SquareRootCubicSteradianID = 56790;
  SquareRootCubicSteradianUnit : TUnit = (
    FID         : SquareRootCubicSteradianID;
    FSymbol     : rsSquareRootCubicSteradianSymbol;
    FName       : rsSquareRootCubicSteradianName;
    FPluralName : rsSquareRootCubicSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TSquareSteradian }

resourcestring
  rsSquareSteradianSymbol = 'sr²';
  rsSquareSteradianName = 'square steradian';
  rsSquareSteradianPluralName = 'square steradian';

const
  SquareSteradianID = 75720;
  SquareSteradianUnit : TUnit = (
    FID         : SquareSteradianID;
    FSymbol     : rsSquareSteradianSymbol;
    FName       : rsSquareSteradianName;
    FPluralName : rsSquareSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TSquareRootQuinticSteradian }

resourcestring
  rsSquareRootQuinticSteradianSymbol = '√sr⁵';
  rsSquareRootQuinticSteradianName = 'square root quintic steradian';
  rsSquareRootQuinticSteradianPluralName = 'square root quintic steradian';

const
  SquareRootQuinticSteradianID = 94650;
  SquareRootQuinticSteradianUnit : TUnit = (
    FID         : SquareRootQuinticSteradianID;
    FSymbol     : rsSquareRootQuinticSteradianSymbol;
    FName       : rsSquareRootQuinticSteradianName;
    FPluralName : rsSquareRootQuinticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TCubicSteradian }

resourcestring
  rsCubicSteradianSymbol = 'sr³';
  rsCubicSteradianName = 'cubic steradian';
  rsCubicSteradianPluralName = 'cubic steradian';

const
  CubicSteradianID = 113580;
  CubicSteradianUnit : TUnit = (
    FID         : CubicSteradianID;
    FSymbol     : rsCubicSteradianSymbol;
    FName       : rsCubicSteradianName;
    FPluralName : rsCubicSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TQuarticSteradian }

resourcestring
  rsQuarticSteradianSymbol = 'sr⁴';
  rsQuarticSteradianName = 'quartic steradian';
  rsQuarticSteradianPluralName = 'quartic steradian';

const
  QuarticSteradianID = 151440;
  QuarticSteradianUnit : TUnit = (
    FID         : QuarticSteradianID;
    FSymbol     : rsQuarticSteradianSymbol;
    FName       : rsQuarticSteradianName;
    FPluralName : rsQuarticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TQuinticSteradian }

resourcestring
  rsQuinticSteradianSymbol = 'sr⁵';
  rsQuinticSteradianName = 'quintic steradian';
  rsQuinticSteradianPluralName = 'quintic steradian';

const
  QuinticSteradianID = 189300;
  QuinticSteradianUnit : TUnit = (
    FID         : QuinticSteradianID;
    FSymbol     : rsQuinticSteradianSymbol;
    FName       : rsQuinticSteradianName;
    FPluralName : rsQuinticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TSexticSteradian }

resourcestring
  rsSexticSteradianSymbol = 'sr⁶';
  rsSexticSteradianName = 'sextic steradian';
  rsSexticSteradianPluralName = 'sextic steradian';

const
  SexticSteradianID = 227160;
  SexticSteradianUnit : TUnit = (
    FID         : SexticSteradianID;
    FSymbol     : rsSexticSteradianSymbol;
    FName       : rsSexticSteradianName;
    FPluralName : rsSexticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalCubicSecond }

resourcestring
  rsReciprocalCubicSecondSymbol = '1/%ss³';
  rsReciprocalCubicSecondName = 'reciprocal cubic %ssecond';
  rsReciprocalCubicSecondPluralName = 'reciprocal cubic %ssecond';

const
  ReciprocalCubicSecondID = -104580;
  ReciprocalCubicSecondUnit : TUnit = (
    FID         : ReciprocalCubicSecondID;
    FSymbol     : rsReciprocalCubicSecondSymbol;
    FName       : rsReciprocalCubicSecondName;
    FPluralName : rsReciprocalCubicSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalQuarticSecond }

resourcestring
  rsReciprocalQuarticSecondSymbol = '1/%ss⁴';
  rsReciprocalQuarticSecondName = 'reciprocal quartic %ssecond';
  rsReciprocalQuarticSecondPluralName = 'reciprocal quartic %ssecond';

const
  ReciprocalQuarticSecondID = -139440;
  ReciprocalQuarticSecondUnit : TUnit = (
    FID         : ReciprocalQuarticSecondID;
    FSymbol     : rsReciprocalQuarticSecondSymbol;
    FName       : rsReciprocalQuarticSecondName;
    FPluralName : rsReciprocalQuarticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-4));

{ TReciprocalQuinticSecond }

resourcestring
  rsReciprocalQuinticSecondSymbol = '1/%ss⁵';
  rsReciprocalQuinticSecondName = 'reciprocal quintic %ssecond';
  rsReciprocalQuinticSecondPluralName = 'reciprocal quintic %ssecond';

const
  ReciprocalQuinticSecondID = -174300;
  ReciprocalQuinticSecondUnit : TUnit = (
    FID         : ReciprocalQuinticSecondID;
    FSymbol     : rsReciprocalQuinticSecondSymbol;
    FName       : rsReciprocalQuinticSecondName;
    FPluralName : rsReciprocalQuinticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticSecond }

resourcestring
  rsReciprocalSexticSecondSymbol = '1/%ss⁶';
  rsReciprocalSexticSecondName = 'reciprocal sextic %ssecond';
  rsReciprocalSexticSecondPluralName = 'reciprocal sextic %ssecond';

const
  ReciprocalSexticSecondID = -209160;
  ReciprocalSexticSecondUnit : TUnit = (
    FID         : ReciprocalSexticSecondID;
    FSymbol     : rsReciprocalSexticSecondSymbol;
    FName       : rsReciprocalSexticSecondName;
    FPluralName : rsReciprocalSexticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-6));

{ TSquareKilogramSquareMeter }

resourcestring
  rsSquareKilogramSquareMeterSymbol = '%skg²∙%sm²';
  rsSquareKilogramSquareMeterName = 'square %skilogram square %smeter';
  rsSquareKilogramSquareMeterPluralName = 'square %skilograms square %smeters';

const
  SquareKilogramSquareMeterID = 97680;
  SquareKilogramSquareMeterUnit : TUnit = (
    FID         : SquareKilogramSquareMeterID;
    FSymbol     : rsSquareKilogramSquareMeterSymbol;
    FName       : rsSquareKilogramSquareMeterName;
    FPluralName : rsSquareKilogramSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 2));

{ TSquareMeterPerQuarticSecond }

resourcestring
  rsSquareMeterPerQuarticSecondSymbol = '%sm²/%ss⁴';
  rsSquareMeterPerQuarticSecondName = 'square %smeter per quartic %ssecond';
  rsSquareMeterPerQuarticSecondPluralName = 'square %smeters per quartic %ssecond';

const
  SquareMeterPerQuarticSecondID = -59880;
  SquareMeterPerQuarticSecondUnit : TUnit = (
    FID         : SquareMeterPerQuarticSecondID;
    FSymbol     : rsSquareMeterPerQuarticSecondSymbol;
    FName       : rsSquareMeterPerQuarticSecondName;
    FPluralName : rsSquareMeterPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -4));

{ TSquareKilogramPerQuarticSecond }

resourcestring
  rsSquareKilogramPerQuarticSecondSymbol = '%skg²/%ss⁴';
  rsSquareKilogramPerQuarticSecondName = 'square %skilogram per quartic %ssecond';
  rsSquareKilogramPerQuarticSecondPluralName = 'square %skilograms per quartic %ssecond';

const
  SquareKilogramPerQuarticSecondID = -121320;
  SquareKilogramPerQuarticSecondUnit : TUnit = (
    FID         : SquareKilogramPerQuarticSecondID;
    FSymbol     : rsSquareKilogramPerQuarticSecondSymbol;
    FName       : rsSquareKilogramPerQuarticSecondName;
    FPluralName : rsSquareKilogramPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -4));

{ TReciprocalMeterSquareSecond }

resourcestring
  rsReciprocalMeterSquareSecondSymbol = '1/%sm/%ss²';
  rsReciprocalMeterSquareSecondName = 'reciprocal %smeter square %ssecond';
  rsReciprocalMeterSquareSecondPluralName = 'reciprocal %smeter square %ssecond';

const
  ReciprocalMeterSquareSecondID = -109500;
  ReciprocalMeterSquareSecondUnit : TUnit = (
    FID         : ReciprocalMeterSquareSecondID;
    FSymbol     : rsReciprocalMeterSquareSecondSymbol;
    FName       : rsReciprocalMeterSquareSecondName;
    FPluralName : rsReciprocalMeterSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -2));

{ TMeterAmpere }

resourcestring
  rsMeterAmpereSymbol = '%sm∙%sA';
  rsMeterAmpereName = '%smeter %sampere';
  rsMeterAmperePluralName = '%smeters %samperes';

const
  MeterAmpereID = 64080;
  MeterAmpereUnit : TUnit = (
    FID         : MeterAmpereID;
    FSymbol     : rsMeterAmpereSymbol;
    FName       : rsMeterAmpereName;
    FPluralName : rsMeterAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TSquareMeterPerCubicSecondPerAmpere }

resourcestring
  rsSquareMeterPerCubicSecondPerAmpereSymbol = '%sm²/%ss³/%sA';
  rsSquareMeterPerCubicSecondPerAmpereName = 'square %smeter per cubic %ssecond per %sampere';
  rsSquareMeterPerCubicSecondPerAmperePluralName = 'square %smeters per cubic %ssecond per %sampere';

const
  SquareMeterPerCubicSecondPerAmpereID = -49320;
  SquareMeterPerCubicSecondPerAmpereUnit : TUnit = (
    FID         : SquareMeterPerCubicSecondPerAmpereID;
    FSymbol     : rsSquareMeterPerCubicSecondPerAmpereSymbol;
    FName       : rsSquareMeterPerCubicSecondPerAmpereName;
    FPluralName : rsSquareMeterPerCubicSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -3, -1));

{ TKilogramPerCubicSecondPerAmpere }

resourcestring
  rsKilogramPerCubicSecondPerAmpereSymbol = '%skg/%ss³/%sA';
  rsKilogramPerCubicSecondPerAmpereName = '%skilogram per cubic %ssecond per %sampere';
  rsKilogramPerCubicSecondPerAmperePluralName = '%skilograms per cubic %ssecond per %sampere';

const
  KilogramPerCubicSecondPerAmpereID = -119820;
  KilogramPerCubicSecondPerAmpereUnit : TUnit = (
    FID         : KilogramPerCubicSecondPerAmpereID;
    FSymbol     : rsKilogramPerCubicSecondPerAmpereSymbol;
    FName       : rsKilogramPerCubicSecondPerAmpereName;
    FPluralName : rsKilogramPerCubicSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -3, -1));

{ TKilogramSquareMeterPerAmpere }

resourcestring
  rsKilogramSquareMeterPerAmpereSymbol = '%skg∙%sm²/%sA';
  rsKilogramSquareMeterPerAmpereName = '%skilogram square %smeter per %sampere';
  rsKilogramSquareMeterPerAmperePluralName = '%skilograms square %smeters per %sampere';

const
  KilogramSquareMeterPerAmpereID = 64320;
  KilogramSquareMeterPerAmpereUnit : TUnit = (
    FID         : KilogramSquareMeterPerAmpereID;
    FSymbol     : rsKilogramSquareMeterPerAmpereSymbol;
    FName       : rsKilogramSquareMeterPerAmpereName;
    FPluralName : rsKilogramSquareMeterPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TQuarticMeterPerSexticSecondPerSquareAmpere }

resourcestring
  rsQuarticMeterPerSexticSecondPerSquareAmpereSymbol = '%sm⁴/%ss⁶/%sA²';
  rsQuarticMeterPerSexticSecondPerSquareAmpereName = 'quartic %smeter per sextic %ssecond per square %sampere';
  rsQuarticMeterPerSexticSecondPerSquareAmperePluralName = 'quartic %smeters per sextic %ssecond per square %sampere';

const
  QuarticMeterPerSexticSecondPerSquareAmpereID = -98640;
  QuarticMeterPerSexticSecondPerSquareAmpereUnit : TUnit = (
    FID         : QuarticMeterPerSexticSecondPerSquareAmpereID;
    FSymbol     : rsQuarticMeterPerSexticSecondPerSquareAmpereSymbol;
    FName       : rsQuarticMeterPerSexticSecondPerSquareAmpereName;
    FPluralName : rsQuarticMeterPerSexticSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, -6, -2));

{ TSquareKilogramPerSexticSecondPerSquareAmpere }

resourcestring
  rsSquareKilogramPerSexticSecondPerSquareAmpereSymbol = '%skg²/%ss⁶/%sA²';
  rsSquareKilogramPerSexticSecondPerSquareAmpereName = 'square %skilogram per sextic %ssecond per square %sampere';
  rsSquareKilogramPerSexticSecondPerSquareAmperePluralName = 'square %skilograms per sextic %ssecond per square %sampere';

const
  SquareKilogramPerSexticSecondPerSquareAmpereID = -239640;
  SquareKilogramPerSexticSecondPerSquareAmpereUnit : TUnit = (
    FID         : SquareKilogramPerSexticSecondPerSquareAmpereID;
    FSymbol     : rsSquareKilogramPerSexticSecondPerSquareAmpereSymbol;
    FName       : rsSquareKilogramPerSexticSecondPerSquareAmpereName;
    FPluralName : rsSquareKilogramPerSexticSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -6, -2));

{ TSquareKilogramQuarticMeterPerSquareAmpere }

resourcestring
  rsSquareKilogramQuarticMeterPerSquareAmpereSymbol = '%skg²∙%sm⁴/%sA²';
  rsSquareKilogramQuarticMeterPerSquareAmpereName = 'square %skilogram quartic %smeter per square %sampere';
  rsSquareKilogramQuarticMeterPerSquareAmperePluralName = 'square %skilograms quartic %smeters per square %sampere';

const
  SquareKilogramQuarticMeterPerSquareAmpereID = 128640;
  SquareKilogramQuarticMeterPerSquareAmpereUnit : TUnit = (
    FID         : SquareKilogramQuarticMeterPerSquareAmpereID;
    FSymbol     : rsSquareKilogramQuarticMeterPerSquareAmpereSymbol;
    FName       : rsSquareKilogramQuarticMeterPerSquareAmpereName;
    FPluralName : rsSquareKilogramQuarticMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 4, -2));

{ TSquareKilogramQuarticMeterPerSexticSecond }

resourcestring
  rsSquareKilogramQuarticMeterPerSexticSecondSymbol = '%skg²∙%sm⁴/%ss⁶';
  rsSquareKilogramQuarticMeterPerSexticSecondName = 'square %skilogram quartic %smeter per sextic %ssecond';
  rsSquareKilogramQuarticMeterPerSexticSecondPluralName = 'square %skilograms quartic %smeters per sextic %ssecond';

const
  SquareKilogramQuarticMeterPerSexticSecondID = -31920;
  SquareKilogramQuarticMeterPerSexticSecondUnit : TUnit = (
    FID         : SquareKilogramQuarticMeterPerSexticSecondID;
    FSymbol     : rsSquareKilogramQuarticMeterPerSexticSecondSymbol;
    FName       : rsSquareKilogramQuarticMeterPerSexticSecondName;
    FPluralName : rsSquareKilogramQuarticMeterPerSexticSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 4, -6));

{ TQuarticSecondSquareAmperePerSquareMeter }

resourcestring
  rsQuarticSecondSquareAmperePerSquareMeterSymbol = '%ss⁴∙%sA²/%sm²';
  rsQuarticSecondSquareAmperePerSquareMeterName = 'quartic %ssecond square %sampere per square %smeter';
  rsQuarticSecondSquareAmperePerSquareMeterPluralName = 'quartic %sseconds square %samperes per square %smeter';

const
  QuarticSecondSquareAmperePerSquareMeterID = 108480;
  QuarticSecondSquareAmperePerSquareMeterUnit : TUnit = (
    FID         : QuarticSecondSquareAmperePerSquareMeterID;
    FSymbol     : rsQuarticSecondSquareAmperePerSquareMeterSymbol;
    FName       : rsQuarticSecondSquareAmperePerSquareMeterName;
    FPluralName : rsQuarticSecondSquareAmperePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, 2, -2));

{ TQuarticSecondSquareAmperePerKilogram }

resourcestring
  rsQuarticSecondSquareAmperePerKilogramSymbol = '%ss⁴∙%sA²/%skg';
  rsQuarticSecondSquareAmperePerKilogramName = 'quartic %ssecond square %sampere per %skilogram';
  rsQuarticSecondSquareAmperePerKilogramPluralName = 'quartic %sseconds square %samperes per %skilogram';

const
  QuarticSecondSquareAmperePerKilogramID = 178980;
  QuarticSecondSquareAmperePerKilogramUnit : TUnit = (
    FID         : QuarticSecondSquareAmperePerKilogramID;
    FSymbol     : rsQuarticSecondSquareAmperePerKilogramSymbol;
    FName       : rsQuarticSecondSquareAmperePerKilogramName;
    FPluralName : rsQuarticSecondSquareAmperePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, 2, -1));

{ TSquareAmperePerKilogramPerSquareMeter }

resourcestring
  rsSquareAmperePerKilogramPerSquareMeterSymbol = '%sA²/%skg/%sm²';
  rsSquareAmperePerKilogramPerSquareMeterName = 'square %sampere per %skilogram per square %smeter';
  rsSquareAmperePerKilogramPerSquareMeterPluralName = 'square %samperes per %skilogram per square %smeter';

const
  SquareAmperePerKilogramPerSquareMeterID = -40020;
  SquareAmperePerKilogramPerSquareMeterUnit : TUnit = (
    FID         : SquareAmperePerKilogramPerSquareMeterID;
    FSymbol     : rsSquareAmperePerKilogramPerSquareMeterSymbol;
    FName       : rsSquareAmperePerKilogramPerSquareMeterName;
    FPluralName : rsSquareAmperePerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -2));

{ TQuarticSecondPerKilogramPerSquareMeter }

resourcestring
  rsQuarticSecondPerKilogramPerSquareMeterSymbol = '%ss⁴/%skg/%sm²';
  rsQuarticSecondPerKilogramPerSquareMeterName = 'quartic %ssecond per %skilogram per square %smeter';
  rsQuarticSecondPerKilogramPerSquareMeterPluralName = 'quartic %sseconds per %skilogram per square %smeter';

const
  QuarticSecondPerKilogramPerSquareMeterID = 50820;
  QuarticSecondPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : QuarticSecondPerKilogramPerSquareMeterID;
    FSymbol     : rsQuarticSecondPerKilogramPerSquareMeterSymbol;
    FName       : rsQuarticSecondPerKilogramPerSquareMeterName;
    FPluralName : rsQuarticSecondPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, -1, -2));

{ TSquareMeterPerCubicSecondPerSquareAmpere }

resourcestring
  rsSquareMeterPerCubicSecondPerSquareAmpereSymbol = '%sm²/%ss³/%sA²';
  rsSquareMeterPerCubicSecondPerSquareAmpereName = 'square %smeter per cubic %ssecond per square %sampere';
  rsSquareMeterPerCubicSecondPerSquareAmperePluralName = 'square %smeters per cubic %ssecond per square %sampere';

const
  SquareMeterPerCubicSecondPerSquareAmpereID = -73620;
  SquareMeterPerCubicSecondPerSquareAmpereUnit : TUnit = (
    FID         : SquareMeterPerCubicSecondPerSquareAmpereID;
    FSymbol     : rsSquareMeterPerCubicSecondPerSquareAmpereSymbol;
    FName       : rsSquareMeterPerCubicSecondPerSquareAmpereName;
    FPluralName : rsSquareMeterPerCubicSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -3, -2));

{ TKilogramPerCubicSecondPerSquareAmpere }

resourcestring
  rsKilogramPerCubicSecondPerSquareAmpereSymbol = '%skg/%ss³/%sA²';
  rsKilogramPerCubicSecondPerSquareAmpereName = '%skilogram per cubic %ssecond per square %sampere';
  rsKilogramPerCubicSecondPerSquareAmperePluralName = '%skilograms per cubic %ssecond per square %sampere';

const
  KilogramPerCubicSecondPerSquareAmpereID = -144120;
  KilogramPerCubicSecondPerSquareAmpereUnit : TUnit = (
    FID         : KilogramPerCubicSecondPerSquareAmpereID;
    FSymbol     : rsKilogramPerCubicSecondPerSquareAmpereSymbol;
    FName       : rsKilogramPerCubicSecondPerSquareAmpereName;
    FPluralName : rsKilogramPerCubicSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -3, -2));

{ TKilogramSquareMeterPerSquareAmpere }

resourcestring
  rsKilogramSquareMeterPerSquareAmpereSymbol = '%skg∙%sm²/%sA²';
  rsKilogramSquareMeterPerSquareAmpereName = '%skilogram square %smeter per square %sampere';
  rsKilogramSquareMeterPerSquareAmperePluralName = '%skilograms square %smeters per square %sampere';

const
  KilogramSquareMeterPerSquareAmpereID = 40020;
  KilogramSquareMeterPerSquareAmpereUnit : TUnit = (
    FID         : KilogramSquareMeterPerSquareAmpereID;
    FSymbol     : rsKilogramSquareMeterPerSquareAmpereSymbol;
    FName       : rsKilogramSquareMeterPerSquareAmpereName;
    FPluralName : rsKilogramSquareMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -2));

{ TCubicSecondSquareAmperePerSquareMeter }

resourcestring
  rsCubicSecondSquareAmperePerSquareMeterSymbol = '%ss³∙%sA²/%sm²';
  rsCubicSecondSquareAmperePerSquareMeterName = 'cubic %ssecond square %sampere per square %smeter';
  rsCubicSecondSquareAmperePerSquareMeterPluralName = 'cubic %sseconds square %samperes per square %smeter';

const
  CubicSecondSquareAmperePerSquareMeterID = 73620;
  CubicSecondSquareAmperePerSquareMeterUnit : TUnit = (
    FID         : CubicSecondSquareAmperePerSquareMeterID;
    FSymbol     : rsCubicSecondSquareAmperePerSquareMeterSymbol;
    FName       : rsCubicSecondSquareAmperePerSquareMeterName;
    FPluralName : rsCubicSecondSquareAmperePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 2, -2));

{ TCubicSecondSquareAmperePerKilogram }

resourcestring
  rsCubicSecondSquareAmperePerKilogramSymbol = '%ss³∙%sA²/%skg';
  rsCubicSecondSquareAmperePerKilogramName = 'cubic %ssecond square %sampere per %skilogram';
  rsCubicSecondSquareAmperePerKilogramPluralName = 'cubic %sseconds square %samperes per %skilogram';

const
  CubicSecondSquareAmperePerKilogramID = 144120;
  CubicSecondSquareAmperePerKilogramUnit : TUnit = (
    FID         : CubicSecondSquareAmperePerKilogramID;
    FSymbol     : rsCubicSecondSquareAmperePerKilogramSymbol;
    FName       : rsCubicSecondSquareAmperePerKilogramName;
    FPluralName : rsCubicSecondSquareAmperePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 2, -1));

{ TCubicSecondSquareAmperePerCubicMeter }

resourcestring
  rsCubicSecondSquareAmperePerCubicMeterSymbol = '%ss³∙%sA²/%sm³';
  rsCubicSecondSquareAmperePerCubicMeterName = 'cubic %ssecond square %sampere per cubic %smeter';
  rsCubicSecondSquareAmperePerCubicMeterPluralName = 'cubic %sseconds square %samperes per cubic %smeter';

const
  CubicSecondSquareAmperePerCubicMeterID = 33840;
  CubicSecondSquareAmperePerCubicMeterUnit : TUnit = (
    FID         : CubicSecondSquareAmperePerCubicMeterID;
    FSymbol     : rsCubicSecondSquareAmperePerCubicMeterSymbol;
    FName       : rsCubicSecondSquareAmperePerCubicMeterName;
    FPluralName : rsCubicSecondSquareAmperePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 2, -3));

{ TSquareAmperePerKilogramPerCubicMeter }

resourcestring
  rsSquareAmperePerKilogramPerCubicMeterSymbol = '%sA²/%skg/%sm³';
  rsSquareAmperePerKilogramPerCubicMeterName = 'square %sampere per %skilogram per cubic %smeter';
  rsSquareAmperePerKilogramPerCubicMeterPluralName = 'square %samperes per %skilogram per cubic %smeter';

const
  SquareAmperePerKilogramPerCubicMeterID = -79800;
  SquareAmperePerKilogramPerCubicMeterUnit : TUnit = (
    FID         : SquareAmperePerKilogramPerCubicMeterID;
    FSymbol     : rsSquareAmperePerKilogramPerCubicMeterSymbol;
    FName       : rsSquareAmperePerKilogramPerCubicMeterName;
    FPluralName : rsSquareAmperePerKilogramPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -3));

{ TCubicSecondPerKilogramPerCubicMeter }

resourcestring
  rsCubicSecondPerKilogramPerCubicMeterSymbol = '%ss³/%skg/%sm³';
  rsCubicSecondPerKilogramPerCubicMeterName = 'cubic %ssecond per %skilogram per cubic %smeter';
  rsCubicSecondPerKilogramPerCubicMeterPluralName = 'cubic %sseconds per %skilogram per cubic %smeter';

const
  CubicSecondPerKilogramPerCubicMeterID = -23820;
  CubicSecondPerKilogramPerCubicMeterUnit : TUnit = (
    FID         : CubicSecondPerKilogramPerCubicMeterID;
    FSymbol     : rsCubicSecondPerKilogramPerCubicMeterSymbol;
    FName       : rsCubicSecondPerKilogramPerCubicMeterName;
    FPluralName : rsCubicSecondPerKilogramPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -1, -3));

{ TReciprocalSquareSecondAmpere }

resourcestring
  rsReciprocalSquareSecondAmpereSymbol = '1/%ss²/%sA';
  rsReciprocalSquareSecondAmpereName = 'reciprocal square %ssecond %sampere';
  rsReciprocalSquareSecondAmperePluralName = 'reciprocal square %ssecond %sampere';

const
  ReciprocalSquareSecondAmpereID = -94020;
  ReciprocalSquareSecondAmpereUnit : TUnit = (
    FID         : ReciprocalSquareSecondAmpereID;
    FSymbol     : rsReciprocalSquareSecondAmpereSymbol;
    FName       : rsReciprocalSquareSecondAmpereName;
    FPluralName : rsReciprocalSquareSecondAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -1));

{ TKilogramPerAmpere }

resourcestring
  rsKilogramPerAmpereSymbol = '%skg/%sA';
  rsKilogramPerAmpereName = '%skilogram per %sampere';
  rsKilogramPerAmperePluralName = '%skilograms per %sampere';

const
  KilogramPerAmpereID = -15240;
  KilogramPerAmpereUnit : TUnit = (
    FID         : KilogramPerAmpereID;
    FSymbol     : rsKilogramPerAmpereSymbol;
    FName       : rsKilogramPerAmpereName;
    FPluralName : rsKilogramPerAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareMeterPerSquareSecondPerAmpere }

resourcestring
  rsSquareMeterPerSquareSecondPerAmpereSymbol = '%sm²/%ss²/%sA';
  rsSquareMeterPerSquareSecondPerAmpereName = 'square %smeter per square %ssecond per %sampere';
  rsSquareMeterPerSquareSecondPerAmperePluralName = 'square %smeters per square %ssecond per %sampere';

const
  SquareMeterPerSquareSecondPerAmpereID = -14460;
  SquareMeterPerSquareSecondPerAmpereUnit : TUnit = (
    FID         : SquareMeterPerSquareSecondPerAmpereID;
    FSymbol     : rsSquareMeterPerSquareSecondPerAmpereSymbol;
    FName       : rsSquareMeterPerSquareSecondPerAmpereName;
    FPluralName : rsSquareMeterPerSquareSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -2, -1));

{ TSquareSecondSquareAmperePerSquareMeter }

resourcestring
  rsSquareSecondSquareAmperePerSquareMeterSymbol = '%ss²∙%sA²/%sm²';
  rsSquareSecondSquareAmperePerSquareMeterName = 'square %ssecond square %sampere per square %smeter';
  rsSquareSecondSquareAmperePerSquareMeterPluralName = 'square %sseconds square %samperes per square %smeter';

const
  SquareSecondSquareAmperePerSquareMeterID = 38760;
  SquareSecondSquareAmperePerSquareMeterUnit : TUnit = (
    FID         : SquareSecondSquareAmperePerSquareMeterID;
    FSymbol     : rsSquareSecondSquareAmperePerSquareMeterSymbol;
    FName       : rsSquareSecondSquareAmperePerSquareMeterName;
    FPluralName : rsSquareSecondSquareAmperePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 2, -2));

{ TSquareSecondSquareAmperePerKilogram }

resourcestring
  rsSquareSecondSquareAmperePerKilogramSymbol = '%ss²∙%sA²/%skg';
  rsSquareSecondSquareAmperePerKilogramName = 'square %ssecond square %sampere per %skilogram';
  rsSquareSecondSquareAmperePerKilogramPluralName = 'square %sseconds square %samperes per %skilogram';

const
  SquareSecondSquareAmperePerKilogramID = 109260;
  SquareSecondSquareAmperePerKilogramUnit : TUnit = (
    FID         : SquareSecondSquareAmperePerKilogramID;
    FSymbol     : rsSquareSecondSquareAmperePerKilogramSymbol;
    FName       : rsSquareSecondSquareAmperePerKilogramName;
    FPluralName : rsSquareSecondSquareAmperePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 2, -1));

{ TSquareSecondPerKilogramPerSquareMeter }

resourcestring
  rsSquareSecondPerKilogramPerSquareMeterSymbol = '%ss²/%skg/%sm²';
  rsSquareSecondPerKilogramPerSquareMeterName = 'square %ssecond per %skilogram per square %smeter';
  rsSquareSecondPerKilogramPerSquareMeterPluralName = 'square %sseconds per %skilogram per square %smeter';

const
  SquareSecondPerKilogramPerSquareMeterID = -18900;
  SquareSecondPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : SquareSecondPerKilogramPerSquareMeterID;
    FSymbol     : rsSquareSecondPerKilogramPerSquareMeterSymbol;
    FName       : rsSquareSecondPerKilogramPerSquareMeterName;
    FPluralName : rsSquareSecondPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -2));

{ TSecondSteradian }

resourcestring
  rsSecondSteradianSymbol = '%ss∙sr';
  rsSecondSteradianName = '%ssecond steradian';
  rsSecondSteradianPluralName = '%sseconds steradian';

const
  SecondSteradianID = 72720;
  SecondSteradianUnit : TUnit = (
    FID         : SecondSteradianID;
    FSymbol     : rsSecondSteradianSymbol;
    FName       : rsSecondSteradianName;
    FPluralName : rsSecondSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSecondCandela }

resourcestring
  rsSecondCandelaSymbol = '%ss∙%scd';
  rsSecondCandelaName = '%ssecond %scandela';
  rsSecondCandelaPluralName = '%sseconds %scandelas';

const
  SecondCandelaID = 74820;
  SecondCandelaUnit : TUnit = (
    FID         : SecondCandelaID;
    FSymbol     : rsSecondCandelaSymbol;
    FName       : rsSecondCandelaName;
    FPluralName : rsSecondCandelaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TCandelaSteradianPerCubicMeter }

resourcestring
  rsCandelaSteradianPerCubicMeterSymbol = '%scd∙sr/%sm³';
  rsCandelaSteradianPerCubicMeterName = '%scandela steradian per cubic %smeter';
  rsCandelaSteradianPerCubicMeterPluralName = '%scandelas steradian per cubic %smeter';

const
  CandelaSteradianPerCubicMeterID = -41520;
  CandelaSteradianPerCubicMeterUnit : TUnit = (
    FID         : CandelaSteradianPerCubicMeterID;
    FSymbol     : rsCandelaSteradianPerCubicMeterSymbol;
    FName       : rsCandelaSteradianPerCubicMeterName;
    FPluralName : rsCandelaSteradianPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TSecondSteradianPerCubicMeter }

resourcestring
  rsSecondSteradianPerCubicMeterSymbol = '%ss∙sr/%sm³';
  rsSecondSteradianPerCubicMeterName = '%ssecond steradian per cubic %smeter';
  rsSecondSteradianPerCubicMeterPluralName = '%sseconds steradian per cubic %smeter';

const
  SecondSteradianPerCubicMeterID = -46620;
  SecondSteradianPerCubicMeterUnit : TUnit = (
    FID         : SecondSteradianPerCubicMeterID;
    FSymbol     : rsSecondSteradianPerCubicMeterSymbol;
    FName       : rsSecondSteradianPerCubicMeterName;
    FPluralName : rsSecondSteradianPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TSecondCandelaPerCubicMeter }

resourcestring
  rsSecondCandelaPerCubicMeterSymbol = '%ss∙%scd/%sm³';
  rsSecondCandelaPerCubicMeterName = '%ssecond %scandela per cubic %smeter';
  rsSecondCandelaPerCubicMeterPluralName = '%sseconds %scandelas per cubic %smeter';

const
  SecondCandelaPerCubicMeterID = -44520;
  SecondCandelaPerCubicMeterUnit : TUnit = (
    FID         : SecondCandelaPerCubicMeterID;
    FSymbol     : rsSecondCandelaPerCubicMeterSymbol;
    FName       : rsSecondCandelaPerCubicMeterName;
    FPluralName : rsSecondCandelaPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -3));

{ TSteradianPerSquareMeter }

resourcestring
  rsSteradianPerSquareMeterSymbol = 'sr/%sm²';
  rsSteradianPerSquareMeterName = 'steradian per square %smeter';
  rsSteradianPerSquareMeterPluralName = 'steradian per square %smeter';

const
  SteradianPerSquareMeterID = -41700;
  SteradianPerSquareMeterUnit : TUnit = (
    FID         : SteradianPerSquareMeterID;
    FSymbol     : rsSteradianPerSquareMeterSymbol;
    FName       : rsSteradianPerSquareMeterName;
    FPluralName : rsSteradianPerSquareMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TSecondSteradianPerSquareMeter }

resourcestring
  rsSecondSteradianPerSquareMeterSymbol = '%ss∙sr/%sm²';
  rsSecondSteradianPerSquareMeterName = '%ssecond steradian per square %smeter';
  rsSecondSteradianPerSquareMeterPluralName = '%sseconds steradian per square %smeter';

const
  SecondSteradianPerSquareMeterID = -6840;
  SecondSteradianPerSquareMeterUnit : TUnit = (
    FID         : SecondSteradianPerSquareMeterID;
    FSymbol     : rsSecondSteradianPerSquareMeterSymbol;
    FName       : rsSecondSteradianPerSquareMeterName;
    FPluralName : rsSecondSteradianPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TSecondCandelaPerSquareMeter }

resourcestring
  rsSecondCandelaPerSquareMeterSymbol = '%ss∙%scd/%sm²';
  rsSecondCandelaPerSquareMeterName = '%ssecond %scandela per square %smeter';
  rsSecondCandelaPerSquareMeterPluralName = '%sseconds %scandelas per square %smeter';

const
  SecondCandelaPerSquareMeterID = -4740;
  SecondCandelaPerSquareMeterUnit : TUnit = (
    FID         : SecondCandelaPerSquareMeterID;
    FSymbol     : rsSecondCandelaPerSquareMeterSymbol;
    FName       : rsSecondCandelaPerSquareMeterName;
    FPluralName : rsSecondCandelaPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -2));

{ TReciprocalSquareMeterSquareSecond }

resourcestring
  rsReciprocalSquareMeterSquareSecondSymbol = '1/%sm²/%ss²';
  rsReciprocalSquareMeterSquareSecondName = 'reciprocal square %smeter square %ssecond';
  rsReciprocalSquareMeterSquareSecondPluralName = 'reciprocal square %smeter square %ssecond';

const
  ReciprocalSquareMeterSquareSecondID = -149280;
  ReciprocalSquareMeterSquareSecondUnit : TUnit = (
    FID         : ReciprocalSquareMeterSquareSecondID;
    FSymbol     : rsReciprocalSquareMeterSquareSecondSymbol;
    FName       : rsReciprocalSquareMeterSquareSecondName;
    FPluralName : rsReciprocalSquareMeterSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -2));

{ TReciprocalMeterSecond }

resourcestring
  rsReciprocalMeterSecondSymbol = '1/%sm/%ss';
  rsReciprocalMeterSecondName = 'reciprocal %smeter %ssecond';
  rsReciprocalMeterSecondPluralName = 'reciprocal %smeter %ssecond';

const
  ReciprocalMeterSecondID = -74640;
  ReciprocalMeterSecondUnit : TUnit = (
    FID         : ReciprocalMeterSecondID;
    FSymbol     : rsReciprocalMeterSecondSymbol;
    FName       : rsReciprocalMeterSecondName;
    FPluralName : rsReciprocalMeterSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TReciprocalQuarticMeterSecond }

resourcestring
  rsReciprocalQuarticMeterSecondSymbol = '1/%sm⁴/%ss';
  rsReciprocalQuarticMeterSecondName = 'reciprocal quartic %smeter %ssecond';
  rsReciprocalQuarticMeterSecondPluralName = 'reciprocal quartic %smeter %ssecond';

const
  ReciprocalQuarticMeterSecondID = -193980;
  ReciprocalQuarticMeterSecondUnit : TUnit = (
    FID         : ReciprocalQuarticMeterSecondID;
    FSymbol     : rsReciprocalQuarticMeterSecondSymbol;
    FName       : rsReciprocalQuarticMeterSecondName;
    FPluralName : rsReciprocalQuarticMeterSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-4, -1));

{ TReciprocalKilogram }

resourcestring
  rsReciprocalKilogramSymbol = '1/%skg';
  rsReciprocalKilogramName = 'reciprocal %skilogram';
  rsReciprocalKilogramPluralName = 'reciprocal %skilogram';

const
  ReciprocalKilogramID = -9060;
  ReciprocalKilogramUnit : TUnit = (
    FID         : ReciprocalKilogramID;
    FSymbol     : rsReciprocalKilogramSymbol;
    FName       : rsReciprocalKilogramName;
    FPluralName : rsReciprocalKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TKilogramCubicMeter }

resourcestring
  rsKilogramCubicMeterSymbol = '%skg∙%sm³';
  rsKilogramCubicMeterName = '%skilogram cubic %smeter';
  rsKilogramCubicMeterPluralName = '%skilograms cubic %smeters';

const
  KilogramCubicMeterID = 128400;
  KilogramCubicMeterUnit : TUnit = (
    FID         : KilogramCubicMeterID;
    FSymbol     : rsKilogramCubicMeterSymbol;
    FName       : rsKilogramCubicMeterName;
    FPluralName : rsKilogramCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 3));

{ TQuarticMeterPerSquareSecond }

resourcestring
  rsQuarticMeterPerSquareSecondSymbol = '%sm⁴/%ss²';
  rsQuarticMeterPerSquareSecondName = 'quartic %smeter per square %ssecond';
  rsQuarticMeterPerSquareSecondPluralName = 'quartic %smeters per square %ssecond';

const
  QuarticMeterPerSquareSecondID = 89400;
  QuarticMeterPerSquareSecondUnit : TUnit = (
    FID         : QuarticMeterPerSquareSecondID;
    FSymbol     : rsQuarticMeterPerSquareSecondSymbol;
    FName       : rsQuarticMeterPerSquareSecondName;
    FPluralName : rsQuarticMeterPerSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -2));

{ TKilogramQuarticMeter }

resourcestring
  rsKilogramQuarticMeterSymbol = '%skg∙%sm⁴';
  rsKilogramQuarticMeterName = '%skilogram quartic %smeter';
  rsKilogramQuarticMeterPluralName = '%skilograms quartic %smeters';

const
  KilogramQuarticMeterID = 168180;
  KilogramQuarticMeterUnit : TUnit = (
    FID         : KilogramQuarticMeterID;
    FSymbol     : rsKilogramQuarticMeterSymbol;
    FName       : rsKilogramQuarticMeterName;
    FPluralName : rsKilogramQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 4));

{ TReciprocalKilogramSquareSecond }

resourcestring
  rsReciprocalKilogramSquareSecondSymbol = '1/%skg/%ss²';
  rsReciprocalKilogramSquareSecondName = 'reciprocal %skilogram square %ssecond';
  rsReciprocalKilogramSquareSecondPluralName = 'reciprocal %skilogram square %ssecond';

const
  ReciprocalKilogramSquareSecondID = -78780;
  ReciprocalKilogramSquareSecondUnit : TUnit = (
    FID         : ReciprocalKilogramSquareSecondID;
    FSymbol     : rsReciprocalKilogramSquareSecondSymbol;
    FName       : rsReciprocalKilogramSquareSecondName;
    FPluralName : rsReciprocalKilogramSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -2));

{ TMeterPerKilogram }

resourcestring
  rsMeterPerKilogramSymbol = '%sm/%skg';
  rsMeterPerKilogramName = '%smeter per %skilogram';
  rsMeterPerKilogramPluralName = '%smeters per %skilogram';

const
  MeterPerKilogramID = 30720;
  MeterPerKilogramUnit : TUnit = (
    FID         : MeterPerKilogramID;
    FSymbol     : rsMeterPerKilogramSymbol;
    FName       : rsMeterPerKilogramName;
    FPluralName : rsMeterPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TReciprocalSquareKilogram }

resourcestring
  rsReciprocalSquareKilogramSymbol = '1/%skg²';
  rsReciprocalSquareKilogramName = 'reciprocal square %skilogram';
  rsReciprocalSquareKilogramPluralName = 'reciprocal square %skilogram';

const
  ReciprocalSquareKilogramID = -18120;
  ReciprocalSquareKilogramUnit : TUnit = (
    FID         : ReciprocalSquareKilogramID;
    FSymbol     : rsReciprocalSquareKilogramSymbol;
    FName       : rsReciprocalSquareKilogramName;
    FPluralName : rsReciprocalSquareKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TKilogramPerSquareSecondPerKelvin }

resourcestring
  rsKilogramPerSquareSecondPerKelvinSymbol = '%skg/%ss²/%sK';
  rsKilogramPerSquareSecondPerKelvinName = '%skilogram per square %ssecond per %skelvin';
  rsKilogramPerSquareSecondPerKelvinPluralName = '%skilograms per square %ssecond per %skelvin';

const
  KilogramPerSquareSecondPerKelvinID = -79680;
  KilogramPerSquareSecondPerKelvinUnit : TUnit = (
    FID         : KilogramPerSquareSecondPerKelvinID;
    FSymbol     : rsKilogramPerSquareSecondPerKelvinSymbol;
    FName       : rsKilogramPerSquareSecondPerKelvinName;
    FPluralName : rsKilogramPerSquareSecondPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -1));

{ TKilogramSquareMeterPerKelvin }

resourcestring
  rsKilogramSquareMeterPerKelvinSymbol = '%skg∙%sm²/%sK';
  rsKilogramSquareMeterPerKelvinName = '%skilogram square %smeter per %skelvin';
  rsKilogramSquareMeterPerKelvinPluralName = '%skilograms square %smeters per %skelvin';

const
  KilogramSquareMeterPerKelvinID = 69600;
  KilogramSquareMeterPerKelvinUnit : TUnit = (
    FID         : KilogramSquareMeterPerKelvinID;
    FSymbol     : rsKilogramSquareMeterPerKelvinSymbol;
    FName       : rsKilogramSquareMeterPerKelvinName;
    FPluralName : rsKilogramSquareMeterPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TReciprocalSquareSecondKelvin }

resourcestring
  rsReciprocalSquareSecondKelvinSymbol = '1/%ss²/%sK';
  rsReciprocalSquareSecondKelvinName = 'reciprocal square %ssecond %skelvin';
  rsReciprocalSquareSecondKelvinPluralName = 'reciprocal square %ssecond %skelvin';

const
  ReciprocalSquareSecondKelvinID = -88740;
  ReciprocalSquareSecondKelvinUnit : TUnit = (
    FID         : ReciprocalSquareSecondKelvinID;
    FSymbol     : rsReciprocalSquareSecondKelvinSymbol;
    FName       : rsReciprocalSquareSecondKelvinName;
    FPluralName : rsReciprocalSquareSecondKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -1));

{ TSquareMeterPerKelvin }

resourcestring
  rsSquareMeterPerKelvinSymbol = '%sm²/%sK';
  rsSquareMeterPerKelvinName = 'square %smeter per %skelvin';
  rsSquareMeterPerKelvinPluralName = 'square %smeters per %skelvin';

const
  SquareMeterPerKelvinID = 60540;
  SquareMeterPerKelvinUnit : TUnit = (
    FID         : SquareMeterPerKelvinID;
    FSymbol     : rsSquareMeterPerKelvinSymbol;
    FName       : rsSquareMeterPerKelvinName;
    FPluralName : rsSquareMeterPerKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TReciprocalMeterCubicSecond }

resourcestring
  rsReciprocalMeterCubicSecondSymbol = '1/%sm/%ss³';
  rsReciprocalMeterCubicSecondName = 'reciprocal %smeter cubic %ssecond';
  rsReciprocalMeterCubicSecondPluralName = 'reciprocal %smeter cubic %ssecond';

const
  ReciprocalMeterCubicSecondID = -144360;
  ReciprocalMeterCubicSecondUnit : TUnit = (
    FID         : ReciprocalMeterCubicSecondID;
    FSymbol     : rsReciprocalMeterCubicSecondSymbol;
    FName       : rsReciprocalMeterCubicSecondName;
    FPluralName : rsReciprocalMeterCubicSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -3));

{ TSquareMeterPerCubicSecondPerKelvin }

resourcestring
  rsSquareMeterPerCubicSecondPerKelvinSymbol = '%sm²/%ss³/%sK';
  rsSquareMeterPerCubicSecondPerKelvinName = 'square %smeter per cubic %ssecond per %skelvin';
  rsSquareMeterPerCubicSecondPerKelvinPluralName = 'square %smeters per cubic %ssecond per %skelvin';

const
  SquareMeterPerCubicSecondPerKelvinID = -44040;
  SquareMeterPerCubicSecondPerKelvinUnit : TUnit = (
    FID         : SquareMeterPerCubicSecondPerKelvinID;
    FSymbol     : rsSquareMeterPerCubicSecondPerKelvinSymbol;
    FName       : rsSquareMeterPerCubicSecondPerKelvinName;
    FPluralName : rsSquareMeterPerCubicSecondPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -3, -1));

{ TMeterPerCubicSecondPerKelvin }

resourcestring
  rsMeterPerCubicSecondPerKelvinSymbol = '%sm/%ss³/%sK';
  rsMeterPerCubicSecondPerKelvinName = '%smeter per cubic %ssecond per %skelvin';
  rsMeterPerCubicSecondPerKelvinPluralName = '%smeters per cubic %ssecond per %skelvin';

const
  MeterPerCubicSecondPerKelvinID = -83820;
  MeterPerCubicSecondPerKelvinUnit : TUnit = (
    FID         : MeterPerCubicSecondPerKelvinID;
    FSymbol     : rsMeterPerCubicSecondPerKelvinSymbol;
    FName       : rsMeterPerCubicSecondPerKelvinName;
    FPluralName : rsMeterPerCubicSecondPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -3, -1));

{ TKilogramMeterPerKelvin }

resourcestring
  rsKilogramMeterPerKelvinSymbol = '%skg∙%sm/%sK';
  rsKilogramMeterPerKelvinName = '%skilogram %smeter per %skelvin';
  rsKilogramMeterPerKelvinPluralName = '%skilograms %smeters per %skelvin';

const
  KilogramMeterPerKelvinID = 29820;
  KilogramMeterPerKelvinUnit : TUnit = (
    FID         : KilogramMeterPerKelvinID;
    FSymbol     : rsKilogramMeterPerKelvinSymbol;
    FName       : rsKilogramMeterPerKelvinName;
    FPluralName : rsKilogramMeterPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TCubicSecondKelvinPerSquareMeter }

resourcestring
  rsCubicSecondKelvinPerSquareMeterSymbol = '%ss³∙%sK/%sm²';
  rsCubicSecondKelvinPerSquareMeterName = 'cubic %ssecond %skelvin per square %smeter';
  rsCubicSecondKelvinPerSquareMeterPluralName = 'cubic %sseconds %skelvins per square %smeter';

const
  CubicSecondKelvinPerSquareMeterID = 44040;
  CubicSecondKelvinPerSquareMeterUnit : TUnit = (
    FID         : CubicSecondKelvinPerSquareMeterID;
    FSymbol     : rsCubicSecondKelvinPerSquareMeterSymbol;
    FName       : rsCubicSecondKelvinPerSquareMeterName;
    FPluralName : rsCubicSecondKelvinPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -2));

{ TCubicSecondKelvinPerKilogram }

resourcestring
  rsCubicSecondKelvinPerKilogramSymbol = '%ss³∙%sK/%skg';
  rsCubicSecondKelvinPerKilogramName = 'cubic %ssecond %skelvin per %skilogram';
  rsCubicSecondKelvinPerKilogramPluralName = 'cubic %sseconds %skelvins per %skilogram';

const
  CubicSecondKelvinPerKilogramID = 114540;
  CubicSecondKelvinPerKilogramUnit : TUnit = (
    FID         : CubicSecondKelvinPerKilogramID;
    FSymbol     : rsCubicSecondKelvinPerKilogramSymbol;
    FName       : rsCubicSecondKelvinPerKilogramName;
    FPluralName : rsCubicSecondKelvinPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -1));

{ TKelvinPerKilogramPerSquareMeter }

resourcestring
  rsKelvinPerKilogramPerSquareMeterSymbol = '%sK/%skg/%sm²';
  rsKelvinPerKilogramPerSquareMeterName = '%skelvin per %skilogram per square %smeter';
  rsKelvinPerKilogramPerSquareMeterPluralName = '%skelvins per %skilogram per square %smeter';

const
  KelvinPerKilogramPerSquareMeterID = -69600;
  KelvinPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : KelvinPerKilogramPerSquareMeterID;
    FSymbol     : rsKelvinPerKilogramPerSquareMeterSymbol;
    FName       : rsKelvinPerKilogramPerSquareMeterName;
    FPluralName : rsKelvinPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TCubicSecondPerMeter }

resourcestring
  rsCubicSecondPerMeterSymbol = '%ss³/%sm';
  rsCubicSecondPerMeterName = 'cubic %ssecond per %smeter';
  rsCubicSecondPerMeterPluralName = 'cubic %sseconds per %smeter';

const
  CubicSecondPerMeterID = 64800;
  CubicSecondPerMeterUnit : TUnit = (
    FID         : CubicSecondPerMeterID;
    FSymbol     : rsCubicSecondPerMeterSymbol;
    FName       : rsCubicSecondPerMeterName;
    FPluralName : rsCubicSecondPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TCubicSecondPerKilogram }

resourcestring
  rsCubicSecondPerKilogramSymbol = '%ss³/%skg';
  rsCubicSecondPerKilogramName = 'cubic %ssecond per %skilogram';
  rsCubicSecondPerKilogramPluralName = 'cubic %sseconds per %skilogram';

const
  CubicSecondPerKilogramID = 95520;
  CubicSecondPerKilogramUnit : TUnit = (
    FID         : CubicSecondPerKilogramID;
    FSymbol     : rsCubicSecondPerKilogramSymbol;
    FName       : rsCubicSecondPerKilogramName;
    FPluralName : rsCubicSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TReciprocalKilogramMeter }

resourcestring
  rsReciprocalKilogramMeterSymbol = '1/%skg/%sm';
  rsReciprocalKilogramMeterName = 'reciprocal %skilogram %smeter';
  rsReciprocalKilogramMeterPluralName = 'reciprocal %skilogram %smeter';

const
  ReciprocalKilogramMeterID = -48840;
  ReciprocalKilogramMeterUnit : TUnit = (
    FID         : ReciprocalKilogramMeterID;
    FSymbol     : rsReciprocalKilogramMeterSymbol;
    FName       : rsReciprocalKilogramMeterName;
    FPluralName : rsReciprocalKilogramMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TCubicSecondKelvinPerMeter }

resourcestring
  rsCubicSecondKelvinPerMeterSymbol = '%ss³∙%sK/%sm';
  rsCubicSecondKelvinPerMeterName = 'cubic %ssecond %skelvin per %smeter';
  rsCubicSecondKelvinPerMeterPluralName = 'cubic %sseconds %skelvins per %smeter';

const
  CubicSecondKelvinPerMeterID = 83820;
  CubicSecondKelvinPerMeterUnit : TUnit = (
    FID         : CubicSecondKelvinPerMeterID;
    FSymbol     : rsCubicSecondKelvinPerMeterSymbol;
    FName       : rsCubicSecondKelvinPerMeterName;
    FPluralName : rsCubicSecondKelvinPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -1));

{ TKelvinPerKilogramPerMeter }

resourcestring
  rsKelvinPerKilogramPerMeterSymbol = '%sK/%skg/%sm';
  rsKelvinPerKilogramPerMeterName = '%skelvin per %skilogram per %smeter';
  rsKelvinPerKilogramPerMeterPluralName = '%skelvins per %skilogram per %smeter';

const
  KelvinPerKilogramPerMeterID = -29820;
  KelvinPerKilogramPerMeterUnit : TUnit = (
    FID         : KelvinPerKilogramPerMeterID;
    FSymbol     : rsKelvinPerKilogramPerMeterSymbol;
    FName       : rsKelvinPerKilogramPerMeterName;
    FPluralName : rsKelvinPerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TReciprocalCubicSecondKelvin }

resourcestring
  rsReciprocalCubicSecondKelvinSymbol = '1/%ss³/%sK';
  rsReciprocalCubicSecondKelvinName = 'reciprocal cubic %ssecond %skelvin';
  rsReciprocalCubicSecondKelvinPluralName = 'reciprocal cubic %ssecond %skelvin';

const
  ReciprocalCubicSecondKelvinID = -123600;
  ReciprocalCubicSecondKelvinUnit : TUnit = (
    FID         : ReciprocalCubicSecondKelvinID;
    FSymbol     : rsReciprocalCubicSecondKelvinSymbol;
    FName       : rsReciprocalCubicSecondKelvinName;
    FPluralName : rsReciprocalCubicSecondKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-3, -1));

{ TKilogramPerKelvin }

resourcestring
  rsKilogramPerKelvinSymbol = '%skg/%sK';
  rsKilogramPerKelvinName = '%skilogram per %skelvin';
  rsKilogramPerKelvinPluralName = '%skilograms per %skelvin';

const
  KilogramPerKelvinID = -9960;
  KilogramPerKelvinUnit : TUnit = (
    FID         : KilogramPerKelvinID;
    FSymbol     : rsKilogramPerKelvinSymbol;
    FName       : rsKilogramPerKelvinName;
    FPluralName : rsKilogramPerKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareMeterPerCubicSecondPerQuarticKelvin }

resourcestring
  rsSquareMeterPerCubicSecondPerQuarticKelvinSymbol = '%sm²/%ss³/%sK⁴';
  rsSquareMeterPerCubicSecondPerQuarticKelvinName = 'square %smeter per cubic %ssecond per quartic %skelvin';
  rsSquareMeterPerCubicSecondPerQuarticKelvinPluralName = 'square %smeters per cubic %ssecond per quartic %skelvin';

const
  SquareMeterPerCubicSecondPerQuarticKelvinID = -101100;
  SquareMeterPerCubicSecondPerQuarticKelvinUnit : TUnit = (
    FID         : SquareMeterPerCubicSecondPerQuarticKelvinID;
    FSymbol     : rsSquareMeterPerCubicSecondPerQuarticKelvinSymbol;
    FName       : rsSquareMeterPerCubicSecondPerQuarticKelvinName;
    FPluralName : rsSquareMeterPerCubicSecondPerQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -3, -4));

{ TKilogramSquareMeterPerQuarticKelvin }

resourcestring
  rsKilogramSquareMeterPerQuarticKelvinSymbol = '%skg∙%sm²/%sK⁴';
  rsKilogramSquareMeterPerQuarticKelvinName = '%skilogram square %smeter per quartic %skelvin';
  rsKilogramSquareMeterPerQuarticKelvinPluralName = '%skilograms square %smeters per quartic %skelvin';

const
  KilogramSquareMeterPerQuarticKelvinID = 12540;
  KilogramSquareMeterPerQuarticKelvinUnit : TUnit = (
    FID         : KilogramSquareMeterPerQuarticKelvinID;
    FSymbol     : rsKilogramSquareMeterPerQuarticKelvinSymbol;
    FName       : rsKilogramSquareMeterPerQuarticKelvinName;
    FPluralName : rsKilogramSquareMeterPerQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -4));

{ TReciprocalCubicSecondQuarticKelvin }

resourcestring
  rsReciprocalCubicSecondQuarticKelvinSymbol = '1/%ss³/%sK⁴';
  rsReciprocalCubicSecondQuarticKelvinName = 'reciprocal cubic %ssecond quartic %skelvin';
  rsReciprocalCubicSecondQuarticKelvinPluralName = 'reciprocal cubic %ssecond quartic %skelvin';

const
  ReciprocalCubicSecondQuarticKelvinID = -180660;
  ReciprocalCubicSecondQuarticKelvinUnit : TUnit = (
    FID         : ReciprocalCubicSecondQuarticKelvinID;
    FSymbol     : rsReciprocalCubicSecondQuarticKelvinSymbol;
    FName       : rsReciprocalCubicSecondQuarticKelvinName;
    FPluralName : rsReciprocalCubicSecondQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-3, -4));

{ TKilogramPerQuarticKelvin }

resourcestring
  rsKilogramPerQuarticKelvinSymbol = '%skg/%sK⁴';
  rsKilogramPerQuarticKelvinName = '%skilogram per quartic %skelvin';
  rsKilogramPerQuarticKelvinPluralName = '%skilograms per quartic %skelvin';

const
  KilogramPerQuarticKelvinID = -67020;
  KilogramPerQuarticKelvinUnit : TUnit = (
    FID         : KilogramPerQuarticKelvinID;
    FSymbol     : rsKilogramPerQuarticKelvinSymbol;
    FName       : rsKilogramPerQuarticKelvinName;
    FPluralName : rsKilogramPerQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -4));

{ TSquareMeterPerSquareSecondPerMole }

resourcestring
  rsSquareMeterPerSquareSecondPerMoleSymbol = '%sm²/%ss²/%smol';
  rsSquareMeterPerSquareSecondPerMoleName = 'square %smeter per square %ssecond per %smole';
  rsSquareMeterPerSquareSecondPerMolePluralName = 'square %smeters per square %ssecond per %smole';

const
  SquareMeterPerSquareSecondPerMoleID = -24840;
  SquareMeterPerSquareSecondPerMoleUnit : TUnit = (
    FID         : SquareMeterPerSquareSecondPerMoleID;
    FSymbol     : rsSquareMeterPerSquareSecondPerMoleSymbol;
    FName       : rsSquareMeterPerSquareSecondPerMoleName;
    FPluralName : rsSquareMeterPerSquareSecondPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -2, -1));

{ TKilogramPerSquareSecondPerMole }

resourcestring
  rsKilogramPerSquareSecondPerMoleSymbol = '%skg/%ss²/%smol';
  rsKilogramPerSquareSecondPerMoleName = '%skilogram per square %ssecond per %smole';
  rsKilogramPerSquareSecondPerMolePluralName = '%skilograms per square %ssecond per %smole';

const
  KilogramPerSquareSecondPerMoleID = -95340;
  KilogramPerSquareSecondPerMoleUnit : TUnit = (
    FID         : KilogramPerSquareSecondPerMoleID;
    FSymbol     : rsKilogramPerSquareSecondPerMoleSymbol;
    FName       : rsKilogramPerSquareSecondPerMoleName;
    FPluralName : rsKilogramPerSquareSecondPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -1));

{ TKilogramSquareMeterPerMole }

resourcestring
  rsKilogramSquareMeterPerMoleSymbol = '%skg∙%sm²/%smol';
  rsKilogramSquareMeterPerMoleName = '%skilogram square %smeter per %smole';
  rsKilogramSquareMeterPerMolePluralName = '%skilograms square %smeters per %smole';

const
  KilogramSquareMeterPerMoleID = 53940;
  KilogramSquareMeterPerMoleUnit : TUnit = (
    FID         : KilogramSquareMeterPerMoleID;
    FSymbol     : rsKilogramSquareMeterPerMoleSymbol;
    FName       : rsKilogramSquareMeterPerMoleName;
    FPluralName : rsKilogramSquareMeterPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TSquareMeterPerSquareSecondPerKelvinPerMole }

resourcestring
  rsSquareMeterPerSquareSecondPerKelvinPerMoleSymbol = '%sm²/%ss²/%sK/%smol';
  rsSquareMeterPerSquareSecondPerKelvinPerMoleName = 'square %smeter per square %ssecond per %skelvin per %smole';
  rsSquareMeterPerSquareSecondPerKelvinPerMolePluralName = 'square %smeters per square %ssecond per %skelvin per %smole';

const
  SquareMeterPerSquareSecondPerKelvinPerMoleID = -43860;
  SquareMeterPerSquareSecondPerKelvinPerMoleUnit : TUnit = (
    FID         : SquareMeterPerSquareSecondPerKelvinPerMoleID;
    FSymbol     : rsSquareMeterPerSquareSecondPerKelvinPerMoleSymbol;
    FName       : rsSquareMeterPerSquareSecondPerKelvinPerMoleName;
    FPluralName : rsSquareMeterPerSquareSecondPerKelvinPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (2, -2, -1, -1));

{ TKilogramPerSquareSecondPerKelvinPerMole }

resourcestring
  rsKilogramPerSquareSecondPerKelvinPerMoleSymbol = '%skg/%ss²/%sK/%smol';
  rsKilogramPerSquareSecondPerKelvinPerMoleName = '%skilogram per square %ssecond per %skelvin per %smole';
  rsKilogramPerSquareSecondPerKelvinPerMolePluralName = '%skilograms per square %ssecond per %skelvin per %smole';

const
  KilogramPerSquareSecondPerKelvinPerMoleID = -114360;
  KilogramPerSquareSecondPerKelvinPerMoleUnit : TUnit = (
    FID         : KilogramPerSquareSecondPerKelvinPerMoleID;
    FSymbol     : rsKilogramPerSquareSecondPerKelvinPerMoleSymbol;
    FName       : rsKilogramPerSquareSecondPerKelvinPerMoleName;
    FPluralName : rsKilogramPerSquareSecondPerKelvinPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (1, -2, -1, -1));

{ TKilogramSquareMeterPerKelvinPerMole }

resourcestring
  rsKilogramSquareMeterPerKelvinPerMoleSymbol = '%skg∙%sm²/%sK/%smol';
  rsKilogramSquareMeterPerKelvinPerMoleName = '%skilogram square %smeter per %skelvin per %smole';
  rsKilogramSquareMeterPerKelvinPerMolePluralName = '%skilograms square %smeters per %skelvin per %smole';

const
  KilogramSquareMeterPerKelvinPerMoleID = 34920;
  KilogramSquareMeterPerKelvinPerMoleUnit : TUnit = (
    FID         : KilogramSquareMeterPerKelvinPerMoleID;
    FSymbol     : rsKilogramSquareMeterPerKelvinPerMoleSymbol;
    FName       : rsKilogramSquareMeterPerKelvinPerMoleName;
    FPluralName : rsKilogramSquareMeterPerKelvinPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (1, 2, -1, -1));

{ TCubicMeterPerCubicSecondPerSquareAmpere }

resourcestring
  rsCubicMeterPerCubicSecondPerSquareAmpereSymbol = '%sm³/%ss³/%sA²';
  rsCubicMeterPerCubicSecondPerSquareAmpereName = 'cubic %smeter per cubic %ssecond per square %sampere';
  rsCubicMeterPerCubicSecondPerSquareAmperePluralName = 'cubic %smeters per cubic %ssecond per square %sampere';

const
  CubicMeterPerCubicSecondPerSquareAmpereID = -33840;
  CubicMeterPerCubicSecondPerSquareAmpereUnit : TUnit = (
    FID         : CubicMeterPerCubicSecondPerSquareAmpereID;
    FSymbol     : rsCubicMeterPerCubicSecondPerSquareAmpereSymbol;
    FName       : rsCubicMeterPerCubicSecondPerSquareAmpereName;
    FPluralName : rsCubicMeterPerCubicSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -3, -2));

{ TKilogramCubicMeterPerSquareAmpere }

resourcestring
  rsKilogramCubicMeterPerSquareAmpereSymbol = '%skg∙%sm³/%sA²';
  rsKilogramCubicMeterPerSquareAmpereName = '%skilogram cubic %smeter per square %sampere';
  rsKilogramCubicMeterPerSquareAmperePluralName = '%skilograms cubic %smeters per square %sampere';

const
  KilogramCubicMeterPerSquareAmpereID = 79800;
  KilogramCubicMeterPerSquareAmpereUnit : TUnit = (
    FID         : KilogramCubicMeterPerSquareAmpereID;
    FSymbol     : rsKilogramCubicMeterPerSquareAmpereSymbol;
    FName       : rsKilogramCubicMeterPerSquareAmpereName;
    FPluralName : rsKilogramCubicMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 3, -2));

{ TKilogramCubicMeterPerCubicSecond }

resourcestring
  rsKilogramCubicMeterPerCubicSecondSymbol = '%skg∙%sm³/%ss³';
  rsKilogramCubicMeterPerCubicSecondName = '%skilogram cubic %smeter per cubic %ssecond';
  rsKilogramCubicMeterPerCubicSecondPluralName = '%skilograms cubic %smeters per cubic %ssecond';

const
  KilogramCubicMeterPerCubicSecondID = 23820;
  KilogramCubicMeterPerCubicSecondUnit : TUnit = (
    FID         : KilogramCubicMeterPerCubicSecondID;
    FSymbol     : rsKilogramCubicMeterPerCubicSecondSymbol;
    FName       : rsKilogramCubicMeterPerCubicSecondName;
    FPluralName : rsKilogramCubicMeterPerCubicSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 3, -3));

{ TMeterPerCubicSecondPerAmpere }

resourcestring
  rsMeterPerCubicSecondPerAmpereSymbol = '%sm/%ss³/%sA';
  rsMeterPerCubicSecondPerAmpereName = '%smeter per cubic %ssecond per %sampere';
  rsMeterPerCubicSecondPerAmperePluralName = '%smeters per cubic %ssecond per %sampere';

const
  MeterPerCubicSecondPerAmpereID = -89100;
  MeterPerCubicSecondPerAmpereUnit : TUnit = (
    FID         : MeterPerCubicSecondPerAmpereID;
    FSymbol     : rsMeterPerCubicSecondPerAmpereSymbol;
    FName       : rsMeterPerCubicSecondPerAmpereName;
    FPluralName : rsMeterPerCubicSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -3, -1));

{ TKilogramMeterPerAmpere }

resourcestring
  rsKilogramMeterPerAmpereSymbol = '%skg∙%sm/%sA';
  rsKilogramMeterPerAmpereName = '%skilogram %smeter per %sampere';
  rsKilogramMeterPerAmperePluralName = '%skilograms %smeters per %sampere';

const
  KilogramMeterPerAmpereID = 24540;
  KilogramMeterPerAmpereUnit : TUnit = (
    FID         : KilogramMeterPerAmpereID;
    FSymbol     : rsKilogramMeterPerAmpereSymbol;
    FName       : rsKilogramMeterPerAmpereName;
    FPluralName : rsKilogramMeterPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TSquareAmperePerMeter }

resourcestring
  rsSquareAmperePerMeterSymbol = '%sA²/%sm';
  rsSquareAmperePerMeterName = 'square %sampere per %smeter';
  rsSquareAmperePerMeterPluralName = 'square %samperes per %smeter';

const
  SquareAmperePerMeterID = 8820;
  SquareAmperePerMeterUnit : TUnit = (
    FID         : SquareAmperePerMeterID;
    FSymbol     : rsSquareAmperePerMeterSymbol;
    FName       : rsSquareAmperePerMeterName;
    FPluralName : rsSquareAmperePerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TSquareSecondPerMeter }

resourcestring
  rsSquareSecondPerMeterSymbol = '%ss²/%sm';
  rsSquareSecondPerMeterName = 'square %ssecond per %smeter';
  rsSquareSecondPerMeterPluralName = 'square %sseconds per %smeter';

const
  SquareSecondPerMeterID = 29940;
  SquareSecondPerMeterUnit : TUnit = (
    FID         : SquareSecondPerMeterID;
    FSymbol     : rsSquareSecondPerMeterSymbol;
    FName       : rsSquareSecondPerMeterName;
    FPluralName : rsSquareSecondPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TSecondPerSquareMeter }

resourcestring
  rsSecondPerSquareMeterSymbol = '%ss/%sm²';
  rsSecondPerSquareMeterName = '%ssecond per square %smeter';
  rsSecondPerSquareMeterPluralName = '%sseconds per square %smeter';

const
  SecondPerSquareMeterID = -44700;
  SecondPerSquareMeterUnit : TUnit = (
    FID         : SecondPerSquareMeterID;
    FSymbol     : rsSecondPerSquareMeterSymbol;
    FName       : rsSecondPerSquareMeterName;
    FPluralName : rsSecondPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TReciprocalSquareSecondSquareAmpere }

resourcestring
  rsReciprocalSquareSecondSquareAmpereSymbol = '1/%ss²/%sA²';
  rsReciprocalSquareSecondSquareAmpereName = 'reciprocal square %ssecond square %sampere';
  rsReciprocalSquareSecondSquareAmperePluralName = 'reciprocal square %ssecond square %sampere';

const
  ReciprocalSquareSecondSquareAmpereID = -118320;
  ReciprocalSquareSecondSquareAmpereUnit : TUnit = (
    FID         : ReciprocalSquareSecondSquareAmpereID;
    FSymbol     : rsReciprocalSquareSecondSquareAmpereSymbol;
    FName       : rsReciprocalSquareSecondSquareAmpereName;
    FPluralName : rsReciprocalSquareSecondSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -2));

{ TSquareMeterPerSquareAmpere }

resourcestring
  rsSquareMeterPerSquareAmpereSymbol = '%sm²/%sA²';
  rsSquareMeterPerSquareAmpereName = 'square %smeter per square %sampere';
  rsSquareMeterPerSquareAmperePluralName = 'square %smeters per square %sampere';

const
  SquareMeterPerSquareAmpereID = 30960;
  SquareMeterPerSquareAmpereUnit : TUnit = (
    FID         : SquareMeterPerSquareAmpereID;
    FSymbol     : rsSquareMeterPerSquareAmpereSymbol;
    FName       : rsSquareMeterPerSquareAmpereName;
    FPluralName : rsSquareMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TMeterPerQuarticSecondPerSquareAmpere }

resourcestring
  rsMeterPerQuarticSecondPerSquareAmpereSymbol = '%sm/%ss⁴/%sA²';
  rsMeterPerQuarticSecondPerSquareAmpereName = '%smeter per quartic %ssecond per square %sampere';
  rsMeterPerQuarticSecondPerSquareAmperePluralName = '%smeters per quartic %ssecond per square %sampere';

const
  MeterPerQuarticSecondPerSquareAmpereID = -148260;
  MeterPerQuarticSecondPerSquareAmpereUnit : TUnit = (
    FID         : MeterPerQuarticSecondPerSquareAmpereID;
    FSymbol     : rsMeterPerQuarticSecondPerSquareAmpereSymbol;
    FName       : rsMeterPerQuarticSecondPerSquareAmpereName;
    FPluralName : rsMeterPerQuarticSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -4, -2));

{ TKilogramPerQuarticSecondPerSquareAmpere }

resourcestring
  rsKilogramPerQuarticSecondPerSquareAmpereSymbol = '%skg/%ss⁴/%sA²';
  rsKilogramPerQuarticSecondPerSquareAmpereName = '%skilogram per quartic %ssecond per square %sampere';
  rsKilogramPerQuarticSecondPerSquareAmperePluralName = '%skilograms per quartic %ssecond per square %sampere';

const
  KilogramPerQuarticSecondPerSquareAmpereID = -178980;
  KilogramPerQuarticSecondPerSquareAmpereUnit : TUnit = (
    FID         : KilogramPerQuarticSecondPerSquareAmpereID;
    FSymbol     : rsKilogramPerQuarticSecondPerSquareAmpereSymbol;
    FName       : rsKilogramPerQuarticSecondPerSquareAmpereName;
    FPluralName : rsKilogramPerQuarticSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -4, -2));

{ TKilogramMeterPerSquareAmpere }

resourcestring
  rsKilogramMeterPerSquareAmpereSymbol = '%skg∙%sm/%sA²';
  rsKilogramMeterPerSquareAmpereName = '%skilogram %smeter per square %sampere';
  rsKilogramMeterPerSquareAmperePluralName = '%skilograms %smeters per square %sampere';

const
  KilogramMeterPerSquareAmpereID = 240;
  KilogramMeterPerSquareAmpereUnit : TUnit = (
    FID         : KilogramMeterPerSquareAmpereID;
    FSymbol     : rsKilogramMeterPerSquareAmpereSymbol;
    FName       : rsKilogramMeterPerSquareAmpereName;
    FPluralName : rsKilogramMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -2));

{ TKilogramMeterPerQuarticSecond }

resourcestring
  rsKilogramMeterPerQuarticSecondSymbol = '%skg∙%sm/%ss⁴';
  rsKilogramMeterPerQuarticSecondName = '%skilogram %smeter per quartic %ssecond';
  rsKilogramMeterPerQuarticSecondPluralName = '%skilograms %smeters per quartic %ssecond';

const
  KilogramMeterPerQuarticSecondID = -90600;
  KilogramMeterPerQuarticSecondUnit : TUnit = (
    FID         : KilogramMeterPerQuarticSecondID;
    FSymbol     : rsKilogramMeterPerQuarticSecondSymbol;
    FName       : rsKilogramMeterPerQuarticSecondName;
    FPluralName : rsKilogramMeterPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -4));

{ TCubicMeterPerQuarticSecondPerSquareAmpere }

resourcestring
  rsCubicMeterPerQuarticSecondPerSquareAmpereSymbol = '%sm³/%ss⁴/%sA²';
  rsCubicMeterPerQuarticSecondPerSquareAmpereName = 'cubic %smeter per quartic %ssecond per square %sampere';
  rsCubicMeterPerQuarticSecondPerSquareAmperePluralName = 'cubic %smeters per quartic %ssecond per square %sampere';

const
  CubicMeterPerQuarticSecondPerSquareAmpereID = -68700;
  CubicMeterPerQuarticSecondPerSquareAmpereUnit : TUnit = (
    FID         : CubicMeterPerQuarticSecondPerSquareAmpereID;
    FSymbol     : rsCubicMeterPerQuarticSecondPerSquareAmpereSymbol;
    FName       : rsCubicMeterPerQuarticSecondPerSquareAmpereName;
    FPluralName : rsCubicMeterPerQuarticSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -4, -2));

{ TKilogramCubicMeterPerQuarticSecond }

resourcestring
  rsKilogramCubicMeterPerQuarticSecondSymbol = '%skg∙%sm³/%ss⁴';
  rsKilogramCubicMeterPerQuarticSecondName = '%skilogram cubic %smeter per quartic %ssecond';
  rsKilogramCubicMeterPerQuarticSecondPluralName = '%skilograms cubic %smeters per quartic %ssecond';

const
  KilogramCubicMeterPerQuarticSecondID = -11040;
  KilogramCubicMeterPerQuarticSecondUnit : TUnit = (
    FID         : KilogramCubicMeterPerQuarticSecondID;
    FSymbol     : rsKilogramCubicMeterPerQuarticSecondSymbol;
    FName       : rsKilogramCubicMeterPerQuarticSecondName;
    FPluralName : rsKilogramCubicMeterPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 3, -4));

{ TCubicMeterPerCubicSecondPerAmpere }

resourcestring
  rsCubicMeterPerCubicSecondPerAmpereSymbol = '%sm³/%ss³/%sA';
  rsCubicMeterPerCubicSecondPerAmpereName = 'cubic %smeter per cubic %ssecond per %sampere';
  rsCubicMeterPerCubicSecondPerAmperePluralName = 'cubic %smeters per cubic %ssecond per %sampere';

const
  CubicMeterPerCubicSecondPerAmpereID = -9540;
  CubicMeterPerCubicSecondPerAmpereUnit : TUnit = (
    FID         : CubicMeterPerCubicSecondPerAmpereID;
    FSymbol     : rsCubicMeterPerCubicSecondPerAmpereSymbol;
    FName       : rsCubicMeterPerCubicSecondPerAmpereName;
    FPluralName : rsCubicMeterPerCubicSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -3, -1));

{ TKilogramCubicMeterPerAmpere }

resourcestring
  rsKilogramCubicMeterPerAmpereSymbol = '%skg∙%sm³/%sA';
  rsKilogramCubicMeterPerAmpereName = '%skilogram cubic %smeter per %sampere';
  rsKilogramCubicMeterPerAmperePluralName = '%skilograms cubic %smeters per %sampere';

const
  KilogramCubicMeterPerAmpereID = 104100;
  KilogramCubicMeterPerAmpereUnit : TUnit = (
    FID         : KilogramCubicMeterPerAmpereID;
    FSymbol     : rsKilogramCubicMeterPerAmpereSymbol;
    FName       : rsKilogramCubicMeterPerAmpereName;
    FPluralName : rsKilogramCubicMeterPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 3, -1));

{ TCubicMeterPerQuarticSecondPerAmpere }

resourcestring
  rsCubicMeterPerQuarticSecondPerAmpereSymbol = '%sm³/%ss⁴/%sA';
  rsCubicMeterPerQuarticSecondPerAmpereName = 'cubic %smeter per quartic %ssecond per %sampere';
  rsCubicMeterPerQuarticSecondPerAmperePluralName = 'cubic %smeters per quartic %ssecond per %sampere';

const
  CubicMeterPerQuarticSecondPerAmpereID = -44400;
  CubicMeterPerQuarticSecondPerAmpereUnit : TUnit = (
    FID         : CubicMeterPerQuarticSecondPerAmpereID;
    FSymbol     : rsCubicMeterPerQuarticSecondPerAmpereSymbol;
    FName       : rsCubicMeterPerQuarticSecondPerAmpereName;
    FPluralName : rsCubicMeterPerQuarticSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -4, -1));

{ TKilogramPerQuarticSecondPerAmpere }

resourcestring
  rsKilogramPerQuarticSecondPerAmpereSymbol = '%skg/%ss⁴/%sA';
  rsKilogramPerQuarticSecondPerAmpereName = '%skilogram per quartic %ssecond per %sampere';
  rsKilogramPerQuarticSecondPerAmperePluralName = '%skilograms per quartic %ssecond per %sampere';

const
  KilogramPerQuarticSecondPerAmpereID = -154680;
  KilogramPerQuarticSecondPerAmpereUnit : TUnit = (
    FID         : KilogramPerQuarticSecondPerAmpereID;
    FSymbol     : rsKilogramPerQuarticSecondPerAmpereSymbol;
    FName       : rsKilogramPerQuarticSecondPerAmpereName;
    FPluralName : rsKilogramPerQuarticSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -4, -1));

{ TQuarticSecondSquareAmperePerCubicMeter }

resourcestring
  rsQuarticSecondSquareAmperePerCubicMeterSymbol = '%ss⁴∙%sA²/%sm³';
  rsQuarticSecondSquareAmperePerCubicMeterName = 'quartic %ssecond square %sampere per cubic %smeter';
  rsQuarticSecondSquareAmperePerCubicMeterPluralName = 'quartic %sseconds square %samperes per cubic %smeter';

const
  QuarticSecondSquareAmperePerCubicMeterID = 68700;
  QuarticSecondSquareAmperePerCubicMeterUnit : TUnit = (
    FID         : QuarticSecondSquareAmperePerCubicMeterID;
    FSymbol     : rsQuarticSecondSquareAmperePerCubicMeterSymbol;
    FName       : rsQuarticSecondSquareAmperePerCubicMeterName;
    FPluralName : rsQuarticSecondSquareAmperePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, 2, -3));

{ TQuarticSecondPerKilogramPerCubicMeter }

resourcestring
  rsQuarticSecondPerKilogramPerCubicMeterSymbol = '%ss⁴/%skg/%sm³';
  rsQuarticSecondPerKilogramPerCubicMeterName = 'quartic %ssecond per %skilogram per cubic %smeter';
  rsQuarticSecondPerKilogramPerCubicMeterPluralName = 'quartic %sseconds per %skilogram per cubic %smeter';

const
  QuarticSecondPerKilogramPerCubicMeterID = 11040;
  QuarticSecondPerKilogramPerCubicMeterUnit : TUnit = (
    FID         : QuarticSecondPerKilogramPerCubicMeterID;
    FSymbol     : rsQuarticSecondPerKilogramPerCubicMeterSymbol;
    FName       : rsQuarticSecondPerKilogramPerCubicMeterName;
    FPluralName : rsQuarticSecondPerKilogramPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, -1, -3));

{ TReciprocalAmpere }

resourcestring
  rsReciprocalAmpereSymbol = '1/%sA';
  rsReciprocalAmpereName = 'reciprocal %sampere';
  rsReciprocalAmperePluralName = 'reciprocal %sampere';

const
  ReciprocalAmpereID = -24300;
  ReciprocalAmpereUnit : TUnit = (
    FID         : ReciprocalAmpereID;
    FSymbol     : rsReciprocalAmpereSymbol;
    FName       : rsReciprocalAmpereName;
    FPluralName : rsReciprocalAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TMeterPerSquareSecondPerAmpere }

resourcestring
  rsMeterPerSquareSecondPerAmpereSymbol = '%sm/%ss²/%sA';
  rsMeterPerSquareSecondPerAmpereName = '%smeter per square %ssecond per %sampere';
  rsMeterPerSquareSecondPerAmperePluralName = '%smeters per square %ssecond per %sampere';

const
  MeterPerSquareSecondPerAmpereID = -54240;
  MeterPerSquareSecondPerAmpereUnit : TUnit = (
    FID         : MeterPerSquareSecondPerAmpereID;
    FSymbol     : rsMeterPerSquareSecondPerAmpereSymbol;
    FName       : rsMeterPerSquareSecondPerAmpereName;
    FPluralName : rsMeterPerSquareSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -1));

{ TKilogramPerSquareAmpere }

resourcestring
  rsKilogramPerSquareAmpereSymbol = '%skg/%sA²';
  rsKilogramPerSquareAmpereName = '%skilogram per square %sampere';
  rsKilogramPerSquareAmperePluralName = '%skilograms per square %sampere';

const
  KilogramPerSquareAmpereID = -39540;
  KilogramPerSquareAmpereUnit : TUnit = (
    FID         : KilogramPerSquareAmpereID;
    FSymbol     : rsKilogramPerSquareAmpereSymbol;
    FName       : rsKilogramPerSquareAmpereName;
    FPluralName : rsKilogramPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TMeterPerSquareSecondPerSquareAmpere }

resourcestring
  rsMeterPerSquareSecondPerSquareAmpereSymbol = '%sm/%ss²/%sA²';
  rsMeterPerSquareSecondPerSquareAmpereName = '%smeter per square %ssecond per square %sampere';
  rsMeterPerSquareSecondPerSquareAmperePluralName = '%smeters per square %ssecond per square %sampere';

const
  MeterPerSquareSecondPerSquareAmpereID = -78540;
  MeterPerSquareSecondPerSquareAmpereUnit : TUnit = (
    FID         : MeterPerSquareSecondPerSquareAmpereID;
    FSymbol     : rsMeterPerSquareSecondPerSquareAmpereSymbol;
    FName       : rsMeterPerSquareSecondPerSquareAmpereName;
    FPluralName : rsMeterPerSquareSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -2));

{ TQuarticMeterPerQuarticSecond }

resourcestring
  rsQuarticMeterPerQuarticSecondSymbol = '%sm⁴/%ss⁴';
  rsQuarticMeterPerQuarticSecondName = 'quartic %smeter per quartic %ssecond';
  rsQuarticMeterPerQuarticSecondPluralName = 'quartic %smeters per quartic %ssecond';

const
  QuarticMeterPerQuarticSecondID = 19680;
  QuarticMeterPerQuarticSecondUnit : TUnit = (
    FID         : QuarticMeterPerQuarticSecondID;
    FSymbol     : rsQuarticMeterPerQuarticSecondSymbol;
    FName       : rsQuarticMeterPerQuarticSecondName;
    FPluralName : rsQuarticMeterPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -4));

{ TSquareKilogramQuarticMeter }

resourcestring
  rsSquareKilogramQuarticMeterSymbol = '%skg²∙%sm⁴';
  rsSquareKilogramQuarticMeterName = 'square %skilogram quartic %smeter';
  rsSquareKilogramQuarticMeterPluralName = 'square %skilograms quartic %smeters';

const
  SquareKilogramQuarticMeterID = 177240;
  SquareKilogramQuarticMeterUnit : TUnit = (
    FID         : SquareKilogramQuarticMeterID;
    FSymbol     : rsSquareKilogramQuarticMeterSymbol;
    FName       : rsSquareKilogramQuarticMeterName;
    FPluralName : rsSquareKilogramQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 4));

{ TAmperePerKilogram }

resourcestring
  rsAmperePerKilogramSymbol = '%sA/%skg';
  rsAmperePerKilogramName = '%sampere per %skilogram';
  rsAmperePerKilogramPluralName = '%samperes per %skilogram';

const
  AmperePerKilogramID = 15240;
  AmperePerKilogramUnit : TUnit = (
    FID         : AmperePerKilogramID;
    FSymbol     : rsAmperePerKilogramSymbol;
    FName       : rsAmperePerKilogramName;
    FPluralName : rsAmperePerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSecondPerKilogram }

resourcestring
  rsSecondPerKilogramSymbol = '%ss/%skg';
  rsSecondPerKilogramName = '%ssecond per %skilogram';
  rsSecondPerKilogramPluralName = '%sseconds per %skilogram';

const
  SecondPerKilogramID = 25800;
  SecondPerKilogramUnit : TUnit = (
    FID         : SecondPerKilogramID;
    FSymbol     : rsSecondPerKilogramSymbol;
    FName       : rsSecondPerKilogramName;
    FPluralName : rsSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TCubicSecondCandelaSteradianPerSquareMeter }

resourcestring
  rsCubicSecondCandelaSteradianPerSquareMeterSymbol = '%ss³∙%scd∙sr/%sm²';
  rsCubicSecondCandelaSteradianPerSquareMeterName = 'cubic %ssecond %scandela steradian per square %smeter';
  rsCubicSecondCandelaSteradianPerSquareMeterPluralName = 'cubic %sseconds %scandelas steradian per square %smeter';

const
  CubicSecondCandelaSteradianPerSquareMeterID = 102840;
  CubicSecondCandelaSteradianPerSquareMeterUnit : TUnit = (
    FID         : CubicSecondCandelaSteradianPerSquareMeterID;
    FSymbol     : rsCubicSecondCandelaSteradianPerSquareMeterSymbol;
    FName       : rsCubicSecondCandelaSteradianPerSquareMeterName;
    FPluralName : rsCubicSecondCandelaSteradianPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -2));

{ TCubicSecondCandelaSteradianPerKilogram }

resourcestring
  rsCubicSecondCandelaSteradianPerKilogramSymbol = '%ss³∙%scd∙sr/%skg';
  rsCubicSecondCandelaSteradianPerKilogramName = 'cubic %ssecond %scandela steradian per %skilogram';
  rsCubicSecondCandelaSteradianPerKilogramPluralName = 'cubic %sseconds %scandelas steradian per %skilogram';

const
  CubicSecondCandelaSteradianPerKilogramID = 173340;
  CubicSecondCandelaSteradianPerKilogramUnit : TUnit = (
    FID         : CubicSecondCandelaSteradianPerKilogramID;
    FSymbol     : rsCubicSecondCandelaSteradianPerKilogramSymbol;
    FName       : rsCubicSecondCandelaSteradianPerKilogramName;
    FPluralName : rsCubicSecondCandelaSteradianPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -1));

{ TCandelaSteradianPerKilogramPerSquareMeter }

resourcestring
  rsCandelaSteradianPerKilogramPerSquareMeterSymbol = '%scd∙sr/%skg/%sm²';
  rsCandelaSteradianPerKilogramPerSquareMeterName = '%scandela steradian per %skilogram per square %smeter';
  rsCandelaSteradianPerKilogramPerSquareMeterPluralName = '%scandelas steradian per %skilogram per square %smeter';

const
  CandelaSteradianPerKilogramPerSquareMeterID = -10800;
  CandelaSteradianPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : CandelaSteradianPerKilogramPerSquareMeterID;
    FSymbol     : rsCandelaSteradianPerKilogramPerSquareMeterSymbol;
    FName       : rsCandelaSteradianPerKilogramPerSquareMeterName;
    FPluralName : rsCandelaSteradianPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TCubicSecondSteradianPerKilogramPerSquareMeter }

resourcestring
  rsCubicSecondSteradianPerKilogramPerSquareMeterSymbol = '%ss³∙sr/%skg/%sm²';
  rsCubicSecondSteradianPerKilogramPerSquareMeterName = 'cubic %ssecond steradian per %skilogram per square %smeter';
  rsCubicSecondSteradianPerKilogramPerSquareMeterPluralName = 'cubic %sseconds steradian per %skilogram per square %smeter';

const
  CubicSecondSteradianPerKilogramPerSquareMeterID = 53820;
  CubicSecondSteradianPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : CubicSecondSteradianPerKilogramPerSquareMeterID;
    FSymbol     : rsCubicSecondSteradianPerKilogramPerSquareMeterSymbol;
    FName       : rsCubicSecondSteradianPerKilogramPerSquareMeterName;
    FPluralName : rsCubicSecondSteradianPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -1, -2));

{ TCubicSecondCandelaPerKilogramPerSquareMeter }

resourcestring
  rsCubicSecondCandelaPerKilogramPerSquareMeterSymbol = '%ss³∙%scd/%skg/%sm²';
  rsCubicSecondCandelaPerKilogramPerSquareMeterName = 'cubic %ssecond %scandela per %skilogram per square %smeter';
  rsCubicSecondCandelaPerKilogramPerSquareMeterPluralName = 'cubic %sseconds %scandelas per %skilogram per square %smeter';

const
  CubicSecondCandelaPerKilogramPerSquareMeterID = 55920;
  CubicSecondCandelaPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : CubicSecondCandelaPerKilogramPerSquareMeterID;
    FSymbol     : rsCubicSecondCandelaPerKilogramPerSquareMeterSymbol;
    FName       : rsCubicSecondCandelaPerKilogramPerSquareMeterName;
    FPluralName : rsCubicSecondCandelaPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (3, 1, -1, -2));

{ TAmperePerCubicMeter }

resourcestring
  rsAmperePerCubicMeterSymbol = '%sA/%sm³';
  rsAmperePerCubicMeterName = '%sampere per cubic %smeter';
  rsAmperePerCubicMeterPluralName = '%samperes per cubic %smeter';

const
  AmperePerCubicMeterID = -95040;
  AmperePerCubicMeterUnit : TUnit = (
    FID         : AmperePerCubicMeterID;
    FSymbol     : rsAmperePerCubicMeterSymbol;
    FName       : rsAmperePerCubicMeterName;
    FPluralName : rsAmperePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TSecondPerCubicMeter }

resourcestring
  rsSecondPerCubicMeterSymbol = '%ss/%sm³';
  rsSecondPerCubicMeterName = '%ssecond per cubic %smeter';
  rsSecondPerCubicMeterPluralName = '%sseconds per cubic %smeter';

const
  SecondPerCubicMeterID = -84480;
  SecondPerCubicMeterUnit : TUnit = (
    FID         : SecondPerCubicMeterID;
    FSymbol     : rsSecondPerCubicMeterSymbol;
    FName       : rsSecondPerCubicMeterName;
    FPluralName : rsSecondPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TSquareMeterPerCubicSecondPerSteradian }

resourcestring
  rsSquareMeterPerCubicSecondPerSteradianSymbol = '%sm²/%ss³/sr';
  rsSquareMeterPerCubicSecondPerSteradianName = 'square %smeter per cubic %ssecond per steradian';
  rsSquareMeterPerCubicSecondPerSteradianPluralName = 'square %smeters per cubic %ssecond per steradian';

const
  SquareMeterPerCubicSecondPerSteradianID = -62880;
  SquareMeterPerCubicSecondPerSteradianUnit : TUnit = (
    FID         : SquareMeterPerCubicSecondPerSteradianID;
    FSymbol     : rsSquareMeterPerCubicSecondPerSteradianSymbol;
    FName       : rsSquareMeterPerCubicSecondPerSteradianName;
    FPluralName : rsSquareMeterPerCubicSecondPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -3));

{ TKilogramSquareMeterPerSteradian }

resourcestring
  rsKilogramSquareMeterPerSteradianSymbol = '%skg∙%sm²/sr';
  rsKilogramSquareMeterPerSteradianName = '%skilogram square %smeter per steradian';
  rsKilogramSquareMeterPerSteradianPluralName = '%skilograms square %smeters per steradian';

const
  KilogramSquareMeterPerSteradianID = 50760;
  KilogramSquareMeterPerSteradianUnit : TUnit = (
    FID         : KilogramSquareMeterPerSteradianID;
    FSymbol     : rsKilogramSquareMeterPerSteradianSymbol;
    FName       : rsKilogramSquareMeterPerSteradianName;
    FPluralName : rsKilogramSquareMeterPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 2));

{ TSquareMeterPerSquareSecondPerSteradian }

resourcestring
  rsSquareMeterPerSquareSecondPerSteradianSymbol = '%sm²/%ss²/sr';
  rsSquareMeterPerSquareSecondPerSteradianName = 'square %smeter per square %ssecond per steradian';
  rsSquareMeterPerSquareSecondPerSteradianPluralName = 'square %smeters per square %ssecond per steradian';

const
  SquareMeterPerSquareSecondPerSteradianID = -28020;
  SquareMeterPerSquareSecondPerSteradianUnit : TUnit = (
    FID         : SquareMeterPerSquareSecondPerSteradianID;
    FSymbol     : rsSquareMeterPerSquareSecondPerSteradianSymbol;
    FName       : rsSquareMeterPerSquareSecondPerSteradianName;
    FPluralName : rsSquareMeterPerSquareSecondPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TMeterPerCubicSecondPerSteradian }

resourcestring
  rsMeterPerCubicSecondPerSteradianSymbol = '%sm/%ss³/sr';
  rsMeterPerCubicSecondPerSteradianName = '%smeter per cubic %ssecond per steradian';
  rsMeterPerCubicSecondPerSteradianPluralName = '%smeters per cubic %ssecond per steradian';

const
  MeterPerCubicSecondPerSteradianID = -102660;
  MeterPerCubicSecondPerSteradianUnit : TUnit = (
    FID         : MeterPerCubicSecondPerSteradianID;
    FSymbol     : rsMeterPerCubicSecondPerSteradianSymbol;
    FName       : rsMeterPerCubicSecondPerSteradianName;
    FPluralName : rsMeterPerCubicSecondPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TKilogramMeterPerSteradian }

resourcestring
  rsKilogramMeterPerSteradianSymbol = '%skg∙%sm/sr';
  rsKilogramMeterPerSteradianName = '%skilogram %smeter per steradian';
  rsKilogramMeterPerSteradianPluralName = '%skilograms %smeters per steradian';

const
  KilogramMeterPerSteradianID = 10980;
  KilogramMeterPerSteradianUnit : TUnit = (
    FID         : KilogramMeterPerSteradianID;
    FSymbol     : rsKilogramMeterPerSteradianSymbol;
    FName       : rsKilogramMeterPerSteradianName;
    FPluralName : rsKilogramMeterPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TReciprocalCubicSecondSteradian }

resourcestring
  rsReciprocalCubicSecondSteradianSymbol = '1/%ss³/sr';
  rsReciprocalCubicSecondSteradianName = 'reciprocal cubic %ssecond steradian';
  rsReciprocalCubicSecondSteradianPluralName = 'reciprocal cubic %ssecond steradian';

const
  ReciprocalCubicSecondSteradianID = -142440;
  ReciprocalCubicSecondSteradianUnit : TUnit = (
    FID         : ReciprocalCubicSecondSteradianID;
    FSymbol     : rsReciprocalCubicSecondSteradianSymbol;
    FName       : rsReciprocalCubicSecondSteradianName;
    FPluralName : rsReciprocalCubicSecondSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TKilogramPerSteradian }

resourcestring
  rsKilogramPerSteradianSymbol = '%skg/sr';
  rsKilogramPerSteradianName = '%skilogram per steradian';
  rsKilogramPerSteradianPluralName = '%skilograms per steradian';

const
  KilogramPerSteradianID = -28800;
  KilogramPerSteradianUnit : TUnit = (
    FID         : KilogramPerSteradianID;
    FSymbol     : rsKilogramPerSteradianSymbol;
    FName       : rsKilogramPerSteradianName;
    FPluralName : rsKilogramPerSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TReciprocalMeterCubicSecondSteradian }

resourcestring
  rsReciprocalMeterCubicSecondSteradianSymbol = '1/%sm/%ss³/sr';
  rsReciprocalMeterCubicSecondSteradianName = 'reciprocal %smeter cubic %ssecond steradian';
  rsReciprocalMeterCubicSecondSteradianPluralName = 'reciprocal %smeter cubic %ssecond steradian';

const
  ReciprocalMeterCubicSecondSteradianID = -182220;
  ReciprocalMeterCubicSecondSteradianUnit : TUnit = (
    FID         : ReciprocalMeterCubicSecondSteradianID;
    FSymbol     : rsReciprocalMeterCubicSecondSteradianSymbol;
    FName       : rsReciprocalMeterCubicSecondSteradianName;
    FPluralName : rsReciprocalMeterCubicSecondSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -3));

{ TKilogramPerMeterPerSteradian }

resourcestring
  rsKilogramPerMeterPerSteradianSymbol = '%skg/%sm/sr';
  rsKilogramPerMeterPerSteradianName = '%skilogram per %smeter per steradian';
  rsKilogramPerMeterPerSteradianPluralName = '%skilograms per %smeter per steradian';

const
  KilogramPerMeterPerSteradianID = -68580;
  KilogramPerMeterPerSteradianUnit : TUnit = (
    FID         : KilogramPerMeterPerSteradianID;
    FSymbol     : rsKilogramPerMeterPerSteradianSymbol;
    FName       : rsKilogramPerMeterPerSteradianName;
    FPluralName : rsKilogramPerMeterPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TReciprocalSquareSecondSteradian }

resourcestring
  rsReciprocalSquareSecondSteradianSymbol = '1/%ss²/sr';
  rsReciprocalSquareSecondSteradianName = 'reciprocal square %ssecond steradian';
  rsReciprocalSquareSecondSteradianPluralName = 'reciprocal square %ssecond steradian';

const
  ReciprocalSquareSecondSteradianID = -107580;
  ReciprocalSquareSecondSteradianUnit : TUnit = (
    FID         : ReciprocalSquareSecondSteradianID;
    FSymbol     : rsReciprocalSquareSecondSteradianSymbol;
    FName       : rsReciprocalSquareSecondSteradianName;
    FPluralName : rsReciprocalSquareSecondSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TReciprocalCubicMeterSecond }

resourcestring
  rsReciprocalCubicMeterSecondSymbol = '1/%sm³/%ss';
  rsReciprocalCubicMeterSecondName = 'reciprocal cubic %smeter %ssecond';
  rsReciprocalCubicMeterSecondPluralName = 'reciprocal cubic %smeter %ssecond';

const
  ReciprocalCubicMeterSecondID = -154200;
  ReciprocalCubicMeterSecondUnit : TUnit = (
    FID         : ReciprocalCubicMeterSecondID;
    FSymbol     : rsReciprocalCubicMeterSecondSymbol;
    FName       : rsReciprocalCubicMeterSecondName;
    FPluralName : rsReciprocalCubicMeterSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-3, -1));

{ TAmperePerMole }

resourcestring
  rsAmperePerMoleSymbol = '%sA/%smol';
  rsAmperePerMoleName = '%sampere per %smole';
  rsAmperePerMolePluralName = '%samperes per %smole';

const
  AmperePerMoleID = -10380;
  AmperePerMoleUnit : TUnit = (
    FID         : AmperePerMoleID;
    FSymbol     : rsAmperePerMoleSymbol;
    FName       : rsAmperePerMoleName;
    FPluralName : rsAmperePerMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSecondPerMole }

resourcestring
  rsSecondPerMoleSymbol = '%ss/%smol';
  rsSecondPerMoleName = '%ssecond per %smole';
  rsSecondPerMolePluralName = '%sseconds per %smole';

const
  SecondPerMoleID = 180;
  SecondPerMoleUnit : TUnit = (
    FID         : SecondPerMoleID;
    FSymbol     : rsSecondPerMoleSymbol;
    FName       : rsSecondPerMoleName;
    FPluralName : rsSecondPerMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareSecondPerKilogram }

resourcestring
  rsSquareSecondPerKilogramSymbol = '%ss²/%skg';
  rsSquareSecondPerKilogramName = 'square %ssecond per %skilogram';
  rsSquareSecondPerKilogramPluralName = 'square %sseconds per %skilogram';

const
  SquareSecondPerKilogramID = 60660;
  SquareSecondPerKilogramUnit : TUnit = (
    FID         : SquareSecondPerKilogramID;
    FSymbol     : rsSquareSecondPerKilogramSymbol;
    FName       : rsSquareSecondPerKilogramName;
    FPluralName : rsSquareSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TSquareSecondAmpere }

resourcestring
  rsSquareSecondAmpereSymbol = '%ss²∙%sA';
  rsSquareSecondAmpereName = 'square %ssecond %sampere';
  rsSquareSecondAmperePluralName = 'square %sseconds %samperes';

const
  SquareSecondAmpereID = 94020;
  SquareSecondAmpereUnit : TUnit = (
    FID         : SquareSecondAmpereID;
    FSymbol     : rsSquareSecondAmpereSymbol;
    FName       : rsSquareSecondAmpereName;
    FPluralName : rsSquareSecondAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 1));

{ TMeterSquareSecond }

resourcestring
  rsMeterSquareSecondSymbol = '%sm∙%ss²';
  rsMeterSquareSecondName = '%smeter square %ssecond';
  rsMeterSquareSecondPluralName = '%smeters square %sseconds';

const
  MeterSquareSecondID = 109500;
  MeterSquareSecondUnit : TUnit = (
    FID         : MeterSquareSecondID;
    FSymbol     : rsMeterSquareSecondSymbol;
    FName       : rsMeterSquareSecondName;
    FPluralName : rsMeterSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 2));

{ TSquareSecondAmperePerSquareMeter }

resourcestring
  rsSquareSecondAmperePerSquareMeterSymbol = '%ss²∙%sA/%sm²';
  rsSquareSecondAmperePerSquareMeterName = 'square %ssecond %sampere per square %smeter';
  rsSquareSecondAmperePerSquareMeterPluralName = 'square %sseconds %samperes per square %smeter';

const
  SquareSecondAmperePerSquareMeterID = 14460;
  SquareSecondAmperePerSquareMeterUnit : TUnit = (
    FID         : SquareSecondAmperePerSquareMeterID;
    FSymbol     : rsSquareSecondAmperePerSquareMeterSymbol;
    FName       : rsSquareSecondAmperePerSquareMeterName;
    FPluralName : rsSquareSecondAmperePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 1, -2));

{ TAmperePerKilogramPerSquareMeter }

resourcestring
  rsAmperePerKilogramPerSquareMeterSymbol = '%sA/%skg/%sm²';
  rsAmperePerKilogramPerSquareMeterName = '%sampere per %skilogram per square %smeter';
  rsAmperePerKilogramPerSquareMeterPluralName = '%samperes per %skilogram per square %smeter';

const
  AmperePerKilogramPerSquareMeterID = -64320;
  AmperePerKilogramPerSquareMeterUnit : TUnit = (
    FID         : AmperePerKilogramPerSquareMeterID;
    FSymbol     : rsAmperePerKilogramPerSquareMeterSymbol;
    FName       : rsAmperePerKilogramPerSquareMeterName;
    FPluralName : rsAmperePerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TCubicSecondPerSquareMeter }

resourcestring
  rsCubicSecondPerSquareMeterSymbol = '%ss³/%sm²';
  rsCubicSecondPerSquareMeterName = 'cubic %ssecond per square %smeter';
  rsCubicSecondPerSquareMeterPluralName = 'cubic %sseconds per square %smeter';

const
  CubicSecondPerSquareMeterID = 25020;
  CubicSecondPerSquareMeterUnit : TUnit = (
    FID         : CubicSecondPerSquareMeterID;
    FSymbol     : rsCubicSecondPerSquareMeterSymbol;
    FName       : rsCubicSecondPerSquareMeterName;
    FPluralName : rsCubicSecondPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -2));

{ TReciprocalKilogramSquareMeter }

resourcestring
  rsReciprocalKilogramSquareMeterSymbol = '1/%skg/%sm²';
  rsReciprocalKilogramSquareMeterName = 'reciprocal %skilogram square %smeter';
  rsReciprocalKilogramSquareMeterPluralName = 'reciprocal %skilogram square %smeter';

const
  ReciprocalKilogramSquareMeterID = -88620;
  ReciprocalKilogramSquareMeterUnit : TUnit = (
    FID         : ReciprocalKilogramSquareMeterID;
    FSymbol     : rsReciprocalKilogramSquareMeterSymbol;
    FName       : rsReciprocalKilogramSquareMeterName;
    FPluralName : rsReciprocalKilogramSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -2));

{ TCubicSecondAmperePerMeter }

resourcestring
  rsCubicSecondAmperePerMeterSymbol = '%ss³∙%sA/%sm';
  rsCubicSecondAmperePerMeterName = 'cubic %ssecond %sampere per %smeter';
  rsCubicSecondAmperePerMeterPluralName = 'cubic %sseconds %samperes per %smeter';

const
  CubicSecondAmperePerMeterID = 89100;
  CubicSecondAmperePerMeterUnit : TUnit = (
    FID         : CubicSecondAmperePerMeterID;
    FSymbol     : rsCubicSecondAmperePerMeterSymbol;
    FName       : rsCubicSecondAmperePerMeterName;
    FPluralName : rsCubicSecondAmperePerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -1));

{ TCubicSecondAmperePerKilogram }

resourcestring
  rsCubicSecondAmperePerKilogramSymbol = '%ss³∙%sA/%skg';
  rsCubicSecondAmperePerKilogramName = 'cubic %ssecond %sampere per %skilogram';
  rsCubicSecondAmperePerKilogramPluralName = 'cubic %sseconds %samperes per %skilogram';

const
  CubicSecondAmperePerKilogramID = 119820;
  CubicSecondAmperePerKilogramUnit : TUnit = (
    FID         : CubicSecondAmperePerKilogramID;
    FSymbol     : rsCubicSecondAmperePerKilogramSymbol;
    FName       : rsCubicSecondAmperePerKilogramName;
    FPluralName : rsCubicSecondAmperePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -1));

{ TAmperePerKilogramPerMeter }

resourcestring
  rsAmperePerKilogramPerMeterSymbol = '%sA/%skg/%sm';
  rsAmperePerKilogramPerMeterName = '%sampere per %skilogram per %smeter';
  rsAmperePerKilogramPerMeterPluralName = '%samperes per %skilogram per %smeter';

const
  AmperePerKilogramPerMeterID = -24540;
  AmperePerKilogramPerMeterUnit : TUnit = (
    FID         : AmperePerKilogramPerMeterID;
    FSymbol     : rsAmperePerKilogramPerMeterSymbol;
    FName       : rsAmperePerKilogramPerMeterName;
    FPluralName : rsAmperePerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TReciprocalCubicSecondAmpere }

resourcestring
  rsReciprocalCubicSecondAmpereSymbol = '1/%ss³/%sA';
  rsReciprocalCubicSecondAmpereName = 'reciprocal cubic %ssecond %sampere';
  rsReciprocalCubicSecondAmperePluralName = 'reciprocal cubic %ssecond %sampere';

const
  ReciprocalCubicSecondAmpereID = -128880;
  ReciprocalCubicSecondAmpereUnit : TUnit = (
    FID         : ReciprocalCubicSecondAmpereID;
    FSymbol     : rsReciprocalCubicSecondAmpereSymbol;
    FName       : rsReciprocalCubicSecondAmpereName;
    FPluralName : rsReciprocalCubicSecondAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-3, -1));

{ TSquareMeterPerAmpere }

resourcestring
  rsSquareMeterPerAmpereSymbol = '%sm²/%sA';
  rsSquareMeterPerAmpereName = 'square %smeter per %sampere';
  rsSquareMeterPerAmperePluralName = 'square %smeters per %sampere';

const
  SquareMeterPerAmpereID = 55260;
  SquareMeterPerAmpereUnit : TUnit = (
    FID         : SquareMeterPerAmpereID;
    FSymbol     : rsSquareMeterPerAmpereSymbol;
    FName       : rsSquareMeterPerAmpereName;
    FPluralName : rsSquareMeterPerAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TReciprocalSexticSecondSquareAmpere }

resourcestring
  rsReciprocalSexticSecondSquareAmpereSymbol = '1/%ss⁶/%sA²';
  rsReciprocalSexticSecondSquareAmpereName = 'reciprocal sextic %ssecond square %sampere';
  rsReciprocalSexticSecondSquareAmperePluralName = 'reciprocal sextic %ssecond square %sampere';

const
  ReciprocalSexticSecondSquareAmpereID = -257760;
  ReciprocalSexticSecondSquareAmpereUnit : TUnit = (
    FID         : ReciprocalSexticSecondSquareAmpereID;
    FSymbol     : rsReciprocalSexticSecondSquareAmpereSymbol;
    FName       : rsReciprocalSexticSecondSquareAmpereName;
    FPluralName : rsReciprocalSexticSecondSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-6, -2));

{ TQuarticMeterPerSquareAmpere }

resourcestring
  rsQuarticMeterPerSquareAmpereSymbol = '%sm⁴/%sA²';
  rsQuarticMeterPerSquareAmpereName = 'quartic %smeter per square %sampere';
  rsQuarticMeterPerSquareAmperePluralName = 'quartic %smeters per square %sampere';

const
  QuarticMeterPerSquareAmpereID = 110520;
  QuarticMeterPerSquareAmpereUnit : TUnit = (
    FID         : QuarticMeterPerSquareAmpereID;
    FSymbol     : rsQuarticMeterPerSquareAmpereSymbol;
    FName       : rsQuarticMeterPerSquareAmpereName;
    FPluralName : rsQuarticMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -2));

{ TQuarticMeterPerSexticSecond }

resourcestring
  rsQuarticMeterPerSexticSecondSymbol = '%sm⁴/%ss⁶';
  rsQuarticMeterPerSexticSecondName = 'quartic %smeter per sextic %ssecond';
  rsQuarticMeterPerSexticSecondPluralName = 'quartic %smeters per sextic %ssecond';

const
  QuarticMeterPerSexticSecondID = -50040;
  QuarticMeterPerSexticSecondUnit : TUnit = (
    FID         : QuarticMeterPerSexticSecondID;
    FSymbol     : rsQuarticMeterPerSexticSecondSymbol;
    FName       : rsQuarticMeterPerSexticSecondName;
    FPluralName : rsQuarticMeterPerSexticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -6));

{ TSquareKilogramPerSquareAmpere }

resourcestring
  rsSquareKilogramPerSquareAmpereSymbol = '%skg²/%sA²';
  rsSquareKilogramPerSquareAmpereName = 'square %skilogram per square %sampere';
  rsSquareKilogramPerSquareAmperePluralName = 'square %skilograms per square %sampere';

const
  SquareKilogramPerSquareAmpereID = -30480;
  SquareKilogramPerSquareAmpereUnit : TUnit = (
    FID         : SquareKilogramPerSquareAmpereID;
    FSymbol     : rsSquareKilogramPerSquareAmpereSymbol;
    FName       : rsSquareKilogramPerSquareAmpereName;
    FPluralName : rsSquareKilogramPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TSquareKilogramPerSexticSecond }

resourcestring
  rsSquareKilogramPerSexticSecondSymbol = '%skg²/%ss⁶';
  rsSquareKilogramPerSexticSecondName = 'square %skilogram per sextic %ssecond';
  rsSquareKilogramPerSexticSecondPluralName = 'square %skilograms per sextic %ssecond';

const
  SquareKilogramPerSexticSecondID = -191040;
  SquareKilogramPerSexticSecondUnit : TUnit = (
    FID         : SquareKilogramPerSexticSecondID;
    FSymbol     : rsSquareKilogramPerSexticSecondSymbol;
    FName       : rsSquareKilogramPerSexticSecondName;
    FPluralName : rsSquareKilogramPerSexticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -6));

{ TQuarticSecondSquareAmpere }

resourcestring
  rsQuarticSecondSquareAmpereSymbol = '%ss⁴∙%sA²';
  rsQuarticSecondSquareAmpereName = 'quartic %ssecond square %sampere';
  rsQuarticSecondSquareAmperePluralName = 'quartic %sseconds square %samperes';

const
  QuarticSecondSquareAmpereID = 188040;
  QuarticSecondSquareAmpereUnit : TUnit = (
    FID         : QuarticSecondSquareAmpereID;
    FSymbol     : rsQuarticSecondSquareAmpereSymbol;
    FName       : rsQuarticSecondSquareAmpereName;
    FPluralName : rsQuarticSecondSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, 2));

{ TSquareAmperePerSquareMeter }

resourcestring
  rsSquareAmperePerSquareMeterSymbol = '%sA²/%sm²';
  rsSquareAmperePerSquareMeterName = 'square %sampere per square %smeter';
  rsSquareAmperePerSquareMeterPluralName = 'square %samperes per square %smeter';

const
  SquareAmperePerSquareMeterID = -30960;
  SquareAmperePerSquareMeterUnit : TUnit = (
    FID         : SquareAmperePerSquareMeterID;
    FSymbol     : rsSquareAmperePerSquareMeterSymbol;
    FName       : rsSquareAmperePerSquareMeterName;
    FPluralName : rsSquareAmperePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TQuarticSecondPerSquareMeter }

resourcestring
  rsQuarticSecondPerSquareMeterSymbol = '%ss⁴/%sm²';
  rsQuarticSecondPerSquareMeterName = 'quartic %ssecond per square %smeter';
  rsQuarticSecondPerSquareMeterPluralName = 'quartic %sseconds per square %smeter';

const
  QuarticSecondPerSquareMeterID = 59880;
  QuarticSecondPerSquareMeterUnit : TUnit = (
    FID         : QuarticSecondPerSquareMeterID;
    FSymbol     : rsQuarticSecondPerSquareMeterSymbol;
    FName       : rsQuarticSecondPerSquareMeterName;
    FPluralName : rsQuarticSecondPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -2));

{ TSquareAmperePerKilogram }

resourcestring
  rsSquareAmperePerKilogramSymbol = '%sA²/%skg';
  rsSquareAmperePerKilogramName = 'square %sampere per %skilogram';
  rsSquareAmperePerKilogramPluralName = 'square %samperes per %skilogram';

const
  SquareAmperePerKilogramID = 39540;
  SquareAmperePerKilogramUnit : TUnit = (
    FID         : SquareAmperePerKilogramID;
    FSymbol     : rsSquareAmperePerKilogramSymbol;
    FName       : rsSquareAmperePerKilogramName;
    FPluralName : rsSquareAmperePerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TQuarticSecondPerKilogram }

resourcestring
  rsQuarticSecondPerKilogramSymbol = '%ss⁴/%skg';
  rsQuarticSecondPerKilogramName = 'quartic %ssecond per %skilogram';
  rsQuarticSecondPerKilogramPluralName = 'quartic %sseconds per %skilogram';

const
  QuarticSecondPerKilogramID = 130380;
  QuarticSecondPerKilogramUnit : TUnit = (
    FID         : QuarticSecondPerKilogramID;
    FSymbol     : rsQuarticSecondPerKilogramSymbol;
    FName       : rsQuarticSecondPerKilogramName;
    FPluralName : rsQuarticSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -1));

{ TReciprocalCubicSecondSquareAmpere }

resourcestring
  rsReciprocalCubicSecondSquareAmpereSymbol = '1/%ss³/%sA²';
  rsReciprocalCubicSecondSquareAmpereName = 'reciprocal cubic %ssecond square %sampere';
  rsReciprocalCubicSecondSquareAmperePluralName = 'reciprocal cubic %ssecond square %sampere';

const
  ReciprocalCubicSecondSquareAmpereID = -153180;
  ReciprocalCubicSecondSquareAmpereUnit : TUnit = (
    FID         : ReciprocalCubicSecondSquareAmpereID;
    FSymbol     : rsReciprocalCubicSecondSquareAmpereSymbol;
    FName       : rsReciprocalCubicSecondSquareAmpereName;
    FPluralName : rsReciprocalCubicSecondSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-3, -2));

{ TCubicSecondSquareAmpere }

resourcestring
  rsCubicSecondSquareAmpereSymbol = '%ss³∙%sA²';
  rsCubicSecondSquareAmpereName = 'cubic %ssecond square %sampere';
  rsCubicSecondSquareAmperePluralName = 'cubic %sseconds square %samperes';

const
  CubicSecondSquareAmpereID = 153180;
  CubicSecondSquareAmpereUnit : TUnit = (
    FID         : CubicSecondSquareAmpereID;
    FSymbol     : rsCubicSecondSquareAmpereSymbol;
    FName       : rsCubicSecondSquareAmpereName;
    FPluralName : rsCubicSecondSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, 2));

{ TSquareAmperePerCubicMeter }

resourcestring
  rsSquareAmperePerCubicMeterSymbol = '%sA²/%sm³';
  rsSquareAmperePerCubicMeterName = 'square %sampere per cubic %smeter';
  rsSquareAmperePerCubicMeterPluralName = 'square %samperes per cubic %smeter';

const
  SquareAmperePerCubicMeterID = -70740;
  SquareAmperePerCubicMeterUnit : TUnit = (
    FID         : SquareAmperePerCubicMeterID;
    FSymbol     : rsSquareAmperePerCubicMeterSymbol;
    FName       : rsSquareAmperePerCubicMeterName;
    FPluralName : rsSquareAmperePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -3));

{ TCubicSecondPerCubicMeter }

resourcestring
  rsCubicSecondPerCubicMeterSymbol = '%ss³/%sm³';
  rsCubicSecondPerCubicMeterName = 'cubic %ssecond per cubic %smeter';
  rsCubicSecondPerCubicMeterPluralName = 'cubic %sseconds per cubic %smeter';

const
  CubicSecondPerCubicMeterID = -14760;
  CubicSecondPerCubicMeterUnit : TUnit = (
    FID         : CubicSecondPerCubicMeterID;
    FSymbol     : rsCubicSecondPerCubicMeterSymbol;
    FName       : rsCubicSecondPerCubicMeterName;
    FPluralName : rsCubicSecondPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -3));

{ TReciprocalKilogramCubicMeter }

resourcestring
  rsReciprocalKilogramCubicMeterSymbol = '1/%skg/%sm³';
  rsReciprocalKilogramCubicMeterName = 'reciprocal %skilogram cubic %smeter';
  rsReciprocalKilogramCubicMeterPluralName = 'reciprocal %skilogram cubic %smeter';

const
  ReciprocalKilogramCubicMeterID = -128400;
  ReciprocalKilogramCubicMeterUnit : TUnit = (
    FID         : ReciprocalKilogramCubicMeterID;
    FSymbol     : rsReciprocalKilogramCubicMeterSymbol;
    FName       : rsReciprocalKilogramCubicMeterName;
    FPluralName : rsReciprocalKilogramCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -3));

{ TSteradianPerCubicMeter }

resourcestring
  rsSteradianPerCubicMeterSymbol = 'sr/%sm³';
  rsSteradianPerCubicMeterName = 'steradian per cubic %smeter';
  rsSteradianPerCubicMeterPluralName = 'steradian per cubic %smeter';

const
  SteradianPerCubicMeterID = -81480;
  SteradianPerCubicMeterUnit : TUnit = (
    FID         : SteradianPerCubicMeterID;
    FSymbol     : rsSteradianPerCubicMeterSymbol;
    FName       : rsSteradianPerCubicMeterName;
    FPluralName : rsSteradianPerCubicMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TCandelaPerCubicMeter }

resourcestring
  rsCandelaPerCubicMeterSymbol = '%scd/%sm³';
  rsCandelaPerCubicMeterName = '%scandela per cubic %smeter';
  rsCandelaPerCubicMeterPluralName = '%scandelas per cubic %smeter';

const
  CandelaPerCubicMeterID = -79380;
  CandelaPerCubicMeterUnit : TUnit = (
    FID         : CandelaPerCubicMeterID;
    FSymbol     : rsCandelaPerCubicMeterSymbol;
    FName       : rsCandelaPerCubicMeterName;
    FPluralName : rsCandelaPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TMeterPerKelvin }

resourcestring
  rsMeterPerKelvinSymbol = '%sm/%sK';
  rsMeterPerKelvinName = '%smeter per %skelvin';
  rsMeterPerKelvinPluralName = '%smeters per %skelvin';

const
  MeterPerKelvinID = 20760;
  MeterPerKelvinUnit : TUnit = (
    FID         : MeterPerKelvinID;
    FSymbol     : rsMeterPerKelvinSymbol;
    FName       : rsMeterPerKelvinName;
    FPluralName : rsMeterPerKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TCubicSecondKelvin }

resourcestring
  rsCubicSecondKelvinSymbol = '%ss³∙%sK';
  rsCubicSecondKelvinName = 'cubic %ssecond %skelvin';
  rsCubicSecondKelvinPluralName = 'cubic %sseconds %skelvins';

const
  CubicSecondKelvinID = 123600;
  CubicSecondKelvinUnit : TUnit = (
    FID         : CubicSecondKelvinID;
    FSymbol     : rsCubicSecondKelvinSymbol;
    FName       : rsCubicSecondKelvinName;
    FPluralName : rsCubicSecondKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, 1));

{ TKelvinPerSquareMeter }

resourcestring
  rsKelvinPerSquareMeterSymbol = '%sK/%sm²';
  rsKelvinPerSquareMeterName = '%skelvin per square %smeter';
  rsKelvinPerSquareMeterPluralName = '%skelvins per square %smeter';

const
  KelvinPerSquareMeterID = -60540;
  KelvinPerSquareMeterUnit : TUnit = (
    FID         : KelvinPerSquareMeterID;
    FSymbol     : rsKelvinPerSquareMeterSymbol;
    FName       : rsKelvinPerSquareMeterName;
    FPluralName : rsKelvinPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TKelvinPerKilogram }

resourcestring
  rsKelvinPerKilogramSymbol = '%sK/%skg';
  rsKelvinPerKilogramName = '%skelvin per %skilogram';
  rsKelvinPerKilogramPluralName = '%skelvins per %skilogram';

const
  KelvinPerKilogramID = 9960;
  KelvinPerKilogramUnit : TUnit = (
    FID         : KelvinPerKilogramID;
    FSymbol     : rsKelvinPerKilogramSymbol;
    FName       : rsKelvinPerKilogramName;
    FPluralName : rsKelvinPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareMeterPerQuarticKelvin }

resourcestring
  rsSquareMeterPerQuarticKelvinSymbol = '%sm²/%sK⁴';
  rsSquareMeterPerQuarticKelvinName = 'square %smeter per quartic %skelvin';
  rsSquareMeterPerQuarticKelvinPluralName = 'square %smeters per quartic %skelvin';

const
  SquareMeterPerQuarticKelvinID = 3480;
  SquareMeterPerQuarticKelvinUnit : TUnit = (
    FID         : SquareMeterPerQuarticKelvinID;
    FSymbol     : rsSquareMeterPerQuarticKelvinSymbol;
    FName       : rsSquareMeterPerQuarticKelvinName;
    FPluralName : rsSquareMeterPerQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -4));

{ TReciprocalQuarticKelvin }

resourcestring
  rsReciprocalQuarticKelvinSymbol = '1/%sK⁴';
  rsReciprocalQuarticKelvinName = 'reciprocal quartic %skelvin';
  rsReciprocalQuarticKelvinPluralName = 'reciprocal quartic %skelvin';

const
  ReciprocalQuarticKelvinID = -76080;
  ReciprocalQuarticKelvinUnit : TUnit = (
    FID         : ReciprocalQuarticKelvinID;
    FSymbol     : rsReciprocalQuarticKelvinSymbol;
    FName       : rsReciprocalQuarticKelvinName;
    FPluralName : rsReciprocalQuarticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-4));

{ TReciprocalSquareSecondMole }

resourcestring
  rsReciprocalSquareSecondMoleSymbol = '1/%ss²/%smol';
  rsReciprocalSquareSecondMoleName = 'reciprocal square %ssecond %smole';
  rsReciprocalSquareSecondMolePluralName = 'reciprocal square %ssecond %smole';

const
  ReciprocalSquareSecondMoleID = -104400;
  ReciprocalSquareSecondMoleUnit : TUnit = (
    FID         : ReciprocalSquareSecondMoleID;
    FSymbol     : rsReciprocalSquareSecondMoleSymbol;
    FName       : rsReciprocalSquareSecondMoleName;
    FPluralName : rsReciprocalSquareSecondMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -1));

{ TSquareMeterPerMole }

resourcestring
  rsSquareMeterPerMoleSymbol = '%sm²/%smol';
  rsSquareMeterPerMoleName = 'square %smeter per %smole';
  rsSquareMeterPerMolePluralName = 'square %smeters per %smole';

const
  SquareMeterPerMoleID = 44880;
  SquareMeterPerMoleUnit : TUnit = (
    FID         : SquareMeterPerMoleID;
    FSymbol     : rsSquareMeterPerMoleSymbol;
    FName       : rsSquareMeterPerMoleName;
    FPluralName : rsSquareMeterPerMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TKilogramPerMole }

resourcestring
  rsKilogramPerMoleSymbol = '%skg/%smol';
  rsKilogramPerMoleName = '%skilogram per %smole';
  rsKilogramPerMolePluralName = '%skilograms per %smole';

const
  KilogramPerMoleID = -25620;
  KilogramPerMoleUnit : TUnit = (
    FID         : KilogramPerMoleID;
    FSymbol     : rsKilogramPerMoleSymbol;
    FName       : rsKilogramPerMoleName;
    FPluralName : rsKilogramPerMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TReciprocalSquareSecondKelvinMole }

resourcestring
  rsReciprocalSquareSecondKelvinMoleSymbol = '1/%ss²/%sK/%smol';
  rsReciprocalSquareSecondKelvinMoleName = 'reciprocal square %ssecond %skelvin %smole';
  rsReciprocalSquareSecondKelvinMolePluralName = 'reciprocal square %ssecond %skelvin %smole';

const
  ReciprocalSquareSecondKelvinMoleID = -123420;
  ReciprocalSquareSecondKelvinMoleUnit : TUnit = (
    FID         : ReciprocalSquareSecondKelvinMoleID;
    FSymbol     : rsReciprocalSquareSecondKelvinMoleSymbol;
    FName       : rsReciprocalSquareSecondKelvinMoleName;
    FPluralName : rsReciprocalSquareSecondKelvinMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (-2, -1, -1));

{ TSquareMeterPerKelvinPerMole }

resourcestring
  rsSquareMeterPerKelvinPerMoleSymbol = '%sm²/%sK/%smol';
  rsSquareMeterPerKelvinPerMoleName = 'square %smeter per %skelvin per %smole';
  rsSquareMeterPerKelvinPerMolePluralName = 'square %smeters per %skelvin per %smole';

const
  SquareMeterPerKelvinPerMoleID = 25860;
  SquareMeterPerKelvinPerMoleUnit : TUnit = (
    FID         : SquareMeterPerKelvinPerMoleID;
    FSymbol     : rsSquareMeterPerKelvinPerMoleSymbol;
    FName       : rsSquareMeterPerKelvinPerMoleName;
    FPluralName : rsSquareMeterPerKelvinPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -1));

{ TKilogramPerKelvinPerMole }

resourcestring
  rsKilogramPerKelvinPerMoleSymbol = '%skg/%sK/%smol';
  rsKilogramPerKelvinPerMoleName = '%skilogram per %skelvin per %smole';
  rsKilogramPerKelvinPerMolePluralName = '%skilograms per %skelvin per %smole';

const
  KilogramPerKelvinPerMoleID = -44640;
  KilogramPerKelvinPerMoleUnit : TUnit = (
    FID         : KilogramPerKelvinPerMoleID;
    FSymbol     : rsKilogramPerKelvinPerMoleSymbol;
    FName       : rsKilogramPerKelvinPerMoleName;
    FPluralName : rsKilogramPerKelvinPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TCubicMeterPerSquareAmpere }

resourcestring
  rsCubicMeterPerSquareAmpereSymbol = '%sm³/%sA²';
  rsCubicMeterPerSquareAmpereName = 'cubic %smeter per square %sampere';
  rsCubicMeterPerSquareAmperePluralName = 'cubic %smeters per square %sampere';

const
  CubicMeterPerSquareAmpereID = 70740;
  CubicMeterPerSquareAmpereUnit : TUnit = (
    FID         : CubicMeterPerSquareAmpereID;
    FSymbol     : rsCubicMeterPerSquareAmpereSymbol;
    FName       : rsCubicMeterPerSquareAmpereName;
    FPluralName : rsCubicMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -2));

{ TCubicMeterPerCubicSecond }

resourcestring
  rsCubicMeterPerCubicSecondSymbol = '%sm³/%ss³';
  rsCubicMeterPerCubicSecondName = 'cubic %smeter per cubic %ssecond';
  rsCubicMeterPerCubicSecondPluralName = 'cubic %smeters per cubic %ssecond';

const
  CubicMeterPerCubicSecondID = 14760;
  CubicMeterPerCubicSecondUnit : TUnit = (
    FID         : CubicMeterPerCubicSecondID;
    FSymbol     : rsCubicMeterPerCubicSecondSymbol;
    FName       : rsCubicMeterPerCubicSecondName;
    FPluralName : rsCubicMeterPerCubicSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -3));

{ TReciprocalSquareAmpere }

resourcestring
  rsReciprocalSquareAmpereSymbol = '1/%sA²';
  rsReciprocalSquareAmpereName = 'reciprocal square %sampere';
  rsReciprocalSquareAmperePluralName = 'reciprocal square %sampere';

const
  ReciprocalSquareAmpereID = -48600;
  ReciprocalSquareAmpereUnit : TUnit = (
    FID         : ReciprocalSquareAmpereID;
    FSymbol     : rsReciprocalSquareAmpereSymbol;
    FName       : rsReciprocalSquareAmpereName;
    FPluralName : rsReciprocalSquareAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TReciprocalQuarticSecondSquareAmpere }

resourcestring
  rsReciprocalQuarticSecondSquareAmpereSymbol = '1/%ss⁴/%sA²';
  rsReciprocalQuarticSecondSquareAmpereName = 'reciprocal quartic %ssecond square %sampere';
  rsReciprocalQuarticSecondSquareAmperePluralName = 'reciprocal quartic %ssecond square %sampere';

const
  ReciprocalQuarticSecondSquareAmpereID = -188040;
  ReciprocalQuarticSecondSquareAmpereUnit : TUnit = (
    FID         : ReciprocalQuarticSecondSquareAmpereID;
    FSymbol     : rsReciprocalQuarticSecondSquareAmpereSymbol;
    FName       : rsReciprocalQuarticSecondSquareAmpereName;
    FPluralName : rsReciprocalQuarticSecondSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-4, -2));

{ TMeterPerSquareAmpere }

resourcestring
  rsMeterPerSquareAmpereSymbol = '%sm/%sA²';
  rsMeterPerSquareAmpereName = '%smeter per square %sampere';
  rsMeterPerSquareAmperePluralName = '%smeters per square %sampere';

const
  MeterPerSquareAmpereID = -8820;
  MeterPerSquareAmpereUnit : TUnit = (
    FID         : MeterPerSquareAmpereID;
    FSymbol     : rsMeterPerSquareAmpereSymbol;
    FName       : rsMeterPerSquareAmpereName;
    FPluralName : rsMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TKilogramPerQuarticSecond }

resourcestring
  rsKilogramPerQuarticSecondSymbol = '%skg/%ss⁴';
  rsKilogramPerQuarticSecondName = '%skilogram per quartic %ssecond';
  rsKilogramPerQuarticSecondPluralName = '%skilograms per quartic %ssecond';

const
  KilogramPerQuarticSecondID = -130380;
  KilogramPerQuarticSecondUnit : TUnit = (
    FID         : KilogramPerQuarticSecondID;
    FSymbol     : rsKilogramPerQuarticSecondSymbol;
    FName       : rsKilogramPerQuarticSecondName;
    FPluralName : rsKilogramPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -4));

{ TCubicMeterPerQuarticSecond }

resourcestring
  rsCubicMeterPerQuarticSecondSymbol = '%sm³/%ss⁴';
  rsCubicMeterPerQuarticSecondName = 'cubic %smeter per quartic %ssecond';
  rsCubicMeterPerQuarticSecondPluralName = 'cubic %smeters per quartic %ssecond';

const
  CubicMeterPerQuarticSecondID = -20100;
  CubicMeterPerQuarticSecondUnit : TUnit = (
    FID         : CubicMeterPerQuarticSecondID;
    FSymbol     : rsCubicMeterPerQuarticSecondSymbol;
    FName       : rsCubicMeterPerQuarticSecondName;
    FPluralName : rsCubicMeterPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -4));

{ TCubicMeterPerAmpere }

resourcestring
  rsCubicMeterPerAmpereSymbol = '%sm³/%sA';
  rsCubicMeterPerAmpereName = 'cubic %smeter per %sampere';
  rsCubicMeterPerAmperePluralName = 'cubic %smeters per %sampere';

const
  CubicMeterPerAmpereID = 95040;
  CubicMeterPerAmpereUnit : TUnit = (
    FID         : CubicMeterPerAmpereID;
    FSymbol     : rsCubicMeterPerAmpereSymbol;
    FName       : rsCubicMeterPerAmpereName;
    FPluralName : rsCubicMeterPerAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TReciprocalQuarticSecondAmpere }

resourcestring
  rsReciprocalQuarticSecondAmpereSymbol = '1/%ss⁴/%sA';
  rsReciprocalQuarticSecondAmpereName = 'reciprocal quartic %ssecond %sampere';
  rsReciprocalQuarticSecondAmperePluralName = 'reciprocal quartic %ssecond %sampere';

const
  ReciprocalQuarticSecondAmpereID = -163740;
  ReciprocalQuarticSecondAmpereUnit : TUnit = (
    FID         : ReciprocalQuarticSecondAmpereID;
    FSymbol     : rsReciprocalQuarticSecondAmpereSymbol;
    FName       : rsReciprocalQuarticSecondAmpereName;
    FPluralName : rsReciprocalQuarticSecondAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-4, -1));

{ TQuarticSecondPerCubicMeter }

resourcestring
  rsQuarticSecondPerCubicMeterSymbol = '%ss⁴/%sm³';
  rsQuarticSecondPerCubicMeterName = 'quartic %ssecond per cubic %smeter';
  rsQuarticSecondPerCubicMeterPluralName = 'quartic %sseconds per cubic %smeter';

const
  QuarticSecondPerCubicMeterID = 20100;
  QuarticSecondPerCubicMeterUnit : TUnit = (
    FID         : QuarticSecondPerCubicMeterID;
    FSymbol     : rsQuarticSecondPerCubicMeterSymbol;
    FName       : rsQuarticSecondPerCubicMeterName;
    FPluralName : rsQuarticSecondPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -3));

{ TCubicSecondCandelaSteradian }

resourcestring
  rsCubicSecondCandelaSteradianSymbol = '%ss³∙%scd∙sr';
  rsCubicSecondCandelaSteradianName = 'cubic %ssecond %scandela steradian';
  rsCubicSecondCandelaSteradianPluralName = 'cubic %sseconds %scandelas steradian';

const
  CubicSecondCandelaSteradianID = 182400;
  CubicSecondCandelaSteradianUnit : TUnit = (
    FID         : CubicSecondCandelaSteradianID;
    FSymbol     : rsCubicSecondCandelaSteradianSymbol;
    FName       : rsCubicSecondCandelaSteradianName;
    FPluralName : rsCubicSecondCandelaSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, 1));

{ TCubicSecondSteradianPerSquareMeter }

resourcestring
  rsCubicSecondSteradianPerSquareMeterSymbol = '%ss³∙sr/%sm²';
  rsCubicSecondSteradianPerSquareMeterName = 'cubic %ssecond steradian per square %smeter';
  rsCubicSecondSteradianPerSquareMeterPluralName = 'cubic %sseconds steradian per square %smeter';

const
  CubicSecondSteradianPerSquareMeterID = 62880;
  CubicSecondSteradianPerSquareMeterUnit : TUnit = (
    FID         : CubicSecondSteradianPerSquareMeterID;
    FSymbol     : rsCubicSecondSteradianPerSquareMeterSymbol;
    FName       : rsCubicSecondSteradianPerSquareMeterName;
    FPluralName : rsCubicSecondSteradianPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -2));

{ TCubicSecondCandelaPerSquareMeter }

resourcestring
  rsCubicSecondCandelaPerSquareMeterSymbol = '%ss³∙%scd/%sm²';
  rsCubicSecondCandelaPerSquareMeterName = 'cubic %ssecond %scandela per square %smeter';
  rsCubicSecondCandelaPerSquareMeterPluralName = 'cubic %sseconds %scandelas per square %smeter';

const
  CubicSecondCandelaPerSquareMeterID = 64980;
  CubicSecondCandelaPerSquareMeterUnit : TUnit = (
    FID         : CubicSecondCandelaPerSquareMeterID;
    FSymbol     : rsCubicSecondCandelaPerSquareMeterSymbol;
    FName       : rsCubicSecondCandelaPerSquareMeterName;
    FPluralName : rsCubicSecondCandelaPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -2));

{ TCandelaSteradianPerKilogram }

resourcestring
  rsCandelaSteradianPerKilogramSymbol = '%scd∙sr/%skg';
  rsCandelaSteradianPerKilogramName = '%scandela steradian per %skilogram';
  rsCandelaSteradianPerKilogramPluralName = '%scandelas steradian per %skilogram';

const
  CandelaSteradianPerKilogramID = 68760;
  CandelaSteradianPerKilogramUnit : TUnit = (
    FID         : CandelaSteradianPerKilogramID;
    FSymbol     : rsCandelaSteradianPerKilogramSymbol;
    FName       : rsCandelaSteradianPerKilogramName;
    FPluralName : rsCandelaSteradianPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TCubicSecondSteradianPerKilogram }

resourcestring
  rsCubicSecondSteradianPerKilogramSymbol = '%ss³∙sr/%skg';
  rsCubicSecondSteradianPerKilogramName = 'cubic %ssecond steradian per %skilogram';
  rsCubicSecondSteradianPerKilogramPluralName = 'cubic %sseconds steradian per %skilogram';

const
  CubicSecondSteradianPerKilogramID = 133380;
  CubicSecondSteradianPerKilogramUnit : TUnit = (
    FID         : CubicSecondSteradianPerKilogramID;
    FSymbol     : rsCubicSecondSteradianPerKilogramSymbol;
    FName       : rsCubicSecondSteradianPerKilogramName;
    FPluralName : rsCubicSecondSteradianPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TCubicSecondCandelaPerKilogram }

resourcestring
  rsCubicSecondCandelaPerKilogramSymbol = '%ss³∙%scd/%skg';
  rsCubicSecondCandelaPerKilogramName = 'cubic %ssecond %scandela per %skilogram';
  rsCubicSecondCandelaPerKilogramPluralName = 'cubic %sseconds %scandelas per %skilogram';

const
  CubicSecondCandelaPerKilogramID = 135480;
  CubicSecondCandelaPerKilogramUnit : TUnit = (
    FID         : CubicSecondCandelaPerKilogramID;
    FSymbol     : rsCubicSecondCandelaPerKilogramSymbol;
    FName       : rsCubicSecondCandelaPerKilogramName;
    FPluralName : rsCubicSecondCandelaPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -1));

{ TSteradianPerKilogramPerSquareMeter }

resourcestring
  rsSteradianPerKilogramPerSquareMeterSymbol = 'sr/%skg/%sm²';
  rsSteradianPerKilogramPerSquareMeterName = 'steradian per %skilogram per square %smeter';
  rsSteradianPerKilogramPerSquareMeterPluralName = 'steradian per %skilogram per square %smeter';

const
  SteradianPerKilogramPerSquareMeterID = -50760;
  SteradianPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : SteradianPerKilogramPerSquareMeterID;
    FSymbol     : rsSteradianPerKilogramPerSquareMeterSymbol;
    FName       : rsSteradianPerKilogramPerSquareMeterName;
    FPluralName : rsSteradianPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -2));

{ TCandelaPerKilogramPerSquareMeter }

resourcestring
  rsCandelaPerKilogramPerSquareMeterSymbol = '%scd/%skg/%sm²';
  rsCandelaPerKilogramPerSquareMeterName = '%scandela per %skilogram per square %smeter';
  rsCandelaPerKilogramPerSquareMeterPluralName = '%scandelas per %skilogram per square %smeter';

const
  CandelaPerKilogramPerSquareMeterID = -48660;
  CandelaPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : CandelaPerKilogramPerSquareMeterID;
    FSymbol     : rsCandelaPerKilogramPerSquareMeterSymbol;
    FName       : rsCandelaPerKilogramPerSquareMeterName;
    FPluralName : rsCandelaPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TSquareMeterPerSteradian }

resourcestring
  rsSquareMeterPerSteradianSymbol = '%sm²/sr';
  rsSquareMeterPerSteradianName = 'square %smeter per steradian';
  rsSquareMeterPerSteradianPluralName = 'square %smeters per steradian';

const
  SquareMeterPerSteradianID = 41700;
  SquareMeterPerSteradianUnit : TUnit = (
    FID         : SquareMeterPerSteradianID;
    FSymbol     : rsSquareMeterPerSteradianSymbol;
    FName       : rsSquareMeterPerSteradianName;
    FPluralName : rsSquareMeterPerSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

{ TMeterPerSteradian }

resourcestring
  rsMeterPerSteradianSymbol = '%sm/sr';
  rsMeterPerSteradianName = '%smeter per steradian';
  rsMeterPerSteradianPluralName = '%smeters per steradian';

const
  MeterPerSteradianID = 1920;
  MeterPerSteradianUnit : TUnit = (
    FID         : MeterPerSteradianID;
    FSymbol     : rsMeterPerSteradianSymbol;
    FName       : rsMeterPerSteradianName;
    FPluralName : rsMeterPerSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TReciprocalSteradian }

resourcestring
  rsReciprocalSteradianSymbol = '1/sr';
  rsReciprocalSteradianName = 'reciprocal steradian';
  rsReciprocalSteradianPluralName = 'reciprocal steradian';

const
  ReciprocalSteradianID = -37860;
  ReciprocalSteradianUnit : TUnit = (
    FID         : ReciprocalSteradianID;
    FSymbol     : rsReciprocalSteradianSymbol;
    FName       : rsReciprocalSteradianName;
    FPluralName : rsReciprocalSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalMeterSteradian }

resourcestring
  rsReciprocalMeterSteradianSymbol = '1/%sm/sr';
  rsReciprocalMeterSteradianName = 'reciprocal %smeter steradian';
  rsReciprocalMeterSteradianPluralName = 'reciprocal %smeter steradian';

const
  ReciprocalMeterSteradianID = -77640;
  ReciprocalMeterSteradianUnit : TUnit = (
    FID         : ReciprocalMeterSteradianID;
    FSymbol     : rsReciprocalMeterSteradianSymbol;
    FName       : rsReciprocalMeterSteradianName;
    FPluralName : rsReciprocalMeterSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TCubicSecondAmpere }

resourcestring
  rsCubicSecondAmpereSymbol = '%ss³∙%sA';
  rsCubicSecondAmpereName = 'cubic %ssecond %sampere';
  rsCubicSecondAmperePluralName = 'cubic %sseconds %samperes';

const
  CubicSecondAmpereID = 128880;
  CubicSecondAmpereUnit : TUnit = (
    FID         : CubicSecondAmpereID;
    FSymbol     : rsCubicSecondAmpereSymbol;
    FName       : rsCubicSecondAmpereName;
    FPluralName : rsCubicSecondAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, 1));

{ TReciprocalKelvinMole }

resourcestring
  rsReciprocalKelvinMoleSymbol = '1/%sK/%smol';
  rsReciprocalKelvinMoleName = 'reciprocal %skelvin %smole';
  rsReciprocalKelvinMolePluralName = 'reciprocal %skelvin %smole';

const
  ReciprocalKelvinMoleID = -53700;
  ReciprocalKelvinMoleUnit : TUnit = (
    FID         : ReciprocalKelvinMoleID;
    FSymbol     : rsReciprocalKelvinMoleSymbol;
    FName       : rsReciprocalKelvinMoleName;
    FPluralName : rsReciprocalKelvinMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TCubicSecondSteradian }

resourcestring
  rsCubicSecondSteradianSymbol = '%ss³∙sr';
  rsCubicSecondSteradianName = 'cubic %ssecond steradian';
  rsCubicSecondSteradianPluralName = 'cubic %sseconds steradian';

const
  CubicSecondSteradianID = 142440;
  CubicSecondSteradianUnit : TUnit = (
    FID         : CubicSecondSteradianID;
    FSymbol     : rsCubicSecondSteradianSymbol;
    FName       : rsCubicSecondSteradianName;
    FPluralName : rsCubicSecondSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TCubicSecondCandela }

resourcestring
  rsCubicSecondCandelaSymbol = '%ss³∙%scd';
  rsCubicSecondCandelaName = 'cubic %ssecond %scandela';
  rsCubicSecondCandelaPluralName = 'cubic %sseconds %scandelas';

const
  CubicSecondCandelaID = 144540;
  CubicSecondCandelaUnit : TUnit = (
    FID         : CubicSecondCandelaID;
    FSymbol     : rsCubicSecondCandelaSymbol;
    FName       : rsCubicSecondCandelaName;
    FPluralName : rsCubicSecondCandelaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, 1));

{ TSteradianPerKilogram }

resourcestring
  rsSteradianPerKilogramSymbol = 'sr/%skg';
  rsSteradianPerKilogramName = 'steradian per %skilogram';
  rsSteradianPerKilogramPluralName = 'steradian per %skilogram';

const
  SteradianPerKilogramID = 28800;
  SteradianPerKilogramUnit : TUnit = (
    FID         : SteradianPerKilogramID;
    FSymbol     : rsSteradianPerKilogramSymbol;
    FName       : rsSteradianPerKilogramName;
    FPluralName : rsSteradianPerKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TCandelaPerKilogram }

resourcestring
  rsCandelaPerKilogramSymbol = '%scd/%skg';
  rsCandelaPerKilogramName = '%scandela per %skilogram';
  rsCandelaPerKilogramPluralName = '%scandelas per %skilogram';

const
  CandelaPerKilogramID = 30900;
  CandelaPerKilogramUnit : TUnit = (
    FID         : CandelaPerKilogramID;
    FSymbol     : rsCandelaPerKilogramSymbol;
    FName       : rsCandelaPerKilogramName;
    FPluralName : rsCandelaPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TReciprocalQuinticMeter }

resourcestring
  rsReciprocalQuinticMeterSymbol = '1/%sm⁵';
  rsReciprocalQuinticMeterName = 'reciprocal quintic %smeter';
  rsReciprocalQuinticMeterPluralName = 'reciprocal quintic %smeter';

const
  ReciprocalQuinticMeterID = -198900;
  ReciprocalQuinticMeterUnit : TUnit = (
    FID         : ReciprocalQuinticMeterID;
    FSymbol     : rsReciprocalQuinticMeterSymbol;
    FName       : rsReciprocalQuinticMeterName;
    FPluralName : rsReciprocalQuinticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticMeter }

resourcestring
  rsReciprocalSexticMeterSymbol = '1/%sm⁶';
  rsReciprocalSexticMeterName = 'reciprocal sextic %smeter';
  rsReciprocalSexticMeterPluralName = 'reciprocal sextic %smeter';

const
  ReciprocalSexticMeterID = -238680;
  ReciprocalSexticMeterUnit : TUnit = (
    FID         : ReciprocalSexticMeterID;
    FSymbol     : rsReciprocalSexticMeterSymbol;
    FName       : rsReciprocalSexticMeterName;
    FPluralName : rsReciprocalSexticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-6));

{ TReciprocalSquareKelvin }

resourcestring
  rsReciprocalSquareKelvinSymbol = '1/%sK²';
  rsReciprocalSquareKelvinName = 'reciprocal square %skelvin';
  rsReciprocalSquareKelvinPluralName = 'reciprocal square %skelvin';

const
  ReciprocalSquareKelvinID = -38040;
  ReciprocalSquareKelvinUnit : TUnit = (
    FID         : ReciprocalSquareKelvinID;
    FSymbol     : rsReciprocalSquareKelvinSymbol;
    FName       : rsReciprocalSquareKelvinName;
    FPluralName : rsReciprocalSquareKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TReciprocalCubicKelvin }

resourcestring
  rsReciprocalCubicKelvinSymbol = '1/%sK³';
  rsReciprocalCubicKelvinName = 'reciprocal cubic %skelvin';
  rsReciprocalCubicKelvinPluralName = 'reciprocal cubic %skelvin';

const
  ReciprocalCubicKelvinID = -57060;
  ReciprocalCubicKelvinUnit : TUnit = (
    FID         : ReciprocalCubicKelvinID;
    FSymbol     : rsReciprocalCubicKelvinSymbol;
    FName       : rsReciprocalCubicKelvinName;
    FPluralName : rsReciprocalCubicKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalCandela }

resourcestring
  rsReciprocalCandelaSymbol = '1/%scd';
  rsReciprocalCandelaName = 'reciprocal %scandela';
  rsReciprocalCandelaPluralName = 'reciprocal %scandela';

const
  ReciprocalCandelaID = -39960;
  ReciprocalCandelaUnit : TUnit = (
    FID         : ReciprocalCandelaID;
    FSymbol     : rsReciprocalCandelaSymbol;
    FName       : rsReciprocalCandelaName;
    FPluralName : rsReciprocalCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TSquareSecondPerSteradian }

resourcestring
  rsSquareSecondPerSteradianSymbol = '%ss²/sr';
  rsSquareSecondPerSteradianName = 'square %ssecond per steradian';
  rsSquareSecondPerSteradianPluralName = 'square %sseconds per steradian';

const
  SquareSecondPerSteradianID = 31860;
  SquareSecondPerSteradianUnit : TUnit = (
    FID         : SquareSecondPerSteradianID;
    FSymbol     : rsSquareSecondPerSteradianSymbol;
    FName       : rsSquareSecondPerSteradianName;
    FPluralName : rsSquareSecondPerSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

{ TQuarticSecondPerMeter }

resourcestring
  rsQuarticSecondPerMeterSymbol = '%ss⁴/%sm';
  rsQuarticSecondPerMeterName = 'quartic %ssecond per %smeter';
  rsQuarticSecondPerMeterPluralName = 'quartic %sseconds per %smeter';

const
  QuarticSecondPerMeterID = 99660;
  QuarticSecondPerMeterUnit : TUnit = (
    FID         : QuarticSecondPerMeterID;
    FSymbol     : rsQuarticSecondPerMeterSymbol;
    FName       : rsQuarticSecondPerMeterName;
    FPluralName : rsQuarticSecondPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -1));

{ TQuinticSecondPerMeter }

resourcestring
  rsQuinticSecondPerMeterSymbol = '%ss⁵/%sm';
  rsQuinticSecondPerMeterName = 'quintic %ssecond per %smeter';
  rsQuinticSecondPerMeterPluralName = 'quintic %sseconds per %smeter';

const
  QuinticSecondPerMeterID = 134520;
  QuinticSecondPerMeterUnit : TUnit = (
    FID         : QuinticSecondPerMeterID;
    FSymbol     : rsQuinticSecondPerMeterSymbol;
    FName       : rsQuinticSecondPerMeterName;
    FPluralName : rsQuinticSecondPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (5, -1));

{ TSexticSecondPerMeter }

resourcestring
  rsSexticSecondPerMeterSymbol = '%ss⁶/%sm';
  rsSexticSecondPerMeterName = 'sextic %ssecond per %smeter';
  rsSexticSecondPerMeterPluralName = 'sextic %sseconds per %smeter';

const
  SexticSecondPerMeterID = 169380;
  SexticSecondPerMeterUnit : TUnit = (
    FID         : SexticSecondPerMeterID;
    FSymbol     : rsSexticSecondPerMeterSymbol;
    FName       : rsSexticSecondPerMeterName;
    FPluralName : rsSexticSecondPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (6, -1));

{ TSecondPerKilogramPerMeter }

resourcestring
  rsSecondPerKilogramPerMeterSymbol = '%ss/%skg/%sm';
  rsSecondPerKilogramPerMeterName = '%ssecond per %skilogram per %smeter';
  rsSecondPerKilogramPerMeterPluralName = '%sseconds per %skilogram per %smeter';

const
  SecondPerKilogramPerMeterID = -13980;
  SecondPerKilogramPerMeterUnit : TUnit = (
    FID         : SecondPerKilogramPerMeterID;
    FSymbol     : rsSecondPerKilogramPerMeterSymbol;
    FName       : rsSecondPerKilogramPerMeterName;
    FPluralName : rsSecondPerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TSquareSecondPerSquareKilogramPerSquareMeter }

resourcestring
  rsSquareSecondPerSquareKilogramPerSquareMeterSymbol = '%ss²/%skg²/%sm²';
  rsSquareSecondPerSquareKilogramPerSquareMeterName = 'square %ssecond per square %skilogram per square %smeter';
  rsSquareSecondPerSquareKilogramPerSquareMeterPluralName = 'square %sseconds per square %skilogram per square %smeter';

const
  SquareSecondPerSquareKilogramPerSquareMeterID = -27960;
  SquareSecondPerSquareKilogramPerSquareMeterUnit : TUnit = (
    FID         : SquareSecondPerSquareKilogramPerSquareMeterID;
    FSymbol     : rsSquareSecondPerSquareKilogramPerSquareMeterSymbol;
    FName       : rsSquareSecondPerSquareKilogramPerSquareMeterName;
    FPluralName : rsSquareSecondPerSquareKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -2, -2));

{ TSecondPerKilogramPerSquareMeter }

resourcestring
  rsSecondPerKilogramPerSquareMeterSymbol = '%ss/%skg/%sm²';
  rsSecondPerKilogramPerSquareMeterName = '%ssecond per %skilogram per square %smeter';
  rsSecondPerKilogramPerSquareMeterPluralName = '%sseconds per %skilogram per square %smeter';

const
  SecondPerKilogramPerSquareMeterID = -53760;
  SecondPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : SecondPerKilogramPerSquareMeterID;
    FSymbol     : rsSecondPerKilogramPerSquareMeterSymbol;
    FName       : rsSecondPerKilogramPerSquareMeterName;
    FPluralName : rsSecondPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TSquareMeterPerKilogram }

resourcestring
  rsSquareMeterPerKilogramSymbol = '%sm²/%skg';
  rsSquareMeterPerKilogramName = 'square %smeter per %skilogram';
  rsSquareMeterPerKilogramPluralName = 'square %smeters per %skilogram';

const
  SquareMeterPerKilogramID = 70500;
  SquareMeterPerKilogramUnit : TUnit = (
    FID         : SquareMeterPerKilogramID;
    FSymbol     : rsSquareMeterPerKilogramSymbol;
    FName       : rsSquareMeterPerKilogramName;
    FPluralName : rsSquareMeterPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TQuarticSecondPerSquareKilogramPerSquareMeter }

resourcestring
  rsQuarticSecondPerSquareKilogramPerSquareMeterSymbol = '%ss⁴/%skg²/%sm²';
  rsQuarticSecondPerSquareKilogramPerSquareMeterName = 'quartic %ssecond per square %skilogram per square %smeter';
  rsQuarticSecondPerSquareKilogramPerSquareMeterPluralName = 'quartic %sseconds per square %skilogram per square %smeter';

const
  QuarticSecondPerSquareKilogramPerSquareMeterID = 41760;
  QuarticSecondPerSquareKilogramPerSquareMeterUnit : TUnit = (
    FID         : QuarticSecondPerSquareKilogramPerSquareMeterID;
    FSymbol     : rsQuarticSecondPerSquareKilogramPerSquareMeterSymbol;
    FName       : rsQuarticSecondPerSquareKilogramPerSquareMeterName;
    FPluralName : rsQuarticSecondPerSquareKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, -2, -2));

{ TReciprocalSecondAmpere }

resourcestring
  rsReciprocalSecondAmpereSymbol = '1/%ss/%sA';
  rsReciprocalSecondAmpereName = 'reciprocal %ssecond %sampere';
  rsReciprocalSecondAmperePluralName = 'reciprocal %ssecond %sampere';

const
  ReciprocalSecondAmpereID = -59160;
  ReciprocalSecondAmpereUnit : TUnit = (
    FID         : ReciprocalSecondAmpereID;
    FSymbol     : rsReciprocalSecondAmpereSymbol;
    FName       : rsReciprocalSecondAmpereName;
    FPluralName : rsReciprocalSecondAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TReciprocalMeterSecondAmpere }

resourcestring
  rsReciprocalMeterSecondAmpereSymbol = '1/%sm/%ss/%sA';
  rsReciprocalMeterSecondAmpereName = 'reciprocal %smeter %ssecond %sampere';
  rsReciprocalMeterSecondAmperePluralName = 'reciprocal %smeter %ssecond %sampere';

const
  ReciprocalMeterSecondAmpereID = -98940;
  ReciprocalMeterSecondAmpereUnit : TUnit = (
    FID         : ReciprocalMeterSecondAmpereID;
    FSymbol     : rsReciprocalMeterSecondAmpereSymbol;
    FName       : rsReciprocalMeterSecondAmpereName;
    FPluralName : rsReciprocalMeterSecondAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (-1, -1, -1));

{ TCubicSecondAmperePerKilogramPerSquareMeter }

resourcestring
  rsCubicSecondAmperePerKilogramPerSquareMeterSymbol = '%ss³∙%sA/%skg/%sm²';
  rsCubicSecondAmperePerKilogramPerSquareMeterName = 'cubic %ssecond %sampere per %skilogram per square %smeter';
  rsCubicSecondAmperePerKilogramPerSquareMeterPluralName = 'cubic %sseconds %samperes per %skilogram per square %smeter';

const
  CubicSecondAmperePerKilogramPerSquareMeterID = 40260;
  CubicSecondAmperePerKilogramPerSquareMeterUnit : TUnit = (
    FID         : CubicSecondAmperePerKilogramPerSquareMeterID;
    FSymbol     : rsCubicSecondAmperePerKilogramPerSquareMeterSymbol;
    FName       : rsCubicSecondAmperePerKilogramPerSquareMeterName;
    FPluralName : rsCubicSecondAmperePerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (3, 1, -1, -2));

{ TSexticSecondSquareAmperePerSquareKilogramPerQuarticMeter }

resourcestring
  rsSexticSecondSquareAmperePerSquareKilogramPerQuarticMeterSymbol = '%ss⁶∙%sA²/%skg²/%sm⁴';
  rsSexticSecondSquareAmperePerSquareKilogramPerQuarticMeterName = 'sextic %ssecond square %sampere per square %skilogram per quartic %smeter';
  rsSexticSecondSquareAmperePerSquareKilogramPerQuarticMeterPluralName = 'sextic %sseconds square %samperes per square %skilogram per quartic %smeter';

const
  SexticSecondSquareAmperePerSquareKilogramPerQuarticMeterID = 80520;
  SexticSecondSquareAmperePerSquareKilogramPerQuarticMeterUnit : TUnit = (
    FID         : SexticSecondSquareAmperePerSquareKilogramPerQuarticMeterID;
    FSymbol     : rsSexticSecondSquareAmperePerSquareKilogramPerQuarticMeterSymbol;
    FName       : rsSexticSecondSquareAmperePerSquareKilogramPerQuarticMeterName;
    FPluralName : rsSexticSecondSquareAmperePerSquareKilogramPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (6, 2, -2, -4));

{ TKilogramSquareMeterPerQuarticSecondPerSquareAmpere }

resourcestring
  rsKilogramSquareMeterPerQuarticSecondPerSquareAmpereSymbol = '%skg∙%sm²/%ss⁴/%sA²';
  rsKilogramSquareMeterPerQuarticSecondPerSquareAmpereName = '%skilogram square %smeter per quartic %ssecond per square %sampere';
  rsKilogramSquareMeterPerQuarticSecondPerSquareAmperePluralName = '%skilograms square %smeters per quartic %ssecond per square %sampere';

const
  KilogramSquareMeterPerQuarticSecondPerSquareAmpereID = -99420;
  KilogramSquareMeterPerQuarticSecondPerSquareAmpereUnit : TUnit = (
    FID         : KilogramSquareMeterPerQuarticSecondPerSquareAmpereID;
    FSymbol     : rsKilogramSquareMeterPerQuarticSecondPerSquareAmpereSymbol;
    FName       : rsKilogramSquareMeterPerQuarticSecondPerSquareAmpereName;
    FPluralName : rsKilogramSquareMeterPerQuarticSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (1, 2, -4, -2));

{ TReciprocalCandelaSteradian }

resourcestring
  rsReciprocalCandelaSteradianSymbol = '1/%scd/sr';
  rsReciprocalCandelaSteradianName = 'reciprocal %scandela steradian';
  rsReciprocalCandelaSteradianPluralName = 'reciprocal %scandela steradian';

const
  ReciprocalCandelaSteradianID = -77820;
  ReciprocalCandelaSteradianUnit : TUnit = (
    FID         : ReciprocalCandelaSteradianID;
    FSymbol     : rsReciprocalCandelaSteradianSymbol;
    FName       : rsReciprocalCandelaSteradianName;
    FPluralName : rsReciprocalCandelaSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSecondCandelaSteradian }

resourcestring
  rsReciprocalSecondCandelaSteradianSymbol = '1/%ss/%scd/sr';
  rsReciprocalSecondCandelaSteradianName = 'reciprocal %ssecond %scandela steradian';
  rsReciprocalSecondCandelaSteradianPluralName = 'reciprocal %ssecond %scandela steradian';

const
  ReciprocalSecondCandelaSteradianID = -112680;
  ReciprocalSecondCandelaSteradianUnit : TUnit = (
    FID         : ReciprocalSecondCandelaSteradianID;
    FSymbol     : rsReciprocalSecondCandelaSteradianSymbol;
    FName       : rsReciprocalSecondCandelaSteradianName;
    FPluralName : rsReciprocalSecondCandelaSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TCubicMeterPerSecondPerCandelaPerSteradian }

resourcestring
  rsCubicMeterPerSecondPerCandelaPerSteradianSymbol = '%sm³/%ss/%scd/sr';
  rsCubicMeterPerSecondPerCandelaPerSteradianName = 'cubic %smeter per %ssecond per %scandela per steradian';
  rsCubicMeterPerSecondPerCandelaPerSteradianPluralName = 'cubic %smeters per %ssecond per %scandela per steradian';

const
  CubicMeterPerSecondPerCandelaPerSteradianID = 6660;
  CubicMeterPerSecondPerCandelaPerSteradianUnit : TUnit = (
    FID         : CubicMeterPerSecondPerCandelaPerSteradianID;
    FSymbol     : rsCubicMeterPerSecondPerCandelaPerSteradianSymbol;
    FName       : rsCubicMeterPerSecondPerCandelaPerSteradianName;
    FPluralName : rsCubicMeterPerSecondPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -1, -1));

{ TSquareMeterPerCandelaPerSteradian }

resourcestring
  rsSquareMeterPerCandelaPerSteradianSymbol = '%sm²/%scd/sr';
  rsSquareMeterPerCandelaPerSteradianName = 'square %smeter per %scandela per steradian';
  rsSquareMeterPerCandelaPerSteradianPluralName = 'square %smeters per %scandela per steradian';

const
  SquareMeterPerCandelaPerSteradianID = 1740;
  SquareMeterPerCandelaPerSteradianUnit : TUnit = (
    FID         : SquareMeterPerCandelaPerSteradianID;
    FSymbol     : rsSquareMeterPerCandelaPerSteradianSymbol;
    FName       : rsSquareMeterPerCandelaPerSteradianName;
    FPluralName : rsSquareMeterPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TSquareMeterPerSecondPerCandelaPerSteradian }

resourcestring
  rsSquareMeterPerSecondPerCandelaPerSteradianSymbol = '%sm²/%ss/%scd/sr';
  rsSquareMeterPerSecondPerCandelaPerSteradianName = 'square %smeter per %ssecond per %scandela per steradian';
  rsSquareMeterPerSecondPerCandelaPerSteradianPluralName = 'square %smeters per %ssecond per %scandela per steradian';

const
  SquareMeterPerSecondPerCandelaPerSteradianID = -33120;
  SquareMeterPerSecondPerCandelaPerSteradianUnit : TUnit = (
    FID         : SquareMeterPerSecondPerCandelaPerSteradianID;
    FSymbol     : rsSquareMeterPerSecondPerCandelaPerSteradianSymbol;
    FName       : rsSquareMeterPerSecondPerCandelaPerSteradianName;
    FPluralName : rsSquareMeterPerSecondPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -1));

{ TSquareMeterSquareSecondPerKilogram }

resourcestring
  rsSquareMeterSquareSecondPerKilogramSymbol = '%sm²∙%ss²/%skg';
  rsSquareMeterSquareSecondPerKilogramName = 'square %smeter square %ssecond per %skilogram';
  rsSquareMeterSquareSecondPerKilogramPluralName = 'square %smeters square %sseconds per %skilogram';

const
  SquareMeterSquareSecondPerKilogramID = 140220;
  SquareMeterSquareSecondPerKilogramUnit : TUnit = (
    FID         : SquareMeterSquareSecondPerKilogramID;
    FSymbol     : rsSquareMeterSquareSecondPerKilogramSymbol;
    FName       : rsSquareMeterSquareSecondPerKilogramName;
    FPluralName : rsSquareMeterSquareSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 2, -1));

{ TMeterSecondPerKilogram }

resourcestring
  rsMeterSecondPerKilogramSymbol = '%sm∙%ss/%skg';
  rsMeterSecondPerKilogramName = '%smeter %ssecond per %skilogram';
  rsMeterSecondPerKilogramPluralName = '%smeters %sseconds per %skilogram';

const
  MeterSecondPerKilogramID = 65580;
  MeterSecondPerKilogramUnit : TUnit = (
    FID         : MeterSecondPerKilogramID;
    FSymbol     : rsMeterSecondPerKilogramSymbol;
    FName       : rsMeterSecondPerKilogramName;
    FPluralName : rsMeterSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TQuarticMeterPerKilogram }

resourcestring
  rsQuarticMeterPerKilogramSymbol = '%sm⁴/%skg';
  rsQuarticMeterPerKilogramName = 'quartic %smeter per %skilogram';
  rsQuarticMeterPerKilogramPluralName = 'quartic %smeters per %skilogram';

const
  QuarticMeterPerKilogramID = 150060;
  QuarticMeterPerKilogramUnit : TUnit = (
    FID         : QuarticMeterPerKilogramID;
    FSymbol     : rsQuarticMeterPerKilogramSymbol;
    FName       : rsQuarticMeterPerKilogramName;
    FPluralName : rsQuarticMeterPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -1));

{ TQuarticMeterSecondPerKilogram }

resourcestring
  rsQuarticMeterSecondPerKilogramSymbol = '%sm⁴∙%ss/%skg';
  rsQuarticMeterSecondPerKilogramName = 'quartic %smeter %ssecond per %skilogram';
  rsQuarticMeterSecondPerKilogramPluralName = 'quartic %smeters %sseconds per %skilogram';

const
  QuarticMeterSecondPerKilogramID = 184920;
  QuarticMeterSecondPerKilogramUnit : TUnit = (
    FID         : QuarticMeterSecondPerKilogramID;
    FSymbol     : rsQuarticMeterSecondPerKilogramSymbol;
    FName       : rsQuarticMeterSecondPerKilogramName;
    FPluralName : rsQuarticMeterSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, 1, -1));

{ TSquareSecondPerCubicMeter }

resourcestring
  rsSquareSecondPerCubicMeterSymbol = '%ss²/%sm³';
  rsSquareSecondPerCubicMeterName = 'square %ssecond per cubic %smeter';
  rsSquareSecondPerCubicMeterPluralName = 'square %sseconds per cubic %smeter';

const
  SquareSecondPerCubicMeterID = -49620;
  SquareSecondPerCubicMeterUnit : TUnit = (
    FID         : SquareSecondPerCubicMeterID;
    FSymbol     : rsSquareSecondPerCubicMeterSymbol;
    FName       : rsSquareSecondPerCubicMeterName;
    FPluralName : rsSquareSecondPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -3));

{ TSquareSecondPerKilogramPerCubicMeter }

resourcestring
  rsSquareSecondPerKilogramPerCubicMeterSymbol = '%ss²/%skg/%sm³';
  rsSquareSecondPerKilogramPerCubicMeterName = 'square %ssecond per %skilogram per cubic %smeter';
  rsSquareSecondPerKilogramPerCubicMeterPluralName = 'square %sseconds per %skilogram per cubic %smeter';

const
  SquareSecondPerKilogramPerCubicMeterID = -58680;
  SquareSecondPerKilogramPerCubicMeterUnit : TUnit = (
    FID         : SquareSecondPerKilogramPerCubicMeterID;
    FSymbol     : rsSquareSecondPerKilogramPerCubicMeterSymbol;
    FName       : rsSquareSecondPerKilogramPerCubicMeterName;
    FPluralName : rsSquareSecondPerKilogramPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -3));

{ TSquareSecondPerKilogramPerQuarticMeter }

resourcestring
  rsSquareSecondPerKilogramPerQuarticMeterSymbol = '%ss²/%skg/%sm⁴';
  rsSquareSecondPerKilogramPerQuarticMeterName = 'square %ssecond per %skilogram per quartic %smeter';
  rsSquareSecondPerKilogramPerQuarticMeterPluralName = 'square %sseconds per %skilogram per quartic %smeter';

const
  SquareSecondPerKilogramPerQuarticMeterID = -98460;
  SquareSecondPerKilogramPerQuarticMeterUnit : TUnit = (
    FID         : SquareSecondPerKilogramPerQuarticMeterID;
    FSymbol     : rsSquareSecondPerKilogramPerQuarticMeterSymbol;
    FName       : rsSquareSecondPerKilogramPerQuarticMeterName;
    FPluralName : rsSquareSecondPerKilogramPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -4));

{ TKilogramSquareSecondPerMeter }

resourcestring
  rsKilogramSquareSecondPerMeterSymbol = '%skg∙%ss²/%sm';
  rsKilogramSquareSecondPerMeterName = '%skilogram square %ssecond per %smeter';
  rsKilogramSquareSecondPerMeterPluralName = '%skilograms square %sseconds per %smeter';

const
  KilogramSquareSecondPerMeterID = 39000;
  KilogramSquareSecondPerMeterUnit : TUnit = (
    FID         : KilogramSquareSecondPerMeterID;
    FSymbol     : rsKilogramSquareSecondPerMeterSymbol;
    FName       : rsKilogramSquareSecondPerMeterName;
    FPluralName : rsKilogramSquareSecondPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TMeterPerSquareKilogram }

resourcestring
  rsMeterPerSquareKilogramSymbol = '%sm/%skg²';
  rsMeterPerSquareKilogramName = '%smeter per square %skilogram';
  rsMeterPerSquareKilogramPluralName = '%smeters per square %skilogram';

const
  MeterPerSquareKilogramID = 21660;
  MeterPerSquareKilogramUnit : TUnit = (
    FID         : MeterPerSquareKilogramID;
    FSymbol     : rsMeterPerSquareKilogramSymbol;
    FName       : rsMeterPerSquareKilogramName;
    FPluralName : rsMeterPerSquareKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TKilogramSquareSecondPerCubicMeter }

resourcestring
  rsKilogramSquareSecondPerCubicMeterSymbol = '%skg∙%ss²/%sm³';
  rsKilogramSquareSecondPerCubicMeterName = '%skilogram square %ssecond per cubic %smeter';
  rsKilogramSquareSecondPerCubicMeterPluralName = '%skilograms square %sseconds per cubic %smeter';

const
  KilogramSquareSecondPerCubicMeterID = -40560;
  KilogramSquareSecondPerCubicMeterUnit : TUnit = (
    FID         : KilogramSquareSecondPerCubicMeterID;
    FSymbol     : rsKilogramSquareSecondPerCubicMeterSymbol;
    FName       : rsKilogramSquareSecondPerCubicMeterName;
    FPluralName : rsKilogramSquareSecondPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -3));

{ TReciprocalKilogramKelvin }

resourcestring
  rsReciprocalKilogramKelvinSymbol = '1/%skg/%sK';
  rsReciprocalKilogramKelvinName = 'reciprocal %skilogram %skelvin';
  rsReciprocalKilogramKelvinPluralName = 'reciprocal %skilogram %skelvin';

const
  ReciprocalKilogramKelvinID = -28080;
  ReciprocalKilogramKelvinUnit : TUnit = (
    FID         : ReciprocalKilogramKelvinID;
    FSymbol     : rsReciprocalKilogramKelvinSymbol;
    FName       : rsReciprocalKilogramKelvinName;
    FPluralName : rsReciprocalKilogramKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TSquareSecondKelvinPerKilogramPerSquareMeter }

resourcestring
  rsSquareSecondKelvinPerKilogramPerSquareMeterSymbol = '%ss²∙%sK/%skg/%sm²';
  rsSquareSecondKelvinPerKilogramPerSquareMeterName = 'square %ssecond %skelvin per %skilogram per square %smeter';
  rsSquareSecondKelvinPerKilogramPerSquareMeterPluralName = 'square %sseconds %skelvins per %skilogram per square %smeter';

const
  SquareSecondKelvinPerKilogramPerSquareMeterID = 120;
  SquareSecondKelvinPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : SquareSecondKelvinPerKilogramPerSquareMeterID;
    FSymbol     : rsSquareSecondKelvinPerKilogramPerSquareMeterSymbol;
    FName       : rsSquareSecondKelvinPerKilogramPerSquareMeterName;
    FPluralName : rsSquareSecondKelvinPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (2, 1, -1, -2));

{ TSquareSecondKelvinPerSquareMeter }

resourcestring
  rsSquareSecondKelvinPerSquareMeterSymbol = '%ss²∙%sK/%sm²';
  rsSquareSecondKelvinPerSquareMeterName = 'square %ssecond %skelvin per square %smeter';
  rsSquareSecondKelvinPerSquareMeterPluralName = 'square %sseconds %skelvins per square %smeter';

const
  SquareSecondKelvinPerSquareMeterID = 9180;
  SquareSecondKelvinPerSquareMeterUnit : TUnit = (
    FID         : SquareSecondKelvinPerSquareMeterID;
    FSymbol     : rsSquareSecondKelvinPerSquareMeterSymbol;
    FName       : rsSquareSecondKelvinPerSquareMeterName;
    FPluralName : rsSquareSecondKelvinPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 1, -2));

{ TReciprocalMeterKelvin }

resourcestring
  rsReciprocalMeterKelvinSymbol = '1/%sm/%sK';
  rsReciprocalMeterKelvinName = 'reciprocal %smeter %skelvin';
  rsReciprocalMeterKelvinPluralName = 'reciprocal %smeter %skelvin';

const
  ReciprocalMeterKelvinID = -58800;
  ReciprocalMeterKelvinUnit : TUnit = (
    FID         : ReciprocalMeterKelvinID;
    FSymbol     : rsReciprocalMeterKelvinSymbol;
    FName       : rsReciprocalMeterKelvinName;
    FPluralName : rsReciprocalMeterKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TMeterCubicSecondPerKilogram }

resourcestring
  rsMeterCubicSecondPerKilogramSymbol = '%sm∙%ss³/%skg';
  rsMeterCubicSecondPerKilogramName = '%smeter cubic %ssecond per %skilogram';
  rsMeterCubicSecondPerKilogramPluralName = '%smeters cubic %sseconds per %skilogram';

const
  MeterCubicSecondPerKilogramID = 135300;
  MeterCubicSecondPerKilogramUnit : TUnit = (
    FID         : MeterCubicSecondPerKilogramID;
    FSymbol     : rsMeterCubicSecondPerKilogramSymbol;
    FName       : rsMeterCubicSecondPerKilogramName;
    FPluralName : rsMeterCubicSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 3, -1));

{ TReciprocalSquareMeterKelvin }

resourcestring
  rsReciprocalSquareMeterKelvinSymbol = '1/%sm²/%sK';
  rsReciprocalSquareMeterKelvinName = 'reciprocal square %smeter %skelvin';
  rsReciprocalSquareMeterKelvinPluralName = 'reciprocal square %smeter %skelvin';

const
  ReciprocalSquareMeterKelvinID = -98580;
  ReciprocalSquareMeterKelvinUnit : TUnit = (
    FID         : ReciprocalSquareMeterKelvinID;
    FSymbol     : rsReciprocalSquareMeterKelvinSymbol;
    FName       : rsReciprocalSquareMeterKelvinName;
    FPluralName : rsReciprocalSquareMeterKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -1));

{ TReciprocalSquareMeterQuarticKelvin }

resourcestring
  rsReciprocalSquareMeterQuarticKelvinSymbol = '1/%sm²/%sK⁴';
  rsReciprocalSquareMeterQuarticKelvinName = 'reciprocal square %smeter quartic %skelvin';
  rsReciprocalSquareMeterQuarticKelvinPluralName = 'reciprocal square %smeter quartic %skelvin';

const
  ReciprocalSquareMeterQuarticKelvinID = -155640;
  ReciprocalSquareMeterQuarticKelvinUnit : TUnit = (
    FID         : ReciprocalSquareMeterQuarticKelvinID;
    FSymbol     : rsReciprocalSquareMeterQuarticKelvinSymbol;
    FName       : rsReciprocalSquareMeterQuarticKelvinName;
    FPluralName : rsReciprocalSquareMeterQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -4));

{ TCubicSecondQuarticKelvinPerKilogramPerSquareMeter }

resourcestring
  rsCubicSecondQuarticKelvinPerKilogramPerSquareMeterSymbol = '%ss³∙%sK⁴/%skg/%sm²';
  rsCubicSecondQuarticKelvinPerKilogramPerSquareMeterName = 'cubic %ssecond quartic %skelvin per %skilogram per square %smeter';
  rsCubicSecondQuarticKelvinPerKilogramPerSquareMeterPluralName = 'cubic %sseconds quartic %skelvins per %skilogram per square %smeter';

const
  CubicSecondQuarticKelvinPerKilogramPerSquareMeterID = 92040;
  CubicSecondQuarticKelvinPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : CubicSecondQuarticKelvinPerKilogramPerSquareMeterID;
    FSymbol     : rsCubicSecondQuarticKelvinPerKilogramPerSquareMeterSymbol;
    FName       : rsCubicSecondQuarticKelvinPerKilogramPerSquareMeterName;
    FPluralName : rsCubicSecondQuarticKelvinPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (3, 4, -1, -2));

{ TCubicSecondQuarticKelvinPerKilogram }

resourcestring
  rsCubicSecondQuarticKelvinPerKilogramSymbol = '%ss³∙%sK⁴/%skg';
  rsCubicSecondQuarticKelvinPerKilogramName = 'cubic %ssecond quartic %skelvin per %skilogram';
  rsCubicSecondQuarticKelvinPerKilogramPluralName = 'cubic %sseconds quartic %skelvins per %skilogram';

const
  CubicSecondQuarticKelvinPerKilogramID = 171600;
  CubicSecondQuarticKelvinPerKilogramUnit : TUnit = (
    FID         : CubicSecondQuarticKelvinPerKilogramID;
    FSymbol     : rsCubicSecondQuarticKelvinPerKilogramSymbol;
    FName       : rsCubicSecondQuarticKelvinPerKilogramName;
    FPluralName : rsCubicSecondQuarticKelvinPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 4, -1));

{ TSquareSecondMolePerKilogramPerSquareMeter }

resourcestring
  rsSquareSecondMolePerKilogramPerSquareMeterSymbol = '%ss²∙%smol/%skg/%sm²';
  rsSquareSecondMolePerKilogramPerSquareMeterName = 'square %ssecond %smole per %skilogram per square %smeter';
  rsSquareSecondMolePerKilogramPerSquareMeterPluralName = 'square %sseconds %smoles per %skilogram per square %smeter';

const
  SquareSecondMolePerKilogramPerSquareMeterID = 15780;
  SquareSecondMolePerKilogramPerSquareMeterUnit : TUnit = (
    FID         : SquareSecondMolePerKilogramPerSquareMeterID;
    FSymbol     : rsSquareSecondMolePerKilogramPerSquareMeterSymbol;
    FName       : rsSquareSecondMolePerKilogramPerSquareMeterName;
    FPluralName : rsSquareSecondMolePerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (2, 1, -1, -2));

{ TSquareSecondKelvinMolePerKilogramPerSquareMeter }

resourcestring
  rsSquareSecondKelvinMolePerKilogramPerSquareMeterSymbol = '%ss²∙%sK∙%smol/%skg/%sm²';
  rsSquareSecondKelvinMolePerKilogramPerSquareMeterName = 'square %ssecond %skelvin %smole per %skilogram per square %smeter';
  rsSquareSecondKelvinMolePerKilogramPerSquareMeterPluralName = 'square %sseconds %skelvins %smoles per %skilogram per square %smeter';

const
  SquareSecondKelvinMolePerKilogramPerSquareMeterID = 34800;
  SquareSecondKelvinMolePerKilogramPerSquareMeterUnit : TUnit = (
    FID         : SquareSecondKelvinMolePerKilogramPerSquareMeterID;
    FSymbol     : rsSquareSecondKelvinMolePerKilogramPerSquareMeterSymbol;
    FName       : rsSquareSecondKelvinMolePerKilogramPerSquareMeterName;
    FPluralName : rsSquareSecondKelvinMolePerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone, pNone);
    FExponents  : (2, 1, 1, -1, -2));

{ TMeterPerSecondPerAmpere }

resourcestring
  rsMeterPerSecondPerAmpereSymbol = '%sm/%ss/%sA';
  rsMeterPerSecondPerAmpereName = '%smeter per %ssecond per %sampere';
  rsMeterPerSecondPerAmperePluralName = '%smeters per %ssecond per %sampere';

const
  MeterPerSecondPerAmpereID = -19380;
  MeterPerSecondPerAmpereUnit : TUnit = (
    FID         : MeterPerSecondPerAmpereID;
    FSymbol     : rsMeterPerSecondPerAmpereSymbol;
    FName       : rsMeterPerSecondPerAmpereName;
    FPluralName : rsMeterPerSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TSquareMeterPerSecondPerAmpere }

resourcestring
  rsSquareMeterPerSecondPerAmpereSymbol = '%sm²/%ss/%sA';
  rsSquareMeterPerSecondPerAmpereName = 'square %smeter per %ssecond per %sampere';
  rsSquareMeterPerSecondPerAmperePluralName = 'square %smeters per %ssecond per %sampere';

const
  SquareMeterPerSecondPerAmpereID = 20400;
  SquareMeterPerSecondPerAmpereUnit : TUnit = (
    FID         : SquareMeterPerSecondPerAmpereID;
    FSymbol     : rsSquareMeterPerSecondPerAmpereSymbol;
    FName       : rsSquareMeterPerSecondPerAmpereName;
    FPluralName : rsSquareMeterPerSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -1));

{ TQuarticSecondSquareAmperePerKilogramPerMeter }

resourcestring
  rsQuarticSecondSquareAmperePerKilogramPerMeterSymbol = '%ss⁴∙%sA²/%skg/%sm';
  rsQuarticSecondSquareAmperePerKilogramPerMeterName = 'quartic %ssecond square %sampere per %skilogram per %smeter';
  rsQuarticSecondSquareAmperePerKilogramPerMeterPluralName = 'quartic %sseconds square %samperes per %skilogram per %smeter';

const
  QuarticSecondSquareAmperePerKilogramPerMeterID = 139200;
  QuarticSecondSquareAmperePerKilogramPerMeterUnit : TUnit = (
    FID         : QuarticSecondSquareAmperePerKilogramPerMeterID;
    FSymbol     : rsQuarticSecondSquareAmperePerKilogramPerMeterSymbol;
    FName       : rsQuarticSecondSquareAmperePerKilogramPerMeterName;
    FPluralName : rsQuarticSecondSquareAmperePerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (4, 2, -1, -1));

{ TCubicSecondAmperePerKilogramPerCubicMeter }

resourcestring
  rsCubicSecondAmperePerKilogramPerCubicMeterSymbol = '%ss³∙%sA/%skg/%sm³';
  rsCubicSecondAmperePerKilogramPerCubicMeterName = 'cubic %ssecond %sampere per %skilogram per cubic %smeter';
  rsCubicSecondAmperePerKilogramPerCubicMeterPluralName = 'cubic %sseconds %samperes per %skilogram per cubic %smeter';

const
  CubicSecondAmperePerKilogramPerCubicMeterID = 480;
  CubicSecondAmperePerKilogramPerCubicMeterUnit : TUnit = (
    FID         : CubicSecondAmperePerKilogramPerCubicMeterID;
    FSymbol     : rsCubicSecondAmperePerKilogramPerCubicMeterSymbol;
    FName       : rsCubicSecondAmperePerKilogramPerCubicMeterName;
    FPluralName : rsCubicSecondAmperePerKilogramPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (3, 1, -1, -3));

{ TQuarticSecondAmperePerKilogramPerCubicMeter }

resourcestring
  rsQuarticSecondAmperePerKilogramPerCubicMeterSymbol = '%ss⁴∙%sA/%skg/%sm³';
  rsQuarticSecondAmperePerKilogramPerCubicMeterName = 'quartic %ssecond %sampere per %skilogram per cubic %smeter';
  rsQuarticSecondAmperePerKilogramPerCubicMeterPluralName = 'quartic %sseconds %samperes per %skilogram per cubic %smeter';

const
  QuarticSecondAmperePerKilogramPerCubicMeterID = 35340;
  QuarticSecondAmperePerKilogramPerCubicMeterUnit : TUnit = (
    FID         : QuarticSecondAmperePerKilogramPerCubicMeterID;
    FSymbol     : rsQuarticSecondAmperePerKilogramPerCubicMeterSymbol;
    FName       : rsQuarticSecondAmperePerKilogramPerCubicMeterName;
    FPluralName : rsQuarticSecondAmperePerKilogramPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (4, 1, -1, -3));

{ TSquareSecondAmperePerKilogramPerMeter }

resourcestring
  rsSquareSecondAmperePerKilogramPerMeterSymbol = '%ss²∙%sA/%skg/%sm';
  rsSquareSecondAmperePerKilogramPerMeterName = 'square %ssecond %sampere per %skilogram per %smeter';
  rsSquareSecondAmperePerKilogramPerMeterPluralName = 'square %sseconds %samperes per %skilogram per %smeter';

const
  SquareSecondAmperePerKilogramPerMeterID = 45180;
  SquareSecondAmperePerKilogramPerMeterUnit : TUnit = (
    FID         : SquareSecondAmperePerKilogramPerMeterID;
    FSymbol     : rsSquareSecondAmperePerKilogramPerMeterSymbol;
    FName       : rsSquareSecondAmperePerKilogramPerMeterName;
    FPluralName : rsSquareSecondAmperePerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (2, 1, -1, -1));

{ TSquareSecondSquareAmperePerKilogramPerMeter }

resourcestring
  rsSquareSecondSquareAmperePerKilogramPerMeterSymbol = '%ss²∙%sA²/%skg/%sm';
  rsSquareSecondSquareAmperePerKilogramPerMeterName = 'square %ssecond square %sampere per %skilogram per %smeter';
  rsSquareSecondSquareAmperePerKilogramPerMeterPluralName = 'square %sseconds square %samperes per %skilogram per %smeter';

const
  SquareSecondSquareAmperePerKilogramPerMeterID = 69480;
  SquareSecondSquareAmperePerKilogramPerMeterUnit : TUnit = (
    FID         : SquareSecondSquareAmperePerKilogramPerMeterID;
    FSymbol     : rsSquareSecondSquareAmperePerKilogramPerMeterSymbol;
    FName       : rsSquareSecondSquareAmperePerKilogramPerMeterName;
    FPluralName : rsSquareSecondSquareAmperePerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (2, 2, -1, -1));

{ TSquareSecondPerSquareKilogram }

resourcestring
  rsSquareSecondPerSquareKilogramSymbol = '%ss²/%skg²';
  rsSquareSecondPerSquareKilogramName = 'square %ssecond per square %skilogram';
  rsSquareSecondPerSquareKilogramPluralName = 'square %sseconds per square %skilogram';

const
  SquareSecondPerSquareKilogramID = 51600;
  SquareSecondPerSquareKilogramUnit : TUnit = (
    FID         : SquareSecondPerSquareKilogramID;
    FSymbol     : rsSquareSecondPerSquareKilogramSymbol;
    FName       : rsSquareSecondPerSquareKilogramName;
    FPluralName : rsSquareSecondPerSquareKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TQuarticSecondPerSquareKilogramPerQuarticMeter }

resourcestring
  rsQuarticSecondPerSquareKilogramPerQuarticMeterSymbol = '%ss⁴/%skg²/%sm⁴';
  rsQuarticSecondPerSquareKilogramPerQuarticMeterName = 'quartic %ssecond per square %skilogram per quartic %smeter';
  rsQuarticSecondPerSquareKilogramPerQuarticMeterPluralName = 'quartic %sseconds per square %skilogram per quartic %smeter';

const
  QuarticSecondPerSquareKilogramPerQuarticMeterID = -37800;
  QuarticSecondPerSquareKilogramPerQuarticMeterUnit : TUnit = (
    FID         : QuarticSecondPerSquareKilogramPerQuarticMeterID;
    FSymbol     : rsQuarticSecondPerSquareKilogramPerQuarticMeterSymbol;
    FName       : rsQuarticSecondPerSquareKilogramPerQuarticMeterName;
    FPluralName : rsQuarticSecondPerSquareKilogramPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, -2, -4));

{ TSquareSecondPerSquareKilogramPerQuarticMeter }

resourcestring
  rsSquareSecondPerSquareKilogramPerQuarticMeterSymbol = '%ss²/%skg²/%sm⁴';
  rsSquareSecondPerSquareKilogramPerQuarticMeterName = 'square %ssecond per square %skilogram per quartic %smeter';
  rsSquareSecondPerSquareKilogramPerQuarticMeterPluralName = 'square %sseconds per square %skilogram per quartic %smeter';

const
  SquareSecondPerSquareKilogramPerQuarticMeterID = -107520;
  SquareSecondPerSquareKilogramPerQuarticMeterUnit : TUnit = (
    FID         : SquareSecondPerSquareKilogramPerQuarticMeterID;
    FSymbol     : rsSquareSecondPerSquareKilogramPerQuarticMeterSymbol;
    FName       : rsSquareSecondPerSquareKilogramPerQuarticMeterName;
    FPluralName : rsSquareSecondPerSquareKilogramPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -2, -4));

{ TKilogramPerSecondPerAmpere }

resourcestring
  rsKilogramPerSecondPerAmpereSymbol = '%skg/%ss/%sA';
  rsKilogramPerSecondPerAmpereName = '%skilogram per %ssecond per %sampere';
  rsKilogramPerSecondPerAmperePluralName = '%skilograms per %ssecond per %sampere';

const
  KilogramPerSecondPerAmpereID = -50100;
  KilogramPerSecondPerAmpereUnit : TUnit = (
    FID         : KilogramPerSecondPerAmpereID;
    FSymbol     : rsKilogramPerSecondPerAmpereSymbol;
    FName       : rsKilogramPerSecondPerAmpereName;
    FPluralName : rsKilogramPerSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TReciprocalSquareMeterAmpere }

resourcestring
  rsReciprocalSquareMeterAmpereSymbol = '1/%sm²/%sA';
  rsReciprocalSquareMeterAmpereName = 'reciprocal square %smeter %sampere';
  rsReciprocalSquareMeterAmperePluralName = 'reciprocal square %smeter %sampere';

const
  ReciprocalSquareMeterAmpereID = -103860;
  ReciprocalSquareMeterAmpereUnit : TUnit = (
    FID         : ReciprocalSquareMeterAmpereID;
    FSymbol     : rsReciprocalSquareMeterAmpereSymbol;
    FName       : rsReciprocalSquareMeterAmpereName;
    FPluralName : rsReciprocalSquareMeterAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -1));

{ TKilogramSquareMeterPerCubicSecondPerCandelaPerSteradian }

resourcestring
  rsKilogramSquareMeterPerCubicSecondPerCandelaPerSteradianSymbol = '%skg∙%sm²/%ss³/%scd/sr';
  rsKilogramSquareMeterPerCubicSecondPerCandelaPerSteradianName = '%skilogram square %smeter per cubic %ssecond per %scandela per steradian';
  rsKilogramSquareMeterPerCubicSecondPerCandelaPerSteradianPluralName = '%skilograms square %smeters per cubic %ssecond per %scandela per steradian';

const
  KilogramSquareMeterPerCubicSecondPerCandelaPerSteradianID = -93780;
  KilogramSquareMeterPerCubicSecondPerCandelaPerSteradianUnit : TUnit = (
    FID         : KilogramSquareMeterPerCubicSecondPerCandelaPerSteradianID;
    FSymbol     : rsKilogramSquareMeterPerCubicSecondPerCandelaPerSteradianSymbol;
    FName       : rsKilogramSquareMeterPerCubicSecondPerCandelaPerSteradianName;
    FPluralName : rsKilogramSquareMeterPerCubicSecondPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (1, 2, -3, -1));

{ TCubicMeterPerMole }

resourcestring
  rsCubicMeterPerMoleSymbol = '%sm³/%smol';
  rsCubicMeterPerMoleName = 'cubic %smeter per %smole';
  rsCubicMeterPerMolePluralName = 'cubic %smeters per %smole';

const
  CubicMeterPerMoleID = 84660;
  CubicMeterPerMoleUnit : TUnit = (
    FID         : CubicMeterPerMoleID;
    FSymbol     : rsCubicMeterPerMoleSymbol;
    FName       : rsCubicMeterPerMoleName;
    FPluralName : rsCubicMeterPerMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TSquareMeterPerCandela }

resourcestring
  rsSquareMeterPerCandelaSymbol = '%sm²/%scd';
  rsSquareMeterPerCandelaName = 'square %smeter per %scandela';
  rsSquareMeterPerCandelaPluralName = 'square %smeters per %scandela';

const
  SquareMeterPerCandelaID = 39600;
  SquareMeterPerCandelaUnit : TUnit = (
    FID         : SquareMeterPerCandelaID;
    FSymbol     : rsSquareMeterPerCandelaSymbol;
    FName       : rsSquareMeterPerCandelaName;
    FPluralName : rsSquareMeterPerCandelaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TCubicMeterPerSecondPerAmpere }

resourcestring
  rsCubicMeterPerSecondPerAmpereSymbol = '%sm³/%ss/%sA';
  rsCubicMeterPerSecondPerAmpereName = 'cubic %smeter per %ssecond per %sampere';
  rsCubicMeterPerSecondPerAmperePluralName = 'cubic %smeters per %ssecond per %sampere';

const
  CubicMeterPerSecondPerAmpereID = 60180;
  CubicMeterPerSecondPerAmpereUnit : TUnit = (
    FID         : CubicMeterPerSecondPerAmpereID;
    FSymbol     : rsCubicMeterPerSecondPerAmpereSymbol;
    FName       : rsCubicMeterPerSecondPerAmpereName;
    FPluralName : rsCubicMeterPerSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -1, -1));

{ TSecondPerSteradian }

resourcestring
  rsSecondPerSteradianSymbol = '%ss/sr';
  rsSecondPerSteradianName = '%ssecond per steradian';
  rsSecondPerSteradianPluralName = '%sseconds per steradian';

const
  SecondPerSteradianID = -3000;
  SecondPerSteradianUnit : TUnit = (
    FID         : SecondPerSteradianID;
    FSymbol     : rsSecondPerSteradianSymbol;
    FName       : rsSecondPerSteradianName;
    FPluralName : rsSecondPerSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TReciprocalSquareMeterSteradian }

resourcestring
  rsReciprocalSquareMeterSteradianSymbol = '1/%sm²/sr';
  rsReciprocalSquareMeterSteradianName = 'reciprocal square %smeter steradian';
  rsReciprocalSquareMeterSteradianPluralName = 'reciprocal square %smeter steradian';

const
  ReciprocalSquareMeterSteradianID = -117420;
  ReciprocalSquareMeterSteradianUnit : TUnit = (
    FID         : ReciprocalSquareMeterSteradianID;
    FSymbol     : rsReciprocalSquareMeterSteradianSymbol;
    FName       : rsReciprocalSquareMeterSteradianName;
    FPluralName : rsReciprocalSquareMeterSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TReciprocalCubicMeterSteradian }

resourcestring
  rsReciprocalCubicMeterSteradianSymbol = '1/%sm³/sr';
  rsReciprocalCubicMeterSteradianName = 'reciprocal cubic %smeter steradian';
  rsReciprocalCubicMeterSteradianPluralName = 'reciprocal cubic %smeter steradian';

const
  ReciprocalCubicMeterSteradianID = -157200;
  ReciprocalCubicMeterSteradianUnit : TUnit = (
    FID         : ReciprocalCubicMeterSteradianID;
    FSymbol     : rsReciprocalCubicMeterSteradianSymbol;
    FName       : rsReciprocalCubicMeterSteradianName;
    FPluralName : rsReciprocalCubicMeterSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TSecondPerSquareMeterPerSteradian }

resourcestring
  rsSecondPerSquareMeterPerSteradianSymbol = '%ss/%sm²/sr';
  rsSecondPerSquareMeterPerSteradianName = '%ssecond per square %smeter per steradian';
  rsSecondPerSquareMeterPerSteradianPluralName = '%sseconds per square %smeter per steradian';

const
  SecondPerSquareMeterPerSteradianID = -82560;
  SecondPerSquareMeterPerSteradianUnit : TUnit = (
    FID         : SecondPerSquareMeterPerSteradianID;
    FSymbol     : rsSecondPerSquareMeterPerSteradianSymbol;
    FName       : rsSecondPerSquareMeterPerSteradianName;
    FPluralName : rsSecondPerSquareMeterPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TSquareSecondSteradianPerKilogramPerSquareMeter }

resourcestring
  rsSquareSecondSteradianPerKilogramPerSquareMeterSymbol = '%ss²∙sr/%skg/%sm²';
  rsSquareSecondSteradianPerKilogramPerSquareMeterName = 'square %ssecond steradian per %skilogram per square %smeter';
  rsSquareSecondSteradianPerKilogramPerSquareMeterPluralName = 'square %sseconds steradian per %skilogram per square %smeter';

const
  SquareSecondSteradianPerKilogramPerSquareMeterID = 18960;
  SquareSecondSteradianPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : SquareSecondSteradianPerKilogramPerSquareMeterID;
    FSymbol     : rsSquareSecondSteradianPerKilogramPerSquareMeterSymbol;
    FName       : rsSquareSecondSteradianPerKilogramPerSquareMeterName;
    FPluralName : rsSquareSecondSteradianPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -2));

{ TCubicSecondSteradianPerKilogramPerMeter }

resourcestring
  rsCubicSecondSteradianPerKilogramPerMeterSymbol = '%ss³∙sr/%skg/%sm';
  rsCubicSecondSteradianPerKilogramPerMeterName = 'cubic %ssecond steradian per %skilogram per %smeter';
  rsCubicSecondSteradianPerKilogramPerMeterPluralName = 'cubic %sseconds steradian per %skilogram per %smeter';

const
  CubicSecondSteradianPerKilogramPerMeterID = 93600;
  CubicSecondSteradianPerKilogramPerMeterUnit : TUnit = (
    FID         : CubicSecondSteradianPerKilogramPerMeterID;
    FSymbol     : rsCubicSecondSteradianPerKilogramPerMeterSymbol;
    FName       : rsCubicSecondSteradianPerKilogramPerMeterName;
    FPluralName : rsCubicSecondSteradianPerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -1, -1));

{ TMeterCubicSecondSteradianPerKilogram }

resourcestring
  rsMeterCubicSecondSteradianPerKilogramSymbol = '%sm∙%ss³∙sr/%skg';
  rsMeterCubicSecondSteradianPerKilogramName = '%smeter cubic %ssecond steradian per %skilogram';
  rsMeterCubicSecondSteradianPerKilogramPluralName = '%smeters cubic %sseconds steradian per %skilogram';

const
  MeterCubicSecondSteradianPerKilogramID = 173160;
  MeterCubicSecondSteradianPerKilogramUnit : TUnit = (
    FID         : MeterCubicSecondSteradianPerKilogramID;
    FSymbol     : rsMeterCubicSecondSteradianPerKilogramSymbol;
    FName       : rsMeterCubicSecondSteradianPerKilogramName;
    FPluralName : rsMeterCubicSecondSteradianPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 3, -1));

{ TSquareSecondSteradianPerKilogram }

resourcestring
  rsSquareSecondSteradianPerKilogramSymbol = '%ss²∙sr/%skg';
  rsSquareSecondSteradianPerKilogramName = 'square %ssecond steradian per %skilogram';
  rsSquareSecondSteradianPerKilogramPluralName = 'square %sseconds steradian per %skilogram';

const
  SquareSecondSteradianPerKilogramID = 98520;
  SquareSecondSteradianPerKilogramUnit : TUnit = (
    FID         : SquareSecondSteradianPerKilogramID;
    FSymbol     : rsSquareSecondSteradianPerKilogramSymbol;
    FName       : rsSquareSecondSteradianPerKilogramName;
    FPluralName : rsSquareSecondSteradianPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TCubicMeterSecondPerMole }

resourcestring
  rsCubicMeterSecondPerMoleSymbol = '%sm³∙%ss/%smol';
  rsCubicMeterSecondPerMoleName = 'cubic %smeter %ssecond per %smole';
  rsCubicMeterSecondPerMolePluralName = 'cubic %smeters %sseconds per %smole';

const
  CubicMeterSecondPerMoleID = 119520;
  CubicMeterSecondPerMoleUnit : TUnit = (
    FID         : CubicMeterSecondPerMoleID;
    FSymbol     : rsCubicMeterSecondPerMoleSymbol;
    FName       : rsCubicMeterSecondPerMoleName;
    FPluralName : rsCubicMeterSecondPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -1));

{ TMolePerSecondPerAmpere }

resourcestring
  rsMolePerSecondPerAmpereSymbol = '%smol/%ss/%sA';
  rsMolePerSecondPerAmpereName = '%smole per %ssecond per %sampere';
  rsMolePerSecondPerAmperePluralName = '%smoles per %ssecond per %sampere';

const
  MolePerSecondPerAmpereID = -24480;
  MolePerSecondPerAmpereUnit : TUnit = (
    FID         : MolePerSecondPerAmpereID;
    FSymbol     : rsMolePerSecondPerAmpereSymbol;
    FName       : rsMolePerSecondPerAmpereName;
    FPluralName : rsMolePerSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TReciprocalQuarticRootKilogram }

resourcestring
  rsReciprocalQuarticRootKilogramSymbol = '1/∜%skg';
  rsReciprocalQuarticRootKilogramName = 'reciprocal quartic root %skilogram';
  rsReciprocalQuarticRootKilogramPluralName = 'reciprocal quartic root %skilogram';

const
  ReciprocalQuarticRootKilogramID = -2265;
  ReciprocalQuarticRootKilogramUnit : TUnit = (
    FID         : ReciprocalQuarticRootKilogramID;
    FSymbol     : rsReciprocalQuarticRootKilogramSymbol;
    FName       : rsReciprocalQuarticRootKilogramName;
    FPluralName : rsReciprocalQuarticRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicRootKilogram }

resourcestring
  rsReciprocalCubicRootKilogramSymbol = '1/∛%skg';
  rsReciprocalCubicRootKilogramName = 'reciprocal cubic root %skilogram';
  rsReciprocalCubicRootKilogramPluralName = 'reciprocal cubic root %skilogram';

const
  ReciprocalCubicRootKilogramID = -3020;
  ReciprocalCubicRootKilogramUnit : TUnit = (
    FID         : ReciprocalCubicRootKilogramID;
    FSymbol     : rsReciprocalCubicRootKilogramSymbol;
    FName       : rsReciprocalCubicRootKilogramName;
    FPluralName : rsReciprocalCubicRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootKilogram }

resourcestring
  rsReciprocalSquareRootKilogramSymbol = '1/√%skg';
  rsReciprocalSquareRootKilogramName = 'reciprocal square root %skilogram';
  rsReciprocalSquareRootKilogramPluralName = 'reciprocal square root %skilogram';

const
  ReciprocalSquareRootKilogramID = -4530;
  ReciprocalSquareRootKilogramUnit : TUnit = (
    FID         : ReciprocalSquareRootKilogramID;
    FSymbol     : rsReciprocalSquareRootKilogramSymbol;
    FName       : rsReciprocalSquareRootKilogramName;
    FPluralName : rsReciprocalSquareRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootCubicKilogram }

resourcestring
  rsReciprocalSquareRootCubicKilogramSymbol = '1/√%skg³';
  rsReciprocalSquareRootCubicKilogramName = 'reciprocal square root cubic %skilogram';
  rsReciprocalSquareRootCubicKilogramPluralName = 'reciprocal square root cubic %skilogram';

const
  ReciprocalSquareRootCubicKilogramID = -13590;
  ReciprocalSquareRootCubicKilogramUnit : TUnit = (
    FID         : ReciprocalSquareRootCubicKilogramID;
    FSymbol     : rsReciprocalSquareRootCubicKilogramSymbol;
    FName       : rsReciprocalSquareRootCubicKilogramName;
    FPluralName : rsReciprocalSquareRootCubicKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootQuinticKilogram }

resourcestring
  rsReciprocalSquareRootQuinticKilogramSymbol = '1/√%skg⁵';
  rsReciprocalSquareRootQuinticKilogramName = 'reciprocal square root quintic %skilogram';
  rsReciprocalSquareRootQuinticKilogramPluralName = 'reciprocal square root quintic %skilogram';

const
  ReciprocalSquareRootQuinticKilogramID = -22650;
  ReciprocalSquareRootQuinticKilogramUnit : TUnit = (
    FID         : ReciprocalSquareRootQuinticKilogramID;
    FSymbol     : rsReciprocalSquareRootQuinticKilogramSymbol;
    FName       : rsReciprocalSquareRootQuinticKilogramName;
    FPluralName : rsReciprocalSquareRootQuinticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalCubicKilogram }

resourcestring
  rsReciprocalCubicKilogramSymbol = '1/%skg³';
  rsReciprocalCubicKilogramName = 'reciprocal cubic %skilogram';
  rsReciprocalCubicKilogramPluralName = 'reciprocal cubic %skilogram';

const
  ReciprocalCubicKilogramID = -27180;
  ReciprocalCubicKilogramUnit : TUnit = (
    FID         : ReciprocalCubicKilogramID;
    FSymbol     : rsReciprocalCubicKilogramSymbol;
    FName       : rsReciprocalCubicKilogramName;
    FPluralName : rsReciprocalCubicKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalQuarticKilogram }

resourcestring
  rsReciprocalQuarticKilogramSymbol = '1/%skg⁴';
  rsReciprocalQuarticKilogramName = 'reciprocal quartic %skilogram';
  rsReciprocalQuarticKilogramPluralName = 'reciprocal quartic %skilogram';

const
  ReciprocalQuarticKilogramID = -36240;
  ReciprocalQuarticKilogramUnit : TUnit = (
    FID         : ReciprocalQuarticKilogramID;
    FSymbol     : rsReciprocalQuarticKilogramSymbol;
    FName       : rsReciprocalQuarticKilogramName;
    FPluralName : rsReciprocalQuarticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-4));

{ TReciprocalQuinticKilogram }

resourcestring
  rsReciprocalQuinticKilogramSymbol = '1/%skg⁵';
  rsReciprocalQuinticKilogramName = 'reciprocal quintic %skilogram';
  rsReciprocalQuinticKilogramPluralName = 'reciprocal quintic %skilogram';

const
  ReciprocalQuinticKilogramID = -45300;
  ReciprocalQuinticKilogramUnit : TUnit = (
    FID         : ReciprocalQuinticKilogramID;
    FSymbol     : rsReciprocalQuinticKilogramSymbol;
    FName       : rsReciprocalQuinticKilogramName;
    FPluralName : rsReciprocalQuinticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticKilogram }

resourcestring
  rsReciprocalSexticKilogramSymbol = '1/%skg⁶';
  rsReciprocalSexticKilogramName = 'reciprocal sextic %skilogram';
  rsReciprocalSexticKilogramPluralName = 'reciprocal sextic %skilogram';

const
  ReciprocalSexticKilogramID = -54360;
  ReciprocalSexticKilogramUnit : TUnit = (
    FID         : ReciprocalSexticKilogramID;
    FSymbol     : rsReciprocalSexticKilogramSymbol;
    FName       : rsReciprocalSexticKilogramName;
    FPluralName : rsReciprocalSexticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-6));

{ TReciprocalQuarticRootMeter }

resourcestring
  rsReciprocalQuarticRootMeterSymbol = '1/∜%sm';
  rsReciprocalQuarticRootMeterName = 'reciprocal quartic root %smeter';
  rsReciprocalQuarticRootMeterPluralName = 'reciprocal quartic root %smeter';

const
  ReciprocalQuarticRootMeterID = -9945;
  ReciprocalQuarticRootMeterUnit : TUnit = (
    FID         : ReciprocalQuarticRootMeterID;
    FSymbol     : rsReciprocalQuarticRootMeterSymbol;
    FName       : rsReciprocalQuarticRootMeterName;
    FPluralName : rsReciprocalQuarticRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicRootMeter }

resourcestring
  rsReciprocalCubicRootMeterSymbol = '1/∛%sm';
  rsReciprocalCubicRootMeterName = 'reciprocal cubic root %smeter';
  rsReciprocalCubicRootMeterPluralName = 'reciprocal cubic root %smeter';

const
  ReciprocalCubicRootMeterID = -13260;
  ReciprocalCubicRootMeterUnit : TUnit = (
    FID         : ReciprocalCubicRootMeterID;
    FSymbol     : rsReciprocalCubicRootMeterSymbol;
    FName       : rsReciprocalCubicRootMeterName;
    FPluralName : rsReciprocalCubicRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootQuinticMeter }

resourcestring
  rsReciprocalSquareRootQuinticMeterSymbol = '1/√%sm⁵';
  rsReciprocalSquareRootQuinticMeterName = 'reciprocal square root quintic %smeter';
  rsReciprocalSquareRootQuinticMeterPluralName = 'reciprocal square root quintic %smeter';

const
  ReciprocalSquareRootQuinticMeterID = -99450;
  ReciprocalSquareRootQuinticMeterUnit : TUnit = (
    FID         : ReciprocalSquareRootQuinticMeterID;
    FSymbol     : rsReciprocalSquareRootQuinticMeterSymbol;
    FName       : rsReciprocalSquareRootQuinticMeterName;
    FPluralName : rsReciprocalSquareRootQuinticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalQuarticRootSecond }

resourcestring
  rsReciprocalQuarticRootSecondSymbol = '1/∜%ss';
  rsReciprocalQuarticRootSecondName = 'reciprocal quartic root %ssecond';
  rsReciprocalQuarticRootSecondPluralName = 'reciprocal quartic root %ssecond';

const
  ReciprocalQuarticRootSecondID = -8715;
  ReciprocalQuarticRootSecondUnit : TUnit = (
    FID         : ReciprocalQuarticRootSecondID;
    FSymbol     : rsReciprocalQuarticRootSecondSymbol;
    FName       : rsReciprocalQuarticRootSecondName;
    FPluralName : rsReciprocalQuarticRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicRootSecond }

resourcestring
  rsReciprocalCubicRootSecondSymbol = '1/∛%ss';
  rsReciprocalCubicRootSecondName = 'reciprocal cubic root %ssecond';
  rsReciprocalCubicRootSecondPluralName = 'reciprocal cubic root %ssecond';

const
  ReciprocalCubicRootSecondID = -11620;
  ReciprocalCubicRootSecondUnit : TUnit = (
    FID         : ReciprocalCubicRootSecondID;
    FSymbol     : rsReciprocalCubicRootSecondSymbol;
    FName       : rsReciprocalCubicRootSecondName;
    FPluralName : rsReciprocalCubicRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootSecond }

resourcestring
  rsReciprocalSquareRootSecondSymbol = '1/√%ss';
  rsReciprocalSquareRootSecondName = 'reciprocal square root %ssecond';
  rsReciprocalSquareRootSecondPluralName = 'reciprocal square root %ssecond';

const
  ReciprocalSquareRootSecondID = -17430;
  ReciprocalSquareRootSecondUnit : TUnit = (
    FID         : ReciprocalSquareRootSecondID;
    FSymbol     : rsReciprocalSquareRootSecondSymbol;
    FName       : rsReciprocalSquareRootSecondName;
    FPluralName : rsReciprocalSquareRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootCubicSecond }

resourcestring
  rsReciprocalSquareRootCubicSecondSymbol = '1/√%ss³';
  rsReciprocalSquareRootCubicSecondName = 'reciprocal square root cubic %ssecond';
  rsReciprocalSquareRootCubicSecondPluralName = 'reciprocal square root cubic %ssecond';

const
  ReciprocalSquareRootCubicSecondID = -52290;
  ReciprocalSquareRootCubicSecondUnit : TUnit = (
    FID         : ReciprocalSquareRootCubicSecondID;
    FSymbol     : rsReciprocalSquareRootCubicSecondSymbol;
    FName       : rsReciprocalSquareRootCubicSecondName;
    FPluralName : rsReciprocalSquareRootCubicSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootQuinticSecond }

resourcestring
  rsReciprocalSquareRootQuinticSecondSymbol = '1/√%ss⁵';
  rsReciprocalSquareRootQuinticSecondName = 'reciprocal square root quintic %ssecond';
  rsReciprocalSquareRootQuinticSecondPluralName = 'reciprocal square root quintic %ssecond';

const
  ReciprocalSquareRootQuinticSecondID = -87150;
  ReciprocalSquareRootQuinticSecondUnit : TUnit = (
    FID         : ReciprocalSquareRootQuinticSecondID;
    FSymbol     : rsReciprocalSquareRootQuinticSecondSymbol;
    FName       : rsReciprocalSquareRootQuinticSecondName;
    FPluralName : rsReciprocalSquareRootQuinticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalQuarticRootAmpere }

resourcestring
  rsReciprocalQuarticRootAmpereSymbol = '1/∜%sA';
  rsReciprocalQuarticRootAmpereName = 'reciprocal quartic root %sampere';
  rsReciprocalQuarticRootAmperePluralName = 'reciprocal quartic root %sampere';

const
  ReciprocalQuarticRootAmpereID = -6075;
  ReciprocalQuarticRootAmpereUnit : TUnit = (
    FID         : ReciprocalQuarticRootAmpereID;
    FSymbol     : rsReciprocalQuarticRootAmpereSymbol;
    FName       : rsReciprocalQuarticRootAmpereName;
    FPluralName : rsReciprocalQuarticRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicRootAmpere }

resourcestring
  rsReciprocalCubicRootAmpereSymbol = '1/∛%sA';
  rsReciprocalCubicRootAmpereName = 'reciprocal cubic root %sampere';
  rsReciprocalCubicRootAmperePluralName = 'reciprocal cubic root %sampere';

const
  ReciprocalCubicRootAmpereID = -8100;
  ReciprocalCubicRootAmpereUnit : TUnit = (
    FID         : ReciprocalCubicRootAmpereID;
    FSymbol     : rsReciprocalCubicRootAmpereSymbol;
    FName       : rsReciprocalCubicRootAmpereName;
    FPluralName : rsReciprocalCubicRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootAmpere }

resourcestring
  rsReciprocalSquareRootAmpereSymbol = '1/√%sA';
  rsReciprocalSquareRootAmpereName = 'reciprocal square root %sampere';
  rsReciprocalSquareRootAmperePluralName = 'reciprocal square root %sampere';

const
  ReciprocalSquareRootAmpereID = -12150;
  ReciprocalSquareRootAmpereUnit : TUnit = (
    FID         : ReciprocalSquareRootAmpereID;
    FSymbol     : rsReciprocalSquareRootAmpereSymbol;
    FName       : rsReciprocalSquareRootAmpereName;
    FPluralName : rsReciprocalSquareRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootCubicAmpere }

resourcestring
  rsReciprocalSquareRootCubicAmpereSymbol = '1/√%sA³';
  rsReciprocalSquareRootCubicAmpereName = 'reciprocal square root cubic %sampere';
  rsReciprocalSquareRootCubicAmperePluralName = 'reciprocal square root cubic %sampere';

const
  ReciprocalSquareRootCubicAmpereID = -36450;
  ReciprocalSquareRootCubicAmpereUnit : TUnit = (
    FID         : ReciprocalSquareRootCubicAmpereID;
    FSymbol     : rsReciprocalSquareRootCubicAmpereSymbol;
    FName       : rsReciprocalSquareRootCubicAmpereName;
    FPluralName : rsReciprocalSquareRootCubicAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootQuinticAmpere }

resourcestring
  rsReciprocalSquareRootQuinticAmpereSymbol = '1/√%sA⁵';
  rsReciprocalSquareRootQuinticAmpereName = 'reciprocal square root quintic %sampere';
  rsReciprocalSquareRootQuinticAmperePluralName = 'reciprocal square root quintic %sampere';

const
  ReciprocalSquareRootQuinticAmpereID = -60750;
  ReciprocalSquareRootQuinticAmpereUnit : TUnit = (
    FID         : ReciprocalSquareRootQuinticAmpereID;
    FSymbol     : rsReciprocalSquareRootQuinticAmpereSymbol;
    FName       : rsReciprocalSquareRootQuinticAmpereName;
    FPluralName : rsReciprocalSquareRootQuinticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalCubicAmpere }

resourcestring
  rsReciprocalCubicAmpereSymbol = '1/%sA³';
  rsReciprocalCubicAmpereName = 'reciprocal cubic %sampere';
  rsReciprocalCubicAmperePluralName = 'reciprocal cubic %sampere';

const
  ReciprocalCubicAmpereID = -72900;
  ReciprocalCubicAmpereUnit : TUnit = (
    FID         : ReciprocalCubicAmpereID;
    FSymbol     : rsReciprocalCubicAmpereSymbol;
    FName       : rsReciprocalCubicAmpereName;
    FPluralName : rsReciprocalCubicAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalQuarticAmpere }

resourcestring
  rsReciprocalQuarticAmpereSymbol = '1/%sA⁴';
  rsReciprocalQuarticAmpereName = 'reciprocal quartic %sampere';
  rsReciprocalQuarticAmperePluralName = 'reciprocal quartic %sampere';

const
  ReciprocalQuarticAmpereID = -97200;
  ReciprocalQuarticAmpereUnit : TUnit = (
    FID         : ReciprocalQuarticAmpereID;
    FSymbol     : rsReciprocalQuarticAmpereSymbol;
    FName       : rsReciprocalQuarticAmpereName;
    FPluralName : rsReciprocalQuarticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-4));

{ TReciprocalQuinticAmpere }

resourcestring
  rsReciprocalQuinticAmpereSymbol = '1/%sA⁵';
  rsReciprocalQuinticAmpereName = 'reciprocal quintic %sampere';
  rsReciprocalQuinticAmperePluralName = 'reciprocal quintic %sampere';

const
  ReciprocalQuinticAmpereID = -121500;
  ReciprocalQuinticAmpereUnit : TUnit = (
    FID         : ReciprocalQuinticAmpereID;
    FSymbol     : rsReciprocalQuinticAmpereSymbol;
    FName       : rsReciprocalQuinticAmpereName;
    FPluralName : rsReciprocalQuinticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticAmpere }

resourcestring
  rsReciprocalSexticAmpereSymbol = '1/%sA⁶';
  rsReciprocalSexticAmpereName = 'reciprocal sextic %sampere';
  rsReciprocalSexticAmperePluralName = 'reciprocal sextic %sampere';

const
  ReciprocalSexticAmpereID = -145800;
  ReciprocalSexticAmpereUnit : TUnit = (
    FID         : ReciprocalSexticAmpereID;
    FSymbol     : rsReciprocalSexticAmpereSymbol;
    FName       : rsReciprocalSexticAmpereName;
    FPluralName : rsReciprocalSexticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-6));

{ TReciprocalQuarticRootKelvin }

resourcestring
  rsReciprocalQuarticRootKelvinSymbol = '1/∜%sK';
  rsReciprocalQuarticRootKelvinName = 'reciprocal quartic root %skelvin';
  rsReciprocalQuarticRootKelvinPluralName = 'reciprocal quartic root %skelvin';

const
  ReciprocalQuarticRootKelvinID = -4755;
  ReciprocalQuarticRootKelvinUnit : TUnit = (
    FID         : ReciprocalQuarticRootKelvinID;
    FSymbol     : rsReciprocalQuarticRootKelvinSymbol;
    FName       : rsReciprocalQuarticRootKelvinName;
    FPluralName : rsReciprocalQuarticRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicRootKelvin }

resourcestring
  rsReciprocalCubicRootKelvinSymbol = '1/∛%sK';
  rsReciprocalCubicRootKelvinName = 'reciprocal cubic root %skelvin';
  rsReciprocalCubicRootKelvinPluralName = 'reciprocal cubic root %skelvin';

const
  ReciprocalCubicRootKelvinID = -6340;
  ReciprocalCubicRootKelvinUnit : TUnit = (
    FID         : ReciprocalCubicRootKelvinID;
    FSymbol     : rsReciprocalCubicRootKelvinSymbol;
    FName       : rsReciprocalCubicRootKelvinName;
    FPluralName : rsReciprocalCubicRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootKelvin }

resourcestring
  rsReciprocalSquareRootKelvinSymbol = '1/√%sK';
  rsReciprocalSquareRootKelvinName = 'reciprocal square root %skelvin';
  rsReciprocalSquareRootKelvinPluralName = 'reciprocal square root %skelvin';

const
  ReciprocalSquareRootKelvinID = -9510;
  ReciprocalSquareRootKelvinUnit : TUnit = (
    FID         : ReciprocalSquareRootKelvinID;
    FSymbol     : rsReciprocalSquareRootKelvinSymbol;
    FName       : rsReciprocalSquareRootKelvinName;
    FPluralName : rsReciprocalSquareRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootCubicKelvin }

resourcestring
  rsReciprocalSquareRootCubicKelvinSymbol = '1/√%sK³';
  rsReciprocalSquareRootCubicKelvinName = 'reciprocal square root cubic %skelvin';
  rsReciprocalSquareRootCubicKelvinPluralName = 'reciprocal square root cubic %skelvin';

const
  ReciprocalSquareRootCubicKelvinID = -28530;
  ReciprocalSquareRootCubicKelvinUnit : TUnit = (
    FID         : ReciprocalSquareRootCubicKelvinID;
    FSymbol     : rsReciprocalSquareRootCubicKelvinSymbol;
    FName       : rsReciprocalSquareRootCubicKelvinName;
    FPluralName : rsReciprocalSquareRootCubicKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootQuinticKelvin }

resourcestring
  rsReciprocalSquareRootQuinticKelvinSymbol = '1/√%sK⁵';
  rsReciprocalSquareRootQuinticKelvinName = 'reciprocal square root quintic %skelvin';
  rsReciprocalSquareRootQuinticKelvinPluralName = 'reciprocal square root quintic %skelvin';

const
  ReciprocalSquareRootQuinticKelvinID = -47550;
  ReciprocalSquareRootQuinticKelvinUnit : TUnit = (
    FID         : ReciprocalSquareRootQuinticKelvinID;
    FSymbol     : rsReciprocalSquareRootQuinticKelvinSymbol;
    FName       : rsReciprocalSquareRootQuinticKelvinName;
    FPluralName : rsReciprocalSquareRootQuinticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalQuinticKelvin }

resourcestring
  rsReciprocalQuinticKelvinSymbol = '1/%sK⁵';
  rsReciprocalQuinticKelvinName = 'reciprocal quintic %skelvin';
  rsReciprocalQuinticKelvinPluralName = 'reciprocal quintic %skelvin';

const
  ReciprocalQuinticKelvinID = -95100;
  ReciprocalQuinticKelvinUnit : TUnit = (
    FID         : ReciprocalQuinticKelvinID;
    FSymbol     : rsReciprocalQuinticKelvinSymbol;
    FName       : rsReciprocalQuinticKelvinName;
    FPluralName : rsReciprocalQuinticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticKelvin }

resourcestring
  rsReciprocalSexticKelvinSymbol = '1/%sK⁶';
  rsReciprocalSexticKelvinName = 'reciprocal sextic %skelvin';
  rsReciprocalSexticKelvinPluralName = 'reciprocal sextic %skelvin';

const
  ReciprocalSexticKelvinID = -114120;
  ReciprocalSexticKelvinUnit : TUnit = (
    FID         : ReciprocalSexticKelvinID;
    FSymbol     : rsReciprocalSexticKelvinSymbol;
    FName       : rsReciprocalSexticKelvinName;
    FPluralName : rsReciprocalSexticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-6));

{ TReciprocalQuarticRootMole }

resourcestring
  rsReciprocalQuarticRootMoleSymbol = '1/∜%smol';
  rsReciprocalQuarticRootMoleName = 'reciprocal quartic root %smole';
  rsReciprocalQuarticRootMolePluralName = 'reciprocal quartic root %smole';

const
  ReciprocalQuarticRootMoleID = -8670;
  ReciprocalQuarticRootMoleUnit : TUnit = (
    FID         : ReciprocalQuarticRootMoleID;
    FSymbol     : rsReciprocalQuarticRootMoleSymbol;
    FName       : rsReciprocalQuarticRootMoleName;
    FPluralName : rsReciprocalQuarticRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicRootMole }

resourcestring
  rsReciprocalCubicRootMoleSymbol = '1/∛%smol';
  rsReciprocalCubicRootMoleName = 'reciprocal cubic root %smole';
  rsReciprocalCubicRootMolePluralName = 'reciprocal cubic root %smole';

const
  ReciprocalCubicRootMoleID = -11560;
  ReciprocalCubicRootMoleUnit : TUnit = (
    FID         : ReciprocalCubicRootMoleID;
    FSymbol     : rsReciprocalCubicRootMoleSymbol;
    FName       : rsReciprocalCubicRootMoleName;
    FPluralName : rsReciprocalCubicRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootMole }

resourcestring
  rsReciprocalSquareRootMoleSymbol = '1/√%smol';
  rsReciprocalSquareRootMoleName = 'reciprocal square root %smole';
  rsReciprocalSquareRootMolePluralName = 'reciprocal square root %smole';

const
  ReciprocalSquareRootMoleID = -17340;
  ReciprocalSquareRootMoleUnit : TUnit = (
    FID         : ReciprocalSquareRootMoleID;
    FSymbol     : rsReciprocalSquareRootMoleSymbol;
    FName       : rsReciprocalSquareRootMoleName;
    FPluralName : rsReciprocalSquareRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootCubicMole }

resourcestring
  rsReciprocalSquareRootCubicMoleSymbol = '1/√%smol³';
  rsReciprocalSquareRootCubicMoleName = 'reciprocal square root cubic %smole';
  rsReciprocalSquareRootCubicMolePluralName = 'reciprocal square root cubic %smole';

const
  ReciprocalSquareRootCubicMoleID = -52020;
  ReciprocalSquareRootCubicMoleUnit : TUnit = (
    FID         : ReciprocalSquareRootCubicMoleID;
    FSymbol     : rsReciprocalSquareRootCubicMoleSymbol;
    FName       : rsReciprocalSquareRootCubicMoleName;
    FPluralName : rsReciprocalSquareRootCubicMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareMole }

resourcestring
  rsReciprocalSquareMoleSymbol = '1/%smol²';
  rsReciprocalSquareMoleName = 'reciprocal square %smole';
  rsReciprocalSquareMolePluralName = 'reciprocal square %smole';

const
  ReciprocalSquareMoleID = -69360;
  ReciprocalSquareMoleUnit : TUnit = (
    FID         : ReciprocalSquareMoleID;
    FSymbol     : rsReciprocalSquareMoleSymbol;
    FName       : rsReciprocalSquareMoleName;
    FPluralName : rsReciprocalSquareMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TReciprocalSquareRootQuinticMole }

resourcestring
  rsReciprocalSquareRootQuinticMoleSymbol = '1/√%smol⁵';
  rsReciprocalSquareRootQuinticMoleName = 'reciprocal square root quintic %smole';
  rsReciprocalSquareRootQuinticMolePluralName = 'reciprocal square root quintic %smole';

const
  ReciprocalSquareRootQuinticMoleID = -86700;
  ReciprocalSquareRootQuinticMoleUnit : TUnit = (
    FID         : ReciprocalSquareRootQuinticMoleID;
    FSymbol     : rsReciprocalSquareRootQuinticMoleSymbol;
    FName       : rsReciprocalSquareRootQuinticMoleName;
    FPluralName : rsReciprocalSquareRootQuinticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalCubicMole }

resourcestring
  rsReciprocalCubicMoleSymbol = '1/%smol³';
  rsReciprocalCubicMoleName = 'reciprocal cubic %smole';
  rsReciprocalCubicMolePluralName = 'reciprocal cubic %smole';

const
  ReciprocalCubicMoleID = -104040;
  ReciprocalCubicMoleUnit : TUnit = (
    FID         : ReciprocalCubicMoleID;
    FSymbol     : rsReciprocalCubicMoleSymbol;
    FName       : rsReciprocalCubicMoleName;
    FPluralName : rsReciprocalCubicMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalQuarticMole }

resourcestring
  rsReciprocalQuarticMoleSymbol = '1/%smol⁴';
  rsReciprocalQuarticMoleName = 'reciprocal quartic %smole';
  rsReciprocalQuarticMolePluralName = 'reciprocal quartic %smole';

const
  ReciprocalQuarticMoleID = -138720;
  ReciprocalQuarticMoleUnit : TUnit = (
    FID         : ReciprocalQuarticMoleID;
    FSymbol     : rsReciprocalQuarticMoleSymbol;
    FName       : rsReciprocalQuarticMoleName;
    FPluralName : rsReciprocalQuarticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-4));

{ TReciprocalQuinticMole }

resourcestring
  rsReciprocalQuinticMoleSymbol = '1/%smol⁵';
  rsReciprocalQuinticMoleName = 'reciprocal quintic %smole';
  rsReciprocalQuinticMolePluralName = 'reciprocal quintic %smole';

const
  ReciprocalQuinticMoleID = -173400;
  ReciprocalQuinticMoleUnit : TUnit = (
    FID         : ReciprocalQuinticMoleID;
    FSymbol     : rsReciprocalQuinticMoleSymbol;
    FName       : rsReciprocalQuinticMoleName;
    FPluralName : rsReciprocalQuinticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticMole }

resourcestring
  rsReciprocalSexticMoleSymbol = '1/%smol⁶';
  rsReciprocalSexticMoleName = 'reciprocal sextic %smole';
  rsReciprocalSexticMolePluralName = 'reciprocal sextic %smole';

const
  ReciprocalSexticMoleID = -208080;
  ReciprocalSexticMoleUnit : TUnit = (
    FID         : ReciprocalSexticMoleID;
    FSymbol     : rsReciprocalSexticMoleSymbol;
    FName       : rsReciprocalSexticMoleName;
    FPluralName : rsReciprocalSexticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-6));

{ TReciprocalQuarticRootCandela }

resourcestring
  rsReciprocalQuarticRootCandelaSymbol = '1/∜%scd';
  rsReciprocalQuarticRootCandelaName = 'reciprocal quartic root %scandela';
  rsReciprocalQuarticRootCandelaPluralName = 'reciprocal quartic root %scandela';

const
  ReciprocalQuarticRootCandelaID = -9990;
  ReciprocalQuarticRootCandelaUnit : TUnit = (
    FID         : ReciprocalQuarticRootCandelaID;
    FSymbol     : rsReciprocalQuarticRootCandelaSymbol;
    FName       : rsReciprocalQuarticRootCandelaName;
    FPluralName : rsReciprocalQuarticRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicRootCandela }

resourcestring
  rsReciprocalCubicRootCandelaSymbol = '1/∛%scd';
  rsReciprocalCubicRootCandelaName = 'reciprocal cubic root %scandela';
  rsReciprocalCubicRootCandelaPluralName = 'reciprocal cubic root %scandela';

const
  ReciprocalCubicRootCandelaID = -13320;
  ReciprocalCubicRootCandelaUnit : TUnit = (
    FID         : ReciprocalCubicRootCandelaID;
    FSymbol     : rsReciprocalCubicRootCandelaSymbol;
    FName       : rsReciprocalCubicRootCandelaName;
    FPluralName : rsReciprocalCubicRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootCandela }

resourcestring
  rsReciprocalSquareRootCandelaSymbol = '1/√%scd';
  rsReciprocalSquareRootCandelaName = 'reciprocal square root %scandela';
  rsReciprocalSquareRootCandelaPluralName = 'reciprocal square root %scandela';

const
  ReciprocalSquareRootCandelaID = -19980;
  ReciprocalSquareRootCandelaUnit : TUnit = (
    FID         : ReciprocalSquareRootCandelaID;
    FSymbol     : rsReciprocalSquareRootCandelaSymbol;
    FName       : rsReciprocalSquareRootCandelaName;
    FPluralName : rsReciprocalSquareRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootCubicCandela }

resourcestring
  rsReciprocalSquareRootCubicCandelaSymbol = '1/√%scd³';
  rsReciprocalSquareRootCubicCandelaName = 'reciprocal square root cubic %scandela';
  rsReciprocalSquareRootCubicCandelaPluralName = 'reciprocal square root cubic %scandela';

const
  ReciprocalSquareRootCubicCandelaID = -59940;
  ReciprocalSquareRootCubicCandelaUnit : TUnit = (
    FID         : ReciprocalSquareRootCubicCandelaID;
    FSymbol     : rsReciprocalSquareRootCubicCandelaSymbol;
    FName       : rsReciprocalSquareRootCubicCandelaName;
    FPluralName : rsReciprocalSquareRootCubicCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareCandela }

resourcestring
  rsReciprocalSquareCandelaSymbol = '1/%scd²';
  rsReciprocalSquareCandelaName = 'reciprocal square %scandela';
  rsReciprocalSquareCandelaPluralName = 'reciprocal square %scandela';

const
  ReciprocalSquareCandelaID = -79920;
  ReciprocalSquareCandelaUnit : TUnit = (
    FID         : ReciprocalSquareCandelaID;
    FSymbol     : rsReciprocalSquareCandelaSymbol;
    FName       : rsReciprocalSquareCandelaName;
    FPluralName : rsReciprocalSquareCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TReciprocalSquareRootQuinticCandela }

resourcestring
  rsReciprocalSquareRootQuinticCandelaSymbol = '1/√%scd⁵';
  rsReciprocalSquareRootQuinticCandelaName = 'reciprocal square root quintic %scandela';
  rsReciprocalSquareRootQuinticCandelaPluralName = 'reciprocal square root quintic %scandela';

const
  ReciprocalSquareRootQuinticCandelaID = -99900;
  ReciprocalSquareRootQuinticCandelaUnit : TUnit = (
    FID         : ReciprocalSquareRootQuinticCandelaID;
    FSymbol     : rsReciprocalSquareRootQuinticCandelaSymbol;
    FName       : rsReciprocalSquareRootQuinticCandelaName;
    FPluralName : rsReciprocalSquareRootQuinticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalCubicCandela }

resourcestring
  rsReciprocalCubicCandelaSymbol = '1/%scd³';
  rsReciprocalCubicCandelaName = 'reciprocal cubic %scandela';
  rsReciprocalCubicCandelaPluralName = 'reciprocal cubic %scandela';

const
  ReciprocalCubicCandelaID = -119880;
  ReciprocalCubicCandelaUnit : TUnit = (
    FID         : ReciprocalCubicCandelaID;
    FSymbol     : rsReciprocalCubicCandelaSymbol;
    FName       : rsReciprocalCubicCandelaName;
    FPluralName : rsReciprocalCubicCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalQuarticCandela }

resourcestring
  rsReciprocalQuarticCandelaSymbol = '1/%scd⁴';
  rsReciprocalQuarticCandelaName = 'reciprocal quartic %scandela';
  rsReciprocalQuarticCandelaPluralName = 'reciprocal quartic %scandela';

const
  ReciprocalQuarticCandelaID = -159840;
  ReciprocalQuarticCandelaUnit : TUnit = (
    FID         : ReciprocalQuarticCandelaID;
    FSymbol     : rsReciprocalQuarticCandelaSymbol;
    FName       : rsReciprocalQuarticCandelaName;
    FPluralName : rsReciprocalQuarticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-4));

{ TReciprocalQuinticCandela }

resourcestring
  rsReciprocalQuinticCandelaSymbol = '1/%scd⁵';
  rsReciprocalQuinticCandelaName = 'reciprocal quintic %scandela';
  rsReciprocalQuinticCandelaPluralName = 'reciprocal quintic %scandela';

const
  ReciprocalQuinticCandelaID = -199800;
  ReciprocalQuinticCandelaUnit : TUnit = (
    FID         : ReciprocalQuinticCandelaID;
    FSymbol     : rsReciprocalQuinticCandelaSymbol;
    FName       : rsReciprocalQuinticCandelaName;
    FPluralName : rsReciprocalQuinticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticCandela }

resourcestring
  rsReciprocalSexticCandelaSymbol = '1/%scd⁶';
  rsReciprocalSexticCandelaName = 'reciprocal sextic %scandela';
  rsReciprocalSexticCandelaPluralName = 'reciprocal sextic %scandela';

const
  ReciprocalSexticCandelaID = -239760;
  ReciprocalSexticCandelaUnit : TUnit = (
    FID         : ReciprocalSexticCandelaID;
    FSymbol     : rsReciprocalSexticCandelaSymbol;
    FName       : rsReciprocalSexticCandelaName;
    FPluralName : rsReciprocalSexticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-6));

{ TReciprocalQuarticRootSteradian }

resourcestring
  rsReciprocalQuarticRootSteradianSymbol = '1/∜sr';
  rsReciprocalQuarticRootSteradianName = 'reciprocal quartic root steradian';
  rsReciprocalQuarticRootSteradianPluralName = 'reciprocal quartic root steradian';

const
  ReciprocalQuarticRootSteradianID = -9465;
  ReciprocalQuarticRootSteradianUnit : TUnit = (
    FID         : ReciprocalQuarticRootSteradianID;
    FSymbol     : rsReciprocalQuarticRootSteradianSymbol;
    FName       : rsReciprocalQuarticRootSteradianName;
    FPluralName : rsReciprocalQuarticRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalCubicRootSteradian }

resourcestring
  rsReciprocalCubicRootSteradianSymbol = '1/∛sr';
  rsReciprocalCubicRootSteradianName = 'reciprocal cubic root steradian';
  rsReciprocalCubicRootSteradianPluralName = 'reciprocal cubic root steradian';

const
  ReciprocalCubicRootSteradianID = -12620;
  ReciprocalCubicRootSteradianUnit : TUnit = (
    FID         : ReciprocalCubicRootSteradianID;
    FSymbol     : rsReciprocalCubicRootSteradianSymbol;
    FName       : rsReciprocalCubicRootSteradianName;
    FPluralName : rsReciprocalCubicRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalSquareRootSteradian }

resourcestring
  rsReciprocalSquareRootSteradianSymbol = '1/√sr';
  rsReciprocalSquareRootSteradianName = 'reciprocal square root steradian';
  rsReciprocalSquareRootSteradianPluralName = 'reciprocal square root steradian';

const
  ReciprocalSquareRootSteradianID = -18930;
  ReciprocalSquareRootSteradianUnit : TUnit = (
    FID         : ReciprocalSquareRootSteradianID;
    FSymbol     : rsReciprocalSquareRootSteradianSymbol;
    FName       : rsReciprocalSquareRootSteradianName;
    FPluralName : rsReciprocalSquareRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalSquareRootCubicSteradian }

resourcestring
  rsReciprocalSquareRootCubicSteradianSymbol = '1/√sr³';
  rsReciprocalSquareRootCubicSteradianName = 'reciprocal square root cubic steradian';
  rsReciprocalSquareRootCubicSteradianPluralName = 'reciprocal square root cubic steradian';

const
  ReciprocalSquareRootCubicSteradianID = -56790;
  ReciprocalSquareRootCubicSteradianUnit : TUnit = (
    FID         : ReciprocalSquareRootCubicSteradianID;
    FSymbol     : rsReciprocalSquareRootCubicSteradianSymbol;
    FName       : rsReciprocalSquareRootCubicSteradianName;
    FPluralName : rsReciprocalSquareRootCubicSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalSquareSteradian }

resourcestring
  rsReciprocalSquareSteradianSymbol = '1/sr²';
  rsReciprocalSquareSteradianName = 'reciprocal square steradian';
  rsReciprocalSquareSteradianPluralName = 'reciprocal square steradian';

const
  ReciprocalSquareSteradianID = -75720;
  ReciprocalSquareSteradianUnit : TUnit = (
    FID         : ReciprocalSquareSteradianID;
    FSymbol     : rsReciprocalSquareSteradianSymbol;
    FName       : rsReciprocalSquareSteradianName;
    FPluralName : rsReciprocalSquareSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalSquareRootQuinticSteradian }

resourcestring
  rsReciprocalSquareRootQuinticSteradianSymbol = '1/√sr⁵';
  rsReciprocalSquareRootQuinticSteradianName = 'reciprocal square root quintic steradian';
  rsReciprocalSquareRootQuinticSteradianPluralName = 'reciprocal square root quintic steradian';

const
  ReciprocalSquareRootQuinticSteradianID = -94650;
  ReciprocalSquareRootQuinticSteradianUnit : TUnit = (
    FID         : ReciprocalSquareRootQuinticSteradianID;
    FSymbol     : rsReciprocalSquareRootQuinticSteradianSymbol;
    FName       : rsReciprocalSquareRootQuinticSteradianName;
    FPluralName : rsReciprocalSquareRootQuinticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalCubicSteradian }

resourcestring
  rsReciprocalCubicSteradianSymbol = '1/sr³';
  rsReciprocalCubicSteradianName = 'reciprocal cubic steradian';
  rsReciprocalCubicSteradianPluralName = 'reciprocal cubic steradian';

const
  ReciprocalCubicSteradianID = -113580;
  ReciprocalCubicSteradianUnit : TUnit = (
    FID         : ReciprocalCubicSteradianID;
    FSymbol     : rsReciprocalCubicSteradianSymbol;
    FName       : rsReciprocalCubicSteradianName;
    FPluralName : rsReciprocalCubicSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalQuarticSteradian }

resourcestring
  rsReciprocalQuarticSteradianSymbol = '1/sr⁴';
  rsReciprocalQuarticSteradianName = 'reciprocal quartic steradian';
  rsReciprocalQuarticSteradianPluralName = 'reciprocal quartic steradian';

const
  ReciprocalQuarticSteradianID = -151440;
  ReciprocalQuarticSteradianUnit : TUnit = (
    FID         : ReciprocalQuarticSteradianID;
    FSymbol     : rsReciprocalQuarticSteradianSymbol;
    FName       : rsReciprocalQuarticSteradianName;
    FPluralName : rsReciprocalQuarticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalQuinticSteradian }

resourcestring
  rsReciprocalQuinticSteradianSymbol = '1/sr⁵';
  rsReciprocalQuinticSteradianName = 'reciprocal quintic steradian';
  rsReciprocalQuinticSteradianPluralName = 'reciprocal quintic steradian';

const
  ReciprocalQuinticSteradianID = -189300;
  ReciprocalQuinticSteradianUnit : TUnit = (
    FID         : ReciprocalQuinticSteradianID;
    FSymbol     : rsReciprocalQuinticSteradianSymbol;
    FName       : rsReciprocalQuinticSteradianName;
    FPluralName : rsReciprocalQuinticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalSexticSteradian }

resourcestring
  rsReciprocalSexticSteradianSymbol = '1/sr⁶';
  rsReciprocalSexticSteradianName = 'reciprocal sextic steradian';
  rsReciprocalSexticSteradianPluralName = 'reciprocal sextic steradian';

const
  ReciprocalSexticSteradianID = -227160;
  ReciprocalSexticSteradianUnit : TUnit = (
    FID         : ReciprocalSexticSteradianID;
    FSymbol     : rsReciprocalSexticSteradianSymbol;
    FName       : rsReciprocalSexticSteradianName;
    FPluralName : rsReciprocalSexticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalSquareKilogramSquareMeter }

resourcestring
  rsReciprocalSquareKilogramSquareMeterSymbol = '1/%skg²/%sm²';
  rsReciprocalSquareKilogramSquareMeterName = 'reciprocal square %skilogram square %smeter';
  rsReciprocalSquareKilogramSquareMeterPluralName = 'reciprocal square %skilogram square %smeter';

const
  ReciprocalSquareKilogramSquareMeterID = -97680;
  ReciprocalSquareKilogramSquareMeterUnit : TUnit = (
    FID         : ReciprocalSquareKilogramSquareMeterID;
    FSymbol     : rsReciprocalSquareKilogramSquareMeterSymbol;
    FName       : rsReciprocalSquareKilogramSquareMeterName;
    FPluralName : rsReciprocalSquareKilogramSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -2));

{ TQuarticSecondPerSquareKilogram }

resourcestring
  rsQuarticSecondPerSquareKilogramSymbol = '%ss⁴/%skg²';
  rsQuarticSecondPerSquareKilogramName = 'quartic %ssecond per square %skilogram';
  rsQuarticSecondPerSquareKilogramPluralName = 'quartic %sseconds per square %skilogram';

const
  QuarticSecondPerSquareKilogramID = 121320;
  QuarticSecondPerSquareKilogramUnit : TUnit = (
    FID         : QuarticSecondPerSquareKilogramID;
    FSymbol     : rsQuarticSecondPerSquareKilogramSymbol;
    FName       : rsQuarticSecondPerSquareKilogramName;
    FPluralName : rsQuarticSecondPerSquareKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -2));

{ TReciprocalMeterAmpere }

resourcestring
  rsReciprocalMeterAmpereSymbol = '1/%sm/%sA';
  rsReciprocalMeterAmpereName = 'reciprocal %smeter %sampere';
  rsReciprocalMeterAmperePluralName = 'reciprocal %smeter %sampere';

const
  ReciprocalMeterAmpereID = -64080;
  ReciprocalMeterAmpereUnit : TUnit = (
    FID         : ReciprocalMeterAmpereID;
    FSymbol     : rsReciprocalMeterAmpereSymbol;
    FName       : rsReciprocalMeterAmpereName;
    FPluralName : rsReciprocalMeterAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TCubicSecondAmperePerSquareMeter }

resourcestring
  rsCubicSecondAmperePerSquareMeterSymbol = '%ss³∙%sA/%sm²';
  rsCubicSecondAmperePerSquareMeterName = 'cubic %ssecond %sampere per square %smeter';
  rsCubicSecondAmperePerSquareMeterPluralName = 'cubic %sseconds %samperes per square %smeter';

const
  CubicSecondAmperePerSquareMeterID = 49320;
  CubicSecondAmperePerSquareMeterUnit : TUnit = (
    FID         : CubicSecondAmperePerSquareMeterID;
    FSymbol     : rsCubicSecondAmperePerSquareMeterSymbol;
    FName       : rsCubicSecondAmperePerSquareMeterName;
    FPluralName : rsCubicSecondAmperePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -2));

{ TSexticSecondSquareAmperePerQuarticMeter }

resourcestring
  rsSexticSecondSquareAmperePerQuarticMeterSymbol = '%ss⁶∙%sA²/%sm⁴';
  rsSexticSecondSquareAmperePerQuarticMeterName = 'sextic %ssecond square %sampere per quartic %smeter';
  rsSexticSecondSquareAmperePerQuarticMeterPluralName = 'sextic %sseconds square %samperes per quartic %smeter';

const
  SexticSecondSquareAmperePerQuarticMeterID = 98640;
  SexticSecondSquareAmperePerQuarticMeterUnit : TUnit = (
    FID         : SexticSecondSquareAmperePerQuarticMeterID;
    FSymbol     : rsSexticSecondSquareAmperePerQuarticMeterSymbol;
    FName       : rsSexticSecondSquareAmperePerQuarticMeterName;
    FPluralName : rsSexticSecondSquareAmperePerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (6, 2, -4));

{ TSexticSecondSquareAmperePerSquareKilogram }

resourcestring
  rsSexticSecondSquareAmperePerSquareKilogramSymbol = '%ss⁶∙%sA²/%skg²';
  rsSexticSecondSquareAmperePerSquareKilogramName = 'sextic %ssecond square %sampere per square %skilogram';
  rsSexticSecondSquareAmperePerSquareKilogramPluralName = 'sextic %sseconds square %samperes per square %skilogram';

const
  SexticSecondSquareAmperePerSquareKilogramID = 239640;
  SexticSecondSquareAmperePerSquareKilogramUnit : TUnit = (
    FID         : SexticSecondSquareAmperePerSquareKilogramID;
    FSymbol     : rsSexticSecondSquareAmperePerSquareKilogramSymbol;
    FName       : rsSexticSecondSquareAmperePerSquareKilogramName;
    FPluralName : rsSexticSecondSquareAmperePerSquareKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (6, 2, -2));

{ TSquareAmperePerSquareKilogramPerQuarticMeter }

resourcestring
  rsSquareAmperePerSquareKilogramPerQuarticMeterSymbol = '%sA²/%skg²/%sm⁴';
  rsSquareAmperePerSquareKilogramPerQuarticMeterName = 'square %sampere per square %skilogram per quartic %smeter';
  rsSquareAmperePerSquareKilogramPerQuarticMeterPluralName = 'square %samperes per square %skilogram per quartic %smeter';

const
  SquareAmperePerSquareKilogramPerQuarticMeterID = -128640;
  SquareAmperePerSquareKilogramPerQuarticMeterUnit : TUnit = (
    FID         : SquareAmperePerSquareKilogramPerQuarticMeterID;
    FSymbol     : rsSquareAmperePerSquareKilogramPerQuarticMeterSymbol;
    FName       : rsSquareAmperePerSquareKilogramPerQuarticMeterName;
    FPluralName : rsSquareAmperePerSquareKilogramPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -2, -4));

{ TSexticSecondPerSquareKilogramPerQuarticMeter }

resourcestring
  rsSexticSecondPerSquareKilogramPerQuarticMeterSymbol = '%ss⁶/%skg²/%sm⁴';
  rsSexticSecondPerSquareKilogramPerQuarticMeterName = 'sextic %ssecond per square %skilogram per quartic %smeter';
  rsSexticSecondPerSquareKilogramPerQuarticMeterPluralName = 'sextic %sseconds per square %skilogram per quartic %smeter';

const
  SexticSecondPerSquareKilogramPerQuarticMeterID = 31920;
  SexticSecondPerSquareKilogramPerQuarticMeterUnit : TUnit = (
    FID         : SexticSecondPerSquareKilogramPerQuarticMeterID;
    FSymbol     : rsSexticSecondPerSquareKilogramPerQuarticMeterSymbol;
    FName       : rsSexticSecondPerSquareKilogramPerQuarticMeterName;
    FPluralName : rsSexticSecondPerSquareKilogramPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (6, -2, -4));

{ TSquareMeterPerQuarticSecondPerSquareAmpere }

resourcestring
  rsSquareMeterPerQuarticSecondPerSquareAmpereSymbol = '%sm²/%ss⁴/%sA²';
  rsSquareMeterPerQuarticSecondPerSquareAmpereName = 'square %smeter per quartic %ssecond per square %sampere';
  rsSquareMeterPerQuarticSecondPerSquareAmperePluralName = 'square %smeters per quartic %ssecond per square %sampere';

const
  SquareMeterPerQuarticSecondPerSquareAmpereID = -108480;
  SquareMeterPerQuarticSecondPerSquareAmpereUnit : TUnit = (
    FID         : SquareMeterPerQuarticSecondPerSquareAmpereID;
    FSymbol     : rsSquareMeterPerQuarticSecondPerSquareAmpereSymbol;
    FName       : rsSquareMeterPerQuarticSecondPerSquareAmpereName;
    FPluralName : rsSquareMeterPerQuarticSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -4, -2));

{ TKilogramSquareMeterPerQuarticSecond }

resourcestring
  rsKilogramSquareMeterPerQuarticSecondSymbol = '%skg∙%sm²/%ss⁴';
  rsKilogramSquareMeterPerQuarticSecondName = '%skilogram square %smeter per quartic %ssecond';
  rsKilogramSquareMeterPerQuarticSecondPluralName = '%skilograms square %smeters per quartic %ssecond';

const
  KilogramSquareMeterPerQuarticSecondID = -50820;
  KilogramSquareMeterPerQuarticSecondUnit : TUnit = (
    FID         : KilogramSquareMeterPerQuarticSecondID;
    FSymbol     : rsKilogramSquareMeterPerQuarticSecondSymbol;
    FName       : rsKilogramSquareMeterPerQuarticSecondName;
    FPluralName : rsKilogramSquareMeterPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -4));

{ TReciprocalSecondSteradian }

resourcestring
  rsReciprocalSecondSteradianSymbol = '1/%ss/sr';
  rsReciprocalSecondSteradianName = 'reciprocal %ssecond steradian';
  rsReciprocalSecondSteradianPluralName = 'reciprocal %ssecond steradian';

const
  ReciprocalSecondSteradianID = -72720;
  ReciprocalSecondSteradianUnit : TUnit = (
    FID         : ReciprocalSecondSteradianID;
    FSymbol     : rsReciprocalSecondSteradianSymbol;
    FName       : rsReciprocalSecondSteradianName;
    FPluralName : rsReciprocalSecondSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSecondCandela }

resourcestring
  rsReciprocalSecondCandelaSymbol = '1/%ss/%scd';
  rsReciprocalSecondCandelaName = 'reciprocal %ssecond %scandela';
  rsReciprocalSecondCandelaPluralName = 'reciprocal %ssecond %scandela';

const
  ReciprocalSecondCandelaID = -74820;
  ReciprocalSecondCandelaUnit : TUnit = (
    FID         : ReciprocalSecondCandelaID;
    FSymbol     : rsReciprocalSecondCandelaSymbol;
    FName       : rsReciprocalSecondCandelaName;
    FPluralName : rsReciprocalSecondCandelaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TCubicMeterPerCandelaPerSteradian }

resourcestring
  rsCubicMeterPerCandelaPerSteradianSymbol = '%sm³/%scd/sr';
  rsCubicMeterPerCandelaPerSteradianName = 'cubic %smeter per %scandela per steradian';
  rsCubicMeterPerCandelaPerSteradianPluralName = 'cubic %smeters per %scandela per steradian';

const
  CubicMeterPerCandelaPerSteradianID = 41520;
  CubicMeterPerCandelaPerSteradianUnit : TUnit = (
    FID         : CubicMeterPerCandelaPerSteradianID;
    FSymbol     : rsCubicMeterPerCandelaPerSteradianSymbol;
    FName       : rsCubicMeterPerCandelaPerSteradianName;
    FPluralName : rsCubicMeterPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TCubicMeterPerSecondPerSteradian }

resourcestring
  rsCubicMeterPerSecondPerSteradianSymbol = '%sm³/%ss/sr';
  rsCubicMeterPerSecondPerSteradianName = 'cubic %smeter per %ssecond per steradian';
  rsCubicMeterPerSecondPerSteradianPluralName = 'cubic %smeters per %ssecond per steradian';

const
  CubicMeterPerSecondPerSteradianID = 46620;
  CubicMeterPerSecondPerSteradianUnit : TUnit = (
    FID         : CubicMeterPerSecondPerSteradianID;
    FSymbol     : rsCubicMeterPerSecondPerSteradianSymbol;
    FName       : rsCubicMeterPerSecondPerSteradianName;
    FPluralName : rsCubicMeterPerSecondPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TCubicMeterPerSecondPerCandela }

resourcestring
  rsCubicMeterPerSecondPerCandelaSymbol = '%sm³/%ss/%scd';
  rsCubicMeterPerSecondPerCandelaName = 'cubic %smeter per %ssecond per %scandela';
  rsCubicMeterPerSecondPerCandelaPluralName = 'cubic %smeters per %ssecond per %scandela';

const
  CubicMeterPerSecondPerCandelaID = 44520;
  CubicMeterPerSecondPerCandelaUnit : TUnit = (
    FID         : CubicMeterPerSecondPerCandelaID;
    FSymbol     : rsCubicMeterPerSecondPerCandelaSymbol;
    FName       : rsCubicMeterPerSecondPerCandelaName;
    FPluralName : rsCubicMeterPerSecondPerCandelaPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -1, -1));

{ TSquareMeterPerSecondPerSteradian }

resourcestring
  rsSquareMeterPerSecondPerSteradianSymbol = '%sm²/%ss/sr';
  rsSquareMeterPerSecondPerSteradianName = 'square %smeter per %ssecond per steradian';
  rsSquareMeterPerSecondPerSteradianPluralName = 'square %smeters per %ssecond per steradian';

const
  SquareMeterPerSecondPerSteradianID = 6840;
  SquareMeterPerSecondPerSteradianUnit : TUnit = (
    FID         : SquareMeterPerSecondPerSteradianID;
    FSymbol     : rsSquareMeterPerSecondPerSteradianSymbol;
    FName       : rsSquareMeterPerSecondPerSteradianName;
    FPluralName : rsSquareMeterPerSecondPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TSquareMeterPerSecondPerCandela }

resourcestring
  rsSquareMeterPerSecondPerCandelaSymbol = '%sm²/%ss/%scd';
  rsSquareMeterPerSecondPerCandelaName = 'square %smeter per %ssecond per %scandela';
  rsSquareMeterPerSecondPerCandelaPluralName = 'square %smeters per %ssecond per %scandela';

const
  SquareMeterPerSecondPerCandelaID = 4740;
  SquareMeterPerSecondPerCandelaUnit : TUnit = (
    FID         : SquareMeterPerSecondPerCandelaID;
    FSymbol     : rsSquareMeterPerSecondPerCandelaSymbol;
    FName       : rsSquareMeterPerSecondPerCandelaName;
    FPluralName : rsSquareMeterPerSecondPerCandelaPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -1));

{ TSquareMeterSquareSecond }

resourcestring
  rsSquareMeterSquareSecondSymbol = '%sm²∙%ss²';
  rsSquareMeterSquareSecondName = 'square %smeter square %ssecond';
  rsSquareMeterSquareSecondPluralName = 'square %smeters square %sseconds';

const
  SquareMeterSquareSecondID = 149280;
  SquareMeterSquareSecondUnit : TUnit = (
    FID         : SquareMeterSquareSecondID;
    FSymbol     : rsSquareMeterSquareSecondSymbol;
    FName       : rsSquareMeterSquareSecondName;
    FPluralName : rsSquareMeterSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 2));

{ TSquareSecondPerQuarticMeter }

resourcestring
  rsSquareSecondPerQuarticMeterSymbol = '%ss²/%sm⁴';
  rsSquareSecondPerQuarticMeterName = 'square %ssecond per quartic %smeter';
  rsSquareSecondPerQuarticMeterPluralName = 'square %sseconds per quartic %smeter';

const
  SquareSecondPerQuarticMeterID = -89400;
  SquareSecondPerQuarticMeterUnit : TUnit = (
    FID         : SquareSecondPerQuarticMeterID;
    FSymbol     : rsSquareSecondPerQuarticMeterSymbol;
    FName       : rsSquareSecondPerQuarticMeterName;
    FPluralName : rsSquareSecondPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -4));

{ TReciprocalKilogramQuarticMeter }

resourcestring
  rsReciprocalKilogramQuarticMeterSymbol = '1/%skg/%sm⁴';
  rsReciprocalKilogramQuarticMeterName = 'reciprocal %skilogram quartic %smeter';
  rsReciprocalKilogramQuarticMeterPluralName = 'reciprocal %skilogram quartic %smeter';

const
  ReciprocalKilogramQuarticMeterID = -168180;
  ReciprocalKilogramQuarticMeterUnit : TUnit = (
    FID         : ReciprocalKilogramQuarticMeterID;
    FSymbol     : rsReciprocalKilogramQuarticMeterSymbol;
    FName       : rsReciprocalKilogramQuarticMeterName;
    FPluralName : rsReciprocalKilogramQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -4));

{ TSquareSecondKelvinPerKilogram }

resourcestring
  rsSquareSecondKelvinPerKilogramSymbol = '%ss²∙%sK/%skg';
  rsSquareSecondKelvinPerKilogramName = 'square %ssecond %skelvin per %skilogram';
  rsSquareSecondKelvinPerKilogramPluralName = 'square %sseconds %skelvins per %skilogram';

const
  SquareSecondKelvinPerKilogramID = 79680;
  SquareSecondKelvinPerKilogramUnit : TUnit = (
    FID         : SquareSecondKelvinPerKilogramID;
    FSymbol     : rsSquareSecondKelvinPerKilogramSymbol;
    FName       : rsSquareSecondKelvinPerKilogramName;
    FPluralName : rsSquareSecondKelvinPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 1, -1));

{ TSquareSecondKelvin }

resourcestring
  rsSquareSecondKelvinSymbol = '%ss²∙%sK';
  rsSquareSecondKelvinName = 'square %ssecond %skelvin';
  rsSquareSecondKelvinPluralName = 'square %sseconds %skelvins';

const
  SquareSecondKelvinID = 88740;
  SquareSecondKelvinUnit : TUnit = (
    FID         : SquareSecondKelvinID;
    FSymbol     : rsSquareSecondKelvinSymbol;
    FName       : rsSquareSecondKelvinName;
    FPluralName : rsSquareSecondKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 1));

{ TMeterCubicSecond }

resourcestring
  rsMeterCubicSecondSymbol = '%sm∙%ss³';
  rsMeterCubicSecondName = '%smeter cubic %ssecond';
  rsMeterCubicSecondPluralName = '%smeters cubic %sseconds';

const
  MeterCubicSecondID = 144360;
  MeterCubicSecondUnit : TUnit = (
    FID         : MeterCubicSecondID;
    FSymbol     : rsMeterCubicSecondSymbol;
    FName       : rsMeterCubicSecondName;
    FPluralName : rsMeterCubicSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 3));

{ TCubicSecondQuarticKelvinPerSquareMeter }

resourcestring
  rsCubicSecondQuarticKelvinPerSquareMeterSymbol = '%ss³∙%sK⁴/%sm²';
  rsCubicSecondQuarticKelvinPerSquareMeterName = 'cubic %ssecond quartic %skelvin per square %smeter';
  rsCubicSecondQuarticKelvinPerSquareMeterPluralName = 'cubic %sseconds quartic %skelvins per square %smeter';

const
  CubicSecondQuarticKelvinPerSquareMeterID = 101100;
  CubicSecondQuarticKelvinPerSquareMeterUnit : TUnit = (
    FID         : CubicSecondQuarticKelvinPerSquareMeterID;
    FSymbol     : rsCubicSecondQuarticKelvinPerSquareMeterSymbol;
    FName       : rsCubicSecondQuarticKelvinPerSquareMeterName;
    FPluralName : rsCubicSecondQuarticKelvinPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 4, -2));

{ TQuarticKelvinPerKilogramPerSquareMeter }

resourcestring
  rsQuarticKelvinPerKilogramPerSquareMeterSymbol = '%sK⁴/%skg/%sm²';
  rsQuarticKelvinPerKilogramPerSquareMeterName = 'quartic %skelvin per %skilogram per square %smeter';
  rsQuarticKelvinPerKilogramPerSquareMeterPluralName = 'quartic %skelvins per %skilogram per square %smeter';

const
  QuarticKelvinPerKilogramPerSquareMeterID = -12540;
  QuarticKelvinPerKilogramPerSquareMeterUnit : TUnit = (
    FID         : QuarticKelvinPerKilogramPerSquareMeterID;
    FSymbol     : rsQuarticKelvinPerKilogramPerSquareMeterSymbol;
    FName       : rsQuarticKelvinPerKilogramPerSquareMeterName;
    FPluralName : rsQuarticKelvinPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, -1, -2));

{ TCubicSecondQuarticKelvin }

resourcestring
  rsCubicSecondQuarticKelvinSymbol = '%ss³∙%sK⁴';
  rsCubicSecondQuarticKelvinName = 'cubic %ssecond quartic %skelvin';
  rsCubicSecondQuarticKelvinPluralName = 'cubic %sseconds quartic %skelvins';

const
  CubicSecondQuarticKelvinID = 180660;
  CubicSecondQuarticKelvinUnit : TUnit = (
    FID         : CubicSecondQuarticKelvinID;
    FSymbol     : rsCubicSecondQuarticKelvinSymbol;
    FName       : rsCubicSecondQuarticKelvinName;
    FPluralName : rsCubicSecondQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, 4));

{ TQuarticKelvinPerKilogram }

resourcestring
  rsQuarticKelvinPerKilogramSymbol = '%sK⁴/%skg';
  rsQuarticKelvinPerKilogramName = 'quartic %skelvin per %skilogram';
  rsQuarticKelvinPerKilogramPluralName = 'quartic %skelvins per %skilogram';

const
  QuarticKelvinPerKilogramID = 67020;
  QuarticKelvinPerKilogramUnit : TUnit = (
    FID         : QuarticKelvinPerKilogramID;
    FSymbol     : rsQuarticKelvinPerKilogramSymbol;
    FName       : rsQuarticKelvinPerKilogramName;
    FPluralName : rsQuarticKelvinPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -1));

{ TSquareSecondMolePerSquareMeter }

resourcestring
  rsSquareSecondMolePerSquareMeterSymbol = '%ss²∙%smol/%sm²';
  rsSquareSecondMolePerSquareMeterName = 'square %ssecond %smole per square %smeter';
  rsSquareSecondMolePerSquareMeterPluralName = 'square %sseconds %smoles per square %smeter';

const
  SquareSecondMolePerSquareMeterID = 24840;
  SquareSecondMolePerSquareMeterUnit : TUnit = (
    FID         : SquareSecondMolePerSquareMeterID;
    FSymbol     : rsSquareSecondMolePerSquareMeterSymbol;
    FName       : rsSquareSecondMolePerSquareMeterName;
    FPluralName : rsSquareSecondMolePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 1, -2));

{ TSquareSecondMolePerKilogram }

resourcestring
  rsSquareSecondMolePerKilogramSymbol = '%ss²∙%smol/%skg';
  rsSquareSecondMolePerKilogramName = 'square %ssecond %smole per %skilogram';
  rsSquareSecondMolePerKilogramPluralName = 'square %sseconds %smoles per %skilogram';

const
  SquareSecondMolePerKilogramID = 95340;
  SquareSecondMolePerKilogramUnit : TUnit = (
    FID         : SquareSecondMolePerKilogramID;
    FSymbol     : rsSquareSecondMolePerKilogramSymbol;
    FName       : rsSquareSecondMolePerKilogramName;
    FPluralName : rsSquareSecondMolePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 1, -1));

{ TMolePerKilogramPerSquareMeter }

resourcestring
  rsMolePerKilogramPerSquareMeterSymbol = '%smol/%skg/%sm²';
  rsMolePerKilogramPerSquareMeterName = '%smole per %skilogram per square %smeter';
  rsMolePerKilogramPerSquareMeterPluralName = '%smoles per %skilogram per square %smeter';

const
  MolePerKilogramPerSquareMeterID = -53940;
  MolePerKilogramPerSquareMeterUnit : TUnit = (
    FID         : MolePerKilogramPerSquareMeterID;
    FSymbol     : rsMolePerKilogramPerSquareMeterSymbol;
    FName       : rsMolePerKilogramPerSquareMeterName;
    FPluralName : rsMolePerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TSquareSecondKelvinMolePerSquareMeter }

resourcestring
  rsSquareSecondKelvinMolePerSquareMeterSymbol = '%ss²∙%sK∙%smol/%sm²';
  rsSquareSecondKelvinMolePerSquareMeterName = 'square %ssecond %skelvin %smole per square %smeter';
  rsSquareSecondKelvinMolePerSquareMeterPluralName = 'square %sseconds %skelvins %smoles per square %smeter';

const
  SquareSecondKelvinMolePerSquareMeterID = 43860;
  SquareSecondKelvinMolePerSquareMeterUnit : TUnit = (
    FID         : SquareSecondKelvinMolePerSquareMeterID;
    FSymbol     : rsSquareSecondKelvinMolePerSquareMeterSymbol;
    FName       : rsSquareSecondKelvinMolePerSquareMeterName;
    FPluralName : rsSquareSecondKelvinMolePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (2, 1, 1, -2));

{ TSquareSecondKelvinMolePerKilogram }

resourcestring
  rsSquareSecondKelvinMolePerKilogramSymbol = '%ss²∙%sK∙%smol/%skg';
  rsSquareSecondKelvinMolePerKilogramName = 'square %ssecond %skelvin %smole per %skilogram';
  rsSquareSecondKelvinMolePerKilogramPluralName = 'square %sseconds %skelvins %smoles per %skilogram';

const
  SquareSecondKelvinMolePerKilogramID = 114360;
  SquareSecondKelvinMolePerKilogramUnit : TUnit = (
    FID         : SquareSecondKelvinMolePerKilogramID;
    FSymbol     : rsSquareSecondKelvinMolePerKilogramSymbol;
    FName       : rsSquareSecondKelvinMolePerKilogramName;
    FPluralName : rsSquareSecondKelvinMolePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (2, 1, 1, -1));

{ TKelvinMolePerKilogramPerSquareMeter }

resourcestring
  rsKelvinMolePerKilogramPerSquareMeterSymbol = '%sK∙%smol/%skg/%sm²';
  rsKelvinMolePerKilogramPerSquareMeterName = '%skelvin %smole per %skilogram per square %smeter';
  rsKelvinMolePerKilogramPerSquareMeterPluralName = '%skelvins %smoles per %skilogram per square %smeter';

const
  KelvinMolePerKilogramPerSquareMeterID = -34920;
  KelvinMolePerKilogramPerSquareMeterUnit : TUnit = (
    FID         : KelvinMolePerKilogramPerSquareMeterID;
    FSymbol     : rsKelvinMolePerKilogramPerSquareMeterSymbol;
    FName       : rsKelvinMolePerKilogramPerSquareMeterName;
    FPluralName : rsKelvinMolePerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (1, 1, -1, -2));

{ TQuarticSecondSquareAmperePerMeter }

resourcestring
  rsQuarticSecondSquareAmperePerMeterSymbol = '%ss⁴∙%sA²/%sm';
  rsQuarticSecondSquareAmperePerMeterName = 'quartic %ssecond square %sampere per %smeter';
  rsQuarticSecondSquareAmperePerMeterPluralName = 'quartic %sseconds square %samperes per %smeter';

const
  QuarticSecondSquareAmperePerMeterID = 148260;
  QuarticSecondSquareAmperePerMeterUnit : TUnit = (
    FID         : QuarticSecondSquareAmperePerMeterID;
    FSymbol     : rsQuarticSecondSquareAmperePerMeterSymbol;
    FName       : rsQuarticSecondSquareAmperePerMeterName;
    FPluralName : rsQuarticSecondSquareAmperePerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, 2, -1));

{ TSquareAmperePerKilogramPerMeter }

resourcestring
  rsSquareAmperePerKilogramPerMeterSymbol = '%sA²/%skg/%sm';
  rsSquareAmperePerKilogramPerMeterName = 'square %sampere per %skilogram per %smeter';
  rsSquareAmperePerKilogramPerMeterPluralName = 'square %samperes per %skilogram per %smeter';

const
  SquareAmperePerKilogramPerMeterID = -240;
  SquareAmperePerKilogramPerMeterUnit : TUnit = (
    FID         : SquareAmperePerKilogramPerMeterID;
    FSymbol     : rsSquareAmperePerKilogramPerMeterSymbol;
    FName       : rsSquareAmperePerKilogramPerMeterName;
    FPluralName : rsSquareAmperePerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -1));

{ TQuarticSecondPerKilogramPerMeter }

resourcestring
  rsQuarticSecondPerKilogramPerMeterSymbol = '%ss⁴/%skg/%sm';
  rsQuarticSecondPerKilogramPerMeterName = 'quartic %ssecond per %skilogram per %smeter';
  rsQuarticSecondPerKilogramPerMeterPluralName = 'quartic %sseconds per %skilogram per %smeter';

const
  QuarticSecondPerKilogramPerMeterID = 90600;
  QuarticSecondPerKilogramPerMeterUnit : TUnit = (
    FID         : QuarticSecondPerKilogramPerMeterID;
    FSymbol     : rsQuarticSecondPerKilogramPerMeterSymbol;
    FName       : rsQuarticSecondPerKilogramPerMeterName;
    FPluralName : rsQuarticSecondPerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, -1, -1));

{ TCubicSecondAmperePerCubicMeter }

resourcestring
  rsCubicSecondAmperePerCubicMeterSymbol = '%ss³∙%sA/%sm³';
  rsCubicSecondAmperePerCubicMeterName = 'cubic %ssecond %sampere per cubic %smeter';
  rsCubicSecondAmperePerCubicMeterPluralName = 'cubic %sseconds %samperes per cubic %smeter';

const
  CubicSecondAmperePerCubicMeterID = 9540;
  CubicSecondAmperePerCubicMeterUnit : TUnit = (
    FID         : CubicSecondAmperePerCubicMeterID;
    FSymbol     : rsCubicSecondAmperePerCubicMeterSymbol;
    FName       : rsCubicSecondAmperePerCubicMeterName;
    FPluralName : rsCubicSecondAmperePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -3));

{ TAmperePerKilogramPerCubicMeter }

resourcestring
  rsAmperePerKilogramPerCubicMeterSymbol = '%sA/%skg/%sm³';
  rsAmperePerKilogramPerCubicMeterName = '%sampere per %skilogram per cubic %smeter';
  rsAmperePerKilogramPerCubicMeterPluralName = '%samperes per %skilogram per cubic %smeter';

const
  AmperePerKilogramPerCubicMeterID = -104100;
  AmperePerKilogramPerCubicMeterUnit : TUnit = (
    FID         : AmperePerKilogramPerCubicMeterID;
    FSymbol     : rsAmperePerKilogramPerCubicMeterSymbol;
    FName       : rsAmperePerKilogramPerCubicMeterName;
    FPluralName : rsAmperePerKilogramPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -3));

{ TQuarticSecondAmperePerCubicMeter }

resourcestring
  rsQuarticSecondAmperePerCubicMeterSymbol = '%ss⁴∙%sA/%sm³';
  rsQuarticSecondAmperePerCubicMeterName = 'quartic %ssecond %sampere per cubic %smeter';
  rsQuarticSecondAmperePerCubicMeterPluralName = 'quartic %sseconds %samperes per cubic %smeter';

const
  QuarticSecondAmperePerCubicMeterID = 44400;
  QuarticSecondAmperePerCubicMeterUnit : TUnit = (
    FID         : QuarticSecondAmperePerCubicMeterID;
    FSymbol     : rsQuarticSecondAmperePerCubicMeterSymbol;
    FName       : rsQuarticSecondAmperePerCubicMeterName;
    FPluralName : rsQuarticSecondAmperePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, 1, -3));

{ TQuarticSecondAmperePerKilogram }

resourcestring
  rsQuarticSecondAmperePerKilogramSymbol = '%ss⁴∙%sA/%skg';
  rsQuarticSecondAmperePerKilogramName = 'quartic %ssecond %sampere per %skilogram';
  rsQuarticSecondAmperePerKilogramPluralName = 'quartic %sseconds %samperes per %skilogram';

const
  QuarticSecondAmperePerKilogramID = 154680;
  QuarticSecondAmperePerKilogramUnit : TUnit = (
    FID         : QuarticSecondAmperePerKilogramID;
    FSymbol     : rsQuarticSecondAmperePerKilogramSymbol;
    FName       : rsQuarticSecondAmperePerKilogramName;
    FPluralName : rsQuarticSecondAmperePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, 1, -1));

{ TSquareSecondAmperePerMeter }

resourcestring
  rsSquareSecondAmperePerMeterSymbol = '%ss²∙%sA/%sm';
  rsSquareSecondAmperePerMeterName = 'square %ssecond %sampere per %smeter';
  rsSquareSecondAmperePerMeterPluralName = 'square %sseconds %samperes per %smeter';

const
  SquareSecondAmperePerMeterID = 54240;
  SquareSecondAmperePerMeterUnit : TUnit = (
    FID         : SquareSecondAmperePerMeterID;
    FSymbol     : rsSquareSecondAmperePerMeterSymbol;
    FName       : rsSquareSecondAmperePerMeterName;
    FPluralName : rsSquareSecondAmperePerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 1, -1));

{ TQuarticSecondPerQuarticMeter }

resourcestring
  rsQuarticSecondPerQuarticMeterSymbol = '%ss⁴/%sm⁴';
  rsQuarticSecondPerQuarticMeterName = 'quartic %ssecond per quartic %smeter';
  rsQuarticSecondPerQuarticMeterPluralName = 'quartic %sseconds per quartic %smeter';

const
  QuarticSecondPerQuarticMeterID = -19680;
  QuarticSecondPerQuarticMeterUnit : TUnit = (
    FID         : QuarticSecondPerQuarticMeterID;
    FSymbol     : rsQuarticSecondPerQuarticMeterSymbol;
    FName       : rsQuarticSecondPerQuarticMeterName;
    FPluralName : rsQuarticSecondPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -4));

{ TReciprocalSquareKilogramQuarticMeter }

resourcestring
  rsReciprocalSquareKilogramQuarticMeterSymbol = '1/%skg²/%sm⁴';
  rsReciprocalSquareKilogramQuarticMeterName = 'reciprocal square %skilogram quartic %smeter';
  rsReciprocalSquareKilogramQuarticMeterPluralName = 'reciprocal square %skilogram quartic %smeter';

const
  ReciprocalSquareKilogramQuarticMeterID = -177240;
  ReciprocalSquareKilogramQuarticMeterUnit : TUnit = (
    FID         : ReciprocalSquareKilogramQuarticMeterID;
    FSymbol     : rsReciprocalSquareKilogramQuarticMeterSymbol;
    FName       : rsReciprocalSquareKilogramQuarticMeterName;
    FPluralName : rsReciprocalSquareKilogramQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -4));

{ TSquareMeterPerCubicSecondPerCandelaPerSteradian }

resourcestring
  rsSquareMeterPerCubicSecondPerCandelaPerSteradianSymbol = '%sm²/%ss³/%scd/sr';
  rsSquareMeterPerCubicSecondPerCandelaPerSteradianName = 'square %smeter per cubic %ssecond per %scandela per steradian';
  rsSquareMeterPerCubicSecondPerCandelaPerSteradianPluralName = 'square %smeters per cubic %ssecond per %scandela per steradian';

const
  SquareMeterPerCubicSecondPerCandelaPerSteradianID = -102840;
  SquareMeterPerCubicSecondPerCandelaPerSteradianUnit : TUnit = (
    FID         : SquareMeterPerCubicSecondPerCandelaPerSteradianID;
    FSymbol     : rsSquareMeterPerCubicSecondPerCandelaPerSteradianSymbol;
    FName       : rsSquareMeterPerCubicSecondPerCandelaPerSteradianName;
    FPluralName : rsSquareMeterPerCubicSecondPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -3, -1));

{ TKilogramPerCubicSecondPerCandelaPerSteradian }

resourcestring
  rsKilogramPerCubicSecondPerCandelaPerSteradianSymbol = '%skg/%ss³/%scd/sr';
  rsKilogramPerCubicSecondPerCandelaPerSteradianName = '%skilogram per cubic %ssecond per %scandela per steradian';
  rsKilogramPerCubicSecondPerCandelaPerSteradianPluralName = '%skilograms per cubic %ssecond per %scandela per steradian';

const
  KilogramPerCubicSecondPerCandelaPerSteradianID = -173340;
  KilogramPerCubicSecondPerCandelaPerSteradianUnit : TUnit = (
    FID         : KilogramPerCubicSecondPerCandelaPerSteradianID;
    FSymbol     : rsKilogramPerCubicSecondPerCandelaPerSteradianSymbol;
    FName       : rsKilogramPerCubicSecondPerCandelaPerSteradianName;
    FPluralName : rsKilogramPerCubicSecondPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -3, -1));

{ TKilogramSquareMeterPerCandelaPerSteradian }

resourcestring
  rsKilogramSquareMeterPerCandelaPerSteradianSymbol = '%skg∙%sm²/%scd/sr';
  rsKilogramSquareMeterPerCandelaPerSteradianName = '%skilogram square %smeter per %scandela per steradian';
  rsKilogramSquareMeterPerCandelaPerSteradianPluralName = '%skilograms square %smeters per %scandela per steradian';

const
  KilogramSquareMeterPerCandelaPerSteradianID = 10800;
  KilogramSquareMeterPerCandelaPerSteradianUnit : TUnit = (
    FID         : KilogramSquareMeterPerCandelaPerSteradianID;
    FSymbol     : rsKilogramSquareMeterPerCandelaPerSteradianSymbol;
    FName       : rsKilogramSquareMeterPerCandelaPerSteradianName;
    FPluralName : rsKilogramSquareMeterPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TKilogramSquareMeterPerCubicSecondPerCandela }

resourcestring
  rsKilogramSquareMeterPerCubicSecondPerCandelaSymbol = '%skg∙%sm²/%ss³/%scd';
  rsKilogramSquareMeterPerCubicSecondPerCandelaName = '%skilogram square %smeter per cubic %ssecond per %scandela';
  rsKilogramSquareMeterPerCubicSecondPerCandelaPluralName = '%skilograms square %smeters per cubic %ssecond per %scandela';

const
  KilogramSquareMeterPerCubicSecondPerCandelaID = -55920;
  KilogramSquareMeterPerCubicSecondPerCandelaUnit : TUnit = (
    FID         : KilogramSquareMeterPerCubicSecondPerCandelaID;
    FSymbol     : rsKilogramSquareMeterPerCubicSecondPerCandelaSymbol;
    FName       : rsKilogramSquareMeterPerCubicSecondPerCandelaName;
    FPluralName : rsKilogramSquareMeterPerCubicSecondPerCandelaPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (1, 2, -3, -1));

{ TSquareSecondSteradianPerSquareMeter }

resourcestring
  rsSquareSecondSteradianPerSquareMeterSymbol = '%ss²∙sr/%sm²';
  rsSquareSecondSteradianPerSquareMeterName = 'square %ssecond steradian per square %smeter';
  rsSquareSecondSteradianPerSquareMeterPluralName = 'square %sseconds steradian per square %smeter';

const
  SquareSecondSteradianPerSquareMeterID = 28020;
  SquareSecondSteradianPerSquareMeterUnit : TUnit = (
    FID         : SquareSecondSteradianPerSquareMeterID;
    FSymbol     : rsSquareSecondSteradianPerSquareMeterSymbol;
    FName       : rsSquareSecondSteradianPerSquareMeterName;
    FPluralName : rsSquareSecondSteradianPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TCubicSecondSteradianPerMeter }

resourcestring
  rsCubicSecondSteradianPerMeterSymbol = '%ss³∙sr/%sm';
  rsCubicSecondSteradianPerMeterName = 'cubic %ssecond steradian per %smeter';
  rsCubicSecondSteradianPerMeterPluralName = 'cubic %sseconds steradian per %smeter';

const
  CubicSecondSteradianPerMeterID = 102660;
  CubicSecondSteradianPerMeterUnit : TUnit = (
    FID         : CubicSecondSteradianPerMeterID;
    FSymbol     : rsCubicSecondSteradianPerMeterSymbol;
    FName       : rsCubicSecondSteradianPerMeterName;
    FPluralName : rsCubicSecondSteradianPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TSteradianPerKilogramPerMeter }

resourcestring
  rsSteradianPerKilogramPerMeterSymbol = 'sr/%skg/%sm';
  rsSteradianPerKilogramPerMeterName = 'steradian per %skilogram per %smeter';
  rsSteradianPerKilogramPerMeterPluralName = 'steradian per %skilogram per %smeter';

const
  SteradianPerKilogramPerMeterID = -10980;
  SteradianPerKilogramPerMeterUnit : TUnit = (
    FID         : SteradianPerKilogramPerMeterID;
    FSymbol     : rsSteradianPerKilogramPerMeterSymbol;
    FName       : rsSteradianPerKilogramPerMeterName;
    FPluralName : rsSteradianPerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TMeterCubicSecondSteradian }

resourcestring
  rsMeterCubicSecondSteradianSymbol = '%sm∙%ss³∙sr';
  rsMeterCubicSecondSteradianName = '%smeter cubic %ssecond steradian';
  rsMeterCubicSecondSteradianPluralName = '%smeters cubic %sseconds steradian';

const
  MeterCubicSecondSteradianID = 182220;
  MeterCubicSecondSteradianUnit : TUnit = (
    FID         : MeterCubicSecondSteradianID;
    FSymbol     : rsMeterCubicSecondSteradianSymbol;
    FName       : rsMeterCubicSecondSteradianName;
    FPluralName : rsMeterCubicSecondSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 3));

{ TMeterSteradianPerKilogram }

resourcestring
  rsMeterSteradianPerKilogramSymbol = '%sm∙sr/%skg';
  rsMeterSteradianPerKilogramName = '%smeter steradian per %skilogram';
  rsMeterSteradianPerKilogramPluralName = '%smeters steradian per %skilogram';

const
  MeterSteradianPerKilogramID = 68580;
  MeterSteradianPerKilogramUnit : TUnit = (
    FID         : MeterSteradianPerKilogramID;
    FSymbol     : rsMeterSteradianPerKilogramSymbol;
    FName       : rsMeterSteradianPerKilogramName;
    FPluralName : rsMeterSteradianPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareSecondSteradian }

resourcestring
  rsSquareSecondSteradianSymbol = '%ss²∙sr';
  rsSquareSecondSteradianName = 'square %ssecond steradian';
  rsSquareSecondSteradianPluralName = 'square %sseconds steradian';

const
  SquareSecondSteradianID = 107580;
  SquareSecondSteradianUnit : TUnit = (
    FID         : SquareSecondSteradianID;
    FSymbol     : rsSquareSecondSteradianSymbol;
    FName       : rsSquareSecondSteradianName;
    FPluralName : rsSquareSecondSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

{ TCubicMeterSecond }

resourcestring
  rsCubicMeterSecondSymbol = '%sm³∙%ss';
  rsCubicMeterSecondName = 'cubic %smeter %ssecond';
  rsCubicMeterSecondPluralName = 'cubic %smeters %sseconds';

const
  CubicMeterSecondID = 154200;
  CubicMeterSecondUnit : TUnit = (
    FID         : CubicMeterSecondID;
    FSymbol     : rsCubicMeterSecondSymbol;
    FName       : rsCubicMeterSecondName;
    FPluralName : rsCubicMeterSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, 1));

{ TMolePerAmpere }

resourcestring
  rsMolePerAmpereSymbol = '%smol/%sA';
  rsMolePerAmpereName = '%smole per %sampere';
  rsMolePerAmperePluralName = '%smoles per %sampere';

const
  MolePerAmpereID = 10380;
  MolePerAmpereUnit : TUnit = (
    FID         : MolePerAmpereID;
    FSymbol     : rsMolePerAmpereSymbol;
    FName       : rsMolePerAmpereName;
    FPluralName : rsMolePerAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSexticSecondSquareAmpere }

resourcestring
  rsSexticSecondSquareAmpereSymbol = '%ss⁶∙%sA²';
  rsSexticSecondSquareAmpereName = 'sextic %ssecond square %sampere';
  rsSexticSecondSquareAmperePluralName = 'sextic %sseconds square %samperes';

const
  SexticSecondSquareAmpereID = 257760;
  SexticSecondSquareAmpereUnit : TUnit = (
    FID         : SexticSecondSquareAmpereID;
    FSymbol     : rsSexticSecondSquareAmpereSymbol;
    FName       : rsSexticSecondSquareAmpereName;
    FPluralName : rsSexticSecondSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (6, 2));

{ TSquareAmperePerQuarticMeter }

resourcestring
  rsSquareAmperePerQuarticMeterSymbol = '%sA²/%sm⁴';
  rsSquareAmperePerQuarticMeterName = 'square %sampere per quartic %smeter';
  rsSquareAmperePerQuarticMeterPluralName = 'square %samperes per quartic %smeter';

const
  SquareAmperePerQuarticMeterID = -110520;
  SquareAmperePerQuarticMeterUnit : TUnit = (
    FID         : SquareAmperePerQuarticMeterID;
    FSymbol     : rsSquareAmperePerQuarticMeterSymbol;
    FName       : rsSquareAmperePerQuarticMeterName;
    FPluralName : rsSquareAmperePerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -4));

{ TSexticSecondPerQuarticMeter }

resourcestring
  rsSexticSecondPerQuarticMeterSymbol = '%ss⁶/%sm⁴';
  rsSexticSecondPerQuarticMeterName = 'sextic %ssecond per quartic %smeter';
  rsSexticSecondPerQuarticMeterPluralName = 'sextic %sseconds per quartic %smeter';

const
  SexticSecondPerQuarticMeterID = 50040;
  SexticSecondPerQuarticMeterUnit : TUnit = (
    FID         : SexticSecondPerQuarticMeterID;
    FSymbol     : rsSexticSecondPerQuarticMeterSymbol;
    FName       : rsSexticSecondPerQuarticMeterName;
    FPluralName : rsSexticSecondPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (6, -4));

{ TSquareAmperePerSquareKilogram }

resourcestring
  rsSquareAmperePerSquareKilogramSymbol = '%sA²/%skg²';
  rsSquareAmperePerSquareKilogramName = 'square %sampere per square %skilogram';
  rsSquareAmperePerSquareKilogramPluralName = 'square %samperes per square %skilogram';

const
  SquareAmperePerSquareKilogramID = 30480;
  SquareAmperePerSquareKilogramUnit : TUnit = (
    FID         : SquareAmperePerSquareKilogramID;
    FSymbol     : rsSquareAmperePerSquareKilogramSymbol;
    FName       : rsSquareAmperePerSquareKilogramName;
    FPluralName : rsSquareAmperePerSquareKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TSexticSecondPerSquareKilogram }

resourcestring
  rsSexticSecondPerSquareKilogramSymbol = '%ss⁶/%skg²';
  rsSexticSecondPerSquareKilogramName = 'sextic %ssecond per square %skilogram';
  rsSexticSecondPerSquareKilogramPluralName = 'sextic %sseconds per square %skilogram';

const
  SexticSecondPerSquareKilogramID = 191040;
  SexticSecondPerSquareKilogramUnit : TUnit = (
    FID         : SexticSecondPerSquareKilogramID;
    FSymbol     : rsSexticSecondPerSquareKilogramSymbol;
    FName       : rsSexticSecondPerSquareKilogramName;
    FPluralName : rsSexticSecondPerSquareKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (6, -2));

{ TCubicMeterPerSteradian }

resourcestring
  rsCubicMeterPerSteradianSymbol = '%sm³/sr';
  rsCubicMeterPerSteradianName = 'cubic %smeter per steradian';
  rsCubicMeterPerSteradianPluralName = 'cubic %smeters per steradian';

const
  CubicMeterPerSteradianID = 81480;
  CubicMeterPerSteradianUnit : TUnit = (
    FID         : CubicMeterPerSteradianID;
    FSymbol     : rsCubicMeterPerSteradianSymbol;
    FName       : rsCubicMeterPerSteradianName;
    FPluralName : rsCubicMeterPerSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TCubicMeterPerCandela }

resourcestring
  rsCubicMeterPerCandelaSymbol = '%sm³/%scd';
  rsCubicMeterPerCandelaName = 'cubic %smeter per %scandela';
  rsCubicMeterPerCandelaPluralName = 'cubic %smeters per %scandela';

const
  CubicMeterPerCandelaID = 79380;
  CubicMeterPerCandelaUnit : TUnit = (
    FID         : CubicMeterPerCandelaID;
    FSymbol     : rsCubicMeterPerCandelaSymbol;
    FName       : rsCubicMeterPerCandelaName;
    FPluralName : rsCubicMeterPerCandelaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TQuarticKelvinPerSquareMeter }

resourcestring
  rsQuarticKelvinPerSquareMeterSymbol = '%sK⁴/%sm²';
  rsQuarticKelvinPerSquareMeterName = 'quartic %skelvin per square %smeter';
  rsQuarticKelvinPerSquareMeterPluralName = 'quartic %skelvins per square %smeter';

const
  QuarticKelvinPerSquareMeterID = -3480;
  QuarticKelvinPerSquareMeterUnit : TUnit = (
    FID         : QuarticKelvinPerSquareMeterID;
    FSymbol     : rsQuarticKelvinPerSquareMeterSymbol;
    FName       : rsQuarticKelvinPerSquareMeterName;
    FPluralName : rsQuarticKelvinPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -2));

{ TSquareSecondMole }

resourcestring
  rsSquareSecondMoleSymbol = '%ss²∙%smol';
  rsSquareSecondMoleName = 'square %ssecond %smole';
  rsSquareSecondMolePluralName = 'square %sseconds %smoles';

const
  SquareSecondMoleID = 104400;
  SquareSecondMoleUnit : TUnit = (
    FID         : SquareSecondMoleID;
    FSymbol     : rsSquareSecondMoleSymbol;
    FName       : rsSquareSecondMoleName;
    FPluralName : rsSquareSecondMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 1));

{ TMolePerSquareMeter }

resourcestring
  rsMolePerSquareMeterSymbol = '%smol/%sm²';
  rsMolePerSquareMeterName = '%smole per square %smeter';
  rsMolePerSquareMeterPluralName = '%smoles per square %smeter';

const
  MolePerSquareMeterID = -44880;
  MolePerSquareMeterUnit : TUnit = (
    FID         : MolePerSquareMeterID;
    FSymbol     : rsMolePerSquareMeterSymbol;
    FName       : rsMolePerSquareMeterName;
    FPluralName : rsMolePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TMolePerKilogram }

resourcestring
  rsMolePerKilogramSymbol = '%smol/%skg';
  rsMolePerKilogramName = '%smole per %skilogram';
  rsMolePerKilogramPluralName = '%smoles per %skilogram';

const
  MolePerKilogramID = 25620;
  MolePerKilogramUnit : TUnit = (
    FID         : MolePerKilogramID;
    FSymbol     : rsMolePerKilogramSymbol;
    FName       : rsMolePerKilogramName;
    FPluralName : rsMolePerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareSecondKelvinMole }

resourcestring
  rsSquareSecondKelvinMoleSymbol = '%ss²∙%sK∙%smol';
  rsSquareSecondKelvinMoleName = 'square %ssecond %skelvin %smole';
  rsSquareSecondKelvinMolePluralName = 'square %sseconds %skelvins %smoles';

const
  SquareSecondKelvinMoleID = 123420;
  SquareSecondKelvinMoleUnit : TUnit = (
    FID         : SquareSecondKelvinMoleID;
    FSymbol     : rsSquareSecondKelvinMoleSymbol;
    FName       : rsSquareSecondKelvinMoleName;
    FPluralName : rsSquareSecondKelvinMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 1, 1));

{ TKelvinMolePerSquareMeter }

resourcestring
  rsKelvinMolePerSquareMeterSymbol = '%sK∙%smol/%sm²';
  rsKelvinMolePerSquareMeterName = '%skelvin %smole per square %smeter';
  rsKelvinMolePerSquareMeterPluralName = '%skelvins %smoles per square %smeter';

const
  KelvinMolePerSquareMeterID = -25860;
  KelvinMolePerSquareMeterUnit : TUnit = (
    FID         : KelvinMolePerSquareMeterID;
    FSymbol     : rsKelvinMolePerSquareMeterSymbol;
    FName       : rsKelvinMolePerSquareMeterName;
    FPluralName : rsKelvinMolePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -2));

{ TKelvinMolePerKilogram }

resourcestring
  rsKelvinMolePerKilogramSymbol = '%sK∙%smol/%skg';
  rsKelvinMolePerKilogramName = '%skelvin %smole per %skilogram';
  rsKelvinMolePerKilogramPluralName = '%skelvins %smoles per %skilogram';

const
  KelvinMolePerKilogramID = 44640;
  KelvinMolePerKilogramUnit : TUnit = (
    FID         : KelvinMolePerKilogramID;
    FSymbol     : rsKelvinMolePerKilogramSymbol;
    FName       : rsKelvinMolePerKilogramName;
    FPluralName : rsKelvinMolePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TQuarticSecondAmpere }

resourcestring
  rsQuarticSecondAmpereSymbol = '%ss⁴∙%sA';
  rsQuarticSecondAmpereName = 'quartic %ssecond %sampere';
  rsQuarticSecondAmperePluralName = 'quartic %sseconds %samperes';

const
  QuarticSecondAmpereID = 163740;
  QuarticSecondAmpereUnit : TUnit = (
    FID         : QuarticSecondAmpereID;
    FSymbol     : rsQuarticSecondAmpereSymbol;
    FName       : rsQuarticSecondAmpereName;
    FPluralName : rsQuarticSecondAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, 1));

{ TReciprocalCubicSecondCandelaSteradian }

resourcestring
  rsReciprocalCubicSecondCandelaSteradianSymbol = '1/%ss³/%scd/sr';
  rsReciprocalCubicSecondCandelaSteradianName = 'reciprocal cubic %ssecond %scandela steradian';
  rsReciprocalCubicSecondCandelaSteradianPluralName = 'reciprocal cubic %ssecond %scandela steradian';

const
  ReciprocalCubicSecondCandelaSteradianID = -182400;
  ReciprocalCubicSecondCandelaSteradianUnit : TUnit = (
    FID         : ReciprocalCubicSecondCandelaSteradianID;
    FSymbol     : rsReciprocalCubicSecondCandelaSteradianSymbol;
    FName       : rsReciprocalCubicSecondCandelaSteradianName;
    FPluralName : rsReciprocalCubicSecondCandelaSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-3, -1));

{ TSquareMeterPerCubicSecondPerCandela }

resourcestring
  rsSquareMeterPerCubicSecondPerCandelaSymbol = '%sm²/%ss³/%scd';
  rsSquareMeterPerCubicSecondPerCandelaName = 'square %smeter per cubic %ssecond per %scandela';
  rsSquareMeterPerCubicSecondPerCandelaPluralName = 'square %smeters per cubic %ssecond per %scandela';

const
  SquareMeterPerCubicSecondPerCandelaID = -64980;
  SquareMeterPerCubicSecondPerCandelaUnit : TUnit = (
    FID         : SquareMeterPerCubicSecondPerCandelaID;
    FSymbol     : rsSquareMeterPerCubicSecondPerCandelaSymbol;
    FName       : rsSquareMeterPerCubicSecondPerCandelaName;
    FPluralName : rsSquareMeterPerCubicSecondPerCandelaPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -3, -1));

{ TKilogramPerCandelaPerSteradian }

resourcestring
  rsKilogramPerCandelaPerSteradianSymbol = '%skg/%scd/sr';
  rsKilogramPerCandelaPerSteradianName = '%skilogram per %scandela per steradian';
  rsKilogramPerCandelaPerSteradianPluralName = '%skilograms per %scandela per steradian';

const
  KilogramPerCandelaPerSteradianID = -68760;
  KilogramPerCandelaPerSteradianUnit : TUnit = (
    FID         : KilogramPerCandelaPerSteradianID;
    FSymbol     : rsKilogramPerCandelaPerSteradianSymbol;
    FName       : rsKilogramPerCandelaPerSteradianName;
    FPluralName : rsKilogramPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TKilogramPerCubicSecondPerCandela }

resourcestring
  rsKilogramPerCubicSecondPerCandelaSymbol = '%skg/%ss³/%scd';
  rsKilogramPerCubicSecondPerCandelaName = '%skilogram per cubic %ssecond per %scandela';
  rsKilogramPerCubicSecondPerCandelaPluralName = '%skilograms per cubic %ssecond per %scandela';

const
  KilogramPerCubicSecondPerCandelaID = -135480;
  KilogramPerCubicSecondPerCandelaUnit : TUnit = (
    FID         : KilogramPerCubicSecondPerCandelaID;
    FSymbol     : rsKilogramPerCubicSecondPerCandelaSymbol;
    FName       : rsKilogramPerCubicSecondPerCandelaName;
    FPluralName : rsKilogramPerCubicSecondPerCandelaPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -3, -1));

{ TKilogramSquareMeterPerCandela }

resourcestring
  rsKilogramSquareMeterPerCandelaSymbol = '%skg∙%sm²/%scd';
  rsKilogramSquareMeterPerCandelaName = '%skilogram square %smeter per %scandela';
  rsKilogramSquareMeterPerCandelaPluralName = '%skilograms square %smeters per %scandela';

const
  KilogramSquareMeterPerCandelaID = 48660;
  KilogramSquareMeterPerCandelaUnit : TUnit = (
    FID         : KilogramSquareMeterPerCandelaID;
    FSymbol     : rsKilogramSquareMeterPerCandelaSymbol;
    FName       : rsKilogramSquareMeterPerCandelaName;
    FPluralName : rsKilogramSquareMeterPerCandelaPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TSteradianPerMeter }

resourcestring
  rsSteradianPerMeterSymbol = 'sr/%sm';
  rsSteradianPerMeterName = 'steradian per %smeter';
  rsSteradianPerMeterPluralName = 'steradian per %smeter';

const
  SteradianPerMeterID = -1920;
  SteradianPerMeterUnit : TUnit = (
    FID         : SteradianPerMeterID;
    FSymbol     : rsSteradianPerMeterSymbol;
    FName       : rsSteradianPerMeterName;
    FPluralName : rsSteradianPerMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicSecondCandela }

resourcestring
  rsReciprocalCubicSecondCandelaSymbol = '1/%ss³/%scd';
  rsReciprocalCubicSecondCandelaName = 'reciprocal cubic %ssecond %scandela';
  rsReciprocalCubicSecondCandelaPluralName = 'reciprocal cubic %ssecond %scandela';

const
  ReciprocalCubicSecondCandelaID = -144540;
  ReciprocalCubicSecondCandelaUnit : TUnit = (
    FID         : ReciprocalCubicSecondCandelaID;
    FSymbol     : rsReciprocalCubicSecondCandelaSymbol;
    FName       : rsReciprocalCubicSecondCandelaName;
    FPluralName : rsReciprocalCubicSecondCandelaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-3, -1));

{ TKilogramPerCandela }

resourcestring
  rsKilogramPerCandelaSymbol = '%skg/%scd';
  rsKilogramPerCandelaName = '%skilogram per %scandela';
  rsKilogramPerCandelaPluralName = '%skilograms per %scandela';

const
  KilogramPerCandelaID = -30900;
  KilogramPerCandelaUnit : TUnit = (
    FID         : KilogramPerCandelaID;
    FSymbol     : rsKilogramPerCandelaSymbol;
    FName       : rsKilogramPerCandelaName;
    FPluralName : rsKilogramPerCandelaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

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

{ Constants }

const
  AvogadroConstant               : TQuantity = {$IFNDEF ADIMOFF} (FID: ReciprocalMoleId;                     FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}
  BohrMagneton                   : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterAmpereId;                  FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}
  BohrRadius                     : TQuantity = {$IFNDEF ADIMOFF} (FID: MeterId;                              FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}
  BoltzmannConstant              : TQuantity = {$IFNDEF ADIMOFF} (FID: JoulePerKelvinId;                     FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}
  ComptonWaveLength              : TQuantity = {$IFNDEF ADIMOFF} (FID: MeterId;                              FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}
  CoulombConstant                : TQuantity = {$IFNDEF ADIMOFF} (FID: NewtonSquareMeterPerSquareCoulombId;  FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}
  DeuteronMass                   : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramId;                           FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}
  ElectricPermittivity           : TQuantity = {$IFNDEF ADIMOFF} (FID: FaradPerMeterId;                      FValue:     8.8541878128E-12); {$ELSE} (    8.8541878128E-12); {$ENDIF}
  ElectronMass                   : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramId;                           FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}
  ElectronCharge                 : TQuantity = {$IFNDEF ADIMOFF} (FID: CoulombId;                            FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}
  MagneticPermeability           : TQuantity = {$IFNDEF ADIMOFF} (FID: HenryPerMeterId;                      FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}
  MolarGasConstant               : TQuantity = {$IFNDEF ADIMOFF} (FID: JoulePerMolePerKelvinId;              FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}
  NeutronMass                    : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramId;                           FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}
  NewtonianConstantOfGravitation : TQuantity = {$IFNDEF ADIMOFF} (FID: NewtonSquareMeterPerSquareKilogramId; FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}
  PlanckConstant                 : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramSquareMeterPerSecondId;       FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}
  ProtonMass                     : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramId;                           FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}
  RydbergConstant                : TQuantity = {$IFNDEF ADIMOFF} (FID: ReciprocalMeterId;                    FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}
  SpeedOfLight                   : TQuantity = {$IFNDEF ADIMOFF} (FID: MeterPerSecondId;                     FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}
  SquaredSpeedOfLight            : TQuantity = {$IFNDEF ADIMOFF} (FID: SquareMeterPerSquareSecondId;         FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}
  StandardAccelerationOfGravity  : TQuantity = {$IFNDEF ADIMOFF} (FID: MeterPerSquareSecondId;               FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}
  ReducedPlanckConstant          : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramSquareMeterPerSecondId;       FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}
  UnifiedAtomicMassUnit          : TQuantity = {$IFNDEF ADIMOFF} (FID: KilogramId;                           FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}

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

{ Internal routines }

function GetStr(AIndex: longint): string;
procedure Check(ALeft, ARight: longint); inline;
function CheckEqual(ALeft, ARight: longint): longint; inline;
function CheckSum(ALeft, ARight: longint): longint; inline;
function CheckSub(ALeft, ARight: longint): longint; inline;
function CheckMul(ALeft, ARight: longint): longint; inline;
function CheckDiv(ALeft, ARight: longint): longint; inline;

implementation

uses Math;

const
  Table : array[0..639-1] of
    record FID: longint; FStr: string; end = (
    (FID:     0; FStr: 'TScalar'),
    (FID: 37860; FStr: 'TSteradian'),
    (FID: 34860; FStr: 'TSecond'),
    (FID: 69720; FStr: 'TSquareSecond'),
    (FID: 104580; FStr: 'TCubicSecond'),
    (FID: 139440; FStr: 'TQuarticSecond'),
    (FID: 174300; FStr: 'TQuinticSecond'),
    (FID: 209160; FStr: 'TSexticSecond'),
    (FID: 39780; FStr: 'TMeter'),
    (FID: 19890; FStr: 'TSquareRootMeter'),
    (FID: 79560; FStr: 'TSquareMeter'),
    (FID: 119340; FStr: 'TCubicMeter'),
    (FID: 159120; FStr: 'TQuarticMeter'),
    (FID: 198900; FStr: 'TQuinticMeter'),
    (FID: 238680; FStr: 'TSexticMeter'),
    (FID:  9060; FStr: 'TKilogram'),
    (FID: 18120; FStr: 'TSquareKilogram'),
    (FID: 24300; FStr: 'TAmpere'),
    (FID: 48600; FStr: 'TSquareAmpere'),
    (FID: 19020; FStr: 'TKelvin'),
    (FID: 38040; FStr: 'TSquareKelvin'),
    (FID: 57060; FStr: 'TCubicKelvin'),
    (FID: 76080; FStr: 'TQuarticKelvin'),
    (FID: 34680; FStr: 'TMole'),
    (FID: 39960; FStr: 'TCandela'),
    (FID: -34860; FStr: 'THertz'),
    (FID: -69720; FStr: 'TSquareHertz'),
    (FID: -31860; FStr: 'TSteradianPerSquareSecond'),
    (FID:  4920; FStr: 'TMeterPerSecond'),
    (FID: -29940; FStr: 'TMeterPerSquareSecond'),
    (FID: -64800; FStr: 'TMeterPerCubicSecond'),
    (FID: -99660; FStr: 'TMeterPerQuarticSecond'),
    (FID: -134520; FStr: 'TMeterPerQuinticSecond'),
    (FID: -169380; FStr: 'TMeterPerSexticSecond'),
    (FID:  9840; FStr: 'TSquareMeterPerSquareSecond'),
    (FID: 74640; FStr: 'TMeterSecond'),
    (FID: 48840; FStr: 'TKilogramMeter'),
    (FID: -25800; FStr: 'TKilogramPerSecond'),
    (FID: 13980; FStr: 'TKilogramMeterPerSecond'),
    (FID: 27960; FStr: 'TSquareKilogramSquareMeterPerSquareSecond'),
    (FID: -19890; FStr: 'TReciprocalSquareRootMeter'),
    (FID: -39780; FStr: 'TReciprocalMeter'),
    (FID: -59670; FStr: 'TReciprocalSquareRootCubicMeter'),
    (FID: -79560; FStr: 'TReciprocalSquareMeter'),
    (FID: -119340; FStr: 'TReciprocalCubicMeter'),
    (FID: -159120; FStr: 'TReciprocalQuarticMeter'),
    (FID: 88620; FStr: 'TKilogramSquareMeter'),
    (FID: 53760; FStr: 'TKilogramSquareMeterPerSecond'),
    (FID: -4920; FStr: 'TSecondPerMeter'),
    (FID: -30720; FStr: 'TKilogramPerMeter'),
    (FID: -70500; FStr: 'TKilogramPerSquareMeter'),
    (FID: -110280; FStr: 'TKilogramPerCubicMeter'),
    (FID: -20880; FStr: 'TNewton'),
    (FID: -41760; FStr: 'TSquareNewton'),
    (FID: -100440; FStr: 'TPascal'),
    (FID: 18900; FStr: 'TJoule'),
    (FID: -15960; FStr: 'TWatt'),
    (FID: 59160; FStr: 'TCoulomb'),
    (FID: 118320; FStr: 'TSquareCoulomb'),
    (FID: 98940; FStr: 'TCoulombMeter'),
    (FID: -40260; FStr: 'TVolt'),
    (FID: -80520; FStr: 'TSquareVolt'),
    (FID: 99420; FStr: 'TFarad'),
    (FID: -64560; FStr: 'TOhm'),
    (FID: 64560; FStr: 'TSiemens'),
    (FID: 24780; FStr: 'TSiemensPerMeter'),
    (FID: -84960; FStr: 'TTesla'),
    (FID: -5400; FStr: 'TWeber'),
    (FID: -29700; FStr: 'THenry'),
    (FID: 29700; FStr: 'TReciprocalHenry'),
    (FID: 77820; FStr: 'TLumen'),
    (FID: 112680; FStr: 'TLumenSecond'),
    (FID: -6660; FStr: 'TLumenSecondPerCubicMeter'),
    (FID: -1740; FStr: 'TLux'),
    (FID: 33120; FStr: 'TLuxSecond'),
    (FID:  -180; FStr: 'TKatal'),
    (FID: -140220; FStr: 'TNewtonPerCubicMeter'),
    (FID: -60660; FStr: 'TNewtonPerMeter'),
    (FID: 84480; FStr: 'TCubicMeterPerSecond'),
    (FID: -65580; FStr: 'TPoiseuille'),
    (FID: 44700; FStr: 'TSquareMeterPerSecond'),
    (FID: -150060; FStr: 'TKilogramPerQuarticMeter'),
    (FID: 193980; FStr: 'TQuarticMeterSecond'),
    (FID: -184920; FStr: 'TKilogramPerQuarticMeterPerSecond'),
    (FID: 110280; FStr: 'TCubicMeterPerKilogram'),
    (FID: 78780; FStr: 'TKilogramSquareSecond'),
    (FID: 49620; FStr: 'TCubicMeterPerSquareSecond'),
    (FID: 58680; FStr: 'TNewtonSquareMeter'),
    (FID: 98460; FStr: 'TNewtonCubicMeter'),
    (FID: -39000; FStr: 'TNewtonPerSquareKilogram'),
    (FID: -21660; FStr: 'TSquareKilogramPerMeter'),
    (FID: -61440; FStr: 'TSquareKilogramPerSquareMeter'),
    (FID: 61440; FStr: 'TSquareMeterPerSquareKilogram'),
    (FID: 40560; FStr: 'TNewtonSquareMeterPerSquareKilogram'),
    (FID: -19020; FStr: 'TReciprocalKelvin'),
    (FID: 28080; FStr: 'TKilogramKelvin'),
    (FID:  -120; FStr: 'TJoulePerKelvin'),
    (FID: -9180; FStr: 'TJoulePerKilogramPerKelvin'),
    (FID: 58800; FStr: 'TMeterKelvin'),
    (FID: -20760; FStr: 'TKelvinPerMeter'),
    (FID: -55740; FStr: 'TWattPerMeter'),
    (FID: -95520; FStr: 'TWattPerSquareMeter'),
    (FID: -135300; FStr: 'TWattPerCubicMeter'),
    (FID: -34980; FStr: 'TWattPerKelvin'),
    (FID: -74760; FStr: 'TWattPerMeterPerKelvin'),
    (FID: 34980; FStr: 'TKelvinPerWatt'),
    (FID: 55740; FStr: 'TMeterPerWatt'),
    (FID: 74760; FStr: 'TMeterKelvinPerWatt'),
    (FID: 98580; FStr: 'TSquareMeterKelvin'),
    (FID: -114540; FStr: 'TWattPerSquareMeterPerKelvin'),
    (FID: 155640; FStr: 'TSquareMeterQuarticKelvin'),
    (FID: -92040; FStr: 'TWattPerQuarticKelvin'),
    (FID: -171600; FStr: 'TWattPerSquareMeterPerQuarticKelvin'),
    (FID: -15780; FStr: 'TJoulePerMole'),
    (FID: 53700; FStr: 'TMoleKelvin'),
    (FID: -34800; FStr: 'TJoulePerMolePerKelvin'),
    (FID: -24780; FStr: 'TOhmMeter'),
    (FID: -80040; FStr: 'TVoltPerMeter'),
    (FID: 19380; FStr: 'TCoulombPerMeter'),
    (FID: 78540; FStr: 'TSquareCoulombPerMeter'),
    (FID: -20400; FStr: 'TCoulombPerSquareMeter'),
    (FID: -38760; FStr: 'TSquareMeterPerSquareCoulomb'),
    (FID: -139200; FStr: 'TNewtonPerSquareCoulomb'),
    (FID: -59640; FStr: 'TNewtonSquareMeterPerSquareCoulomb'),
    (FID:  -480; FStr: 'TVoltMeter'),
    (FID: -35340; FStr: 'TVoltMeterPerSecond'),
    (FID: 59640; FStr: 'TFaradPerMeter'),
    (FID: -15480; FStr: 'TAmperePerMeter'),
    (FID: 15480; FStr: 'TMeterPerAmpere'),
    (FID: -45180; FStr: 'TTeslaMeter'),
    (FID: -109260; FStr: 'TTeslaPerAmpere'),
    (FID: -69480; FStr: 'THenryPerMeter'),
    (FID: -51600; FStr: 'TSquareKilogramPerSquareSecond'),
    (FID: -9840; FStr: 'TSquareSecondPerSquareMeter'),
    (FID: 37800; FStr: 'TSquareJoule'),
    (FID: 107520; FStr: 'TSquareJouleSquareSecond'),
    (FID: 50100; FStr: 'TCoulombPerKilogram'),
    (FID: 103860; FStr: 'TSquareMeterAmpere'),
    (FID: 93780; FStr: 'TLumenPerWatt'),
    (FID: -34680; FStr: 'TReciprocalMole'),
    (FID: -55260; FStr: 'TAmperePerSquareMeter'),
    (FID: -84660; FStr: 'TMolePerCubicMeter'),
    (FID: -39600; FStr: 'TCandelaPerSquareMeter'),
    (FID: -60180; FStr: 'TCoulombPerCubicMeter'),
    (FID: -25020; FStr: 'TGrayPerSecond'),
    (FID:  3000; FStr: 'TSteradianHertz'),
    (FID: 77640; FStr: 'TMeterSteradian'),
    (FID: 117420; FStr: 'TSquareMeterSteradian'),
    (FID: 157200; FStr: 'TCubicMeterSteradian'),
    (FID: 82560; FStr: 'TSquareMeterSteradianHertz'),
    (FID: -53820; FStr: 'TWattPerSteradian'),
    (FID: -18960; FStr: 'TWattPerSteradianPerHertz'),
    (FID: -93600; FStr: 'TWattPerMeterPerSteradian'),
    (FID: -133380; FStr: 'TWattPerSquareMeterPerSteradian'),
    (FID: -173160; FStr: 'TWattPerCubicMeterPerSteradian'),
    (FID: -98520; FStr: 'TWattPerSquareMeterPerSteradianPerHertz'),
    (FID: -119520; FStr: 'TKatalPerCubicMeter'),
    (FID: 24480; FStr: 'TCoulombPerMole'),
    (FID: 20880; FStr: 'TReciprocalNewton'),
    (FID: 84960; FStr: 'TReciprocalTesla'),
    (FID: 100440; FStr: 'TReciprocalPascal'),
    (FID:  5400; FStr: 'TReciprocalWeber'),
    (FID: 15960; FStr: 'TReciprocalWatt'),
    (FID: 80040; FStr: 'TMeterPerVolt'),
    (FID:  2265; FStr: 'TQuarticRootKilogram'),
    (FID:  3020; FStr: 'TCubicRootKilogram'),
    (FID:  4530; FStr: 'TSquareRootKilogram'),
    (FID: 13590; FStr: 'TSquareRootCubicKilogram'),
    (FID: 22650; FStr: 'TSquareRootQuinticKilogram'),
    (FID: 27180; FStr: 'TCubicKilogram'),
    (FID: 36240; FStr: 'TQuarticKilogram'),
    (FID: 45300; FStr: 'TQuinticKilogram'),
    (FID: 54360; FStr: 'TSexticKilogram'),
    (FID:  9945; FStr: 'TQuarticRootMeter'),
    (FID: 13260; FStr: 'TCubicRootMeter'),
    (FID: 59670; FStr: 'TSquareRootCubicMeter'),
    (FID: 99450; FStr: 'TSquareRootQuinticMeter'),
    (FID:  8715; FStr: 'TQuarticRootSecond'),
    (FID: 11620; FStr: 'TCubicRootSecond'),
    (FID: 17430; FStr: 'TSquareRootSecond'),
    (FID: 52290; FStr: 'TSquareRootCubicSecond'),
    (FID: 87150; FStr: 'TSquareRootQuinticSecond'),
    (FID:  6075; FStr: 'TQuarticRootAmpere'),
    (FID:  8100; FStr: 'TCubicRootAmpere'),
    (FID: 12150; FStr: 'TSquareRootAmpere'),
    (FID: 36450; FStr: 'TSquareRootCubicAmpere'),
    (FID: 60750; FStr: 'TSquareRootQuinticAmpere'),
    (FID: 72900; FStr: 'TCubicAmpere'),
    (FID: 97200; FStr: 'TQuarticAmpere'),
    (FID: 121500; FStr: 'TQuinticAmpere'),
    (FID: 145800; FStr: 'TSexticAmpere'),
    (FID:  4755; FStr: 'TQuarticRootKelvin'),
    (FID:  6340; FStr: 'TCubicRootKelvin'),
    (FID:  9510; FStr: 'TSquareRootKelvin'),
    (FID: 28530; FStr: 'TSquareRootCubicKelvin'),
    (FID: 47550; FStr: 'TSquareRootQuinticKelvin'),
    (FID: 95100; FStr: 'TQuinticKelvin'),
    (FID: 114120; FStr: 'TSexticKelvin'),
    (FID:  8670; FStr: 'TQuarticRootMole'),
    (FID: 11560; FStr: 'TCubicRootMole'),
    (FID: 17340; FStr: 'TSquareRootMole'),
    (FID: 52020; FStr: 'TSquareRootCubicMole'),
    (FID: 69360; FStr: 'TSquareMole'),
    (FID: 86700; FStr: 'TSquareRootQuinticMole'),
    (FID: 104040; FStr: 'TCubicMole'),
    (FID: 138720; FStr: 'TQuarticMole'),
    (FID: 173400; FStr: 'TQuinticMole'),
    (FID: 208080; FStr: 'TSexticMole'),
    (FID:  9990; FStr: 'TQuarticRootCandela'),
    (FID: 13320; FStr: 'TCubicRootCandela'),
    (FID: 19980; FStr: 'TSquareRootCandela'),
    (FID: 59940; FStr: 'TSquareRootCubicCandela'),
    (FID: 79920; FStr: 'TSquareCandela'),
    (FID: 99900; FStr: 'TSquareRootQuinticCandela'),
    (FID: 119880; FStr: 'TCubicCandela'),
    (FID: 159840; FStr: 'TQuarticCandela'),
    (FID: 199800; FStr: 'TQuinticCandela'),
    (FID: 239760; FStr: 'TSexticCandela'),
    (FID:  9465; FStr: 'TQuarticRootSteradian'),
    (FID: 12620; FStr: 'TCubicRootSteradian'),
    (FID: 18930; FStr: 'TSquareRootSteradian'),
    (FID: 56790; FStr: 'TSquareRootCubicSteradian'),
    (FID: 75720; FStr: 'TSquareSteradian'),
    (FID: 94650; FStr: 'TSquareRootQuinticSteradian'),
    (FID: 113580; FStr: 'TCubicSteradian'),
    (FID: 151440; FStr: 'TQuarticSteradian'),
    (FID: 189300; FStr: 'TQuinticSteradian'),
    (FID: 227160; FStr: 'TSexticSteradian'),
    (FID: -104580; FStr: 'TReciprocalCubicSecond'),
    (FID: -139440; FStr: 'TReciprocalQuarticSecond'),
    (FID: -174300; FStr: 'TReciprocalQuinticSecond'),
    (FID: -209160; FStr: 'TReciprocalSexticSecond'),
    (FID: 97680; FStr: 'TSquareKilogramSquareMeter'),
    (FID: -59880; FStr: 'TSquareMeterPerQuarticSecond'),
    (FID: -121320; FStr: 'TSquareKilogramPerQuarticSecond'),
    (FID: -109500; FStr: 'TReciprocalMeterSquareSecond'),
    (FID: 64080; FStr: 'TMeterAmpere'),
    (FID: -49320; FStr: 'TSquareMeterPerCubicSecondPerAmpere'),
    (FID: -119820; FStr: 'TKilogramPerCubicSecondPerAmpere'),
    (FID: 64320; FStr: 'TKilogramSquareMeterPerAmpere'),
    (FID: -98640; FStr: 'TQuarticMeterPerSexticSecondPerSquareAmpere'),
    (FID: -239640; FStr: 'TSquareKilogramPerSexticSecondPerSquareAmpere'),
    (FID: 128640; FStr: 'TSquareKilogramQuarticMeterPerSquareAmpere'),
    (FID: -31920; FStr: 'TSquareKilogramQuarticMeterPerSexticSecond'),
    (FID: 108480; FStr: 'TQuarticSecondSquareAmperePerSquareMeter'),
    (FID: 178980; FStr: 'TQuarticSecondSquareAmperePerKilogram'),
    (FID: -40020; FStr: 'TSquareAmperePerKilogramPerSquareMeter'),
    (FID: 50820; FStr: 'TQuarticSecondPerKilogramPerSquareMeter'),
    (FID: -73620; FStr: 'TSquareMeterPerCubicSecondPerSquareAmpere'),
    (FID: -144120; FStr: 'TKilogramPerCubicSecondPerSquareAmpere'),
    (FID: 40020; FStr: 'TKilogramSquareMeterPerSquareAmpere'),
    (FID: 73620; FStr: 'TCubicSecondSquareAmperePerSquareMeter'),
    (FID: 144120; FStr: 'TCubicSecondSquareAmperePerKilogram'),
    (FID: 33840; FStr: 'TCubicSecondSquareAmperePerCubicMeter'),
    (FID: -79800; FStr: 'TSquareAmperePerKilogramPerCubicMeter'),
    (FID: -23820; FStr: 'TCubicSecondPerKilogramPerCubicMeter'),
    (FID: -94020; FStr: 'TReciprocalSquareSecondAmpere'),
    (FID: -15240; FStr: 'TKilogramPerAmpere'),
    (FID: -14460; FStr: 'TSquareMeterPerSquareSecondPerAmpere'),
    (FID: 38760; FStr: 'TSquareSecondSquareAmperePerSquareMeter'),
    (FID: 109260; FStr: 'TSquareSecondSquareAmperePerKilogram'),
    (FID: -18900; FStr: 'TSquareSecondPerKilogramPerSquareMeter'),
    (FID: 72720; FStr: 'TSecondSteradian'),
    (FID: 74820; FStr: 'TSecondCandela'),
    (FID: -41520; FStr: 'TCandelaSteradianPerCubicMeter'),
    (FID: -46620; FStr: 'TSecondSteradianPerCubicMeter'),
    (FID: -44520; FStr: 'TSecondCandelaPerCubicMeter'),
    (FID: -41700; FStr: 'TSteradianPerSquareMeter'),
    (FID: -6840; FStr: 'TSecondSteradianPerSquareMeter'),
    (FID: -4740; FStr: 'TSecondCandelaPerSquareMeter'),
    (FID: -149280; FStr: 'TReciprocalSquareMeterSquareSecond'),
    (FID: -74640; FStr: 'TReciprocalMeterSecond'),
    (FID: -193980; FStr: 'TReciprocalQuarticMeterSecond'),
    (FID: -9060; FStr: 'TReciprocalKilogram'),
    (FID: 128400; FStr: 'TKilogramCubicMeter'),
    (FID: 89400; FStr: 'TQuarticMeterPerSquareSecond'),
    (FID: 168180; FStr: 'TKilogramQuarticMeter'),
    (FID: -78780; FStr: 'TReciprocalKilogramSquareSecond'),
    (FID: 30720; FStr: 'TMeterPerKilogram'),
    (FID: -18120; FStr: 'TReciprocalSquareKilogram'),
    (FID: -79680; FStr: 'TKilogramPerSquareSecondPerKelvin'),
    (FID: 69600; FStr: 'TKilogramSquareMeterPerKelvin'),
    (FID: -88740; FStr: 'TReciprocalSquareSecondKelvin'),
    (FID: 60540; FStr: 'TSquareMeterPerKelvin'),
    (FID: -144360; FStr: 'TReciprocalMeterCubicSecond'),
    (FID: -44040; FStr: 'TSquareMeterPerCubicSecondPerKelvin'),
    (FID: -83820; FStr: 'TMeterPerCubicSecondPerKelvin'),
    (FID: 29820; FStr: 'TKilogramMeterPerKelvin'),
    (FID: 44040; FStr: 'TCubicSecondKelvinPerSquareMeter'),
    (FID: 114540; FStr: 'TCubicSecondKelvinPerKilogram'),
    (FID: -69600; FStr: 'TKelvinPerKilogramPerSquareMeter'),
    (FID: 64800; FStr: 'TCubicSecondPerMeter'),
    (FID: 95520; FStr: 'TCubicSecondPerKilogram'),
    (FID: -48840; FStr: 'TReciprocalKilogramMeter'),
    (FID: 83820; FStr: 'TCubicSecondKelvinPerMeter'),
    (FID: -29820; FStr: 'TKelvinPerKilogramPerMeter'),
    (FID: -123600; FStr: 'TReciprocalCubicSecondKelvin'),
    (FID: -9960; FStr: 'TKilogramPerKelvin'),
    (FID: -101100; FStr: 'TSquareMeterPerCubicSecondPerQuarticKelvin'),
    (FID: 12540; FStr: 'TKilogramSquareMeterPerQuarticKelvin'),
    (FID: -180660; FStr: 'TReciprocalCubicSecondQuarticKelvin'),
    (FID: -67020; FStr: 'TKilogramPerQuarticKelvin'),
    (FID: -24840; FStr: 'TSquareMeterPerSquareSecondPerMole'),
    (FID: -95340; FStr: 'TKilogramPerSquareSecondPerMole'),
    (FID: 53940; FStr: 'TKilogramSquareMeterPerMole'),
    (FID: -43860; FStr: 'TSquareMeterPerSquareSecondPerKelvinPerMole'),
    (FID: -114360; FStr: 'TKilogramPerSquareSecondPerKelvinPerMole'),
    (FID: 34920; FStr: 'TKilogramSquareMeterPerKelvinPerMole'),
    (FID: -33840; FStr: 'TCubicMeterPerCubicSecondPerSquareAmpere'),
    (FID: 79800; FStr: 'TKilogramCubicMeterPerSquareAmpere'),
    (FID: 23820; FStr: 'TKilogramCubicMeterPerCubicSecond'),
    (FID: -89100; FStr: 'TMeterPerCubicSecondPerAmpere'),
    (FID: 24540; FStr: 'TKilogramMeterPerAmpere'),
    (FID:  8820; FStr: 'TSquareAmperePerMeter'),
    (FID: 29940; FStr: 'TSquareSecondPerMeter'),
    (FID: -44700; FStr: 'TSecondPerSquareMeter'),
    (FID: -118320; FStr: 'TReciprocalSquareSecondSquareAmpere'),
    (FID: 30960; FStr: 'TSquareMeterPerSquareAmpere'),
    (FID: -148260; FStr: 'TMeterPerQuarticSecondPerSquareAmpere'),
    (FID: -178980; FStr: 'TKilogramPerQuarticSecondPerSquareAmpere'),
    (FID:   240; FStr: 'TKilogramMeterPerSquareAmpere'),
    (FID: -90600; FStr: 'TKilogramMeterPerQuarticSecond'),
    (FID: -68700; FStr: 'TCubicMeterPerQuarticSecondPerSquareAmpere'),
    (FID: -11040; FStr: 'TKilogramCubicMeterPerQuarticSecond'),
    (FID: -9540; FStr: 'TCubicMeterPerCubicSecondPerAmpere'),
    (FID: 104100; FStr: 'TKilogramCubicMeterPerAmpere'),
    (FID: -44400; FStr: 'TCubicMeterPerQuarticSecondPerAmpere'),
    (FID: -154680; FStr: 'TKilogramPerQuarticSecondPerAmpere'),
    (FID: 68700; FStr: 'TQuarticSecondSquareAmperePerCubicMeter'),
    (FID: 11040; FStr: 'TQuarticSecondPerKilogramPerCubicMeter'),
    (FID: -24300; FStr: 'TReciprocalAmpere'),
    (FID: -54240; FStr: 'TMeterPerSquareSecondPerAmpere'),
    (FID: -39540; FStr: 'TKilogramPerSquareAmpere'),
    (FID: -78540; FStr: 'TMeterPerSquareSecondPerSquareAmpere'),
    (FID: 19680; FStr: 'TQuarticMeterPerQuarticSecond'),
    (FID: 177240; FStr: 'TSquareKilogramQuarticMeter'),
    (FID: 15240; FStr: 'TAmperePerKilogram'),
    (FID: 25800; FStr: 'TSecondPerKilogram'),
    (FID: 102840; FStr: 'TCubicSecondCandelaSteradianPerSquareMeter'),
    (FID: 173340; FStr: 'TCubicSecondCandelaSteradianPerKilogram'),
    (FID: -10800; FStr: 'TCandelaSteradianPerKilogramPerSquareMeter'),
    (FID: 53820; FStr: 'TCubicSecondSteradianPerKilogramPerSquareMeter'),
    (FID: 55920; FStr: 'TCubicSecondCandelaPerKilogramPerSquareMeter'),
    (FID: -95040; FStr: 'TAmperePerCubicMeter'),
    (FID: -84480; FStr: 'TSecondPerCubicMeter'),
    (FID: -62880; FStr: 'TSquareMeterPerCubicSecondPerSteradian'),
    (FID: 50760; FStr: 'TKilogramSquareMeterPerSteradian'),
    (FID: -28020; FStr: 'TSquareMeterPerSquareSecondPerSteradian'),
    (FID: -102660; FStr: 'TMeterPerCubicSecondPerSteradian'),
    (FID: 10980; FStr: 'TKilogramMeterPerSteradian'),
    (FID: -142440; FStr: 'TReciprocalCubicSecondSteradian'),
    (FID: -28800; FStr: 'TKilogramPerSteradian'),
    (FID: -182220; FStr: 'TReciprocalMeterCubicSecondSteradian'),
    (FID: -68580; FStr: 'TKilogramPerMeterPerSteradian'),
    (FID: -107580; FStr: 'TReciprocalSquareSecondSteradian'),
    (FID: -154200; FStr: 'TReciprocalCubicMeterSecond'),
    (FID: -10380; FStr: 'TAmperePerMole'),
    (FID:   180; FStr: 'TSecondPerMole'),
    (FID: 60660; FStr: 'TSquareSecondPerKilogram'),
    (FID: 94020; FStr: 'TSquareSecondAmpere'),
    (FID: 109500; FStr: 'TMeterSquareSecond'),
    (FID: 14460; FStr: 'TSquareSecondAmperePerSquareMeter'),
    (FID: -64320; FStr: 'TAmperePerKilogramPerSquareMeter'),
    (FID: 25020; FStr: 'TCubicSecondPerSquareMeter'),
    (FID: -88620; FStr: 'TReciprocalKilogramSquareMeter'),
    (FID: 89100; FStr: 'TCubicSecondAmperePerMeter'),
    (FID: 119820; FStr: 'TCubicSecondAmperePerKilogram'),
    (FID: -24540; FStr: 'TAmperePerKilogramPerMeter'),
    (FID: -128880; FStr: 'TReciprocalCubicSecondAmpere'),
    (FID: 55260; FStr: 'TSquareMeterPerAmpere'),
    (FID: -257760; FStr: 'TReciprocalSexticSecondSquareAmpere'),
    (FID: 110520; FStr: 'TQuarticMeterPerSquareAmpere'),
    (FID: -50040; FStr: 'TQuarticMeterPerSexticSecond'),
    (FID: -30480; FStr: 'TSquareKilogramPerSquareAmpere'),
    (FID: -191040; FStr: 'TSquareKilogramPerSexticSecond'),
    (FID: 188040; FStr: 'TQuarticSecondSquareAmpere'),
    (FID: -30960; FStr: 'TSquareAmperePerSquareMeter'),
    (FID: 59880; FStr: 'TQuarticSecondPerSquareMeter'),
    (FID: 39540; FStr: 'TSquareAmperePerKilogram'),
    (FID: 130380; FStr: 'TQuarticSecondPerKilogram'),
    (FID: -153180; FStr: 'TReciprocalCubicSecondSquareAmpere'),
    (FID: 153180; FStr: 'TCubicSecondSquareAmpere'),
    (FID: -70740; FStr: 'TSquareAmperePerCubicMeter'),
    (FID: -14760; FStr: 'TCubicSecondPerCubicMeter'),
    (FID: -128400; FStr: 'TReciprocalKilogramCubicMeter'),
    (FID: -81480; FStr: 'TSteradianPerCubicMeter'),
    (FID: -79380; FStr: 'TCandelaPerCubicMeter'),
    (FID: 20760; FStr: 'TMeterPerKelvin'),
    (FID: 123600; FStr: 'TCubicSecondKelvin'),
    (FID: -60540; FStr: 'TKelvinPerSquareMeter'),
    (FID:  9960; FStr: 'TKelvinPerKilogram'),
    (FID:  3480; FStr: 'TSquareMeterPerQuarticKelvin'),
    (FID: -76080; FStr: 'TReciprocalQuarticKelvin'),
    (FID: -104400; FStr: 'TReciprocalSquareSecondMole'),
    (FID: 44880; FStr: 'TSquareMeterPerMole'),
    (FID: -25620; FStr: 'TKilogramPerMole'),
    (FID: -123420; FStr: 'TReciprocalSquareSecondKelvinMole'),
    (FID: 25860; FStr: 'TSquareMeterPerKelvinPerMole'),
    (FID: -44640; FStr: 'TKilogramPerKelvinPerMole'),
    (FID: 70740; FStr: 'TCubicMeterPerSquareAmpere'),
    (FID: 14760; FStr: 'TCubicMeterPerCubicSecond'),
    (FID: -48600; FStr: 'TReciprocalSquareAmpere'),
    (FID: -188040; FStr: 'TReciprocalQuarticSecondSquareAmpere'),
    (FID: -8820; FStr: 'TMeterPerSquareAmpere'),
    (FID: -130380; FStr: 'TKilogramPerQuarticSecond'),
    (FID: -20100; FStr: 'TCubicMeterPerQuarticSecond'),
    (FID: 95040; FStr: 'TCubicMeterPerAmpere'),
    (FID: -163740; FStr: 'TReciprocalQuarticSecondAmpere'),
    (FID: 20100; FStr: 'TQuarticSecondPerCubicMeter'),
    (FID: 182400; FStr: 'TCubicSecondCandelaSteradian'),
    (FID: 62880; FStr: 'TCubicSecondSteradianPerSquareMeter'),
    (FID: 64980; FStr: 'TCubicSecondCandelaPerSquareMeter'),
    (FID: 68760; FStr: 'TCandelaSteradianPerKilogram'),
    (FID: 133380; FStr: 'TCubicSecondSteradianPerKilogram'),
    (FID: 135480; FStr: 'TCubicSecondCandelaPerKilogram'),
    (FID: -50760; FStr: 'TSteradianPerKilogramPerSquareMeter'),
    (FID: -48660; FStr: 'TCandelaPerKilogramPerSquareMeter'),
    (FID: 41700; FStr: 'TSquareMeterPerSteradian'),
    (FID:  1920; FStr: 'TMeterPerSteradian'),
    (FID: -37860; FStr: 'TReciprocalSteradian'),
    (FID: -77640; FStr: 'TReciprocalMeterSteradian'),
    (FID: 128880; FStr: 'TCubicSecondAmpere'),
    (FID: -53700; FStr: 'TReciprocalKelvinMole'),
    (FID: 142440; FStr: 'TCubicSecondSteradian'),
    (FID: 144540; FStr: 'TCubicSecondCandela'),
    (FID: 28800; FStr: 'TSteradianPerKilogram'),
    (FID: 30900; FStr: 'TCandelaPerKilogram'),
    (FID: -198900; FStr: 'TReciprocalQuinticMeter'),
    (FID: -238680; FStr: 'TReciprocalSexticMeter'),
    (FID: -38040; FStr: 'TReciprocalSquareKelvin'),
    (FID: -57060; FStr: 'TReciprocalCubicKelvin'),
    (FID: -39960; FStr: 'TReciprocalCandela'),
    (FID: 31860; FStr: 'TSquareSecondPerSteradian'),
    (FID: 99660; FStr: 'TQuarticSecondPerMeter'),
    (FID: 134520; FStr: 'TQuinticSecondPerMeter'),
    (FID: 169380; FStr: 'TSexticSecondPerMeter'),
    (FID: -13980; FStr: 'TSecondPerKilogramPerMeter'),
    (FID: -27960; FStr: 'TSquareSecondPerSquareKilogramPerSquareMeter'),
    (FID: -53760; FStr: 'TSecondPerKilogramPerSquareMeter'),
    (FID: 70500; FStr: 'TSquareMeterPerKilogram'),
    (FID: 41760; FStr: 'TQuarticSecondPerSquareKilogramPerSquareMeter'),
    (FID: -59160; FStr: 'TReciprocalSecondAmpere'),
    (FID: -98940; FStr: 'TReciprocalMeterSecondAmpere'),
    (FID: 40260; FStr: 'TCubicSecondAmperePerKilogramPerSquareMeter'),
    (FID: 80520; FStr: 'TSexticSecondSquareAmperePerSquareKilogramPerQuarticMeter'),
    (FID: -99420; FStr: 'TKilogramSquareMeterPerQuarticSecondPerSquareAmpere'),
    (FID: -77820; FStr: 'TReciprocalCandelaSteradian'),
    (FID: -112680; FStr: 'TReciprocalSecondCandelaSteradian'),
    (FID:  6660; FStr: 'TCubicMeterPerSecondPerCandelaPerSteradian'),
    (FID:  1740; FStr: 'TSquareMeterPerCandelaPerSteradian'),
    (FID: -33120; FStr: 'TSquareMeterPerSecondPerCandelaPerSteradian'),
    (FID: 140220; FStr: 'TSquareMeterSquareSecondPerKilogram'),
    (FID: 65580; FStr: 'TMeterSecondPerKilogram'),
    (FID: 150060; FStr: 'TQuarticMeterPerKilogram'),
    (FID: 184920; FStr: 'TQuarticMeterSecondPerKilogram'),
    (FID: -49620; FStr: 'TSquareSecondPerCubicMeter'),
    (FID: -58680; FStr: 'TSquareSecondPerKilogramPerCubicMeter'),
    (FID: -98460; FStr: 'TSquareSecondPerKilogramPerQuarticMeter'),
    (FID: 39000; FStr: 'TKilogramSquareSecondPerMeter'),
    (FID: 21660; FStr: 'TMeterPerSquareKilogram'),
    (FID: -40560; FStr: 'TKilogramSquareSecondPerCubicMeter'),
    (FID: -28080; FStr: 'TReciprocalKilogramKelvin'),
    (FID:   120; FStr: 'TSquareSecondKelvinPerKilogramPerSquareMeter'),
    (FID:  9180; FStr: 'TSquareSecondKelvinPerSquareMeter'),
    (FID: -58800; FStr: 'TReciprocalMeterKelvin'),
    (FID: 135300; FStr: 'TMeterCubicSecondPerKilogram'),
    (FID: -98580; FStr: 'TReciprocalSquareMeterKelvin'),
    (FID: -155640; FStr: 'TReciprocalSquareMeterQuarticKelvin'),
    (FID: 92040; FStr: 'TCubicSecondQuarticKelvinPerKilogramPerSquareMeter'),
    (FID: 171600; FStr: 'TCubicSecondQuarticKelvinPerKilogram'),
    (FID: 15780; FStr: 'TSquareSecondMolePerKilogramPerSquareMeter'),
    (FID: 34800; FStr: 'TSquareSecondKelvinMolePerKilogramPerSquareMeter'),
    (FID: -19380; FStr: 'TMeterPerSecondPerAmpere'),
    (FID: 20400; FStr: 'TSquareMeterPerSecondPerAmpere'),
    (FID: 139200; FStr: 'TQuarticSecondSquareAmperePerKilogramPerMeter'),
    (FID:   480; FStr: 'TCubicSecondAmperePerKilogramPerCubicMeter'),
    (FID: 35340; FStr: 'TQuarticSecondAmperePerKilogramPerCubicMeter'),
    (FID: 45180; FStr: 'TSquareSecondAmperePerKilogramPerMeter'),
    (FID: 69480; FStr: 'TSquareSecondSquareAmperePerKilogramPerMeter'),
    (FID: 51600; FStr: 'TSquareSecondPerSquareKilogram'),
    (FID: -37800; FStr: 'TQuarticSecondPerSquareKilogramPerQuarticMeter'),
    (FID: -107520; FStr: 'TSquareSecondPerSquareKilogramPerQuarticMeter'),
    (FID: -50100; FStr: 'TKilogramPerSecondPerAmpere'),
    (FID: -103860; FStr: 'TReciprocalSquareMeterAmpere'),
    (FID: -93780; FStr: 'TKilogramSquareMeterPerCubicSecondPerCandelaPerSteradian'),
    (FID: 84660; FStr: 'TCubicMeterPerMole'),
    (FID: 39600; FStr: 'TSquareMeterPerCandela'),
    (FID: 60180; FStr: 'TCubicMeterPerSecondPerAmpere'),
    (FID: -3000; FStr: 'TSecondPerSteradian'),
    (FID: -117420; FStr: 'TReciprocalSquareMeterSteradian'),
    (FID: -157200; FStr: 'TReciprocalCubicMeterSteradian'),
    (FID: -82560; FStr: 'TSecondPerSquareMeterPerSteradian'),
    (FID: 18960; FStr: 'TSquareSecondSteradianPerKilogramPerSquareMeter'),
    (FID: 93600; FStr: 'TCubicSecondSteradianPerKilogramPerMeter'),
    (FID: 173160; FStr: 'TMeterCubicSecondSteradianPerKilogram'),
    (FID: 98520; FStr: 'TSquareSecondSteradianPerKilogram'),
    (FID: 119520; FStr: 'TCubicMeterSecondPerMole'),
    (FID: -24480; FStr: 'TMolePerSecondPerAmpere'),
    (FID: -2265; FStr: 'TReciprocalQuarticRootKilogram'),
    (FID: -3020; FStr: 'TReciprocalCubicRootKilogram'),
    (FID: -4530; FStr: 'TReciprocalSquareRootKilogram'),
    (FID: -13590; FStr: 'TReciprocalSquareRootCubicKilogram'),
    (FID: -22650; FStr: 'TReciprocalSquareRootQuinticKilogram'),
    (FID: -27180; FStr: 'TReciprocalCubicKilogram'),
    (FID: -36240; FStr: 'TReciprocalQuarticKilogram'),
    (FID: -45300; FStr: 'TReciprocalQuinticKilogram'),
    (FID: -54360; FStr: 'TReciprocalSexticKilogram'),
    (FID: -9945; FStr: 'TReciprocalQuarticRootMeter'),
    (FID: -13260; FStr: 'TReciprocalCubicRootMeter'),
    (FID: -99450; FStr: 'TReciprocalSquareRootQuinticMeter'),
    (FID: -8715; FStr: 'TReciprocalQuarticRootSecond'),
    (FID: -11620; FStr: 'TReciprocalCubicRootSecond'),
    (FID: -17430; FStr: 'TReciprocalSquareRootSecond'),
    (FID: -52290; FStr: 'TReciprocalSquareRootCubicSecond'),
    (FID: -87150; FStr: 'TReciprocalSquareRootQuinticSecond'),
    (FID: -6075; FStr: 'TReciprocalQuarticRootAmpere'),
    (FID: -8100; FStr: 'TReciprocalCubicRootAmpere'),
    (FID: -12150; FStr: 'TReciprocalSquareRootAmpere'),
    (FID: -36450; FStr: 'TReciprocalSquareRootCubicAmpere'),
    (FID: -60750; FStr: 'TReciprocalSquareRootQuinticAmpere'),
    (FID: -72900; FStr: 'TReciprocalCubicAmpere'),
    (FID: -97200; FStr: 'TReciprocalQuarticAmpere'),
    (FID: -121500; FStr: 'TReciprocalQuinticAmpere'),
    (FID: -145800; FStr: 'TReciprocalSexticAmpere'),
    (FID: -4755; FStr: 'TReciprocalQuarticRootKelvin'),
    (FID: -6340; FStr: 'TReciprocalCubicRootKelvin'),
    (FID: -9510; FStr: 'TReciprocalSquareRootKelvin'),
    (FID: -28530; FStr: 'TReciprocalSquareRootCubicKelvin'),
    (FID: -47550; FStr: 'TReciprocalSquareRootQuinticKelvin'),
    (FID: -95100; FStr: 'TReciprocalQuinticKelvin'),
    (FID: -114120; FStr: 'TReciprocalSexticKelvin'),
    (FID: -8670; FStr: 'TReciprocalQuarticRootMole'),
    (FID: -11560; FStr: 'TReciprocalCubicRootMole'),
    (FID: -17340; FStr: 'TReciprocalSquareRootMole'),
    (FID: -52020; FStr: 'TReciprocalSquareRootCubicMole'),
    (FID: -69360; FStr: 'TReciprocalSquareMole'),
    (FID: -86700; FStr: 'TReciprocalSquareRootQuinticMole'),
    (FID: -104040; FStr: 'TReciprocalCubicMole'),
    (FID: -138720; FStr: 'TReciprocalQuarticMole'),
    (FID: -173400; FStr: 'TReciprocalQuinticMole'),
    (FID: -208080; FStr: 'TReciprocalSexticMole'),
    (FID: -9990; FStr: 'TReciprocalQuarticRootCandela'),
    (FID: -13320; FStr: 'TReciprocalCubicRootCandela'),
    (FID: -19980; FStr: 'TReciprocalSquareRootCandela'),
    (FID: -59940; FStr: 'TReciprocalSquareRootCubicCandela'),
    (FID: -79920; FStr: 'TReciprocalSquareCandela'),
    (FID: -99900; FStr: 'TReciprocalSquareRootQuinticCandela'),
    (FID: -119880; FStr: 'TReciprocalCubicCandela'),
    (FID: -159840; FStr: 'TReciprocalQuarticCandela'),
    (FID: -199800; FStr: 'TReciprocalQuinticCandela'),
    (FID: -239760; FStr: 'TReciprocalSexticCandela'),
    (FID: -9465; FStr: 'TReciprocalQuarticRootSteradian'),
    (FID: -12620; FStr: 'TReciprocalCubicRootSteradian'),
    (FID: -18930; FStr: 'TReciprocalSquareRootSteradian'),
    (FID: -56790; FStr: 'TReciprocalSquareRootCubicSteradian'),
    (FID: -75720; FStr: 'TReciprocalSquareSteradian'),
    (FID: -94650; FStr: 'TReciprocalSquareRootQuinticSteradian'),
    (FID: -113580; FStr: 'TReciprocalCubicSteradian'),
    (FID: -151440; FStr: 'TReciprocalQuarticSteradian'),
    (FID: -189300; FStr: 'TReciprocalQuinticSteradian'),
    (FID: -227160; FStr: 'TReciprocalSexticSteradian'),
    (FID: -97680; FStr: 'TReciprocalSquareKilogramSquareMeter'),
    (FID: 121320; FStr: 'TQuarticSecondPerSquareKilogram'),
    (FID: -64080; FStr: 'TReciprocalMeterAmpere'),
    (FID: 49320; FStr: 'TCubicSecondAmperePerSquareMeter'),
    (FID: 98640; FStr: 'TSexticSecondSquareAmperePerQuarticMeter'),
    (FID: 239640; FStr: 'TSexticSecondSquareAmperePerSquareKilogram'),
    (FID: -128640; FStr: 'TSquareAmperePerSquareKilogramPerQuarticMeter'),
    (FID: 31920; FStr: 'TSexticSecondPerSquareKilogramPerQuarticMeter'),
    (FID: -108480; FStr: 'TSquareMeterPerQuarticSecondPerSquareAmpere'),
    (FID: -50820; FStr: 'TKilogramSquareMeterPerQuarticSecond'),
    (FID: -72720; FStr: 'TReciprocalSecondSteradian'),
    (FID: -74820; FStr: 'TReciprocalSecondCandela'),
    (FID: 41520; FStr: 'TCubicMeterPerCandelaPerSteradian'),
    (FID: 46620; FStr: 'TCubicMeterPerSecondPerSteradian'),
    (FID: 44520; FStr: 'TCubicMeterPerSecondPerCandela'),
    (FID:  6840; FStr: 'TSquareMeterPerSecondPerSteradian'),
    (FID:  4740; FStr: 'TSquareMeterPerSecondPerCandela'),
    (FID: 149280; FStr: 'TSquareMeterSquareSecond'),
    (FID: -89400; FStr: 'TSquareSecondPerQuarticMeter'),
    (FID: -168180; FStr: 'TReciprocalKilogramQuarticMeter'),
    (FID: 79680; FStr: 'TSquareSecondKelvinPerKilogram'),
    (FID: 88740; FStr: 'TSquareSecondKelvin'),
    (FID: 144360; FStr: 'TMeterCubicSecond'),
    (FID: 101100; FStr: 'TCubicSecondQuarticKelvinPerSquareMeter'),
    (FID: -12540; FStr: 'TQuarticKelvinPerKilogramPerSquareMeter'),
    (FID: 180660; FStr: 'TCubicSecondQuarticKelvin'),
    (FID: 67020; FStr: 'TQuarticKelvinPerKilogram'),
    (FID: 24840; FStr: 'TSquareSecondMolePerSquareMeter'),
    (FID: 95340; FStr: 'TSquareSecondMolePerKilogram'),
    (FID: -53940; FStr: 'TMolePerKilogramPerSquareMeter'),
    (FID: 43860; FStr: 'TSquareSecondKelvinMolePerSquareMeter'),
    (FID: 114360; FStr: 'TSquareSecondKelvinMolePerKilogram'),
    (FID: -34920; FStr: 'TKelvinMolePerKilogramPerSquareMeter'),
    (FID: 148260; FStr: 'TQuarticSecondSquareAmperePerMeter'),
    (FID:  -240; FStr: 'TSquareAmperePerKilogramPerMeter'),
    (FID: 90600; FStr: 'TQuarticSecondPerKilogramPerMeter'),
    (FID:  9540; FStr: 'TCubicSecondAmperePerCubicMeter'),
    (FID: -104100; FStr: 'TAmperePerKilogramPerCubicMeter'),
    (FID: 44400; FStr: 'TQuarticSecondAmperePerCubicMeter'),
    (FID: 154680; FStr: 'TQuarticSecondAmperePerKilogram'),
    (FID: 54240; FStr: 'TSquareSecondAmperePerMeter'),
    (FID: -19680; FStr: 'TQuarticSecondPerQuarticMeter'),
    (FID: -177240; FStr: 'TReciprocalSquareKilogramQuarticMeter'),
    (FID: -102840; FStr: 'TSquareMeterPerCubicSecondPerCandelaPerSteradian'),
    (FID: -173340; FStr: 'TKilogramPerCubicSecondPerCandelaPerSteradian'),
    (FID: 10800; FStr: 'TKilogramSquareMeterPerCandelaPerSteradian'),
    (FID: -55920; FStr: 'TKilogramSquareMeterPerCubicSecondPerCandela'),
    (FID: 28020; FStr: 'TSquareSecondSteradianPerSquareMeter'),
    (FID: 102660; FStr: 'TCubicSecondSteradianPerMeter'),
    (FID: -10980; FStr: 'TSteradianPerKilogramPerMeter'),
    (FID: 182220; FStr: 'TMeterCubicSecondSteradian'),
    (FID: 68580; FStr: 'TMeterSteradianPerKilogram'),
    (FID: 107580; FStr: 'TSquareSecondSteradian'),
    (FID: 154200; FStr: 'TCubicMeterSecond'),
    (FID: 10380; FStr: 'TMolePerAmpere'),
    (FID: 257760; FStr: 'TSexticSecondSquareAmpere'),
    (FID: -110520; FStr: 'TSquareAmperePerQuarticMeter'),
    (FID: 50040; FStr: 'TSexticSecondPerQuarticMeter'),
    (FID: 30480; FStr: 'TSquareAmperePerSquareKilogram'),
    (FID: 191040; FStr: 'TSexticSecondPerSquareKilogram'),
    (FID: 81480; FStr: 'TCubicMeterPerSteradian'),
    (FID: 79380; FStr: 'TCubicMeterPerCandela'),
    (FID: -3480; FStr: 'TQuarticKelvinPerSquareMeter'),
    (FID: 104400; FStr: 'TSquareSecondMole'),
    (FID: -44880; FStr: 'TMolePerSquareMeter'),
    (FID: 25620; FStr: 'TMolePerKilogram'),
    (FID: 123420; FStr: 'TSquareSecondKelvinMole'),
    (FID: -25860; FStr: 'TKelvinMolePerSquareMeter'),
    (FID: 44640; FStr: 'TKelvinMolePerKilogram'),
    (FID: 163740; FStr: 'TQuarticSecondAmpere'),
    (FID: -182400; FStr: 'TReciprocalCubicSecondCandelaSteradian'),
    (FID: -64980; FStr: 'TSquareMeterPerCubicSecondPerCandela'),
    (FID: -68760; FStr: 'TKilogramPerCandelaPerSteradian'),
    (FID: -135480; FStr: 'TKilogramPerCubicSecondPerCandela'),
    (FID: 48660; FStr: 'TKilogramSquareMeterPerCandela'),
    (FID: -1920; FStr: 'TSteradianPerMeter'),
    (FID: -144540; FStr: 'TReciprocalCubicSecondCandela'),
    (FID: -30900; FStr: 'TKilogramPerCandela')
  );

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

{$IFNDEF ADIMOFF}
  {$ASSERTIONS ON}
{$ENDIF}

function GetStr(AIndex: longint): string;
var
  i: longint;
begin
  for i := Low(Table) to High(Table) do
  begin
    if Table[i].FID = AIndex then
      Exit(Table[i].FStr);
  end;
  result := 'a unknown unit of measurement';
end;

procedure Check(ALeft, ARight: longint); inline;
begin
  if ALeft <> ARight then
  begin
    Assert(FALSE, Format('Wrong units of measurement detected, %s expected but %s found', [GetStr(ALeft), GetStr(ARight)]));
  end;
end;

function CheckEqual(ALeft, ARight: longint): longint; inline;
begin
  if ALeft <> ARight then
  begin
    Assert(FALSE, Format('Wrong units of measurement detected, %s expected but %s found', [GetStr(ALeft), GetStr(ARight)]));
  end;
  result := ALeft;
end;

function CheckSum(ALeft, ARight: longint): longint; inline;
begin
  if ALeft <> ARight then
  begin
    Assert(FALSE, Format('Wrong units of measurement detected, %s expected but %s found', [GetStr(ALeft), GetStr(ARight)]));
  end;
  result := ALeft;
end;

function CheckSub(ALeft, ARight: longint): longint; inline;
begin
  if ALeft <> ARight then
  begin
    Assert(FALSE, Format('Wrong units of measurement detected, "%s" expected but "%s" found', [GetStr(ALeft), GetStr(ARight)]));
  end;
  result := ALeft;
end;

function CheckMul(ALeft, ARight: longint): longint; inline;
begin
  result := ALeft + ARight;
end;

function CheckDiv(ALeft, ARight: longint): longint; inline;
begin
  result := ALeft - ARight;
end;

{$I complexprocs.inc}
{$I matrixprocs.inc}
{$I vectorprocs.inc}
{$I cl3procs.inc}
{$I scalarprocs.inc}
{$I helperprocs.inc}
{$I extraprocs.inc}

{ TUnit }

// Real numbers

class operator TUnit.*(const AQuantity: double; const ASelf: TUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := ASelf.FID;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: double; const ASelf: TUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckDiv(ScalarId, ASelf.FID);
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

// Complex numbers

class operator TUnit.*(const AQuantity: TComplex; const ASelf: TUnit): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckMul(ScalarID, ASelf.FID);
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: TComplex; const ASelf: TUnit): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckDiv(ScalarID, ASelf.FID);
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const ASelf: TUnit; const AQuantity: TComplex): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckMul(ASelf.FID, ScalarID);
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const ASelf: TUnit; const AQuantity: TComplex): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckDiv(ASelf.FID, ScalarID);
  result.FValue := AQuantity.Reciprocal;
{$ELSE}
  result := AQuantity.Reciprocal;
{$ENDIF}
end;

// R3 vector space

class operator TUnit.*(const AQuantity: TR3Vector; const ASelf: TUnit): TR3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := ASelf.FID;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: TR3Vector; const ASelf: TUnit): TR3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckDiv(ScalarId, ASelf.FID);
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

// CL3 vector space, Clifford algebra

class operator TUnit.*(const AQuantity: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := ASelf.FID;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckDiv(ScalarId, ASelf.FID);
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := ASelf.FID;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckDiv(ScalarId, ASelf.FID);
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := ASelf.FID;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckDiv(ScalarId, ASelf.FID);
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := ASelf.FID;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckDiv(ScalarId, ASelf.FID);
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

{$IFNDEF ADIMOFF}

// Real numbers

class operator TUnit.*(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
begin
  result.FID := CheckMul(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
begin
  result.FID := CheckDiv(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue;
end;

// Complex numbers

class operator TUnit.*(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;
begin
  result.FID := CheckMul(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;
begin
  result.FID := CheckDiv(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FID := CheckMul(ASelf.FID, AQuantity.FID);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FID := CheckDiv(ASelf.FID, AQuantity.FID);
  result.FValue := AQuantity.FValue.Reciprocal;
end;

// R3 vector space

class operator TUnit.*(const AQuantity: TR3VecQuantity; const ASelf: TUnit): TR3VecQuantity; inline;
begin
  result.FID := CheckMul(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TR3VecQuantity; const ASelf: TUnit): TR3VecQuantity; inline;
begin
  result.FID := CheckDiv(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue;
end;

// CL3 vector space, Clifford algebra

class operator TUnit.*(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
  result.FID := CheckMul(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
  result.FID := CheckDiv(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
  result.FID := CheckMul(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
  result.FID := CheckDiv(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
  result.FID := CheckMul(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
  result.FID := CheckDiv(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
  result.FID := CheckMul(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
  result.FID := CheckDiv(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue;
end;

{$ENDIF}

{ TFactoredUnit }

// Real numbers

class operator TFactoredUnit.*(const AQuantity: double; const ASelf: TFactoredUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := ASelf.FID;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: double; const ASelf: TFactoredUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckDiv(ScalarId, ASelf.FID);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

// R3 vector space

class operator TFactoredUnit.*(const AQuantity: TR3Vector; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := ASelf.FID;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TR3Vector; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckDiv(ScalarId, ASelf.FID);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

// CL3 vector space, Clifford algebra

class operator TFactoredUnit.*(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := ASelf.FID;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckDiv(ScalarId, ASelf.FID);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := ASelf.FID;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckDiv(ScalarId, ASelf.FID);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := ASelf.FID;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckDiv(ScalarId, ASelf.FID);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := ASelf.FID;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckDiv(ScalarId, ASelf.FID);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

{$IFNDEF ADIMOFF}

// Real numbers

class operator TFactoredUnit.*(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
begin
  result.FID := CheckMul(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
begin
  result.FID := CheckDiv(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

// R3 vector space

class operator TFactoredUnit.*(const AQuantity: TR3VecQuantity; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
begin
  result.FID := CheckMul(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TR3VecQuantity; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
begin
  result.FID := CheckDiv(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

// CL3 vector space, Clifford algebra

class operator TFactoredUnit.*(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
  result.FID := CheckMul(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
  result.FID := CheckDiv(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
  result.FID := CheckMul(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
  result.FID := CheckDiv(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
  result.FID := CheckMul(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
  result.FID := CheckDiv(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
  result.FID := CheckMul(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
  result.FID := CheckDiv(AQuantity.FID, ASelf.FID);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

{$ENDIF}

{ TDegreeCelsiusUnit }

class operator TDegreeCelsiusUnit.*(const AQuantity: double; const ASelf: TDegreeCelsiusUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := ASelf.FID;
  result.FValue := AQuantity + 273.15;
{$ELSE}
  result := AQuantity + 273.15;
{$ENDIF}
end;

{ TDegreeFahrenheitUnit }

class operator TDegreeFahrenheitUnit.*(const AQuantity: double; const ASelf: TDegreeFahrenheitUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FID := ASelf.FID;
  result.FValue := 5/9 * (AQuantity - 32) + 273.15;
{$ELSE}
  result := 5/9 * (AQuantity - 32) + 273.15;
{$ENDIF}
end;

{ TUnitHelper }

function TUnitHelper.GetName(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(FPrefixes) of
    0: result := FName;
    1: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name]);
    2: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name]);
    3: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TUnitHelper.GetPluralName(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0: result := FPluralName;
    1: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name]);
    2: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name]);
    3: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TUnitHelper.GetSymbol(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0:  result := FSymbol;
    1:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol]);
    2:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol]);
    3:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol,
          PrefixTable[Prefixes[2]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TUnitHelper.GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
var
  I: longint;
  Exponent: longint;
  PrefixCount: longint;
begin
  PrefixCount := Length(APrefixes);
  if PrefixCount = Length(FPrefixes) then
  begin
    Exponent := 0;
    for I := 0 to PrefixCount -1 do
      Inc(Exponent, PrefixTable[FPrefixes[I]].Exponent * FExponents[I]);

    for I := 0 to PrefixCount -1 do
      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * FExponents[I]);

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

// Real numbers

function TUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := FloatToStr(AQuantity.FValue) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;

function TUnitHelper.ToVerboseString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  if (AQuantity.FValue > -1) and (AQuantity.FValue < 1) then
    result := FloatToStr(AQuantity.FValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(AQuantity.FValue) + ' ' + GetPluralName(FPrefixes);
{$ELSE}
  if (AQuantity > -1) and (AQuantity < 1) then
    result := FloatToStr(AQuantity) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(AQuantity) + ' ' + GetPluralName(FPrefixes);
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(FPRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPRefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(APRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TUnitHelper.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(FPRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(FPRefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(APRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TUnitHelper.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

// Complex numbers

function TUnitHelper.ToComplex(const AQuantity: TComplexQuantity): TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TComplexQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TComplexQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetName(FPrefixes)
{$ENDIF}
end;

// Complex matrix

function TUnitHelper.ToString(const AQuantity: TC2MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC2MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

// R3 vector space

function TUnitHelper.ToString(const AQuantity: TC2VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC2VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TR3VecQuantity): TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

// CL3 vector space, Clifford algebra

function TUnitHelper.ToString(const AQuantity: TCL3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3BivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3TrivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3MultivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3BivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

{ TFactoredUnitHelper }

function TFactoredUnitHelper.GetName(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0:  result := FName;
    1:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TFactoredUnitHelper.GetPluralName(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0:  result := FPluralName;
    1:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TFactoredUnitHelper.GetSymbol(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0:  result := FSymbol;
    1:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol]);
    2:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol]);
    3:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol,
          PrefixTable[Prefixes[2]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TFactoredUnitHelper.GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
var
  I: longint;
  Exponent: longint;
  PrefixCount: longint;
begin
  PrefixCount := Length(APrefixes);
  if PrefixCount = Length(FPrefixes) then
  begin
    Exponent := 0;
    for I := 0 to PrefixCount -1 do
      Inc(Exponent, PrefixTable[FPrefixes[I]].Exponent * FExponents[I]);

    for I := 0 to PrefixCount -1 do
      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * FExponents[I]);

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

// Real numbers

function TFactoredUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := FloatToStr(AQuantity.FValue / FFactor) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity / FFactor) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
   Check(FID, AQuantity.FID);
   FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
   FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TQuantity): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(APRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(APRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

// Complex numbers

function TFactoredUnitHelper.ToString(const AQuantity: TComplexQuantity): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TComplexQuantity): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetName(FPrefixes)
end;

// R3 vector space

function TFactoredUnitHelper.ToString(const AQuantity: TR3VecQuantity): string;
var
  FactoredValue: TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR3VecQuantity): string;
var
  FactoredValue: TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetName(FPrefixes)
end;

// CL3 vector space, Cliffor algebra

function TFactoredUnitHelper.ToString(const AQuantity: TCL3VecQuantity): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3BivecQuantity): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3TrivecQuantity): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3MultivecQuantity): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3VecQuantity): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3BivecQuantity): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetName(FPrefixes)
end;

{ TDegreeCelsiusUnitHelper }

function TDegreeCelsiusUnitHelper.GetName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FName;
    1:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TDegreeCelsiusUnitHelper.GetPluralName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FPluralName;
    1:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TDegreeCelsiusUnitHelper.GetSymbol(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FSymbol;
    1:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol]);
    2:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol]);
    3:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol,
          PrefixTable[Prefixes[2]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TDegreeCelsiusUnitHelper.GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
var
  I: longint;
  Exponent: longint;
  PrefixCount: longint;
begin
  PrefixCount := Length(APrefixes);
  if PrefixCount = Length(FPrefixes) then
  begin
    Exponent := 0;
    for I := 0 to PrefixCount -1 do
      Inc(Exponent, PrefixTable[FPrefixes[I]].Exponent * FExponents[I]);

    for I := 0 to PrefixCount -1 do
      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * FExponents[I]);

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

function TDegreeCelsiusUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := AQuantity.FValue - 273.15;
{$ELSE}
  result := AQuantity - 273.15;
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  result := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := FloatToStr(AQuantity.FValue - 273.15) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity - 273.15) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TQuantity): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := AQuantity.FValue - 273.15;
{$ELSE}
  FactoredValue := AQuantity - 273.15;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(APRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(APRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

{ TDegreeFahrenheitUnitHelper }

function TDegreeFahrenheitUnitHelper.GetName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FName;
    1:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TDegreeFahrenheitUnitHelper.GetPluralName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FPluralName;
    1:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TDegreeFahrenheitUnitHelper.GetSymbol(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FSymbol;
    1:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol]);
    2:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol]);
    3:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol,
          PrefixTable[Prefixes[2]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TDegreeFahrenheitUnitHelper.GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
var
  I: longint;
  Exponent: longint;
  PrefixCount: longint;
begin
  PrefixCount := Length(APrefixes);
  if PrefixCount = Length(FPrefixes) then
  begin
    Exponent := 0;
    for I := 0 to PrefixCount -1 do
      Inc(Exponent, PrefixTable[FPrefixes[I]].Exponent * FExponents[I]);

    for I := 0 to PrefixCount -1 do
      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * FExponents[I]);

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

function TDegreeFahrenheitUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := 9/5 * AQuantity.FValue - 459.67;
{$ELSE}
  result := 9/5 * AQuantity - 459.67;
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  result := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  result := FloatToStr(9/5 * AQuantity.FValue - 459.67) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(9/5 * AQuantity - 459.67) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
  FactoredTol   := GetValue(9/5 * ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
  FactoredTol   := GetValue(9/5 * ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TQuantity): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := 9/5 * AQuantity.FValue - 459.67;
{$ELSE}
  FactoredValue := 9/5 * AQuantity - 459.67;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(APRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(APRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FID, AQuantity.FID);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
  FactoredTol   := GetValue(9/5 * ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
  FactoredTol   := GetValue(9/5 * ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

{ Power functions }

function SquarePower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := AQuantity.FID * 2;
  result.FValue := IntPower(AQuantity.FValue, 2);
{$ELSE}
  result := IntPower(AQuantity, 2);
{$ENDIF}
end;

function CubicPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := AQuantity.FID * 3;
  result.FValue := IntPower(AQuantity.FValue, 3);
{$ELSE}
  result := IntPower(AQuantity, 3);
{$ENDIF}
end;

function QuarticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := AQuantity.FID * 4;
  result.FValue := IntPower(AQuantity.FValue, 4);
{$ELSE}
  result := IntPower(AQuantity, 4);
{$ENDIF}
end;

function QuinticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := AQuantity.FID * 5;
  result.FValue := IntPower(AQuantity.FValue, 5);
{$ELSE}
  result := IntPower(AQuantity, 5);
{$ENDIF}
end;

function SexticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := AQuantity.FID * 6;
  result.FValue := IntPower(AQuantity.FValue, 6);
{$ELSE}
  result := IntPower(AQuantity, 6);
{$ENDIF}
end;

function SquareRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := AQuantity.FID div 2;
  result.FValue := Power(AQuantity.FValue, 1/2);
{$ELSE};
  result := Power(AQuantity, 1/2);
{$ENDIF}
end;

function CubicRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := AQuantity.FID div 3;
  result.FValue := Power(AQuantity.FValue, 1/3);
{$ELSE}
  result := Power(AQuantity, 1/3);
{$ENDIF}
end;

function QuarticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := AQuantity.FID div 4;
  result.FValue := Power(AQuantity.FValue, 1/4);
{$ELSE}
  result := Power(AQuantity, 1/4);
{$ENDIF}
end;

function QuinticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := AQuantity.FID div 5;
  result.FValue := Power(AQuantity.FValue, 1/5);
{$ELSE}
  result := Power(AQuantity, 1/5);
{$ENDIF}
end;

function SexticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := AQuantity.FID div 6;
  result.FValue := Power(AQuantity.FValue, 1/6);
{$ELSE}
  result := Power(AQuantity, 1/6);
{$ENDIF}
end;

{ Trigonometric functions }

function Cos(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarId, AQuantity.FID);
  result := System.Cos(AQuantity.FValue);
{$ELSE}
  result := System.Cos(AQuantity);
{$ENDIF}
end;

function Sin(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarId, AQuantity.FID);
  result := System.Sin(AQuantity.FValue);
{$ELSE}
  result := System.Sin(AQuantity);
{$ENDIF}
end;

function Tan(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarId, AQuantity.FID);
  result := Math.Tan(AQuantity.FValue);
{$ELSE}
  result := Math.Tan(AQuantity);
{$ENDIF}
end;

function Cotan(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarId, AQuantity.FID);
  result := Math.Cotan(AQuantity.FValue);
{$ELSE}
  result := Math.Cotan(AQuantity);
{$ENDIF}
end;

function Secant(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarId, AQuantity.FID);
  result := Math.Secant(AQuantity.FValue);
{$ELSE}
  result := Math.Secant(AQuantity);
{$ENDIF}
end;

function Cosecant(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarId, AQuantity.FID);
  result := Math.Cosecant(AQuantity.FValue);
{$ELSE}
  result := Math.Cosecant(AQuantity);
{$ENDIF}
end;

function ArcCos(const AValue: double): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := ScalarId;
  result.FValue := Math.ArcCos(AValue);
{$ELSE}
  result := Math.ArcCos(AValue);
{$ENDIF}
end;

function ArcSin(const AValue: double): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := ScalarId;
  result.FValue := Math.ArcSin(AValue);
{$ELSE}
  result := Math.ArcSin(AValue);
{$ENDIF}
end;

function ArcTan(const AValue: double): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := ScalarId;
  result.FValue := System.ArcTan(AValue);
{$ELSE}
  result := System.ArcTan(AValue);
{$ENDIF}
end;

function ArcTan2(const x, y: double): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := ScalarId;
  result.FValue := Math.ArcTan2(x, y);
{$ELSE}
  result := Math.ArcTan2(x, y);
{$ENDIF}
end;

{ Math functions }

function Min(const ALeft, ARight: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := Math.Min(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.Min(ALeft, ARight);
{$ENDIF}
end;

function Max(const ALeft, ARight: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := Math.Max(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.Max(ALeft, ARight);
{$ENDIF}
end;

function Exp(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FID := CheckSum(AQuantity.FID, ScalarId);
  result.FValue := System.Exp(AQuantity.FValue);
{$ELSE}
  result := System.Exp(AQuantity);
{$ENDIF}
end;

function Log10(const AQuantity : TQuantity) : double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarId, AQuantity.FID);
  result := Math.Log10(AQuantity.FValue);
{$ELSE}
  result := Math.Log10(AQuantity);
{$ENDIF}
end;

function Log2(const AQuantity : TQuantity) : double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarId, AQuantity.FID);
  result := Math.Log2(AQuantity.FValue);
{$ELSE}
  result := Math.Log2(AQuantity);
{$ENDIF}
end;

function LogN(ABase: longint; const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarId, AQuantity.FID);
  result := Math.LogN(ABase, AQuantity.FValue);
{$ELSE}
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function LogN(const ABase, AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ABase.FID, ScalarId);
  Check(ScalarId, AQuantity.FID);
  result := Math.LogN(ABase.FValue, AQuantity.FValue);
{$ELSE}
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function Power(const ABase: TQuantity; AExponent: double): double;
begin
{$IFNDEF ADIMOFF}
  Check(ABase.FID, ScalarId);
  result := Math.Power(ABase.FValue, AExponent);
{$ELSE}
  result := Math.Power(ABase, AExponent);
{$ENDIF}
end;

{ Helper functions }

function LessThanOrEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue <= 0;
{$ELSE}
  result := AQuantity <= 0;
{$ENDIF}
end;

function LessThanZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue < 0;
{$ELSE}
  result := AQuantity < 0;
{$ENDIF}
end;

function EqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue = 0;
{$ELSE}
  result := AQuantity = 0;
{$ENDIF}
end;

function NotEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue <> 0;
{$ELSE}
  result := AQuantity <> 0;
{$ENDIF}
end;

function GreaterThanOrEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue >= 0;
{$ELSE}
  result := AQuantity >= 0;
{$ENDIF}
end;

function GreaterThanZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue > 0;
{$ELSE}
  result := AQuantity > 0;
{$ENDIF}
end;

end.
