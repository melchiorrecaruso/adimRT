{
  ADimRT library built on 7-9-24.

  Number of base units: 161
  Number of factored units: 118
  Number of operators: 0 (0 external, 0 internal)
}

unit ADimRT;

{$H+}{$J-}
{$modeswitch typehelpers}
{$modeswitch advancedrecords}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function's return value.
{$MACRO ON}

interface

uses
  DateUtils, Sysutils;

{ TQuantity }

type
  {$IFOPT D+}
  TQuantity = record
  private
    FUnitOfMeasurement: longint;
    FValue: double;
  public
    class operator Copy(constref ASrc: TQuantity; var ADst: TQuantity); inline;
    class operator +(const ALeft, ARight: TQuantity): TQuantity; inline;
    class operator -(const ALeft, ARight: TQuantity): TQuantity; inline;
    class operator *(const ALeft, ARight: TQuantity): TQuantity; inline;
    class operator /(const ALeft, ARight: TQuantity): TQuantity; inline;
    class operator *(const ALeft: double; const ARight: TQuantity): TQuantity; inline;
    class operator *(const ALeft: TQuantity; const ARight: double): TQuantity; inline;
    class operator /(const ALeft: TQuantity; const ARight: double): TQuantity; inline;
  end;
  {$ELSE}
  TQuantity = double;
  {$ENDIF}

{ Base units }

type
  TSecondUnit = record
    class operator *(const AValue: double; const ASelf: TSecondUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSecondUnit): TQuantity; inline;
  end;

  TSquareSecondUnit = record
    class operator *(const AValue: double; const ASelf: TSquareSecondUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareSecondUnit): TQuantity; inline;
  end;

  TCubicSecondUnit = record
    class operator *(const AValue: double; const ASelf: TCubicSecondUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TCubicSecondUnit): TQuantity; inline;
  end;

  TQuarticSecondUnit = record
    class operator *(const AValue: double; const ASelf: TQuarticSecondUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TQuarticSecondUnit): TQuantity; inline;
  end;

  TQuinticSecondUnit = record
    class operator *(const AValue: double; const ASelf: TQuinticSecondUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TQuinticSecondUnit): TQuantity; inline;
  end;

  TSexticSecondUnit = record
    class operator *(const AValue: double; const ASelf: TSexticSecondUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSexticSecondUnit): TQuantity; inline;
  end;

  TMeterUnit = record
    class operator *(const AValue: double; const ASelf: TMeterUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TMeterUnit): TQuantity; inline;
  end;

  TSquareMeterUnit = record
    class operator *(const AValue: double; const ASelf: TSquareMeterUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareMeterUnit): TQuantity; inline;
  end;

  TCubicMeterUnit = record
    class operator *(const AValue: double; const ASelf: TCubicMeterUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TCubicMeterUnit): TQuantity; inline;
  end;

  TQuarticMeterUnit = record
    class operator *(const AValue: double; const ASelf: TQuarticMeterUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TQuarticMeterUnit): TQuantity; inline;
  end;

  TQuinticMeterUnit = record
    class operator *(const AValue: double; const ASelf: TQuinticMeterUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TQuinticMeterUnit): TQuantity; inline;
  end;

  TSexticMeterUnit = record
    class operator *(const AValue: double; const ASelf: TSexticMeterUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSexticMeterUnit): TQuantity; inline;
  end;

  TKilogramUnit = record
    class operator *(const AValue: double; const ASelf: TKilogramUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TKilogramUnit): TQuantity; inline;
  end;

  TSquareKilogramUnit = record
    class operator *(const AValue: double; const ASelf: TSquareKilogramUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareKilogramUnit): TQuantity; inline;
  end;

  TAmpereUnit = record
    class operator *(const AValue: double; const ASelf: TAmpereUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TAmpereUnit): TQuantity; inline;
  end;

  TSquareAmpereUnit = record
    class operator *(const AValue: double; const ASelf: TSquareAmpereUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareAmpereUnit): TQuantity; inline;
  end;

  TKelvinUnit = record
    class operator *(const AValue: double; const ASelf: TKelvinUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TKelvinUnit): TQuantity; inline;
  end;

  TSquareKelvinUnit = record
    class operator *(const AValue: double; const ASelf: TSquareKelvinUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareKelvinUnit): TQuantity; inline;
  end;

  TCubicKelvinUnit = record
    class operator *(const AValue: double; const ASelf: TCubicKelvinUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TCubicKelvinUnit): TQuantity; inline;
  end;

  TQuarticKelvinUnit = record
    class operator *(const AValue: double; const ASelf: TQuarticKelvinUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TQuarticKelvinUnit): TQuantity; inline;
  end;

  TMoleUnit = record
    class operator *(const AValue: double; const ASelf: TMoleUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TMoleUnit): TQuantity; inline;
  end;

  TCandelaUnit = record
    class operator *(const AValue: double; const ASelf: TCandelaUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TCandelaUnit): TQuantity; inline;
  end;

  TRadianUnit = record
    class operator *(const AValue: double; const ASelf: TRadianUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TRadianUnit): TQuantity; inline;
  end;

  TSteradianUnit = record
    class operator *(const AValue: double; const ASelf: TSteradianUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSteradianUnit): TQuantity; inline;
  end;

  THertzUnit = record
    class operator *(const AValue: double; const ASelf: THertzUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: THertzUnit): TQuantity; inline;
  end;

  TSquareHertzUnit = record
    class operator *(const AValue: double; const ASelf: TSquareHertzUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareHertzUnit): TQuantity; inline;
  end;

  TNewtonUnit = record
    class operator *(const AValue: double; const ASelf: TNewtonUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TNewtonUnit): TQuantity; inline;
  end;

  TSquareNewtonUnit = record
    class operator *(const AValue: double; const ASelf: TSquareNewtonUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareNewtonUnit): TQuantity; inline;
  end;

  TPascalUnit = record
    class operator *(const AValue: double; const ASelf: TPascalUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TPascalUnit): TQuantity; inline;
  end;

  TJouleUnit = record
    class operator *(const AValue: double; const ASelf: TJouleUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TJouleUnit): TQuantity; inline;
  end;

  TWattUnit = record
    class operator *(const AValue: double; const ASelf: TWattUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TWattUnit): TQuantity; inline;
  end;

  TCoulombUnit = record
    class operator *(const AValue: double; const ASelf: TCoulombUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TCoulombUnit): TQuantity; inline;
  end;

  TSquareCoulombUnit = record
    class operator *(const AValue: double; const ASelf: TSquareCoulombUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareCoulombUnit): TQuantity; inline;
  end;

  TVoltUnit = record
    class operator *(const AValue: double; const ASelf: TVoltUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TVoltUnit): TQuantity; inline;
  end;

  TSquareVoltUnit = record
    class operator *(const AValue: double; const ASelf: TSquareVoltUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareVoltUnit): TQuantity; inline;
  end;

  TFaradUnit = record
    class operator *(const AValue: double; const ASelf: TFaradUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TFaradUnit): TQuantity; inline;
  end;

  TOhmUnit = record
    class operator *(const AValue: double; const ASelf: TOhmUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TOhmUnit): TQuantity; inline;
  end;

  TSiemensUnit = record
    class operator *(const AValue: double; const ASelf: TSiemensUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSiemensUnit): TQuantity; inline;
  end;

  TTeslaUnit = record
    class operator *(const AValue: double; const ASelf: TTeslaUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TTeslaUnit): TQuantity; inline;
  end;

  TWeberUnit = record
    class operator *(const AValue: double; const ASelf: TWeberUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TWeberUnit): TQuantity; inline;
  end;

  THenryUnit = record
    class operator *(const AValue: double; const ASelf: THenryUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: THenryUnit): TQuantity; inline;
  end;

  TLumenUnit = record
    class operator *(const AValue: double; const ASelf: TLumenUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TLumenUnit): TQuantity; inline;
  end;

  TLuxUnit = record
    class operator *(const AValue: double; const ASelf: TLuxUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TLuxUnit): TQuantity; inline;
  end;

  TKatalUnit = record
    class operator *(const AValue: double; const ASelf: TKatalUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TKatalUnit): TQuantity; inline;
  end;

  TPoiseuilleUnit = record
    class operator *(const AValue: double; const ASelf: TPoiseuilleUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TPoiseuilleUnit): TQuantity; inline;
  end;

  TSquareJouleUnit = record
    class operator *(const AValue: double; const ASelf: TSquareJouleUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareJouleUnit): TQuantity; inline;
  end;

{ Factored units }

type
  TDayUnit = record
    class operator *(const AValue: double; const ASelf: TDayUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TDayUnit): TQuantity; inline;
  end;

  THourUnit = record
    class operator *(const AValue: double; const ASelf: THourUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: THourUnit): TQuantity; inline;
  end;

  TMinuteUnit = record
    class operator *(const AValue: double; const ASelf: TMinuteUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TMinuteUnit): TQuantity; inline;
  end;

  TSquareDayUnit = record
    class operator *(const AValue: double; const ASelf: TSquareDayUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareDayUnit): TQuantity; inline;
  end;

  TSquareHourUnit = record
    class operator *(const AValue: double; const ASelf: TSquareHourUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareHourUnit): TQuantity; inline;
  end;

  TSquareMinuteUnit = record
    class operator *(const AValue: double; const ASelf: TSquareMinuteUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareMinuteUnit): TQuantity; inline;
  end;

  TAstronomicalUnit = record
    class operator *(const AValue: double; const ASelf: TAstronomicalUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TAstronomicalUnit): TQuantity; inline;
  end;

  TInchUnit = record
    class operator *(const AValue: double; const ASelf: TInchUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TInchUnit): TQuantity; inline;
  end;

  TFootUnit = record
    class operator *(const AValue: double; const ASelf: TFootUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TFootUnit): TQuantity; inline;
  end;

  TYardUnit = record
    class operator *(const AValue: double; const ASelf: TYardUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TYardUnit): TQuantity; inline;
  end;

  TMileUnit = record
    class operator *(const AValue: double; const ASelf: TMileUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TMileUnit): TQuantity; inline;
  end;

  TNauticalMileUnit = record
    class operator *(const AValue: double; const ASelf: TNauticalMileUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TNauticalMileUnit): TQuantity; inline;
  end;

  TAngstromUnit = record
    class operator *(const AValue: double; const ASelf: TAngstromUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TAngstromUnit): TQuantity; inline;
  end;

  TSquareInchUnit = record
    class operator *(const AValue: double; const ASelf: TSquareInchUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareInchUnit): TQuantity; inline;
  end;

  TSquareFootUnit = record
    class operator *(const AValue: double; const ASelf: TSquareFootUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareFootUnit): TQuantity; inline;
  end;

  TSquareYardUnit = record
    class operator *(const AValue: double; const ASelf: TSquareYardUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareYardUnit): TQuantity; inline;
  end;

  TSquareMileUnit = record
    class operator *(const AValue: double; const ASelf: TSquareMileUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareMileUnit): TQuantity; inline;
  end;

  TCubicInchUnit = record
    class operator *(const AValue: double; const ASelf: TCubicInchUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TCubicInchUnit): TQuantity; inline;
  end;

  TCubicFootUnit = record
    class operator *(const AValue: double; const ASelf: TCubicFootUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TCubicFootUnit): TQuantity; inline;
  end;

  TCubicYardUnit = record
    class operator *(const AValue: double; const ASelf: TCubicYardUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TCubicYardUnit): TQuantity; inline;
  end;

  TLitreUnit = record
    class operator *(const AValue: double; const ASelf: TLitreUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TLitreUnit): TQuantity; inline;
  end;

  TGallonUnit = record
    class operator *(const AValue: double; const ASelf: TGallonUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TGallonUnit): TQuantity; inline;
  end;

  TTonneUnit = record
    class operator *(const AValue: double; const ASelf: TTonneUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TTonneUnit): TQuantity; inline;
  end;

  TPoundUnit = record
    class operator *(const AValue: double; const ASelf: TPoundUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TPoundUnit): TQuantity; inline;
  end;

  TOunceUnit = record
    class operator *(const AValue: double; const ASelf: TOunceUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TOunceUnit): TQuantity; inline;
  end;

  TStoneUnit = record
    class operator *(const AValue: double; const ASelf: TStoneUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TStoneUnit): TQuantity; inline;
  end;

  TTonUnit = record
    class operator *(const AValue: double; const ASelf: TTonUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TTonUnit): TQuantity; inline;
  end;

  TDegreeCelsiusUnit = record
    class operator *(const AValue: double; const ASelf: TDegreeCelsiusUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TDegreeCelsiusUnit): TQuantity; inline;
  end;

  TDegreeFahrenheitUnit = record
    class operator *(const AValue: double; const ASelf: TDegreeFahrenheitUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TDegreeFahrenheitUnit): TQuantity; inline;
  end;

  TDegreeUnit = record
    class operator *(const AValue: double; const ASelf: TDegreeUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TDegreeUnit): TQuantity; inline;
  end;

  TSquareDegreeUnit = record
    class operator *(const AValue: double; const ASelf: TSquareDegreeUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSquareDegreeUnit): TQuantity; inline;
  end;

  TGrayUnit = record
    class operator *(const AValue: double; const ASelf: TGrayUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TGrayUnit): TQuantity; inline;
  end;

  TSievertUnit = record
    class operator *(const AValue: double; const ASelf: TSievertUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TSievertUnit): TQuantity; inline;
  end;

  TPoundForceUnit = record
    class operator *(const AValue: double; const ASelf: TPoundForceUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TPoundForceUnit): TQuantity; inline;
  end;

  TBarUnit = record
    class operator *(const AValue: double; const ASelf: TBarUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TBarUnit): TQuantity; inline;
  end;

  TPoundPerSquareInchUnit = record
    class operator *(const AValue: double; const ASelf: TPoundPerSquareInchUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TPoundPerSquareInchUnit): TQuantity; inline;
  end;

  TElectronvoltUnit = record
    class operator *(const AValue: double; const ASelf: TElectronvoltUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TElectronvoltUnit): TQuantity; inline;
  end;

  TRydbergUnit = record
    class operator *(const AValue: double; const ASelf: TRydbergUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TRydbergUnit): TQuantity; inline;
  end;

  TCalorieUnit = record
    class operator *(const AValue: double; const ASelf: TCalorieUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TCalorieUnit): TQuantity; inline;
  end;

  TBequerelUnit = record
    class operator *(const AValue: double; const ASelf: TBequerelUnit): TQuantity; inline;
    class operator *(const AValue: TQuantity; const ASelf: TBequerelUnit): TQuantity; inline;
  end;

var
  s          : TSecondUnit;
  s2         : TSquareSecondUnit;
  s3         : TCubicSecondUnit;
  s4         : TQuarticSecondUnit;
  s5         : TQuinticSecondUnit;
  s6         : TSexticSecondUnit;
  m          : TMeterUnit;
  m2         : TSquareMeterUnit;
  m3         : TCubicMeterUnit;
  m4         : TQuarticMeterUnit;
  m5         : TQuinticMeterUnit;
  m6         : TSexticMeterUnit;
  kg         : TKilogramUnit;
  kg2        : TSquareKilogramUnit;
  A          : TAmpereUnit;
  A2         : TSquareAmpereUnit;
  K          : TKelvinUnit;
  K2         : TSquareKelvinUnit;
  K3         : TCubicKelvinUnit;
  K4         : TQuarticKelvinUnit;
  mol        : TMoleUnit;
  cd         : TCandelaUnit;
  rad        : TRadianUnit;
  sr         : TSteradianUnit;
  Hz         : THertzUnit;
  Hz2        : TSquareHertzUnit;
  N          : TNewtonUnit;
  N2         : TSquareNewtonUnit;
  Pa         : TPascalUnit;
  J          : TJouleUnit;
  W          : TWattUnit;
  C          : TCoulombUnit;
  C2         : TSquareCoulombUnit;
  V          : TVoltUnit;
  V2         : TSquareVoltUnit;
  F          : TFaradUnit;
  ohm        : TOhmUnit;
  siemens    : TSiemensUnit;
  T          : TTeslaUnit;
  Wb         : TWeberUnit;
  H          : THenryUnit;
  lm         : TLumenUnit;
  lx         : TLuxUnit;
  kat        : TKatalUnit;
  Pl         : TPoiseuilleUnit;
  J2         : TSquareJouleUnit;

