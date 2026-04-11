{
  Description: ADim CL3 vector space utils.

  Copyright (C) 2025-2026 Melchiorre Caruso <@url(melchiorrecaruso@gmail.com)>

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

unit ADimCL3;

{$mode ObjFPC}{$H+}

interface

uses
  ADim;

const
  e1   : TCL3Versor1 = ();
  e2   : TCL3Versor2 = ();
  e3   : TCL3Versor3 = ();
  e12  : TCL3Biversor12 = ();
  e13  : TCL3Biversor13 = ();
  e23  : TCL3Biversor23 = ();
  e123 : TCL3Triversor123 = ();

  u1   : TCL3Vector = (fm1:1.0; fm2:0.0; fm3:0.0);
  u2   : TCL3Vector = (fm1:0.0; fm2:1.0; fm3:0.0);
  u3   : TCL3Vector = (fm1:0.0; fm2:0.0; fm3:1.0);
  u12  : TCL3Bivector = (fm12:1.0; fm13:0.0; fm23:0.0);
  u13  : TCL3Bivector = (fm12:0.0; fm13:1.0; fm23:0.0);
  u23  : TCL3Bivector = (fm12:0.0; fm13:0.0; fm23:1.0);
  u123 : TCL3Trivector = (fm123:1.0);

  { The zero multivector of @code(Cl(3,0)).
    All eight grade components are set to zero:
    @code(0 = 0 + 0·e₁ + 0·e₂ + 0·e₃ + 0·e₁₂ + 0·e₁₃ + 0·e₂₃ + 0·e₁₂₃).
    Useful as a neutral element for addition or as an initial accumulator
    in multivector summations.
  }
  NullMultivector : TCL3Multivector = (fm0:0.0; fm1:0.0; fm2:0.0; fm3:0.0; fm12:0.0; fm13:0.0; fm23:0.0; fm123:0.0);

  { The zero trivector of @code(Cl(3,0)).
    The pseudoscalar coefficient is zero: @code(0·e₁∧e₂∧e₃).
    Useful as a neutral element for trivector addition.
  }
  NullTrivector : TCL3Trivector = (fm123:0.0);

  { The zero bivector of @code(Cl(3,0)).
    All three bivector coefficients are zero:
    @code(0·e₁∧e₂ + 0·e₁∧e₃ + 0·e₂∧e₃).
    Useful as a neutral element for bivector addition.
  }
  NullBivector : TCL3Bivector = (fm12:0.0; fm13:0.0; fm23:0.0);

  { The zero vector of @code(Cl(3,0)).
    All three vector coefficients are zero:
    @code(0·e₁ + 0·e₂ + 0·e₃).
    Useful as a neutral element for vector addition.
  }
  NullVector : TCL3Vector = (fm1:0.0; fm2:0.0; fm3:0.0);

  { The zero scalar of @code(Cl(3,0)).
    Equivalent to the real number @code(0.0).
    Useful as a neutral element for scalar addition or as a default
    return value for operations that yield a dimensionless zero.
  }
  NullScalar : double = (0.0);

implementation

end.

