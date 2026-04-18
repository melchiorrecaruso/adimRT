{ ADim Clifford algebra @code(Cl(3,0)) utilities.

  Provides predefined global constants for the basis blades, unit elements
  and zero elements of the Clifford algebra @code(Cl(3,0)) over @code(ℝ³).

  The basis blades are available both as versor/biversor/triversor singleton
  records (for use in operator expressions) and as pre-initialised
  @link(TCL3Vector), @link(TCL3Bivector) and @link(TCL3Trivector) values
  (for use as numerical unit vectors):

  @unorderedList(
    @item(@bold(Versors): @link(e1), @link(e2), @link(e3) — allow expressions like @code(3.0*e1 + 2.0*e2).)
    @item(@bold(Biversors): @link(e12), @link(e13), @link(e23) — allow expressions like @code(1.5*e12).)
    @item(@bold(Triversor): @link(e123) — allows expressions like @code(2.0*e123).)
    @item(@bold(Unit vectors): @link(u1), @link(u2), @link(u3), @link(u12), @link(u13), @link(u23), @link(u123)
          — pre-built numerical basis elements for direct arithmetic.)
    @item(@bold(Zero elements): @link(NullMultivector), @link(NullTrivector), @link(NullBivector),
          @link(NullVector), @link(NullScalar) — neutral elements for addition.)
  )

  @author Melchiorre Caruso (melchiorrecaruso@@gmail.com)
  @copyright 2025-2026 Melchiorre Caruso
  @license GNU Lesser General Public License v3 with modified LGPL exception.

  This unit is part of the ADim library, distributed under the
  GNU Lesser General Public License v3 (LGPL v3) with the following
  special exception:

  As a special exception, the copyright holders of this library give you
  permission to link this library with independent modules to produce an
  executable, regardless of the license terms of these independent modules,
  and to copy and distribute the resulting executable under terms of your
  choice, provided that you also meet, for each linked independent module,
  the terms and conditions of the license of that module. An independent
  module is a module which is not derived from or based on this library.
  If you modify this library, you may extend this exception to your version
  of the library, but you are not obligated to do so. If you do not wish
  to do so, delete this exception statement from your version.
}

unit ADimCL3;

{$mode ObjFPC}{$H+}

interface

uses
  ADim;

var
  { Basis versor @code(e₁) of @code(Cl(3,0)). Enables expressions like @code(3.0 * e1). }
  e1: TCL3Versor1 = ();

  { Basis versor @code(e₂) of @code(Cl(3,0)). Enables expressions like @code(3.0 * e2). }
  e2: TCL3Versor2 = ();

  { Basis versor @code(e₃) of @code(Cl(3,0)). Enables expressions like @code(3.0 * e3). }
  e3: TCL3Versor3 = ();

  { Basis biversor @code(e₁∧e₂) of @code(Cl(3,0)). Enables expressions like @code(2.0 * e12). }
  e12: TCL3Biversor12 = ();

  { Basis biversor @code(e₁∧e₃) of @code(Cl(3,0)). Enables expressions like @code(2.0 * e13). }
  e13: TCL3Biversor13 = ();

  { Basis biversor @code(e₂∧e₃) of @code(Cl(3,0)). Enables expressions like @code(2.0 * e23). }
  e23: TCL3Biversor23 = ();

  { Unit pseudoscalar @code(e₁∧e₂∧e₃) of @code(Cl(3,0)). Enables expressions like @code(2.0 * e123). }
  e123: TCL3Triversor123 = ();

  { Unit vector along @code(e₁): @code(u1 = 1·e₁ + 0·e₂ + 0·e₃). }
  u1: TCL3Vector = (fm1: 1.0; fm2: 0.0; fm3: 0.0);

  { Unit vector along @code(e₂): @code(u2 = 0·e₁ + 1·e₂ + 0·e₃). }
  u2: TCL3Vector = (fm1: 0.0; fm2: 1.0; fm3: 0.0);

  { Unit vector along @code(e₃): @code(u3 = 0·e₁ + 0·e₂ + 1·e₃). }
  u3: TCL3Vector = (fm1: 0.0; fm2: 0.0; fm3: 1.0);

  { Unit bivector along @code(e₁∧e₂): @code(u12 = 1·e₁₂ + 0·e₁₃ + 0·e₂₃). }
  u12: TCL3Bivector = (fm12: 1.0; fm13: 0.0; fm23: 0.0);

  { Unit bivector along @code(e₁∧e₃): @code(u13 = 0·e₁₂ + 1·e₁₃ + 0·e₂₃). }
  u13: TCL3Bivector = (fm12: 0.0; fm13: 1.0; fm23: 0.0);

  { Unit bivector along @code(e₂∧e₃): @code(u23 = 0·e₁₂ + 0·e₁₃ + 1·e₂₃). }
  u23: TCL3Bivector = (fm12: 0.0; fm13: 0.0; fm23: 1.0);

  { Unit pseudoscalar: @code(u123 = 1·e₁∧e₂∧e₃). }
  u123: TCL3Trivector = (fm123: 1.0);


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

