        ��  ��                  �      �� ��               <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">
 <assemblyIdentity version="1.0.0.0" processorArchitecture="*" name="CompanyName.ProductName.AppName" type="win32"/>
 <description>Your application description.</description>
 <dependency>
  <dependentAssembly>
   <assemblyIdentity type="win32" name="Microsoft.Windows.Common-Controls" version="6.0.0.0" processorArchitecture="*" publicKeyToken="6595b64144ccf1df" language="*"/>
  </dependentAssembly>
 </dependency>
 <trustInfo xmlns="urn:schemas-microsoft-com:asm.v3">
  <security>
   <requestedPrivileges>
    <requestedExecutionLevel level="asInvoker" uiAccess="false"/>
   </requestedPrivileges>
  </security>
 </trustInfo>
 <compatibility xmlns="urn:schemas-microsoft-com:compatibility.v1">
  <application>
   <!-- Windows Vista -->
   <supportedOS Id="{e2011457-1546-43c5-a5fe-008deee3d3f0}" />
   <!-- Windows 7 -->
   <supportedOS Id="{35138b9a-5d96-4fbd-8e2d-a2440225f93a}" />
   <!-- Windows 8 -->
   <supportedOS Id="{4a2f28e3-53b9-4441-ba9c-d69d4a4a6e38}" />
   <!-- Windows 8.1 -->
   <supportedOS Id="{1f676c76-80e1-4239-95bb-83d0f6d0da78}" />
   <!-- Windows 10 -->
   <supportedOS Id="{8e0f7a12-bfb3-4fe8-b9a5-48fd50a15a9a}" />
   </application>
  </compatibility>
 <asmv3:application xmlns:asmv3="urn:schemas-microsoft-com:asm.v3">
  <asmv3:windowsSettings xmlns="http://schemas.microsoft.com/SMI/2005/WindowsSettings">
   <dpiAware>True</dpiAware>
  </asmv3:windowsSettings>
  <asmv3:windowsSettings xmlns="http://schemas.microsoft.com/SMI/2016/WindowsSettings">
   
   <longPathAware>false</longPathAware>
   
  </asmv3:windowsSettings>
 </asmv3:application>
</assembly>   0   �� M A I N I C O N                              �     <   ��
 C L 0 0 - S E C T I O N - A 0                 {
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
 {  <   ��
 C L 0 0 - S E C T I O N - A 1                 
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

 �  <   ��
 C L 0 0 - S E C T I O N - A 4                 { Power functions }

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

   <   ��
 C L 0 0 - S E C T I O N - B 0                 implementation

uses Math;�l  <   ��
 C L 0 0 - S E C T I O N - B 1                 
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

  ,  <   ��
 C L 0 0 - S E C T I O N - B 4                 
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

  <   ��
 C L 1 3 - S E C T I O N - A 0                 {
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
�  <   ��
 C L 1 3 - S E C T I O N - A 1                 
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

  {$IFDEF USEADIM}
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
  end;
  {$ELSE}
  TQuantity = double;
  {$ENDIF}

  { TUnit }

  generic TUnit<U> = record
    type TSelf = specialize TUnit<U>;
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AValue: double; const APrefixes: TPrefixes): double;
  public
    procedure Check(var AQuantity: TQuantity);
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
  {$IFDEF USEADIM}
    class operator *(const AQuantity: TQuantity; const ASelf: TSelf): TQuantity; inline;
    class operator /(const AQuantity: TQuantity; const ASelf: TSelf): TQuantity; inline;
  {$ENDIF}
  end;

  { TFactoredUnit }

  generic TFactoredUnit<U> = record
    type TSelf = specialize TFactoredUnit<U>;
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AValue: double; const APrefixes: TPrefixes): double;
  public
    procedure Check(var AQuantity: TQuantity);
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
  {$IFDEF USEADIM}
    class operator *(const AQuantity: TQuantity; const ASelf: TSelf): TQuantity; inline;
    class operator /(const AQuantity: TQuantity; const ASelf: TSelf): TQuantity; inline;
  {$ENDIF}
  end;

   1  <   ��
 C L 1 3 - S E C T I O N - A 4                 { Power functions }

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
function SameValue(const ALeft, ARight: TQuantity): boolean;

{ Constants }

const
  AvogadroConstant               : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cReciprocalMole;                     FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}
  BohrMagneton                   : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cSquareMeterAmpere;                  FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}
  BohrRadius                     : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeter;                              FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}
  BoltzmannConstant              : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cJoulePerKelvin;                     FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}
  ComptonWaveLength              : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeter;                              FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}
  CoulombConstant                : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cNewtonSquareMeterPerSquareCoulomb;  FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}
  DeuteronMass                   : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}
  ElectricPermittivity           : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cFaradPerMeter;                      FValue:     8.8541878128E-12); {$ELSE} (    8.8541878128E-12); {$ENDIF}
  ElectronMass                   : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}
  ElectronCharge                 : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cCoulomb;                            FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}
  MagneticPermeability           : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cHenryPerMeter;                      FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}
  MolarGasConstant               : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cJoulePerMolePerKelvin;              FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}
  NeutronMass                    : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}
  NewtonianConstantOfGravitation : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cNewtonSquareMeterPerSquareKilogram; FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}
  PlanckConstant                 : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogramSquareMeterPerSecond;       FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}
  ProtonMass                     : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}
  RydbergConstant                : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cReciprocalMeter;                    FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}
  SpeedOfLight                   : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeterPerSecond;                     FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}
  SquaredSpeedOfLight            : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cSquareMeterPerSquareSecond;         FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}
  StandardAccelerationOfGravity  : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeterPerSquareSecond;               FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}
  ReducedPlanckConstant          : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogramSquareMeterPerSecond;       FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}
  UnifiedAtomicMassUnit          : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}

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

      <   ��
 C L 1 3 - S E C T I O N - B 0                 implementation

uses Math;�l  <   ��
 C L 1 3 - S E C T I O N - B 1                 
{ TQuantity }

