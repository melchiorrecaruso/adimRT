# ADimRT

[![Build and test](https://github.com/melchiorrecaruso/ADimRT/actions/workflows/linux.yml/badge.svg)](https://github.com/melchiorrecaruso/ADimRT/actions/workflows/linux.yml)

ADimRT is a Free Pascal library for run-time dimensional analysis. It associates
each numerical value with its physical dimension and carries that information
through calculations, so errors such as adding a length to a time are detected
where they occur.

The library is intended for scientific, engineering and educational software
that manipulates physical quantities. Its notation remains close to an ordinary
formula:

```pascal
distance := 5000 * m;
duration := 2 * hr;
speed    := distance / duration;
```

`speed` now contains both its numerical value and the resulting length/time
dimension. It can later be converted to or displayed in any compatible unit.

ADimRT was inspired by [DimPas](https://github.com/circular17/DimPas).

## What the library provides

- Run-time validation of physical dimensions during arithmetic, comparison,
  conversion and mathematical operations.
- Real and complex scalar quantities.
- Dynamically sized real and complex vector quantities.
- Dynamically sized square real and complex matrix quantities, including common
  linear-algebra operations.
- Dimensioned vectors, bivectors, trivectors and multivectors in the Clifford
  algebras `Cl(2,0)` (plane), `Cl(3,0)` (space) and `Cl(1,3)` (spacetime).
- Hundreds of ready-to-use SI, derived, scaled and non-SI units.
- SI decimal prefixes from quetta (`10^30`) to quecto (`10^-30`).
- Physical constants represented as dimensioned quantities.
- Dimension-aware powers, roots, trigonometric functions, exponentials and
  logarithms.
- Compact and verbose formatting, selectable prefixes, numerical precision and
  optional tolerances.
- Correct affine conversion of absolute Celsius and Fahrenheit temperatures,
  with separate units for temperature intervals.

Dimensional checks are performed at run time, not at compile time. Invalid
Pascal syntax and type errors are still handled by the compiler; incompatible
physical dimensions raise `EDimensionError` when the expression is evaluated.

## Getting started

ADimRT requires Free Pascal and the FCL. Lazarus is optional, but the repository
includes `adimpack.lpk` for adding the library as a Lazarus project dependency.
For a command-line Free Pascal project, make the ADimRT units visible in the
compiler unit path.

Most applications only need the main unit:

```pascal
uses
  ADim;
```

Use `ADimMath` as well if the application needs to name `EDimensionError` or use
the underlying mathematical types directly. When both units are present, put
`ADim` after `ADimMath` so ADimRT's dimension-aware overloads take precedence:

```pascal
uses
  ADimMath, ADim;
```

### First calculation

```pascal
program SpeedExample;

{$mode objfpc}{$H+}

uses
  ADim;

var
  Distance: TRealQuantity;
  Duration: TRealQuantity;
  Speed: TRealQuantity;
begin
  Distance := 5000 * m;
  Duration := 2 * hr;
  Speed    := Distance / Duration;

  WriteLn('Speed: ', MeterPerHourUnit.ToString(Speed, [pKilo]));
end.
```

Output:

```text
Speed: 2.5 km/h
```

The decimal separator used by formatted output follows Free Pascal's
`DefaultFormatSettings`; the examples in this document assume `.`.

The expression may mix compatible units. ADimRT converts factored units such as
hours and kilometres to a coherent internal SI value, while preserving the
physical dimension.

## Constructing quantities

Multiply a number by a unit or by one of its aliases:

```pascal
Length       := 1.2 * km;
ElapsedTime  := 250 * ms;
Force        := 12 * N;
Angle        := 30 * deg;
Temperature  := 20 * degC;
```

Common units generally have:

- a descriptive unit record, such as `MeterUnit` or `NewtonUnit`;
- a readable alias, such as `Meter` or `Newton`;
- a symbol alias, such as `m` or `N`.

Some prefixed units are also exposed directly as dimensioned constants, for
example `km`, `mm`, `nm`, `ms` and `kJ`. The complete set is listed in the
[units of measurement reference](help/unitsofmeasurement.md) and in the
[generated API documentation](docs/index.html).

Assigning a plain real value to `TRealQuantity` creates a dimensionless
quantity. Attach a unit whenever the value represents a physical measurement.

## Dimensional rules

ADimRT applies the usual rules of dimensional analysis:

| Operation | Rule |
| --- | --- |
| Addition and subtraction | Both operands must have the same dimension. |
| Multiplication | Dimensions are multiplied and their exponents are added. |
| Division | Dimensions are divided and their exponents are subtracted. |
| `Min`, `Max` and tolerant comparison | The quantities must be dimensionally compatible. |
| Integer powers | The value and every dimensional exponent are raised together. |
| Roots | The dimension must admit the requested exact root. |
| `Sin`, `Cos`, `Tan`, etc. | The argument must have the dimension of an angle. |
| `Exp`, `Log10`, `Log2`, `LogN`, `Power` | Arguments that mathematically require it must be dimensionless. |

For example:

```pascal
Area   := Length * Width;
Radius := SquareRoot(Area / Pi);

// Raises EDimensionError when evaluated: length and time cannot be added.
Invalid := 10 * m + 3 * s;
```

Use `SquarePower`, `CubicPower`, `QuarticPower`, `QuinticPower` and
`SexticPower` instead of applying an unrestricted floating-point exponent to a
dimensioned value. Matching root functions are available from square through
sixth root. A root is rejected when the quantity's dimension cannot be divided
exactly by that order.

## Conversion and output

A unit record validates compatibility and extracts the numerical value in the
requested unit:

```pascal
Length := 1.2 * km;

ValueInMeters     := MeterUnit.ToFloat(Length);
ValueInKilometers := MeterUnit.ToFloat(Length, [pKilo]);

WriteLn('Value in metres:     ', ValueInMeters:0:1);
WriteLn('Value in kilometres: ', ValueInKilometers:0:1);
WriteLn('Length:              ', MeterUnit.ToString(Length));
WriteLn('Length in km:        ', MeterUnit.ToString(Length, [pKilo]));
```

Output:

```text
Value in metres:     1200.0
Value in kilometres: 1.2
Length:              1200 m
Length in km:        1.2 km
```

`ToFloat` returns a plain numerical value. `ToString` appends the unit symbol,
whereas `ToVerboseString` uses the unit name. Overloads allow the caller to
control floating-point formatting and to include a tolerance:

```pascal
Length    := 10.5 * mm;
Tolerance := 0.2 * mm;

WriteLn('Length: ', MeterUnit.ToString(Length, Tolerance, 5, 5, [pMilli]));
```

Output:

```text
Length: 10.5 ± 0.2 mm
```

For a compound unit, the prefix array follows the order of the unit factors.
For example, `[pKilo, pNone]` selects kilometres per second for a unit whose
factors are metre and second. Passing `[]` uses the unit's default prefixes.

Complex scalars, vectors and matrices can be extracted with `ToComplex`,
`ToVector` and `ToMatrix`, respectively, and Clifford quantities with
`ToMultivector`, `ToVector`, `ToBivector`, `ToTrivector` and `ToQuadrivector`.
`ToString` and `ToVerboseString`, with or without a precision, are available
for every quantity type. The tolerance overloads, which show a result as
`value ± tolerance`, are specific to real quantities: for a complex, vector,
matrix or Clifford quantity it would not be clear which component the
tolerance refers to. A conversion to an incompatible unit raises
`EDimensionError`; it never silently reinterprets the value.

A unit may also appear on the left of a scalar quantity, for example
`m / (2*s)` is `0.5 m/s`.

## Temperatures and temperature intervals

Celsius and Fahrenheit are affine scales: an absolute temperature needs both a
scale and a zero-point offset. ADimRT therefore distinguishes an absolute
temperature from a temperature difference.

```pascal
Temperature := 20 * degC;
WriteLn('Temperature:          ', KelvinUnit.ToString(Temperature, 5, 2, []));

DeltaTemperature := 18 * deltaDegF;
WriteLn('Temperature interval: ', DeltaDegreeCelsiusUnit.ToString(DeltaTemperature));
```

Output:

```text
Temperature:          293.15 K
Temperature interval: 10 Δ°C
```

Use these units for absolute values:

- `K` / `KelvinUnit`
- `degC` / `DegreeCelsiusUnit`
- `degF` / `DegreeFahrenheitUnit`

Use `deltaDegC`, `deltaDegF`, `DeltaDegreeCelsiusUnit` and
`DeltaDegreeFahrenheitUnit` for differences, increments and tolerances. A
temperature interval is scaled but never receives an absolute-temperature
offset. Subtracting two absolute temperatures produces a compatible interval.

## Supported numerical quantities

### Scalars

`TRealQuantity` stores a `Double` value and a physical dimension, with
`Abs`, `Norm`, `SquaredNorm`, `Conjugate` and `Reciprocal`.
`TComplexQuantity` provides the same dimensional behaviour for complex values,
with conjugate, norm, squared-norm, argument and null tests.

### Vectors

`TRealVectorQuantity` and `TComplexVectorQuantity` are dynamically sized and
require all coefficients to share one physical dimension. They support indexed
access, addition, subtraction, scalar products, norms, normalization,
reciprocals and tolerant comparison. Real vectors also provide
three-dimensional cross products; complex vectors provide conjugation.

A scalar quantity times a plain vector is a vector quantity, so
`BohrRadius * V` gives a vector in metres.

### Matrices

`TRealMatrixQuantity` and `TComplexMatrixQuantity` represent dynamically sized
square matrices whose coefficients share one dimension. Available operations
include matrix arithmetic, determinant, trace, norm, rank, transpose, inverse,
linear-system solving and eigenvalue/eigenvector calculation, with dedicated
routines for symmetric (`SymmetricEigenpairs`) and Hermitian
(`HermitianEigenpairs`) matrices. Real matrices can be tested for
orthogonality; complex matrices support conjugation, conjugate transpose,
Hermitian and unitary checks. As for vectors, a scalar quantity times a plain
matrix is a matrix quantity.

The dimension of a result follows the operation. For example, the determinant
of an order-`n` matrix has the coefficient dimension raised to `n`, while an
inverse matrix has the reciprocal dimension.

### Clifford algebras

Three geometric algebras are available, each with its own unit for the basis
blades:

| Algebra | Unit | Basis | Quantity types |
| --- | --- | --- | --- |
| `Cl(2,0)`, plane | `ADimCL2` | `e1`, `e2`, `e12` | `TCL2VecQuantity`, `TCL2BivecQuantity`, `TCL2MultivecQuantity` |
| `Cl(3,0)`, space | `ADimCL3` | `e1` .. `e123` | `TCL3VecQuantity`, `TCL3BivecQuantity`, `TCL3TrivecQuantity`, `TCL3MultivecQuantity` |
| `Cl(1,3)`, spacetime | `ADimCL13` | `g0` .. `g0123`, `g0^2 = +1` | `TCL13VecQuantity` .. `TCL13QuadrivecQuantity`, `TCL13MultivecQuantity` |

A program uses the unit of the algebra it needs, next to `ADim`:

```pascal
uses
  ADim, ADimCL3;

var
  Radius, Force: TCL3VecQuantity;
  Torque: TCL3BivecQuantity;
begin
  Radius := 2*e1*m;
  Force  := 3*e3*N;
  Torque := Radius.Wedge(Force);
  WriteLn('Torque: ', NewtonMeterUnit.ToString(Torque));
end.
```

Output:

```text
Torque: (+6e13) N∙m
```

These types combine physical dimensions with geometric products and operations
such as dot, wedge and cross products, dual, reverse, inverse, projection,
rejection, reflection and rotation. This is useful when orientation is part of
the physical model, for example directed lengths, oriented areas, torques,
rotations and Lorentz transformations.

All the components of a quantity share one dimension. In spacetime, a
four-vector is therefore written with homogeneous components, for example an
event as `(c*t)*g0 + x*g1` in metres or a four-momentum as `(E/c)*g0 + p*g1`.

The spacetime algebra (STA) turns special relativity into geometry. A
spaceship leaves the Earth at `0.6c`: how much time has the clock on board
measured after 5 s of Earth time?

```pascal
uses
  ADim, ADimCL13, Math;

var
  EarthTime: TRealQuantity;
  Event, ShipEvent: TCL13VecQuantity;
  Boost: TCL13MultivecQuantity;
  Rapidity: double;
begin
  // After 5 s the ship is at x = 0.6 c t: the event is c t g0 + x g1, in metres
  EarthTime := 5*s;
  Event     := (SpeedOfLight*EarthTime)*g0 + (0.6*SpeedOfLight*EarthTime)*g1;

  // The interval (ct)^2 - x^2 is the same in every frame: the proper time is Norm/c
  WriteLn('Proper time from the interval: ', SecondUnit.ToString(Event.Norm/SpeedOfLight, 5, 0, []));

  // The same result in the ship frame, reached with the boost rotor
  // R = cosh(phi/2) + sinh(phi/2) g01, where tanh(phi) = v/c
  Rapidity  := ArcTanh(0.6);
  Boost     := Cosh(Rapidity/2) + Sinh(Rapidity/2)*g01;
  ShipEvent := Event.Rotate(Boost);
  WriteLn('Proper time in the ship frame: ', SecondUnit.ToString(ShipEvent.Dot(1*g0)/SpeedOfLight, 5, 0, []));
end.
```

Output:

```text
Proper time from the interval: 4 s
Proper time in the ship frame: 4 s
```

In the ship frame the event lies on the time axis (`x' = 0`, up to rounding),
so its time component is the proper time.

In the plane, `Cl(2,0)` handles the phasors of AC circuits without complex
numbers: a phasor is a vector and a reactance is a bivector, because
multiplying by `e12` turns a vector by 90 degrees. A series RL circuit with
`R = 30 Ω` and `X_L = ωL = 40 Ω` carries an rms current of 2 A; find the
voltage, the active power and the phase shift:

```pascal
uses
  ADim, ADimCL2;

var
  Current, Voltage: TCL2VecQuantity;
  Resistance, ActivePower: TRealQuantity;
  Reactance: TCL2BivecQuantity;
  PowerFactor: double;
begin
  Current    := 2*e1*A;           // reference phasor
  Resistance := 30*ohm;
  Reactance  := 40*e12*ohm;       // inductive: the voltage leads the current
  Voltage    := Current*Resistance + Current*Reactance;
  WriteLn('Voltage phasor:  ', VoltUnit.ToString(Voltage));
  WriteLn('Voltage (rms):   ', VoltUnit.ToString(Voltage.Norm));

  // The dot product of the phasors is the active power
  ActivePower := Voltage.Dot(Current);
  WriteLn('Active power:    ', WattUnit.ToString(ActivePower));

  PowerFactor := ScalarUnit.ToFloat(ActivePower/(Voltage.Norm*Current.Norm));
  WriteLn('Power factor:    ', PowerFactor:0:2);
  WriteLn('Phase shift:     ', DegreeUnit.ToString(ArcCos(PowerFactor), 4, 0, []));
end.
```

Output:

```text
Voltage phasor:  (+60e1 +80e2) V
Voltage (rms):   100 V
Active power:    120 W
Power factor:    0.60
Phase shift:     53.13 deg
```

The wedge product `Current.Wedge(Voltage)` is the reactive power, `160 e12`
in volt-amperes, and the product of the norms is the apparent power, 200 VA.

The algebras come from the
[Clifford](https://github.com/melchiorrecaruso/clifford) library. Conventions:

- `Inverse` is the multiplicative inverse, `X * X.Inverse = X.Inverse * X = 1`;
  the dimension is inverted. Dividing by a non-invertible value raises a
  floating-point exception.
- `Involute` is the grade involution and `Conjugate` the Clifford conjugate;
  both preserve the dimension.
- `Dot` is the "fat" dot product and `Dual` is `X * I`, with `I` the unit
  pseudoscalar. In 3D, `a.Cross(b)` equals `-(a.Wedge(b)).Dual`.
- `X.Rotate(R)` is `R X ~R`, the rotation by the rotor `R`, and keeps the type
  of `X`; `X.Rotation(A, B)` rotates by twice the angle from `A` to `B`.
- `SquaredNorm` is `<X ~X>`, which in spacetime is the invariant interval and
  can be negative; `Norm` is `Sqrt(Abs(SquaredNorm))`.
- `Extract` keeps the selected components, for example `vc1`, `vc2` for
  vectors or `bc12` for bivectors.
- Widening to a multivector is implicit; narrowing is explicit, for example
  `TCL3VecQuantity(M)`.
- A plain value converts implicitly to a dimensionless quantity, so a rotor is
  written `R := Cos(a/2) - Sin(a/2)*e12`, and a real quantity times a basis
  blade or a value is a quantity, for example `(c*t)*g0 + x*g1`.

## Units, prefixes and physical constants

`TUnit` represents a coherent unit with its dimension, symbol and names.
`TFactoredUnit` adds a conversion factor for units such as hours, degrees,
electronvolts and other scaled or non-SI units. Celsius and Fahrenheit have
special affine unit types because a multiplicative factor alone is not enough.

The `TPrefix` enumeration covers:

```text
quetta, ronna, yotta, zetta, exa, peta, tera, giga, mega, kilo, hecto,
deca, none, deci, centi, milli, micro, nano, pico, femto, atto, zepto,
yocto, ronto, quecto
```

The main unit also exports dimensioned physical constants, including the speed
of light, Planck and reduced Planck constants, elementary charge, electron mass,
Bohr radius, vacuum permittivity and many others. Because constants carry their
own dimensions, they participate in the same validation as application values.

Example using the predefined constants:

```pascal
Radius := (SquarePower(ReducedPlanckConstant) / ElectronMass) /
          (CoulombConstant * SquarePower(ElectronCharge));

WriteLn('Bohr radius: ', MeterUnit.ToString(Radius, 4, 4, []));
```

Output:

```text
Bohr radius: 5.292E-11 m
```

## Disabling dimensional checks

Defining the compiler symbol `ADIMOFF` removes dimensional checking: quantity
types become aliases of their underlying real, complex, vector, matrix or
Clifford types. This mode is intended for a validated performance-sensitive
build where the loss of all run-time unit protection is an explicit choice.

The same source compiles in both modes: every operation of a quantity type has
a counterpart on the underlying type. Two points need care:

- With `ADIMOFF`, the methods of `TRealQuantity` (`Norm`, `SameValue`, ...)
  come from the `Double` helper of `ADimMath`. Free Pascal activates only the
  last helper in scope, so list `ADimMath` after `SysUtils` in the `uses`
  clause, or enable `{$modeswitch multihelpers}`.
- Code compiled with `ADIMOFF` must not depend on `EDimensionError` being
  raised.

Keep checks enabled while developing and testing physical calculations.

## Further documentation and examples

- [Generated API reference](docs/index.html)
- [Worked examples](adimtest.pas)
- [Units of measurement](help/unitsofmeasurement.md)
- [Mechanics](help/mechanics.md)
- [Fluid mechanics](help/fluidmechanics.md)
- [Electricity and magnetism](help/electricityandmagnetism.md)
- [Heat and thermodynamics](help/heatandthermodynamics.md)
- [Waves and hearing](help/waves.md)
- [Light and vision](help/lightandvision.md)
- [Relativity](help/relativity.md)
- [Quantum mechanics](help/quantummechanics.md)

The physics pages collect equations and examples by subject. `adimtest.pas` is
a collection of runnable exercises that show how the library is used, including
unit conversion, tolerances, affine temperatures, quantum-mechanical relations,
vectors, matrices and Clifford algebras.

## Author

Melchiorre Caruso (melchiorrecaruso@gmail.com)

## License

ADimRT is distributed under the [MIT License](LICENSE).

The unit `adimlapack.pas` contains translations to Pascal of routines of
[LAPACK](https://www.netlib.org/lapack), distributed under the LAPACK license
reproduced in [COPYING.LAPACK](COPYING.LAPACK). Redistributions in binary form
must reproduce that notice in their documentation.
