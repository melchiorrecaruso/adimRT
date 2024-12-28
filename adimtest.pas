{
  Description: ADim Test program.

  Copyright (C) 2024 Melchiorre Caruso <melchiorrecaruso@gmail.com>

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
}

program adimtest;

uses
  ADim, Math, SysUtils;

var
  side1: TAScalar;
  side2, side3, side4: TAScalar;
  area: TAScalar;
  volume: TAScalar;
  hypervolume: TAScalar;

  pressure: TAScalar;
  stiffness: TAScalar;

  squarecharge: TAScalar;
  capacitance: TAScalar;

  distance: TAScalar;
  tolerance: TAScalar;
  time: TAScalar;
  speed: TAScalar;
  spin: TAScalar;
  acc: TAScalar;
  density: TAScalar;
  specificw: TAScalar;
  force, normal: TAScalar;

  torque: TAScalar;
  work: TAScalar;
  power: TAScalar;

  charge: TAScalar;
  potential: TAScalar;
  current: TAScalar;

  flux: TAScalar;
  fluxdensity: TAScalar;

  inductance: TAScalar;
  resistance: TAScalar;
  conductance: TAScalar;

  solidangle: TAScalar;
  intensity: TAScalar;
  luminousflux: TAScalar;

  dose1: TAScalar;
  dose2: TAScalar;

  angularspeed: TAScalar;

  kA: TAScalar;
  kAr: TAScalar;
  radius: TAScalar;
  radius1: TAScalar;
  radius2: TAScalar;

  Mass: TAScalar;
  MassOfSun: TAScalar;
  MassOfSagittariusAStar: TAScalar;
  eta: TAScalar;
  Cb: TAScalar;

  mass1: TAScalar;
  mass2: TAScalar;

  cCd: TAScalar;
  angle: TAScalar;

  Uc: TAScalar;
  Ug: TAScalar;

  Ue: TAScalar;
  kx: TAScalar;
  x: TAScalar;

  q1: TAScalar;
  q2: TAScalar;
  Uel: TAScalar;
  U: TAScalar;

  p: TAScalar;
  p2: TAScalar;
  impulse: TAScalar;
  Lp: TAScalar;

  flowrate: TAScalar;

  lambda: TAScalar;
  deltadist: TAScalar;
  deltatemp: TAScalar;

  specificheatcapacity: TAScalar;
  heatcapacity: TAScalar;

  _m1: TAScalar;
  _m2: TAScalar;
  _tf: TAScalar;
  _t1: TAScalar;
  _t2: TAScalar;
  _c1: TAScalar;
  _c2: TAScalar;

  lambda2: TAScalar;

  E: TAScalar;
  sigma: TAScalar;

  B: TAScalar;
  len: TAScalar;
  r: TAScalar;
  z: TAScalar;
  loops: longint;

  i1, i2: TAScalar;
  magneticflux: TAScalar;

  DeltaE: TAScalar;

  Ampl: TAScalar;
  Kw: TAScalar;
  Omega: TAScalar;
  phi: TAScalar;

  wavelen: TAScalar;
  wavelenc: TAScalar;
  yspeed: TAScalar;
  yacc: TAScalar;

  E0: TAScalar;
  Energy: TAScalar;
  freq: TAScalar;

  I: TAScalar;
  Re: TAScalar;

  num: integer;
  alpha: TAScalar;
  kc: TAScalar;
  BoxLen: TAScalar;
  EnergyLevels: array[1..4] of TAScalar;
  SquarePsi: array[1..4] of TAScalar;
  Psi0: TAScalar;
  PsiValues: array [1..4] of TAScalar;
  A0: TAScalar;
  y: TAScalar;

  Iteration: longint;
  Iterations: longint;
  Probability: TAScalar;
  mu: TAScalar;

  E1, E2: TAScalar;
  L1, L2: TAScalar;

  kfactor: TAScalar;
  bfactor: TAScalar;
  U0: TAScalar;
  TunnelingProbability: TAScalar;