{$IFDEF USEADIM}
class operator TQuantity.:=(const ASelf: double): TQuantity;
begin
  result.FUnitOfMeasurement := cScalar;
  result.FValue := ASelf;
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
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TQuantity.<(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('LessThan operator (<) has detected wrong unit of measurements.');

  result := ALeft.FValue < ARight.FValue;
end;

class operator TQuantity.>(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('GreaterThan operator (>) has detected wrong unit of measurements.');

  result := ALeft.FValue > ARight.FValue;
end;

class operator TQuantity.<=(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('LessThanOrEqual operator (<=) has detected wrong unit of measurements.');
    
  result := ALeft.FValue <= ARight.FValue;
end;

class operator TQuantity.>=(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('GreaterThanOrEqual operator (>=) has detected wrong unit of measurements.');
    
  result := ALeft.FValue >= ARight.FValue;
end;

class operator TQuantity.<>(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;
{$ENDIF}

{ TUnit }

class operator TUnit.*(const AValue: double; const ASelf: TUnit): TQuantity; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := U.FUnitOfMeasurement;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: double; const ASelf: TUnit): TQuantity; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

{$IFDEF USEADIM}
class operator TUnit.*(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
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

function TUnit.GetValue(const AValue: double; const APrefixes: TPrefixes): double;
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
      result := AValue * IntPower(10, Exponent)
    else
      result := AValue;

  end else
    if PrefixCount = 0 then
      result := AValue
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

procedure TUnit.Check(var AQuantity: TQuantity);
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TUnit.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnit.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}  
end;

function TUnit.ToString(const AQuantity: TQuantity): string;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(AQuantity.FValue) + ' ' + GetSymbol(U.FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity) + ' ' + GetSymbol(U.FPrefixes);
{$ENDIF}
end;

function TUnit.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
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

function TUnit.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TUnit.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TUnit.ToVerboseString(const AQuantity: TQuantity): string;
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

function TUnit.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
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

function TUnit.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TUnit.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

class operator TFactoredUnit.*(const AValue: double; const ASelf: TFactoredUnit): TQuantity; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := U.FUnitOfMeasurement;
  result.FValue := U.PutValue(AValue);
{$ELSE}
  result := U.PutValue(AValue);
{$ENDIF}
end;

class operator TFactoredUnit./(const AValue: double; const ASelf: TFactoredUnit): TQuantity; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := U.PutValue(AValue);
{$ELSE}
  result := U.PutValue(AValue);
{$ENDIF}
end;

{$IFDEF USEADIM}
class operator TFactoredUnit.*(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := U.PutValue(AQuantity.FValue);
end;

class operator TFactoredUnit./(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
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

function TFactoredUnit.GetValue(const AValue: double; const APrefixes: TPrefixes): double;
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
      result := AValue * IntPower(10, Exponent)
    else
      result := AValue;

  end else
    if PrefixCount = 0 then
      result := AValue
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

procedure TFactoredUnit.Check(var AQuantity: TQuantity);
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TFactoredUnit.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := U.GetValue(AQuantity.FValue);
{$ELSE}
  result := U.GetValue(AQuantity);
{$ENDIF}  
end;

function TFactoredUnit.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(U.GetValue(AQuantity.FValue), APrefixes);
{$ELSE}
  result := GetValue(U.GetValue(AQuantity), APrefixes);
{$ENDIF}  
end;

function TFactoredUnit.ToString(const AQuantity: TQuantity): string;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(U.GetValue(AQuantity.FValue)) + ' ' + GetSymbol(U.FPrefixes);
{$ELSE}
  result := FloatToStr(U.GetValue(AQuantity)) + ' ' + GetSymbol(U.FPrefixes);
{$ENDIF}
end;

function TFactoredUnit.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToVerboseString(const AQuantity: TQuantity): string;
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

function TFactoredUnit.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

  ,  <   ��
 C L 1 3 - S E C T I O N - B 4                 
{ Power functions }

function SquarePower(const AQuantity: TQuantity): TQuantity;
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

function CubicPower(const AQuantity: TQuantity): TQuantity;
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

function QuarticPower(const AQuantity: TQuantity): TQuantity;
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

function QuinticPower(const AQuantity: TQuantity): TQuantity;
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

function SexticPower(const AQuantity: TQuantity): TQuantity;
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

function SquareRoot(const AQuantity: TQuantity): TQuantity;
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

function CubicRoot(const AQuantity: TQuantity): TQuantity;
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

function QuarticRoot(const AQuantity: TQuantity): TQuantity;
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

function QuinticRoot(const AQuantity: TQuantity): TQuantity;
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

function SexticRoot(const AQuantity: TQuantity): TQuantity;
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

function Cos(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Cos routine has detected wrong units of measurements.');

  result := System.Cos(AQuantity.FValue);
{$ELSE}
  result := System.Cos(AQuantity);
{$ENDIF}
end;

function Sin(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Sin routine has detected wrong units of measurements.');

  result := System.Sin(AQuantity.FValue);
{$ELSE}
  result := System.Sin(AQuantity);
{$ENDIF}
end;

function Tan(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Tan routine has detected wrong units of measurements.');

  result := Math.Tan(AQuantity.FValue);
{$ELSE}
  result := Math.Tan(AQuantity);
{$ENDIF}
end;

function Cotan(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Cotan routine has detected wrong units of measurements.');

  result := Math.Cotan(AQuantity.FValue);
{$ELSE}
  result := Math.Cotan(AQuantity);
{$ENDIF}
end;

function Secant(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Setan routine has detected wrong units of measurements.');

  result := Math.Secant(AQuantity.FValue);
{$ELSE}
  result := Math.Secant(AQuantity);
{$ENDIF}
end;

function Cosecant(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Cosecant routine has detected wrong units of measurements.');

  result := Math.Cosecant(AQuantity.FValue);
{$ELSE}
  result := Math.Cosecant(AQuantity);
{$ENDIF}
end;

function ArcCos(const AValue: double): TQuantity;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcCos(AValue);
{$ELSE}
  result := Math.ArcCos(AValue);
{$ENDIF}
end;

function ArcSin(const AValue: double): TQuantity;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcSin(AValue);
{$ELSE}
  result := Math.ArcSin(AValue);
{$ENDIF}
end;

function ArcTan(const AValue: double): TQuantity;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := System.ArcTan(AValue);
{$ELSE}
  result := System.ArcTan(AValue);
{$ENDIF}
end;

function ArcTan2(const x, y: double): TQuantity;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcTan2(x, y);
{$ELSE}
  result := Math.ArcTan2(x, y);
{$ENDIF}
end;

{ Math functions }


function Min(const ALeft, ARight: TQuantity): TQuantity;
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

function Max(const ALeft, ARight: TQuantity): TQuantity;
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

function Exp(const AQuantity: TQuantity): TQuantity;
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

function Log10(const AQuantity : TQuantity) : double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Log10 routine has detected wrong units of measurements.');

  result := Math.Log10(AQuantity.FValue);
{$ELSE}  
  result := Math.Log10(AQuantity);
{$ENDIF}
end;

function Log2(const AQuantity : TQuantity) : double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Log2 routine has detected wrong units of measurements.');

  result := Math.Log2(AQuantity.FValue);
{$ELSE} 
  result := Math.Log2(AQuantity);
{$ENDIF}
end;

function LogN(ABase: longint; const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  result := Math.LogN(ABase, AQuantity.FValue);
{$ELSE} 
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function LogN(const ABase, AQuantity: TQuantity): double;
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

function Power(const ABase: TQuantity; AExponent: double): double;
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

function LessThanOrEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue <= 0;
{$ELSE}  
  result := AQuantity <= 0;
{$ENDIF}
end;

function LessThanZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue < 0;
{$ELSE}  
  result := AQuantity < 0;
{$ENDIF}
end;

function EqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue = 0;
{$ELSE} 
  result := AQuantity = 0;
{$ENDIF}
end;

function NotEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue <> 0;
{$ELSE}
  result := AQuantity <> 0;
{$ENDIF}
end;

function GreaterThanOrEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue >= 0;
{$ELSE}
  result := AQuantity >= 0;
{$ENDIF}
end;

function GreaterThanZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue > 0;
{$ELSE}
  result := AQuantity > 0;
{$ENDIF}
end;

function SameValue(const ALeft, ARight: TQuantity): boolean;
begin
{$IFDEF USEADIM}
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('SameValue routine has detected wrong units of measurements.');

  result := Math.SameValue(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.SameValue(ALeft, ARight);
{$ENDIF}
end;

     <   ��
 C L 2 0 - S E C T I O N - A 0                 {
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
�  <   ��
 C L 2 0 - S E C T I O N - A 1                 
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

  {$IFDEF USEADIM}
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
  end;
  {$ELSE}
  TQuantity = double;
  {$ENDIF}

  { TUnit }

  generic TUnit<U> = record
    type TSelf = specialize TUnit<U>;
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AValue: double; const APrefixes: TPrefixes): double;
  public
    procedure Check(var AQuantity: TQuantity);
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
  {$IFDEF USEADIM}
    class operator *(const AQuantity: TQuantity; const ASelf: TSelf): TQuantity; inline;
    class operator /(const AQuantity: TQuantity; const ASelf: TSelf): TQuantity; inline;
  {$ENDIF}
  end;

  { TFactoredUnit }

  generic TFactoredUnit<U> = record
    type TSelf = specialize TFactoredUnit<U>;
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AValue: double; const APrefixes: TPrefixes): double;
  public
    procedure Check(var AQuantity: TQuantity);
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
  {$IFDEF USEADIM}
    class operator *(const AQuantity: TQuantity; const ASelf: TSelf): TQuantity; inline;
    class operator /(const AQuantity: TQuantity; const ASelf: TSelf): TQuantity; inline;
  {$ENDIF}
  end;

   1  <   ��
 C L 2 0 - S E C T I O N - A 4                 { Power functions }

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
function SameValue(const ALeft, ARight: TQuantity): boolean;

{ Constants }

const
  AvogadroConstant               : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cReciprocalMole;                     FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}
  BohrMagneton                   : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cSquareMeterAmpere;                  FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}
  BohrRadius                     : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeter;                              FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}
  BoltzmannConstant              : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cJoulePerKelvin;                     FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}
  ComptonWaveLength              : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeter;                              FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}
  CoulombConstant                : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cNewtonSquareMeterPerSquareCoulomb;  FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}
  DeuteronMass                   : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}
  ElectricPermittivity           : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cFaradPerMeter;                      FValue:     8.8541878128E-12); {$ELSE} (    8.8541878128E-12); {$ENDIF}
  ElectronMass                   : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}
  ElectronCharge                 : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cCoulomb;                            FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}
  MagneticPermeability           : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cHenryPerMeter;                      FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}
  MolarGasConstant               : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cJoulePerMolePerKelvin;              FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}
  NeutronMass                    : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}
  NewtonianConstantOfGravitation : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cNewtonSquareMeterPerSquareKilogram; FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}
  PlanckConstant                 : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogramSquareMeterPerSecond;       FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}
  ProtonMass                     : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}
  RydbergConstant                : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cReciprocalMeter;                    FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}
  SpeedOfLight                   : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeterPerSecond;                     FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}
  SquaredSpeedOfLight            : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cSquareMeterPerSquareSecond;         FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}
  StandardAccelerationOfGravity  : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeterPerSquareSecond;               FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}
  ReducedPlanckConstant          : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogramSquareMeterPerSecond;       FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}
  UnifiedAtomicMassUnit          : TQuantity = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}

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

      <   ��
 C L 2 0 - S E C T I O N - B 0                 implementation

uses Math;�l  <   ��
 C L 2 0 - S E C T I O N - B 1                 
{ TQuantity }

