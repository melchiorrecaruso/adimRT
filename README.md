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
- Dimensioned vectors, bivectors, trivectors and multivectors in the Euclidean
  Clifford algebra `Cl(3,0)`.
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

  WriteLn(MeterPerHourUnit.ToString(Speed, [pKilo]));
end.
```

Output:

```text
2.5 km/h
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

ValueInMeters     := MeterUnit.ToFloat(Length);            // 1200
ValueInKilometers := MeterUnit.ToFloat(Length, [pKilo]);   // 1.2

WriteLn(MeterUnit.ToString(Length));             // 1200 m
WriteLn(MeterUnit.ToString(Length, [pKilo]));    // 1.2 km
```

`ToFloat` returns a plain numerical value. `ToString` appends the unit symbol,
whereas `ToVerboseString` uses the unit name. Overloads allow the caller to
control floating-point formatting and to include a tolerance:

```pascal
Length    := 10.5 * mm;
Tolerance := 0.2 * mm;

WriteLn(MeterUnit.ToString(Length, Tolerance, 5, 5, [pMilli]));
// 10.5 +/- 0.2 mm (the actual output uses the Unicode plus/minus sign)
```

For a compound unit, the prefix array follows the order of the unit factors.
For example, `[pKilo, pNone]` selects kilometres per second for a unit whose
factors are metre and second. Passing `[]` uses the unit's default prefixes.

Complex scalars, vectors and matrices can be extracted with `ToComplex`,
`ToVector` and `ToMatrix`, respectively. Formatting with `ToString` and
`ToVerboseString` is also available for those types and for Clifford
quantities. A conversion to an incompatible unit raises `EDimensionError`; it
never silently reinterprets the value.

## Temperatures and temperature intervals

Celsius and Fahrenheit are affine scales: an absolute temperature needs both a
scale and a zero-point offset. ADimRT therefore distinguishes an absolute
temperature from a temperature difference.

```pascal
Temperature := 20 * degC;
WriteLn(KelvinUnit.ToString(Temperature, 5, 2, [])); // 293.15 K

DeltaTemperature := 18 * deltaDegF;
WriteLn(DeltaDegreeCelsiusUnit.ToString(DeltaTemperature)); // 10 Δ°C
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

`TRealQuantity` stores a `Double` value and a physical dimension.
`TComplexQuantity` provides the same dimensional behaviour for complex values,
with conjugate, norm and squared-norm operations.

### Vectors

`TRealVectorQuantity` and `TComplexVectorQuantity` are dynamically sized and
require all coefficients to share one physical dimension. They support indexed
access, addition, subtraction, scalar products, norms, normalization and
reciprocals. Real vectors also provide three-dimensional cross products;
complex vectors provide conjugation.

### Matrices

`TRealMatrixQuantity` and `TComplexMatrixQuantity` represent dynamically sized
square matrices whose coefficients share one dimension. Available operations
include matrix arithmetic, determinant, trace, norm, rank, transpose, inverse,
linear-system solving and eigenvalue/eigenvector calculation. Real matrices can
be tested for orthogonality; complex matrices support conjugation, conjugate
transpose, Hermitian and unitary checks.

The dimension of a result follows the operation. For example, the determinant
of an order-`n` matrix has the coefficient dimension raised to `n`, while an
inverse matrix has the reciprocal dimension.

### Clifford algebra `Cl(3,0)`

For three-dimensional directed quantities the library exposes:

- `TCL3VecQuantity`
- `TCL3BivecQuantity`
- `TCL3TrivecQuantity`
- `TCL3MultivecQuantity`

These types combine physical dimensions with geometric products and operations
such as dot, wedge and cross products, dual, reverse, inverse, projection,
rejection, reflection and rotation. This is useful when orientation is part of
the physical model, for example directed lengths, oriented areas, torques and
rotations.

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

WriteLn(MeterUnit.ToString(Radius, 4, 4, [])); // 5.292E-11 m
```

## Disabling dimensional checks

Defining the compiler symbol `ADIMOFF` removes dimensional checking: quantity
types become aliases of their underlying real, complex, vector, matrix or
Clifford types. This mode is intended for a validated performance-sensitive
build where the loss of all run-time unit protection is an explicit choice.

Code compiled with `ADIMOFF` must not depend on `EDimensionError` being raised.
Keep checks enabled while developing and testing physical calculations.

## Further documentation and examples

- [Generated API reference](docs/index.html)
- [Complete executable test suite and usage examples](adimtest.pas)
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
the most extensive source of runnable examples, including unit conversion,
tolerances, affine temperatures, quantum-mechanical relations, vectors,
matrices and Clifford algebra.

## License

ADimRT is distributed under the [GNU Lesser General Public License v3](COPYING.LGPL)
with the [modified LGPL linking exception](COPYING.modifiedLGPL). The exception
allows the library to be linked with independent modules under the conditions
stated in that file.
