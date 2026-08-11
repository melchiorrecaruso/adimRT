{
  Description: ADim Test program.

  Copyright (C) 2024-2026 Melchiorre Caruso <melchiorrecaruso@gmail.com>

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

program ADimTest;

uses
  ADimMath, ADim, ADimCL3, Math, SysUtils;

var
  side1: TRealQuantity;
  side2, side3, side4: TRealQuantity;
  area: TRealQuantity;
  volume: TRealQuantity;
  hypervolume: TRealQuantity;

  pressure: TRealQuantity;
  stiffness: TRealQuantity;

  squarecharge: TRealQuantity;
  capacitance: TRealQuantity;

  distance: TRealQuantity;
  tolerance: TRealQuantity;
  time: TRealQuantity;
  speed: TRealQuantity;
  spin: TRealQuantity;
  acc: TRealQuantity;
  density: TRealQuantity;
  specificw: TRealQuantity;
  force, normal: TRealQuantity;

  torque: TRealQuantity;
  work: TRealQuantity;
  power: TRealQuantity;

  charge: TRealQuantity;
  potential: TRealQuantity;
  current: TRealQuantity;

  flux: TRealQuantity;
  fluxdensity: TRealQuantity;

  inductance: TRealQuantity;
  resistance: TRealQuantity;
  conductance: TRealQuantity;

  solidangle: TRealQuantity;
  intensity: TRealQuantity;
  luminousflux: TRealQuantity;

  dose1: TRealQuantity;
  dose2: TRealQuantity;

  angularspeed: TRealQuantity;

  kA: TRealQuantity;
  kAr: TRealQuantity;
  radius: TRealQuantity;
  radius1: TRealQuantity;
  radius2: TRealQuantity;

  Mass: TRealQuantity;
  MassOfSun: TRealQuantity;
  MassOfSagittariusAStar: TRealQuantity;
  eta: TRealQuantity;
  Cb: TRealQuantity;

  mass1: TRealQuantity;
  mass2: TRealQuantity;

  cCd: TRealQuantity;
  angle: TRealQuantity;

  Uc: TRealQuantity;
  Ug: TRealQuantity;

  Ue: TRealQuantity;
  kx: TRealQuantity;
  x: TRealQuantity;

  q1: TRealQuantity;
  q2: TRealQuantity;
  Uel: TRealQuantity;
  U: TRealQuantity;

  p: TRealQuantity;
  p2: TRealQuantity;
  impulse: TRealQuantity;
  Lp: TRealQuantity;

  flowrate: TRealQuantity;

  lambda: TRealQuantity;
  deltadist: TRealQuantity;
  deltatemp: TRealQuantity;
  temp: TRealQuantity;

  specificheatcapacity: TRealQuantity;
  heatcapacity: TRealQuantity;

  _m1: TRealQuantity;
  _m2: TRealQuantity;
  _tf: TRealQuantity;
  _t1: TRealQuantity;
  _t2: TRealQuantity;
  _c1: TRealQuantity;
  _c2: TRealQuantity;

  lambda2: TRealQuantity;

  E: TRealQuantity;
  sigma: TRealQuantity;

  B: TRealQuantity;
  Bx: TRealQuantity;
  By: TRealQuantity;
  Bz: TRealQuantity;
  muB: TRealQuantity;
  len: TRealQuantity;
  r: TRealQuantity;
  z: TRealQuantity;
  loops: longint;

  i1, i2: TRealQuantity;
  magneticflux: TRealQuantity;

  DeltaE: TRealQuantity;

  Ampl: TRealQuantity;
  Kw: TRealQuantity;
  Omega: TRealQuantity;
  phi: TRealQuantity;

  wavelen: TRealQuantity;
  wavelenc: TRealQuantity;
  yspeed: TRealQuantity;
  yacc: TRealQuantity;

  E0: TRealQuantity;
  Energy: TRealQuantity;
  freq: TRealQuantity;

  I: TRealQuantity;
  Re: TRealQuantity;

  num: integer;
  alpha: TRealQuantity;
  kc: TRealQuantity;
  BoxLen: TRealQuantity;
  EnergyLevels: array[1..4] of TRealQuantity;
  SquarePsi: array[1..4] of TRealQuantity;
  Psi0: TRealQuantity;
  PsiValues: array [1..4] of TRealQuantity;
  A0: TRealQuantity;
  y: TRealQuantity;

  Iteration: longint;
  Iterations: longint;
  Probability: TRealQuantity;
  mu: TRealQuantity;

  ELV1, ELV2: TRealQuantity;
  L1, L2: TRealQuantity;

  kfactor: TRealQuantity;
  bfactor: TRealQuantity;
  U0: TRealQuantity;
  TunnelingProbability: TRealQuantity;

  side1_: TCL3VecQuantity;
  side2_: TCL3VecQuantity;
  area_: TCL3BivecQuantity;
  displacement_: TCL3VecQuantity;
  speed_: TCL3VecQuantity;
  acc_: TCL3VecQuantity;
  momentum_: TCL3VecQuantity;

  angle_: TCL3BivecQuantity;
  angularspeed_: TCL3BivecQuantity;
  angularacc_: TCL3BivecQuantity;
  radius_: TCL3VecQuantity;
  angularmomentum_: TCL3BivecQuantity;
  force_: TCL3VecQuantity;
  torque_: TCL3BivecQuantity;

  magneticfield_: TCL3BivecQuantity;
  magneticflux_: TCL3TrivecQuantity;
  current_: TCL3MultivecQuantity;
  pressure_: TCL3TrivecQuantity;

  torquestifness_: TCL3BivecQuantity;
  electricfield_: TCL3VecQuantity;
  omega_: TCL3BivecQuantity;
  impedance_: TCL3MultivecQuantity;
  power_: TCL3MultivecQuantity;

  acc__: TRealVectorQuantity;
  radius__: TRealVectorQuantity;
  force__: TRealVectorQuantity;
  momentum__: TRealVectorQuantity;
  angle__: TRealVectorQuantity;
  angularspeed__: TRealVectorQuantity;
  angularacc__: TRealVectorQuantity;
  angularmomentum__: TRealVectorQuantity;
  torque__: TRealVectorQuantity;
  magneticfield__: TRealVectorQuantity;
  area__: TRealVectorQuantity;
  omega__: TRealVectorQuantity;
  potential__: TComplexQuantity;
  impedance__: TComplexQuantity;
  current__: TComplexQuantity;
  power__: TComplexQuantity;

  H2, U2: TComplexMatrixQuantity;
  State, Coeff, EigenValues: TComplexVectorQuantity;
  EigenVectors: TComplexMatrix;
  StateValues: TComplexVector;
  PauliX, PauliZ: TComplexMatrix;

  x1, x2, x3: TRealVector;

  a_: TRealQuantity;
  H0: TRealQuantity;

begin
  ExitCode := 0;
  DefaultFormatSettings.DecimalSeparator := '.';
  writeln('ADim TEST STARTING ...');

  // TEST-00 - Area of a rectangle.
  // Exercise: compute A = a*b and then recover each side by division.  The
  // test shows that ADim propagates the length exponent and obtains an area.
  side1 := 10*m;
  side2 := 5*m;
  area  := side1*side2;
  side1 := area/side2;
  side2 := area/side1;

  if m.ToVerboseString(side1) <> '10 meters'        then halt(1);
  if m.ToVerboseString(side2) <> '5 meters'         then halt(2);
  if m2.ToVerboseString(area) <> '50 square meters' then halt(3);
  writeln('* TEST-00: PASSED');

  // TEST-01 - Volume of a rectangular parallelepiped.
  // Exercise: V = a*b*c.  Multiplying three lengths produces L^3; dividing
  // the volume by two sides must recover the remaining length.
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

  // TEST-02 - Four-dimensional hypervolume.
  // Exercise: H = a*b*c*d.  Although it has no ordinary spatial-volume
  // interpretation, this is a useful check of arbitrary integer exponents.
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

  // TEST-03 - Average speed.
  // Exercise: v = distance/time, followed by the inverse relations t = s/v
  // and s = v*t.  The result is displayed directly in kilometres per hour.
  distance := 20*km;
  time     := 2*hr;
  speed    := distance/time;
  time     := distance/speed;
  distance := speed*time;
  if MeterPerHourUnit.ToVerboseString(speed, 5, 0, [pKilo]) <> '10 kilometers per hour' then halt(1);
  if hourUnit.ToVerboseString(time)                         <> '2 hours'                then halt(2);
  if m.ToVerboseString(distance, 5, 0, [pKilo])             <> '20 kilometers'          then halt(3);
  writeln('* TEST-03: PASSED');

  // TEST-04 - Average acceleration and unit conversion.
  // Exercise: a = v/t.  The same quantity is formatted both as km/(h*s) and
  // as m/s^2, illustrating that units may differ while dimensions agree.
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

  // TEST-05 - Newton's second law.
  // Exercise: F = m*a, with the inverse relations m = F/a and a = F/m.
  // A newton is therefore the derived unit kg*m/s^2.
  mass  := 5*kg;
  acc   := 10*m/s2;
  force := mass*acc;
  mass  := force/acc;
  acc   := force/mass;
  if kg.ToVerboseString(mass,  5, 0, [])              <> '5 kilograms' then halt(1);
  if MeterPerSquareSecondUnit.ToString(acc, 5, 0, []) <> '10 m/s²'     then halt(2);
  if N.ToVerboseString(force, 5, 0, [])               <> '50 newtons'  then halt(3);
  writeln('* TEST-05: PASSED');

  // TEST-06 - Angular and tangential speed.
  // Exercise: omega = theta/t and v = omega*r.  In SI the radian is
  // dimensionless, but retaining its unit documents the geometric meaning.
  angle        := 5*rad;
  time         := 2*s;
  angularspeed := angle/time;
  radius       := 2*m;
  speed        := angularspeed*radius;
  angularspeed := speed/radius;
  if RadianPerSecondUnit.ToVerboseString(angularspeed, 5, 1, []) <> '2.5 radians per second' then halt(1);
  if MeterPerSecondUnit.ToVerboseString (speed, 5, 1, [])        <> '5 meters per second'    then halt(2);
  writeln('* TEST-06: PASSED');

  // TEST-07 - Centrifugal force in a rotating reference frame.
  // Exercise: v = omega*r, a = omega^2*r and F = m*a.  Its magnitude equals
  // the centripetal force, while its direction belongs to the rotating frame.
  mass         := 1*kg;
  angularspeed := 2*rad/s;
  radius       := 10*m;
  speed        := angularspeed*radius;
  acc          := (angularspeed*angularspeed)*radius;
  force        := mass*acc;
  if MeterPerSecondUnit.ToString(speed, 5, 0, [])     <> '20 m/s'  then halt(1);
  if MeterPerSquareSecondUnit.ToString(acc, 5, 0, []) <> '40 m/s²' then halt(2);
  if N.ToString(force, 5, 0, [])                      <> '40 N'    then halt(3);
  writeln('* TEST-07: PASSED');

  // TEST-08 - Centripetal force in uniform circular motion.
  // Exercise: verify the equivalent formulas F = m*omega^2*r and F = m*v^2/r,
  // where v = omega*r.  Both paths must yield the same physical dimension.
  mass         := 10*kg;
  radius       := 1*m;
  angularspeed := 2*rad/s;
  speed        := angularspeed*radius;
  force        := mass*(SquarePower(angularspeed)*radius);
  force        := mass*(SquarePower(speed)/radius);
  if MeterPerSecondUnit.ToString(speed, 5, 0, []) <> '2 m/s' then halt(1);
  if N.ToString(force, 5, 0, [])                  <> '40 N'  then halt(2);
  writeln('* TEST-08: PASSED');

  // TEST-09 - Mechanical pressure.
  // Exercise: p = F/A and the inverse relations F = p*A and A = F/p.
  // The pascal is a newton per square metre.
  force    := 10*N;
  area     := 5*m2;
  pressure := force/area;
  force    := pressure*area;
  area     := force/pressure;
  if Pa.ToString(pressure)  <> '2 Pa' then halt(1);
  if N.ToString(force)      <> '10 N' then halt(2);
  if m2.ToString(area)      <> '5 m²' then halt(3);
  writeln('* TEST-09: PASSED');

  // TEST-10 - Work done by a constant, collinear force.
  // Exercise: W = F*s (the general formula is W = F*s*cos(theta)).  The
  // numerical result is formatted with the deca prefix in compact and long form.
  force    := 10*N;
  distance := 5*m;
  work     := force*distance;
  if J.ToString(work, 5, 0, [pDeca])        <> '5 daJ'        then halt(1);
  if J.ToVerboseString(work, 5, 0, [pDeca]) <> '5 decajoules' then halt(2);
  writeln('* TEST-10: PASSED');

  // TEST-11 - Mean power from work and elapsed time.
  // Exercise: P = W/t.  One watt is one joule per second.
  work  := 50*J;
  time  := 10*s;
  power := work/time;
  if W.ToString(power, 5, 0, []) <> '5 W' then halt(1);
  writeln('* TEST-11: PASSED');

  // TEST-12 - Power in rotational motion.
  // Exercise: P = tau*omega for collinear torque and angular velocity, then
  // recover tau and omega by the inverse dimensional relations.
  torque       := 10*N*m;
  angularspeed := 2*rad/s;
  power        := torque*angularspeed;
  angularspeed := power/torque;
  torque       := power/angularspeed;
  if W.ToString(power, 5, 0, []) <> '20 W' then halt(1);
  writeln('* TEST-12: PASSED');

  // TEST-13 - Electric potential difference from energy per charge.
  // Exercise: V = W/Q.  One volt represents one joule transferred per coulomb.
  work      := 50*J;
  charge    := 25*C;
  potential := work/charge;
  if V.ToString(potential) <> '2 V'  then halt(1);
  if C.ToString(charge) <> '25 C' then halt(2);
  if J.ToString(work)     <> '50 J' then halt(3);
  writeln('* TEST-13: PASSED');

  // TEST-14 - Electric potential difference from power and current.
  // Exercise: since P = V*I, calculate V = P/I and check the original units.
  power     := 10*W;
  current   := 5*A;
  potential := power/current;
  if V.ToString(potential) <> '2 V'  then halt(1);
  if A.ToString(current)   <> '5 A'  then halt(2);
  if W.ToString(power)     <> '10 W' then halt(3);
  writeln('* TEST-14: PASSED');

  // TEST-15 - Voltage in a resistor from power and resistance.
  // Exercise: combining P = V*I with V = R*I gives V = sqrt(P*R).
  power      := 250*W;
  resistance := 10*Ohm;
  potential  := SquareRoot(power*resistance);
  if V.ToString(potential) <> '50 V' then halt(1);
  writeln('* TEST-15: PASSED');

  // TEST-16 - Current in a resistor from power and resistance.
  // Exercise: from P = I^2*R follows I = sqrt(P/R).
  power      := 4000*W;
  resistance := 10*Ohm;
  current    := SquareRoot(power/resistance);
  if A.ToString(current) <> '20 A' then halt(1);
  writeln('* TEST-16: PASSED');

  // TEST-17 - Capacitance as squared charge per energy.
  // Exercise: the identity F = C^2/J is dimensionally valid and follows from
  // J = C*V and F = C/V; this test is about derived-unit algebra.
  squarecharge := 25*C2;
  work         := 50*J;
  capacitance  := squarecharge/work;
  if F.ToString(capacitance) <> '0.5 F' then halt(1);
  writeln('* TEST-17: PASSED');

  // TEST-18 - Definition of capacitance.
  // Exercise: C_cap = Q/V.  One farad stores one coulomb per volt.
  charge      :=  10*C;
  potential   :=  5*V;
  capacitance := charge/potential;
  if F.ToVerboseString(capacitance) <> '2 farads' then halt(1);
  writeln('* TEST-18: PASSED');

  // TEST-19 - Magnetic flux from Faraday's law.
  // Exercise: for a constant induced voltage magnitude, Phi = V*t.  The sign
  // in Faraday's law describes orientation and is intentionally absent here.
  potential := 5*V;
  time      := 10*s;
  flux      := potential*time;
  if Wb.ToVerboseString(flux) <> '50 webers' then halt(1);
  writeln('* TEST-19: PASSED');

  // TEST-20 - Magnetic flux density.
  // Exercise: for a field normal to a flat surface, B = Phi/A.  Therefore
  // one tesla is one weber per square metre.
  flux        := 25*Wb;
  area        := 10*m2;
  fluxdensity := flux/area;
  if T.ToVerboseString(fluxdensity) <> '2.5 teslas' then halt(1);
  writeln('* TEST-20: PASSED');

  // TEST-21 - Inductance from linked magnetic flux.
  // Exercise: L = Phi/I in the linear, single-turn case; hence H = Wb/A.
  flux       := 30*Wb;
  current    := 10*A;
  inductance := flux/current;
  if H.ToString(inductance)        <> '3 H'       then halt(1);
  if H.ToVerboseString(inductance) <> '3 henries' then halt(2);
  writeln('* TEST-21: PASSED');

  // TEST-22 - Electrical conductance.
  // Exercise: G = 1/R.  The siemens is the reciprocal of the ohm.
  resistance  := 2*Ohm;
  conductance := 1/resistance;
  if Siemens.ToVerboseString(conductance) <> '0.5 siemens' then halt(1);
  writeln('* TEST-22: PASSED');

  // TEST-23 - Electric charge transported by a steady current.
  // Exercise: Q = I*t.  One coulomb is the charge carried by one ampere in one second.
  current := 5*A;
  time    := 5*s;
  charge  := current*time;
  if C.ToVerboseString(charge) <> '25 coulombs' then halt(1);
  if C.ToString(charge)        <> '25 C'        then halt(2);
  writeln('* TEST-23: PASSED');

  // TEST-24 - Luminous flux.
  // Exercise: Phi_v = I_v*Omega for uniform luminous intensity over a solid
  // angle.  The lumen is the candela-steradian derived unit.
  intensity    := 10*cd;
  solidangle   := 90*sr;
  luminousflux := intensity*solidangle;
  if lm.ToString(luminousflux) <> '900 lm' then halt(1);
  writeln('* TEST-24: PASSED');

  // TEST-25 - Absorbed dose and equivalent dose.
  // Exercise: gray and sievert both reduce dimensionally to J/kg = m^2/s^2.
  // Their identical dimensions do not make their physical meanings interchangeable.
  dose1 := 10*Sv;
  dose2 := 5 *Gy;
  dose1 := 10*m2/s2;
  dose2 := 5 *m2/s2;
  dose1 := 10*j/kg;
  dose2 := 5 *j/kg;
  if SquareMeterPerSquareSecondUnit.ToString(dose1) <> '10 m²/s²' then halt(1);
  if SquareMeterPerSquareSecondUnit.ToString(dose2) <> '5 m²/s²'  then halt(2);
  if Sv.ToString(dose1)                             <> '10 Sv'    then halt(3);
  if Gy.ToString(dose2)                             <> '5 Gy'     then halt(4);
  writeln('* TEST-25: PASSED');

  // TEST-26 - Linear stiffness.
  // Exercise: Hooke's law F = k*x gives k = F/x, measured in newtons per metre.
  force     := 50*N;
  distance  := 10*mm;
  stiffness := force/distance;
  if NewtonPerMeterUnit.ToString(stiffness) <> '5000 N/m' then halt(1);
  writeln('* TEST-26: PASSED');

  // TEST-27 - Mass density.
  // Exercise: rho = m/V and its inverse relations m = rho*V and V = m/rho.
  mass    := 10*kg;
  volume  := 5*m3;
  density := mass/volume;
  mass    := density*volume;
  volume  := mass/density;
  if KilogramPerCubicMeterUnit.ToString(density) <> '2 kg/m³' then halt(1);
  if Kg.ToString(mass)                           <> '10 kg'   then halt(2);
  if m3.ToString(volume)                         <> '5 m³'    then halt(3);
  writeln('* TEST-27: PASSED');

  // TEST-28 - Specific weight.
  // Exercise: gamma = F_g/V.  Unlike density, specific weight is force per
  // volume and therefore depends on the local gravitational acceleration.
  force     := 100*N;
  volume    := 10*m3;
  specificw := force/volume;
  force     := specificw*volume;
  volume    := force/specificw;
  if NewtonPerCubicMeterUnit.ToString(specificw) <> '10 N/m³' then halt(1);
  if N.ToString(force)                           <> '100 N'   then halt(2);
  if m3.ToString(volume)                         <> '10 m³'   then halt(3);
  writeln('* TEST-28: PASSED');

  // TEST-29 - Coulomb model of sliding friction.
  // Exercise: F_f = mu*N.  The friction coefficient mu is dimensionless.
  normal := 100*N;
  kA     := 0.05;
  force  := kA*normal;
  if N.ToString(force) <> '5 N' then halt(1);
  writeln('* TEST-29: PASSED');

  // TEST-30 - Simple rolling-resistance model.
  // Exercise: F_r = (b/r)*N, where b is a rolling-resistance length and r is
  // the wheel radius; their ratio is dimensionless.
  normal := 100*N;
  kAr    := 0.0005*m;
  radius := 50*mm;
  force  := kAr*normal/radius;
  if N.ToString(force) <> '1 N' then halt(1);
  writeln('* TEST-30: PASSED');

  // TEST-31 - Stokes drag in laminar flow.
  // Exercise: F = 6*pi*eta*r*v for a sphere at low Reynolds number.  The
  // preceding shear estimate also demonstrates the dimensions eta*A/(r/v).
  eta    := 10*Pa*s;
  radius := 20*mm;
  side1  := 1*m;
  area   := 2*radius*side1;
  speed  := 0.5*m/s;
  force  := eta/(radius/speed)*area;
  force  := 6*pi*radius*eta*speed;
  if N.ToString(force, 4, 2, []) <> '1.885 N' then halt(1);
  writeln('* TEST-31: PASSED');

  // TEST-32 - Quadratic aerodynamic drag.
  // Exercise: F_d = (1/2)*C_d*rho*A*v^2.  C_d is dimensionless; density,
  // area and squared speed combine automatically into a force.
  cCd     := 0.47;
  area    := 1000*mm2;
  speed   := 5*m/s;
  density := 1.225*kg/m3;
  force   := 0.5*cCd*(density*SquarePower(Speed))*area;
  if N.ToString(force, 4, 2, [])                           <> '0.007197 N'  then halt(1);
  if KilogramPerCubicMeterUnit.ToString(density, 4, 2, []) <> '1.225 kg/m³' then halt(2);
  writeln('* TEST-32: PASSED');

  // TEST-33 - Newton's law of universal gravitation.
  // Exercise: F = G*m1*m2/r^2, using Earth-Moon data as a numerical example.
  mass1    := 5.97219E24*kg;
  mass2    := 7.342E22*kg;
  distance := 384400*km;
  force    := NewtonianConstantOfGravitation*(mass1*mass2)/(distance*distance);
  if N.ToString(force, 4, 2, []) <> '1.981E20 N' then halt(1);
  writeln('* TEST-33: PASSED');

  // TEST-34 - Gravitational potential energy near Earth's surface.
  // Exercise: U_g = m*g*h, the constant-g approximation valid for h much
  // smaller than Earth's radius.
  mass     := 10*kg;
  distance := 10*m;
  Ug       := mass*StandardAccelerationOfGravity*distance;
  if J.ToString(Ug, 4, 2, []) <> '980.7 J' then halt(1);
  writeln('* TEST-34: PASSED');

  // TEST-35 - Translational kinetic energy.
  // Exercise: K = (1/2)*m*v^2.  This corrects the old title: kinetic energy is
  // energy of motion, not a form of potential energy.
  mass  := 10*kg;
  speed := 5*m/s;
  Uc    := 1/2*mass*(speed*speed);
  if J.ToString(Uc, 4, 2, []) <> '125 J' then halt(1);
  writeln('* TEST-35: PASSED');

  // TEST-36 - Elastic potential energy of an ideal spring.
  // Exercise: U_e = (1/2)*k*x^2, obtained by integrating Hooke's law F = k*x.
  kx       := 10*N/m;
  distance := 10*m;
  Ue       := 0.5*kx*(distance*distance);
  if J.ToString(Ue, 4, 2, []) <> '500 J' then halt(1);
  writeln('* TEST-36: PASSED');

  // TEST-37 - Linear momentum and kinetic energy.
  // Exercise: p = m*v and K = p^2/(2*m).  The intermediate p^2 check also
  // exercises products of quantities with already-derived dimensions.
  mass  := 10*kg;
  speed := 5*m/s;
  p     := mass*speed;
  p     := 50*kg*m/s;
  p2    := p*p;
  Uc    := 0.5*p2/mass;
  if KilogramMeterPerSecondUnit.ToString(p, 4, 2, [])                    <> '50 kg∙m/s'      then halt(1);
  if SquareKilogramSquareMeterPerSquareSecondUnit.ToString(p2, 4, 2, []) <> '2500 kg²∙m²/s²' then halt(2);
  writeln('* TEST-37: PASSED');

  // TEST-38 - Impulse of a constant force.
  // Exercise: J_imp = F*Delta t = Delta p.  Momentum and impulse therefore
  // have the same dimensions even though they describe different concepts.
  force   := 10*N;
  time    := 5*ms;
  impulse := p;
  impulse := force*time;
  if NewtonSecondUnit.ToString(impulse, 4, 2, [pNone, pMilli]) <> '50 N∙ms' then halt(1);
  writeln('* TEST-38: PASSED');

  // TEST-39 - Hydrostatic pressure (Stevin's law).
  // Exercise: Delta p = rho*g*h for an incompressible fluid at rest.
  density  := 10*kg/m3;
  distance := 2*m;
  pressure := density*StandardAccelerationOfGravity*distance;
  if Pa.ToString(pressure, 4, 2, []) <> '196.1 Pa' then halt(1);
  writeln('* TEST-39: PASSED');

  // TEST-40 - Archimedes' principle.
  // Exercise: the buoyant-force magnitude is F_b = rho_fluid*g*V_displaced.
  density := 0.5*kg/m3;
  volume  := 0.5*m3;
  force   := density*StandardAccelerationOfGravity*volume;
  if N.ToString(force, 4, 2, []) <> '2.452 N' then halt(1);
  writeln('* TEST-40: PASSED');

  // TEST-41 - Volumetric flow rate.
  // Exercise: Q_v = V/t.  This is the basic quantity used by the continuity
  // equation; for steady incompressible flow it is constant along a pipe.
  volume   := 50*m3;
  time     := 10*s;
  flowrate := volume/time;
  if CubicMeterPerSecondUnit.ToString(flowrate, 4, 2, []) <> '5 m³/s' then halt(1);
  writeln('* TEST-41: PASSED');

  // TEST-42 - Pressure terms in Bernoulli's equation.
  // Exercise: evaluate dynamic pressure rho*v^2/2 and hydrostatic pressure
  // rho*g*h separately; both terms have the same pressure dimension.
  density  := 5*kg/m3;
  speed    := 5*m/s;
  pressure := 1/2*density*(speed*speed);
  if Pa.ToString(pressure, 4, 2, []) <> '62.5 Pa' then halt(1);

  distance := 2*m;
  pressure := density*StandardAccelerationOfGravity*distance;
  if Pa.ToString(pressure, 4, 2, []) <> '98.07 Pa' then halt(2);
  writeln('* TEST-42: PASSED');

  // TEST-43 - Reynolds number.
  // Exercise: Re = rho*v*D/eta is dimensionless.  Here the relation is solved
  // for v with pipe diameter D = 2*r at the conventional transition value 2000.
  flowrate := 5*dm3/minute;
  density  := 1.05*g/cm3;
  eta      := 0.003*Pl;
  radius   := 0.9*cm;
  Re       := 2000;
  speed    := Re*eta/(2*density*radius);
  if MeterPerSecondUnit.ToString(speed, 4, 2, []) <> '0.3175 m/s' then halt(1);
  writeln('* TEST-43: PASSED');

  // TEST-44 - Linear thermal expansion.
  // Exercise: Delta L = alpha*L*Delta T.  The expansion coefficient has unit
  // K^-1, so the temperature interval cancels and the result is a length.
  distance  := 10*m;
  lambda    := 1.2E-5/K;
  deltatemp := 100*K;
  deltadist := distance*(lambda*deltatemp);
  if m.ToString(deltadist, 4, 2, [pMilli]) <> '12 mm' then halt(1);
  writeln('* TEST-44: PASSED');

  // TEST-45 - Heat capacity of a body.
  // Exercise: C = m*c, where c is the specific heat capacity in J/(kg*K).
  mass                 := 10*kg;
  specificheatcapacity := 7.5*J/kg/K;
  heatcapacity         := mass*specificheatcapacity;
  if JoulePerKelvinUnit.ToString(heatcapacity, 4, 2, []) <> '75 J/K' then halt(1);
  writeln('* TEST-45: PASSED');

  // TEST-46 - Thermal equilibrium in an ideal calorimeter.
  // Exercise: conservation of energy gives Tf = sum(m_i*c_i*T_i)/sum(m_i*c_i)
  // when the calorimeter is isolated and no phase transition occurs.
  _m1 := 10*kg;
  _t1 := 100*K;
  _c1 := 7.5*J/kg/K;
  _m2 := 10*kg;
  _t2 := 50*K;
  _c2 := 7.5*J/kg/K;
  _tf := (_m1*_c1*_t1+_m2*_c2*_t2) / (_m1*_c1+_m2*_c2);
  if K.ToString(_tf, 4, 2, []) <> '75 K' then halt(1);
  writeln('* TEST-46: PASSED');

  // TEST-47 - Heat-conduction power through a plane wall.
  // Exercise: Fourier's law in magnitude is P = lambda*A*Delta T/L for a
  // homogeneous slab in stationary one-dimensional conduction.
  area      := 5*m2;
  side1     := 100*mm;
  lambda2   := 1.1*W/m/K;
  deltatemp := 15*K;
  power     := lambda2*(deltatemp/side1)*area;
  if W.ToString(power, 4, 2, []) <> '825 W' then halt(1);
  writeln('* TEST-47: PASSED');

  // TEST-48 - Electrostatic potential energy of two point charges.
  // Exercise: U = k_e*q1*q2/r.  The distance is initialized locally so that
  // this example is independent of all preceding test cases.
  q1  := 6E-6*C;
  q2  := 9E-6*C;
  distance := 10*m;
  Uel := CoulombConstant*(q1*q2/distance);
  if J.ToString(Uel, 4, 2, [pMilli]) <> '48.53 mJ' then halt(1);
  writeln('* TEST-48: PASSED');

  // TEST-49 - Electric force on a point charge.
  // Exercise: the electric part of the Lorentz force is F = q*E.  The charge
  // sign determines direction; this scalar example checks the magnitude.
  E     := 0.0015*N/C;
  q1    := ElectronCharge;
  force := E*q1;
  if N.ToString(force, 4, 2, [pYocto]) <> '240.3 yN' then halt(1);
  writeln('* TEST-49: PASSED');

  // TEST-50 - Coulomb force between two point charges.
  // Exercise: F = k_e*q1*q2/r^2.  This scalar form verifies the magnitude;
  // a vector treatment would additionally encode the line joining the charges.
  q1       := 6E-6*C;
  q2       := 9E-6*C;
  distance := 2*m;
  force    := CoulombConstant*(q1*q2)/(distance*distance);
  if N.ToString(force, 4, 2, [pMilli]) <> '121.3 mN' then halt(1);
  writeln('* TEST-50: PASSED');

  // TEST-51 - Electric field generated by one point charge.
  // Exercise: E = k_e*q/r^2.  N/C and V/m are equivalent SI derived units.
  q1 := 2*C;
  r  := 5*cm;
  E  := CoulombConstant*(q1/SquarePower(r));
  if VoltPerMeterUnit.ToString(E, 4, 2, [pMega, pMilli]) <> '7190 MV/mm' then halt(1);
  writeln('* TEST-51: PASSED');

  // TEST-52 - Electric field inside a uniformly charged sphere.
  // Exercise: for r < R, Gauss's law gives E = k_e*Q*r/R^3, so the field
  // grows linearly from the centre rather than following the external 1/r^2 law.
  q1       := 2*C;
  r        := 10*cm;
  distance := 5*cm;
  E        := CoulombConstant*(q1/ (CubicPower(r)/distance));
  if VoltPerMeterUnit.ToString(E, 4, 2, [pMega, pMilli]) <> '898.8 MV/mm' then halt(1);
  writeln('* TEST-52: PASSED');

  // TEST-53 - Electric field between ideal parallel conducting plates.
  // Exercise: E = sigma/epsilon_0 with surface density sigma = Q/A, neglecting
  // edge effects.  The calculation also checks compound division of quantities.
  q1    := 2*C;
  Area  := 4*cm2;
  sigma := q1/Area;
  E     := sigma/ElectricPermittivity;
  if VoltPerMeterUnit.ToString(E, 4, 2, [pGiga, pMilli]) <> '564.7 GV/mm' then halt(1);
  writeln('* TEST-53: PASSED');

  // TEST-54 - Current required to lift a conductor magnetically.
  // Exercise: balance the weight m*g with F_B = I*L*B*sin(theta), then solve
  // I = m*g/(L*B*sin(theta)) for a conductor perpendicular to the field.
  mass    := 100*g;
  len     := 20*cm;
  B       := 2.0*T;
  current := (mass*StandardAccelerationOfGravity)/(len*B*Sin(90*deg));
  if A.ToString(current, 4, 2, [pMilli]) <> '2452 mA' then halt(1);
  writeln('* TEST-54: PASSED');

  // TEST-55 - Magnetic field on the axis of a circular current loop.
  // Exercise: B(z) = mu_0*I*R^2/[2*(R^2+z^2)^(3/2)].  At z = 0 this reduces
  // to B = mu_0*I/(2*R); the old title incorrectly referred to a straight wire.
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

  // TEST-56 - Magnetic field inside an ideal solenoid.
  // Exercise: B = mu_0*(N/L)*I, valid near the centre of a long air-core solenoid.
  current  := 1600*A;
  loops    := 2000;
  len      := 2.0*m;
  B        := MagneticPermeability*loops*(current/len);
  if T.ToVerboseString(B, 4, 2, []) <> '2.011 teslas' then halt(1);
  writeln('* TEST-56: PASSED');

  // TEST-57 - Force between two long parallel conductors.
  // Exercise: F = mu_0*I1*I2*L/(2*pi*r).  Equal current directions attract;
  // opposite directions repel, while this test checks only the magnitude.
  i1    := 2.5*A;
  i2    := 1.5*A;
  r     := 4*cm;
  len   := 1.0*m;
  force := (MagneticPermeability/(2*pi)*(len/r)) * (i1*i2);
  if N.ToVerboseString(force, 4, 2, [pMicro]) <> '18.75 micronewtons' then halt(1);
  writeln('* TEST-57: PASSED');

  // TEST-58 - Magnetic flux through a plane surface.
  // Exercise: Phi = B*A*cos(theta) for a uniform field, where theta is the
  // angle between the field and the surface normal.
  B            := 0.4*T;
  Area         := 100*cm2;
  angle        := 70*deg;
  magneticflux := B*Area*cos(angle);
  if Wb.ToVerboseString(magneticflux, 4, 2, [pMicro]) <> '1368 microwebers' then halt(1);
  writeln('* TEST-58: PASSED');

  // TEST-59 - Electromagnetic induction.
  // Exercise: Faraday's law gives |emf| = |Delta Phi/Delta t| for one turn.
  // The omitted minus sign is Lenz's-law information about orientation.
  magneticflux := 6*1E-5*Wb;
  time         := 0.1*s;
  potential    := magneticflux/time;
  if V.ToVerboseString(potential, 4, 2, [pMicro]) <> '600 microvolts' then halt(1);
  writeln('* TEST-59: PASSED');

  // TEST-60 - Maxwell displacement current.
  // Exercise: I_d = epsilon_0*A*Delta E/Delta t for a uniform changing field.
  // It has the same ampere dimension as conduction current.
  Area     := 100*cm2;
  DeltaE   := 6.0E10*N/C;
  time     := 1*s;
  current  := (ElectricPermittivity*DeltaE*Area)/time;
  if A.ToVerboseString(current, 4, 2, [pMicro]) <> '5313 microamperes' then halt(1);
  writeln('* TEST-60: PASSED');

  // TEST-61 - Travelling harmonic wave.
  // Exercise: y = A*sin(k*x-omega*t+phi), then differentiate with respect to
  // time to obtain transverse velocity and acceleration; power is checked too.
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
  if MeterPerSquareSecondUnit.ToString(yacc, 4, 2, []) <> '-7255 m/s²' then halt(3);
  if W.ToString(power, 4, 2, [pMilli])                 <> '128 mW'     then halt(4);
  writeln('* TEST-61: PASSED');

  // TEST-62 - Relativistic rest energy.
  // Exercise: E_0 = m*c^2.  The same energy is rendered in joules and electronvolts.
  mass       := 1*kg;
  energy     := mass*SquarePower(SpeedOfLight);
  if ElectronVoltUnit.ToString(energy, 4, 2, [pTera]) <> '5.61E23 TeV' then halt(1);
  if J.ToString(energy, 4, 2, [pTera])                <> '8.988E4 TJ'  then halt(2);
  writeln('* TEST-62: PASSED');

  // TEST-63 - Relativistic energy-momentum relation.
  // Exercise: E^2 = (p*c)^2 + (m*c^2)^2.  The sample uses p = m*v only to
  // construct a small-velocity momentum before applying the exact energy relation.
  mass       := ElectronMass;
  speed      := 10800000*km/hr;
  p          := mass*speed;
  energy     := SquareRoot(SquarePower(p*SpeedOfLight)+ SquarePower(mass*SquarePower(SpeedOfLight)));
  if KilogramMeterPerSecondUnit.ToString(p, 4, 2, [pPico, pPico, pNone]) <> '2733 pg∙pm/s' then halt(1);
  if ElectronVoltUnit.ToString(energy, 4, 2, [pKilo])                    <> '511 keV'      then halt(2);
  writeln('* TEST-63: PASSED');

  // TEST-64 - Photon energy and momentum.
  // Exercise: E = h*c/lambda and p = h/lambda.  The separate v = lambda*f
  // calculation illustrates the general wave relation with the chosen frequency.
  len    := 1*mim;
  freq   := 1*Hz;
  energy := PlanckConstant/(len/SpeedOfLight);
  p      := PlanckConstant*freq/SpeedOfLight;
  p      := PlanckConstant/len;
  speed  := len*freq;
  if ElectronVoltUnit.ToString(energy, 4, 2, [])                         <> '1.24 eV'        then halt(1);
  if KilogramMeterPerSecondUnit.ToString(p, 4, 2, [pPico, pPico, pNone]) <> '0.6626 pg∙pm/s' then halt(2);
  if MeterPerSecondUnit.ToString(speed, 9, 2, [pPico, pNone])            <> '1000000 pm/s'   then halt(3);
  writeln('* TEST-64: PASSED');

  // TEST-65 - Newtonian form of Kepler's third law.
  // Exercise: T = sqrt(4*pi^2*a^3/[G*(M+m)]) for a two-body circular-orbit
  // approximation; Earth-Sun data should give approximately one year.
  mass1    := 1.989E30*kg;
  mass2    := 5.972E24*kg;
  distance := 1*au;
  time     := SquareRoot( 4*Sqr(pi)*CubicPower(distance)/(NewtonianConstantOfGravitation*(mass1+mass2)));
  if DayUnit.ToString(time, 5, 0, []) <> '365.2 d' then halt(1);
  writeln('* TEST-65: PASSED');

  // TEST-66 - Gravitational acceleration at Earth's surface.
  // Exercise: g = G*M/R^2, obtained from Newtonian gravitation per unit test mass.
  mass     := 5.972E24*kg;
  distance := 6.373E6*m;
  acc      := NewtonianConstantOfGravitation*mass/SquarePower(distance);
  if MeterPerSquareSecondUnit.ToString(acc, 3, 2, []) <> '9.81 m/s²' then halt(1);
  writeln('* TEST-66: PASSED');

  // TEST-67 - Undamped simple harmonic oscillator.
  // Exercise: omega_0 = sqrt(k/m) for an ideal mass-spring system.
  mass  := 1*kg;
  kx    := 10*N/m;
  omega := SquareRoot(kx/mass);
  if RadianPerSecondUnit.ToString(omega, 3, 2, []) <> '3.16 rad/s' then halt(1);
  writeln('* TEST-67: PASSED');

  // TEST-68 - Parameters of a damped harmonic oscillator.
  // Exercise: the code declares the damping coefficient but computes only the
  // undamped natural frequency omega_0 = sqrt(k/m), not the damped frequency.
  mass   := 1*kg;
  kx     := 10*N/m;
  Cb     := 10*Pa*s*m;
  omega  := SquareRoot(kx/mass);
  if RadianPerSecondUnit.ToString(omega, 3, 2, []) <> '3.16 rad/s' then halt(1);
  writeln('* TEST-68: PASSED');

  // TEST-69 - Small oscillations of a physical pendulum.
  // Exercise: T = 2*pi*sqrt(I/(m*g*d)), with I about the pivot and d the
  // pivot-to-centre-of-mass distance.  It follows from the small-angle equation.
  mass   := 1*kg;
  I      := 10*kg*m2;
  radius := 20*cm;
  time   := 2*pi*SquareRoot(1/((mass*StandardAccelerationOfGravity*radius)/I));
  time   := 2*pi*SquareRoot(I/(mass*StandardAccelerationOfGravity*radius));
  if s.ToString(time, 4, 2, []) <> '14.19 s' then halt(1);
  writeln('* TEST-69: PASSED');

  // TEST-70 - Convert one milligram to kilograms.
  // Prefixes scale the numeric value: 1 mg = 10^-6 kg.
  if kg.ToString(1.0*mg, 10, 10, [pKilo]) <> '1E-6 kg' then halt(01);
  writeln('* TEST-70: PASSED');

  // TEST-71 - Convert a squared mass unit.
  // Squaring also squares the scale factor: 1 mg^2 = 10^-12 kg^2.
  if kg2.ToString(1.0*mg2, 10, 0, [pKilo]) <> '1E-12 kg²' then halt(02);
  writeln('* TEST-71: PASSED');

  // TEST-72 - Express one milligram using the mega prefix.
  // Since 1 Mg = 10^9 mg, the same mass is 10^-9 Mg.
  if kg.ToString(1.0*mg, 10, 10, [pMega]) <> '1E-9 Mg' then halt(03);
  writeln('* TEST-72: PASSED');

  // TEST-73 - Square of a prefixed mass conversion.
  // The 10^-9 conversion from mg to Mg becomes 10^-18 after squaring.
  if kg2.ToString(1.0*mg2, 10, 0, [pMega]) <> '1E-18 Mg²' then halt(04);
  writeln('* TEST-73: PASSED');

  // TEST-74 - Render a kilogram in unprefixed grams.
  // Choosing pNone requests the base gram symbol, so 1 kg is shown as 1000 g.
  if kg.ToString(1.0*kg, 10, 0, [pNone]) <> '1000 g' then halt(05);
  writeln('* TEST-74: PASSED');

  // TEST-75 - Render a kilogram with its natural kilo prefix.
  // No numerical rescaling is needed when source and requested unit coincide.
  if kg.ToString(1.0*kg, 10, 0, [pKilo]) <> '1 kg' then halt(06);
  writeln('* TEST-75: PASSED');

  // TEST-76 - Render square kilograms as square grams.
  // (10^3 g)^2 = 10^6 g^2, an important rule for prefixed powered units.
  if kg2.ToString(1.0*kg2, 10, 0, [pNone]) <> '1000000 g²' then halt(07);
  writeln('* TEST-76: PASSED');

  // TEST-77 - Preserve square kilograms in compact notation.
  // The exponent belongs to the whole prefixed unit: kg^2 means (kg)^2.
  if kg2.ToString(1.0*kg2, 10, 0, [pKilo]) <> '1 kg²' then halt(08);
  writeln('* TEST-77: PASSED');

  // TEST-78 - Convert kilometres to metres.
  // A kilo prefix supplies the scale factor 10^3.
  if m.ToString(1.0*km, 10, 0, []) <> '1000 m' then halt(09);
  writeln('* TEST-78: PASSED');

  // TEST-79 - Convert square kilometres to square metres.
  // 1 km^2 = (10^3 m)^2 = 10^6 m^2.
  if m2.ToString(1.0*km2, 10, 0, []) <> '1000000 m²' then halt(10);
  writeln('* TEST-79: PASSED');

  // TEST-80 - Verbose mass formatting.
  // This repeats TEST-74 while exercising the long unit name and plural form.
  if kg.ToVerboseString(1.0*kg, 10, 0, [pNone]) <> '1000 grams' then halt(11);
  writeln('* TEST-80: PASSED');

  // TEST-81 - Verbose formatting of a squared mass unit.
  // The formatter must describe both the exponent and the plural unit name.
  if kg2.ToVerboseString(1.0*kg2, 10, 0, [pNone]) <> '1000000 square grams' then halt(12);
  writeln('* TEST-81: PASSED');
  // TEST-82 - Verbose length conversion.
  // One kilometre is rendered as 1000 metres using the long unit name.
  if m.ToVerboseString(1.0*km, 10, 0, []) <> '1000 meters' then halt(13);
  writeln('* TEST-82: PASSED');

  // TEST-83 - Verbose area conversion.
  // The formatter applies the prefix factor to the second power.
  if m2.ToVerboseString(1.0*km2, 10, 0, []) <> '1000000 square meters' then halt(14);
  writeln('* TEST-83: PASSED');

  // TEST-84 - Verbose volume conversion.
  // 1 km^3 = 10^9 m^3 because the length scale is raised to the third power.
  if m3.ToVerboseString(1.0*km3, 10, 0, []) <> '1000000000 cubic meters' then halt(15);
  writeln('* TEST-84: PASSED');

  // TEST-85 - Verbose fourth-power length conversion.
  // 1 km^4 = 10^12 m^4, extending the same exponent rule beyond ordinary volume.
  if m4.ToVerboseString(1.0*km4, 10, 0, []) <> '1E12 quartic meters' then halt(16);
  writeln('* TEST-85: PASSED');

  // TEST-86 - Convert one day to seconds in verbose notation.
  // 1 d = 24 h and 1 h = 3600 s, hence 86400 s.
  if s.ToVerboseString(1.0*day, 10, 0, []) <> '86400 seconds' then halt(16);
  writeln('* TEST-86: PASSED');

  // TEST-87 - Convert one hour to seconds in verbose notation.
  // This exercises a non-decimal conversion factor rather than an SI prefix.
  if s.ToVerboseString(1.0*hr, 10, 0, []) <> '3600 seconds' then halt(17);
  writeln('* TEST-87: PASSED');

  // TEST-88 - Convert one day to compact second notation.
  // The numerical conversion is the same as TEST-86; only formatting changes.
  if s.ToString(1.0*day, 10, 0, []) <> '86400 s' then halt(18);
  writeln('* TEST-88: PASSED');

  // TEST-89 - Convert one hour to compact second notation.
  // This checks the abbreviated symbol path of the unit formatter.
  if s.ToString(1.0*hr, 10, 0, []) <> '3600 s' then halt(19);
  writeln('* TEST-89: PASSED');

  // TEST-90 - Convert a squared day to square seconds, verbosely.
  // Squaring 86400 seconds gives 7464960000 square seconds.
  if s2.ToVerboseString(1.0*day2, 10, 0, []) <> '7464960000 square seconds' then halt(20);
  writeln('* TEST-90: PASSED');

  // TEST-91 - Convert a squared hour to square seconds, verbosely.
  // The scale is squared: (3600 s)^2 = 12960000 s^2.
  if s2.ToVerboseString(1.0*hr2, 10, 0, []) <> '12960000 square seconds' then halt(21);
  writeln('* TEST-91: PASSED');

  // TEST-92 - Compact formatting of a squared day.
  // The test pairs powered non-SI conversion with the compact exponent symbol.
  if s2.ToString(1.0*day2, 10, 0, []) <> '7464960000 s²' then halt(22);
  writeln('* TEST-92: PASSED');

  // TEST-93 - Compact formatting of a squared hour.
  // This closes the conversion group with the abbreviated square-second unit.
  if s2.ToString(1.0*hr2, 10, 0, []) <> '12960000 s²' then halt(23);
  writeln('* TEST-93: PASSED');

  // TEST-94 - Energy and charge expressed with hour-based units.
  // Exercise: 1 J = 1 W*s = 1/3600 W*h and, analogously,
  // 1 C = 1 A*s = 1/3600 A*h.  Milli prefixes make both values convenient.
  if WattHourUnit.ToString(1.0*J, 4, 0, [pMilli])   <> '0.2778 mW∙h' then halt(1);
  if AmpereHourUnit.ToString(1.0*C, 4, 0, [pMilli]) <> '0.2778 mA∙h' then halt(2);
  writeln('* TEST-94: PASSED');

  // TEST-95 - Hertz and radians per second.
  // Exercise: both reduce to reciprocal seconds, so ADim accepts assignments
  // between them.  Physically omega = 2*pi*f, which remains the user's responsibility.
  omega := 10*rad/s;
  omega := 10*Hz;
  freq  := 10*rad/s;
  freq  := 10*Hz;
  omega := freq;
  freq  := omega;
  if Hz.ToString(omega)                 <> '10 Hz'    then halt(1);
  if RadianPerSecondUnit.ToString(freq) <> '10 rad/s' then halt(2);
  writeln('* TEST-95: PASSED');

  // TEST-96 - Measurement with absolute uncertainty.
  // Exercise: format x +/- Delta x, requiring value and uncertainty to have
  // the same physical dimension and requested display unit.
  distance  := 10.5*mm;
  tolerance := 0.2*mm;
  if Utf8ToAnsi(m.ToString(distance, tolerance, 5, 5, [pMilli]))        <> Utf8ToAnsi('10.5 ± 0.2 mm')          then halt(1);
  if Utf8ToAnsi(m.ToVerboseString(distance, tolerance, 5, 5, [pMilli])) <> Utf8ToAnsi('10.5 ± 0.2 millimeters') then halt(2);
  writeln('* TEST-96: PASSED');

  // TEST-97 - Approximate equality of floating-point quantities.
  // Exercise: SameValueEx accepts the difference at 10^-13 but rejects larger
  // perturbations, documenting the library's default numerical tolerance.
  distance := 5.0*m;
  if SameValueEx(distance, (5.0+1E-13)*m) = False then halt(1);
  if SameValueEx(distance, (5.0+1E-12)*m) = True  then halt(2);
  if SameValueEx(distance, (5.0+1E-11)*m) = True  then halt(3);
  writeln('* TEST-97: PASSED');

  // TEST-98 - Minimum and maximum of homogeneous quantities.
  // Exercise: ordering is meaningful only for values of the same dimension;
  // Min and Max retain the complete length quantity, not just its scalar value.
  if Min(5.0*m, 6.0*m) <> (5.0*m) then halt(1);
  if Max(5.0*m, 6.0*m) <> (6.0*m) then halt(2);
  writeln('* TEST-98: PASSED');

  // TEST-99 - Compton wavelength of the electron.
  // Exercise: lambda_C = h/(m_e*c).  The computed value is compared with the
  // physical constant already supplied by the library.
  wavelenc := PlanckConstant/(ElectronMass*SpeedOfLight);
  if SameValueEx(wavelenc, ComptonWaveLength) <> TRUE then halt(1);
  writeln('* TEST-99: PASSED');

  // TEST-100 - Bohr model of the hydrogen ground state.
  // Exercise: derive the orbital speed, radius, angular momentum and binding
  // energy from Coulomb attraction and L = n*hbar, showing equivalent formulas.
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

  if SameValueEx(radius ,BohrRadius)               <> TRUE          then halt(1);
  if m.ToString(radius, 4, 4, [])                  <> '5.292E-11 m' then halt(2);
  if MeterPerSecondUnit.ToString(speed, 4, 4, [])  <> '2.188E6 m/s' then halt(3);
  if ElectronVoltUnit.ToString(energy, 3, 3, [])   <> '-13.6 eV'    then halt(4);
  if RydbergUnit.ToString(energy, 3, 3, [])        <> '-1 Ry'       then halt(5);
  writeln('* TEST-100: PASSED');

  // TEST-101 - Planck, de Broglie and free-particle relations.
  // Exercise: connect lambda, k, p, frequency, omega and energy through
  // p = hbar*k, E = h*f = hbar*omega and E = p^2/(2*m) in the nonrelativistic case.
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

  // TEST-102 - Stationary states of a particle in a one-dimensional box.
  // Exercise: E_n = n^2*pi^2*hbar^2/(2*m*L^2) and
  // psi_n(x) = sqrt(2/L)*sin(n*pi*x/L).  A normalized wavefunction has unit m^-1/2.
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
  writeln('* TEST-102: PASSED');

  // TEST-103 - Numerical normalization of the box eigenstates.
  // Exercise: approximate integral_0^L |psi_n(x)|^2 dx with a rectangular sum.
  // Probability is dimensionless because |psi|^2 has unit 1/m and dx has unit m.
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

  // TEST-104 - Quantum harmonic oscillator.
  // Exercise: omega = sqrt(k/m), E_n = (n+1/2)*hbar*omega and the ground state
  // is a normalized Gaussian; higher states introduce Hermite polynomials.
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

  PsiValues[1]    := A0*(  Sqr(2.0)*(  y         ))*QuarticRoot(mass*omega/pi/ReducedPlanckConstant);
  PsiValues[2]    := A0*(1/Sqr(2)*(2*y*y   -1  ))*QuarticRoot(mass*omega/pi/ReducedPlanckConstant);
  PsiValues[3]    := A0*(1/Sqr(3)*(2*y*y*y -3*y))*QuarticRoot(mass*omega/pi/ReducedPlanckConstant);
  writeln('* TEST-104: PASSED');

  // TEST-105 - Spin magnetic moment in a Stern-Gerlach setting.
  // Exercise: rewrite the electron magnetic moment in equivalent forms and
  // evaluate the interaction energy U = mu*B in an external magnetic field.
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

  // TEST-106 - Schwarzschild radius.
  // Exercise: r_s = 2*G*M/c^2 for a non-rotating, uncharged mass.  The Sun and
  // Sagittarius A* illustrate the linear dependence of the radius on mass.
  MassOfSun              := 1.9884E+30*kg;
  MassOfSagittariusAStar := 4.297E6 * MassOfSun;
  radius1                := 2*(MassOfSun*NewtonianConstantOfGravitation)/SquarePower(SpeedOfLight);
  radius2                := 2*(MassOfSagittariusAStar*NewtonianConstantOfGravitation)/SquarePower(SpeedOfLight);
  if m.ToString(radius1, 5, 5, [pKilo]) <> '2.9532 km'  then halt(1);
  if m.ToString(radius2, 5, 5, [])      <> '1.269E10 m' then halt(2);
  writeln('* TEST-106: PASSED');

  // TEST-107 - Quantum tunnelling through a rectangular barrier.
  // Exercise: for E < U0, the evanescent wave decays with
  // beta = sqrt(2*m*(U0-E))/hbar and transmission is exponentially small in 2*beta*L.
  U0      := 10*eV;
  Mass    := 511*keV/SquaredSpeedOfLight;

  // SubCase-1
  ELV1    := 7*eV;
  L1      := 5*nm;
  kfactor := SquareRoot(2*Mass*ELV1/SquarePower(ReducedPlanckConstant));
  bfactor := SquareRoot(2*Mass*(U0 - ELV1))/ReducedPlanckConstant;
  TunnelingProbability := (16*SquarePower(kfactor)*SquarePower(bfactor))/SquarePower(SquarePower(kfactor) + SquarePower(bfactor))*Exp(-2*bfactor*L1);

  if ReciprocalMeterUnit.ToString(bfactor, 3, 3, [pNano])        <> '8.87 1/nm' then halt(1);
  if Format('%0.3e', [ScalarUnit.ToFloat(TunnelingProbability)]) <> '9.75E-039' then halt(2);

  // SubCase-2
  ELV2    := 9*eV;
  L2      := 1*nm;
  kfactor := SquareRoot(2*Mass*ELV2/SquarePower(ReducedPlanckConstant));
  bfactor := SquareRoot(2*Mass*(U0 - ELV2))/ReducedPlanckConstant;
  TunnelingProbability := (16*(ELV2/U0)*(1-ELV2/U0))*Exp(-2*bfactor*L2);

  if ReciprocalMeterUnit.ToString(bfactor, 3, 3, [pNano])        <> '5.12 1/nm' then halt(1);
  if Format('%0.3e', [ScalarUnit.ToFloat(TunnelingProbability)]) <> '5.11E-005' then halt(2);
  writeln('* TEST-107: PASSED');

  // TEST-108 - Affine temperature-unit conversions.
  // Exercise: Celsius and Fahrenheit values are points on affine scales, so
  // converting an absolute temperature requires an offset as well as a scale
  // factor. Temperature differences are vectors: their delta units are purely
  // multiplicative and must never include the zero-point offset.
  temp := 0*K;
  {$IFDEF WINDOWS}
  if Utf8ToAnsi(KelvinUnit.ToString(temp)) <> Utf8ToAnsi('0 K')                  then halt(1);
  if Utf8ToAnsi(DegreeCelsiusUnit.ToString(temp)) <> Utf8ToAnsi('-273.15 °C')    then halt(2);
  if Utf8ToAnsi(DegreeFahrenheitUnit.ToString(temp)) <> Utf8ToAnsi('-459.67 °F') then halt(3);
  {$ELSE}
  if KelvinUnit.ToString(temp) <> '0 K'                  then halt(1);
  if DegreeCelsiusUnit.ToString(temp) <> '-273.15 °C'    then halt(2);
  if DegreeFahrenheitUnit.ToString(temp) <> '-459.67 °F' then halt(3);
  {$ENDIF}

  temp := 0*degC;
  {$IFDEF WINDOWS}
  if Utf8ToAnsi(KelvinUnit.ToString(temp, 5, 2, [])) <> Utf8ToAnsi('273.15 K') then halt(4);
  {$ELSE}
  if KelvinUnit.ToString(temp, 5, 2, []) <> '273.15 K' then halt(4);
  {$ENDIF}

  temp := 0*degF;
  {$IFDEF WINDOWS}
  if Utf8ToAnsi(KelvinUnit.ToString(temp, 5, 2, [])) <> Utf8ToAnsi('255.37 K') then halt(5);
  {$ELSE}
  if KelvinUnit.ToString(temp, 5, 2, []) <> '255.37 K' then halt(5);
  {$ENDIF}

  // A change of 18 degrees Fahrenheit is exactly 10 kelvin or 10 degrees
  // Celsius. DeltaDegreeFahrenheitUnit divides by its 5/9 conversion factor
  // when the same interval is expressed again in delta degrees Fahrenheit.
  deltatemp := 18*deltaDegF;
  if not SameValue(KelvinUnit.ToFloat(deltatemp), 10, DefaultEpsilon) then halt(6);
  if not SameValue(DeltaDegreeCelsiusUnit.ToFloat(deltatemp), 10, DefaultEpsilon) then halt(7);
  if not SameValue(DeltaDegreeFahrenheitUnit.ToFloat(deltatemp), 18, DefaultEpsilon) then halt(8);

  // Conversely, a 10-degree Celsius interval is 10 kelvin and 18 degrees
  // Fahrenheit. No absolute-temperature offset participates in this conversion.
  deltatemp := 10*deltaDegC;
  if not SameValue(KelvinUnit.ToFloat(deltatemp), 10, DefaultEpsilon) then halt(9);
  if not SameValue(DeltaDegreeFahrenheitUnit.ToFloat(deltatemp), 18, DefaultEpsilon) then halt(10);

  // Subtracting two absolute temperatures produces an interval. The freezing
  // point of water is 100 Celsius degrees below its boiling point, equivalently
  // 180 Fahrenheit degrees.
  deltatemp := 100*degC - 32*degF;
  if not SameValue(DeltaDegreeCelsiusUnit.ToFloat(deltatemp), 100, DefaultEpsilon) then halt(11);
  if not SameValue(DeltaDegreeFahrenheitUnit.ToFloat(deltatemp), 180, DefaultEpsilon) then halt(12);

  // A tolerance is also an interval. The central value receives the affine
  // conversion, whereas the uncertainty receives only the interval scale.
  temp := 20*degC;
  tolerance := 0.5*deltaDegC;
  {$IFDEF WINDOWS}
  if Utf8ToAnsi(DegreeCelsiusUnit.ToString(temp, tolerance, 4, 2, [])) <>
    Utf8ToAnsi('20 ± 0.5 °C') then halt(13);
  {$ELSE}
  if DegreeCelsiusUnit.ToString(temp, tolerance, 4, 2, []) <>
    '20 ± 0.5 °C' then halt(13);
  {$ENDIF}

  temp := 68*degF;
  tolerance := 0.9*deltaDegF;
  {$IFDEF WINDOWS}
  if Utf8ToAnsi(DegreeFahrenheitUnit.ToString(temp, tolerance, 4, 2, [])) <>
    Utf8ToAnsi('68 ± 0.9 °F') then halt(14);
  {$ELSE}
  if DegreeFahrenheitUnit.ToString(temp, tolerance, 4, 2, []) <>
    '68 ± 0.9 °F' then halt(14);
  {$ENDIF}
  writeln('* TEST-108: PASSED');

  // The TEST-5xx group represents directed physical quantities in Cl(3), the
  // three-dimensional Euclidean Clifford algebra.  Vectors, bivectors and the
  // trivector encode oriented lines, planes and volume elements respectively.

  // TEST-501 - Oriented area as a bivector.
  // Exercise: A = a wedge b.  The exterior product of perpendicular vectors
  // gives their oriented parallelogram; contractions recover the two factors.
  side1_ := 5*e1*m;
  side2_ := 10*e2*m;
  area_  := 50*e12*m2;
  area_  := side1_.wedge(side2_);
  side1_ := area_.dot(1/side2_);
  side2_ := (1/side1_).dot(area_);
  if m2.ToString(area_) <> '(+50e12) m²' then halt(1);
  if m.ToString(side1_) <> '(+5e1) m'    then halt(2);
  if m.ToString(side2_) <> '(+10e2) m'   then halt(3);
  writeln('* TEST-501: PASSED');

  // TEST-502 - Vector velocity in Cl(3).
  // Exercise: v = Delta r/Delta t.  Division by scalar time preserves the
  // e1 and e2 directions while changing the physical unit from metres to m/s.
  displacement_ := (5*e1 + 5*e2)*m;
  time          := 2*s;
  speed_        := displacement_/time;
  if MeterPerSecondUnit.ToString(speed_) <> '(+2.5e1 +2.5e2) m/s' then halt(1);
  writeln('* TEST-502: PASSED');

  // TEST-503 - Vector acceleration in Cl(3).
  // Exercise: a = Delta v/Delta t, applied component by component without
  // losing the vector character of the physical quantity.
  speed_ := (5*e1 + 5*e2)*m/s;
  time   := 2*s;
  acc_   := speed_/time;
  if MeterPerSquareSecondUnit.ToString(acc_) <> '(+2.5e1 +2.5e2) m/s²' then halt(1);
  writeln('* TEST-503: PASSED');

  // TEST-504 - Vector linear momentum in Cl(3).
  // Exercise: p = m*v.  Scalar mass scales every component of the velocity.
  mass      := 10*kg;
  speed_    := (5*e1 + 5*e2)*m/s;
  momentum_ := mass*speed_;
  if KilogramMeterPerSecondUnit.ToString(momentum_) <> '(+50e1 +50e2) kg∙m/s' then halt(1);
  writeln('* TEST-504: PASSED');

  // TEST-505 - Angular velocity as a bivector.
  // Exercise: omega = theta/t.  In geometric algebra the e13 bivector stores
  // the oriented plane of rotation instead of replacing it by an axial vector.
  angle_ := (10*e13)*rad;
  time   := 2.5*s;
  angularspeed_ := angle_/time;
  time := angle_.dot(1/angularspeed_);
  freq := angularspeed_.dot(1/angle_);

  if SecondUnit.ToVerboseString(time) <> '2.5 seconds'              then halt(1);
  if RadianPerSecondUnit.ToString(angularspeed_) <> '(+4e13) rad/s' then halt(2);
  writeln('* TEST-505: PASSED');

  // TEST-506 - Angular acceleration as a bivector.
  // Exercise: alpha = Delta omega/Delta t; its plane of rotation remains e13.
  angularspeed_ := 5*e13*rad/s;
  angularacc_   := angularspeed_/(2*s);
  if RadianPerSquareSecondUnit.ToString(angularacc_) <> '(+2.5e13) rad/s²' then halt(1);
  writeln('* TEST-506: PASSED');

  // TEST-507 - Angular momentum as an oriented plane.
  // Exercise: L = r wedge p.  For perpendicular e1 and e2 inputs, the result
  // is the e12 bivector with magnitude |r|*|p|.
  radius_          := 2*e1*m;
  momentum_        := 5*e2*kg*m/s;
  angularmomentum_ := radius_.wedge(momentum_);
  if KilogramSquareMeterPerSecondUnit.ToString(angularmomentum_) <> '(+10e12) kg∙m²/s' then halt(1);
  writeln('* TEST-507: PASSED');

  // TEST-508 - Two definitions of vector force.
  // Exercise: verify F = m*a and F = Delta p/Delta t.  Both calculations yield
  // a grade-one Clifford quantity measured in newtons.
  mass   := 10*kg;
  acc_   := (2*e1 + 2*e2)*m/s2;
  force_ := mass*acc_;
  if NewtonUnit.ToString(force_) <> '(+20e1 +20e2) N' then halt(1);

  momentum_ := 10*e1*kg*m/s;
  time      := 10*s;
  force_    := momentum_/time;
  if NewtonUnit.ToString(force_) <> '(+1e1) N' then halt(2);
  writeln('* TEST-508: PASSED');

  // TEST-509 - Torque as a bivector.
  // Exercise: tau = r wedge F.  With perpendicular r and F, contractions with
  // the reciprocal factors recover the original radius and force.
  radius_ :=  2*e1*m;
  force_  := 10*e2*N;
  torque_ := radius_.wedge(force_);
  radius_ := torque_.dot(1/force_);
  force_  := (1/radius_).dot(torque_);
  if NewtonMeterUnit.ToString(torque_) <> '(+20e12) N∙m' then halt(1);
  if MeterUnit.ToString(radius_) <> '(+2e1) m'           then halt(2);
  if NewtonUnit.ToString(force_) <> '(+10e2) N'          then halt(3);
  writeln('* TEST-509: PASSED');

  // TEST-510 - Magnetic flux in geometric algebra.
  // Exercise: combine magnetic-field and surface bivectors through duality and
  // the exterior product; the oriented flux is represented by a trivector.
  magneticfield_ := (10*e12)*T;
  area_          := ( 5*e12)*m2;
  magneticflux_  := -magneticfield_.dual.wedge(area_);
  magneticfield_ := magneticflux_.dot(1/area_).dual;
  area_          := -(1/magneticfield_.dual).dot(magneticflux_);
  if WeberUnit.ToString(magneticflux_) <> '(+50e123) Wb' then halt(1);
  if TeslaUnit.ToString(magneticfield_) <> '(+10e12) T'  then halt(2);
  if SquareMeterUnit.ToString(area_) <> '(+5e12) m²'     then halt(3);
  writeln('* TEST-510: PASSED');

  // TEST-511 - Inductance from geometric magnetic flux.
  // Exercise: L = |Phi|/|I|.  Norms remove orientation when only the scalar
  // circuit parameter is required.
  magneticflux_ := 50*e123*Wb;
  current_      := 5*e2*A;
  inductance    := -magneticflux_.Dual/current_.Norm;
  if HenryUnit.ToVerboseString(inductance) <> '10 henries' then halt(1);
  writeln('* TEST-511: PASSED');

  // TEST-512 - Pressure with oriented force and surface.
  // Exercise: pressure is force per area.  Clifford products retain the mutual
  // orientation and permit the force and surface to be recovered in this example.
  force_    := 10*e1*N;
  area_     := 2*e23*m2;
  pressure_ := -force_.wedge(1/area_);
  force_    := -pressure_.dot(area_);
  area_     := -force_.dot(1/pressure_);
  if PascalUnit.ToString(pressure_) <> '(+5e123) Pa' then halt(1);
  if NewtonUnit.ToString(force_) <> '(+10e1) N'      then halt(2);
  if SquareMeterUnit.ToString(area_) <> '(+2e23) m²' then halt(3);
  writeln('* TEST-512: PASSED');

  // TEST-513 - Torsional stiffness.
  // Exercise: tau = k_theta*theta, where k_theta is measured in N*m/rad and is
  // represented in the same oriented plane as the resulting torque.
  torquestifness_ := 10*e12*N*m/rad;
  torque_         := torquestifness_ * (5*rad);
  if NewtonMeterPerRadianUnit.ToString(torquestifness_) <> '(+10e12) N∙m/rad' then halt(1);
  if NewtonMeterUnit.ToString(torque_) <> '(+50e12) N∙m' then halt(2);
  writeln('* TEST-513: PASSED');

  // TEST-514 - Electric component of the Lorentz force.
  // Exercise: F_E = q*E and the inverse relations q = F dot E^-1 and E = F/q.
  // No magnetic q*v cross B term is present, so this is not the full Lorentz law.
  electricfield_ := (10*e1)*N/C;
  charge         := ElectronCharge;
  force_         := charge * electricfield_;
  force_         := electricfield_ * charge;
  charge         := force_.dot(1/electricfield_);
  electricfield_ := force_/charge;
  if not SameValueEx(charge, ElectronCharge) then halt(1);
  writeln('* TEST-514: PASSED');

  // TEST-515 - AC circuit quantities represented in Cl(3).
  // Exercise: resistance is scalar while reactance occupies the e12 plane;
  // compute impedance, current, power, admittance and their orientation-free norms.
  omega_      := 1*e12*rad/s;
  potential   := 50*V;
  resistance  := 2*Ohm;
  capacitance := 1*F;
  inductance  := 2*H;
  impedance_  := resistance + (1/(omega_*capacitance) + omega_*inductance);
  current_    := (1/impedance_) * potential;
  power_      := current_ * potential;
  {$IFDEF WINDOWS}
  if Utf8ToAnsi(Format('Z = %s', [ohm.ToString(impedance_)])) <> Utf8ToAnsi('Z = (+2 +1e12) Ω') then halt(1);
  {$ELSE}
  if            Format('Z = %s', [ohm.ToString(impedance_)]) <> 'Z = (+2 +1e12) Ω'              then halt(1);
  {$ENDIF}
  if            Format('I = %s', [A.ToString(current_)]) <> 'I = (+20 -10e12) A'                then halt(2);
  if            Format('P = %s', [W.ToString(power_)]) <> 'P = (+1000 -500e12) W'               then halt(3);
  if            Format('Y = %s', [siemens.ToString(1/impedance_)]) <> 'Y = (+0.4 -0.2e12) S'    then halt(4);

  if V.ToString(potential) <> '50 V'                   then halt(5);
  if A.ToString(current_.Norm) <> '22.3606797749979 A' then halt(6);
  if W.ToString(power_.Norm) <> '1118.03398874989 W'   then halt(7);
  writeln('* TEST-515: PASSED');

  // The TEST-6xx group repeats selected exercises with ordinary real or complex
  // vectors and matrices.  It demonstrates the alternative linear-algebra API.
  x1.Init([1.0, 0.0, 0.0]);
  x2.Init([0.0, 1.0, 0.0]);
  x3.Init([0.0, 0.0, 1.0]);

  // TEST-601 - Angular velocity as an axial R3 vector.
  // Exercise: omega = theta/t along x3.  Unlike TEST-505, the rotation plane is
  // represented by its perpendicular axial vector.
  angle__ := (10*x3)*rad;
  time   := 2.5*s;
  angularspeed__ := angle__/time;
  time := angle__.dot(angularspeed__.Reciprocal);
  freq := angularspeed__.dot(angle__.Reciprocal);
  if SecondUnit.ToVerboseString(time) <> '2.5 seconds'              then halt(1);
  if RadianPerSecondUnit.ToString(angularspeed__) <> '(0,0,4) rad/s' then halt(2);
  writeln('* TEST-601: PASSED');

  // TEST-602 - Angular acceleration as an R3 vector.
  // Exercise: alpha = Delta omega/Delta t, preserving the x3 rotation axis.
  angularspeed__ := 5*x3*rad/s;
  angularacc__   := angularspeed__/(2*s);
  if RadianPerSquareSecondUnit.ToString(angularacc__) <> '(0,0,2.5) rad/s²' then halt(1);
  writeln('* TEST-602: PASSED');

  // TEST-603 - Angular momentum from the cross product.
  // Exercise: L = r cross p.  The right-hand rule sends x1 cross x2 to x3.
  radius__          := 2*x1*m;
  momentum__        := 5*x2*kg*m/s;
  angularmomentum__ := radius__.cross(momentum__);
  if KilogramSquareMeterPerSecondUnit.ToString(angularmomentum__) <> '(0,0,10) kg∙m²/s' then halt(1);
  writeln('* TEST-603: PASSED');

  // TEST-604 - Vector force in R3.
  // Exercise: compare F = m*a with F = Delta p/Delta t, as in TEST-508 but
  // using the dynamically sized real-vector quantity.
  mass    := 10*kg;
  acc__   := (2*x1 + 2*x2)*m/s2;
  force__ := mass*acc__;
  if NewtonUnit.ToString(force__) <> '(20,20,0) N' then halt(1);

  momentum__ := 10*x1*kg*m/s;
  time       := 10*s;
  force__    := momentum__/time;
  if NewtonUnit.ToString(force__) <> '(1,0,0) N' then halt(2);
  writeln('* TEST-604: PASSED');

  // TEST-605 - Torque from the R3 cross product.
  // Exercise: tau = r cross F.  For these mutually perpendicular vectors,
  // reciprocal-vector cross products recover the original operands.
  radius__ :=  2*x1*m;
  force__  := 10*x2*N;
  torque__ := radius__.cross(force__);
  radius__ := force__.Reciprocal.cross(torque__);
  force__  := torque__.cross(radius__.Reciprocal);
  if NewtonMeterUnit.ToString(torque__) <> '(0,0,20) N∙m' then halt(1);
  if MeterUnit.ToString(radius__) <> '(2,0,0) m'           then halt(2);
  if NewtonUnit.ToString(force__) <> '(0,10,0) N'          then halt(3);
  writeln('* TEST-605: PASSED');

  // TEST-606 - Magnetic flux as a scalar dot product.
  // Exercise: Phi = B dot A.  Parallel field and area vectors give Phi = |B|*|A|;
  // multiplying by reciprocal vectors reconstructs each input.
  magneticfield__ := (10*x1)*T;
  area__          := (5*x1)*m2;
  magneticflux    := magneticfield__.dot(area__);
  magneticfield__ := area__.Reciprocal * magneticflux;
  area__          := magneticfield__.Reciprocal * magneticflux;
  if WeberUnit.ToString(magneticflux)    <> '50 Wb'     then halt(1);
  if TeslaUnit.ToString(magneticfield__) <> '(10,0,0) T' then halt(2);
  if SquareMeterUnit.ToString(area__)    <> '(5,0,0) m²' then halt(3);
  writeln('* TEST-606: PASSED');

  // TEST-607 - Scalar inductance.
  // Exercise: L = Phi/I, illustrating that vector machinery is unnecessary once
  // the oriented flux has already been reduced to a scalar quantity.
  magneticflux := 50*Wb;
  current      := 5*A;
  inductance   := magneticflux/current;
  if HenryUnit.ToVerboseString(inductance) <> '10 henries' then halt(1);
  writeln('* TEST-607: PASSED');

  // TEST-608 - Sinusoidal steady-state RLC circuit with complex phasors.
  // Exercise: Z = R + 1/(i*omega*C) + i*omega*L, then I = V/Z.  The real and
  // imaginary parts encode in-phase and quadrature components; Norm gives magnitude.
  time         := 0*s;
  omega        := 1*rad/s;
  potential__  := 50*(cos(omega*time) - img*sin(omega*time))*V;
  resistance   := 2*Ohm;
  capacitance  := 1*F;
  inductance   := 2*H;

  impedance__  := resistance + Complex(1, 0)/(img*omega*capacitance) +
    img*omega*inductance;
  current__    := potential__/impedance__;
  power__      := current__*potential__;

  {$IFDEF WINDOWS}
  if Utf8ToAnsi(Format('Z = %s', [ohm.ToString(impedance__)])) <> Utf8ToAnsi('Z = (2 +i) Ω') then halt(1);
  {$ELSE}
  if            Format('Z = %s', [ohm.ToString(impedance__)]) <> 'Z = (2 +i) Ω'              then halt(1);
  {$ENDIF}
  if            Format('I = %s', [A.ToString(current__)]) <> 'I = (20 -10∙i) A'                then halt(2);
  if            Format('P = %s', [W.ToString(power__)]) <> 'P = (1000 -500∙i) W'               then halt(3);
  if            Format('Y = %s', [siemens.ToString(Complex(1, 0)/impedance__)]) <> 'Y = (0.4 -0.2∙i) S'    then halt(4);

  if V.ToString(potential__.Norm) <> '50 V'             then halt(5);
  if A.ToString(current__.Norm) <> '22.3606797749979 A' then halt(6);
  if W.ToString(power__.Norm) <> '1118.03398874989 W'   then halt(7);
  writeln('* TEST-608: PASSED');

  // TEST-609 - Quantum expectation value after diagonalizing a Hamiltonian.
  // Exercise: build the spin-1/2 Hamiltonian H = mu_B*(Bx*sigma_x+Bz*sigma_z)
  // and calculate <H> = <psi|H|psi> in three equivalent ways: directly in the
  // original basis, in the eigenbasis, and as sum_i |c_i|^2*E_i.  Agreement
  // demonstrates matrix quantities, conjugation, eigenpairs and basis changes.

  DefaultEpsilon := 1E-30;

  Bx  := 1.0*T;
  Bz  := 2.0*T;
  muB := 9.274009994E-24*J/T;
  StateValues.Init([
    Complex(3/sqrt(10), 0),
    Complex(1/sqrt(10), 0)
  ]);
  State := StateValues * ScalarUnit;

  PauliX.Init([
    Complex(0, 0), Complex(1, 0),
    Complex(1, 0), Complex(0, 0)
  ]);
  PauliZ.Init([
    Complex(1, 0), Complex(0, 0),
    Complex(0, 0), Complex(-1, 0)
  ]);
  H2 := TComplexQuantity(muB) *
    (TComplexQuantity(Bx) * (PauliX * ScalarUnit) +
     TComplexQuantity(Bz) * (PauliZ * ScalarUnit));

  if eV.toString(State.Conjugate*H2*State) <> '(0.00012734439857522) eV' then halt(1);

  EigenValues  := H2.EigenValues;
  EigenVectors := H2.EigenVectors(EigenValues);
  U2 := EigenVectors.TransposeConjugate * ScalarUnit;
  H2 := H2.Diagonalize(EigenValues);

  if eV.toString((U2*State).Conjugate*H2*(U2*State)) <> '(0.00012734439857522) eV' then halt(2);

  coeff := U2 * State;

  if eV.ToString(coeff[0].SquaredNorm*EigenValues[0] +
                 coeff[1].SquaredNorm*EigenValues[1]) <> '(0.00012734439857522) eV' then halt(3);
  writeln('* TEST-609: PASSED');

  // TEST-610 - Inverse fine-structure constant.
  // Exercise: 1/alpha = 2*epsilon_0*h*c/e^2 in SI.  Every physical dimension
  // cancels, leaving the dimensionless electromagnetic coupling constant.
  a_ := (2*ElectricPermittivity*PlanckConstant*SpeedOfLight)/SquarePower(ElectronCharge);
  if Abs(ScalarUnit.ToFloat(a_ - InverseFineStructureConstant)) > 1E-10 then Halt(1);
  writeln('* TEST-610: PASSED');

  // TEST-611 - Hubble constant as an inverse time.
  // Exercise: H0 = 67.4 km/(s*Mpc).  Although written as recession speed per
  // distance, the length dimensions cancel and H0 is an expansion rate.
  H0 := 67.4*km/s/megaparsec;
  if MeterPerSecondPerParsecUnit.ToString(H0, [pKilo, pNone, pMega]) <> '67.4 km/s/Mpc' then halt(1);
  writeln('* TEST-611: PASSED');

  writeln;
  writeln('ADIM-TEST DONE.');
end.