{$IFDEF USEADIM}
class operator TQuantity.:=(const ASelf: double): TQuantity;
begin
  result.FUnitOfMeasurement := cScalar;
  result.FValue := ASelf;
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
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TQuantity.<(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('LessThan operator (<) has detected wrong unit of measurements.');

  result := ALeft.FValue < ARight.FValue;
end;

class operator TQuantity.>(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('GreaterThan operator (>) has detected wrong unit of measurements.');

  result := ALeft.FValue > ARight.FValue;
end;

class operator TQuantity.<=(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('LessThanOrEqual operator (<=) has detected wrong unit of measurements.');
    
  result := ALeft.FValue <= ARight.FValue;
end;

class operator TQuantity.>=(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('GreaterThanOrEqual operator (>=) has detected wrong unit of measurements.');
    
  result := ALeft.FValue >= ARight.FValue;
end;

class operator TQuantity.<>(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;
{$ENDIF}

{ TUnit }

class operator TUnit.*(const AValue: double; const ASelf: TUnit): TQuantity; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := U.FUnitOfMeasurement;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: double; const ASelf: TUnit): TQuantity; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

{$IFDEF USEADIM}
class operator TUnit.*(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
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

function TUnit.GetValue(const AValue: double; const APrefixes: TPrefixes): double;
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
      result := AValue * IntPower(10, Exponent)
    else
      result := AValue;

  end else
    if PrefixCount = 0 then
      result := AValue
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

procedure TUnit.Check(var AQuantity: TQuantity);
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TUnit.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnit.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}  
end;

function TUnit.ToString(const AQuantity: TQuantity): string;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(AQuantity.FValue) + ' ' + GetSymbol(U.FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity) + ' ' + GetSymbol(U.FPrefixes);
{$ENDIF}
end;

function TUnit.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
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

function TUnit.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TUnit.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TUnit.ToVerboseString(const AQuantity: TQuantity): string;
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

function TUnit.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
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

function TUnit.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TUnit.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

class operator TFactoredUnit.*(const AValue: double; const ASelf: TFactoredUnit): TQuantity; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := U.FUnitOfMeasurement;
  result.FValue := U.PutValue(AValue);
{$ELSE}
  result := U.PutValue(AValue);
{$ENDIF}
end;

class operator TFactoredUnit./(const AValue: double; const ASelf: TFactoredUnit): TQuantity; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := U.PutValue(AValue);
{$ELSE}
  result := U.PutValue(AValue);
{$ENDIF}
end;

{$IFDEF USEADIM}
class operator TFactoredUnit.*(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := U.PutValue(AQuantity.FValue);
end;

class operator TFactoredUnit./(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
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

function TFactoredUnit.GetValue(const AValue: double; const APrefixes: TPrefixes): double;
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
      result := AValue * IntPower(10, Exponent)
    else
      result := AValue;

  end else
    if PrefixCount = 0 then
      result := AValue
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

procedure TFactoredUnit.Check(var AQuantity: TQuantity);
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TFactoredUnit.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := U.GetValue(AQuantity.FValue);
{$ELSE}
  result := U.GetValue(AQuantity);
{$ENDIF}  
end;

function TFactoredUnit.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(U.GetValue(AQuantity.FValue), APrefixes);
{$ELSE}
  result := GetValue(U.GetValue(AQuantity), APrefixes);
{$ENDIF}  
end;

function TFactoredUnit.ToString(const AQuantity: TQuantity): string;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(U.GetValue(AQuantity.FValue)) + ' ' + GetSymbol(U.FPrefixes);
{$ELSE}
  result := FloatToStr(U.GetValue(AQuantity)) + ' ' + GetSymbol(U.FPrefixes);
{$ENDIF}
end;

function TFactoredUnit.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToVerboseString(const AQuantity: TQuantity): string;
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

function TFactoredUnit.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

  ,  <   ��
 C L 2 0 - S E C T I O N - B 4                 
{ Power functions }

function SquarePower(const AQuantity: TQuantity): TQuantity;
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

function CubicPower(const AQuantity: TQuantity): TQuantity;
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

function QuarticPower(const AQuantity: TQuantity): TQuantity;
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

function QuinticPower(const AQuantity: TQuantity): TQuantity;
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

function SexticPower(const AQuantity: TQuantity): TQuantity;
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

function SquareRoot(const AQuantity: TQuantity): TQuantity;
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

function CubicRoot(const AQuantity: TQuantity): TQuantity;
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

function QuarticRoot(const AQuantity: TQuantity): TQuantity;
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

function QuinticRoot(const AQuantity: TQuantity): TQuantity;
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

function SexticRoot(const AQuantity: TQuantity): TQuantity;
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

function Cos(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Cos routine has detected wrong units of measurements.');

  result := System.Cos(AQuantity.FValue);
{$ELSE}
  result := System.Cos(AQuantity);
{$ENDIF}
end;

function Sin(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Sin routine has detected wrong units of measurements.');

  result := System.Sin(AQuantity.FValue);
{$ELSE}
  result := System.Sin(AQuantity);
{$ENDIF}
end;

function Tan(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Tan routine has detected wrong units of measurements.');

  result := Math.Tan(AQuantity.FValue);
{$ELSE}
  result := Math.Tan(AQuantity);
{$ENDIF}
end;

function Cotan(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Cotan routine has detected wrong units of measurements.');

  result := Math.Cotan(AQuantity.FValue);
{$ELSE}
  result := Math.Cotan(AQuantity);
{$ENDIF}
end;

function Secant(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Setan routine has detected wrong units of measurements.');

  result := Math.Secant(AQuantity.FValue);
{$ELSE}
  result := Math.Secant(AQuantity);
{$ENDIF}
end;

function Cosecant(const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Cosecant routine has detected wrong units of measurements.');

  result := Math.Cosecant(AQuantity.FValue);
{$ELSE}
  result := Math.Cosecant(AQuantity);
{$ENDIF}
end;

function ArcCos(const AValue: double): TQuantity;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcCos(AValue);
{$ELSE}
  result := Math.ArcCos(AValue);
{$ENDIF}
end;

function ArcSin(const AValue: double): TQuantity;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcSin(AValue);
{$ELSE}
  result := Math.ArcSin(AValue);
{$ENDIF}
end;

function ArcTan(const AValue: double): TQuantity;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := System.ArcTan(AValue);
{$ELSE}
  result := System.ArcTan(AValue);
{$ENDIF}
end;

function ArcTan2(const x, y: double): TQuantity;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcTan2(x, y);
{$ELSE}
  result := Math.ArcTan2(x, y);
{$ENDIF}
end;

{ Math functions }


function Min(const ALeft, ARight: TQuantity): TQuantity;
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

function Max(const ALeft, ARight: TQuantity): TQuantity;
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

function Exp(const AQuantity: TQuantity): TQuantity;
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

function Log10(const AQuantity : TQuantity) : double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Log10 routine has detected wrong units of measurements.');

  result := Math.Log10(AQuantity.FValue);
{$ELSE}  
  result := Math.Log10(AQuantity);
{$ENDIF}
end;

function Log2(const AQuantity : TQuantity) : double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Log2 routine has detected wrong units of measurements.');

  result := Math.Log2(AQuantity.FValue);
{$ELSE} 
  result := Math.Log2(AQuantity);
{$ENDIF}
end;

function LogN(ABase: longint; const AQuantity: TQuantity): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  result := Math.LogN(ABase, AQuantity.FValue);
{$ELSE} 
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function LogN(const ABase, AQuantity: TQuantity): double;
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

function Power(const ABase: TQuantity; AExponent: double): double;
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

function LessThanOrEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue <= 0;
{$ELSE}  
  result := AQuantity <= 0;
{$ENDIF}
end;

function LessThanZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue < 0;
{$ELSE}  
  result := AQuantity < 0;
{$ENDIF}
end;

function EqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue = 0;
{$ELSE} 
  result := AQuantity = 0;
{$ENDIF}
end;

function NotEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue <> 0;
{$ELSE}
  result := AQuantity <> 0;
{$ENDIF}
end;

function GreaterThanOrEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue >= 0;
{$ELSE}
  result := AQuantity >= 0;
{$ENDIF}
end;

function GreaterThanZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue > 0;
{$ELSE}
  result := AQuantity > 0;
{$ENDIF}
end;

function SameValue(const ALeft, ARight: TQuantity): boolean;
begin
{$IFDEF USEADIM}
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('SameValue routine has detected wrong units of measurements.');

  result := Math.SameValue(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.SameValue(ALeft, ARight);
{$ENDIF}
end;

     <   ��
 C L 3 0 - S E C T I O N - A 0                 {
  Description: ADim (CL3) Run-time library.

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
   Jo  <   ��
 C L 3 0 - S E C T I O N - A 1                 
interface

uses CL3, SysUtils;

type
  { Prefix }
  TPrefix = (pQuetta, pRonna, pYotta, pZetta, pExa, pPeta, pTera, pGiga, pMega, pKilo, pHecto, pDeca, 
    pNone, pDeci, pCenti, pMilli, pMicro, pNano, pPico, pFemto, pAtto, pZepto, pYocto, pRonto, pQuecto);

  { Prefixes } 
  TPrefixes = array of TPrefix; 

  { Exponents } 
  TExponents = array of longint;

  { TScalar }

  {$IFDEF USEADIM}
  TScalar = record
  private
    FUnitOfMeasurement: longint;
    FValue: double;
  public
    class operator + (const ASelf: TScalar): TScalar;
    class operator - (const ASelf: TScalar): TScalar;
    class operator + (const ALeft, ARight: TScalar): TScalar;
    class operator - (const ALeft, ARight: TScalar): TScalar;
    class operator * (const ALeft, ARight: TScalar): TScalar;
    class operator / (const ALeft, ARight: TScalar): TScalar;
    class operator * (const ALeft: double; const ARight: TScalar): TScalar;
    class operator / (const ALeft: double; const ARight: TScalar): TScalar;
    class operator * (const ALeft: TScalar; const ARight: double): TScalar;
    class operator / (const ALeft: TScalar; const ARight: double): TScalar;

    class operator = (const ALeft, ARight: TScalar): boolean;
    class operator < (const ALeft, ARight: TScalar): boolean;
    class operator > (const ALeft, ARight: TScalar): boolean;
    class operator <=(const ALeft, ARight: TScalar): boolean;
    class operator >=(const ALeft, ARight: TScalar): boolean;
    class operator <>(const ALeft, ARight: TScalar): boolean;
    class operator :=(const ASelf: double): TScalar;
  end;
  {$ELSE}
  TScalar = double;
  {$ENDIF}

  { TMultivector }

  {$IFDEF USEADIM}
  TMultivector = record
  private
    FUnitOfMeasurement: longint;
    FValue: CL3.TMultivector;
  public
    class operator :=(const AValue: TScalar): TMultivector;
    class operator :=(const AValue: TMultivector): TScalar;
    class operator <>(const ALeft, ARight: TMultivector): boolean;
    class operator <>(const ALeft: TMultivector; const ARight: TScalar): boolean;
    class operator <>(const ALeft: TScalar; const ARight: TMultivector): boolean;

    class operator = (const ALeft, ARight: TMultivector): boolean;
    class operator = (const ALeft: TMultivector; const ARight: TScalar): boolean;
    class operator = (const ALeft: TScalar; const ARight: TMultivector): boolean;

    class operator + (const ALeft, ARight: TMultivector): TMultivector;
    class operator + (const ALeft: TMultivector; const ARight: TScalar): TMultivector;
    class operator + (const ALeft: TScalar; const ARight: TMultivector): TMultivector;

    class operator - (const ASelf: TMultivector): TMultivector;
    class operator - (const ALeft, ARight: TMultivector): TMultivector;
    class operator - (const ALeft: TMultivector; const ARight: TScalar): TMultivector;
    class operator - (const ALeft: TScalar; const ARight: TMultivector): TMultivector;

    class operator * (const ALeft, ARight: TMultivector): TMultivector;
    class operator * (const ALeft: TMultivector; const ARight: TScalar): TMultivector;
    class operator * (const ALeft: TScalar; const ARight: TMultivector): TMultivector;

    class operator / (const ALeft, ARight: TMultivector): TMultivector;
    class operator / (const ALeft: TMultivector; const ARight: TScalar): TMultivector;
    class operator / (const ALeft: TScalar; const ARight: TMultivector): TMultivector;
  end;
  {$ELSE}
  TMultivector = CL3.TMultivector;
  {$ENDIF}

  { TTrivector }

  {$IFDEF USEADIM}
  TTrivector = record
  private
    FUnitOfMeasurement: longint;
    FValue: CL3.TTrivector;
  public
    class operator :=(const AValue: TTrivector): TMultivector;
    class operator :=(const AValue: TMultivector): TTrivector;
    class operator <>(const ALeft, ARight: TTrivector): boolean;
    class operator <>(const ALeft: TTrivector; const ARight: TMultivector): boolean;
    class operator <>(const ALeft: TMultivector; const ARight: TTrivector): boolean;

    class operator = (const ALeft, ARight: TTrivector): boolean;
    class operator = (const ALeft: TTrivector; const ARight: TMultivector): boolean;
    class operator = (const ALeft: TMultivector; const ARight: TTrivector): boolean;

    class operator + (const ALeft, ARight: TTrivector): TTrivector;
    class operator + (const ALeft: TTrivector; const ARight: TScalar): TMultivector;
    class operator + (const ALeft: TScalar; const ARight: TTrivector): TMultivector;
    class operator + (const ALeft: TTrivector; const ARight: TMultivector): TMultivector;
    class operator + (const ALeft: TMultivector; const ARight: TTrivector): TMultivector;

    class operator - (const ASelf: TTrivector): TTrivector;
    class operator - (const ALeft, ARight: TTrivector): TTrivector;
    class operator - (const ALeft: TTrivector; const ARight: TScalar): TMultivector;
    class operator - (const ALeft: TScalar; const ARight: TTrivector): TMultivector;
    class operator - (const ALeft: TTrivector; const ARight: TMultivector): TMultivector;
    class operator - (const ALeft: TMultivector; const ARight: TTrivector): TMultivector;

    class operator * (const ALeft, ARight: TTrivector): TScalar;
    class operator * (const ALeft: TScalar; const ARight: TTrivector): TTrivector;
    class operator * (const ALeft: TTrivector; const ARight: TScalar): TTrivector;
    class operator * (const ALeft: TTrivector; const ARight: TMultivector): TMultivector;
    class operator * (const ALeft: TMultivector; const ARight: TTrivector): TMultivector;

    class operator / (const ALeft, ARight: TTrivector): TScalar;
    class operator / (const ALeft: TTrivector; const ARight: TScalar): TTrivector;
    class operator / (const ALeft: TScalar; const ARight: TTrivector): TTrivector;
    class operator / (const ALeft: TTrivector; const ARight: TMultivector): TMultivector;
    class operator / (const ALeft: TMultivector; const ARight: TTrivector): TMultivector;
  end;
  {$ELSE}
  TTrivector = CL3.TTrivector;
  {$ENDIF}

  { TBivector }

  {$IFDEF USEADIM}
  TBivector = record
  private
    FUnitOfMeasurement: longint;
    FValue: CL3.TBivector;
  public
    class operator :=(const AValue: TBivector): TMultivector;
    class operator :=(const AValue: TMultivector): TBivector;
    class operator <>(const ALeft, ARight: TBivector): boolean;
    class operator <>(const ALeft: TBivector; const ARight: TMultivector): boolean;
    class operator <>(const ALeft: TMultivector; const ARight: TBivector): boolean;

    class operator = (const ALeft, ARight: TBivector): boolean;
    class operator = (const ALeft: TBivector; const ARight: TMultivector): boolean;
    class operator = (const ALeft: TMultivector; const ARight: TBivector): boolean;

    class operator + (const ALeft, ARight: TBivector): TBivector;
    class operator + (const ALeft: TBivector; const ARight: TScalar): TMultivector;
    class operator + (const ALeft: TScalar; const ARight: TBivector): TMultivector;
    class operator + (const ALeft: TBivector; const ARight: TTrivector): TMultivector;
    class operator + (const ALeft: TTrivector; const ARight: TBivector): TMultivector;
    class operator + (const ALeft: TBivector; const ARight: TMultivector): TMultivector;
    class operator + (const ALeft: TMultivector; const ARight: TBivector): TMultivector;

    class operator - (const ASelf: TBivector): TBivector;
    class operator - (const ALeft, ARight: TBivector): TBivector;
    class operator - (const ALeft: TBivector; const ARight: TScalar): TMultivector;
    class operator - (const ALeft: TScalar; const ARight: TBivector): TMultivector;
    class operator - (const ALeft: TBivector; const ARight: TTrivector): TMultivector;
    class operator - (const ALeft: TTrivector; const ARight: TBivector): TMultivector;
    class operator - (const ALeft: TBivector; const ARight: TMultivector): TMultivector;
    class operator - (const ALeft: TMultivector; const ARight: TBivector): TMultivector;

    class operator * (const ALeft, ARight: TBivector): TMultivector;
    class operator * (const ALeft: TScalar; const ARight: TBivector): TBivector;
    class operator * (const ALeft: TBivector; const ARight: TScalar): TBivector;
    class operator * (const ALeft: TBivector; const ARight: TMultivector): TMultivector;
    class operator * (const ALeft: TBivector; const ARight: TTrivector): TMultivector;
    class operator * (const ALeft: TTrivector; const ARight: TBivector): TMultivector;
    class operator * (const ALeft: TMultivector; const ARight: TBivector): TMultivector;

    class operator / (const ALeft, ARight: TBivector): TMultivector;
    class operator / (const ALeft: TBivector; const ARight: TScalar): TBivector;
    class operator / (const ALeft: TScalar; const ARight: TBivector): TBivector;
    class operator / (const ALeft: TBivector; const ARight: TTrivector): TMultivector;
    class operator / (const ALeft: TTrivector; const ARight: TBivector): TMultivector;
    class operator / (const ALeft: TBivector; const ARight: TMultivector): TMultivector;
    class operator / (const ALeft: TMultivector; const ARight: TBivector): TMultivector;
  end;
  {$ELSE}
  TBivector = CL3.TBivector;
  {$ENDIF}

  { TVector }

  {$IFDEF USEADIM}
  TVector = record
  private
    FUnitOfMeasurement: longint;
    FValue: CL3.TVector;
  public
    class operator :=(const AValue: TVector): TMultivector;
    class operator :=(const AValue: TMultivector): TVector;
    class operator <>(const ALeft, ARight: TVector): boolean;
    class operator <>(const ALeft: TVector; const ARight: TMultivector): boolean;
    class operator <>(const ALeft: TMultivector; const ARight: TVector): boolean;

    class operator = (const ALeft, ARight: TVector): boolean;
    class operator = (const ALeft: TVector; const ARight: TMultivector): boolean;
    class operator = (const ALeft: TMultivector; const ARight: TVector): boolean;

    class operator + (const ALeft, ARight: TVector): TVector;
    class operator + (const ALeft: TVector; const ARight: TScalar): TMultivector;
    class operator + (const ALeft: TScalar; const ARight: TVector): TMultivector;
    class operator + (const ALeft: TVector; const ARight: TBivector): TMultivector;
    class operator + (const ALeft: TBivector; const ARight: TVector): TMultivector;
    class operator + (const ALeft: TVector; const ARight: TTrivector): TMultivector;
    class operator + (const ALeft: TTrivector; const ARight: TVector): TMultivector;
    class operator + (const ALeft: TVector; const ARight: TMultivector): TMultivector;
    class operator + (const ALeft: TMultivector; const ARight: TVector): TMultivector;

    class operator - (const ASelf: TVector): TVector;
    class operator - (const ALeft, ARight: TVector): TVector;
    class operator - (const ALeft: TVector; const ARight: TScalar): TMultivector;
    class operator - (const ALeft: TScalar; const ARight: TVector): TMultivector;
    class operator - (const ALeft: TVector; const ARight: TBivector): TMultivector;
    class operator - (const ALeft: TBivector; const ARight: TVector): TMultivector;
    class operator - (const ALeft: TVector; const ARight: TTrivector): TMultivector;
    class operator - (const ALeft: TTrivector; const ARight: TVector): TMultivector;
    class operator - (const ALeft: TVector; const ARight: TMultivector): TMultivector;
    class operator - (const ALeft: TMultivector; const ARight: TVector): TMultivector;

    class operator * (const ALeft, ARight: TVector): TMultivector;
    class operator * (const ALeft: TScalar; const ARight: TVector): TVector;
    class operator * (const ALeft: TVector; const ARight: TScalar): TVector;
    class operator * (const ALeft: TVector; const ARight: TBivector): TMultivector;
    class operator * (const ALeft: TVector; const ARight: TTrivector): TBivector;
    class operator * (const ALeft: TVector; const ARight: TMultivector): TMultivector;
    class operator * (const ALeft: TBivector; const ARight: TVector): TMultivector;
    class operator * (const ALeft: TTrivector; const ARight: TVector): TBivector;
    class operator * (const ALeft: TMultivector; const ARight: TVector): TMultivector;

    class operator / (const ALeft: TScalar; const ARight: TVector): TVector;
    class operator / (const ALeft: TVector; const ARight: TScalar): TVector;
    class operator / (const ALeft, ARight: TVector): TMultivector;
    class operator / (const ALeft: TVector; const ARight: TBivector): TMultivector;
    class operator / (const ALeft: TVector; const ARight: TTrivector): TBivector;
    class operator / (const ALeft: TVector; const ARight: TMultivector): TMultivector;
    class operator / (const ALeft: TBivector; const ARight: TVector): TMultivector;
    class operator / (const ALeft: TTrivector; const ARight: TVector): TBivector;
    class operator / (const ALeft: TMultivector; const ARight: TVector): TMultivector;
  end;
  {$ELSE}
  TVector = CL3.TVector;
  {$ENDIF}

  { TMultivectorHelper }

  {$IFDEF USEADIM}
  TMultivectorHelper = record helper for TMultivector
    function Dual: TMultivector;
    function Inverse: TMultivector;
    function Reverse: TMultivector;
    function Conjugate: TMultivector;
    function Reciprocal: TMultivector;
    function LeftReciprocal: TMultivector;
    function Normalized: TMultivector;
    function Norm: TScalar;
    function SquaredNorm: TScalar;

    function Dot(const AVector: TVector): TMultivector; overload;
    function Dot(const AVector: TBivector): TMultivector; overload;
    function Dot(const AVector: TTrivector): TMultivector; overload;
    function Dot(const AVector: TMultivector): TMultivector; overload;

    function Wedge(const AVector: TVector): TMultivector; overload;
    function Wedge(const AVector: TBivector): TMultivector; overload;
    function Wedge(const AVector: TTrivector): TTrivector; overload;
    function Wedge(const AVector: TMultivector): TMultivector; overload;

    function Projection(const AVector: TVector): TMultivector; overload;
    function Projection(const AVector: TBivector): TMultivector; overload;
    function Projection(const AVector: TTrivector): TMultivector; overload;
    function Projection(const AVector: TMultivector): TMultivector; overload;

    function Rejection(const AVector: TVector): TMultivector; overload;
    function Rejection(const AVector: TBivector): TMultivector; overload;
    function Rejection(const AVector: TTrivector): TScalar; overload;
    function Rejection(const AVector: TMultivector): TMultivector; overload;

    function Reflection(const AVector: TVector): TMultivector; overload;
    function Reflection(const AVector: TBivector): TMultivector; overload;
    function Reflection(const AVector: TTrivector): TMultivector; overload;
    function Reflection(const AVector: TMultivector): TMultivector; overload;

    function Rotation(const AVector1, AVector2: TVector): TMultivector; overload;
    function Rotation(const AVector1, AVector2: TBivector): TMultivector; overload;
    function Rotation(const AVector1, AVector2: TTrivector): TMultivector; overload;
    function Rotation(const AVector1, AVector2: TMultivector): TMultivector;overload;

    function SameValue(const AValue: TMultivector): boolean;
    function SameValue(const AValue: TTrivector): boolean;
    function SameValue(const AValue: TBivector): boolean;
    function SameValue(const AValue: TVector): boolean;
    function SameValue(const AValue: TScalar): boolean;

    function ExtractMultivector(AComponents: TMultivectorComponents): TMultivector;
    function ExtractBivector(AComponents: TMultivectorComponents): TBivector;
    function ExtractVector(AComponents: TMultivectorComponents): TVector;

    function ExtractTrivector: TTrivector;
    function ExtractBivector: TBivector;
    function ExtractVector: TVector;
    function ExtractScalar: TScalar;

    function IsNull: boolean;
    function IsScalar: boolean;
    function IsVector: boolean;
    function IsBiVector: boolean;
    function IsTrivector: boolean;
    function IsA: string;
  end;
  {$ENDIF}

  { TTrivectorHelper }

  {$IFDEF USEADIM}
  TTrivectorHelper = record helper for TTrivector
    function Dual: TScalar;
    function Inverse: TTrivector;
    function Reverse: TTrivector;
    function Conjugate: TTrivector;
    function Reciprocal: TTrivector;
    function Normalized: TTrivector;
    function Norm: TScalar;
    function SquaredNorm: TScalar;

    function Dot(const AVector: TVector): TBivector; overload;
    function Dot(const AVector: TBivector): TVector; overload;
    function Dot(const AVector: TTrivector): TScalar; overload;
    function Dot(const AVector: TMultivector): TMultivector; overload;

    function Wedge(const AVector: TVector): TScalar; overload;
    function Wedge(const AVector: TBivector): TScalar; overload;
    function Wedge(const AVector: TTrivector): TScalar; overload;
    function Wedge(const AVector: TMultivector): TTrivector; overload;

    function Projection(const AVector: TVector): TTrivector; overload;
    function Projection(const AVector: TBivector): TTrivector; overload;
    function Projection(const AVector: TTrivector): TTrivector; overload;
    function Projection(const AVector: TMultivector): TTrivector; overload;

    function Rejection(const AVector: TVector): TScalar; overload;
    function Rejection(const AVector: TBivector): TScalar; overload;
    function Rejection(const AVector: TTrivector): TScalar; overload;
    function Rejection(const AVector: TMultivector): TMultivector; overload;

    function Reflection(const AVector: TVector): TTrivector; overload;
    function Reflection(const AVector: TBivector): TTrivector; overload;
    function Reflection(const AVector: TTrivector): TTrivector; overload;
    function Reflection(const AVector: TMultivector): TTrivector; overload;

    function Rotation(const AVector1, AVector2: TVector): TTrivector; overload;
    function Rotation(const AVector1, AVector2: TBivector): TTrivector; overload;
    function Rotation(const AVector1, AVector2: TTrivector): TTrivector; overload;
    function Rotation(const AVector1, AVector2: TMultivector): TTrivector; overload;

    function SameValue(const AValue: TMultivector): boolean;
    function SameValue(const AValue: TTrivector): boolean;

    function ToMultivector: TMultivector;
  end;
  {$ENDIF}

  { TBivectorHelper }

  {$IFDEF USEADIM}
  TBivectorHelper = record helper for TBivector
    function Dual: TVector;
    function Inverse: TBivector;
    function Reverse: TBivector;
    function Conjugate: TBivector;
    function Reciprocal: TBivector;
    function Normalized: TBivector;
    function Norm: TScalar;
    function SquaredNorm: TScalar;

    function Dot(const AVector: TVector): TVector; overload;
    function Dot(const AVector: TBivector): TScalar; overload;
    function Dot(const AVector: TTrivector): TVector; overload;
    function Dot(const AVector: TMultivector): TMultivector; overload;

    function Wedge(const AVector: TVector): TTrivector; overload;
    function Wedge(const AVector: TBivector): TScalar; overload;
    function Wedge(const AVector: TTrivector): TScalar; overload;
    function Wedge(const AVector: TMultivector): TMultivector; overload;

    function Projection(const AVector: TVector): TBivector; overload;
    function Projection(const AVector: TBivector): TBivector; overload;
    function Projection(const AVector: TTrivector): TBivector; overload;
    function Projection(const AVector: TMultivector): TMultivector; overload;

    function Rejection(const AVector: TVector): TBivector; overload;
    function Rejection(const AVector: TBivector): TScalar; overload;
    function Rejection(const AVector: TTrivector): TScalar; overload;
    function Rejection(const AVector: TMultivector): TMultivector; overload;

    function Reflection(const AVector: TVector): TBivector; overload;
    function Reflection(const AVector: TBivector): TBivector; overload;
    function Reflection(const AVector: TTrivector): TBivector; overload;
    function Reflection(const AVector: TMultivector): TMultivector; overload;

    function Rotation(const AVector1, AVector2: TVector): TBivector; overload;
    function Rotation(const AVector1, AVector2: TBivector): TBivector; overload;
    function Rotation(const AVector1, AVector2: TTrivector): TBivector; overload;
    function Rotation(const AVector1, AVector2: TMultivector): TMultivector; overload;

    function SameValue(const AValue: TMultivector): boolean;
    function SameValue(const AValue: TBivector): boolean;

    function ExtractBivector(AComponents: TMultivectorComponents): TBivector;

    function ToMultivector: TMultivector;
  end;
  {$ENDIF}

  { TVectorHelper }

  {$IFDEF USEADIM}
  TVectorHelper = record helper for TVector
    function Dual: TBivector;
    function Inverse: TVector;
    function Reverse: TVector;
    function Conjugate: TVector;
    function Reciprocal: TVector;
    function Normalized: TVector;
    function Norm: TScalar;
    function SquaredNorm: TScalar;

    function Dot(const AVector: TVector): TScalar; overload;
    function Dot(const AVector: TBivector): TVector; overload;
    function Dot(const AVector: TTrivector): TBivector; overload;
    function Dot(const AVector: TMultivector): TMultivector; overload;

    function Wedge(const AVector: TVector): TBivector; overload;
    function Wedge(const AVector: TBivector): TTrivector; overload;
    function Wedge(const AVector: TTrivector): TScalar; overload;
    function Wedge(const AVector: TMultivector): TMultivector; overload;

    function Cross(const AVector: TVector): TVector;

    function Projection(const AVector: TVector): TVector; overload;
    function Projection(const AVector: TBivector): TVector; overload;
    function Projection(const AVector: TTrivector): TVector; overload;
    function Projection(const AVector: TMultivector): TMultivector; overload;

    function Rejection(const AVector: TVector): TVector; overload;
    function Rejection(const AVector: TBivector): TVector; overload;
    function Rejection(const AVector: TTrivector): TScalar; overload;
    function Rejection(const AVector: TMultivector): TMultivector; overload;

    function Reflection(const AVector: TVector): TVector; overload;
    function Reflection(const AVector: TBivector): TVector; overload;
    function Reflection(const AVector: TTrivector): TVector; overload;
    function Reflection(const AVector: TMultivector): TMultivector; overload;

    function Rotation(const AVector1, AVector2: TVector): TVector; overload;
    function Rotation(const AVector1, AVector2: TBivector): TVector; overload;
    function Rotation(const AVector1, AVector2: TTrivector): TVector; overload;
    function Rotation(const AVector1, AVector2: TMultivector): TMultivector; overload;

    function SameValue(const AValue: TMultivector): boolean;
    function SameValue(const AValue: TVector): boolean;

    function ExtractVector(AComponents: TMultivectorComponents): TVector;

    function ToMultivector: TMultivector;
  end;
  {$ENDIF}

  { TUnit }

  generic TUnit<U> = record
    type TSelf = specialize TUnit<U>;
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AValue: double; const APrefixes: TPrefixes): double;
  public
    procedure Check(var AQuantity: TScalar);
    function ToFloat(const AQuantity: TScalar): double;
    function ToFloat(const AQuantity: TScalar; const APrefixes: TPrefixes): double;
    function ToString(const AQuantity: TScalar): string;
    function ToString(const AQuantity: TScalar; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity, ATolerance: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TScalar): string;
    function ToVerboseString(const AQuantity: TScalar; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity, ATolerance: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    class operator *(const AQuantity: double; const ASelf: TSelf): TScalar; inline;
    class operator /(const AQuantity: double; const ASelf: TSelf): TScalar; inline;
    class operator *(const AQuantity: CL3.TVector; const ASelf: TSelf): TVector; inline;
    class operator /(const AQuantity: CL3.TVector; const ASelf: TSelf): TVector; inline;
    class operator *(const AQuantity: CL3.TBivector; const ASelf: TSelf): TBivector; inline;
    class operator /(const AQuantity: CL3.TBivector; const ASelf: TSelf): TBivector; inline;
    class operator *(const AQuantity: CL3.TTrivector; const ASelf: TSelf): TTrivector; inline;
    class operator /(const AQuantity: CL3.TTrivector; const ASelf: TSelf): TTrivector; inline;
    class operator *(const AQuantity: CL3.TMultivector; const ASelf: TSelf): TMultivector; inline;
    class operator /(const AQuantity: CL3.TMultivector; const ASelf: TSelf): TMultivector; inline;
  {$IFDEF USEADIM}
    class operator *(const AQuantity: TScalar; const ASelf: TSelf): TScalar; inline;
    class operator /(const AQuantity: TScalar; const ASelf: TSelf): TScalar; inline;
    class operator *(const AQuantity: TVector; const ASelf: TSelf): TVector; inline;
    class operator /(const AQuantity: TVector; const ASelf: TSelf): TVector; inline;
    class operator *(const AQuantity: TBivector; const ASelf: TSelf): TBivector; inline;
    class operator /(const AQuantity: TBivector; const ASelf: TSelf): TBivector; inline;
    class operator *(const AQuantity: TTrivector; const ASelf: TSelf): TTrivector; inline;
    class operator /(const AQuantity: TTrivector; const ASelf: TSelf): TTrivector; inline;
    class operator *(const AQuantity: TMultivector; const ASelf: TSelf): TMultivector; inline;
    class operator /(const AQuantity: TMultivector; const ASelf: TSelf): TMultivector; inline;
  {$ENDIF}
  end;

  { TFactoredUnit }

  generic TFactoredUnit<U> = record
    type TSelf = specialize TFactoredUnit<U>;
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AValue: double; const APrefixes: TPrefixes): double;
  public
    procedure Check(var AQuantity: TScalar);
    function ToFloat(const AQuantity: TScalar): double;
    function ToFloat(const AQuantity: TScalar; const APrefixes: TPrefixes): double;
    function ToString(const AQuantity: TScalar): string;
    function ToString(const AQuantity: TScalar; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity, ATolerance: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TScalar): string;
    function ToVerboseString(const AQuantity: TScalar; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity, ATolerance: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    class operator *(const AValue: double; const ASelf: TSelf): TScalar; inline;
    class operator /(const AValue: double; const ASelf: TSelf): TScalar; inline;
  {$IFDEF USEADIM}
    class operator *(const AQuantity: TScalar; const ASelf: TSelf): TScalar; inline;
    class operator /(const AQuantity: TScalar; const ASelf: TSelf): TScalar; inline;
  {$ENDIF}
  end;

  �  <   ��
 C L 3 0 - S E C T I O N - A 4                 { Power functions }

function SquarePower(const AQuantity: TScalar): TScalar;
function CubicPower(const AQuantity: TScalar): TScalar;
function QuarticPower(const AQuantity: TScalar): TScalar;
function QuinticPower(const AQuantity: TScalar): TScalar;
function SexticPower(const AQuantity: TScalar): TScalar;
function SquareRoot(const AQuantity: TScalar): TScalar;
function CubicRoot(const AQuantity: TScalar): TScalar;
function QuarticRoot(const AQuantity: TScalar): TScalar;
function QuinticRoot(const AQuantity: TScalar): TScalar;
function SexticRoot(const AQuantity: TScalar): TScalar;

{ Trigonometric functions }

function Cos(const AQuantity: TScalar): double;
function Sin(const AQuantity: TScalar): double;
function Tan(const AQuantity: TScalar): double;
function Cotan(const AQuantity: TScalar): double;
function Secant(const AQuantity: TScalar): double;
function Cosecant(const AQuantity: TScalar): double;

function ArcCos(const AValue: double): TScalar;
function ArcSin(const AValue: double): TScalar;
function ArcTan(const AValue: double): TScalar;
function ArcTan2(const x, y: double): TScalar;

{ Math functions }

function Min(const ALeft, ARight: TScalar): TScalar;
function Max(const ALeft, ARight: TScalar): TScalar;
function Exp(const AQuantity: TScalar): TScalar;

function Log10(const AQuantity : TScalar) : double;
function Log2(const AQuantity : TScalar) : double;
function LogN(ABase: longint; const AQuantity: TScalar): double;
function LogN(const ABase, AQuantity: TScalar): double;

function Power(const ABase: TScalar; AExponent: double): double;

{ Helper functions }

function LessThanOrEqualToZero(const AQuantity: TScalar): boolean;
function LessThanZero(const AQuantity: TScalar): boolean;
function EqualToZero(const AQuantity: TScalar): boolean;
function NotEqualToZero(const AQuantity: TScalar): boolean;
function GreaterThanOrEqualToZero(const AQuantity: TScalar): boolean;
function GreaterThanZero(const AQuantity: TScalar): boolean;
function SameValue(const ALeft, ARight: TScalar): boolean;

{ Constants }

const
  AvogadroConstant               : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cReciprocalMole;                     FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}
  BohrMagneton                   : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cSquareMeterAmpere;                  FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}
  BohrRadius                     : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeter;                              FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}
  BoltzmannConstant              : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cJoulePerKelvin;                     FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}
  ComptonWaveLength              : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeter;                              FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}
  CoulombConstant                : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cNewtonSquareMeterPerSquareCoulomb;  FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}
  DeuteronMass                   : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}
  ElectricPermittivity           : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cFaradPerMeter;                      FValue:     8.8541878128E-12); {$ELSE} (    8.8541878128E-12); {$ENDIF}
  ElectronMass                   : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}
  ElectronCharge                 : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cCoulomb;                            FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}
  MagneticPermeability           : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cHenryPerMeter;                      FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}
  MolarGasConstant               : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cJoulePerMolePerKelvin;              FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}
  NeutronMass                    : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}
  NewtonianConstantOfGravitation : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cNewtonSquareMeterPerSquareKilogram; FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}
  PlanckConstant                 : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogramSquareMeterPerSecond;       FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}
  ProtonMass                     : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}
  RydbergConstant                : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cReciprocalMeter;                    FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}
  SpeedOfLight                   : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeterPerSecond;                     FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}
  SquaredSpeedOfLight            : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cSquareMeterPerSquareSecond;         FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}
  StandardAccelerationOfGravity  : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeterPerSquareSecond;               FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}
  ReducedPlanckConstant          : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogramSquareMeterPerSecond;       FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}
  UnifiedAtomicMassUnit          : TScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}

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

      <   ��
 C L 3 0 - S E C T I O N - B 0                 implementation

