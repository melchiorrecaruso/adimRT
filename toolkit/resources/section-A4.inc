
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
  AvogadroConstant               : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole: -60; FCandela: 0; FSteradian: 0); FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}
  BohrMagneton                   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:  120; FSecond:    0; FAmpere:   60; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}
  BohrRadius                     : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}
  BoltzmannConstant              : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond: -120; FAmpere:    0; FKelvin: -60; FMole:   0; FCandela: 0; FSteradian: 0); FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}
  ComptonWaveLength              : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}
  CoulombConstant                : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  180; FSecond: -240; FAmpere: -120; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}
  DeuteronMass                   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}
  ElectricPermittivity           : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter: -180; FSecond:  240; FAmpere:  120; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     8.8541878188E-12); {$ELSE} (    8.8541878188E-12); {$ENDIF}
  ElectronMass                   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}
  ElectronCharge                 : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:   60; FAmpere:   60; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}
  FineStructureConstant          : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      7.2973525643E-3); {$ELSE} (     7.2973525643E-3); {$ENDIF}
  InverseFineStructureConstant   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:        137.035999177); {$ELSE} (       137.035999177); {$ENDIF}
  MagneticPermeability           : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:   60; FSecond: -120; FAmpere: -120; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}
  MolarGasConstant               : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond:  120; FAmpere:    0; FKelvin: -60; FMole: -60; FCandela: 0; FSteradian: 0); FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}
  NeutronMass                    : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}
  NewtonianConstantOfGravitation : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter:  180; FSecond: -120; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}
  PlanckConstant                 : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond:  -60; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}
  ProtonMass                     : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}
  RydbergConstant                : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:  -60; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}
  SpeedOfLight                   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond:  -60; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}
  SquaredSpeedOfLight            : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:  120; FSecond: -120; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}
  StandardAccelerationOfGravity  : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond: -120; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}
  ReducedPlanckConstant          : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond:  -60; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}
  UnifiedAtomicMassUnit          : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}

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

{ Default Epsilon }

var

  DefaultEpsilon : double = 1E-12;

