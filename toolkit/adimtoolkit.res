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
</assembly>   0   �� M A I N I C O N                              �     <   ��
 C L 0 0 - S E C T I O N - A 0                 {
  Description: ADim (CL3) Run-time library.

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
  u#  <   ��
 C L 0 0 - S E C T I O N - A 1                 
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

  { TAScalar }

  {$IFDEF ADIMDEBUG}
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
    class operator :=(const AValue: double): TAScalar;
  end;
  {$ELSE}
  TAScalar = double;
  {$ENDIF}

  
  

  

 

  

 

 

  

  { TUnit }

  TUnit = record
  private
    FUnitOfMeasurement: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    class operator *(const AQuantity: double; const ASelf: TUnit): TAScalar; inline;
    class operator /(const AQuantity: double; const ASelf: TUnit): TAScalar; inline;
  {$IFDEF ADIMDEBUG}
    class operator *(const AQuantity: TAScalar; const ASelf: TUnit): TAScalar; inline;
    class operator /(const AQuantity: TAScalar; const ASelf: TUnit): TAScalar; inline;
  {$ENDIF}
  end;

  { TFactoredUnit }

  TFactoredUnit = record
  private
    FUnitOfMeasurement: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
    FFactor: double; 
  public
    class operator *(const AQuantity: double; const ASelf: TFactoredUnit): TAScalar; inline;
    class operator /(const AQuantity: double; const ASelf: TFactoredUnit): TAScalar; inline;
  {$IFDEF ADIMDEBUG}
    class operator *(const AQuantity: TAScalar; const ASelf: TFactoredUnit): TAScalar; inline;
    class operator /(const AQuantity: TAScalar; const ASelf: TFactoredUnit): TAScalar; inline;
  {$ENDIF}
  end;

  { TDegreeCelsiusUnit }

  TDegreeCelsiusUnit = record
  private
    FUnitOfMeasurement: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    class operator *(const AQuantity: double; const ASelf: TDegreeCelsiusUnit): TAScalar; inline;
  end;

  { TDegreeFahrenheitUnit }

  TDegreeFahrenheitUnit = record
  private
    FUnitOfMeasurement: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    class operator *(const AQuantity: double; const ASelf: TDegreeFahrenheitUnit): TAScalar; inline;
  end;   

 { TUnitHelper }

  TUnitHelper = record helper for TUnit
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
  end;

 { TFactoredUnitHelper }

  TFactoredUnitHelper = record helper for TFactoredUnit
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
  end;

 { TDegreeCelsiusUnitHelper }

  TDegreeCelsiusUnitHelper = record helper for TDegreeCelsiusUnit
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
  end;

 { TDegreeFahrenheitUnitHelper }

  TDegreeFahrenheitUnitHelper = record helper for TDegreeFahrenheitUnit
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
  end;
  
     -  <   ��
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

function ArcCos(const AValue: double): TAScalar;
function ArcSin(const AValue: double): TAScalar;
function ArcTan(const AValue: double): TAScalar;
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
  AvogadroConstant               : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: ReciprocalMoleId;                     FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}
  BohrMagneton                   : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: SquareMeterAmpereId;                  FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}
  BohrRadius                     : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: MeterId;                              FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}
  BoltzmannConstant              : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: JoulePerKelvinId;                     FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}
  ComptonWaveLength              : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: MeterId;                              FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}
  CoulombConstant                : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: NewtonSquareMeterPerSquareCoulombId;  FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}
  DeuteronMass                   : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}
  ElectricPermittivity           : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: FaradPerMeterId;                      FValue:     8.8541878128E-12); {$ELSE} (    8.8541878128E-12); {$ENDIF}
  ElectronMass                   : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}
  ElectronCharge                 : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: CoulombId;                            FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}
  MagneticPermeability           : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: HenryPerMeterId;                      FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}
  MolarGasConstant               : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: JoulePerMolePerKelvinId;              FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}
  NeutronMass                    : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}
  NewtonianConstantOfGravitation : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: NewtonSquareMeterPerSquareKilogramId; FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}
  PlanckConstant                 : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramSquareMeterPerSecondId;       FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}
  ProtonMass                     : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}
  RydbergConstant                : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: ReciprocalMeterId;                    FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}
  SpeedOfLight                   : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: MeterPerSecondId;                     FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}
  SquaredSpeedOfLight            : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: SquareMeterPerSquareSecondId;         FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}
  StandardAccelerationOfGravity  : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: MeterPerSquareSecondId;               FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}
  ReducedPlanckConstant          : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramSquareMeterPerSecondId;       FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}
  UnifiedAtomicMassUnit          : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}

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
 C L 0 0 - S E C T I O N - B 0                 implementation

uses Math;q�  <   ��
 C L 0 0 - S E C T I O N - B 1                 { TAScalar }

{$IFDEF ADIMDEBUG}
class operator TAScalar.:=(const AValue: double): TAScalar;
begin
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := AValue;
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
  result.FUnitOfMeasurement := DivTable[ScalarId, ARight.FUnitOfMeasurement];
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
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: double; const ASelf: TUnit): TAScalar; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

{$IFDEF ADIMDEBUG}
class operator TUnit.*(const AQuantity: TAScalar; const ASelf: TUnit): TAScalar; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TAScalar; const ASelf: TUnit): TAScalar; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

{$ENDIF}

{ TFactoredUnit }

class operator TFactoredUnit.*(const AQuantity: double; const ASelf: TFactoredUnit): TAScalar; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: double; const ASelf: TFactoredUnit): TAScalar; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

{$IFDEF ADIMDEBUG}
class operator TFactoredUnit.*(const AQuantity: TAScalar; const ASelf: TFactoredUnit): TAScalar; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TAScalar; const ASelf: TFactoredUnit): TAScalar; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;
{$ENDIF}

{ TDegreeCelsiusUnit }

class operator TDegreeCelsiusUnit.*(const AQuantity: double; const ASelf: TDegreeCelsiusUnit): TAScalar; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity + 273.15;
{$ELSE}
  result := AQuantity + 273.15;
{$ENDIF}
end;

{ TDegreeFahrenheitUnit }

class operator TDegreeFahrenheitUnit.*(const AQuantity: double; const ASelf: TDegreeFahrenheitUnit): TAScalar; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := 5/9 * (AQuantity - 32) + 273.15;
{$ELSE}
  result := 5/9 * (AQuantity - 32) + 273.15;
{$ENDIF}
end;

{ TUnitHelper }

function TUnitHelper.GetName(const Prefixes: TPrefixes): string;
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

function TUnitHelper.GetPluralName(const Prefixes: TPrefixes): string;
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

function TUnitHelper.GetSymbol(const Prefixes: TPrefixes): string;
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

procedure TUnitHelper.Check(var AQuantity: TAScalar);
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TUnitHelper.ToFloat(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToFloat(const AQuantity: TAScalar; const APrefixes: TPrefixes): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}  
end;

function TUnitHelper.ToString(const AQuantity: TAScalar): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(AQuantity.FValue) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(AQuantity.FValue, APrefixes); 
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
 
  if Length(APrefixes) = 0 then
     result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}  

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
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
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;    

function TUnitHelper.ToVerboseString(const AQuantity: TAScalar): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TUnitHelper.ToVerboseString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TUnitHelper.ToVerboseString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TUnitHelper.ToVerboseString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
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
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

{ TFactoredUnitHelper }

function TFactoredUnitHelper.GetName(const Prefixes: TPrefixes): string;
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

function TFactoredUnitHelper.GetPluralName(const Prefixes: TPrefixes): string;
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

function TFactoredUnitHelper.GetSymbol(const Prefixes: TPrefixes): string;
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

procedure TFactoredUnitHelper.Check(var AQuantity: TAScalar);
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TFactoredUnitHelper.ToFloat(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}  
end;

function TFactoredUnitHelper.ToFloat(const AQuantity: TAScalar; const APrefixes: TPrefixes): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}  
end;

function TFactoredUnitHelper.ToString(const AQuantity: TAScalar): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(AQuantity.FValue / FFactor) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity / FFactor) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

    FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
    FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToString routine has detected wrong units of measurements.'); 

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

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TAScalar): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TFactoredUnitHelper.ToVerboseString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

procedure TDegreeCelsiusUnitHelper.Check(var AQuantity: TAScalar);
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToFloat(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := AQuantity.FValue - 273.15;
{$ELSE}
  result := AQuantity - 273.15;
{$ENDIF}  
end;

function TDegreeCelsiusUnitHelper.ToFloat(const AQuantity: TAScalar; const APrefixes: TPrefixes): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  result := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}  
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TAScalar): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(AQuantity.FValue - 273.15) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity - 273.15) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

    FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
    FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToString routine has detected wrong units of measurements.'); 

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

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TAScalar): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue - 273.15;
{$ELSE}
  FactoredValue := AQuantity - 273.15;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

procedure TDegreeFahrenheitUnitHelper.Check(var AQuantity: TAScalar);
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToFloat(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := 9/5 * AQuantity.FValue - 459.67;
{$ELSE}
  result := 9/5 * AQuantity - 459.67;
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToFloat(const AQuantity: TAScalar; const APrefixes: TPrefixes): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  result := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}  
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TAScalar): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(9/5 * AQuantity.FValue - 459.67) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(9/5 * AQuantity - 459.67) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

    FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
    FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToString routine has detected wrong units of measurements.'); 

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

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TAScalar): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := 9/5 * AQuantity.FValue - 459.67;
{$ELSE}
  FactoredValue := 9/5 * AQuantity - 459.67;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

   =,  <   ��
 C L 0 0 - S E C T I O N - B 4                 
{ Power functions }

function SquarePower(const AQuantity: TAScalar): TAScalar;
begin
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Cos routine has detected wrong units of measurements.');

  result := System.Cos(AQuantity.FValue);
{$ELSE}
  result := System.Cos(AQuantity);
{$ENDIF}
end;