uses Math;ދ <   ��
 C L 3 0 - S E C T I O N - B 1                 
{ TScalar }

{$IFDEF USEADIM}
class operator TScalar.:=(const ASelf: double): TScalar;
begin
  result.FUnitOfMeasurement := cScalar;
  result.FValue := ASelf;
end;

class operator TScalar.+(const ASelf: TScalar): TScalar;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := ASelf.FValue;
end;

class operator TScalar.-(const ASelf: TScalar): TScalar;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TScalar.+(const ALeft, ARight: TScalar): TScalar;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;  
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TScalar.-(const ALeft, ARight: TScalar): TScalar;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');
    
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;   
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TScalar.*(const ALeft, ARight: TScalar): TScalar;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TScalar./(const ALeft, ARight: TScalar): TScalar;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TScalar.*(const ALeft: double; const ARight: TScalar): TScalar;
begin
  result.FUnitOfMeasurement := ARight.FUnitOfMeasurement;
  result.FValue:= ALeft * ARight.FValue;
end;

class operator TScalar./(const ALeft: double; const ARight: TScalar): TScalar;
begin
  result.FUnitOfMeasurement := DivTable[cScalar, ARight.FUnitOfMeasurement];
  result.FValue:= ALeft / ARight.FValue;
end;

class operator TScalar.*(const ALeft: TScalar; const ARight: double): TScalar;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue:= ALeft.FValue * ARight;
end;