begin
  ExitCode := 0;
  DefaultFormatSettings.DecimalSeparator := '.';
  writeln('ADim TEST STARTING ...');

  // TEST-00 - AREA
  side1 := 10*m;
  side2 := 5*m;
  area  := side1*side2;
  side1 := area/side2;
  side2 := area/side1;

  if m.ToVerboseString(side1) <> '10 meters'        then halt(1);
  if m.ToVerboseString(side2) <> '5 meters'         then halt(2);
  if m2.ToVerboseString(area) <> '50 square meters' then halt(3);
  writeln('* TEST-00: PASSED');

  // TEST-01 - VOLUME
  side1  := 10*m;
  side2  := 5*m;
  side3  := 2*m;
  volume := side1*side2*side3;
  side1  := volume/side2/side3;
  side2  := volume/side1/side3;
  side3  := volume/side1/side2;
  if m.ToVerboseString(side1)   <> '10 meters'        then halt(1);
  if m.ToVerboseString(side2)   <> '5 meters'         then halt(2);
  if m.ToVerboseString(side3)   <> '2 meters'         then halt(3);
  if m3.ToVerboseString(volume) <> '100 cubic meters' then halt(4);
  writeln('* TEST-01: PASSED');

  // TEST-02 - HYPER VOLUME
  side1 := 10*m;
  side2 := 5*m;
  side3 := 2*m;
  side4 := 7*m;
  hypervolume := side1*side2*side3*side4;
  side1 := hypervolume/side2/side3/side4;
  side2 := hypervolume/side1/side3/side4;
  side3 := hypervolume/side1/side2/side4;
  side4 := hypervolume/side1/side2/side3;
  if m.ToVerboseString(side1)        <> '10 meters'          then halt(1);
  if m.ToVerboseString(side2)        <> '5 meters'           then halt(2);
  if m.ToVerboseString(side3)        <> '2 meters'           then halt(3);
  if m.ToVerboseString(side4)        <> '7 meters'           then halt(4);
  if m4.ToVerboseString(hypervolume) <> '700 quartic meters' then halt(5);
  writeln('* TEST-02: PASSED');

  // TEST-03 - SPEED
  distance := 20*km;
  time     := 2*hr;
  speed    := distance/time;
  time     := distance/speed;
  distance := speed*time;
  if MeterPerHourUnit.ToVerboseString(speed, 5, 0, [pKilo]) <> '10 kilometers per hour' then halt(1);
  if hourUnit.ToVerboseString(time)                         <> '2 hours'                then halt(2);
  if m.ToVerboseString(distance, 5, 0, [pKilo])             <> '20 kilometers'          then halt(3);
  writeln('* TEST-03: PASSED');

  // TEST-04 - ACCELERATION
  time  := 5*s;
  speed := 100*km/hr;
  acc   := speed/time;
  time  := speed/acc;
  speed := acc*time;

  if MeterPerHourUnit.ToVerboseString(speed, 5, 0, [pKilo])               <> '100 kilometers per hour'           then halt(1);
  if s.ToVerboseString(time,  5, 0, [])                                   <> '5 seconds'                         then halt(2);
  if MeterPerHourPerSecondUnit.ToVerboseString(acc, 5, 0, [pKilo, pNone]) <> '20 kilometers per hour per second' then halt(3);
  if MeterPerSquareSecondUnit.ToVerboseString (acc, 5, 0, [])             <> '5.5556 meters per second squared'  then halt(4);
  writeln('* TEST-04: PASSED');

  // TEST-05 - FORCE
  mass  := 5*kg;
  acc   := 10*m/s2;
  force := mass*acc;
  mass  := force/acc;
  acc   := force/mass;
  if kg.ToVerboseString(mass,  5, 0, [])              <> '5 kilograms' then halt(1);
  if MeterPerSquareSecondUnit.ToString(acc, 5, 0, []) <> '10 m/s2'     then halt(2);
  if N.ToVerboseString(force, 5, 0, [])               <> '50 newtons'  then halt(3);
  writeln('* TEST-05: PASSED');

  // TEST-06 - ANGULAR SPEED
  angle        := 5*rad;
  time         := 2*s;
  angularspeed := angle/time;
  radius       := 2*m;
  speed        := angularspeed*radius;
  angularspeed := speed/radius;
  if RadianPerSecondUnit.ToVerboseString(angularspeed, 5, 1, []) <> '2.5 radians per second' then halt(1);
  if MeterPerSecondUnit.ToVerboseString (speed, 5, 1, [])        <> '5 meters per second'    then halt(2);
  writeln('* TEST-06: PASSED');

  // TEST-07 - CENTRIFUGAL FORCE
  mass         := 1*kg;
  angularspeed := 2*rad/s;
  radius       := 10*m;
  speed        := angularspeed*radius;
  acc          := (angularspeed*angularspeed)*radius;
  force        := mass*acc;
  if MeterPerSecondUnit.ToString(speed, 5, 0, [])     <> '20 m/s'  then halt(1);
  if MeterPerSquareSecondUnit.ToString(acc, 5, 0, []) <> '40 m/s2' then halt(2);
  if N.ToString(force, 5, 0, [])                      <> '40 N'    then halt(3);
  writeln('* TEST-07: PASSED');

  // TEST-08 - CENTRIPETAL FORCE
  mass         := 10*kg;
  radius       := 1*m;
  angularspeed := 2*rad/s;
  speed        := angularspeed*radius;
  force        := mass*(SquarePower(angularspeed)*radius);
  force        := mass*(SquarePower(speed)/radius);
  if MeterPerSecondUnit.ToString(speed, 5, 0, []) <> '2 m/s' then halt(1);
  if N.ToString(force, 5, 0, [])                  <> '40 N'  then halt(2);
  writeln('* TEST-08: PASSED');

  // TEST-09 - PRESSURE
  force    := 10*N;
  area     := 5*m2;
  pressure := force/area;
  force    := pressure*area;
  area     := force/pressure;
  if Pa.ToString(pressure)  <> '2 Pa' then halt(1);
  if N.ToString(force)      <> '10 N' then halt(2);
  if m2.ToString(area)      <> '5 m2' then halt(3);
  writeln('* TEST-09: PASSED');

  // TEST-10 - WORK
  force    := 10*N;
  distance := 5*m;
  work     := force*distance;
  if J.ToString(work, 5, 0, [pDeca])        <> '5 daJ'        then halt(1);
  if J.ToVerboseString(work, 5, 0, [pDeca]) <> '5 decajoules' then halt(2);
  writeln('* TEST-10: PASSED');

  // TEST-11 - POWER (J/s)
  work  := 50*J;
  time  := 10*s;
  power := work/time;
  if W.ToString(power, 5, 0, []) <> '5 W' then halt(1);
  writeln('* TEST-11: PASSED');

  // TEST-12 - POWER (N.m * rad/s)
  torque       := 10*N*m;
  angularspeed := 2*rad/s;
  power        := torque*angularspeed;
  angularspeed := power/torque;
  torque       := power/angularspeed;
  if W.ToString(power, 5, 0, []) <> '20 W' then halt(1);
  writeln('* TEST-12: PASSED');

  // TEST-13 - VOLT (J/C)
  work      := 50*J;
  charge    := 25*C;
  potential := work/charge;
  if V.ToString(potential) <> '2 V'  then halt(1);
  if C.ToString(charge) <> '25 C' then halt(2);
  if J.ToString(work)     <> '50 J' then halt(3);
  writeln('* TEST-13: PASSED');

  // TEST-14 - VOLT (W/A)
  power     := 10*W;
  current   := 5*A;
  potential := power/current;
  if V.ToString(potential) <> '2 V'  then halt(1);
  if A.ToString(current)   <> '5 A'  then halt(2);
  if W.ToString(power)     <> '10 W' then halt(3);
  writeln('* TEST-14: PASSED');

  // TEST-15 - VOLT ((W*Ω)^0.5);
  power      := 250*W;
  resistance := 10*Ohm;
  potential  := SquareRoot(power*resistance);
  if V.ToString(potential) <> '50 V' then halt(1);
  writeln('* TEST-15: PASSED');

  // TEST-16 - AMPERE ((W/Ω)^0.5);
  power      := 4000*W;
  resistance := 10*Ohm;
  current    := SquareRoot(power/resistance);
  if A.ToString(current) <> '20 A' then halt(1);
  writeln('* TEST-16: PASSED');

  // TEST-17 - FARAD (C2/J)
  squarecharge := 25*C2;
  work         := 50*J;
  capacitance  := squarecharge/work;
  if F.ToString(capacitance) <> '0.5 F' then halt(1);
  writeln('* TEST-17: PASSED');

  // TEST-18 - FARAD (C/V)
  charge      :=  10*C;
  potential   :=  5*V;
  capacitance := charge/potential;
  if F.ToVerboseString(capacitance) <> '2 farads' then halt(1);
  writeln('* TEST-18: PASSED');

  // TEST-19 - WEBER
  potential := 5*V;
  time      := 10*s;
  flux      := potential*time;
  if Wb.ToVerboseString(flux) <> '50 webers' then halt(1);
  writeln('* TEST-19: PASSED');

  // TEST-20 - TESLA
  flux        := 25*Wb;
  area        := 10*m2;
  fluxdensity := flux/area;
  if T.ToVerboseString(fluxdensity) <> '2.5 teslas' then halt(1);
  writeln('* TEST-20: PASSED');

  // TEST-21 - HENRY
  flux       := 30*Wb;
  current    := 10*A;
  inductance := flux/current;
  if H.ToString(inductance)        <> '3 H'       then halt(1);
  if H.ToVerboseString(inductance) <> '3 henries' then halt(2);
  writeln('* TEST-21: PASSED');

  // TEST-22 - SIEMENS
  resistance  := 2*Ohm;
  conductance := 1/resistance;
  if Siemens.ToVerboseString(conductance) <> '0.5 siemens' then halt(1);
  writeln('* TEST-22: PASSED');

  // TEST-23 - COULOMB
  current := 5*A;
  time    := 5*s;
  charge  := current*time;
  if C.ToVerboseString(charge) <> '25 coulombs' then halt(1);
  if C.ToString(charge)        <> '25 C'        then halt(2);
  writeln('* TEST-23: PASSED');

  // TEST-24 - LUMEN
  intensity    := 10*cd;
  solidangle   := 90*sr;
  luminousflux := intensity*solidangle;
  if lm.ToString(luminousflux) <> '900 lm' then halt(1);
  writeln('* TEST-24: PASSED');

  // TEST-25 - SIEVERT & GRAY
  dose1 := 10*Sv;
  dose2 := 5 *Gy;
  dose1 := 10*m2/s2;
  dose2 := 5 *m2/s2;
  dose1 := 10*j/kg;
  dose2 := 5 *j/kg;
  if SquareMeterPerSquareSecondUnit.ToString(dose1) <> '10 m2/s2' then halt(1);
  if SquareMeterPerSquareSecondUnit.ToString(dose2) <> '5 m2/s2'  then halt(2);
  if Sv.ToString(dose1)                             <> '10 Sv'    then halt(3);
  if Gy.ToString(dose2)                             <> '5 Gy'     then halt(4);
  writeln('* TEST-25: PASSED');

  // TEST-26 - NEWTON PER METER
  force     := 50*N;
  distance  := 10*mm;
  stiffness := force/distance;
  if NewtonPerMeterUnit.ToString(stiffness) <> '5000 N/m' then halt(1);
  writeln('* TEST-26: PASSED');

  // TEST-27 - DENSITY
  mass    := 10*kg;
  volume  := 5*m3;
  density := mass/volume;
  mass    := density*volume;
  volume  := mass/density;
  if KilogramPerCubicMeterUnit.ToString(density) <> '2 kg/m3' then halt(1);
  if Kg.ToString(mass)                           <> '10 kg'   then halt(2);
  if m3.ToString(volume)                         <> '5 m3'    then halt(3);
  writeln('* TEST-27: PASSED');

  // TEST-28 - SPECIFIC WEIGHT
  force     := 100*N;
  volume    := 10*m3;
  specificw := force/volume;
  force     := specificw*volume;
  volume    := force/specificw;
  if NewtonPerCubicMeterUnit.ToString(specificw) <> '10 N/m3' then halt(1);
  if N.ToString(force)                           <> '100 N'   then halt(2);
  if m3.ToString(volume)                         <> '10 m3'   then halt(3);
  writeln('* TEST-28: PASSED');

  // TEST-29 - SLIDING FRICTION
  normal := 100*N;
  kA     := 0.05;
  force  := kA*normal;
  if N.ToString(force) <> '5 N' then halt(1);
  writeln('* TEST-29: PASSED');

  // TEST-30 - ROLLING FRICTION
  normal := 100*N;
  kAr    := 0.0005*m;
  radius := 50*mm;
  force  := kAr*normal/radius;
  if N.ToString(force) <> '1 N' then halt(1);
  writeln('* TEST-30: PASSED');

  // TEST-31 - VISCOSITY FORCE (LAMINAR FLOW)
  eta    := 10*Pa*s;
  radius := 20*mm;
  side1  := 1*m;
  area   := 2*radius*side1;
  speed  := 0.5*m/s;
  force  := eta/(radius/speed)*area;
  force  := 6*pi*radius*eta*speed;
  if N.ToString(force, 4, 2, []) <> '1.885 N' then halt(1);
  writeln('* TEST-31: PASSED');

  // TEST-32 - DRAG FORCE
  cCd     := 0.47;
  area    := 1000*mm2;
  speed   := 5*m/s;
  density := 1.225*kg/m3;
  force   := 0.5*cCd*(density*SquarePower(Speed))*area;
  if N.ToString(force, 4, 2, [])                           <> '0.007197 N'  then halt(1);
  if KilogramPerCubicMeterUnit.ToString(density, 4, 2, []) <> '1.225 kg/m3' then halt(2);
  writeln('* TEST-32: PASSED');

  // TEST-33 - UNIVERSAL GRAVITATION LAW
  mass1    := 5.97219E24*kg;
  mass2    := 7.342E22*kg;
  distance := 384400*km;
  force    := NewtonianConstantOfGravitation*(mass1*mass2)/(distance*distance);
  if N.ToString(force, 4, 2, []) <> '1.981E20 N' then halt(1);
  writeln('* TEST-33: PASSED');

  // TEST-34 - GRAVITATIONAL POTENTIAL ENERGY
  mass     := 10*kg;
  distance := 10*m;
  Ug       := mass*StandardAccelerationOfGravity*distance;
  if J.ToString(Ug, 4, 2, []) <> '980.7 J' then halt(1);
  writeln('* TEST-34: PASSED');

  // TEST-35 - KINEMATIC POTENTIAL ENERGY
  mass  := 10*kg;
  speed := 5*m/s;
  Uc    := 1/2*mass*(speed*speed);
  if J.ToString(Uc, 4, 2, []) <> '125 J' then halt(1);
  writeln('* TEST-35: PASSED');

  // TEST-36 - ELASTIC POTENTIAL ENERGY
  kx       := 10*N/m;
  distance := 10*m;
  Ue       := 0.5*kx*(distance*distance);
  if J.ToString(Ue, 4, 2, []) <> '500 J' then halt(1);
  writeln('* TEST-36: PASSED');

  // TEST-37 - MOMENTUM
  mass  := 10*kg;
  speed := 5*m/s;
  p     := mass*speed;
  p     := 50*kg*m/s;
  p2    := p*p;
  Uc    := 0.5*p2/mass;
  if KilogramMeterPerSecondUnit.ToString(p, 4, 2, [])                    <> '50 kg.m/s'      then halt(1);
  if SquareKilogramSquareMeterPerSquareSecondUnit.ToString(p2, 4, 2, []) <> '2500 kg2.m2/s2' then halt(2);
  writeln('* TEST-37: PASSED');

  // TEST-38 - IMPULSE
  force   := 10*N;
  time    := 5*ms;
  impulse := p;
  impulse := force*time;
  if NewtonSecondUnit.ToString(impulse, 4, 2, [pNone, pMilli]) <> '50 N.ms' then halt(1);
  writeln('* TEST-38: PASSED');

  // TEST-39 - STEVINO'S LAW
  density  := 10*kg/m3;
  distance := 2*m;
  pressure := density*StandardAccelerationOfGravity*distance;
  if Pa.ToString(pressure, 4, 2, []) <> '196.1 Pa' then halt(1);
  writeln('* TEST-39: PASSED');

  // TEST-40 - ARCHIMEDE'S LAW
  density := 0.5*kg/m3;
  volume  := 0.5*m3;
  force   := density*StandardAccelerationOfGravity*volume;
  if N.ToString(force, 4, 2, []) <> '2.452 N' then halt(1);
  writeln('* TEST-40: PASSED');

  // TEST-41 - CONTINUITY EQUATION (FLUID)
  volume   := 50*m3;
  time     := 10*s;
  flowrate := volume/time;
  if CubicMeterPerSecondUnit.ToString(flowrate, 4, 2, []) <> '5 m3/s' then halt(1);
  writeln('* TEST-41: PASSED');

  // TEST-42 - BERNOULLI'S LAW
  density  := 5*kg/m3;
  speed    := 5*m/s;
  pressure := 1/2*density*(speed*speed);
  if Pa.ToString(pressure, 4, 2, []) <> '62.5 Pa' then halt(1);

  distance := 2*m;
  pressure := density*StandardAccelerationOfGravity*distance;
  if Pa.ToString(pressure, 4, 2, []) <> '98.07 Pa' then halt(2);
  writeln('* TEST-42: PASSED');

  // TEST-43 - REYNOLDS NUMBER
  flowrate := 5*dm3/minute;
  density  := 1.05*g/cm3;
  eta      := 0.003*Pl;
  radius   := 0.9*cm;
  Re       := 2000;
  speed    := Re*eta/(2*density*radius);
  if MeterPerSecondUnit.ToString(speed, 4, 2, []) <> '0.3175 m/s' then halt(1);
  writeln('* TEST-43: PASSED');

  // TEST-44 - LINEAR THERMAL EXPANSION
  distance  := 10*m;
  lambda    := 1.2E-5/K;
  deltatemp := 100*K;
  deltadist := distance*(lambda*deltatemp);
  if m.ToString(deltadist, 4, 2, [pMilli]) <> '12 mm' then halt(1);
  writeln('* TEST-44: PASSED');

  // TEST-45 - HEAT CAPACITY
  mass                 := 10*kg;
  specificheatcapacity := 7.5*J/kg/K;
  heatcapacity         := mass*specificheatcapacity;
  if JoulePerKelvinUnit.ToString(heatcapacity, 4, 2, []) <> '75 J/K' then halt(1);
  writeln('* TEST-45: PASSED');

  // TEST-46 - CALORIMETER
  _m1 := 10*kg;
  _t1 := 100*K;
  _c1 := 7.5*J/kg/K;
  _m2 := 10*kg;
  _t2 := 50*K;
  _c2 := 7.5*J/kg/K;
  _tf := (_m1*_c1*_t1+_m2*_c2*_t2) / (_m1*_c1+_m2*_c2);
  if K.ToString(_tf, 4, 2, []) <> '75 K' then halt(1);
  writeln('* TEST-46: PASSED');

  // TEST-47 - THERMAL FLUX
  area      := 5*m2;
  side1     := 100*mm;
  lambda2   := 1.1*W/m/K;
  deltatemp := 15*K;
  power     := lambda2*(deltatemp/side1)*area;
  if W.ToString(power, 4, 2, []) <> '825 W' then halt(1);
  writeln('* TEST-47: PASSED');

  // TEST-48 - ELECTRIC POTENTIAL ENERGY
  q1  := 6E-6*C;
  q2  := 9E-6*C;
  Uel := CoulombConstant*(q1*q2/distance);
  if J.ToString(Uel, 4, 2, [pMilli]) <> '48.53 mJ' then halt(1);
  writeln('* TEST-48: PASSED');

  // TEST-49 - ELECTROSTATIC FORCE ON A POINT CHARGE IN A ELECTRIC FIELD
  E     := 0.0015*N/C;
  q1    := ElectronCharge;
  force := E*q1;
  if N.ToString(force, 4, 2, [pYocto]) <> '240.3 yN' then halt(1);
  writeln('* TEST-49: PASSED');

  // TEST-50 - ELECTROSTATIC FORCE BETWEEN TWO POINT CHARGES
  q1       := 6E-6*C;
  q2       := 9E-6*C;
  distance := 2*m;
  force    := CoulombConstant*(q1*q2)/(distance*distance);
  if N.ToString(force, 4, 2, [pMilli]) <> '121.3 mN' then halt(1);
  writeln('* TEST-50: PASSED');

  // TEST-51 - ELECTRIC FIELD OF A SINGLE POINT CHARGE
  q1 := 2*C;
  r  := 5*cm;
  E  := CoulombConstant*(q1/SquarePower(r));
  if VoltPerMeterUnit.ToString(E, 4, 2, [pMega, pMilli]) <> '7190 MV/mm' then halt(1);
  writeln('* TEST-51: PASSED');

  // TEST-52 - ELECTRIC FIELD OF UNIFORM CHARGE SPHERE
  q1       := 2*C;
  r        := 10*cm;
  distance := 5*cm;
  E        := CoulombConstant*(q1/ (CubicPower(r)/distance));
  if VoltPerMeterUnit.ToString(E, 4, 2, [pMega, pMilli]) <> '898.8 MV/mm' then halt(1);
  writeln('* TEST-52: PASSED');

  // TEST-53 - ELECTRIC FIELD OF PARALLEL CONDUCTING PLATES
  q1    := 2*C;
  Area  := 4*cm2;
  sigma := q1/Area;
  E     := sigma/ElectricPermittivity;
  if VoltPerMeterUnit.ToString(E, 4, 2, [pGiga, pMilli]) <> '564.7 GV/mm' then halt(1);
  writeln('* TEST-53: PASSED');

  // TEST-54 - MAGNETIC FORCE FOR LIFTING A OBJECT
  mass    := 100*g;
  len     := 20*cm;
  B       := 2.0*T;
  current := (mass*StandardAccelerationOfGravity)/(len*B*Sin(90*deg));
  if A.ToString(current, 4, 2, [pMilli]) <> '2452 mA' then halt(1);
  writeln('* TEST-54: PASSED');

  // TEST-55 - MAGNETIC FIELD DUE TO STRAIGHT WIRE
  current  := 3.0*A;
  R        := 50*cm;
  z        := 0*cm;
  B        := MagneticPermeability/(2*pi) * (current/(SquareRoot(CubicPower(SquarePower(z)+SquarePower(R)))/SquarePower(R)));
  {$IFDEF WINDOWS}
  if Utf8ToAnsi(T.ToString(B, 4, 2, [pMicro])) <> Utf8ToAnsi('1.2 µT') then halt(1);
  {$ENDIF}
  {$IFDEF UNIX}
  if T.ToVerboseString(B, 4, 2, [pMicro]) <> '1.2 microteslas' then halt(1);
  {$ENDIF}
  writeln('* TEST-55: PASSED');

  // TEST-56 - MAGNETIC FIELD PRODUCED BY A CURRENT-CARRYING SOLENOID
  current  := 1600*A;
  loops    := 2000;
  len      := 2.0*m;
  B        := MagneticPermeability*loops*(current/len);
  if T.ToVerboseString(B, 4, 2, []) <> '2.011 teslas' then halt(1);
  writeln('* TEST-56: PASSED');

  // TEST-57 - FORCES BETWEEN PARALLEL CONDUCTORS
  i1    := 2.5*A;
  i2    := 1.5*A;
  r     := 4*cm;
  len   := 1.0*m;
  force := (MagneticPermeability/(2*pi)*(len/r)) * (i1*i2);
  if N.ToVerboseString(force, 4, 2, [pMicro]) <> '18.75 micronewtons' then halt(1);
  writeln('* TEST-57: PASSED');

  // TEST-58 - MAGNETIC FLUX
  B            := 0.4*T;
  Area         := 100*cm2;
  angle        := 70*deg;
  magneticflux := B*Area*cos(angle);
  if Wb.ToVerboseString(magneticflux, 4, 2, [pMicro]) <> '1368 microwebers' then halt(1);
  writeln('* TEST-58: PASSED');

  // TEST-59 - ELECTROMAGNETIC INDUCTION
  magneticflux := 6*1E-5*Wb;
  time         := 0.1*s;
  potential    := magneticflux/time;
  if V.ToVerboseString(potential, 4, 2, [pMicro]) <> '600 microvolts' then halt(1);
  writeln('* TEST-59: PASSED');

  // TEST-60 - DISPLACEMENT CURRENT
  Area     := 100*cm2;
  DeltaE   := 6.0E10*N/C;
  time     := 1*s;
  current  := (ElectricPermittivity*DeltaE*Area)/time;
  if A.ToVerboseString(current, 4, 2, [pMicro]) <> '5313 microamperes' then halt(1);
  writeln('* TEST-60: PASSED');

  // TEST-61 - HARMONIC WAVE
  Ampl    := 2*m;
  Kw      := 0.2*rad/m;
  omega   := 80*rad/s;
  phi     := 0*rad;
  wavelen := Ampl*Sin(Kw*(1*m) -omega*(0.8*s) + phi);
  yspeed  := -omega*Ampl*Cos(Kw*(1*m) -omega*(0.8*s));
  yacc    := -SquarePower(omega)*Ampl*cos(Kw*(1*m) -omega*(0.8*s));
  power   := (1.0*g/m)*SquarePower(omega*Ampl)*(5*mm/s);
  if m.ToString(wavelen, 4, 2, [pMilli])               <> '-1648 mm'   then halt(1);
  if MeterPerSecondUnit.ToString(yspeed, 4, 2, [])     <> '-90.69 m/s' then halt(2);
  if MeterPerSquareSecondUnit.ToString(yacc, 4, 2, []) <> '-7255 m/s2' then halt(3);
  if W.ToString(power, 4, 2, [pMilli])                 <> '128 mW'     then halt(4);
  writeln('* TEST-61: PASSED');

  // TEST-62 - RELATIVTY: ENERGY
  mass       := 1*kg;
  energy     := mass*SquarePower(SpeedOfLight);
  if ElectronVoltUnit.ToString(energy, 4, 2, [pTera]) <> '5.61E23 TeV' then halt(1);
  if J.ToString(energy, 4, 2, [pTera])                <> '8.988E4 TJ'  then halt(2);
  writeln('* TEST-62: PASSED');

  // TEST-63 - RELATIVTY: MOMENTUM
  mass       := ElectronMass;
  speed      := 10800000*km/hr;
  p          := mass*speed;
  energy     := SquareRoot(SquarePower(p*SpeedOfLight)+ SquarePower(mass*SquarePower(SpeedOfLight)));
  if KilogramMeterPerSecondUnit.ToString(p, 4, 2, [pPico, pPico, pNone]) <> '2733 pg.pm/s' then halt(1);
  if ElectronVoltUnit.ToString(energy, 4, 2, [pKilo])                    <> '511 keV'      then halt(2);
  writeln('* TEST-63: PASSED');

  // TEST-64 - MOMENTUM OF PHOTON
  len    := 1*mim;
  freq   := 1*Hz;
  energy := PlanckConstant/(len/SpeedOfLight);
  p      := PlanckConstant*freq/SpeedOfLight;
  p      := PlanckConstant/len;
  speed  := len*freq;
  if ElectronVoltUnit.ToString(energy, 4, 2, [])                         <> '1.24 eV'        then halt(1);
  if KilogramMeterPerSecondUnit.ToString(p, 4, 2, [pPico, pPico, pNone]) <> '0.6626 pg.pm/s' then halt(2);
  if MeterPerSecondUnit.ToString(speed, 9, 2, [pPico, pNone])            <> '1000000 pm/s'   then halt(3);
  writeln('* TEST-64: PASSED');

  // TEST-65 - THIRD KEPLER'S LAW
  mass1    := 1.989E30*kg;
  mass2    := 5.972E24*kg;
  distance := 1*au;
  time     := SquareRoot( 4*Sqr(pi)*CubicPower(distance)/(NewtonianConstantOfGravitation*(mass1+mass2)));
  if DayUnit.ToString(time, 5, 0, []) <> '365.2 d' then halt(1);
  writeln('* TEST-65: PASSED');

  // TEST-66 - EARTH'S GRAVITY
  mass     := 5.972E24*kg;
  distance := 6.373E6*m;
  acc      := NewtonianConstantOfGravitation*mass/SquarePower(distance);
  if MeterPerSquareSecondUnit.ToString(acc, 3, 2, []) <> '9.81 m/s2' then halt(1);
  writeln('* TEST-66: PASSED');

  // TEST-67 - SIMPLE HARMONIC OSCILLATOR
  mass  := 1*kg;
  kx    := 10*N/m;
  omega := SquareRoot(kx/mass);
  if RadianPerSecondUnit.ToString(omega, 3, 2, []) <> '3.16 rad/s' then halt(1);
  writeln('* TEST-67: PASSED');

  // TEST-68 - DAMPED HARMONIC OSCILLATOR
  mass   := 1*kg;
  kx     := 10*N/m;
  Cb     := 10*Pa*s*m;
  omega  := SquareRoot(kx/mass);
  if RadianPerSecondUnit.ToString(omega, 3, 2, []) <> '3.16 rad/s' then halt(1);
  writeln('* TEST-68: PASSED');

  // TEST-69 - PHYSICAL PENDULUM
  mass   := 1*kg;
  I      := 10*kg*m2;
  radius := 20*cm;
  time   := 2*pi*SquareRoot(1/((mass*StandardAccelerationOfGravity*radius)/I));
  time   := 2*pi*SquareRoot(I/(mass*StandardAccelerationOfGravity*radius));
  if s.ToString(time, 4, 2, []) <> '14.19 s' then halt(1);
  writeln('* TEST-69: PASSED');

  // TESTS FROM 70 TO 93
  if kg.ToString(1.0*mg, 10, 10, [pKilo])         <> '1E-6 kg'                   then halt(01);  writeln('* TEST-70: PASSED');
  if kg2.ToString(1.0*mg2, 10, 0,  [pKilo])       <> '1E-12 kg2'                 then halt(02);  writeln('* TEST-71: PASSED');
  if kg.ToString(1.0*mg, 10, 10, [pMega])         <> '1E-9 Mg'                   then halt(03);  writeln('* TEST-72: PASSED');
  if kg2.ToString(1.0*mg2, 10, 0,  [pMega])       <> '1E-18 Mg2'                 then halt(04);  writeln('* TEST-73: PASSED');
  if kg.ToString(1.0*kg, 10, 0, [pNone])          <> '1000 g'                    then halt(05);  writeln('* TEST-74: PASSED');
  if kg.ToString(1.0*kg, 10, 0, [pKilo])          <> '1 kg'                      then halt(06);  writeln('* TEST-75: PASSED');
  if kg2.ToString(1.0*kg2, 10, 0, [pNone])        <> '1000000 g2'                then halt(07);  writeln('* TEST-76: PASSED');
  if kg2.ToString(1.0*kg2, 10, 0, [pKilo])        <> '1 kg2'                     then halt(08);  writeln('* TEST-77: PASSED');
  if m.ToString(1.0*km, 10, 0, [])                <> '1000 m'                    then halt(09);  writeln('* TEST-78: PASSED');
  if m2.ToString(1.0*km2, 10, 0, [])              <> '1000000 m2'                then halt(10);  writeln('* TEST-79: PASSED');
  if kg.ToVerboseString(1.0*kg, 10, 0, [pNone])   <> '1000 grams'                then halt(11);  writeln('* TEST-80: PASSED');
  if kg2.ToVerboseString(1.0*kg2, 10, 0, [pNone]) <> '1000000 square grams'      then halt(12);  writeln('* TEST-81: PASSED');
  if m.ToVerboseString (1.0*km, 10, 0, [])        <> '1000 meters'               then halt(13);  writeln('* TEST-82: PASSED');
  if m2.ToVerboseString(1.0*km2, 10, 0, [])       <> '1000000 square meters'     then halt(14);  writeln('* TEST-83: PASSED');
  if m3.ToVerboseString(1.0*km3, 10, 0, [])       <> '1000000000 cubic meters'   then halt(15);  writeln('* TEST-84: PASSED');
  if m4.ToVerboseString(1.0*km4, 10, 0, [])       <> '1E12 quartic meters'       then halt(16);  writeln('* TEST-85: PASSED');
  if s.ToVerboseString (1.0*day, 10, 0, [])       <> '86400 seconds'             then halt(16);  writeln('* TEST-86: PASSED');
  if s.ToVerboseString (1.0*hr, 10, 0, [])        <> '3600 seconds'              then halt(17);  writeln('* TEST-87: PASSED');
  if s.ToString(1.0*day, 10, 0, [])               <> '86400 s'                   then halt(18);  writeln('* TEST-88: PASSED');
  if s.ToString(1.0*hr, 10, 0, [])                <> '3600 s'                    then halt(19);  writeln('* TEST-89: PASSED');
  if s2.ToVerboseString(1.0*day2, 10, 0, [])      <> '7464960000 square seconds' then halt(20);  writeln('* TEST-90: PASSED');
  if s2.ToVerboseString(1.0*hr2, 10, 0, [])       <> '12960000 square seconds'   then halt(21);  writeln('* TEST-91: PASSED');
  if s2.ToString(1.0*day2, 10, 0, [])             <> '7464960000 s2'             then halt(22);  writeln('* TEST-92: PASSED');
  if s2.ToString(1.0*hr2, 10, 0, [])              <> '12960000 s2'               then halt(23);  writeln('* TEST-93: PASSED');

  // TEST-94
  if WattHourUnit.ToString(1.0*J, 4, 0, [pMilli])   <> '0.2778 mW.h' then halt(1);
  if AmpereHourUnit.ToString(1.0*C, 4, 0, [pMilli]) <> '0.2778 mA.h' then halt(2);
  writeln('* TEST-94: PASSED');

  // TEST-95
  omega := 10*rad/s;
  omega := 10*Hz;
  freq  := 10*rad/s;
  freq  := 10*Hz;
  omega := freq;
  freq  := omega;
  if Hz.ToString(omega)                 <> '10 Hz'    then halt(1);
  if RadianPerSecondUnit.ToString(freq) <> '10 rad/s' then halt(2);
  writeln('* TEST-95: PASSED');

  // TEST-96
  distance  := 10.5*mm;
  tolerance := 0.2*mm;
  if Utf8ToAnsi(m.ToString(distance, tolerance, 5, 5, [pMilli]))        <> Utf8ToAnsi('10.5 ± 0.2 mm')          then halt(1);
  if Utf8ToAnsi(m.ToVerboseString(distance, tolerance, 5, 5, [pMilli])) <> Utf8ToAnsi('10.5 ± 0.2 millimeters') then halt(2);
  writeln('* TEST-96: PASSED');

  // TEST-97
  distance := 5.0*m;
  if SameValue(distance, (5.0+1E-13)*m) = False then halt(1);
  if SameValue(distance, (5.0+1E-12)*m) = False then halt(2);
  if SameValue(distance, (5.0+1E-11)*m) = True  then halt(3);
  writeln('* TEST-97: PASSED');

  // TEST-98
  if Min(5.0*m, 6.0*m) <> (5.0*m) then halt(1);
  if Max(5.0*m, 6.0*m) <> (6.0*m) then halt(2);
  writeln('* TEST-98: PASSED');

  // TEST-99 - COMPTON WAVE LEGNTH
  wavelenc := PlanckConstant/(ElectronMass*SpeedOfLight);
  if SameValue(wavelenc, ComptonWaveLength) <> TRUE then halt(1);
  writeln('* TEST-99: PASSED');

  // TEST-100 - BOHR MODEL
  num    := 1;
  // electron's speed
  speed  := CoulombConstant*SquarePower(ElectronCharge)/num/ReducedPlanckConstant;
  // orbit radius
  radius := num*ReducedPlanckConstant/ElectronMass/speed;
  // angular momentum
  Lp     := num*ReducedPlanckConstant;
  Lp     := ElectronMass*speed*radius;
  // electron's speed
  speed  := SquareRoot(CoulombConstant*SquarePower(ElectronCharge)/ElectronMass/radius);
  speed  := SquareRoot(SquarePower(ElectronCharge)/4/pi/ElectricPermittivity/ElectronMass/radius);
  // orbit radius
  radius := Sqr(num)*SquarePower(ReducedPlanckConstant)/ElectronMass/(ElectronCharge*ElectronCharge*CoulombConstant);
  // fine structure constant
  alpha  := CoulombConstant*SquarePower(ElectronCharge)/ReducedPlanckConstant/SpeedOfLight;
  // orbit radius
  radius := num*(ReducedPlanckConstant)/ElectronMass/SpeedOfLight/alpha;
  // orbit radius
  radius := SquarePower(ElectronCharge)/(ElectronMass*SquarePower(speed)/CoulombConstant);
  // orbit radius
  radius := (SquarePower(ReducedPlanckConstant)/ElectronMass)/(CoulombConstant*SquarePower(ElectronCharge));
  // energy
  energy := 0.5*ElectronMass*SquarePower(speed) - (CoulombConstant*SquarePower(ElectronCharge))/radius;

  if SameValue(radius ,BohrRadius)                 <> TRUE          then halt(1);
  if m.ToString(radius, 4, 4, [])                  <> '5.292E-11 m' then halt(2);
  if MeterPerSecondUnit.ToString(speed, 4, 4, [])  <> '2.188E6 m/s' then halt(3);
  if ElectronVoltUnit.ToString(energy, 3, 3, [])   <> '-13.6 eV'    then halt(4);
  if RydbergUnit.ToString(energy, 3, 3, [])        <> '-1 Ry'       then halt(5);
  writeln('* TEST-100: PASSED');

  // TEST-101 - QUANTUM MECHANICS
  WaveLen    := 390*nm;
  Kc         := 2*pi/WaveLen;
  p          := ReducedPlanckConstant*Kc;
  p          := ReducedPlanckConstant/(1/Kc);
  p          := Energy/SpeedOfLight;
  Freq       := SpeedOfLight/WaveLen;
  Omega      := Freq*2*pi;
  Energy     := PlanckConstant*Freq;
  Energy     := ReducedPlanckConstant*Omega;
  Energy     := SquarePower(p)/ElectronMass;
  Energy     := SquarePower(ReducedPlanckConstant)*SquarePower(Kc)/2/ElectronMass;
  Kc         := SquareRoot (2*ElectronMass*Energy)/ReducedPlanckConstant;
  writeln('* TEST-101: PASSED');

  // TEST-102 - QUANTUM MECHANICS: PARTICLE IN A BOX
  BoxLen      := 0.05*m;
  EnergyLevels[1] := SquarePower(1*pi*ReducedPlanckConstant)/2/ElectronMass/SquarePower(BoxLen);
  EnergyLevels[2] := SquarePower(2*pi*ReducedPlanckConstant)/2/ElectronMass/SquarePower(BoxLen);
  EnergyLevels[3] := SquarePower(3*pi*ReducedPlanckConstant)/2/ElectronMass/SquarePower(BoxLen);
  EnergyLevels[4] := SquarePower(4*pi*ReducedPlanckConstant)/2/ElectronMass/SquarePower(BoxLen);

  SquarePsi[1] := (2/BoxLen*Sqr(Sin(1*pi/BoxLen*BoxLen/2)));
  SquarePsi[2] := (2/BoxLen*Sqr(Sin(2*pi/BoxLen*BoxLen/4)));
  SquarePsi[3] := (2/BoxLen*Sqr(Sin(3*pi/BoxLen*BoxLen/6)));
  SquarePsi[4] := (2/BoxLen*Sqr(Sin(4*pi/BoxLen*BoxLen/8)));

  if ('|Ψ| = ' + ReciprocalSquareRootMeterUnit.ToString(SquareRoot(2/BoxLen)*Sin(1*pi/BoxLen*BoxLen/2), 4, 4, [])) <> '|Ψ| = 6.325 1/√m' then halt(1);
  if ('|Ψ| = ' + ReciprocalSquareRootMeterUnit.ToString(SquareRoot(2/BoxLen)*Sin(2*pi/BoxLen*BoxLen/4), 4, 4, [])) <> '|Ψ| = 6.325 1/√m' then halt(2);
  if ('|Ψ| = ' + ReciprocalSquareRootMeterUnit.ToString(SquareRoot(2/BoxLen)*Sin(3*pi/BoxLen*BoxLen/6), 4, 4, [])) <> '|Ψ| = 6.325 1/√m' then halt(3);
  if ('|Ψ| = ' + ReciprocalSquareRootMeterUnit.ToString(SquareRoot(2/BoxLen)*Sin(4*pi/BoxLen*BoxLen/8), 4, 4, [])) <> '|Ψ| = 6.325 1/√m' then halt(4);

  if ('|Ψ²| = ' + ReciprocalMeterUnit.ToString(SquarePsi[1])) <> '|Ψ²| = 40 1/m' then halt(5);
  if ('|Ψ²| = ' + ReciprocalMeterUnit.ToString(SquarePsi[2])) <> '|Ψ²| = 40 1/m' then halt(6);
  if ('|Ψ²| = ' + ReciprocalMeterUnit.ToString(SquarePsi[3])) <> '|Ψ²| = 40 1/m' then halt(7);
  if ('|Ψ²| = ' + ReciprocalMeterUnit.ToString(SquarePsi[4])) <> '|Ψ²| = 40 1/m' then halt(8);

  // TEST-103 : Calculate Ψ² integral
  Iterations  := 100;
  for Num := 1 to 4 do
  begin
    Probability := 0;
    for Iteration := 1 to Iterations do
    begin
      Probability := Probability + (2/BoxLen)*Sqr(Sin(Num*pi/BoxLen*(BoxLen*Iteration/Iterations)))*(BoxLen/Iterations);
    end;
    if Format('∫|Ψ²|dx = %0.3f', [ScalarUnit.ToFloat(Probability)]) <> '∫|Ψ²|dx = 1.000' then Halt(1);
  end;
  writeln('* TEST-103: PASSED');

  // TEST-104 : Quantum harmonic oscillator
  x      := 10E-6*m;
  Kx     := 1*N/m;
  mass   := ElectronMass;
  omega  := SquareRoot(Kx/mass);
  E0     := 0.5*ReducedPlanckConstant*omega;

  A0     := QuarticRoot(mass*omega/pi/ReducedPlanckConstant);
  Psi0   := A0*exp(-mass*omega/2/ReducedPlanckConstant*SquarePower(x));

  EnergyLevels[1] := (1 + 0.5)*ReducedPlanckConstant*omega;
  EnergyLevels[2] := (2 + 0.5)*ReducedPlanckConstant*omega;
  EnergyLevels[3] := (3 + 0.5)*ReducedPlanckConstant*omega;
  EnergyLevels[4] := (4 + 0.5)*ReducedPlanckConstant*omega;

  y               := SquareRoot(mass*omega/ReducedPlanckConstant)*x;

  PsiValues[1]    := A0*(  sqrt(2)*(  y         ))*QuarticRoot(mass*omega/pi/ReducedPlanckConstant);
  PsiValues[2]    := A0*(1/sqrt(2)*(2*y*y   -1  ))*QuarticRoot(mass*omega/pi/ReducedPlanckConstant);
  PsiValues[3]    := A0*(1/sqrt(3)*(2*y*y*y -3*y))*QuarticRoot(mass*omega/pi/ReducedPlanckConstant);
  writeln('* TEST-104: PASSED');

  // TEST-105 : STEN-GERLACH EXPERIMENT
  speed    := SpeedOfLight/2;
  spin     := 0.5*ReducedPlanckConstant;
  // magnetic momentum
  mu :=  0.5*ElectronCharge/pi/BohrRadius*speed*pi*SquarePower(BohrRadius);
  mu :=  0.5*ElectronCharge*(speed*BohrRadius);
  mu :=  0.5*ElectronCharge/ElectronMass*(ElectronMass*speed*BohrRadius);
  mu :=  1.0*ElectronCharge/ElectronMass*ReducedPlanckConstant;
  mu := -2.0*BohrMagneton*(spin/ReducedPlanckConstant);
  U  :=  mu*(10*T);
  writeln('* TEST-105: PASSED');

  // TEST-106 : SCHWARZSCHILD RADIUS
  MassOfSun              := 1.9884E+30*kg;
  MassOfSagittariusAStar := 4.297E6 * MassOfSun;
  radius1                := 2*(MassOfSun*NewtonianConstantOfGravitation)/SquarePower(SpeedOfLight);
  radius2                := 2*(MassOfSagittariusAStar*NewtonianConstantOfGravitation)/SquarePower(SpeedOfLight);
  if m.ToString(radius1, 5, 5, [pKilo]) <> '2.9532 km'  then halt(1);
  if m.ToString(radius2, 5, 5, [])      <> '1.269E10 m' then halt(2);
  writeln('* TEST-106: PASSED');

  // TEST-107 : QUANTUM TUNNELING
  U0      := 10*eV;
  Mass    := 511*keV/SquaredSpeedOfLight;

  // SubCase-1
  E1      := 7*eV;
  L1      := 5*nm;
  kfactor := SquareRoot(2*Mass*E1/SquarePower(ReducedPlanckConstant));
  bfactor := SquareRoot(2*Mass*(U0 - E1))/ReducedPlanckConstant;
  TunnelingProbability := (16*SquarePower(kfactor)*SquarePower(bfactor))/SquarePower(SquarePower(kfactor) + SquarePower(bfactor))*Exp(-2*bfactor*L1);

  if ReciprocalMeterUnit.ToString(bfactor, 3, 3, [pNano])        <> '8.87 1/nm' then halt(1);
  if Format('%0.3e', [ScalarUnit.ToFloat(TunnelingProbability)]) <> '9.75E-039' then halt(2);

  // SubCase-2
  E2      := 9*eV;
  L2      := 1*nm;
  kfactor := SquareRoot(2*Mass*E2/SquarePower(ReducedPlanckConstant));
  bfactor := SquareRoot(2*Mass*(U0 - E2))/ReducedPlanckConstant;
  TunnelingProbability := (16*(E2/U0)*(1-E2/U0))*Exp(-2*bfactor*L2);

  if ReciprocalMeterUnit.ToString(bfactor, 3, 3, [pNano])        <> '5.12 1/nm' then halt(1);
  if Format('%0.3e', [ScalarUnit.ToFloat(TunnelingProbability)]) <> '5.11E-005' then halt(2);
  writeln('* TEST-107: PASSED');

  writeln('ADIM-TEST DONE.');
end.