var
  day        : TDayUnit;
  hr         : THourUnit;
  minute     : TMinuteUnit;
  day2       : TSquareDayUnit;
  hr2        : TSquareHourUnit;
  minute2    : TSquareMinuteUnit;
  au         : TAstronomicalUnit;
  inch       : TInchUnit;
  ft         : TFootUnit;
  yd         : TYardUnit;
  mi         : TMileUnit;
  nmi        : TNauticalMileUnit;
  angstrom   : TAngstromUnit;
  inch2      : TSquareInchUnit;
  ft2        : TSquareFootUnit;
  yd2        : TSquareYardUnit;
  mi2        : TSquareMileUnit;
  inch3      : TCubicInchUnit;
  ft3        : TCubicFootUnit;
  yd3        : TCubicYardUnit;
  L          : TLitreUnit;
  gal        : TGallonUnit;
  tonne      : TTonneUnit;
  lb         : TPoundUnit;
  oz         : TOunceUnit;
  st         : TStoneUnit;
  ton        : TTonUnit;
  degC       : TDegreeCelsiusUnit;
  degF       : TDegreeFahrenheitUnit;
  deg        : TDegreeUnit;
  deg2       : TSquareDegreeUnit;
  Gy         : TGrayUnit;
  Sv         : TSievertUnit;
  lbf        : TPoundForceUnit;
  bar        : TBarUnit;
  psi        : TPoundPerSquareInchUnit;
  eV         : TElectronvoltUnit;
  Ry         : TRydbergUnit;
  cal        : TCalorieUnit;
  Bq         : TBequerelUnit;

{ Helpers }

