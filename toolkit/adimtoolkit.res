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
</assembly>   0   �� M A I N I C O N                              �     4   ��
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
P  4   ��
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








�  4   ��
 S E C T I O N - A 4                   { Power functions }

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

   �Z  4   ��
 S E C T I O N - B 1                   
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
end
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




 }  4   ��
 S E C T I O N - B 4                   
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
      4   ��
 S E C T I O N - B 0                   implementation

uses Math;�      �� ��               (       @             d   d                                                                                                                                                                                                                                                                                           Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu����������ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ�������������Ӥu�                                    Ӥu����������ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ�������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu����������ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ�������������Ӥu�                                    Ӥu����������ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ�������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu���������������������������������������������������������������������������������޻��ը|�                                    Ӥu�����������������������������������������������������������������������������޼��֨{�ےm                                    Ӥu�������������������������������������������������������������������������޼��֨{�ےm                                        Ӥu���������������������������������������������������������������������޼��֨{�ےm                                            Ӥu�����������������������������������������������������������������޽��֨|�ےm                                                Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�֩}�ժ�                                                                                                                                                                                                                                                                                                                                                                                                                                    