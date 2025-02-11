# <center>adimRT Library</center>

Another library for type checking of dimensioned quantities at run-time in FreePascal. From a [circular's](https://github.com/circular17/DimPas) idea.

[<center>![Actions Status](https://github.com/melchiorrecaruso/ADimRT/workflows/build-test/badge.svg)</center>](https://github.com/melchiorrecaruso/ADimRT/actions)

## <u>What it's </u>

Ensuring coherence of physical dimensions in physical equations or mathematical relationships involving various variables is crucial. Dimensional analysis provides a fundamental tool to verify this coherence and correct any errors in the expressions.

The adimRT library allows defining variables and constants in terms of quantity and units of measurement, automating dimensional analysis at run-time.

## <u>How to use</u>

#### Example 1: Calculate speed
``` pas
uses
  adim;
var 
  distance: TQuantity;
  time:     TQuantity;
  speed:    TQuantity;  
begin
  distance := 5000*m;
  time     := 2*hr;
  speed    := distance/time;
  
  writeln('The value of speed is ', KilometerPerHourUnit.ToString(speed);
end;
```
Output: 
``` 
The value of speed is 2.5 km/h
``` 
#### Example 2: Calculate Borh radius
``` pas
uses
  adim;
var 
  plank:  TQuantity;
  e0:     TQuantity;
  ke:     TQuantity;  
  mass:   TQuantity;
  radius: TQuantity;
begin
  plank  := 6.62607015E-34*J*s;    // Planck constant
  e0     := 8.8541878128E-12*F/m;  // vacuum permittivity
  ke     := 1/(4*pi*e0);           // Coulomb constant
  mass   := 9.1093837015E-31*kg;   // mass of an electron
  radius := (SquarePower(plank/2/pi)/mass)/(ke*SquarePower(charge)); 

  writeln('The value of the Bohr radius is ', MeterUnit.ToString(radius, 10, 10, []));      
end;
```
Output: 
``` 
The value of the Bohr radius is 5.291772109E-11 m
``` 

Refer to the [adim test](adimtest.pas) source code for additional examples.

## <u>Requirements</u>

- [FreePascal compiler](https://www.freepascal.org)
- [Lazarus IDE](https://www.lazarus-ide.org)

## <u>Supported mathematical formulae:<u>

- [Mechanics](doc/mechanics.md)
- [Fluid Mechanics](doc/fluidmechanics.md)
- [Electricity and Magnetism](doc/electricityandmagnetism.md)
- [Heat and Thermodynamics](doc/heatandthermodynamics.md)
- [Waves and Hearing](doc/waves.md)
- [Light and Vision](doc/lightandvision.md)
- [Relativity](doc/relativity.md)
- [Quantum Mechanics](doc/quantummechanics.md)
- [Units of measurement](doc/unitsofmeasurement.md)

## References

- [HyperPhysics](http://hyperphysics.phy-astr.gsu.edu/hbase/hframe.html)
- [University Physics Volume 1](https://openstax.org/details/books/university-physics-volume-1)
- [University Physics Volume 2](https://openstax.org/details/books/university-physics-volume-2)
- [University Physics Volume 3](https://openstax.org/details/books/university-physics-volume-3)
- [National Institute of Standards and Technology](https://www.nist.gov/pml/owm/metric-si/si-units)
- [Bureau international des poids et mesures](https://www.bipm.org/en/)

## LICENSE

[GNU Lesser General Public License v3.0](https://github.com/melchiorrecaruso/ADimRT/blob/main/LICENSE)
