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
</assembly>   0   �� M A I N I C O N                              �   �  4   ��
 S E C T I O N - A 0                   {
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
  @  4   ��
 S E C T I O N - A 1                   
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

�  4   ��
 S E C T I O N - A 4                   { Power functions }

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

   �i  4   ��
 S E C T I O N - B 1                   
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

{*  4   ��
 S E C T I O N - B 4                   
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

    4   ��
 S E C T I O N - B 0                   implementation

uses Math;  �      �� ��               (       @             d   d                                                                                                                                                                                                                                                                                           Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu����������ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ�������������Ӥu�                                    Ӥu����������ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ�������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu����������ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ�������������Ӥu�                                    Ӥu����������ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ�������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu���������������������������������������������������������������������������������޻��ը|�                                    Ӥu�����������������������������������������������������������������������������޼��֨{�ےm                                    Ӥu�������������������������������������������������������������������������޼��֨{�ےm                                        Ӥu���������������������������������������������������������������������޼��֨{�ےm                                            Ӥu�����������������������������������������������������������������޽��֨|�ےm                                                Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�֩}�ժ�                                                                                                                                                                                                                                                                                                                                                                                                                                    