function Sin(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Sin routine has detected wrong units of measurements.');

  result := System.Sin(AQuantity.FValue);
{$ELSE}
  result := System.Sin(AQuantity);
{$ENDIF}
end;

function Tan(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Tan routine has detected wrong units of measurements.');

  result := Math.Tan(AQuantity.FValue);
{$ELSE}
  result := Math.Tan(AQuantity);
{$ENDIF}
end;

function Cotan(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Cotan routine has detected wrong units of measurements.');

  result := Math.Cotan(AQuantity.FValue);
{$ELSE}
  result := Math.Cotan(AQuantity);
{$ENDIF}
end;

function Secant(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Setan routine has detected wrong units of measurements.');

  result := Math.Secant(AQuantity.FValue);
{$ELSE}
  result := Math.Secant(AQuantity);
{$ENDIF}
end;

function Cosecant(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Cosecant routine has detected wrong units of measurements.');

  result := Math.Cosecant(AQuantity.FValue);
{$ELSE}
  result := Math.Cosecant(AQuantity);
{$ENDIF}
end;

function ArcCos(const AValue: double): TAScalar;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := Math.ArcCos(AValue);
{$ELSE}
  result := Math.ArcCos(AValue);
{$ENDIF}
end;

function ArcSin(const AValue: double): TAScalar;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := Math.ArcSin(AValue);
{$ELSE}
  result := Math.ArcSin(AValue);
{$ENDIF}
end;

function ArcTan(const AValue: double): TAScalar;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := System.ArcTan(AValue);
{$ELSE}
  result := System.ArcTan(AValue);
{$ENDIF}
end;

function ArcTan2(const x, y: double): TAScalar;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := Math.ArcTan2(x, y);
{$ELSE}
  result := Math.ArcTan2(x, y);
{$ENDIF}
end;

{ Math functions }


function Min(const ALeft, ARight: TAScalar): TAScalar;
begin
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Exp routine has detected wrong units of measurements.');

  result.FUnitOfMeasurement := ScalarId;
  result.FValue := System.Exp(AQuantity.FValue);
{$ELSE}
  result := System.Exp(AQuantity);
{$ENDIF}
end;

function Log10(const AQuantity : TAScalar) : double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Log10 routine has detected wrong units of measurements.');

  result := Math.Log10(AQuantity.FValue);
{$ELSE}  
  result := Math.Log10(AQuantity);
{$ENDIF}
end;

function Log2(const AQuantity : TAScalar) : double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Log2 routine has detected wrong units of measurements.');

  result := Math.Log2(AQuantity.FValue);
{$ELSE} 
  result := Math.Log2(AQuantity);
{$ENDIF}
end;

function LogN(ABase: longint; const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  result := Math.LogN(ABase, AQuantity.FValue);
{$ELSE} 
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function LogN(const ABase, AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if ABase.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  result := Math.LogN(ABase.FValue, AQuantity.FValue);
{$ELSE} 
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function Power(const ABase: TAScalar; AExponent: double): double;
begin
{$IFDEF ADIMDEBUG}
  if ABase.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Power routine has detected wrong units of measurements.');

   result := Math.Power(ABase.FValue, AExponent);
{$ELSE}
  result := Math.Power(ABase, AExponent);
{$ENDIF}
end;

{ Helper functions }

function LessThanOrEqualToZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue <= 0;
{$ELSE}  
  result := AQuantity <= 0;
{$ENDIF}
end;

function LessThanZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue < 0;
{$ELSE}  
  result := AQuantity < 0;
{$ENDIF}
end;

function EqualToZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue = 0;
{$ELSE} 
  result := AQuantity = 0;
{$ENDIF}
end;

function NotEqualToZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue <> 0;
{$ELSE}
  result := AQuantity <> 0;
{$ENDIF}
end;

function GreaterThanOrEqualToZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue >= 0;
{$ELSE}
  result := AQuantity >= 0;
{$ENDIF}
end;

function GreaterThanZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue > 0;
{$ELSE}
  result := AQuantity > 0;
{$ENDIF}
end;

function SameValue(const ALeft, ARight: TAScalar): boolean;
begin
{$IFDEF ADIMDEBUG}
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('SameValue routine has detected wrong units of measurements.');

  result := Math.SameValue(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.SameValue(ALeft, ARight);
{$ENDIF}
end;

     <   ��
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
   I�  <   ��
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

  { TAScalar }

  {$IFDEF ADIMDEBUG}
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
    class operator :=(const AValue: double): TAScalar;
  end;
  {$ELSE}
  TAScalar = double;
  {$ENDIF}

  { TAMultivector }

  {$IFDEF ADIMDEBUG}
  TAMultivector = record
  private
    FUnitOfMeasurement: longint;
    FValue: TMultivector;
  public
    class operator :=(const AValue: TAScalar): TAMultivector;
    class operator <>(const ALeft, ARight: TAMultivector): boolean;
    class operator <>(const ALeft: TAMultivector; const ARight: TAScalar): boolean;
    class operator <>(const ALeft: TAScalar; const ARight: TAMultivector): boolean;

    class operator = (const ALeft, ARight: TAMultivector): boolean;
    class operator = (const ALeft: TAMultivector; const ARight: TAScalar): boolean;
    class operator = (const ALeft: TAScalar; const ARight: TAMultivector): boolean;

    class operator + (const ALeft, ARight: TAMultivector): TAMultivector;
    class operator + (const ALeft: TAMultivector; const ARight: TAScalar): TAMultivector;
    class operator + (const ALeft: TAScalar; const ARight: TAMultivector): TAMultivector;

    class operator - (const ASelf: TAMultivector): TAMultivector;
    class operator - (const ALeft, ARight: TAMultivector): TAMultivector;
    class operator - (const ALeft: TAMultivector; const ARight: TAScalar): TAMultivector;
    class operator - (const ALeft: TAScalar; const ARight: TAMultivector): TAMultivector;

    class operator * (const ALeft, ARight: TAMultivector): TAMultivector;
    class operator * (const ALeft: TAMultivector; const ARight: TAScalar): TAMultivector;
    class operator * (const ALeft: TAScalar; const ARight: TAMultivector): TAMultivector;

    class operator / (const ALeft, ARight: TAMultivector): TAMultivector;
    class operator / (const ALeft: TAMultivector; const ARight: TAScalar): TAMultivector;
    class operator / (const ALeft: TAScalar; const ARight: TAMultivector): TAMultivector;
  end;
  {$ELSE}
  TAMultivector = TMultivector;
  {$ENDIF}

  { TATrivector }

  {$IFDEF ADIMDEBUG}
  TATrivector = record
  private
    FUnitOfMeasurement: longint;
    FValue: TTrivector;
  public
    class operator :=(const AValue: TATrivector): TAMultivector;
    class operator <>(const ALeft, ARight: TATrivector): boolean;
    class operator <>(const ALeft: TATrivector; const ARight: TAMultivector): boolean;
    class operator <>(const ALeft: TAMultivector; const ARight: TATrivector): boolean;

    class operator = (const ALeft, ARight: TATrivector): boolean;
    class operator = (const ALeft: TATrivector; const ARight: TAMultivector): boolean;
    class operator = (const ALeft: TAMultivector; const ARight: TATrivector): boolean;

    class operator + (const ALeft, ARight: TATrivector): TATrivector;
    class operator + (const ALeft: TATrivector; const ARight: TAScalar): TAMultivector;
    class operator + (const ALeft: TAScalar; const ARight: TATrivector): TAMultivector;
    class operator + (const ALeft: TATrivector; const ARight: TAMultivector): TAMultivector;
    class operator + (const ALeft: TAMultivector; const ARight: TATrivector): TAMultivector;

    class operator - (const ASelf: TATrivector): TATrivector;
    class operator - (const ALeft, ARight: TATrivector): TATrivector;
    class operator - (const ALeft: TATrivector; const ARight: TAScalar): TAMultivector;
    class operator - (const ALeft: TAScalar; const ARight: TATrivector): TAMultivector;
    class operator - (const ALeft: TATrivector; const ARight: TAMultivector): TAMultivector;
    class operator - (const ALeft: TAMultivector; const ARight: TATrivector): TAMultivector;

    class operator * (const ALeft, ARight: TATrivector): TAScalar;
    class operator * (const ALeft: TAScalar; const ARight: TATrivector): TATrivector;
    class operator * (const ALeft: TATrivector; const ARight: TAScalar): TATrivector;
    class operator * (const ALeft: TATrivector; const ARight: TAMultivector): TAMultivector;
    class operator * (const ALeft: TAMultivector; const ARight: TATrivector): TAMultivector;

    class operator / (const ALeft, ARight: TATrivector): TAScalar;
    class operator / (const ALeft: TATrivector; const ARight: TAScalar): TATrivector;
    class operator / (const ALeft: TAScalar; const ARight: TATrivector): TATrivector;
    class operator / (const ALeft: TATrivector; const ARight: TAMultivector): TAMultivector;
    class operator / (const ALeft: TAMultivector; const ARight: TATrivector): TAMultivector;
  end;
  {$ELSE}
  TATrivector = TTrivector;
  {$ENDIF}

  { TABivector }

  {$IFDEF ADIMDEBUG}
  TABivector = record
  private
    FUnitOfMeasurement: longint;
    FValue: TBivector;
  public
    class operator :=(const AValue: TABivector): TAMultivector;
    class operator <>(const ALeft, ARight: TABivector): boolean;
    class operator <>(const ALeft: TABivector; const ARight: TAMultivector): boolean;
    class operator <>(const ALeft: TAMultivector; const ARight: TABivector): boolean;

    class operator = (const ALeft, ARight: TABivector): boolean;
    class operator = (const ALeft: TABivector; const ARight: TAMultivector): boolean;
    class operator = (const ALeft: TAMultivector; const ARight: TABivector): boolean;

    class operator + (const ALeft, ARight: TABivector): TABivector;
    class operator + (const ALeft: TABivector; const ARight: TAScalar): TAMultivector;
    class operator + (const ALeft: TAScalar; const ARight: TABivector): TAMultivector;
    class operator + (const ALeft: TABivector; const ARight: TATrivector): TAMultivector;
    class operator + (const ALeft: TATrivector; const ARight: TABivector): TAMultivector;
    class operator + (const ALeft: TABivector; const ARight: TAMultivector): TAMultivector;
    class operator + (const ALeft: TAMultivector; const ARight: TABivector): TAMultivector;

    class operator - (const ASelf: TABivector): TABivector;
    class operator - (const ALeft, ARight: TABivector): TABivector;
    class operator - (const ALeft: TABivector; const ARight: TAScalar): TAMultivector;
    class operator - (const ALeft: TAScalar; const ARight: TABivector): TAMultivector;
    class operator - (const ALeft: TABivector; const ARight: TATrivector): TAMultivector;
    class operator - (const ALeft: TATrivector; const ARight: TABivector): TAMultivector;
    class operator - (const ALeft: TABivector; const ARight: TAMultivector): TAMultivector;
    class operator - (const ALeft: TAMultivector; const ARight: TABivector): TAMultivector;

    class operator * (const ALeft, ARight: TABivector): TAMultivector;
    class operator * (const ALeft: TAScalar; const ARight: TABivector): TABivector;
    class operator * (const ALeft: TABivector; const ARight: TAScalar): TABivector;
    class operator * (const ALeft: TABivector; const ARight: TAMultivector): TAMultivector;
    class operator * (const ALeft: TABivector; const ARight: TATrivector): TAMultivector;
    class operator * (const ALeft: TATrivector; const ARight: TABivector): TAMultivector;
    class operator * (const ALeft: TAMultivector; const ARight: TABivector): TAMultivector;

    class operator / (const ALeft, ARight: TABivector): TAMultivector;
    class operator / (const ALeft: TABivector; const ARight: TAScalar): TABivector;
    class operator / (const ALeft: TAScalar; const ARight: TABivector): TABivector;
    class operator / (const ALeft: TABivector; const ARight: TATrivector): TAMultivector;
    class operator / (const ALeft: TATrivector; const ARight: TABivector): TAMultivector;
    class operator / (const ALeft: TABivector; const ARight: TAMultivector): TAMultivector;
    class operator / (const ALeft: TAMultivector; const ARight: TABivector): TAMultivector;
  end;
  {$ELSE}
  TABivector = TBivector;
  {$ENDIF}

  { TAVector }

  {$IFDEF ADIMDEBUG}
  TAVector = record
  private
    FUnitOfMeasurement: longint;
    FValue: TVector;
  public
    class operator :=(const AValue: TAVector): TAMultivector;
    class operator <>(const ALeft, ARight: TAVector): boolean;
    class operator <>(const ALeft: TAVector; const ARight: TAMultivector): boolean;
    class operator <>(const ALeft: TAMultivector; const ARight: TAVector): boolean;

    class operator = (const ALeft, ARight: TAVector): boolean;
    class operator = (const ALeft: TAVector; const ARight: TAMultivector): boolean;
    class operator = (const ALeft: TAMultivector; const ARight: TAVector): boolean;

    class operator + (const ALeft, ARight: TAVector): TAVector;
    class operator + (const ALeft: TAVector; const ARight: TAScalar): TAMultivector;
    class operator + (const ALeft: TAScalar; const ARight: TAVector): TAMultivector;
    class operator + (const ALeft: TAVector; const ARight: TABivector): TAMultivector;
    class operator + (const ALeft: TABivector; const ARight: TAVector): TAMultivector;
    class operator + (const ALeft: TAVector; const ARight: TATrivector): TAMultivector;
    class operator + (const ALeft: TATrivector; const ARight: TAVector): TAMultivector;
    class operator + (const ALeft: TAVector; const ARight: TAMultivector): TAMultivector;
    class operator + (const ALeft: TAMultivector; const ARight: TAVector): TAMultivector;

    class operator - (const ASelf: TAVector): TAVector;
    class operator - (const ALeft, ARight: TAVector): TAVector;
    class operator - (const ALeft: TAVector; const ARight: TAScalar): TAMultivector;
    class operator - (const ALeft: TAScalar; const ARight: TAVector): TAMultivector;
    class operator - (const ALeft: TAVector; const ARight: TABivector): TAMultivector;
    class operator - (const ALeft: TABivector; const ARight: TAVector): TAMultivector;
    class operator - (const ALeft: TAVector; const ARight: TATrivector): TAMultivector;
    class operator - (const ALeft: TATrivector; const ARight: TAVector): TAMultivector;
    class operator - (const ALeft: TAVector; const ARight: TAMultivector): TAMultivector;
    class operator - (const ALeft: TAMultivector; const ARight: TAVector): TAMultivector;

    class operator * (const ALeft, ARight: TAVector): TAMultivector;
    class operator * (const ALeft: TAScalar; const ARight: TAVector): TAVector;
    class operator * (const ALeft: TAVector; const ARight: TAScalar): TAVector;
    class operator * (const ALeft: TAVector; const ARight: TABivector): TAMultivector;
    class operator * (const ALeft: TAVector; const ARight: TATrivector): TABivector;
    class operator * (const ALeft: TAVector; const ARight: TAMultivector): TAMultivector;
    class operator * (const ALeft: TABivector; const ARight: TAVector): TAMultivector;
    class operator * (const ALeft: TATrivector; const ARight: TAVector): TABivector;
    class operator * (const ALeft: TAMultivector; const ARight: TAVector): TAMultivector;

    class operator / (const ALeft: TAScalar; const ARight: TAVector): TAVector;
    class operator / (const ALeft: TAVector; const ARight: TAScalar): TAVector;
    class operator / (const ALeft, ARight: TAVector): TAMultivector;
    class operator / (const ALeft: TAVector; const ARight: TABivector): TAMultivector;
    class operator / (const ALeft: TAVector; const ARight: TATrivector): TABivector;
    class operator / (const ALeft: TAVector; const ARight: TAMultivector): TAMultivector;
    class operator / (const ALeft: TABivector; const ARight: TAVector): TAMultivector;
    class operator / (const ALeft: TATrivector; const ARight: TAVector): TABivector;
    class operator / (const ALeft: TAMultivector; const ARight: TAVector): TAMultivector;
  end;
  {$ELSE}
  TAVector = TVector;
  {$ENDIF}

  { TAMultivectorHelper }

  {$IFDEF ADIMDEBUG}
  TAMultivectorHelper = record helper for TAMultivector
    function Dual: TAMultivector;
    function Inverse: TAMultivector;
    function Reverse: TAMultivector;
    function Conjugate: TAMultivector;
    function Reciprocal: TAMultivector;
    function LeftReciprocal: TAMultivector;
    function Normalized: TAMultivector;
    function Norm: TAScalar;
    function SquaredNorm: TAScalar;

    function Dot(const AVector: TAVector): TAMultivector; overload;
    function Dot(const AVector: TABivector): TAMultivector; overload;
    function Dot(const AVector: TATrivector): TAMultivector; overload;
    function Dot(const AVector: TAMultivector): TAMultivector; overload;

    function Wedge(const AVector: TAVector): TAMultivector; overload;
    function Wedge(const AVector: TABivector): TAMultivector; overload;
    function Wedge(const AVector: TATrivector): TATrivector; overload;
    function Wedge(const AVector: TAMultivector): TAMultivector; overload;

    function Projection(const AVector: TAVector): TAMultivector; overload;
    function Projection(const AVector: TABivector): TAMultivector; overload;
    function Projection(const AVector: TATrivector): TAMultivector; overload;
    function Projection(const AVector: TAMultivector): TAMultivector; overload;

    function Rejection(const AVector: TAVector): TAMultivector; overload;
    function Rejection(const AVector: TABivector): TAMultivector; overload;
    function Rejection(const AVector: TATrivector): TAScalar; overload;
    function Rejection(const AVector: TAMultivector): TAMultivector; overload;

    function Reflection(const AVector: TAVector): TAMultivector; overload;
    function Reflection(const AVector: TABivector): TAMultivector; overload;
    function Reflection(const AVector: TATrivector): TAMultivector; overload;
    function Reflection(const AVector: TAMultivector): TAMultivector; overload;

    function Rotation(const AVector1, AVector2: TAVector): TAMultivector; overload;
    function Rotation(const AVector1, AVector2: TABivector): TAMultivector; overload;
    function Rotation(const AVector1, AVector2: TATrivector): TAMultivector; overload;
    function Rotation(const AVector1, AVector2: TAMultivector): TAMultivector;overload;

    function SameValue(const AVector: TAMultivector): boolean;
    function SameValue(const AVector: TATrivector): boolean;
    function SameValue(const AVector: TABivector): boolean;
    function SameValue(const AVector: TAVector): boolean;
    function SameValue(const AVector: TAScalar): boolean;

    function ExtractMultivector(AComponents: TMultivectorComponents): TAMultivector;
    function ExtractBivector(AComponents: TMultivectorComponents): TABivector;
    function ExtractVector(AComponents: TMultivectorComponents): TAVector;

    function ExtractTrivector: TATrivector;
    function ExtractBivector: TABivector;
    function ExtractVector: TAVector;
    function ExtractScalar: TAScalar;

    function IsNull: boolean;
    function IsScalar: boolean;
    function IsVector: boolean;
    function IsBiVector: boolean;
    function IsTrivector: boolean;
    function IsA: string;
  end;
  {$ENDIF}

  { TATrivectorHelper }

  {$IFDEF ADIMDEBUG}
  TATrivectorHelper = record helper for TATrivector
    function Dual: TAScalar;
    function Inverse: TATrivector;
    function Reverse: TATrivector;
    function Conjugate: TATrivector;
    function Reciprocal: TATrivector;
    function Normalized: TATrivector;
    function Norm: TAScalar;
    function SquaredNorm: TAScalar;

    function Dot(const AVector: TAVector): TABivector; overload;
    function Dot(const AVector: TABivector): TAVector; overload;
    function Dot(const AVector: TATrivector): TAScalar; overload;
    function Dot(const AVector: TAMultivector): TAMultivector; overload;

    function Wedge(const AVector: TAVector): TAScalar; overload;
    function Wedge(const AVector: TABivector): TAScalar; overload;
    function Wedge(const AVector: TATrivector): TAScalar; overload;
    function Wedge(const AVector: TAMultivector): TATrivector; overload;

    function Projection(const AVector: TAVector): TATrivector; overload;
    function Projection(const AVector: TABivector): TATrivector; overload;
    function Projection(const AVector: TATrivector): TATrivector; overload;
    function Projection(const AVector: TAMultivector): TATrivector; overload;

    function Rejection(const AVector: TAVector): TAScalar; overload;
    function Rejection(const AVector: TABivector): TAScalar; overload;
    function Rejection(const AVector: TATrivector): TAScalar; overload;
    function Rejection(const AVector: TAMultivector): TAMultivector; overload;

    function Reflection(const AVector: TAVector): TATrivector; overload;
    function Reflection(const AVector: TABivector): TATrivector; overload;
    function Reflection(const AVector: TATrivector): TATrivector; overload;
    function Reflection(const AVector: TAMultivector): TATrivector; overload;

    function Rotation(const AVector1, AVector2: TAVector): TATrivector; overload;
    function Rotation(const AVector1, AVector2: TABivector): TATrivector; overload;
    function Rotation(const AVector1, AVector2: TATrivector): TATrivector; overload;
    function Rotation(const AVector1, AVector2: TAMultivector): TATrivector; overload;

    function SameValue(const AVector: TAMultivector): boolean;
    function SameValue(const AVector: TATrivector): boolean;

    function ToMultivector: TAMultivector;
  end;
  {$ENDIF}

  { TABivectorHelper }

  {$IFDEF ADIMDEBUG}
  TABivectorHelper = record helper for TABivector
    function Dual: TAVector;
    function Inverse: TABivector;
    function Reverse: TABivector;
    function Conjugate: TABivector;
    function Reciprocal: TABivector;
    function Normalized: TABivector;
    function Norm: TAScalar;
    function SquaredNorm: TAScalar;

    function Dot(const AVector: TAVector): TAVector; overload;
    function Dot(const AVector: TABivector): TAScalar; overload;
    function Dot(const AVector: TATrivector): TAVector; overload;
    function Dot(const AVector: TAMultivector): TAMultivector; overload;

    function Wedge(const AVector: TAVector): TATrivector; overload;
    function Wedge(const AVector: TABivector): TAScalar; overload;
    function Wedge(const AVector: TATrivector): TAScalar; overload;
    function Wedge(const AVector: TAMultivector): TAMultivector; overload;

    function Projection(const AVector: TAVector): TABivector; overload;
    function Projection(const AVector: TABivector): TABivector; overload;
    function Projection(const AVector: TATrivector): TABivector; overload;
    function Projection(const AVector: TAMultivector): TAMultivector; overload;

    function Rejection(const AVector: TAVector): TABivector; overload;
    function Rejection(const AVector: TABivector): TAScalar; overload;
    function Rejection(const AVector: TATrivector): TAScalar; overload;
    function Rejection(const AVector: TAMultivector): TAMultivector; overload;

    function Reflection(const AVector: TAVector): TABivector; overload;
    function Reflection(const AVector: TABivector): TABivector; overload;
    function Reflection(const AVector: TATrivector): TABivector; overload;
    function Reflection(const AVector: TAMultivector): TAMultivector; overload;

    function Rotation(const AVector1, AVector2: TAVector): TABivector; overload;
    function Rotation(const AVector1, AVector2: TABivector): TABivector; overload;
    function Rotation(const AVector1, AVector2: TATrivector): TABivector; overload;
    function Rotation(const AVector1, AVector2: TAMultivector): TAMultivector; overload;

    function SameValue(const AVector: TAMultivector): boolean;
    function SameValue(const AVector: TABivector): boolean;

    function ExtractBivector(AComponents: TMultivectorComponents): TABivector;

    function ToMultivector: TAMultivector;
  end;
  {$ENDIF}

  { TAVectorHelper }

  {$IFDEF ADIMDEBUG}
  TAVectorHelper = record helper for TAVector
    function Dual: TABivector;
    function Inverse: TAVector;
    function Reverse: TAVector;
    function Conjugate: TAVector;
    function Reciprocal: TAVector;
    function Normalized: TAVector;
    function Norm: TAScalar;
    function SquaredNorm: TAScalar;

    function Dot(const AVector: TAVector): TAScalar; overload;
    function Dot(const AVector: TABivector): TAVector; overload;
    function Dot(const AVector: TATrivector): TABivector; overload;
    function Dot(const AVector: TAMultivector): TAMultivector; overload;

    function Wedge(const AVector: TAVector): TABivector; overload;
    function Wedge(const AVector: TABivector): TATrivector; overload;
    function Wedge(const AVector: TATrivector): TAScalar; overload;
    function Wedge(const AVector: TAMultivector): TAMultivector; overload;

    function Cross(const AVector: TAVector): TAVector;

    function Projection(const AVector: TAVector): TAVector; overload;
    function Projection(const AVector: TABivector): TAVector; overload;
    function Projection(const AVector: TATrivector): TAVector; overload;
    function Projection(const AVector: TAMultivector): TAMultivector; overload;

    function Rejection(const AVector: TAVector): TAVector; overload;
    function Rejection(const AVector: TABivector): TAVector; overload;
    function Rejection(const AVector: TATrivector): TAScalar; overload;
    function Rejection(const AVector: TAMultivector): TAMultivector; overload;

    function Reflection(const AVector: TAVector): TAVector; overload;
    function Reflection(const AVector: TABivector): TAVector; overload;
    function Reflection(const AVector: TATrivector): TAVector; overload;
    function Reflection(const AVector: TAMultivector): TAMultivector; overload;

    function Rotation(const AVector1, AVector2: TAVector): TAVector; overload;
    function Rotation(const AVector1, AVector2: TABivector): TAVector; overload;
    function Rotation(const AVector1, AVector2: TATrivector): TAVector; overload;
    function Rotation(const AVector1, AVector2: TAMultivector): TAMultivector; overload;

    function SameValue(const AVector: TAMultivector): boolean;
    function SameValue(const AVector: TAVector): boolean;

    function ExtractVector(AComponents: TMultivectorComponents): TAVector;

    function ToMultivector: TAMultivector;
  end;
  {$ENDIF}

  { TUnit }

  TUnit = record
  private
    FUnitOfMeasurement: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    class operator *(const AQuantity: double; const ASelf: TUnit): TAScalar; inline;
    class operator /(const AQuantity: double; const ASelf: TUnit): TAScalar; inline;
    class operator *(const AQuantity: TVector; const ASelf: TUnit): TAVector; inline;
    class operator /(const AQuantity: TVector; const ASelf: TUnit): TAVector; inline;
    class operator *(const AQuantity: TBivector; const ASelf: TUnit): TABivector; inline;
    class operator /(const AQuantity: TBivector; const ASelf: TUnit): TABivector; inline;
    class operator *(const AQuantity: TTrivector; const ASelf: TUnit): TATrivector; inline;
    class operator /(const AQuantity: TTrivector; const ASelf: TUnit): TATrivector; inline;
    class operator *(const AQuantity: TMultivector; const ASelf: TUnit): TAMultivector; inline;
    class operator /(const AQuantity: TMultivector; const ASelf: TUnit): TAMultivector; inline;
  {$IFDEF ADIMDEBUG}
    class operator *(const AQuantity: TAScalar; const ASelf: TUnit): TAScalar; inline;
    class operator /(const AQuantity: TAScalar; const ASelf: TUnit): TAScalar; inline;
    class operator *(const AQuantity: TAVector; const ASelf: TUnit): TAVector; inline;
    class operator /(const AQuantity: TAVector; const ASelf: TUnit): TAVector; inline;
    class operator *(const AQuantity: TABivector; const ASelf: TUnit): TABivector; inline;
    class operator /(const AQuantity: TABivector; const ASelf: TUnit): TABivector; inline;
    class operator *(const AQuantity: TATrivector; const ASelf: TUnit): TATrivector; inline;
    class operator /(const AQuantity: TATrivector; const ASelf: TUnit): TATrivector; inline;
    class operator *(const AQuantity: TAMultivector; const ASelf: TUnit): TAMultivector; inline;
    class operator /(const AQuantity: TAMultivector; const ASelf: TUnit): TAMultivector; inline;
  {$ENDIF}
  end;

  { TFactoredUnit }

  TFactoredUnit = record
  private
    FUnitOfMeasurement: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
    FFactor: double; 
  public
    class operator *(const AQuantity: double; const ASelf: TFactoredUnit): TAScalar; inline;
    class operator /(const AQuantity: double; const ASelf: TFactoredUnit): TAScalar; inline;
    class operator *(const AQuantity: TVector; const ASelf: TFactoredUnit): TAVector; inline;
    class operator /(const AQuantity: TVector; const ASelf: TFactoredUnit): TAVector; inline;
    class operator *(const AQuantity: TBivector; const ASelf: TFactoredUnit): TABivector; inline;
    class operator /(const AQuantity: TBivector; const ASelf: TFactoredUnit): TABivector; inline;
    class operator *(const AQuantity: TTrivector; const ASelf: TFactoredUnit): TATrivector; inline;
    class operator /(const AQuantity: TTrivector; const ASelf: TFactoredUnit): TATrivector; inline;
    class operator *(const AQuantity: TMultivector; const ASelf: TFactoredUnit): TAMultivector; inline;
    class operator /(const AQuantity: TMultivector; const ASelf: TFactoredUnit): TAMultivector; inline;
  {$IFDEF ADIMDEBUG}
    class operator *(const AQuantity: TAScalar; const ASelf: TFactoredUnit): TAScalar; inline;
    class operator /(const AQuantity: TAScalar; const ASelf: TFactoredUnit): TAScalar; inline;
    class operator *(const AQuantity: TAVector; const ASelf: TFactoredUnit): TAVector; inline;
    class operator /(const AQuantity: TAVector; const ASelf: TFactoredUnit): TAVector; inline;
    class operator *(const AQuantity: TABivector; const ASelf: TFactoredUnit): TABivector; inline;
    class operator /(const AQuantity: TABivector; const ASelf: TFactoredUnit): TABivector; inline;
    class operator *(const AQuantity: TATrivector; const ASelf: TFactoredUnit): TATrivector; inline;
    class operator /(const AQuantity: TATrivector; const ASelf: TFactoredUnit): TATrivector; inline;
    class operator *(const AQuantity: TAMultivector; const ASelf: TFactoredUnit): TAMultivector; inline;
    class operator /(const AQuantity: TAMultivector; const ASelf: TFactoredUnit): TAMultivector; inline;
  {$ENDIF}
  end;

  { TDegreeCelsiusUnit }

  TDegreeCelsiusUnit = record
  private
    FUnitOfMeasurement: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    class operator *(const AQuantity: double; const ASelf: TDegreeCelsiusUnit): TAScalar; inline;
  end;

  { TDegreeFahrenheitUnit }

  TDegreeFahrenheitUnit = record
  private
    FUnitOfMeasurement: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    class operator *(const AQuantity: double; const ASelf: TDegreeFahrenheitUnit): TAScalar; inline;
  end;   

 { TUnitHelper }

  TUnitHelper = record helper for TUnit
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

    function ToString(const AQuantity: TAVector): string;
    function ToString(const AQuantity: TABivector): string;
    function ToString(const AQuantity: TATrivector): string;
    function ToString(const AQuantity: TAMultivector): string;

    function ToVerboseString(const AQuantity: TAVector): string;
    function ToVerboseString(const AQuantity: TABivector): string;
    function ToVerboseString(const AQuantity: TATrivector): string;
    function ToVerboseString(const AQuantity: TAMultivector): string;
  end;

 { TFactoredUnitHelper }

  TFactoredUnitHelper = record helper for TFactoredUnit
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
  
    function ToString(const AQuantity: TAVector): string;
    function ToString(const AQuantity: TABivector): string;
    function ToString(const AQuantity: TATrivector): string;
    function ToString(const AQuantity: TAMultivector): string;

    function ToVerboseString(const AQuantity: TAVector): string;
    function ToVerboseString(const AQuantity: TABivector): string;
    function ToVerboseString(const AQuantity: TATrivector): string;
    function ToVerboseString(const AQuantity: TAMultivector): string;
  end;

 { TDegreeCelsiusUnitHelper }

  TDegreeCelsiusUnitHelper = record helper for TDegreeCelsiusUnit
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
  end;

 { TDegreeFahrenheitUnitHelper }

  TDegreeFahrenheitUnitHelper = record helper for TDegreeFahrenheitUnit
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
  end;
  
     -  <   ��
 C L 3 0 - S E C T I O N - A 4                 { Power functions }

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

function ArcCos(const AValue: double): TAScalar;
function ArcSin(const AValue: double): TAScalar;
function ArcTan(const AValue: double): TAScalar;
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
  AvogadroConstant               : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: ReciprocalMoleId;                     FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}
  BohrMagneton                   : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: SquareMeterAmpereId;                  FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}
  BohrRadius                     : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: MeterId;                              FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}
  BoltzmannConstant              : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: JoulePerKelvinId;                     FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}
  ComptonWaveLength              : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: MeterId;                              FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}
  CoulombConstant                : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: NewtonSquareMeterPerSquareCoulombId;  FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}
  DeuteronMass                   : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}
  ElectricPermittivity           : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: FaradPerMeterId;                      FValue:     8.8541878128E-12); {$ELSE} (    8.8541878128E-12); {$ENDIF}
  ElectronMass                   : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}
  ElectronCharge                 : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: CoulombId;                            FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}
  MagneticPermeability           : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: HenryPerMeterId;                      FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}
  MolarGasConstant               : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: JoulePerMolePerKelvinId;              FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}
  NeutronMass                    : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}
  NewtonianConstantOfGravitation : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: NewtonSquareMeterPerSquareKilogramId; FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}
  PlanckConstant                 : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramSquareMeterPerSecondId;       FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}
  ProtonMass                     : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}
  RydbergConstant                : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: ReciprocalMeterId;                    FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}
  SpeedOfLight                   : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: MeterPerSecondId;                     FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}
  SquaredSpeedOfLight            : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: SquareMeterPerSquareSecondId;         FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}
  StandardAccelerationOfGravity  : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: MeterPerSquareSecondId;               FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}
  ReducedPlanckConstant          : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramSquareMeterPerSecondId;       FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}
  UnifiedAtomicMassUnit          : TAScalar = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}

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