function SecondToString(const AValue: TQuantity): string;
function SecondToVerboseString(const AValue: TQuantity): string;
function SecondToFloat(const AValue: TQuantity): double;
function DayToString(const AValue: TQuantity): string;
function DayVerboseToString(const AValue: TQuantity): string;
function DayToFloat(const AValue: TQuantity): double;
function HourToString(const AValue: TQuantity): string;
function HourVerboseToString(const AValue: TQuantity): string;
function HourToFloat(const AValue: TQuantity): double;
function MinuteToString(const AValue: TQuantity): string;
function MinuteVerboseToString(const AValue: TQuantity): string;
function MinuteToFloat(const AValue: TQuantity): double;
function SquareSecondToString(const AValue: TQuantity): string;
function SquareSecondToVerboseString(const AValue: TQuantity): string;
function SquareSecondToFloat(const AValue: TQuantity): double;
function SquareDayToString(const AValue: TQuantity): string;
function SquareDayVerboseToString(const AValue: TQuantity): string;
function SquareDayToFloat(const AValue: TQuantity): double;
function SquareHourToString(const AValue: TQuantity): string;
function SquareHourVerboseToString(const AValue: TQuantity): string;
function SquareHourToFloat(const AValue: TQuantity): double;
function SquareMinuteToString(const AValue: TQuantity): string;
function SquareMinuteVerboseToString(const AValue: TQuantity): string;
function SquareMinuteToFloat(const AValue: TQuantity): double;
function CubicSecondToString(const AValue: TQuantity): string;
function CubicSecondToVerboseString(const AValue: TQuantity): string;
function CubicSecondToFloat(const AValue: TQuantity): double;
function QuarticSecondToString(const AValue: TQuantity): string;
function QuarticSecondToVerboseString(const AValue: TQuantity): string;
function QuarticSecondToFloat(const AValue: TQuantity): double;
function QuinticSecondToString(const AValue: TQuantity): string;
function QuinticSecondToVerboseString(const AValue: TQuantity): string;
function QuinticSecondToFloat(const AValue: TQuantity): double;
function SexticSecondToString(const AValue: TQuantity): string;
function SexticSecondToVerboseString(const AValue: TQuantity): string;
function SexticSecondToFloat(const AValue: TQuantity): double;
function MeterToString(const AValue: TQuantity): string;
function MeterToVerboseString(const AValue: TQuantity): string;
function MeterToFloat(const AValue: TQuantity): double;
function AstronomicalToString(const AValue: TQuantity): string;
function AstronomicalVerboseToString(const AValue: TQuantity): string;
function AstronomicalToFloat(const AValue: TQuantity): double;
function InchToString(const AValue: TQuantity): string;
function InchVerboseToString(const AValue: TQuantity): string;
function InchToFloat(const AValue: TQuantity): double;
function FootToString(const AValue: TQuantity): string;
function FootVerboseToString(const AValue: TQuantity): string;
function FootToFloat(const AValue: TQuantity): double;
function YardToString(const AValue: TQuantity): string;
function YardVerboseToString(const AValue: TQuantity): string;
function YardToFloat(const AValue: TQuantity): double;
function MileToString(const AValue: TQuantity): string;
function MileVerboseToString(const AValue: TQuantity): string;
function MileToFloat(const AValue: TQuantity): double;
function NauticalMileToString(const AValue: TQuantity): string;
function NauticalMileVerboseToString(const AValue: TQuantity): string;
function NauticalMileToFloat(const AValue: TQuantity): double;
function AngstromToString(const AValue: TQuantity): string;
function AngstromVerboseToString(const AValue: TQuantity): string;
function AngstromToFloat(const AValue: TQuantity): double;
function SquareRootMeterToString(const AValue: TQuantity): string;
function SquareRootMeterToVerboseString(const AValue: TQuantity): string;
function SquareRootMeterToFloat(const AValue: TQuantity): double;
function SquareMeterToString(const AValue: TQuantity): string;
function SquareMeterToVerboseString(const AValue: TQuantity): string;
function SquareMeterToFloat(const AValue: TQuantity): double;
function SquareInchToString(const AValue: TQuantity): string;
function SquareInchVerboseToString(const AValue: TQuantity): string;
function SquareInchToFloat(const AValue: TQuantity): double;
function SquareFootToString(const AValue: TQuantity): string;
function SquareFootVerboseToString(const AValue: TQuantity): string;
function SquareFootToFloat(const AValue: TQuantity): double;
function SquareYardToString(const AValue: TQuantity): string;
function SquareYardVerboseToString(const AValue: TQuantity): string;
function SquareYardToFloat(const AValue: TQuantity): double;
function SquareMileToString(const AValue: TQuantity): string;
function SquareMileVerboseToString(const AValue: TQuantity): string;
function SquareMileToFloat(const AValue: TQuantity): double;
function CubicMeterToString(const AValue: TQuantity): string;
function CubicMeterToVerboseString(const AValue: TQuantity): string;
function CubicMeterToFloat(const AValue: TQuantity): double;
function CubicInchToString(const AValue: TQuantity): string;
function CubicInchVerboseToString(const AValue: TQuantity): string;
function CubicInchToFloat(const AValue: TQuantity): double;
function CubicFootToString(const AValue: TQuantity): string;
function CubicFootVerboseToString(const AValue: TQuantity): string;
function CubicFootToFloat(const AValue: TQuantity): double;
function CubicYardToString(const AValue: TQuantity): string;
function CubicYardVerboseToString(const AValue: TQuantity): string;
function CubicYardToFloat(const AValue: TQuantity): double;
function LitreToString(const AValue: TQuantity): string;
function LitreVerboseToString(const AValue: TQuantity): string;
function LitreToFloat(const AValue: TQuantity): double;
function GallonToString(const AValue: TQuantity): string;
function GallonVerboseToString(const AValue: TQuantity): string;
function GallonToFloat(const AValue: TQuantity): double;
function QuarticMeterToString(const AValue: TQuantity): string;
function QuarticMeterToVerboseString(const AValue: TQuantity): string;
function QuarticMeterToFloat(const AValue: TQuantity): double;
function QuinticMeterToString(const AValue: TQuantity): string;
function QuinticMeterToVerboseString(const AValue: TQuantity): string;
function QuinticMeterToFloat(const AValue: TQuantity): double;
function SexticMeterToString(const AValue: TQuantity): string;
function SexticMeterToVerboseString(const AValue: TQuantity): string;
function SexticMeterToFloat(const AValue: TQuantity): double;
function KilogramToString(const AValue: TQuantity): string;
function KilogramToVerboseString(const AValue: TQuantity): string;
function KilogramToFloat(const AValue: TQuantity): double;
function TonneToString(const AValue: TQuantity): string;
function TonneVerboseToString(const AValue: TQuantity): string;
function TonneToFloat(const AValue: TQuantity): double;
function PoundToString(const AValue: TQuantity): string;
function PoundVerboseToString(const AValue: TQuantity): string;
function PoundToFloat(const AValue: TQuantity): double;
function OunceToString(const AValue: TQuantity): string;
function OunceVerboseToString(const AValue: TQuantity): string;
function OunceToFloat(const AValue: TQuantity): double;
function StoneToString(const AValue: TQuantity): string;
function StoneVerboseToString(const AValue: TQuantity): string;
function StoneToFloat(const AValue: TQuantity): double;
function TonToString(const AValue: TQuantity): string;
function TonVerboseToString(const AValue: TQuantity): string;
function TonToFloat(const AValue: TQuantity): double;
function ElectronvoltPerSquareSpeedOfLightToString(const AValue: TQuantity): string;
function ElectronvoltPerSquareSpeedOfLightVerboseToString(const AValue: TQuantity): string;
function ElectronvoltPerSquareSpeedOfLightToFloat(const AValue: TQuantity): double;
function SquareKilogramToString(const AValue: TQuantity): string;
function SquareKilogramToVerboseString(const AValue: TQuantity): string;
function SquareKilogramToFloat(const AValue: TQuantity): double;
function AmpereToString(const AValue: TQuantity): string;
function AmpereToVerboseString(const AValue: TQuantity): string;
function AmpereToFloat(const AValue: TQuantity): double;
function SquareAmpereToString(const AValue: TQuantity): string;
function SquareAmpereToVerboseString(const AValue: TQuantity): string;
function SquareAmpereToFloat(const AValue: TQuantity): double;
function KelvinToString(const AValue: TQuantity): string;
function KelvinToVerboseString(const AValue: TQuantity): string;
function KelvinToFloat(const AValue: TQuantity): double;
function DegreeCelsiusToString(const AValue: TQuantity): string;
function DegreeCelsiusVerboseToString(const AValue: TQuantity): string;
function DegreeCelsiusToFloat(const AValue: TQuantity): double;
function DegreeFahrenheitToString(const AValue: TQuantity): string;
function DegreeFahrenheitVerboseToString(const AValue: TQuantity): string;
function DegreeFahrenheitToFloat(const AValue: TQuantity): double;
function SquareKelvinToString(const AValue: TQuantity): string;
function SquareKelvinToVerboseString(const AValue: TQuantity): string;
function SquareKelvinToFloat(const AValue: TQuantity): double;
function CubicKelvinToString(const AValue: TQuantity): string;
function CubicKelvinToVerboseString(const AValue: TQuantity): string;
function CubicKelvinToFloat(const AValue: TQuantity): double;
function QuarticKelvinToString(const AValue: TQuantity): string;
function QuarticKelvinToVerboseString(const AValue: TQuantity): string;
function QuarticKelvinToFloat(const AValue: TQuantity): double;
function MoleToString(const AValue: TQuantity): string;
function MoleToVerboseString(const AValue: TQuantity): string;
function MoleToFloat(const AValue: TQuantity): double;
function CandelaToString(const AValue: TQuantity): string;
function CandelaToVerboseString(const AValue: TQuantity): string;
function CandelaToFloat(const AValue: TQuantity): double;
function RadianToString(const AValue: TQuantity): string;
function RadianToVerboseString(const AValue: TQuantity): string;
function RadianToFloat(const AValue: TQuantity): double;
function DegreeToString(const AValue: TQuantity): string;
function DegreeVerboseToString(const AValue: TQuantity): string;
function DegreeToFloat(const AValue: TQuantity): double;
function SteradianToString(const AValue: TQuantity): string;
function SteradianToVerboseString(const AValue: TQuantity): string;
function SteradianToFloat(const AValue: TQuantity): double;
function SquareDegreeToString(const AValue: TQuantity): string;
function SquareDegreeVerboseToString(const AValue: TQuantity): string;
function SquareDegreeToFloat(const AValue: TQuantity): double;
function HertzToString(const AValue: TQuantity): string;
function HertzToVerboseString(const AValue: TQuantity): string;
function HertzToFloat(const AValue: TQuantity): double;
function ReciprocalSecondToString(const AValue: TQuantity): string;
function ReciprocalSecondVerboseToString(const AValue: TQuantity): string;
function ReciprocalSecondToFloat(const AValue: TQuantity): double;
function RadianPerSecondToString(const AValue: TQuantity): string;
function RadianPerSecondVerboseToString(const AValue: TQuantity): string;
function RadianPerSecondToFloat(const AValue: TQuantity): double;
function SquareHertzToString(const AValue: TQuantity): string;
function SquareHertzToVerboseString(const AValue: TQuantity): string;
function SquareHertzToFloat(const AValue: TQuantity): double;
function ReciprocalSquareSecondToString(const AValue: TQuantity): string;
function ReciprocalSquareSecondVerboseToString(const AValue: TQuantity): string;
function ReciprocalSquareSecondToFloat(const AValue: TQuantity): double;
function RadianPerSquareSecondToString(const AValue: TQuantity): string;
function RadianPerSquareSecondVerboseToString(const AValue: TQuantity): string;
function RadianPerSquareSecondToFloat(const AValue: TQuantity): double;
function SteradianPerSquareSecondToString(const AValue: TQuantity): string;
function SteradianPerSquareSecondToVerboseString(const AValue: TQuantity): string;
function SteradianPerSquareSecondToFloat(const AValue: TQuantity): double;
function MeterPerSecondToString(const AValue: TQuantity): string;
function MeterPerSecondToVerboseString(const AValue: TQuantity): string;
function MeterPerSecondToFloat(const AValue: TQuantity): double;
function MeterPerHourToString(const AValue: TQuantity): string;
function MeterPerHourVerboseToString(const AValue: TQuantity): string;
function MeterPerHourToFloat(const AValue: TQuantity): double;
function MilePerHourToString(const AValue: TQuantity): string;
function MilePerHourVerboseToString(const AValue: TQuantity): string;
function MilePerHourToFloat(const AValue: TQuantity): double;
function NauticalMilePerHourToString(const AValue: TQuantity): string;
function NauticalMilePerHourVerboseToString(const AValue: TQuantity): string;
function NauticalMilePerHourToFloat(const AValue: TQuantity): double;
function MeterPerSquareSecondToString(const AValue: TQuantity): string;
function MeterPerSquareSecondToVerboseString(const AValue: TQuantity): string;
function MeterPerSquareSecondToFloat(const AValue: TQuantity): double;
function MeterPerSecondPerSecondToString(const AValue: TQuantity): string;
function MeterPerSecondPerSecondVerboseToString(const AValue: TQuantity): string;
function MeterPerSecondPerSecondToFloat(const AValue: TQuantity): double;
function MeterPerHourPerSecondToString(const AValue: TQuantity): string;
function MeterPerHourPerSecondVerboseToString(const AValue: TQuantity): string;
function MeterPerHourPerSecondToFloat(const AValue: TQuantity): double;
function MeterPerCubicSecondToString(const AValue: TQuantity): string;
function MeterPerCubicSecondToVerboseString(const AValue: TQuantity): string;
function MeterPerCubicSecondToFloat(const AValue: TQuantity): double;
function MeterPerQuarticSecondToString(const AValue: TQuantity): string;
function MeterPerQuarticSecondToVerboseString(const AValue: TQuantity): string;
function MeterPerQuarticSecondToFloat(const AValue: TQuantity): double;
function MeterPerQuinticSecondToString(const AValue: TQuantity): string;
function MeterPerQuinticSecondToVerboseString(const AValue: TQuantity): string;
function MeterPerQuinticSecondToFloat(const AValue: TQuantity): double;
function MeterPerSexticSecondToString(const AValue: TQuantity): string;
function MeterPerSexticSecondToVerboseString(const AValue: TQuantity): string;
function MeterPerSexticSecondToFloat(const AValue: TQuantity): double;
function SquareMeterPerSquareSecondToString(const AValue: TQuantity): string;
function SquareMeterPerSquareSecondToVerboseString(const AValue: TQuantity): string;
function SquareMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
function JoulePerKilogramToString(const AValue: TQuantity): string;
function JoulePerKilogramVerboseToString(const AValue: TQuantity): string;
function JoulePerKilogramToFloat(const AValue: TQuantity): double;
function GrayToString(const AValue: TQuantity): string;
function GrayVerboseToString(const AValue: TQuantity): string;
function GrayToFloat(const AValue: TQuantity): double;
function SievertToString(const AValue: TQuantity): string;
function SievertVerboseToString(const AValue: TQuantity): string;
function SievertToFloat(const AValue: TQuantity): double;
function MeterSecondToString(const AValue: TQuantity): string;
function MeterSecondToVerboseString(const AValue: TQuantity): string;
function MeterSecondToFloat(const AValue: TQuantity): double;
function KilogramMeterToString(const AValue: TQuantity): string;
function KilogramMeterToVerboseString(const AValue: TQuantity): string;
function KilogramMeterToFloat(const AValue: TQuantity): double;
function KilogramPerSecondToString(const AValue: TQuantity): string;
function KilogramPerSecondToVerboseString(const AValue: TQuantity): string;
function KilogramPerSecondToFloat(const AValue: TQuantity): double;
function JoulePerSquareMeterPerHertzToString(const AValue: TQuantity): string;
function JoulePerSquareMeterPerHertzVerboseToString(const AValue: TQuantity): string;
function JoulePerSquareMeterPerHertzToFloat(const AValue: TQuantity): double;
function KilogramMeterPerSecondToString(const AValue: TQuantity): string;
function KilogramMeterPerSecondToVerboseString(const AValue: TQuantity): string;
function KilogramMeterPerSecondToFloat(const AValue: TQuantity): double;
function NewtonSecondToString(const AValue: TQuantity): string;
function NewtonSecondVerboseToString(const AValue: TQuantity): string;
function NewtonSecondToFloat(const AValue: TQuantity): double;
function SquareKilogramSquareMeterPerSquareSecondToString(const AValue: TQuantity): string;
function SquareKilogramSquareMeterPerSquareSecondToVerboseString(const AValue: TQuantity): string;
function SquareKilogramSquareMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
function ReciprocalSquareRootMeterToString(const AValue: TQuantity): string;
function ReciprocalSquareRootMeterToVerboseString(const AValue: TQuantity): string;
function ReciprocalSquareRootMeterToFloat(const AValue: TQuantity): double;
function ReciprocalMeterToString(const AValue: TQuantity): string;
function ReciprocalMeterToVerboseString(const AValue: TQuantity): string;
function ReciprocalMeterToFloat(const AValue: TQuantity): double;
function DioptreToString(const AValue: TQuantity): string;
function DioptreVerboseToString(const AValue: TQuantity): string;
function DioptreToFloat(const AValue: TQuantity): double;
function ReciprocalSquareRootCubicMeterToString(const AValue: TQuantity): string;
function ReciprocalSquareRootCubicMeterToVerboseString(const AValue: TQuantity): string;
function ReciprocalSquareRootCubicMeterToFloat(const AValue: TQuantity): double;
function ReciprocalSquareMeterToString(const AValue: TQuantity): string;
function ReciprocalSquareMeterToVerboseString(const AValue: TQuantity): string;
function ReciprocalSquareMeterToFloat(const AValue: TQuantity): double;
function ReciprocalCubicMeterToString(const AValue: TQuantity): string;
function ReciprocalCubicMeterToVerboseString(const AValue: TQuantity): string;
function ReciprocalCubicMeterToFloat(const AValue: TQuantity): double;
function ReciprocalQuarticMeterToString(const AValue: TQuantity): string;
function ReciprocalQuarticMeterToVerboseString(const AValue: TQuantity): string;
function ReciprocalQuarticMeterToFloat(const AValue: TQuantity): double;
function KilogramSquareMeterToString(const AValue: TQuantity): string;
function KilogramSquareMeterToVerboseString(const AValue: TQuantity): string;
function KilogramSquareMeterToFloat(const AValue: TQuantity): double;
function KilogramSquareMeterPerSecondToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerSecondToVerboseString(const AValue: TQuantity): string;
function KilogramSquareMeterPerSecondToFloat(const AValue: TQuantity): double;
function NewtonMeterSecondToString(const AValue: TQuantity): string;
function NewtonMeterSecondVerboseToString(const AValue: TQuantity): string;
function NewtonMeterSecondToFloat(const AValue: TQuantity): double;
function SecondPerMeterToString(const AValue: TQuantity): string;
function SecondPerMeterToVerboseString(const AValue: TQuantity): string;
function SecondPerMeterToFloat(const AValue: TQuantity): double;
function KilogramPerMeterToString(const AValue: TQuantity): string;
function KilogramPerMeterToVerboseString(const AValue: TQuantity): string;
function KilogramPerMeterToFloat(const AValue: TQuantity): double;
function KilogramPerSquareMeterToString(const AValue: TQuantity): string;
function KilogramPerSquareMeterToVerboseString(const AValue: TQuantity): string;
function KilogramPerSquareMeterToFloat(const AValue: TQuantity): double;
function KilogramPerCubicMeterToString(const AValue: TQuantity): string;
function KilogramPerCubicMeterToVerboseString(const AValue: TQuantity): string;
function KilogramPerCubicMeterToFloat(const AValue: TQuantity): double;
function PoundPerCubicInchToString(const AValue: TQuantity): string;
function PoundPerCubicInchVerboseToString(const AValue: TQuantity): string;
function PoundPerCubicInchToFloat(const AValue: TQuantity): double;
function NewtonToString(const AValue: TQuantity): string;
function NewtonToVerboseString(const AValue: TQuantity): string;
function NewtonToFloat(const AValue: TQuantity): double;
function PoundForceToString(const AValue: TQuantity): string;
function PoundForceVerboseToString(const AValue: TQuantity): string;
function PoundForceToFloat(const AValue: TQuantity): double;
function KilogramMeterPerSquareSecondToString(const AValue: TQuantity): string;
function KilogramMeterPerSquareSecondVerboseToString(const AValue: TQuantity): string;
function KilogramMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
function NewtonRadianToString(const AValue: TQuantity): string;
function NewtonRadianToVerboseString(const AValue: TQuantity): string;
function NewtonRadianToFloat(const AValue: TQuantity): double;
function SquareNewtonToString(const AValue: TQuantity): string;
function SquareNewtonToVerboseString(const AValue: TQuantity): string;
function SquareNewtonToFloat(const AValue: TQuantity): double;
function SquareKilogramSquareMeterPerQuarticSecondToString(const AValue: TQuantity): string;
function SquareKilogramSquareMeterPerQuarticSecondVerboseToString(const AValue: TQuantity): string;
function SquareKilogramSquareMeterPerQuarticSecondToFloat(const AValue: TQuantity): double;
function PascalToString(const AValue: TQuantity): string;
function PascalToVerboseString(const AValue: TQuantity): string;
function PascalToFloat(const AValue: TQuantity): double;
function NewtonPerSquareMeterToString(const AValue: TQuantity): string;
function NewtonPerSquareMeterVerboseToString(const AValue: TQuantity): string;
function NewtonPerSquareMeterToFloat(const AValue: TQuantity): double;
function BarToString(const AValue: TQuantity): string;
function BarVerboseToString(const AValue: TQuantity): string;
function BarToFloat(const AValue: TQuantity): double;
function PoundPerSquareInchToString(const AValue: TQuantity): string;
function PoundPerSquareInchVerboseToString(const AValue: TQuantity): string;
function PoundPerSquareInchToFloat(const AValue: TQuantity): double;
function JoulePerCubicMeterToString(const AValue: TQuantity): string;
function JoulePerCubicMeterVerboseToString(const AValue: TQuantity): string;
function JoulePerCubicMeterToFloat(const AValue: TQuantity): double;
function KilogramPerMeterPerSquareSecondToString(const AValue: TQuantity): string;
function KilogramPerMeterPerSquareSecondVerboseToString(const AValue: TQuantity): string;
function KilogramPerMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
function JouleToString(const AValue: TQuantity): string;
function JouleToVerboseString(const AValue: TQuantity): string;
function JouleToFloat(const AValue: TQuantity): double;
function WattHourToString(const AValue: TQuantity): string;
function WattHourVerboseToString(const AValue: TQuantity): string;
function WattHourToFloat(const AValue: TQuantity): double;
function WattSecondToString(const AValue: TQuantity): string;
function WattSecondVerboseToString(const AValue: TQuantity): string;
function WattSecondToFloat(const AValue: TQuantity): double;
function WattPerHertzToString(const AValue: TQuantity): string;
function WattPerHertzVerboseToString(const AValue: TQuantity): string;
function WattPerHertzToFloat(const AValue: TQuantity): double;
function ElectronvoltToString(const AValue: TQuantity): string;
function ElectronvoltVerboseToString(const AValue: TQuantity): string;
function ElectronvoltToFloat(const AValue: TQuantity): double;
function NewtonMeterToString(const AValue: TQuantity): string;
function NewtonMeterVerboseToString(const AValue: TQuantity): string;
function NewtonMeterToFloat(const AValue: TQuantity): double;
function PoundForceInchToString(const AValue: TQuantity): string;
function PoundForceInchVerboseToString(const AValue: TQuantity): string;
function PoundForceInchToFloat(const AValue: TQuantity): double;
function RydbergToString(const AValue: TQuantity): string;
function RydbergVerboseToString(const AValue: TQuantity): string;
function RydbergToFloat(const AValue: TQuantity): double;
function CalorieToString(const AValue: TQuantity): string;
function CalorieVerboseToString(const AValue: TQuantity): string;
function CalorieToFloat(const AValue: TQuantity): double;
function KilogramSquareMeterPerSquareSecondToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerSquareSecondVerboseToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
function JoulePerRadianToString(const AValue: TQuantity): string;
function JoulePerRadianToVerboseString(const AValue: TQuantity): string;
function JoulePerRadianToFloat(const AValue: TQuantity): double;
function JoulePerDegreeToString(const AValue: TQuantity): string;
function JoulePerDegreeVerboseToString(const AValue: TQuantity): string;
function JoulePerDegreeToFloat(const AValue: TQuantity): double;
function NewtonMeterPerRadianToString(const AValue: TQuantity): string;
function NewtonMeterPerRadianVerboseToString(const AValue: TQuantity): string;
function NewtonMeterPerRadianToFloat(const AValue: TQuantity): double;
function NewtonMeterPerDegreeToString(const AValue: TQuantity): string;
function NewtonMeterPerDegreeVerboseToString(const AValue: TQuantity): string;
function NewtonMeterPerDegreeToFloat(const AValue: TQuantity): double;
function KilogramSquareMeterPerSquareSecondPerRadianToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerSquareSecondPerRadianVerboseToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerSquareSecondPerRadianToFloat(const AValue: TQuantity): double;
function WattToString(const AValue: TQuantity): string;
function WattToVerboseString(const AValue: TQuantity): string;
function WattToFloat(const AValue: TQuantity): double;
function KilogramSquareMeterPerCubicSecondToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerCubicSecondVerboseToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerCubicSecondToFloat(const AValue: TQuantity): double;
function CoulombToString(const AValue: TQuantity): string;
function CoulombToVerboseString(const AValue: TQuantity): string;
function CoulombToFloat(const AValue: TQuantity): double;
function AmpereHourToString(const AValue: TQuantity): string;
function AmpereHourVerboseToString(const AValue: TQuantity): string;
function AmpereHourToFloat(const AValue: TQuantity): double;
function AmpereSecondToString(const AValue: TQuantity): string;
function AmpereSecondVerboseToString(const AValue: TQuantity): string;
function AmpereSecondToFloat(const AValue: TQuantity): double;
function SquareCoulombToString(const AValue: TQuantity): string;
function SquareCoulombToVerboseString(const AValue: TQuantity): string;
function SquareCoulombToFloat(const AValue: TQuantity): double;
function SquareAmpereSquareSecondToString(const AValue: TQuantity): string;
function SquareAmpereSquareSecondVerboseToString(const AValue: TQuantity): string;
function SquareAmpereSquareSecondToFloat(const AValue: TQuantity): double;
function CoulombMeterToString(const AValue: TQuantity): string;
function CoulombMeterToVerboseString(const AValue: TQuantity): string;
function CoulombMeterToFloat(const AValue: TQuantity): double;
function VoltToString(const AValue: TQuantity): string;
function VoltToVerboseString(const AValue: TQuantity): string;
function VoltToFloat(const AValue: TQuantity): double;
function JoulePerCoulombToString(const AValue: TQuantity): string;
function JoulePerCoulombVerboseToString(const AValue: TQuantity): string;
function JoulePerCoulombToFloat(const AValue: TQuantity): double;
function KilogramSquareMeterPerAmperePerCubicSecondToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerAmperePerCubicSecondVerboseToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerAmperePerCubicSecondToFloat(const AValue: TQuantity): double;
function SquareVoltToString(const AValue: TQuantity): string;
function SquareVoltToVerboseString(const AValue: TQuantity): string;
function SquareVoltToFloat(const AValue: TQuantity): double;
function SquareKilogramQuarticMeterPerSquareAmperePerSexticSecondToString(const AValue: TQuantity): string;
function SquareKilogramQuarticMeterPerSquareAmperePerSexticSecondVerboseToString(const AValue: TQuantity): string;
function SquareKilogramQuarticMeterPerSquareAmperePerSexticSecondToFloat(const AValue: TQuantity): double;
function FaradToString(const AValue: TQuantity): string;
function FaradToVerboseString(const AValue: TQuantity): string;
function FaradToFloat(const AValue: TQuantity): double;
function CoulombPerVoltToString(const AValue: TQuantity): string;
function CoulombPerVoltVerboseToString(const AValue: TQuantity): string;
function CoulombPerVoltToFloat(const AValue: TQuantity): double;
function SquareAmpereQuarticSecondPerKilogramPerSquareMeterToString(const AValue: TQuantity): string;
function SquareAmpereQuarticSecondPerKilogramPerSquareMeterVerboseToString(const AValue: TQuantity): string;
function SquareAmpereQuarticSecondPerKilogramPerSquareMeterToFloat(const AValue: TQuantity): double;
function OhmToString(const AValue: TQuantity): string;
function OhmToVerboseString(const AValue: TQuantity): string;
function OhmToFloat(const AValue: TQuantity): double;
function KilogramSquareMeterPerSquareAmperePerCubicSecondToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerSquareAmperePerCubicSecondVerboseToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerSquareAmperePerCubicSecondToFloat(const AValue: TQuantity): double;
function SiemensToString(const AValue: TQuantity): string;
function SiemensToVerboseString(const AValue: TQuantity): string;
function SiemensToFloat(const AValue: TQuantity): double;
function SquareAmpereCubicSecondPerKilogramPerSquareMeterToString(const AValue: TQuantity): string;
function SquareAmpereCubicSecondPerKilogramPerSquareMeterVerboseToString(const AValue: TQuantity): string;
function SquareAmpereCubicSecondPerKilogramPerSquareMeterToFloat(const AValue: TQuantity): double;
function SiemensPerMeterToString(const AValue: TQuantity): string;
function SiemensPerMeterToVerboseString(const AValue: TQuantity): string;
function SiemensPerMeterToFloat(const AValue: TQuantity): double;
function TeslaToString(const AValue: TQuantity): string;
function TeslaToVerboseString(const AValue: TQuantity): string;
function TeslaToFloat(const AValue: TQuantity): double;
function WeberPerSquareMeterToString(const AValue: TQuantity): string;
function WeberPerSquareMeterVerboseToString(const AValue: TQuantity): string;
function WeberPerSquareMeterToFloat(const AValue: TQuantity): double;
function KilogramPerAmperePerSquareSecondToString(const AValue: TQuantity): string;
function KilogramPerAmperePerSquareSecondVerboseToString(const AValue: TQuantity): string;
function KilogramPerAmperePerSquareSecondToFloat(const AValue: TQuantity): double;
function WeberToString(const AValue: TQuantity): string;
function WeberToVerboseString(const AValue: TQuantity): string;
function WeberToFloat(const AValue: TQuantity): double;
function KilogramSquareMeterPerAmperePerSquareSecondToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerAmperePerSquareSecondVerboseToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerAmperePerSquareSecondToFloat(const AValue: TQuantity): double;
function HenryToString(const AValue: TQuantity): string;
function HenryToVerboseString(const AValue: TQuantity): string;
function HenryToFloat(const AValue: TQuantity): double;
function KilogramSquareMeterPerSquareAmperePerSquareSecondToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerSquareAmperePerSquareSecondVerboseToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerSquareAmperePerSquareSecondToFloat(const AValue: TQuantity): double;
function ReciprocalHenryToString(const AValue: TQuantity): string;
function ReciprocalHenryToVerboseString(const AValue: TQuantity): string;
function ReciprocalHenryToFloat(const AValue: TQuantity): double;
function LumenToString(const AValue: TQuantity): string;
function LumenToVerboseString(const AValue: TQuantity): string;
function LumenToFloat(const AValue: TQuantity): double;
function CandelaSteradianToString(const AValue: TQuantity): string;
function CandelaSteradianVerboseToString(const AValue: TQuantity): string;
function CandelaSteradianToFloat(const AValue: TQuantity): double;
function LumenSecondToString(const AValue: TQuantity): string;
function LumenSecondToVerboseString(const AValue: TQuantity): string;
function LumenSecondToFloat(const AValue: TQuantity): double;
function LumenSecondPerCubicMeterToString(const AValue: TQuantity): string;
function LumenSecondPerCubicMeterToVerboseString(const AValue: TQuantity): string;
function LumenSecondPerCubicMeterToFloat(const AValue: TQuantity): double;
function LuxToString(const AValue: TQuantity): string;
function LuxToVerboseString(const AValue: TQuantity): string;
function LuxToFloat(const AValue: TQuantity): double;
function CandelaSteradianPerSquareMeterToString(const AValue: TQuantity): string;
function CandelaSteradianPerSquareMeterVerboseToString(const AValue: TQuantity): string;
function CandelaSteradianPerSquareMeterToFloat(const AValue: TQuantity): double;
function LuxSecondToString(const AValue: TQuantity): string;
function LuxSecondToVerboseString(const AValue: TQuantity): string;
function LuxSecondToFloat(const AValue: TQuantity): double;
function BequerelToString(const AValue: TQuantity): string;
function BequerelVerboseToString(const AValue: TQuantity): string;
function BequerelToFloat(const AValue: TQuantity): double;
function KatalToString(const AValue: TQuantity): string;
function KatalToVerboseString(const AValue: TQuantity): string;
function KatalToFloat(const AValue: TQuantity): double;
function MolePerSecondToString(const AValue: TQuantity): string;
function MolePerSecondVerboseToString(const AValue: TQuantity): string;
function MolePerSecondToFloat(const AValue: TQuantity): double;
function NewtonPerCubicMeterToString(const AValue: TQuantity): string;
function NewtonPerCubicMeterToVerboseString(const AValue: TQuantity): string;
function NewtonPerCubicMeterToFloat(const AValue: TQuantity): double;
function PascalPerMeterToString(const AValue: TQuantity): string;
function PascalPerMeterVerboseToString(const AValue: TQuantity): string;
function PascalPerMeterToFloat(const AValue: TQuantity): double;
function KilogramPerSquareMeterPerSquareSecondToString(const AValue: TQuantity): string;
function KilogramPerSquareMeterPerSquareSecondVerboseToString(const AValue: TQuantity): string;
function KilogramPerSquareMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
function NewtonPerMeterToString(const AValue: TQuantity): string;
function NewtonPerMeterToVerboseString(const AValue: TQuantity): string;
function NewtonPerMeterToFloat(const AValue: TQuantity): double;
function JoulePerSquareMeterToString(const AValue: TQuantity): string;
function JoulePerSquareMeterVerboseToString(const AValue: TQuantity): string;
function JoulePerSquareMeterToFloat(const AValue: TQuantity): double;
function WattPerSquareMeterPerHertzToString(const AValue: TQuantity): string;
function WattPerSquareMeterPerHertzVerboseToString(const AValue: TQuantity): string;
function WattPerSquareMeterPerHertzToFloat(const AValue: TQuantity): double;
function PoundForcePerInchToString(const AValue: TQuantity): string;
function PoundForcePerInchVerboseToString(const AValue: TQuantity): string;
function PoundForcePerInchToFloat(const AValue: TQuantity): double;
function KilogramPerSquareSecondToString(const AValue: TQuantity): string;
function KilogramPerSquareSecondVerboseToString(const AValue: TQuantity): string;
function KilogramPerSquareSecondToFloat(const AValue: TQuantity): double;
function CubicMeterPerSecondToString(const AValue: TQuantity): string;
function CubicMeterPerSecondToVerboseString(const AValue: TQuantity): string;
function CubicMeterPerSecondToFloat(const AValue: TQuantity): double;
function PoiseuilleToString(const AValue: TQuantity): string;
function PoiseuilleToVerboseString(const AValue: TQuantity): string;
function PoiseuilleToFloat(const AValue: TQuantity): double;
function PascalSecondToString(const AValue: TQuantity): string;
function PascalSecondVerboseToString(const AValue: TQuantity): string;
function PascalSecondToFloat(const AValue: TQuantity): double;
function KilogramPerMeterPerSecondToString(const AValue: TQuantity): string;
function KilogramPerMeterPerSecondVerboseToString(const AValue: TQuantity): string;
function KilogramPerMeterPerSecondToFloat(const AValue: TQuantity): double;
function SquareMeterPerSecondToString(const AValue: TQuantity): string;
function SquareMeterPerSecondToVerboseString(const AValue: TQuantity): string;
function SquareMeterPerSecondToFloat(const AValue: TQuantity): double;
function KilogramPerQuarticMeterToString(const AValue: TQuantity): string;
function KilogramPerQuarticMeterToVerboseString(const AValue: TQuantity): string;
function KilogramPerQuarticMeterToFloat(const AValue: TQuantity): double;
function QuarticMeterSecondToString(const AValue: TQuantity): string;
function QuarticMeterSecondToVerboseString(const AValue: TQuantity): string;
function QuarticMeterSecondToFloat(const AValue: TQuantity): double;
function KilogramPerQuarticMeterPerSecondToString(const AValue: TQuantity): string;
function KilogramPerQuarticMeterPerSecondToVerboseString(const AValue: TQuantity): string;
function KilogramPerQuarticMeterPerSecondToFloat(const AValue: TQuantity): double;
function CubicMeterPerKilogramToString(const AValue: TQuantity): string;
function CubicMeterPerKilogramToVerboseString(const AValue: TQuantity): string;
function CubicMeterPerKilogramToFloat(const AValue: TQuantity): double;
function KilogramSquareSecondToString(const AValue: TQuantity): string;
function KilogramSquareSecondToVerboseString(const AValue: TQuantity): string;
function KilogramSquareSecondToFloat(const AValue: TQuantity): double;
function CubicMeterPerSquareSecondToString(const AValue: TQuantity): string;
function CubicMeterPerSquareSecondToVerboseString(const AValue: TQuantity): string;
function CubicMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
function NewtonSquareMeterToString(const AValue: TQuantity): string;
function NewtonSquareMeterToVerboseString(const AValue: TQuantity): string;
function NewtonSquareMeterToFloat(const AValue: TQuantity): double;
function KilogramCubicMeterPerSquareSecondToString(const AValue: TQuantity): string;
function KilogramCubicMeterPerSquareSecondVerboseToString(const AValue: TQuantity): string;
function KilogramCubicMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
function NewtonCubicMeterToString(const AValue: TQuantity): string;
function NewtonCubicMeterToVerboseString(const AValue: TQuantity): string;
function NewtonCubicMeterToFloat(const AValue: TQuantity): double;
function KilogramQuarticMeterPerSquareSecondToString(const AValue: TQuantity): string;
function KilogramQuarticMeterPerSquareSecondVerboseToString(const AValue: TQuantity): string;
function KilogramQuarticMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
function NewtonPerSquareKilogramToString(const AValue: TQuantity): string;
function NewtonPerSquareKilogramToVerboseString(const AValue: TQuantity): string;
function NewtonPerSquareKilogramToFloat(const AValue: TQuantity): double;
function MeterPerKilogramPerSquareSecondToString(const AValue: TQuantity): string;
function MeterPerKilogramPerSquareSecondVerboseToString(const AValue: TQuantity): string;
function MeterPerKilogramPerSquareSecondToFloat(const AValue: TQuantity): double;
function SquareKilogramPerMeterToString(const AValue: TQuantity): string;
function SquareKilogramPerMeterToVerboseString(const AValue: TQuantity): string;
function SquareKilogramPerMeterToFloat(const AValue: TQuantity): double;
function SquareKilogramPerSquareMeterToString(const AValue: TQuantity): string;
function SquareKilogramPerSquareMeterToVerboseString(const AValue: TQuantity): string;
function SquareKilogramPerSquareMeterToFloat(const AValue: TQuantity): double;
function SquareMeterPerSquareKilogramToString(const AValue: TQuantity): string;
function SquareMeterPerSquareKilogramToVerboseString(const AValue: TQuantity): string;
function SquareMeterPerSquareKilogramToFloat(const AValue: TQuantity): double;
function NewtonSquareMeterPerSquareKilogramToString(const AValue: TQuantity): string;
function NewtonSquareMeterPerSquareKilogramToVerboseString(const AValue: TQuantity): string;
function NewtonSquareMeterPerSquareKilogramToFloat(const AValue: TQuantity): double;
function CubicMeterPerKilogramPerSquareSecondToString(const AValue: TQuantity): string;
function CubicMeterPerKilogramPerSquareSecondVerboseToString(const AValue: TQuantity): string;
function CubicMeterPerKilogramPerSquareSecondToFloat(const AValue: TQuantity): double;
function ReciprocalKelvinToString(const AValue: TQuantity): string;
function ReciprocalKelvinToVerboseString(const AValue: TQuantity): string;
function ReciprocalKelvinToFloat(const AValue: TQuantity): double;
function KilogramKelvinToString(const AValue: TQuantity): string;
function KilogramKelvinToVerboseString(const AValue: TQuantity): string;
function KilogramKelvinToFloat(const AValue: TQuantity): double;
function JoulePerKelvinToString(const AValue: TQuantity): string;
function JoulePerKelvinToVerboseString(const AValue: TQuantity): string;
function JoulePerKelvinToFloat(const AValue: TQuantity): double;
function KilogramSquareMeterPerSquareSecondPerKelvinToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerSquareSecondPerKelvinVerboseToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerSquareSecondPerKelvinToFloat(const AValue: TQuantity): double;
function JoulePerKilogramPerKelvinToString(const AValue: TQuantity): string;
function JoulePerKilogramPerKelvinToVerboseString(const AValue: TQuantity): string;
function JoulePerKilogramPerKelvinToFloat(const AValue: TQuantity): double;
function SquareMeterPerSquareSecondPerKelvinToString(const AValue: TQuantity): string;
function SquareMeterPerSquareSecondPerKelvinVerboseToString(const AValue: TQuantity): string;
function SquareMeterPerSquareSecondPerKelvinToFloat(const AValue: TQuantity): double;
function MeterKelvinToString(const AValue: TQuantity): string;
function MeterKelvinToVerboseString(const AValue: TQuantity): string;
function MeterKelvinToFloat(const AValue: TQuantity): double;
function KelvinPerMeterToString(const AValue: TQuantity): string;
function KelvinPerMeterToVerboseString(const AValue: TQuantity): string;
function KelvinPerMeterToFloat(const AValue: TQuantity): double;
function WattPerMeterToString(const AValue: TQuantity): string;
function WattPerMeterToVerboseString(const AValue: TQuantity): string;
function WattPerMeterToFloat(const AValue: TQuantity): double;
function KilogramMeterPerCubicSecondToString(const AValue: TQuantity): string;
function KilogramMeterPerCubicSecondVerboseToString(const AValue: TQuantity): string;
function KilogramMeterPerCubicSecondToFloat(const AValue: TQuantity): double;
function WattPerSquareMeterToString(const AValue: TQuantity): string;
function WattPerSquareMeterToVerboseString(const AValue: TQuantity): string;
function WattPerSquareMeterToFloat(const AValue: TQuantity): double;
function KilogramPerCubicSecondToString(const AValue: TQuantity): string;
function KilogramPerCubicSecondVerboseToString(const AValue: TQuantity): string;
function KilogramPerCubicSecondToFloat(const AValue: TQuantity): double;
function WattPerCubicMeterToString(const AValue: TQuantity): string;
function WattPerCubicMeterToVerboseString(const AValue: TQuantity): string;
function WattPerCubicMeterToFloat(const AValue: TQuantity): double;
function WattPerKelvinToString(const AValue: TQuantity): string;
function WattPerKelvinToVerboseString(const AValue: TQuantity): string;
function WattPerKelvinToFloat(const AValue: TQuantity): double;
function KilogramSquareMeterPerCubicSecondPerKelvinToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerCubicSecondPerKelvinVerboseToString(const AValue: TQuantity): string;
function KilogramSquareMeterPerCubicSecondPerKelvinToFloat(const AValue: TQuantity): double;
function WattPerMeterPerKelvinToString(const AValue: TQuantity): string;
function WattPerMeterPerKelvinToVerboseString(const AValue: TQuantity): string;
function WattPerMeterPerKelvinToFloat(const AValue: TQuantity): double;
function KilogramMeterPerCubicSecondPerKelvinToString(const AValue: TQuantity): string;
function KilogramMeterPerCubicSecondPerKelvinVerboseToString(const AValue: TQuantity): string;
function KilogramMeterPerCubicSecondPerKelvinToFloat(const AValue: TQuantity): double;
function KelvinPerWattToString(const AValue: TQuantity): string;
function KelvinPerWattToVerboseString(const AValue: TQuantity): string;
function KelvinPerWattToFloat(const AValue: TQuantity): double;
function MeterPerWattToString(const AValue: TQuantity): string;
function MeterPerWattToVerboseString(const AValue: TQuantity): string;
function MeterPerWattToFloat(const AValue: TQuantity): double;
function MeterKelvinPerWattToString(const AValue: TQuantity): string;
function MeterKelvinPerWattToVerboseString(const AValue: TQuantity): string;
function MeterKelvinPerWattToFloat(const AValue: TQuantity): double;
function SquareMeterKelvinToString(const AValue: TQuantity): string;
function SquareMeterKelvinToVerboseString(const AValue: TQuantity): string;
function SquareMeterKelvinToFloat(const AValue: TQuantity): double;
function WattPerSquareMeterPerKelvinToString(const AValue: TQuantity): string;
function WattPerSquareMeterPerKelvinToVerboseString(const AValue: TQuantity): string;
function WattPerSquareMeterPerKelvinToFloat(const AValue: TQuantity): double;
function KilogramPerCubicSecondPerKelvinToString(const AValue: TQuantity): string;
function KilogramPerCubicSecondPerKelvinVerboseToString(const AValue: TQuantity): string;
function KilogramPerCubicSecondPerKelvinToFloat(const AValue: TQuantity): double;
function SquareMeterQuarticKelvinToString(const AValue: TQuantity): string;
function SquareMeterQuarticKelvinToVerboseString(const AValue: TQuantity): string;
function SquareMeterQuarticKelvinToFloat(const AValue: TQuantity): double;
function WattPerQuarticKelvinToString(const AValue: TQuantity): string;
function WattPerQuarticKelvinToVerboseString(const AValue: TQuantity): string;
function WattPerQuarticKelvinToFloat(const AValue: TQuantity): double;
function WattPerSquareMeterPerQuarticKelvinToString(const AValue: TQuantity): string;
function WattPerSquareMeterPerQuarticKelvinToVerboseString(const AValue: TQuantity): string;
function WattPerSquareMeterPerQuarticKelvinToFloat(const AValue: TQuantity): double;
function JoulePerMoleToString(const AValue: TQuantity): string;
function JoulePerMoleToVerboseString(const AValue: TQuantity): string;
function JoulePerMoleToFloat(const AValue: TQuantity): double;
function MoleKelvinToString(const AValue: TQuantity): string;
function MoleKelvinToVerboseString(const AValue: TQuantity): string;
function MoleKelvinToFloat(const AValue: TQuantity): double;
function JoulePerMolePerKelvinToString(const AValue: TQuantity): string;
function JoulePerMolePerKelvinToVerboseString(const AValue: TQuantity): string;
function JoulePerMolePerKelvinToFloat(const AValue: TQuantity): double;
function OhmMeterToString(const AValue: TQuantity): string;
function OhmMeterToVerboseString(const AValue: TQuantity): string;
function OhmMeterToFloat(const AValue: TQuantity): double;
function VoltPerMeterToString(const AValue: TQuantity): string;
function VoltPerMeterToVerboseString(const AValue: TQuantity): string;
function VoltPerMeterToFloat(const AValue: TQuantity): double;
function NewtonPerCoulombToString(const AValue: TQuantity): string;
function NewtonPerCoulombVerboseToString(const AValue: TQuantity): string;
function NewtonPerCoulombToFloat(const AValue: TQuantity): double;
function CoulombPerMeterToString(const AValue: TQuantity): string;
function CoulombPerMeterToVerboseString(const AValue: TQuantity): string;
function CoulombPerMeterToFloat(const AValue: TQuantity): double;
function SquareCoulombPerMeterToString(const AValue: TQuantity): string;
function SquareCoulombPerMeterToVerboseString(const AValue: TQuantity): string;
function SquareCoulombPerMeterToFloat(const AValue: TQuantity): double;
function CoulombPerSquareMeterToString(const AValue: TQuantity): string;
function CoulombPerSquareMeterToVerboseString(const AValue: TQuantity): string;
function CoulombPerSquareMeterToFloat(const AValue: TQuantity): double;
function SquareMeterPerSquareCoulombToString(const AValue: TQuantity): string;
function SquareMeterPerSquareCoulombToVerboseString(const AValue: TQuantity): string;
function SquareMeterPerSquareCoulombToFloat(const AValue: TQuantity): double;
function NewtonPerSquareCoulombToString(const AValue: TQuantity): string;
function NewtonPerSquareCoulombToVerboseString(const AValue: TQuantity): string;
function NewtonPerSquareCoulombToFloat(const AValue: TQuantity): double;
function NewtonSquareMeterPerSquareCoulombToString(const AValue: TQuantity): string;
function NewtonSquareMeterPerSquareCoulombToVerboseString(const AValue: TQuantity): string;
function NewtonSquareMeterPerSquareCoulombToFloat(const AValue: TQuantity): double;
function VoltMeterToString(const AValue: TQuantity): string;
function VoltMeterToVerboseString(const AValue: TQuantity): string;
function VoltMeterToFloat(const AValue: TQuantity): double;
function NewtonSquareMeterPerCoulombToString(const AValue: TQuantity): string;
function NewtonSquareMeterPerCoulombVerboseToString(const AValue: TQuantity): string;
function NewtonSquareMeterPerCoulombToFloat(const AValue: TQuantity): double;
function VoltMeterPerSecondToString(const AValue: TQuantity): string;
function VoltMeterPerSecondToVerboseString(const AValue: TQuantity): string;
function VoltMeterPerSecondToFloat(const AValue: TQuantity): double;
function FaradPerMeterToString(const AValue: TQuantity): string;
function FaradPerMeterToVerboseString(const AValue: TQuantity): string;
function FaradPerMeterToFloat(const AValue: TQuantity): double;
function AmperePerMeterToString(const AValue: TQuantity): string;
function AmperePerMeterToVerboseString(const AValue: TQuantity): string;
function AmperePerMeterToFloat(const AValue: TQuantity): double;
function MeterPerAmpereToString(const AValue: TQuantity): string;
function MeterPerAmpereToVerboseString(const AValue: TQuantity): string;
function MeterPerAmpereToFloat(const AValue: TQuantity): double;
function TeslaMeterToString(const AValue: TQuantity): string;
function TeslaMeterToVerboseString(const AValue: TQuantity): string;
function TeslaMeterToFloat(const AValue: TQuantity): double;
function NewtonPerAmpereToString(const AValue: TQuantity): string;
function NewtonPerAmpereVerboseToString(const AValue: TQuantity): string;
function NewtonPerAmpereToFloat(const AValue: TQuantity): double;
function TeslaPerAmpereToString(const AValue: TQuantity): string;
function TeslaPerAmpereToVerboseString(const AValue: TQuantity): string;
function TeslaPerAmpereToFloat(const AValue: TQuantity): double;
function HenryPerMeterToString(const AValue: TQuantity): string;
function HenryPerMeterToVerboseString(const AValue: TQuantity): string;
function HenryPerMeterToFloat(const AValue: TQuantity): double;
function TeslaMeterPerAmpereToString(const AValue: TQuantity): string;
function TeslaMeterPerAmpereVerboseToString(const AValue: TQuantity): string;
function TeslaMeterPerAmpereToFloat(const AValue: TQuantity): double;
function NewtonPerSquareAmpereToString(const AValue: TQuantity): string;
function NewtonPerSquareAmpereVerboseToString(const AValue: TQuantity): string;
function NewtonPerSquareAmpereToFloat(const AValue: TQuantity): double;
function RadianPerMeterToString(const AValue: TQuantity): string;
function RadianPerMeterToVerboseString(const AValue: TQuantity): string;
function RadianPerMeterToFloat(const AValue: TQuantity): double;
function SquareKilogramPerSquareSecondToString(const AValue: TQuantity): string;
function SquareKilogramPerSquareSecondToVerboseString(const AValue: TQuantity): string;
function SquareKilogramPerSquareSecondToFloat(const AValue: TQuantity): double;
function SquareSecondPerSquareMeterToString(const AValue: TQuantity): string;
function SquareSecondPerSquareMeterToVerboseString(const AValue: TQuantity): string;
function SquareSecondPerSquareMeterToFloat(const AValue: TQuantity): double;
function SquareJouleToString(const AValue: TQuantity): string;
function SquareJouleToVerboseString(const AValue: TQuantity): string;
function SquareJouleToFloat(const AValue: TQuantity): double;
function JouleSecondToString(const AValue: TQuantity): string;
function JouleSecondVerboseToString(const AValue: TQuantity): string;
function JouleSecondToFloat(const AValue: TQuantity): double;
function JoulePerHertzToString(const AValue: TQuantity): string;
function JoulePerHertzVerboseToString(const AValue: TQuantity): string;
function JoulePerHertzToFloat(const AValue: TQuantity): double;
function ElectronvoltSecondToString(const AValue: TQuantity): string;
function ElectronvoltSecondVerboseToString(const AValue: TQuantity): string;
function ElectronvoltSecondToFloat(const AValue: TQuantity): double;
function ElectronvoltMeterPerSpeedOfLightToString(const AValue: TQuantity): string;
function ElectronvoltMeterPerSpeedOfLightVerboseToString(const AValue: TQuantity): string;
function ElectronvoltMeterPerSpeedOfLightToFloat(const AValue: TQuantity): double;
function SquareJouleSquareSecondToString(const AValue: TQuantity): string;
function SquareJouleSquareSecondToVerboseString(const AValue: TQuantity): string;
function SquareJouleSquareSecondToFloat(const AValue: TQuantity): double;
function CoulombPerKilogramToString(const AValue: TQuantity): string;
function CoulombPerKilogramToVerboseString(const AValue: TQuantity): string;
function CoulombPerKilogramToFloat(const AValue: TQuantity): double;
function SquareMeterAmpereToString(const AValue: TQuantity): string;
function SquareMeterAmpereToVerboseString(const AValue: TQuantity): string;
function SquareMeterAmpereToFloat(const AValue: TQuantity): double;
function JoulePerTeslaToString(const AValue: TQuantity): string;
function JoulePerTeslaVerboseToString(const AValue: TQuantity): string;
function JoulePerTeslaToFloat(const AValue: TQuantity): double;
function LumenPerWattToString(const AValue: TQuantity): string;
function LumenPerWattToVerboseString(const AValue: TQuantity): string;
function LumenPerWattToFloat(const AValue: TQuantity): double;
function ReciprocalMoleToString(const AValue: TQuantity): string;
function ReciprocalMoleToVerboseString(const AValue: TQuantity): string;
function ReciprocalMoleToFloat(const AValue: TQuantity): double;
function AmperePerSquareMeterToString(const AValue: TQuantity): string;
function AmperePerSquareMeterToVerboseString(const AValue: TQuantity): string;
function AmperePerSquareMeterToFloat(const AValue: TQuantity): double;
function MolePerCubicMeterToString(const AValue: TQuantity): string;
function MolePerCubicMeterToVerboseString(const AValue: TQuantity): string;
function MolePerCubicMeterToFloat(const AValue: TQuantity): double;
function CandelaPerSquareMeterToString(const AValue: TQuantity): string;
function CandelaPerSquareMeterToVerboseString(const AValue: TQuantity): string;
function CandelaPerSquareMeterToFloat(const AValue: TQuantity): double;
function CoulombPerCubicMeterToString(const AValue: TQuantity): string;
function CoulombPerCubicMeterToVerboseString(const AValue: TQuantity): string;
function CoulombPerCubicMeterToFloat(const AValue: TQuantity): double;
function GrayPerSecondToString(const AValue: TQuantity): string;
function GrayPerSecondToVerboseString(const AValue: TQuantity): string;
function GrayPerSecondToFloat(const AValue: TQuantity): double;
function SteradianHertzToString(const AValue: TQuantity): string;
function SteradianHertzToVerboseString(const AValue: TQuantity): string;
function SteradianHertzToFloat(const AValue: TQuantity): double;
function MeterSteradianToString(const AValue: TQuantity): string;
function MeterSteradianToVerboseString(const AValue: TQuantity): string;
function MeterSteradianToFloat(const AValue: TQuantity): double;
function SquareMeterSteradianToString(const AValue: TQuantity): string;
function SquareMeterSteradianToVerboseString(const AValue: TQuantity): string;
function SquareMeterSteradianToFloat(const AValue: TQuantity): double;
function CubicMeterSteradianToString(const AValue: TQuantity): string;
function CubicMeterSteradianToVerboseString(const AValue: TQuantity): string;
function CubicMeterSteradianToFloat(const AValue: TQuantity): double;
function SquareMeterSteradianHertzToString(const AValue: TQuantity): string;
function SquareMeterSteradianHertzToVerboseString(const AValue: TQuantity): string;
function SquareMeterSteradianHertzToFloat(const AValue: TQuantity): double;
function WattPerSteradianToString(const AValue: TQuantity): string;
function WattPerSteradianToVerboseString(const AValue: TQuantity): string;
function WattPerSteradianToFloat(const AValue: TQuantity): double;
function WattPerSteradianPerHertzToString(const AValue: TQuantity): string;
function WattPerSteradianPerHertzToVerboseString(const AValue: TQuantity): string;
function WattPerSteradianPerHertzToFloat(const AValue: TQuantity): double;
function WattPerMeterPerSteradianToString(const AValue: TQuantity): string;
function WattPerMeterPerSteradianToVerboseString(const AValue: TQuantity): string;
function WattPerMeterPerSteradianToFloat(const AValue: TQuantity): double;
function WattPerSquareMeterPerSteradianToString(const AValue: TQuantity): string;
function WattPerSquareMeterPerSteradianToVerboseString(const AValue: TQuantity): string;
function WattPerSquareMeterPerSteradianToFloat(const AValue: TQuantity): double;
function WattPerCubicMeterPerSteradianToString(const AValue: TQuantity): string;
function WattPerCubicMeterPerSteradianToVerboseString(const AValue: TQuantity): string;
function WattPerCubicMeterPerSteradianToFloat(const AValue: TQuantity): double;
function WattPerSquareMeterPerSteradianPerHertzToString(const AValue: TQuantity): string;
function WattPerSquareMeterPerSteradianPerHertzToVerboseString(const AValue: TQuantity): string;
function WattPerSquareMeterPerSteradianPerHertzToFloat(const AValue: TQuantity): double;
function KatalPerCubicMeterToString(const AValue: TQuantity): string;
function KatalPerCubicMeterToVerboseString(const AValue: TQuantity): string;
function KatalPerCubicMeterToFloat(const AValue: TQuantity): double;
function CoulombPerMoleToString(const AValue: TQuantity): string;
function CoulombPerMoleToVerboseString(const AValue: TQuantity): string;
function CoulombPerMoleToFloat(const AValue: TQuantity): double;