class operator TScalar./(const ALeft: TScalar; const ARight: double): TScalar;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue:= ALeft.FValue / ARight;
end;

class operator TScalar.=(const ALeft, ARight: TScalar): boolean; inline;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TScalar.<(const ALeft, ARight: TScalar): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('LessThan operator (<) has detected wrong unit of measurements.');

  result := ALeft.FValue < ARight.FValue;
end;

class operator TScalar.>(const ALeft, ARight: TScalar): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('GreaterThan operator (>) has detected wrong unit of measurements.');

  result := ALeft.FValue > ARight.FValue;
end;

class operator TScalar.<=(const ALeft, ARight: TScalar): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('LessThanOrEqual operator (<=) has detected wrong unit of measurements.');
    
  result := ALeft.FValue <= ARight.FValue;
end;

class operator TScalar.>=(const ALeft, ARight: TScalar): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('GreaterThanOrEqual operator (>=) has detected wrong unit of measurements.');
    
  result := ALeft.FValue >= ARight.FValue;
end;

class operator TScalar.<>(const ALeft, ARight: TScalar): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;
{$ENDIF}

// TMultivector

{$IFDEF USEADIM}
class operator TMultivector.:=(const AValue: TScalar): TMultivector;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TMultivector.:=(const AValue: TMultivector): TScalar;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue.ExtractScalar;
end;