uses Math;� <   ��
 C L 3 0 - S E C T I O N - B 1                 { TAScalar }

{$IFDEF ADIMDEBUG}
class operator TAScalar.:=(const AValue: double): TAScalar;
begin
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := AValue;
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
  result.FUnitOfMeasurement := DivTable[ScalarId, ARight.FUnitOfMeasurement];
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

// TAMultivector

{$IFDEF ADIMDEBUG}
class operator TAMultivector.:=(const AValue: TAScalar): TAMultivector;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TAMultivector.<>(const ALeft, ARight: TAMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TAMultivector.<>(const ALeft: TAMultivector; const ARight: TAScalar): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TAMultivector.<>(const ALeft: TAScalar; const ARight: TAMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TAMultivector.=(const ALeft: TAMultivector; const ARight: TAScalar): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TAMultivector.=(const ALeft: TAScalar; const ARight: TAMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');
    
  result := ALeft.FValue = ARight.FValue;
end;

class operator TAMultivector.=(const ALeft, ARight: TAMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TAMultivector.+(const ALeft: TAMultivector; const ARight: TAScalar): TAMultivector;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;

  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');
end;

class operator TAMultivector.+(const ALeft: TAScalar; const ARight: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;

  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');
end;

class operator TAMultivector.+(const ALeft, ARight: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;

  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');
end;

class operator TAMultivector.-(const ASelf: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TAMultivector.-(const ALeft: TAMultivector; const ARight: TAScalar): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TAMultivector.-(const ALeft: TAScalar; const ARight: TAMultivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TAMultivector.-(const ALeft, ARight: TAMultivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TAMultivector.*(const ALeft: TAMultivector; const ARight: TAScalar): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TAMultivector.*(const ALeft: TAScalar; const ARight: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TAMultivector.*(const ALeft, ARight: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TAMultivector./(const ALeft: TAMultivector; const ARight: TAScalar): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TAMultivector./(const ALeft: TAScalar; const ARight: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TAMultivector./(const ALeft, ARight: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TATrivector

{$IFDEF ADIMDEBUG}

class operator TATrivector.:=(const AValue: TATrivector): TAMultivector;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TATrivector.<>(const ALeft, ARight: TATrivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TATrivector.<>(const ALeft: TAMultivector; const ARight: TATrivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TATrivector.<>(const ALeft: TATrivector; const ARight: TAMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TATrivector.=(const ALeft: TAMultivector; const ARight: TATrivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TATrivector.=(const ALeft: TATrivector; const ARight: TAMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TATrivector.=(const ALeft, ARight: TATrivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TATrivector.+(const ALeft, ARight: TATrivector): TATrivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TATrivector.+(const ALeft: TATrivector; const ARight: TAScalar): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TATrivector.+(const ALeft: TAScalar; const ARight: TATrivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TATrivector.+(const ALeft: TAMultivector; const ARight: TATrivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TATrivector.+(const ALeft: TATrivector; const ARight: TAMultivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TATrivector.-(const ASelf: TATrivector): TATrivector;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TATrivector.-(const ALeft, ARight: TATrivector): TATrivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TATrivector.-(const ALeft: TATrivector; const ARight: TAScalar): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TATrivector.-(const ALeft: TAScalar; const ARight: TATrivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TATrivector.-(const ALeft: TAMultivector; const ARight: TATrivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TATrivector.-(const ALeft: TATrivector; const ARight: TAMultivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TATrivector.*(const ALeft: TAScalar; const ARight: TATrivector): TATrivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TATrivector.*(const ALeft: TATrivector; const ARight: TAScalar): TATrivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TATrivector.*(const ALeft, ARight: TATrivector): TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TATrivector.*(const ALeft: TAMultivector; const ARight: TATrivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TATrivector.*(const ALeft: TATrivector; const ARight: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TATrivector./(const ALeft, ARight: TATrivector): TAScalar;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TATrivector./(const ALeft: TATrivector; const ARight: TAScalar): TATrivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TATrivector./(const ALeft: TAScalar; const ARight: TATrivector): TATrivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TATrivector./(const ALeft: TAMultivector; const ARight: TATrivector): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TATrivector./(const ALeft: TATrivector; const ARight: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TABivector

{$IFDEF ADIMDEBUG}
class operator TABivector.:=(const AValue: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TABivector.<>(const ALeft, ARight: TABivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TABivector.<>(const ALeft: TAMultivector; const ARight: TABivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TABivector.<>(const ALeft: TABivector; const ARight: TAMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TABivector.=(const ALeft, ARight: TABivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TABivector.=(const ALeft: TAMultivector; const ARight: TABivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TABivector.=(const ALeft: TABivector; const ARight: TAMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TABivector.+(const ALeft, ARight: TABivector): TABivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TABivector.+(const ALeft: TABivector; const ARight: TAScalar): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TABivector.+(const ALeft: TAScalar; const ARight: TABivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TABivector.+(const ALeft: TABivector; const ARight: TATrivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TABivector.+(const ALeft: TATrivector; const ARight: TABivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TABivector.+(const ALeft: TABivector; const ARight: TAMultivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TABivector.+(const ALeft: TAMultivector; const ARight: TABivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TABivector.-(const ASelf: TABivector): TABivector;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TABivector.-(const ALeft, ARight: TABivector): TABivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TABivector.-(const ALeft: TABivector; const ARight: TAScalar): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TABivector.-(const ALeft: TAScalar; const ARight: TABivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TABivector.-(const ALeft: TABivector; const ARight: TATrivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TABivector.-(const ALeft: TATrivector; const ARight: TABivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TABivector.-(const ALeft: TABivector; const ARight: TAMultivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TABivector.-(const ALeft: TAMultivector; const ARight: TABivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TABivector.*(const ALeft: TAScalar; const ARight: TABivector): TABivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TABivector.*(const ALeft: TABivector; const ARight: TAScalar): TABivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TABivector.*(const ALeft, ARight: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TABivector.*(const ALeft: TABivector; const ARight: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TABivector.*(const ALeft: TABivector; const ARight: TATrivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TABivector.*(const ALeft: TATrivector; const ARight: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TABivector.*(const ALeft: TAMultivector; const ARight: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TABivector./(const ALeft, ARight: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TABivector./(const ALeft: TABivector; const ARight: TAScalar): TABivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TABivector./(const ALeft: TAScalar; const ARight: TABivector): TABivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TABivector./(const ALeft: TABivector; const ARight: TATrivector): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TABivector./(const ALeft: TATrivector; const ARight: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TABivector./(const ALeft: TAMultivector; const ARight: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TABivector./(const ALeft: TABivector; const ARight: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TAVector

{$IFDEF ADIMDEBUG}
class operator TAVector.:=(const AValue: TAVector): TAMultivector;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TAVector.<>(const ALeft, ARight: TAVector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TAVector.<>(const ALeft: TAMultivector; const ARight: TAVector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TAVector.<>(const ALeft: TAVector; const ARight: TAMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TAVector.=(const ALeft, ARight: TAVector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TAVector.=(const ALeft: TAVector; const ARight: TAMultivector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TAVector.=(const ALeft: TAMultivector; const ARight: TAVector): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TAVector.+(const ALeft, ARight: TAVector): TAVector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TAVector.+(const ALeft: TAVector; const ARight: TAScalar): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TAVector.+(const ALeft: TAScalar; const ARight: TAVector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TAVector.+(const ALeft: TAVector; const ARight: TABivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TAVector.+(const ALeft: TABivector; const ARight: TAVector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TAVector.+(const ALeft: TAVector; const ARight: TATrivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TAVector.+(const ALeft: TATrivector; const ARight: TAVector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TAVector.+(const ALeft: TAVector; const ARight: TAMultivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TAVector.+(const ALeft: TAMultivector; const ARight: TAVector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TAVector.-(const ASelf: TAVector): TAVector;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TAVector.-(const ALeft, ARight: TAVector): TAVector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TAVector.-(const ALeft: TAVector; const ARight: TAScalar): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TAVector.-(const ALeft: TAScalar; const ARight: TAVector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TAVector.-(const ALeft: TAVector; const ARight: TABivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TAVector.-(const ALeft: TABivector; const ARight: TAVector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TAVector.-(const ALeft: TAVector; const ARight: TATrivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TAVector.-(const ALeft: TATrivector; const ARight: TAVector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TAVector.-(const ALeft: TAVector; const ARight: TAMultivector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TAVector.-(const ALeft: TAMultivector; const ARight: TAVector): TAMultivector;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TAVector.*(const ALeft: TAScalar; const ARight: TAVector): TAVector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TAVector.*(const ALeft: TAVector; const ARight: TAScalar): TAVector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TAVector.*(const ALeft, ARight: TAVector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TAVector.*(const ALeft: TAVector; const ARight: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TAVector.*(const ALeft: TABivector; const ARight: TAVector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TAVector.*(const ALeft: TAVector; const ARight: TATrivector): TABivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TAVector.*(const ALeft: TATrivector; const ARight: TAVector): TABivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TAVector.*(const ALeft: TAVector; const ARight: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TAVector.*(const ALeft: TAMultivector; const ARight: TAVector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TAVector./(const ALeft, ARight: TAVector): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TAVector./ (const ALeft: TAVector; const ARight: TAScalar): TAVector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TAVector./(const ALeft: TAScalar; const ARight: TAVector): TAVector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TAVector./(const ALeft: TAVector; const ARight: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TAVector./(const ALeft: TABivector; const ARight: TAVector): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TAVector./(const ALeft: TAVector; const ARight: TATrivector): TABivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TAVector./(const ALeft: TATrivector; const ARight: TAVector): TABivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TAVector./(const ALeft: TAMultivector; const ARight: TAVector): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TAVector./(const ALeft: TAVector; const ARight: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TAMultivectorHelper

{$IFDEF ADIMDEBUG}
function TAMultivectorHelper.Dual: TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Dual;
end;

function TAMultivectorHelper.Inverse: TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Inverse;
end;

function TAMultivectorHelper.Reverse: TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reverse;
end;

function TAMultivectorHelper.Conjugate: TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Conjugate;
end;

function TAMultivectorHelper.Reciprocal: TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ScalarId, FUnitOfMeasurement];
  result.FValue := FValue.Reciprocal;
end;

function TAMultivectorHelper.LeftReciprocal: TAMultivector;
begin
  result.FUnitOfMeasurement := DivTable[ScalarId, FUnitOfMeasurement];
  result.FValue := FValue.LeftReciprocal;
end;

function TAMultivectorHelper.Normalized: TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Normalized;
end;

function TAMultivectorHelper.Norm: TAScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Norm;
end;

function TAMultivectorHelper.SquaredNorm: TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := FValue.SquaredNorm;
end;

function TAMultivectorHelper.Dot(const AVector: TAVector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TAMultivectorHelper.Dot(const AVector: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TAMultivectorHelper.Dot(const AVector: TATrivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TAMultivectorHelper.Dot(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TAMultivectorHelper.Wedge(const AVector: TAVector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TAMultivectorHelper.Wedge(const AVector: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TAMultivectorHelper.Wedge(const AVector: TATrivector): TATrivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TAMultivectorHelper.Wedge(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TAMultivectorHelper.Projection(const AVector: TAVector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TAMultivectorHelper.Projection(const AVector: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TAMultivectorHelper.Projection(const AVector: TATrivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TAMultivectorHelper.Projection(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TAMultivectorHelper.Rejection(const AVector: TAVector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TAMultivectorHelper.Rejection(const AVector: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TAMultivectorHelper.Rejection(const AVector: TATrivector): TAScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TAMultivectorHelper.Rejection(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TAMultivectorHelper.Reflection(const AVector: TAVector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TAMultivectorHelper.Reflection(const AVector: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TAMultivectorHelper.Reflection(const AVector: TATrivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TAMultivectorHelper.Reflection(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TAMultivectorHelper.Rotation(const AVector1, AVector2: TAVector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TAMultivectorHelper.Rotation(const AVector1, AVector2: TABivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TAMultivectorHelper.Rotation(const AVector1, AVector2: TATrivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TAMultivectorHelper.Rotation(const AVector1, AVector2: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TAMultivectorHelper.SameValue(const AVector: TAMultivector): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TAMultivectorHelper.SameValue(const AVector: TATrivector): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TAMultivectorHelper.SameValue(const AVector: TABivector): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TAMultivectorHelper.SameValue(const AVector: TAVector): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TAMultivectorHelper.SameValue(const AVector: TAScalar): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TAMultivectorHelper.ExtractMultivector(AComponents: TMultivectorComponents): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractMultivector(AComponents);
end;

function TAMultivectorHelper.ExtractBivector(AComponents: TMultivectorComponents): TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractBivector(AComponents);
end;

function TAMultivectorHelper.ExtractVector(AComponents: TMultivectorComponents): TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractVector(AComponents);
end;

function TAMultivectorHelper.ExtractTrivector: TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractTrivector;
end;

function TAMultivectorHelper.ExtractBivector: TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractBivector;
end;

function TAMultivectorHelper.ExtractVector: TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractVector;
end;

function TAMultivectorHelper.ExtractScalar: TAScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractScalar;
end;

function TAMultivectorHelper.IsNull: boolean;
begin
  result := FValue.SameValue(NullMultivector);
end;

function TAMultivectorHelper.IsScalar: boolean;
begin
  result := FValue.IsScalar;
end;

function TAMultivectorHelper.IsVector: boolean;
begin
  result := FValue.IsVector;
end;

function TAMultivectorHelper.IsBiVector: boolean;
begin
  result := FValue.IsBiVector;
end;

function TAMultivectorHelper.IsTrivector: boolean;
begin
  result := FValue.IsTrivector;
end;

function TAMultivectorHelper.IsA: string;
begin
  result := FValue.IsA;
end;
{$ENDIF}

// TATrivectorHelper

{$IFDEF ADIMDEBUG}
function TATrivectorHelper.Dual: TAScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Dual;
end;

function TATrivectorHelper.Inverse: TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Inverse;
end;

function TATrivectorHelper.Reverse: TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reverse;
end;

function TATrivectorHelper.Conjugate: TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Conjugate;
end;

function TATrivectorHelper.Reciprocal: TATrivector;
begin
  result.FUnitOfMeasurement := DivTable[ScalarId, FUnitOfMeasurement];
  result.FValue := FValue.Reciprocal;
end;

function TATrivectorHelper.Normalized: TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Normalized;
end;

function TATrivectorHelper.Norm: TAScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Norm;
end;

function TATrivectorHelper.SquaredNorm: TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := FValue.SquaredNorm;
end;

function TATrivectorHelper.Dot(const AVector: TAVector): TABivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TATrivectorHelper.Dot(const AVector: TABivector): TAVector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TATrivectorHelper.Dot(const AVector: TATrivector): TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TATrivectorHelper.Dot(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TATrivectorHelper.Wedge(const AVector: TAVector): TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TATrivectorHelper.Wedge(const AVector: TABivector): TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TATrivectorHelper.Wedge(const AVector: TATrivector): TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TATrivectorHelper.Wedge(const AVector: TAMultivector): TATrivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TATrivectorHelper.Projection(const AVector: TAVector): TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TATrivectorHelper.Projection(const AVector: TABivector): TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TATrivectorHelper.Projection(const AVector: TATrivector): TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TATrivectorHelper.Projection(const AVector: TAMultivector): TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TATrivectorHelper.Rejection(const AVector: TAVector): TAScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TATrivectorHelper.Rejection(const AVector: TABivector): TAScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TATrivectorHelper.Rejection(const AVector: TATrivector): TAScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TATrivectorHelper.Rejection(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TATrivectorHelper.Reflection(const AVector: TAVector): TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TATrivectorHelper.Reflection(const AVector: TABivector): TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TATrivectorHelper.Reflection(const AVector: TATrivector): TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TATrivectorHelper.Reflection(const AVector: TAMultivector): TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TATrivectorHelper.Rotation(const AVector1, AVector2: TAVector): TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TATrivectorHelper.Rotation(const AVector1, AVector2: TABivector): TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TATrivectorHelper.Rotation(const AVector1, AVector2: TATrivector): TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TATrivectorHelper.Rotation(const AVector1, AVector2: TAMultivector): TATrivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TATrivectorHelper.SameValue(const AVector: TAMultivector): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TATrivectorHelper.SameValue(const AVector: TATrivector): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TATrivectorHelper.ToMultivector: TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TABivectorHelper

{$IFDEF ADIMDEBUG}
function TABivectorHelper.Dual: TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Dual;
end;

function TABivectorHelper.Inverse: TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Inverse;
end;

function TABivectorHelper.Conjugate: TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Conjugate;
end;

function TABivectorHelper.Reverse: TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reverse;
end;

function TABivectorHelper.Reciprocal: TABivector;
begin
  result.FUnitOfMeasurement := DivTable[ScalarId, FUnitOfMeasurement];
  result.FValue := FValue.Reciprocal;
end;

function TABivectorHelper.Normalized: TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Normalized;
end;

function TABivectorHelper.Norm: TAScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Norm;
end;

function TABivectorHelper.SquaredNorm: TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := FValue.SquaredNorm;
end;

function TABivectorHelper.Dot(const AVector: TAVector): TAVector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TABivectorHelper.Dot(const AVector: TABivector): TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TABivectorHelper.Dot(const AVector: TATrivector): TAVector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TABivectorHelper.Dot(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TABivectorHelper.Wedge(const AVector: TAVector): TATrivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TABivectorHelper.Wedge(const AVector: TABivector): TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TABivectorHelper.Wedge(const AVector: TATrivector): TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TABivectorHelper.Wedge(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TABivectorHelper.Projection(const AVector: TAVector): TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TABivectorHelper.Projection(const AVector: TABivector): TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TABivectorHelper.Projection(const AVector: TATrivector): TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TABivectorHelper.Projection(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TABivectorHelper.Rejection(const AVector: TAVector): TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TABivectorHelper.Rejection(const AVector: TABivector): TAScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TABivectorHelper.Rejection(const AVector: TATrivector): TAScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TABivectorHelper.Rejection(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TABivectorHelper.Reflection(const AVector: TAVector): TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TABivectorHelper.Reflection(const AVector: TABivector): TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TABivectorHelper.Reflection(const AVector: TATrivector): TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TABivectorHelper.Reflection(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TABivectorHelper.Rotation(const AVector1, AVector2: TAVector): TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TABivectorHelper.Rotation(const AVector1, AVector2: TABivector): TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TABivectorHelper.Rotation(const AVector1, AVector2: TATrivector): TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TABivectorHelper.Rotation(const AVector1, AVector2: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TABivectorHelper.SameValue(const AVector: TAMultivector): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TABivectorHelper.SameValue(const AVector: TABivector): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TABivectorHelper.ExtractBivector(AComponents: TMultivectorComponents): TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractBivector(AComponents);
end;

function TABivectorHelper.ToMultivector: TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TAVectorHelper

{$IFDEF ADIMDEBUG}
function TAVectorHelper.Dual: TABivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Dual;
end;

function TAVectorHelper.Inverse: TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Inverse;
end;

function TAVectorHelper.Reverse: TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reverse;
end;

function TAVectorHelper.Conjugate: TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Conjugate;
end;

function TAVectorHelper.Reciprocal: TAVector;
begin
  result.FUnitOfMeasurement := DivTable[ScalarId, FUnitOfMeasurement];
  result.FValue := FValue.Reciprocal;
end;

function TAVectorHelper.Normalized: TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Normalized;
end;

function TAVectorHelper.Norm: TAScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Norm;
end;

function TAVectorHelper.SquaredNorm: TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := FValue.SquaredNorm;
end;

function TAVectorHelper.Dot(const AVector: TAVector): TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TAVectorHelper.Dot(const AVector: TABivector): TAVector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TAVectorHelper.Dot(const AVector: TATrivector): TABivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TAVectorHelper.Dot(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TAVectorHelper.Wedge(const AVector: TAVector): TABivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TAVectorHelper.Wedge(const AVector: TABivector): TATrivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TAVectorHelper.Wedge(const AVector: TATrivector): TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TAVectorHelper.Wedge(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TAVectorHelper.Projection(const AVector: TAVector): TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TAVectorHelper.Projection(const AVector: TABivector): TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TAVectorHelper.Projection(const AVector: TATrivector): TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TAVectorHelper.Projection(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TAVectorHelper.Rejection(const AVector: TAVector): TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function  TAVectorHelper.Rejection(const AVector: TABivector): TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TAVectorHelper.Rejection(const AVector: TATrivector): TAScalar;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TAVectorHelper.Rejection(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TAVectorHelper.Reflection(const AVector: TAVector): TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TAVectorHelper.Reflection(const AVector: TABivector): TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TAVectorHelper.Reflection(const AVector: TATrivector): TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TAVectorHelper.Reflection(const AVector: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TAVectorHelper.Rotation(const AVector1, AVector2: TAVector): TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TAVectorHelper.Rotation(const AVector1, AVector2: TABivector): TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TAVectorHelper.Rotation(const AVector1, AVector2: TATrivector): TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TAVectorHelper.Rotation(const AVector1, AVector2: TAMultivector): TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TAVectorHelper.Cross(const AVector: TAVector): TAVector;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Cross(AVector.FValue);
end;

function TAVectorHelper.SameValue(const AVector: TAMultivector): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TAVectorHelper.SameValue(const AVector: TAVector): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TAVectorHelper.ExtractVector(AComponents: TMultivectorComponents): TAVector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractVector(AComponents);
end;

function TAVectorHelper.ToMultivector: TAMultivector;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

{ TUnit }

class operator TUnit.*(const AQuantity: double; const ASelf: TUnit): TAScalar; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: double; const ASelf: TUnit): TAScalar; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: TVector; const ASelf: TUnit): TAVector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: TVector; const ASelf: TUnit): TAVector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: TBivector; const ASelf: TUnit): TABivector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: TBivector; const ASelf: TUnit): TABivector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: TTrivector; const ASelf: TUnit): TATrivector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: TTrivector; const ASelf: TUnit): TATrivector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: TMultivector; const ASelf: TUnit): TAMultivector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: TMultivector; const ASelf: TUnit): TAMultivector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

{$IFDEF ADIMDEBUG}
class operator TUnit.*(const AQuantity: TAScalar; const ASelf: TUnit): TAScalar; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TAScalar; const ASelf: TUnit): TAScalar; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TAVector; const ASelf: TUnit): TAVector; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TAVector; const ASelf: TUnit): TAVector; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TABivector; const ASelf: TUnit): TABivector; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TABivector; const ASelf: TUnit): TABivector; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TATrivector; const ASelf: TUnit): TATrivector; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TATrivector; const ASelf: TUnit): TATrivector; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TAMultivector; const ASelf: TUnit): TAMultivector; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TAMultivector; const ASelf: TUnit): TAMultivector; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

{$ENDIF}

{ TFactoredUnit }

class operator TFactoredUnit.*(const AQuantity: double; const ASelf: TFactoredUnit): TAScalar; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: double; const ASelf: TFactoredUnit): TAScalar; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TVector; const ASelf: TFactoredUnit): TAVector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TVector; const ASelf: TFactoredUnit): TAVector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TBivector; const ASelf: TFactoredUnit): TABivector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TBivector; const ASelf: TFactoredUnit): TABivector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TTrivector; const ASelf: TFactoredUnit): TATrivector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TTrivector; const ASelf: TFactoredUnit): TATrivector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TMultivector; const ASelf: TFactoredUnit): TAMultivector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TMultivector; const ASelf: TFactoredUnit): TAMultivector; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

{$IFDEF ADIMDEBUG}
class operator TFactoredUnit.*(const AQuantity: TAScalar; const ASelf: TFactoredUnit): TAScalar; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TAScalar; const ASelf: TFactoredUnit): TAScalar; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TAVector; const ASelf: TFactoredUnit): TAVector; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TAVector; const ASelf: TFactoredUnit): TAVector; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TABivector; const ASelf: TFactoredUnit): TABivector; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TABivector; const ASelf: TFactoredUnit): TABivector; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TATrivector; const ASelf: TFactoredUnit): TATrivector; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TATrivector; const ASelf: TFactoredUnit): TATrivector; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TAMultivector; const ASelf: TFactoredUnit): TAMultivector; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TAMultivector; const ASelf: TFactoredUnit): TAMultivector; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;
{$ENDIF}

{ TDegreeCelsiusUnit }

class operator TDegreeCelsiusUnit.*(const AQuantity: double; const ASelf: TDegreeCelsiusUnit): TAScalar; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity + 273.15;
{$ELSE}
  result := AQuantity + 273.15;
{$ENDIF}
end;

{ TDegreeFahrenheitUnit }

class operator TDegreeFahrenheitUnit.*(const AQuantity: double; const ASelf: TDegreeFahrenheitUnit): TAScalar; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := 5/9 * (AQuantity - 32) + 273.15;
{$ELSE}
  result := 5/9 * (AQuantity - 32) + 273.15;
{$ENDIF}
end;

{ TUnitHelper }

function TUnitHelper.GetName(const Prefixes: TPrefixes): string;
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

function TUnitHelper.GetPluralName(const Prefixes: TPrefixes): string;
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

function TUnitHelper.GetSymbol(const Prefixes: TPrefixes): string;
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

procedure TUnitHelper.Check(var AQuantity: TAScalar);
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TUnitHelper.ToFloat(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToFloat(const AQuantity: TAScalar; const APrefixes: TPrefixes): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}  
end;

function TUnitHelper.ToString(const AQuantity: TAScalar): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(AQuantity.FValue) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(AQuantity.FValue, APrefixes); 
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
 
  if Length(APrefixes) = 0 then
     result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}  

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
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
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;    

function TUnitHelper.ToVerboseString(const AQuantity: TAScalar): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TUnitHelper.ToVerboseString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TUnitHelper.ToVerboseString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TUnitHelper.ToVerboseString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
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
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

function TUnitHelper.ToVerboseString(const AQuantity: TAVector): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TABivector): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TATrivector): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TAMultivector): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TAVector): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TABivector): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TATrivector): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TAMultivector): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

{ TFactoredUnitHelper }

function TFactoredUnitHelper.GetName(const Prefixes: TPrefixes): string;
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

function TFactoredUnitHelper.GetPluralName(const Prefixes: TPrefixes): string;
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

function TFactoredUnitHelper.GetSymbol(const Prefixes: TPrefixes): string;
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

procedure TFactoredUnitHelper.Check(var AQuantity: TAScalar);
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TFactoredUnitHelper.ToFloat(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}  
end;

function TFactoredUnitHelper.ToFloat(const AQuantity: TAScalar; const APrefixes: TPrefixes): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}  
end;

function TFactoredUnitHelper.ToString(const AQuantity: TAScalar): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(AQuantity.FValue / FFactor) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity / FFactor) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

    FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
    FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToString routine has detected wrong units of measurements.'); 

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

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TAScalar): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TFactoredUnitHelper.ToVerboseString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TFactoredUnitHelper.ToString(const AQuantity: TAVector): string;
var
  FactoredValue: TVector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TABivector): string;
var
  FactoredValue: TBivector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TATrivector): string;
var
  FactoredValue: TTrivector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TAMultivector): string;
var
  FactoredValue: TMultivector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TAVector): string;
var
  FactoredValue: TVector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TABivector): string;
var
  FactoredValue: TBivector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TATrivector): string;
var
  FactoredValue: TTrivector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TAMultivector): string;
var
  FactoredValue: TMultivector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

procedure TDegreeCelsiusUnitHelper.Check(var AQuantity: TAScalar);
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToFloat(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := AQuantity.FValue - 273.15;
{$ELSE}
  result := AQuantity - 273.15;
{$ENDIF}  
end;

function TDegreeCelsiusUnitHelper.ToFloat(const AQuantity: TAScalar; const APrefixes: TPrefixes): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  result := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}  
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TAScalar): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(AQuantity.FValue - 273.15) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity - 273.15) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

    FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
    FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToString routine has detected wrong units of measurements.'); 

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

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TAScalar): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue - 273.15;
{$ELSE}
  FactoredValue := AQuantity - 273.15;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

procedure TDegreeFahrenheitUnitHelper.Check(var AQuantity: TAScalar);
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToFloat(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := 9/5 * AQuantity.FValue - 459.67;
{$ELSE}
  result := 9/5 * AQuantity - 459.67;
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToFloat(const AQuantity: TAScalar; const APrefixes: TPrefixes): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  result := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}  
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TAScalar): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(9/5 * AQuantity.FValue - 459.67) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(9/5 * AQuantity - 459.67) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

    FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
    FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToString routine has detected wrong units of measurements.'); 

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

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TAScalar): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := 9/5 * AQuantity.FValue - 459.67;
{$ELSE}
  FactoredValue := 9/5 * AQuantity - 459.67;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

  =,  <   ��
 C L 3 0 - S E C T I O N - B 4                 
{ Power functions }

function SquarePower(const AQuantity: TAScalar): TAScalar;
begin
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Cos routine has detected wrong units of measurements.');

  result := System.Cos(AQuantity.FValue);
{$ELSE}
  result := System.Cos(AQuantity);
{$ENDIF}
end;

function Sin(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Sin routine has detected wrong units of measurements.');

  result := System.Sin(AQuantity.FValue);
{$ELSE}
  result := System.Sin(AQuantity);
{$ENDIF}
end;

function Tan(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Tan routine has detected wrong units of measurements.');

  result := Math.Tan(AQuantity.FValue);
{$ELSE}
  result := Math.Tan(AQuantity);
{$ENDIF}
end;

function Cotan(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Cotan routine has detected wrong units of measurements.');

  result := Math.Cotan(AQuantity.FValue);
{$ELSE}
  result := Math.Cotan(AQuantity);
{$ENDIF}
end;

function Secant(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Setan routine has detected wrong units of measurements.');

  result := Math.Secant(AQuantity.FValue);
{$ELSE}
  result := Math.Secant(AQuantity);
{$ENDIF}
end;

function Cosecant(const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Cosecant routine has detected wrong units of measurements.');

  result := Math.Cosecant(AQuantity.FValue);
{$ELSE}
  result := Math.Cosecant(AQuantity);
{$ENDIF}
end;

function ArcCos(const AValue: double): TAScalar;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := Math.ArcCos(AValue);
{$ELSE}
  result := Math.ArcCos(AValue);
{$ENDIF}
end;

function ArcSin(const AValue: double): TAScalar;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := Math.ArcSin(AValue);
{$ELSE}
  result := Math.ArcSin(AValue);
{$ENDIF}
end;

function ArcTan(const AValue: double): TAScalar;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := System.ArcTan(AValue);
{$ELSE}
  result := System.ArcTan(AValue);
{$ENDIF}
end;

function ArcTan2(const x, y: double): TAScalar;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := Math.ArcTan2(x, y);
{$ELSE}
  result := Math.ArcTan2(x, y);
{$ENDIF}
end;

{ Math functions }


function Min(const ALeft, ARight: TAScalar): TAScalar;
begin
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Exp routine has detected wrong units of measurements.');

  result.FUnitOfMeasurement := ScalarId;
  result.FValue := System.Exp(AQuantity.FValue);
{$ELSE}
  result := System.Exp(AQuantity);
{$ENDIF}
end;

function Log10(const AQuantity : TAScalar) : double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Log10 routine has detected wrong units of measurements.');

  result := Math.Log10(AQuantity.FValue);
{$ELSE}  
  result := Math.Log10(AQuantity);
{$ENDIF}
end;

function Log2(const AQuantity : TAScalar) : double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Log2 routine has detected wrong units of measurements.');

  result := Math.Log2(AQuantity.FValue);
{$ELSE} 
  result := Math.Log2(AQuantity);
{$ENDIF}
end;

function LogN(ABase: longint; const AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  result := Math.LogN(ABase, AQuantity.FValue);
{$ELSE} 
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function LogN(const ABase, AQuantity: TAScalar): double;
begin
{$IFDEF ADIMDEBUG}
  if ABase.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  result := Math.LogN(ABase.FValue, AQuantity.FValue);
{$ELSE} 
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function Power(const ABase: TAScalar; AExponent: double): double;
begin
{$IFDEF ADIMDEBUG}
  if ABase.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Power routine has detected wrong units of measurements.');

   result := Math.Power(ABase.FValue, AExponent);
{$ELSE}
  result := Math.Power(ABase, AExponent);
{$ENDIF}
end;

{ Helper functions }

function LessThanOrEqualToZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue <= 0;
{$ELSE}  
  result := AQuantity <= 0;
{$ENDIF}
end;

function LessThanZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue < 0;
{$ELSE}  
  result := AQuantity < 0;
{$ENDIF}
end;

function EqualToZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue = 0;
{$ELSE} 
  result := AQuantity = 0;
{$ENDIF}
end;

function NotEqualToZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue <> 0;
{$ELSE}
  result := AQuantity <> 0;
{$ENDIF}
end;

function GreaterThanOrEqualToZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue >= 0;
{$ELSE}
  result := AQuantity >= 0;
{$ENDIF}
end;

function GreaterThanZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue > 0;
{$ELSE}
  result := AQuantity > 0;
{$ENDIF}
end;

function SameValue(const ALeft, ARight: TAScalar): boolean;
begin
{$IFDEF ADIMDEBUG}
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('SameValue routine has detected wrong units of measurements.');

  result := Math.SameValue(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.SameValue(ALeft, ARight);
{$ENDIF}
end;

   �      �� ��               (       @             d   d                                                                                                                                                                                                                                                                                           Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu����������ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ�������������Ӥu�                                    Ӥu����������ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ��ݻ�������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu����������ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ�������������Ӥu�                                    Ӥu����������ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ��ԧ�������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu�������������������������������������������������������������������������������������Ӥu�                                    Ӥu���������������������������������������������������������������������������������޻��ը|�                                    Ӥu�����������������������������������������������������������������������������޼��֨{�ےm                                    Ӥu�������������������������������������������������������������������������޼��֨{�ےm                                        Ӥu���������������������������������������������������������������������޼��֨{�ےm                                            Ӥu�����������������������������������������������������������������޽��֨|�ےm                                                Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�Ӥu�֩}�ժ�                                                                                                                                                                                                                                                                                                                                                                                                                                    