{ Power functions }

implementation

const
  uScalar                                            = 0;
  uSecond                                            = 1;
  uSquareSecond                                      = 2;
  uCubicSecond                                       = 3;
  uQuarticSecond                                     = 4;
  uQuinticSecond                                     = 5;
  uSexticSecond                                      = 6;
  uMeter                                             = 7;
  uSquareRootMeter                                   = 8;
  uSquareMeter                                       = 9;
  uCubicMeter                                        = 10;
  uQuarticMeter                                      = 11;
  uQuinticMeter                                      = 12;
  uSexticMeter                                       = 13;
  uKilogram                                          = 14;
  uSquareKilogram                                    = 15;
  uAmpere                                            = 16;
  uSquareAmpere                                      = 17;
  uKelvin                                            = 18;
  uSquareKelvin                                      = 19;
  uCubicKelvin                                       = 20;
  uQuarticKelvin                                     = 21;
  uMole                                              = 22;
  uCandela                                           = 23;
  uRadian                                            = 24;
  uSteradian                                         = 25;
  uHertz                                             = 26;
  uSquareHertz                                       = 27;
  uSteradianPerSquareSecond                          = 28;
  uMeterPerSecond                                    = 29;
  uMeterPerSquareSecond                              = 30;
  uMeterPerCubicSecond                               = 31;
  uMeterPerQuarticSecond                             = 32;
  uMeterPerQuinticSecond                             = 33;
  uMeterPerSexticSecond                              = 34;
  uSquareMeterPerSquareSecond                        = 35;
  uMeterSecond                                       = 36;
  uKilogramMeter                                     = 37;
  uKilogramPerSecond                                 = 38;
  uKilogramMeterPerSecond                            = 39;
  uSquareKilogramSquareMeterPerSquareSecond          = 40;
  uReciprocalSquareRootMeter                         = 41;
  uReciprocalMeter                                   = 42;
  uReciprocalSquareRootCubicMeter                    = 43;
  uReciprocalSquareMeter                             = 44;
  uReciprocalCubicMeter                              = 45;
  uReciprocalQuarticMeter                            = 46;
  uKilogramSquareMeter                               = 47;
  uKilogramSquareMeterPerSecond                      = 48;
  uSecondPerMeter                                    = 49;
  uKilogramPerMeter                                  = 50;
  uKilogramPerSquareMeter                            = 51;
  uKilogramPerCubicMeter                             = 52;
  uNewton                                            = 53;
  uNewtonRadian                                      = 54;
  uSquareNewton                                      = 55;
  uPascal                                            = 56;
  uJoule                                             = 57;
  uJoulePerRadian                                    = 58;
  uWatt                                              = 59;
  uCoulomb                                           = 60;
  uSquareCoulomb                                     = 61;
  uCoulombMeter                                      = 62;
  uVolt                                              = 63;
  uSquareVolt                                        = 64;
  uFarad                                             = 65;
  uOhm                                               = 66;
  uSiemens                                           = 67;
  uSiemensPerMeter                                   = 68;
  uTesla                                             = 69;
  uWeber                                             = 70;
  uHenry                                             = 71;
  uReciprocalHenry                                   = 72;
  uLumen                                             = 73;
  uLumenSecond                                       = 74;
  uLumenSecondPerCubicMeter                          = 75;
  uLux                                               = 76;
  uLuxSecond                                         = 77;
  uKatal                                             = 78;
  uNewtonPerCubicMeter                               = 79;
  uNewtonPerMeter                                    = 80;
  uCubicMeterPerSecond                               = 81;
  uPoiseuille                                        = 82;
  uSquareMeterPerSecond                              = 83;
  uKilogramPerQuarticMeter                           = 84;
  uQuarticMeterSecond                                = 85;
  uKilogramPerQuarticMeterPerSecond                  = 86;
  uCubicMeterPerKilogram                             = 87;
  uKilogramSquareSecond                              = 88;
  uCubicMeterPerSquareSecond                         = 89;
  uNewtonSquareMeter                                 = 90;
  uNewtonCubicMeter                                  = 91;
  uNewtonPerSquareKilogram                           = 92;
  uSquareKilogramPerMeter                            = 93;
  uSquareKilogramPerSquareMeter                      = 94;
  uSquareMeterPerSquareKilogram                      = 95;
  uNewtonSquareMeterPerSquareKilogram                = 96;
  uReciprocalKelvin                                  = 97;
  uKilogramKelvin                                    = 98;
  uJoulePerKelvin                                    = 99;
  uJoulePerKilogramPerKelvin                         = 100;
  uMeterKelvin                                       = 101;
  uKelvinPerMeter                                    = 102;
  uWattPerMeter                                      = 103;
  uWattPerSquareMeter                                = 104;
  uWattPerCubicMeter                                 = 105;
  uWattPerKelvin                                     = 106;
  uWattPerMeterPerKelvin                             = 107;
  uKelvinPerWatt                                     = 108;
  uMeterPerWatt                                      = 109;
  uMeterKelvinPerWatt                                = 110;
  uSquareMeterKelvin                                 = 111;
  uWattPerSquareMeterPerKelvin                       = 112;
  uSquareMeterQuarticKelvin                          = 113;
  uWattPerQuarticKelvin                              = 114;
  uWattPerSquareMeterPerQuarticKelvin                = 115;
  uJoulePerMole                                      = 116;
  uMoleKelvin                                        = 117;
  uJoulePerMolePerKelvin                             = 118;
  uOhmMeter                                          = 119;
  uVoltPerMeter                                      = 120;
  uCoulombPerMeter                                   = 121;
  uSquareCoulombPerMeter                             = 122;
  uCoulombPerSquareMeter                             = 123;
  uSquareMeterPerSquareCoulomb                       = 124;
  uNewtonPerSquareCoulomb                            = 125;
  uNewtonSquareMeterPerSquareCoulomb                 = 126;
  uVoltMeter                                         = 127;
  uVoltMeterPerSecond                                = 128;
  uFaradPerMeter                                     = 129;
  uAmperePerMeter                                    = 130;
  uMeterPerAmpere                                    = 131;
  uTeslaMeter                                        = 132;
  uTeslaPerAmpere                                    = 133;
  uHenryPerMeter                                     = 134;
  uRadianPerMeter                                    = 135;
  uSquareKilogramPerSquareSecond                     = 136;
  uSquareSecondPerSquareMeter                        = 137;
  uSquareJoule                                       = 138;
  uSquareJouleSquareSecond                           = 139;
  uCoulombPerKilogram                                = 140;
  uSquareMeterAmpere                                 = 141;
  uLumenPerWatt                                      = 142;
  uReciprocalMole                                    = 143;
  uAmperePerSquareMeter                              = 144;
  uMolePerCubicMeter                                 = 145;
  uCandelaPerSquareMeter                             = 146;
  uCoulombPerCubicMeter                              = 147;
  uGrayPerSecond                                     = 148;
  uSteradianHertz                                    = 149;
  uMeterSteradian                                    = 150;
  uSquareMeterSteradian                              = 151;
  uCubicMeterSteradian                               = 152;
  uSquareMeterSteradianHertz                         = 153;
  uWattPerSteradian                                  = 154;
  uWattPerSteradianPerHertz                          = 155;
  uWattPerMeterPerSteradian                          = 156;
  uWattPerSquareMeterPerSteradian                    = 157;
  uWattPerCubicMeterPerSteradian                     = 158;
  uWattPerSquareMeterPerSteradianPerHertz            = 159;
  uKatalPerCubicMeter                                = 160;
  uCoulombPerMole                                    = 161;