class operator TMultivector.<>(const ALeft, ARight: TMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TMultivector.<>(const ALeft: TMultivector; const ARight: TScalar): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TMultivector.<>(const ALeft: TScalar; const ARight: TMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TMultivector.=(const ALeft: TMultivector; const ARight: TScalar): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TMultivector.=(const ALeft: TScalar; const ARight: TMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then

    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');
  result := ALeft.FValue = ARight.FValue;
end;

class operator TMultivector.=(const ALeft, ARight: TMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TMultivector.+(const ALeft: TMultivector; const ARight: TScalar): TMultivector;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;

  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');
end;

class operator TMultivector.+(const ALeft: TScalar; const ARight: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;

  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');
end;

class operator TMultivector.+(const ALeft, ARight: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;

  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');
end;

class operator TMultivector.-(const ASelf: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TMultivector.-(const ALeft: TMultivector; const ARight: TScalar): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TMultivector.-(const ALeft: TScalar; const ARight: TMultivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TMultivector.-(const ALeft, ARight: TMultivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TMultivector.*(const ALeft: TMultivector; const ARight: TScalar): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TMultivector.*(const ALeft: TScalar; const ARight: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TMultivector.*(const ALeft, ARight: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TMultivector./(const ALeft: TMultivector; const ARight: TScalar): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TMultivector./(const ALeft: TScalar; const ARight: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TMultivector./(const ALeft, ARight: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TTrivector

{$IFDEF USEADIM}

class operator TTrivector.:=(const AValue: TTrivector): TMultivector;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TTrivector.:=(const AValue: TMultivector): TTrivector;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TTrivector.<>(const ALeft, ARight: TTrivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TTrivector.<>(const ALeft: TMultivector; const ARight: TTrivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TTrivector.<>(const ALeft: TTrivector; const ARight: TMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TTrivector.=(const ALeft: TMultivector; const ARight: TTrivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TTrivector.=(const ALeft: TTrivector; const ARight: TMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TTrivector.=(const ALeft, ARight: TTrivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TTrivector.+(const ALeft, ARight: TTrivector): TTrivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivector.+(const ALeft: TTrivector; const ARight: TScalar): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivector.+(const ALeft: TScalar; const ARight: TTrivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivector.+(const ALeft: TMultivector; const ARight: TTrivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivector.+(const ALeft: TTrivector; const ARight: TMultivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivector.-(const ASelf: TTrivector): TTrivector;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TTrivector.-(const ALeft, ARight: TTrivector): TTrivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivector.-(const ALeft: TTrivector; const ARight: TScalar): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivector.-(const ALeft: TScalar; const ARight: TTrivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivector.-(const ALeft: TMultivector; const ARight: TTrivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivector.-(const ALeft: TTrivector; const ARight: TMultivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivector.*(const ALeft: TScalar; const ARight: TTrivector): TTrivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivector.*(const ALeft: TTrivector; const ARight: TScalar): TTrivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivector.*(const ALeft, ARight: TTrivector): TScalar;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivector.*(const ALeft: TMultivector; const ARight: TTrivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivector.*(const ALeft: TTrivector; const ARight: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivector./(const ALeft, ARight: TTrivector): TScalar;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TTrivector./(const ALeft: TTrivector; const ARight: TScalar): TTrivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivector./(const ALeft: TScalar; const ARight: TTrivector): TTrivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TTrivector./(const ALeft: TMultivector; const ARight: TTrivector): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TTrivector./(const ALeft: TTrivector; const ARight: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TBivector

{$IFDEF USEADIM}
class operator TBivector.:=(const AValue: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TBivector.:=(const AValue: TMultivector): TBivector;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TBivector.<>(const ALeft, ARight: TBivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TBivector.<>(const ALeft: TMultivector; const ARight: TBivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TBivector.<>(const ALeft: TBivector; const ARight: TMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TBivector.=(const ALeft, ARight: TBivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TBivector.=(const ALeft: TMultivector; const ARight: TBivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TBivector.=(const ALeft: TBivector; const ARight: TMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TBivector.+(const ALeft, ARight: TBivector): TBivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivector.+(const ALeft: TBivector; const ARight: TScalar): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivector.+(const ALeft: TScalar; const ARight: TBivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivector.+(const ALeft: TBivector; const ARight: TTrivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivector.+(const ALeft: TTrivector; const ARight: TBivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivector.+(const ALeft: TBivector; const ARight: TMultivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivector.+(const ALeft: TMultivector; const ARight: TBivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivector.-(const ASelf: TBivector): TBivector;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TBivector.-(const ALeft, ARight: TBivector): TBivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivector.-(const ALeft: TBivector; const ARight: TScalar): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivector.-(const ALeft: TScalar; const ARight: TBivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivector.-(const ALeft: TBivector; const ARight: TTrivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivector.-(const ALeft: TTrivector; const ARight: TBivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivector.-(const ALeft: TBivector; const ARight: TMultivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivector.-(const ALeft: TMultivector; const ARight: TBivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivector.*(const ALeft: TScalar; const ARight: TBivector): TBivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivector.*(const ALeft: TBivector; const ARight: TScalar): TBivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivector.*(const ALeft, ARight: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivector.*(const ALeft: TBivector; const ARight: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivector.*(const ALeft: TBivector; const ARight: TTrivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivector.*(const ALeft: TTrivector; const ARight: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivector.*(const ALeft: TMultivector; const ARight: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivector./(const ALeft, ARight: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivector./(const ALeft: TBivector; const ARight: TScalar): TBivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TBivector./(const ALeft: TScalar; const ARight: TBivector): TBivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivector./(const ALeft: TBivector; const ARight: TTrivector): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivector./(const ALeft: TTrivector; const ARight: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivector./(const ALeft: TMultivector; const ARight: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivector./(const ALeft: TBivector; const ARight: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TVector

{$IFDEF USEADIM}
class operator TVector.:=(const AValue: TVector): TMultivector;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TVector.:=(const AValue: TMultivector): TVector;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TVector.<>(const ALeft, ARight: TVector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVector.<>(const ALeft: TMultivector; const ARight: TVector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVector.<>(const ALeft: TVector; const ARight: TMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVector.=(const ALeft, ARight: TVector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVector.=(const ALeft: TVector; const ARight: TMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TVector.=(const ALeft: TMultivector; const ARight: TVector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TVector.+(const ALeft, ARight: TVector): TVector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVector.+(const ALeft: TVector; const ARight: TScalar): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVector.+(const ALeft: TScalar; const ARight: TVector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVector.+(const ALeft: TVector; const ARight: TBivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVector.+(const ALeft: TBivector; const ARight: TVector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVector.+(const ALeft: TVector; const ARight: TTrivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVector.+(const ALeft: TTrivector; const ARight: TVector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVector.+(const ALeft: TVector; const ARight: TMultivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVector.+(const ALeft: TMultivector; const ARight: TVector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVector.-(const ASelf: TVector): TVector;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TVector.-(const ALeft, ARight: TVector): TVector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVector.-(const ALeft: TVector; const ARight: TScalar): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVector.-(const ALeft: TScalar; const ARight: TVector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVector.-(const ALeft: TVector; const ARight: TBivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVector.-(const ALeft: TBivector; const ARight: TVector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVector.-(const ALeft: TVector; const ARight: TTrivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVector.-(const ALeft: TTrivector; const ARight: TVector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVector.-(const ALeft: TVector; const ARight: TMultivector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVector.-(const ALeft: TMultivector; const ARight: TVector): TMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVector.*(const ALeft: TScalar; const ARight: TVector): TVector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVector.*(const ALeft: TVector; const ARight: TScalar): TVector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVector.*(const ALeft, ARight: TVector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVector.*(const ALeft: TVector; const ARight: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVector.*(const ALeft: TBivector; const ARight: TVector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVector.*(const ALeft: TVector; const ARight: TTrivector): TBivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVector.*(const ALeft: TTrivector; const ARight: TVector): TBivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVector.*(const ALeft: TVector; const ARight: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVector.*(const ALeft: TMultivector; const ARight: TVector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVector./(const ALeft, ARight: TVector): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVector./ (const ALeft: TVector; const ARight: TScalar): TVector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVector./(const ALeft: TScalar; const ARight: TVector): TVector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVector./(const ALeft: TVector; const ARight: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVector./(const ALeft: TBivector; const ARight: TVector): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVector./(const ALeft: TVector; const ARight: TTrivector): TBivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVector./(const ALeft: TTrivector; const ARight: TVector): TBivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVector./(const ALeft: TMultivector; const ARight: TVector): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVector./(const ALeft: TVector; const ARight: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TMultivectorHelper

{$IFDEF USEADIM}
function TMultivectorHelper.Dual: TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Dual;
end;

function TMultivectorHelper.Inverse: TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Inverse;
end;

function TMultivectorHelper.Reverse: TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reverse;
end;

function TMultivectorHelper.Conjugate: TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Conjugate;
end;

function TMultivectorHelper.Reciprocal: TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[cScalar, FUnitOfMeasurement];
  result.FValue := FValue.Reciprocal;
end;

function TMultivectorHelper.LeftReciprocal: TMultivector;
begin
  result.FUnitOfMeasurement := DivTable[cScalar, FUnitOfMeasurement];
  result.FValue := FValue.LeftReciprocal;
end;

function TMultivectorHelper.Normalized: TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Normalized;
end;

function TMultivectorHelper.Norm: TScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Norm;
end;

function TMultivectorHelper.SquaredNorm: TScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := FValue.SquaredNorm;
end;

function TMultivectorHelper.Dot(const AVector: TVector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivectorHelper.Dot(const AVector: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivectorHelper.Dot(const AVector: TTrivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivectorHelper.Dot(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivectorHelper.Wedge(const AVector: TVector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivectorHelper.Wedge(const AVector: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivectorHelper.Wedge(const AVector: TTrivector): TTrivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivectorHelper.Wedge(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivectorHelper.Projection(const AVector: TVector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TMultivectorHelper.Projection(const AVector: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TMultivectorHelper.Projection(const AVector: TTrivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TMultivectorHelper.Projection(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TMultivectorHelper.Rejection(const AVector: TVector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TMultivectorHelper.Rejection(const AVector: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TMultivectorHelper.Rejection(const AVector: TTrivector): TScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TMultivectorHelper.Rejection(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TMultivectorHelper.Reflection(const AVector: TVector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TMultivectorHelper.Reflection(const AVector: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TMultivectorHelper.Reflection(const AVector: TTrivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TMultivectorHelper.Reflection(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TMultivectorHelper.Rotation(const AVector1, AVector2: TVector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TMultivectorHelper.Rotation(const AVector1, AVector2: TBivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TMultivectorHelper.Rotation(const AVector1, AVector2: TTrivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TMultivectorHelper.Rotation(const AVector1, AVector2: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TMultivectorHelper.SameValue(const AValue: TMultivector): boolean;
begin
  result := FValue.SameValue(AValue.FValue);
end;

function TMultivectorHelper.SameValue(const AValue: TTrivector): boolean;
begin
  result := FValue.SameValue(AValue.FValue);
end;

function TMultivectorHelper.SameValue(const AValue: TBivector): boolean;
begin
  result := FValue.SameValue(AValue.FValue);
end;

function TMultivectorHelper.SameValue(const AValue: TVector): boolean;
begin
  result := FValue.SameValue(AValue.FValue);
end;

function TMultivectorHelper.SameValue(const AValue: TScalar): boolean;
begin
  result := FValue.SameValue(AValue.FValue);
end;

function TMultivectorHelper.ExtractMultivector(AComponents: TMultivectorComponents): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractMultivector(AComponents);
end;

function TMultivectorHelper.ExtractBivector(AComponents: TMultivectorComponents): TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractBivector(AComponents);
end;

function TMultivectorHelper.ExtractVector(AComponents: TMultivectorComponents): TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractVector(AComponents);
end;

function TMultivectorHelper.ExtractTrivector: TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractTrivector;
end;

function TMultivectorHelper.ExtractBivector: TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractBivector;
end;

function TMultivectorHelper.ExtractVector: TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractVector;
end;

function TMultivectorHelper.ExtractScalar: TScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractScalar;
end;

function TMultivectorHelper.IsNull: boolean;
begin
  result := FValue.SameValue(NullMultivector);
end;

function TMultivectorHelper.IsScalar: boolean;
begin
  result := FValue.IsScalar;
end;

function TMultivectorHelper.IsVector: boolean;
begin
  result := FValue.IsVector;
end;

function TMultivectorHelper.IsBiVector: boolean;
begin
  result := FValue.IsBiVector;
end;

function TMultivectorHelper.IsTrivector: boolean;
begin
  result := FValue.IsTrivector;
end;

function TMultivectorHelper.IsA: string;
begin
  result := FValue.IsA;
end;
{$ENDIF}

// TTrivectorHelper

{$IFDEF USEADIM}
function TTrivectorHelper.Dual: TScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Dual;
end;

function TTrivectorHelper.Inverse: TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Inverse;
end;

function TTrivectorHelper.Reverse: TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reverse;
end;

function TTrivectorHelper.Conjugate: TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Conjugate;
end;

function TTrivectorHelper.Reciprocal: TTrivector;
begin
  result.FUnitOfMeasurement := DivTable[cScalar, FUnitOfMeasurement];
  result.FValue := FValue.Reciprocal;
end;

function TTrivectorHelper.Normalized: TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Normalized;
end;

function TTrivectorHelper.Norm: TScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Norm;
end;

function TTrivectorHelper.SquaredNorm: TScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := FValue.SquaredNorm;
end;

function TTrivectorHelper.Dot(const AVector: TVector): TBivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TTrivectorHelper.Dot(const AVector: TBivector): TVector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TTrivectorHelper.Dot(const AVector: TTrivector): TScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TTrivectorHelper.Dot(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TTrivectorHelper.Wedge(const AVector: TVector): TScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TTrivectorHelper.Wedge(const AVector: TBivector): TScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TTrivectorHelper.Wedge(const AVector: TTrivector): TScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TTrivectorHelper.Wedge(const AVector: TMultivector): TTrivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TTrivectorHelper.Projection(const AVector: TVector): TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TTrivectorHelper.Projection(const AVector: TBivector): TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TTrivectorHelper.Projection(const AVector: TTrivector): TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TTrivectorHelper.Projection(const AVector: TMultivector): TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TTrivectorHelper.Rejection(const AVector: TVector): TScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TTrivectorHelper.Rejection(const AVector: TBivector): TScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TTrivectorHelper.Rejection(const AVector: TTrivector): TScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TTrivectorHelper.Rejection(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TTrivectorHelper.Reflection(const AVector: TVector): TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TTrivectorHelper.Reflection(const AVector: TBivector): TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TTrivectorHelper.Reflection(const AVector: TTrivector): TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TTrivectorHelper.Reflection(const AVector: TMultivector): TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TTrivectorHelper.Rotation(const AVector1, AVector2: TVector): TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TTrivectorHelper.Rotation(const AVector1, AVector2: TBivector): TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TTrivectorHelper.Rotation(const AVector1, AVector2: TTrivector): TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TTrivectorHelper.Rotation(const AVector1, AVector2: TMultivector): TTrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TTrivectorHelper.SameValue(const AValue: TMultivector): boolean;
begin
  result := FValue.SameValue(AValue.FValue);
end;

function TTrivectorHelper.SameValue(const AValue: TTrivector): boolean;
begin
  result := FValue.SameValue(AValue.FValue);
end;

function TTrivectorHelper.ToMultivector: TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TBivectorHelper

{$IFDEF USEADIM}
function TBivectorHelper.Dual: TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Dual;
end;

function TBivectorHelper.Inverse: TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Inverse;
end;

function TBivectorHelper.Conjugate: TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Conjugate;
end;

function TBivectorHelper.Reverse: TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reverse;
end;

function TBivectorHelper.Reciprocal: TBivector;
begin
  result.FUnitOfMeasurement := DivTable[cScalar, FUnitOfMeasurement];
  result.FValue := FValue.Reciprocal;
end;

function TBivectorHelper.Normalized: TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Normalized;
end;

function TBivectorHelper.Norm: TScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Norm;
end;

function TBivectorHelper.SquaredNorm: TScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := FValue.SquaredNorm;
end;

function TBivectorHelper.Dot(const AVector: TVector): TVector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivectorHelper.Dot(const AVector: TBivector): TSCalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivectorHelper.Dot(const AVector: TTrivector): TVector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivectorHelper.Dot(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivectorHelper.Wedge(const AVector: TVector): TTrivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TBivectorHelper.Wedge(const AVector: TBivector): TScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TBivectorHelper.Wedge(const AVector: TTrivector): TSCalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TBivectorHelper.Wedge(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TBivectorHelper.Projection(const AVector: TVector): TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TBivectorHelper.Projection(const AVector: TBivector): TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TBivectorHelper.Projection(const AVector: TTrivector): TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TBivectorHelper.Projection(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TBivectorHelper.Rejection(const AVector: TVector): TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TBivectorHelper.Rejection(const AVector: TBivector): TScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TBivectorHelper.Rejection(const AVector: TTrivector): TScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TBivectorHelper.Rejection(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TBivectorHelper.Reflection(const AVector: TVector): TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TBivectorHelper.Reflection(const AVector: TBivector): TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TBivectorHelper.Reflection(const AVector: TTrivector): TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TBivectorHelper.Reflection(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TBivectorHelper.Rotation(const AVector1, AVector2: TVector): TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TBivectorHelper.Rotation(const AVector1, AVector2: TBivector): TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TBivectorHelper.Rotation(const AVector1, AVector2: Ttrivector): TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TBivectorHelper.Rotation(const AVector1, AVector2: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TBivectorHelper.SameValue(const AValue: TMultivector): boolean;
begin
  result := FValue.SameValue(AValue.FValue);
end;

function TBivectorHelper.SameValue(const AValue: TBivector): boolean;
begin
  result := FValue.SameValue(AValue.FValue);
end;

function TBivectorHelper.ExtractBivector(AComponents: TMultivectorComponents): TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractBivector(AComponents);
end;

function TBivectorHelper.ToMultivector: TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TVectorHelper

{$IFDEF USEADIM}
function TVectorHelper.Dual: TBivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Dual;
end;

function TVectorHelper.Inverse: TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Inverse;
end;

function TVectorHelper.Reverse: TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reverse;
end;

function TVectorHelper.Conjugate: TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Conjugate;
end;

function TVectorHelper.Reciprocal: TVector;
begin
  result.FUnitOfMeasurement := DivTable[cScalar, FUnitOfMeasurement];
  result.FValue := FValue.Reciprocal;
end;

function TVectorHelper.Normalized: TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Normalized;
end;

function TVectorHelper.Norm: TScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Norm;
end;

function TVectorHelper.SquaredNorm: TScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := FValue.SquaredNorm;
end;

function TVectorHelper.Dot(const AVector: TVector): TScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVectorHelper.Dot(const AVector: TBivector): TVector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVectorHelper.Dot(const AVector: TTrivector): TBivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVectorHelper.Dot(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVectorHelper.Wedge(const AVector: TVector): TBivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TVectorHelper.Wedge(const AVector: TBivector): TTrivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TVectorHelper.Wedge(const AVector: TTrivector): TScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TVectorHelper.Wedge(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TVectorHelper.Projection(const AVector: TVector): TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TVectorHelper.Projection(const AVector: TBivector): TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TVectorHelper.Projection(const AVector: TTrivector): TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TVectorHelper.Projection(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TVectorHelper.Rejection(const AVector: TVector): TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function  TVectorHelper.Rejection(const AVector: TBivector): TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TVectorHelper.Rejection(const AVector: TTrivector): TScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TVectorHelper.Rejection(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TVectorHelper.Reflection(const AVector: TVector): TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TVectorHelper.Reflection(const AVector: TBivector): TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TVectorHelper.Reflection(const AVector: TTrivector): TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TVectorHelper.Reflection(const AVector: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TVectorHelper.Rotation(const AVector1, AVector2: TVector): TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TVectorHelper.Rotation(const AVector1, AVector2: TBivector): TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TVectorHelper.Rotation(const AVector1, AVector2: TTrivector): TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TVectorHelper.Rotation(const AVector1, AVector2: TMultivector): TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TVectorHelper.Cross(const AVector: TVector): TVector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Cross(AVector.FValue);
end;

function TVectorHelper.SameValue(const AValue: TMultivector): boolean;
begin
  result := FValue.SameValue(AValue.FValue);
end;

function TVectorHelper.SameValue(const AValue: TVector): boolean;
begin
  result := FValue.SameValue(AValue.FValue);
end;

function TVectorHelper.ExtractVector(AComponents: TMultivectorComponents): TVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractVector(AComponents);
end;

function TVectorHelper.ToMultivector: TMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

{ TUnit }

class operator TUnit.*(const AQuantity: double; const ASelf: TUnit): TScalar; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := U.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: double; const ASelf: TUnit): TScalar; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: CL3.TVector; const ASelf: TSelf): TVector; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := U.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: CL3.TVector; const ASelf: TSelf): TVector; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: CL3.TBivector; const ASelf: TSelf): TBivector; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := U.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: CL3.TBivector; const ASelf: TSelf): TBivector; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: CL3.TTrivector; const ASelf: TSelf): TTrivector; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := U.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: CL3.TTrivector; const ASelf: TSelf): TTrivector; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: CL3.TMultivector; const ASelf: TSelf): TMultivector; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := U.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: CL3.TMultivector; const ASelf: TSelf): TMultivector; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

{$IFDEF USEADIM}
class operator TUnit.*(const AQuantity: TScalar; const ASelf: TUnit): TScalar; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TScalar; const ASelf: TUnit): TScalar; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TVector; const ASelf: TSelf): TVector; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TVector; const ASelf: TSelf): TVector; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TBivector; const ASelf: TSelf): TBivector; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TBivector; const ASelf: TSelf): TBivector; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TTrivector; const ASelf: TSelf): TTrivector; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TTrivector; const ASelf: TSelf): TTrivector; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TMultivector; const ASelf: TSelf): TMultivector; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TMultivector; const ASelf: TSelf): TMultivector; inline;
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

function TUnit.GetValue(const AValue: double; const APrefixes: TPrefixes): double;
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
      result := AValue * IntPower(10, Exponent)
    else
      result := AValue;

  end else
    if PrefixCount = 0 then
      result := AValue
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

procedure TUnit.Check(var AQuantity: TScalar);
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TUnit.ToFloat(const AQuantity: TScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnit.ToFloat(const AQuantity: TScalar; const APrefixes: TPrefixes): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}  
end;

function TUnit.ToString(const AQuantity: TScalar): string;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(AQuantity.FValue) + ' ' + GetSymbol(U.FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity) + ' ' + GetSymbol(U.FPrefixes);
{$ENDIF}
end;

function TUnit.ToString(const AQuantity: TScalar; const APrefixes: TPrefixes): string;
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

function TUnit.ToString(const AQuantity: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TUnit.ToString(const AQuantity, ATolerance: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TUnit.ToVerboseString(const AQuantity: TScalar): string;
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

function TUnit.ToVerboseString(const AQuantity: TScalar; const APrefixes: TPrefixes): string;
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

function TUnit.ToVerboseString(const AQuantity: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TUnit.ToVerboseString(const AQuantity, ATolerance: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

class operator TFactoredUnit.*(const AValue: double; const ASelf: TFactoredUnit): TScalar; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := U.FUnitOfMeasurement;
  result.FValue := U.PutValue(AValue);
{$ELSE}
  result := U.PutValue(AValue);
{$ENDIF}
end;

class operator TFactoredUnit./(const AValue: double; const ASelf: TFactoredUnit): TScalar; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := U.PutValue(AValue);
{$ELSE}
  result := U.PutValue(AValue);
{$ENDIF}
end;

{$IFDEF USEADIM}
class operator TFactoredUnit.*(const AQuantity: TScalar; const ASelf: TFactoredUnit): TScalar; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := U.PutValue(AQuantity.FValue);
end;

class operator TFactoredUnit./(const AQuantity: TScalar; const ASelf: TFactoredUnit): TScalar; inline;
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

function TFactoredUnit.GetValue(const AValue: double; const APrefixes: TPrefixes): double;
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
      result := AValue * IntPower(10, Exponent)
    else
      result := AValue;

  end else
    if PrefixCount = 0 then
      result := AValue
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

procedure TFactoredUnit.Check(var AQuantity: TScalar);
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TFactoredUnit.ToFloat(const AQuantity: TScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := U.GetValue(AQuantity.FValue);
{$ELSE}
  result := U.GetValue(AQuantity);
{$ENDIF}  
end;

function TFactoredUnit.ToFloat(const AQuantity: TScalar; const APrefixes: TPrefixes): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(U.GetValue(AQuantity.FValue), APrefixes);
{$ELSE}
  result := GetValue(U.GetValue(AQuantity), APrefixes);
{$ENDIF}  
end;

function TFactoredUnit.ToString(const AQuantity: TScalar): string;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(U.GetValue(AQuantity.FValue)) + ' ' + GetSymbol(U.FPrefixes);
{$ELSE}
  result := FloatToStr(U.GetValue(AQuantity)) + ' ' + GetSymbol(U.FPrefixes);
{$ENDIF}
end;

function TFactoredUnit.ToString(const AQuantity: TScalar; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToString(const AQuantity: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToString(const AQuantity, ATolerance: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToVerboseString(const AQuantity: TScalar): string;
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

function TFactoredUnit.ToVerboseString(const AQuantity: TScalar; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToVerboseString(const AQuantity: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

function TFactoredUnit.ToVerboseString(const AQuantity, ATolerance: TScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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

  �+  <   ��
 C L 3 0 - S E C T I O N - B 4                 
{ Power functions }

function SquarePower(const AQuantity: TScalar): TScalar;
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

function CubicPower(const AQuantity: TScalar): TScalar;
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

function QuarticPower(const AQuantity: TScalar): TScalar;
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

function QuinticPower(const AQuantity: TScalar): TScalar;
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

function SexticPower(const AQuantity: TScalar): TScalar;
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

function SquareRoot(const AQuantity: TScalar): TScalar;
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

function CubicRoot(const AQuantity: TScalar): TScalar;
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

function QuarticRoot(const AQuantity: TScalar): TScalar;
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

function QuinticRoot(const AQuantity: TScalar): TScalar;
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

function SexticRoot(const AQuantity: TScalar): TScalar;
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

function Cos(const AQuantity: TScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Cos routine has detected wrong units of measurements.');

  result := System.Cos(AQuantity.FValue);
{$ELSE}
  result := System.Cos(AQuantity);
{$ENDIF}
end;

function Sin(const AQuantity: TScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Sin routine has detected wrong units of measurements.');

  result := System.Sin(AQuantity.FValue);
{$ELSE}
  result := System.Sin(AQuantity);
{$ENDIF}
end;

function Tan(const AQuantity: TScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Tan routine has detected wrong units of measurements.');

  result := Math.Tan(AQuantity.FValue);
{$ELSE}
  result := Math.Tan(AQuantity);
{$ENDIF}
end;

function Cotan(const AQuantity: TScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Cotan routine has detected wrong units of measurements.');

  result := Math.Cotan(AQuantity.FValue);
{$ELSE}
  result := Math.Cotan(AQuantity);
{$ENDIF}
end;

function Secant(const AQuantity: TScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Setan routine has detected wrong units of measurements.');

  result := Math.Secant(AQuantity.FValue);
{$ELSE}
  result := Math.Secant(AQuantity);
{$ENDIF}
end;

function Cosecant(const AQuantity: TScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Cosecant routine has detected wrong units of measurements.');

  result := Math.Cosecant(AQuantity.FValue);
{$ELSE}
  result := Math.Cosecant(AQuantity);
{$ENDIF}
end;

function ArcCos(const AValue: double): TScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcCos(AValue);
{$ELSE}
  result := Math.ArcCos(AValue);
{$ENDIF}
end;

function ArcSin(const AValue: double): TScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcSin(AValue);
{$ELSE}
  result := Math.ArcSin(AValue);
{$ENDIF}
end;

function ArcTan(const AValue: double): TScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := System.ArcTan(AValue);
{$ELSE}
  result := System.ArcTan(AValue);
{$ENDIF}
end;

function ArcTan2(const x, y: double): TScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcTan2(x, y);
{$ELSE}
  result := Math.ArcTan2(x, y);
{$ENDIF}
end;

{ Math functions }


function Min(const ALeft, ARight: TScalar): TScalar;
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

function Max(const ALeft, ARight: TScalar): TScalar;
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

function Exp(const AQuantity: TScalar): TScalar;
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

function Log10(const AQuantity : TScalar) : double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Log10 routine has detected wrong units of measurements.');

  result := Math.Log10(AQuantity.FValue);
{$ELSE}  
  result := Math.Log10(AQuantity);
{$ENDIF}
end;

function Log2(const AQuantity : TScalar) : double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Log2 routine has detected wrong units of measurements.');

  result := Math.Log2(AQuantity.FValue);
{$ELSE} 
  result := Math.Log2(AQuantity);
{$ENDIF}
end;

function LogN(ABase: longint; const AQuantity: TScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  result := Math.LogN(ABase, AQuantity.FValue);
{$ELSE} 
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function LogN(const ABase, AQuantity: TScalar): double;
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

function Power(const ABase: TScalar; AExponent: double): double;
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

function LessThanOrEqualToZero(const AQuantity: TScalar): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue <= 0;
{$ELSE}  
  result := AQuantity <= 0;
{$ENDIF}
end;

function LessThanZero(const AQuantity: TScalar): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue < 0;
{$ELSE}  
  result := AQuantity < 0;
{$ENDIF}
end;

function EqualToZero(const AQuantity: TScalar): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue = 0;
{$ELSE} 
  result := AQuantity = 0;
{$ENDIF}
end;

function NotEqualToZero(const AQuantity: TScalar): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue <> 0;
{$ELSE}
  result := AQuantity <> 0;
{$ENDIF}
end;

function GreaterThanOrEqualToZero(const AQuantity: TScalar): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue >= 0;
{$ELSE}
  result := AQuantity >= 0;
{$ENDIF}
end;

function GreaterThanZero(const AQuantity: TScalar): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue > 0;
{$ELSE}
  result := AQuantity > 0;
{$ENDIF}
end;

function SameValue(const ALeft, ARight: TScalar): boolean;
begin
{$IFDEF USEADIM}
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('SameValue routine has detected wrong units of measurements.');

  result := Math.SameValue(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.SameValue(ALeft, ARight);
{$ENDIF}
end;

   �      �� ��               (       @             d   d                                                                                                                                                                                                                                                                                           Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu����������ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ�������������Ӥu�                                    Ӥu����������ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ�������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu����������ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ�������������Ӥu�                                    Ӥu����������ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ�������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu���������������������������������������������������������������������������������޻��ը|�                                    Ӥu�����������������������������������������������������������������������������޼��֨{�ےm                                    Ӥu�������������������������������������������������������������������������޼��֨{�ےm                                        Ӥu���������������������������������������������������������������������޼��֨{�ےm                                            Ӥu�����������������������������������������������������������������޽��֨|�ےm                                                Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�֩}�ժ�                                                                                                                                                                                                                                                                                                                                                                                                                                    