{$IFOPT D+}
class operator TQuantity.+(const ALeft, ARight: TQuantity): TQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.-(const ALeft, ARight: TQuantity): TQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');
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

class operator TQuantity.Copy(constref ASrc: TQuantity; var ADst: TQuantity);
begin
  if ASrc.FUnitOfMeasurement <> ADst.FUnitOfMeasurement then
    raise Exception.Create('Assignment operator (:=) has detected wrong unit of measurements.');
  ADst.FValue := ASrc.FValue;
end;

class operator TQuantity.*(const ALeft: double; const ARight: TQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := ARight.FUnitOfMeasurement;
  result.FValue:= ALeft * ARight.FValue;
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
{$ENDIF}

{ Base units }

class operator TSecondUnit.*(const AValue: double; const ASelf: TSecondUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSecond;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSecondUnit.*(const AValue: TQuantity; const ASelf: TSecondUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSecond];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareSecondUnit.*(const AValue: double; const ASelf: TSquareSecondUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareSecond;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareSecondUnit.*(const AValue: TQuantity; const ASelf: TSquareSecondUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSquareSecond];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TCubicSecondUnit.*(const AValue: double; const ASelf: TCubicSecondUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uCubicSecond;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TCubicSecondUnit.*(const AValue: TQuantity; const ASelf: TCubicSecondUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uCubicSecond];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TQuarticSecondUnit.*(const AValue: double; const ASelf: TQuarticSecondUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uQuarticSecond;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TQuarticSecondUnit.*(const AValue: TQuantity; const ASelf: TQuarticSecondUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uQuarticSecond];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TQuinticSecondUnit.*(const AValue: double; const ASelf: TQuinticSecondUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uQuinticSecond;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TQuinticSecondUnit.*(const AValue: TQuantity; const ASelf: TQuinticSecondUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uQuinticSecond];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSexticSecondUnit.*(const AValue: double; const ASelf: TSexticSecondUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSexticSecond;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSexticSecondUnit.*(const AValue: TQuantity; const ASelf: TSexticSecondUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSexticSecond];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TMeterUnit.*(const AValue: double; const ASelf: TMeterUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uMeter;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TMeterUnit.*(const AValue: TQuantity; const ASelf: TMeterUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uMeter];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareMeterUnit.*(const AValue: double; const ASelf: TSquareMeterUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareMeter;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareMeterUnit.*(const AValue: TQuantity; const ASelf: TSquareMeterUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSquareMeter];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TCubicMeterUnit.*(const AValue: double; const ASelf: TCubicMeterUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uCubicMeter;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TCubicMeterUnit.*(const AValue: TQuantity; const ASelf: TCubicMeterUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uCubicMeter];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TQuarticMeterUnit.*(const AValue: double; const ASelf: TQuarticMeterUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uQuarticMeter;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TQuarticMeterUnit.*(const AValue: TQuantity; const ASelf: TQuarticMeterUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uQuarticMeter];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TQuinticMeterUnit.*(const AValue: double; const ASelf: TQuinticMeterUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uQuinticMeter;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TQuinticMeterUnit.*(const AValue: TQuantity; const ASelf: TQuinticMeterUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uQuinticMeter];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSexticMeterUnit.*(const AValue: double; const ASelf: TSexticMeterUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSexticMeter;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSexticMeterUnit.*(const AValue: TQuantity; const ASelf: TSexticMeterUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSexticMeter];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TKilogramUnit.*(const AValue: double; const ASelf: TKilogramUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uKilogram;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TKilogramUnit.*(const AValue: TQuantity; const ASelf: TKilogramUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uKilogram];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareKilogramUnit.*(const AValue: double; const ASelf: TSquareKilogramUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareKilogram;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareKilogramUnit.*(const AValue: TQuantity; const ASelf: TSquareKilogramUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSquareKilogram];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TAmpereUnit.*(const AValue: double; const ASelf: TAmpereUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uAmpere;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TAmpereUnit.*(const AValue: TQuantity; const ASelf: TAmpereUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uAmpere];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareAmpereUnit.*(const AValue: double; const ASelf: TSquareAmpereUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareAmpere;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareAmpereUnit.*(const AValue: TQuantity; const ASelf: TSquareAmpereUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSquareAmpere];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TKelvinUnit.*(const AValue: double; const ASelf: TKelvinUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uKelvin;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TKelvinUnit.*(const AValue: TQuantity; const ASelf: TKelvinUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uKelvin];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareKelvinUnit.*(const AValue: double; const ASelf: TSquareKelvinUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareKelvin;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareKelvinUnit.*(const AValue: TQuantity; const ASelf: TSquareKelvinUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSquareKelvin];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TCubicKelvinUnit.*(const AValue: double; const ASelf: TCubicKelvinUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uCubicKelvin;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TCubicKelvinUnit.*(const AValue: TQuantity; const ASelf: TCubicKelvinUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uCubicKelvin];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TQuarticKelvinUnit.*(const AValue: double; const ASelf: TQuarticKelvinUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uQuarticKelvin;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TQuarticKelvinUnit.*(const AValue: TQuantity; const ASelf: TQuarticKelvinUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uQuarticKelvin];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TMoleUnit.*(const AValue: double; const ASelf: TMoleUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uMole;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TMoleUnit.*(const AValue: TQuantity; const ASelf: TMoleUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uMole];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TCandelaUnit.*(const AValue: double; const ASelf: TCandelaUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uCandela;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TCandelaUnit.*(const AValue: TQuantity; const ASelf: TCandelaUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uCandela];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TRadianUnit.*(const AValue: double; const ASelf: TRadianUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uRadian;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TRadianUnit.*(const AValue: TQuantity; const ASelf: TRadianUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uRadian];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSteradianUnit.*(const AValue: double; const ASelf: TSteradianUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSteradian;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSteradianUnit.*(const AValue: TQuantity; const ASelf: TSteradianUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSteradian];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator THertzUnit.*(const AValue: double; const ASelf: THertzUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uHertz;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator THertzUnit.*(const AValue: TQuantity; const ASelf: THertzUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uHertz];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareHertzUnit.*(const AValue: double; const ASelf: TSquareHertzUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareHertz;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareHertzUnit.*(const AValue: TQuantity; const ASelf: TSquareHertzUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSquareHertz];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TNewtonUnit.*(const AValue: double; const ASelf: TNewtonUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uNewton;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TNewtonUnit.*(const AValue: TQuantity; const ASelf: TNewtonUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uNewton];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareNewtonUnit.*(const AValue: double; const ASelf: TSquareNewtonUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareNewton;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareNewtonUnit.*(const AValue: TQuantity; const ASelf: TSquareNewtonUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSquareNewton];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TPascalUnit.*(const AValue: double; const ASelf: TPascalUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uPascal;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TPascalUnit.*(const AValue: TQuantity; const ASelf: TPascalUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uPascal];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TJouleUnit.*(const AValue: double; const ASelf: TJouleUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uJoule;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TJouleUnit.*(const AValue: TQuantity; const ASelf: TJouleUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uJoule];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TWattUnit.*(const AValue: double; const ASelf: TWattUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uWatt;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TWattUnit.*(const AValue: TQuantity; const ASelf: TWattUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uWatt];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TCoulombUnit.*(const AValue: double; const ASelf: TCoulombUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uCoulomb;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TCoulombUnit.*(const AValue: TQuantity; const ASelf: TCoulombUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uCoulomb];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareCoulombUnit.*(const AValue: double; const ASelf: TSquareCoulombUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareCoulomb;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareCoulombUnit.*(const AValue: TQuantity; const ASelf: TSquareCoulombUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSquareCoulomb];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TVoltUnit.*(const AValue: double; const ASelf: TVoltUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uVolt;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TVoltUnit.*(const AValue: TQuantity; const ASelf: TVoltUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uVolt];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareVoltUnit.*(const AValue: double; const ASelf: TSquareVoltUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareVolt;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareVoltUnit.*(const AValue: TQuantity; const ASelf: TSquareVoltUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSquareVolt];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TFaradUnit.*(const AValue: double; const ASelf: TFaradUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uFarad;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TFaradUnit.*(const AValue: TQuantity; const ASelf: TFaradUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uFarad];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TOhmUnit.*(const AValue: double; const ASelf: TOhmUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uOhm;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TOhmUnit.*(const AValue: TQuantity; const ASelf: TOhmUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uOhm];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSiemensUnit.*(const AValue: double; const ASelf: TSiemensUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSiemens;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSiemensUnit.*(const AValue: TQuantity; const ASelf: TSiemensUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSiemens];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TTeslaUnit.*(const AValue: double; const ASelf: TTeslaUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uTesla;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TTeslaUnit.*(const AValue: TQuantity; const ASelf: TTeslaUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uTesla];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TWeberUnit.*(const AValue: double; const ASelf: TWeberUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uWeber;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TWeberUnit.*(const AValue: TQuantity; const ASelf: TWeberUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uWeber];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator THenryUnit.*(const AValue: double; const ASelf: THenryUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uHenry;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator THenryUnit.*(const AValue: TQuantity; const ASelf: THenryUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uHenry];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TLumenUnit.*(const AValue: double; const ASelf: TLumenUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uLumen;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TLumenUnit.*(const AValue: TQuantity; const ASelf: TLumenUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uLumen];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TLuxUnit.*(const AValue: double; const ASelf: TLuxUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uLux;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TLuxUnit.*(const AValue: TQuantity; const ASelf: TLuxUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uLux];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TKatalUnit.*(const AValue: double; const ASelf: TKatalUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uKatal;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TKatalUnit.*(const AValue: TQuantity; const ASelf: TKatalUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uKatal];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TPoiseuilleUnit.*(const AValue: double; const ASelf: TPoiseuilleUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uPoiseuille;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TPoiseuilleUnit.*(const AValue: TQuantity; const ASelf: TPoiseuilleUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uPoiseuille];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareJouleUnit.*(const AValue: double; const ASelf: TSquareJouleUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareJoule;
  result.FValue := AValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

class operator TSquareJouleUnit.*(const AValue: TQuantity; const ASelf: TSquareJouleUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, uSquareJoule];
  result.FValue := AValue.FValue
  {$ELSE}
  result := AValue
  {$ENDIF}
end;

{ Factored units }

class operator TDayUnit.*(const AValue: double; const ASelf: TDayUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSecond;
  result.FValue := AValue * 86400;
  {$ELSE}
  result := AValue * 86400;
  {$ENDIF}
end;

class operator THourUnit.*(const AValue: double; const ASelf: THourUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSecond;
  result.FValue := AValue * 3600;
  {$ELSE}
  result := AValue * 3600;
  {$ENDIF}
end;

class operator TMinuteUnit.*(const AValue: double; const ASelf: TMinuteUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSecond;
  result.FValue := AValue * 60;
  {$ELSE}
  result := AValue * 60;
  {$ENDIF}
end;

class operator TSquareDayUnit.*(const AValue: double; const ASelf: TSquareDayUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareSecond;
  result.FValue := AValue * 7464960000;
  {$ELSE}
  result := AValue * 7464960000;
  {$ENDIF}
end;

class operator TSquareHourUnit.*(const AValue: double; const ASelf: TSquareHourUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareSecond;
  result.FValue := AValue * 12960000;
  {$ELSE}
  result := AValue * 12960000;
  {$ENDIF}
end;

class operator TSquareMinuteUnit.*(const AValue: double; const ASelf: TSquareMinuteUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareSecond;
  result.FValue := AValue * 3600;
  {$ELSE}
  result := AValue * 3600;
  {$ENDIF}
end;

class operator TAstronomicalUnit.*(const AValue: double; const ASelf: TAstronomicalUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uMeter;
  result.FValue := AValue * 149597870691;
  {$ELSE}
  result := AValue * 149597870691;
  {$ENDIF}
end;

class operator TInchUnit.*(const AValue: double; const ASelf: TInchUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uMeter;
  result.FValue := AValue * 0.0254;
  {$ELSE}
  result := AValue * 0.0254;
  {$ENDIF}
end;

class operator TFootUnit.*(const AValue: double; const ASelf: TFootUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uMeter;
  result.FValue := AValue * 0.3048;
  {$ELSE}
  result := AValue * 0.3048;
  {$ENDIF}
end;

class operator TYardUnit.*(const AValue: double; const ASelf: TYardUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uMeter;
  result.FValue := AValue * 0.9144;
  {$ELSE}
  result := AValue * 0.9144;
  {$ENDIF}
end;

class operator TMileUnit.*(const AValue: double; const ASelf: TMileUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uMeter;
  result.FValue := AValue * 1609.344;
  {$ELSE}
  result := AValue * 1609.344;
  {$ENDIF}
end;

class operator TNauticalMileUnit.*(const AValue: double; const ASelf: TNauticalMileUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uMeter;
  result.FValue := AValue * 1852;
  {$ELSE}
  result := AValue * 1852;
  {$ENDIF}
end;

class operator TAngstromUnit.*(const AValue: double; const ASelf: TAngstromUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uMeter;
  result.FValue := AValue * 1E-10;
  {$ELSE}
  result := AValue * 1E-10;
  {$ENDIF}
end;

class operator TSquareInchUnit.*(const AValue: double; const ASelf: TSquareInchUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareMeter;
  result.FValue := AValue * 0.00064516;
  {$ELSE}
  result := AValue * 0.00064516;
  {$ENDIF}
end;

class operator TSquareFootUnit.*(const AValue: double; const ASelf: TSquareFootUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareMeter;
  result.FValue := AValue * 0.09290304;
  {$ELSE}
  result := AValue * 0.09290304;
  {$ENDIF}
end;

class operator TSquareYardUnit.*(const AValue: double; const ASelf: TSquareYardUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareMeter;
  result.FValue := AValue * 0.83612736;
  {$ELSE}
  result := AValue * 0.83612736;
  {$ENDIF}
end;

class operator TSquareMileUnit.*(const AValue: double; const ASelf: TSquareMileUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareMeter;
  result.FValue := AValue * 2589988.110336;
  {$ELSE}
  result := AValue * 2589988.110336;
  {$ENDIF}
end;

class operator TCubicInchUnit.*(const AValue: double; const ASelf: TCubicInchUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uCubicMeter;
  result.FValue := AValue * 0.000016387064;
  {$ELSE}
  result := AValue * 0.000016387064;
  {$ENDIF}
end;

class operator TCubicFootUnit.*(const AValue: double; const ASelf: TCubicFootUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uCubicMeter;
  result.FValue := AValue * 0.028316846592;
  {$ELSE}
  result := AValue * 0.028316846592;
  {$ENDIF}
end;

class operator TCubicYardUnit.*(const AValue: double; const ASelf: TCubicYardUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uCubicMeter;
  result.FValue := AValue * 0.764554857984;
  {$ELSE}
  result := AValue * 0.764554857984;
  {$ENDIF}
end;

class operator TLitreUnit.*(const AValue: double; const ASelf: TLitreUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uCubicMeter;
  result.FValue := AValue * 1E-03;
  {$ELSE}
  result := AValue * 1E-03;
  {$ENDIF}
end;

class operator TGallonUnit.*(const AValue: double; const ASelf: TGallonUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uCubicMeter;
  result.FValue := AValue * 0.0037854119678;
  {$ELSE}
  result := AValue * 0.0037854119678;
  {$ENDIF}
end;

class operator TTonneUnit.*(const AValue: double; const ASelf: TTonneUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uKilogram;
  result.FValue := AValue * 1E+03;
  {$ELSE}
  result := AValue * 1E+03;
  {$ENDIF}
end;

class operator TPoundUnit.*(const AValue: double; const ASelf: TPoundUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uKilogram;
  result.FValue := AValue * 0.45359237;
  {$ELSE}
  result := AValue * 0.45359237;
  {$ENDIF}
end;

class operator TOunceUnit.*(const AValue: double; const ASelf: TOunceUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uKilogram;
  result.FValue := AValue * 0.028349523125;
  {$ELSE}
  result := AValue * 0.028349523125;
  {$ENDIF}
end;

class operator TStoneUnit.*(const AValue: double; const ASelf: TStoneUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uKilogram;
  result.FValue := AValue * 6.35029318;
  {$ELSE}
  result := AValue * 6.35029318;
  {$ENDIF}
end;

class operator TTonUnit.*(const AValue: double; const ASelf: TTonUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uKilogram;
  result.FValue := AValue * 907.18474;
  {$ELSE}
  result := AValue * 907.18474;
  {$ENDIF}
end;

class operator TDegreeCelsiusUnit.*(const AValue: double; const ASelf: TDegreeCelsiusUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uKelvin;
  result.FValue := AValue + 273.15;
  {$ELSE}
  result := AValue + 273.15;
  {$ENDIF}
end;

class operator TDegreeFahrenheitUnit.*(const AValue: double; const ASelf: TDegreeFahrenheitUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uKelvin;
  result.FValue := 5/9 * (AValue - 32) + 273.15;
  {$ELSE}
  result := 5/9 * (AValue - 32) + 273.15;
  {$ENDIF}
end;

class operator TDegreeUnit.*(const AValue: double; const ASelf: TDegreeUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uRadian;
  result.FValue := AValue * Pi/180;
  {$ELSE}
  result := AValue * Pi/180;
  {$ENDIF}
end;

class operator TSquareDegreeUnit.*(const AValue: double; const ASelf: TSquareDegreeUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSteradian;
  result.FValue := AValue * Pi*Pi/32400;
  {$ELSE}
  result := AValue * Pi*Pi/32400;
  {$ENDIF}
end;

class operator TGrayUnit.*(const AValue: double; const ASelf: TGrayUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareMeterPerSquareSecond;
  result.FValue := AValue;
  {$ELSE}
  result := AValue;
  {$ENDIF}
end;

class operator TSievertUnit.*(const AValue: double; const ASelf: TSievertUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareMeterPerSquareSecond;
  result.FValue := AValue;
  {$ELSE}
  result := AValue;
  {$ENDIF}
end;

class operator TPoundForceUnit.*(const AValue: double; const ASelf: TPoundForceUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uNewton;
  result.FValue := AValue * 4.4482216152605;
  {$ELSE}
  result := AValue * 4.4482216152605;
  {$ENDIF}
end;

class operator TBarUnit.*(const AValue: double; const ASelf: TBarUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uPascal;
  result.FValue := AValue * 1E+05;
  {$ELSE}
  result := AValue * 1E+05;
  {$ENDIF}
end;

class operator TPoundPerSquareInchUnit.*(const AValue: double; const ASelf: TPoundPerSquareInchUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uPascal;
  result.FValue := AValue * 6894.75729316836;
  {$ELSE}
  result := AValue * 6894.75729316836;
  {$ENDIF}
end;

class operator TElectronvoltUnit.*(const AValue: double; const ASelf: TElectronvoltUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uJoule;
  result.FValue := AValue * 1.602176634E-019;
  {$ELSE}
  result := AValue * 1.602176634E-019;
  {$ENDIF}
end;

class operator TRydbergUnit.*(const AValue: double; const ASelf: TRydbergUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uJoule;
  result.FValue := AValue * 2.1798723611035E-18;
  {$ELSE}
  result := AValue * 2.1798723611035E-18;
  {$ENDIF}
end;

class operator TCalorieUnit.*(const AValue: double; const ASelf: TCalorieUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uJoule;
  result.FValue := AValue * 4.184;
  {$ELSE}
  result := AValue * 4.184;
  {$ENDIF}
end;

class operator TBequerelUnit.*(const AValue: double; const ASelf: TBequerelUnit): TQuantity; inline;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uHertz;
  result.FValue := AValue;
  {$ELSE}
  result := AValue;
  {$ENDIF}
end;

{ TUnit classes }

function SecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function DayToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function DayVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function DayToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function HourToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function HourVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function HourToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MinuteToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MinuteVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MinuteToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareDayToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareDayVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareDayToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareHourToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareHourVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareHourToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareMinuteToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareMinuteVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareMinuteToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CubicSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CubicSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CubicSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function QuarticSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuarticSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function QuarticSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuarticSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function QuarticSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuarticSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function QuinticSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuinticSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function QuinticSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuinticSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function QuinticSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuinticSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SexticSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSexticSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SexticSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSexticSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SexticSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSexticSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function AstronomicalToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function AstronomicalVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function AstronomicalToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function InchToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function InchVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function InchToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function FootToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function FootVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function FootToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function YardToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function YardVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function YardToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MileToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MileVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MileToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NauticalMileToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NauticalMileVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NauticalMileToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function AngstromToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function AngstromVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function AngstromToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareRootMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareRootMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareRootMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareRootMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareRootMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareRootMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareInchToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareInchVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareInchToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareFootToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareFootVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareFootToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareYardToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareYardVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareYardToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareMileToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareMileVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareMileToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CubicMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CubicMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CubicMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CubicInchToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CubicInchVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CubicInchToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CubicFootToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CubicFootVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CubicFootToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CubicYardToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CubicYardVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CubicYardToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function LitreToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function LitreVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function LitreToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function GallonToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function GallonVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function GallonToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function QuarticMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuarticMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function QuarticMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuarticMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function QuarticMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuarticMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function QuinticMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuinticMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function QuinticMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuinticMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function QuinticMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuinticMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SexticMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSexticMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SexticMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSexticMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SexticMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSexticMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function TonneToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function TonneVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function TonneToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function PoundToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PoundVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PoundToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function OunceToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function OunceVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function OunceToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function StoneToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function StoneVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function StoneToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function TonToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function TonVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function TonToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ElectronvoltPerSquareSpeedOfLightToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function ElectronvoltPerSquareSpeedOfLightVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function ElectronvoltPerSquareSpeedOfLightToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareKilogramToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogram then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareKilogramToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogram then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareKilogramToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function AmpereToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uAmpere then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function AmpereToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uAmpere then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function AmpereToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uAmpere then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareAmpereToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareAmpere then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareAmpereToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareAmpere then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareAmpereToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareAmpere then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function DegreeCelsiusToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function DegreeCelsiusVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function DegreeCelsiusToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function DegreeFahrenheitToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function DegreeFahrenheitVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function DegreeFahrenheitToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CubicKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CubicKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CubicKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function QuarticKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuarticKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function QuarticKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuarticKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function QuarticKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuarticKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MoleToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMole then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MoleToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMole then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MoleToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMole then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CandelaToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCandela then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CandelaToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCandela then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CandelaToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCandela then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function RadianToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uRadian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function RadianToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uRadian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function RadianToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function DegreeToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function DegreeVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function DegreeToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SteradianToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SteradianToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SteradianToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSteradian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareDegreeToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSteradian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareDegreeVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSteradian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareDegreeToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSteradian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function HertzToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHertz then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function HertzToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHertz then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function HertzToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ReciprocalSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function ReciprocalSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function ReciprocalSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function RadianPerSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function RadianPerSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function RadianPerSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareHertzToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareHertz then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareHertzToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareHertz then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareHertzToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ReciprocalSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function ReciprocalSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function ReciprocalSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function RadianPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function RadianPerSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function RadianPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SteradianPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSteradianPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SteradianPerSquareSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSteradianPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SteradianPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSteradianPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterPerSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterPerHourToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MeterPerHourVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MeterPerHourToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MilePerHourToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MilePerHourVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MilePerHourToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NauticalMilePerHourToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NauticalMilePerHourVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NauticalMilePerHourToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerSquareSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterPerSecondPerSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MeterPerSecondPerSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MeterPerSecondPerSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterPerHourPerSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MeterPerHourPerSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MeterPerHourPerSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterPerCubicSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerCubicSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerCubicSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerCubicSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerCubicSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerCubicSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterPerQuarticSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerQuarticSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerQuarticSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerQuarticSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerQuarticSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerQuarticSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterPerQuinticSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerQuinticSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerQuinticSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerQuinticSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerQuinticSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerQuinticSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterPerSexticSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSexticSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerSexticSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSexticSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerSexticSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerSexticSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareMeterPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterPerSquareSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JoulePerKilogramToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerKilogramVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerKilogramToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function GrayToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function GrayVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function GrayToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SievertToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SievertVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SievertToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramPerSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramPerSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramPerSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JoulePerSquareMeterPerHertzToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerSquareMeterPerHertzVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerSquareMeterPerHertzToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramMeterPerSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramMeterPerSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramMeterPerSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareKilogramSquareMeterPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogramSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareKilogramSquareMeterPerSquareSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogramSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareKilogramSquareMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogramSquareMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ReciprocalSquareRootMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalSquareRootMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalSquareRootMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalSquareRootMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalSquareRootMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalSquareRootMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ReciprocalMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function DioptreToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function DioptreVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function DioptreToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ReciprocalSquareRootCubicMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalSquareRootCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalSquareRootCubicMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalSquareRootCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalSquareRootCubicMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalSquareRootCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ReciprocalSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalSquareMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ReciprocalCubicMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalCubicMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalCubicMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ReciprocalQuarticMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalQuarticMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalQuarticMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalQuarticMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalQuarticMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalQuarticMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramSquareMeterPerSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonMeterSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonMeterSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonMeterSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SecondPerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecondPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SecondPerMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecondPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SecondPerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSecondPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramPerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramPerMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramPerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramPerSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramPerSquareMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramPerSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramPerCubicMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramPerCubicMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramPerCubicMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function PoundPerCubicInchToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PoundPerCubicInchVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PoundPerCubicInchToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewton then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewton then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewton then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function PoundForceToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewton then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PoundForceVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewton then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PoundForceToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewton then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramMeterPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewton then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramMeterPerSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewton then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewton then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonRadianToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonRadian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonRadianToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonRadian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonRadianToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareNewtonToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareNewton then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareNewtonToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareNewton then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareNewtonToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareNewton then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareKilogramSquareMeterPerQuarticSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareNewton then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareKilogramSquareMeterPerQuarticSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareNewton then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareKilogramSquareMeterPerQuarticSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareNewton then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function PascalToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function PascalToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function PascalToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonPerSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonPerSquareMeterVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonPerSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function BarToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function BarVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function BarToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function PoundPerSquareInchToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PoundPerSquareInchVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PoundPerSquareInchToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JoulePerCubicMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerCubicMeterVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerCubicMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramPerMeterPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramPerMeterPerSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramPerMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPascal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JouleToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function JouleToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function JouleToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattHourToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function WattHourVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function WattHourToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function WattSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function WattSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerHertzToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function WattPerHertzVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function WattPerHertzToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ElectronvoltToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function ElectronvoltVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function ElectronvoltToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonMeterVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function PoundForceInchToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PoundForceInchVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PoundForceInchToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function RydbergToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function RydbergVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function RydbergToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CalorieToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CalorieVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CalorieToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramSquareMeterPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JoulePerRadianToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function JoulePerRadianToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function JoulePerRadianToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JoulePerDegreeToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerDegreeVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerDegreeToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonMeterPerRadianToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonMeterPerRadianVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonMeterPerRadianToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonMeterPerDegreeToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonMeterPerDegreeVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonMeterPerDegreeToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramSquareMeterPerSquareSecondPerRadianToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerSquareSecondPerRadianVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerSquareSecondPerRadianToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerRadian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWatt then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWatt then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWatt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramSquareMeterPerCubicSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWatt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerCubicSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWatt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerCubicSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWatt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CoulombToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulomb then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CoulombToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulomb then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CoulombToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulomb then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function AmpereHourToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulomb then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function AmpereHourVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulomb then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function AmpereHourToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulomb then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function AmpereSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulomb then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function AmpereSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulomb then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function AmpereSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulomb then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareCoulombToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareCoulombToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareCoulombToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareAmpereSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareAmpereSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareAmpereSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CoulombMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CoulombMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CoulombMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function VoltToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVolt then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function VoltToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVolt then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function VoltToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVolt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JoulePerCoulombToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVolt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerCoulombVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVolt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerCoulombToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVolt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramSquareMeterPerAmperePerCubicSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVolt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerAmperePerCubicSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVolt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerAmperePerCubicSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVolt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareVoltToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareVolt then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareVoltToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareVolt then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareVoltToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareVolt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareKilogramQuarticMeterPerSquareAmperePerSexticSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareVolt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareKilogramQuarticMeterPerSquareAmperePerSexticSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareVolt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareKilogramQuarticMeterPerSquareAmperePerSexticSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareVolt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function FaradToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uFarad then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function FaradToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uFarad then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function FaradToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uFarad then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CoulombPerVoltToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uFarad then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CoulombPerVoltVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uFarad then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CoulombPerVoltToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uFarad then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareAmpereQuarticSecondPerKilogramPerSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uFarad then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareAmpereQuarticSecondPerKilogramPerSquareMeterVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uFarad then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareAmpereQuarticSecondPerKilogramPerSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uFarad then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function OhmToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uOhm then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function OhmToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uOhm then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function OhmToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uOhm then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramSquareMeterPerSquareAmperePerCubicSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uOhm then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerSquareAmperePerCubicSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uOhm then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerSquareAmperePerCubicSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uOhm then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SiemensToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSiemens then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SiemensToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSiemens then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SiemensToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSiemens then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareAmpereCubicSecondPerKilogramPerSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSiemens then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareAmpereCubicSecondPerKilogramPerSquareMeterVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSiemens then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareAmpereCubicSecondPerKilogramPerSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSiemens then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SiemensPerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSiemensPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SiemensPerMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSiemensPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SiemensPerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSiemensPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function TeslaToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTesla then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function TeslaToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTesla then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function TeslaToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTesla then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WeberPerSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTesla then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function WeberPerSquareMeterVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTesla then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function WeberPerSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTesla then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramPerAmperePerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTesla then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramPerAmperePerSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTesla then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramPerAmperePerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTesla then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WeberToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWeber then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WeberToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWeber then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WeberToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWeber then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramSquareMeterPerAmperePerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWeber then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerAmperePerSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWeber then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerAmperePerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWeber then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function HenryToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenry then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function HenryToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenry then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function HenryToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenry then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramSquareMeterPerSquareAmperePerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenry then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerSquareAmperePerSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenry then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerSquareAmperePerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenry then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ReciprocalHenryToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalHenry then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalHenryToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalHenry then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalHenryToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalHenry then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function LumenToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumen then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function LumenToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumen then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function LumenToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumen then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CandelaSteradianToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumen then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CandelaSteradianVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumen then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CandelaSteradianToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumen then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function LumenSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumenSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function LumenSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumenSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function LumenSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumenSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function LumenSecondPerCubicMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumenSecondPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function LumenSecondPerCubicMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumenSecondPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function LumenSecondPerCubicMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumenSecondPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function LuxToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLux then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function LuxToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLux then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function LuxToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLux then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CandelaSteradianPerSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLux then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CandelaSteradianPerSquareMeterVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLux then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CandelaSteradianPerSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLux then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function LuxSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLuxSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function LuxSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLuxSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function LuxSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLuxSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function BequerelToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function BequerelVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function BequerelToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KatalToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKatal then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KatalToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKatal then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KatalToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKatal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MolePerSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKatal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MolePerSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKatal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MolePerSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKatal then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonPerCubicMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonPerCubicMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonPerCubicMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function PascalPerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PascalPerMeterVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PascalPerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramPerSquareMeterPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramPerSquareMeterPerSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramPerSquareMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonPerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonPerMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonPerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JoulePerSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerSquareMeterVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerSquareMeterPerHertzToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function WattPerSquareMeterPerHertzVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function WattPerSquareMeterPerHertzToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function PoundForcePerInchToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PoundForcePerInchVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PoundForcePerInchToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramPerSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CubicMeterPerSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CubicMeterPerSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CubicMeterPerSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function PoiseuilleToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPoiseuille then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function PoiseuilleToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPoiseuille then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function PoiseuilleToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPoiseuille then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function PascalSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPoiseuille then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PascalSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPoiseuille then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function PascalSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPoiseuille then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramPerMeterPerSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPoiseuille then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramPerMeterPerSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPoiseuille then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramPerMeterPerSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uPoiseuille then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareMeterPerSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterPerSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterPerSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramPerQuarticMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerQuarticMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramPerQuarticMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerQuarticMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramPerQuarticMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerQuarticMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function QuarticMeterSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuarticMeterSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function QuarticMeterSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuarticMeterSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function QuarticMeterSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uQuarticMeterSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramPerQuarticMeterPerSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerQuarticMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramPerQuarticMeterPerSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerQuarticMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramPerQuarticMeterPerSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramPerQuarticMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CubicMeterPerKilogramToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeterPerKilogram then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CubicMeterPerKilogramToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeterPerKilogram then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CubicMeterPerKilogramToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeterPerKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramSquareSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CubicMeterPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CubicMeterPerSquareSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CubicMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeterPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonSquareMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramCubicMeterPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramCubicMeterPerSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramCubicMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonCubicMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonCubicMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonCubicMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramQuarticMeterPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramQuarticMeterPerSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramQuarticMeterPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonPerSquareKilogramToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonPerSquareKilogramToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonPerSquareKilogramToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterPerKilogramPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MeterPerKilogramPerSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function MeterPerKilogramPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareKilogramPerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogramPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareKilogramPerMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogramPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareKilogramPerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogramPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareKilogramPerSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogramPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareKilogramPerSquareMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogramPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareKilogramPerSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogramPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareMeterPerSquareKilogramToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterPerSquareKilogramToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterPerSquareKilogramToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonSquareMeterPerSquareKilogramToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeterPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonSquareMeterPerSquareKilogramToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeterPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonSquareMeterPerSquareKilogramToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeterPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CubicMeterPerKilogramPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeterPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CubicMeterPerKilogramPerSquareSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeterPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function CubicMeterPerKilogramPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeterPerSquareKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ReciprocalKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KilogramKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JoulePerKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function JoulePerKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function JoulePerKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramSquareMeterPerSquareSecondPerKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerSquareSecondPerKelvinVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerSquareSecondPerKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JoulePerKilogramPerKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerKilogramPerKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function JoulePerKilogramPerKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerKilogramPerKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function JoulePerKilogramPerKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerKilogramPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareMeterPerSquareSecondPerKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerKilogramPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareMeterPerSquareSecondPerKelvinVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerKilogramPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function SquareMeterPerSquareSecondPerKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerKilogramPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KelvinPerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvinPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KelvinPerMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvinPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KelvinPerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvinPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramMeterPerCubicSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramMeterPerCubicSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramMeterPerCubicSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerSquareMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramPerCubicSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramPerCubicSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramPerCubicSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerCubicMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerCubicMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerCubicMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramSquareMeterPerCubicSecondPerKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerCubicSecondPerKelvinVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramSquareMeterPerCubicSecondPerKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerMeterPerKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeterPerKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerMeterPerKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeterPerKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerMeterPerKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeterPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramMeterPerCubicSecondPerKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeterPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramMeterPerCubicSecondPerKelvinVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeterPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramMeterPerCubicSecondPerKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeterPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KelvinPerWattToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvinPerWatt then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KelvinPerWattToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvinPerWatt then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KelvinPerWattToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKelvinPerWatt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterPerWattToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerWatt then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerWattToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerWatt then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerWattToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerWatt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterKelvinPerWattToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterKelvinPerWatt then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterKelvinPerWattToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterKelvinPerWatt then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterKelvinPerWattToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterKelvinPerWatt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareMeterKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerSquareMeterPerKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerSquareMeterPerKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerSquareMeterPerKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KilogramPerCubicSecondPerKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramPerCubicSecondPerKelvinVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function KilogramPerCubicSecondPerKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareMeterQuarticKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterQuarticKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterQuarticKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterQuarticKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterQuarticKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterQuarticKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerQuarticKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerQuarticKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerQuarticKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerQuarticKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerQuarticKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerQuarticKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerSquareMeterPerQuarticKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerQuarticKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerSquareMeterPerQuarticKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerQuarticKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerSquareMeterPerQuarticKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerQuarticKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JoulePerMoleToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerMole then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function JoulePerMoleToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerMole then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function JoulePerMoleToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerMole then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MoleKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMoleKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MoleKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMoleKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MoleKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMoleKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JoulePerMolePerKelvinToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerMolePerKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function JoulePerMolePerKelvinToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerMolePerKelvin then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function JoulePerMolePerKelvinToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uJoulePerMolePerKelvin then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function OhmMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uOhmMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function OhmMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uOhmMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function OhmMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uOhmMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function VoltPerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function VoltPerMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function VoltPerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonPerCoulombToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonPerCoulombVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonPerCoulombToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CoulombPerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CoulombPerMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CoulombPerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareCoulombPerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareCoulombPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareCoulombPerMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareCoulombPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareCoulombPerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareCoulombPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CoulombPerSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CoulombPerSquareMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CoulombPerSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareMeterPerSquareCoulombToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterPerSquareCoulombToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterPerSquareCoulombToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterPerSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonPerSquareCoulombToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonPerSquareCoulombToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonPerSquareCoulombToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonPerSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonSquareMeterPerSquareCoulombToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeterPerSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonSquareMeterPerSquareCoulombToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeterPerSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function NewtonSquareMeterPerSquareCoulombToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uNewtonSquareMeterPerSquareCoulomb then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function VoltMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function VoltMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function VoltMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonSquareMeterPerCoulombToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonSquareMeterPerCoulombVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonSquareMeterPerCoulombToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function VoltMeterPerSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function VoltMeterPerSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function VoltMeterPerSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uVoltMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function FaradPerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uFaradPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function FaradPerMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uFaradPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function FaradPerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uFaradPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function AmperePerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uAmperePerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function AmperePerMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uAmperePerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function AmperePerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uAmperePerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterPerAmpereToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerAmpere then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerAmpereToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerAmpere then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterPerAmpereToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterPerAmpere then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function TeslaMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTeslaMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function TeslaMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTeslaMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function TeslaMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTeslaMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonPerAmpereToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTeslaMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonPerAmpereVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTeslaMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonPerAmpereToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTeslaMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function TeslaPerAmpereToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTeslaPerAmpere then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function TeslaPerAmpereToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTeslaPerAmpere then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function TeslaPerAmpereToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uTeslaPerAmpere then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function HenryPerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenryPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function HenryPerMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenryPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function HenryPerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenryPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function TeslaMeterPerAmpereToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenryPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function TeslaMeterPerAmpereVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenryPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function TeslaMeterPerAmpereToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenryPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function NewtonPerSquareAmpereToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenryPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonPerSquareAmpereVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenryPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function NewtonPerSquareAmpereToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uHenryPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function RadianPerMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uRadianPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function RadianPerMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uRadianPerMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function RadianPerMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uRadianPerMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareKilogramPerSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogramPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareKilogramPerSquareSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogramPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareKilogramPerSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareKilogramPerSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareSecondPerSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecondPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareSecondPerSquareMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecondPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareSecondPerSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareSecondPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareJouleToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareJoule then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareJouleToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareJoule then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareJouleToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareJoule then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JouleSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JouleSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JouleSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JoulePerHertzToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerHertzVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerHertzToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ElectronvoltSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function ElectronvoltSecondVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function ElectronvoltSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ElectronvoltMeterPerSpeedOfLightToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function ElectronvoltMeterPerSpeedOfLightVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function ElectronvoltMeterPerSpeedOfLightToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKilogramSquareMeterPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareJouleSquareSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareJouleSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareJouleSquareSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareJouleSquareSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareJouleSquareSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareJouleSquareSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CoulombPerKilogramToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerKilogram then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CoulombPerKilogramToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerKilogram then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CoulombPerKilogramToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerKilogram then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareMeterAmpereToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterAmpere then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterAmpereToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterAmpere then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterAmpereToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterAmpere then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function JoulePerTeslaToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterAmpere then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerTeslaVerboseToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterAmpere then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := ';
end;

function JoulePerTeslaToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterAmpere then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function LumenPerWattToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumenPerWatt then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function LumenPerWattToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumenPerWatt then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function LumenPerWattToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uLumenPerWatt then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function ReciprocalMoleToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalMole then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalMoleToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalMole then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function ReciprocalMoleToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uReciprocalMole then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function AmperePerSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uAmperePerSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function AmperePerSquareMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uAmperePerSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function AmperePerSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uAmperePerSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MolePerCubicMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMolePerCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MolePerCubicMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMolePerCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MolePerCubicMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMolePerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CandelaPerSquareMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCandelaPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CandelaPerSquareMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCandelaPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CandelaPerSquareMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCandelaPerSquareMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CoulombPerCubicMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CoulombPerCubicMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CoulombPerCubicMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function GrayPerSecondToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uGrayPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function GrayPerSecondToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uGrayPerSecond then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function GrayPerSecondToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uGrayPerSecond then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SteradianHertzToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSteradianHertz then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SteradianHertzToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSteradianHertz then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SteradianHertzToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSteradianHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function MeterSteradianToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterSteradianToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function MeterSteradianToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uMeterSteradian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareMeterSteradianToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterSteradianToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterSteradianToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterSteradian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CubicMeterSteradianToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeterSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CubicMeterSteradianToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeterSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CubicMeterSteradianToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCubicMeterSteradian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function SquareMeterSteradianHertzToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterSteradianHertz then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterSteradianHertzToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterSteradianHertz then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function SquareMeterSteradianHertzToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uSquareMeterSteradianHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerSteradianToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerSteradianToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerSteradianToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSteradian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerSteradianPerHertzToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSteradianPerHertz then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerSteradianPerHertzToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSteradianPerHertz then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerSteradianPerHertzToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSteradianPerHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerMeterPerSteradianToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeterPerSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerMeterPerSteradianToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeterPerSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerMeterPerSteradianToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerMeterPerSteradian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerSquareMeterPerSteradianToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerSquareMeterPerSteradianToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerSquareMeterPerSteradianToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerSteradian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerCubicMeterPerSteradianToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerCubicMeterPerSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerCubicMeterPerSteradianToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerCubicMeterPerSteradian then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerCubicMeterPerSteradianToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerCubicMeterPerSteradian then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function WattPerSquareMeterPerSteradianPerHertzToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerSteradianPerHertz then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerSquareMeterPerSteradianPerHertzToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerSteradianPerHertz then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function WattPerSquareMeterPerSteradianPerHertzToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uWattPerSquareMeterPerSteradianPerHertz then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function KatalPerCubicMeterToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKatalPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KatalPerCubicMeterToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKatalPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function KatalPerCubicMeterToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uKatalPerCubicMeter then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

function CoulombPerMoleToString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerMole then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CoulombPerMoleToVerboseString(const AValue: TQuantity): string;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerMole then;
    raise Exception.Create(Wrong units of measurements);
  {$ENDIF}
  result := ';
end;

function CoulombPerMoleToFloat(const AValue: TQuantity): double;
begin
  {$IFOPT D+}
  if.FUnitOfMeasurement <> uCoulombPerMole then;
    raise Exception.Create(Wrong units of measurements
  {$ENDIF}
  result := 0;
end;

{ Helpers }

{ Power functions }

end.
