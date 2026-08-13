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

{$H+}{$J-}
{$modeswitch advancedrecords}

interface

uses
  ADimMath, ADimRes, ADimCommon;

type
  { Enumeration of the eight basis blade components of a multivector in the
    Clifford algebra @code(Cl(3,0)) over @code(R3).

    The basis blades are:
    @unorderedList(
      @item(@code(mcm0)   - scalar part: @code(1))
      @item(@code(mcm1)   - vector basis blade: @code(e1))
      @item(@code(mcm2)   - vector basis blade: @code(e2))
      @item(@code(mcm3)   - vector basis blade: @code(e3))
      @item(@code(mcm12)  - bivector basis blade: @code(e1∧e2))
      @item(@code(mcm13)  - bivector basis blade: @code(e1∧e3))
      @item(@code(mcm23)  - bivector basis blade: @code(e2∧e3))
      @item(@code(mcm123) - pseudoscalar (trivector) basis blade: @code(e1∧e2∧e3))
    )
    The algebra satisfies @code(e1·e1 = +1) for all @code(i), and
    @code(e1·e2 = -e2·e1) for @code(i ≠ j).
  }
  TCL3MultivectorComponent = (mcm0, mcm1, mcm2, mcm3, mcm12, mcm13, mcm23, mcm123);

  { A set of @link(TCL3MultivectorComponent) values.
    Used to identify which components of a multivector are non-zero,
    e.g. to select or test specific grades.
  }
  TCL3MultivectorComponents = set of TCL3MultivectorComponent;

  { Represents a general multivector in the Clifford algebra @code(Cl(3,0)) over @code(R3).

    A multivector is the most general element of the algebra and is expressed as:
    @code(M = m0 + m1·e1 + m2·e2 + m3·e3 + m12·e12 + m13·e13 + m23·e23 + m123·e123)

    where:
    @unorderedList(
      @item(@code(m0) is the scalar part (grade 0))
      @item(@code(m1, m2, m3) are the vector components (grade 1))
      @item(@code(m12, m13, m23) are the bivector components (grade 2))
      @item(@code(m123) is the pseudoscalar component (grade 3))
    )

    The geometric product @code(·) is the fundamental product of the algebra,
    from which the inner product and outer (wedge) product can be derived.
    The algebra satisfies:
    @unorderedList(
      @item(@code(ei² = +1) for @code(i = 1, 2, 3))
      @item(@code(ei·ej = -ej·ei) for @code(i ≠ j))
      @item(@code(e1·e2·e3 = e123) - the unit pseudoscalar)
    )
  }
  TCL3Multivector = record
  private
    fm0: double;
    fm1: double;
    fm2: double;
    fm3: double;
    fm12: double;
    fm13: double;
    fm23: double;
    fm123: double;
  public
    { Implicit conversion from a real scalar to a multivector.
      All components are set to zero except the scalar part @code(m0 = AValue).
    }
    class operator :=(const AValue: double): TCL3Multivector;

    { Implicit conversion from a multivector to a real scalar.
      Returns the scalar part @code(m0). All other components are discarded.
      Use with care: this conversion is only meaningful for pure-scalar multivectors.
    }
    class operator :=(const AValue: TCL3Multivector): double;

    { Returns @true if the two multivectors differ in at least one component. }
    class operator <>(const ALeft, ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector differs from the scalar @code(ARight) in any component. }
    class operator <>(const ALeft: TCL3Multivector; const ARight: double): boolean;

    { Returns @true if the multivector @code(ARight) differs from the scalar @code(ALeft) in any component. }
    class operator <>(const ALeft: double; const ARight: TCL3Multivector): boolean;

    { Returns @true if all corresponding components of the two multivectors are equal. }
    class operator =(const ALeft, ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector equals the scalar @code(ARight), i.e. all non-scalar components are zero. }
    class operator =(const ALeft: TCL3Multivector; const ARight: double): boolean;

    { Returns @true if the multivector @code(ARight) equals the scalar @code(ALeft), i.e. all non-scalar components are zero. }
    class operator =(const ALeft: double; const ARight: TCL3Multivector): boolean;

    { Returns the component-wise sum of two multivectors. }
    class operator +(const ALeft, ARight: TCL3Multivector): TCL3Multivector;

    { Returns the sum of a multivector and a real scalar. Only the scalar component is affected. }
    class operator +(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;

    { Returns the sum of a real scalar and a multivector. Only the scalar component is affected. }
    class operator +(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;

    { Unary minus. Returns the negation of the multivector.
      Each component @code(mₖ) becomes @code(-mₖ).
    }
    class operator -(const ASelf: TCL3Multivector): TCL3Multivector;

    { Returns the component-wise difference of two multivectors. }
    class operator -(const ALeft, ARight: TCL3Multivector): TCL3Multivector;

    { Returns the difference of a multivector and a real scalar. Only the scalar component is affected. }
    class operator -(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;

    { Returns the difference of a real scalar and a multivector. Only the scalar component is affected. }
    class operator -(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric product of two multivectors.
      This is the fundamental product of the Clifford algebra @code(Cl(3,0)).
      It combines the inner (dot) and outer (wedge) products:
      @code(AB = A·B + A∧B).
      The geometric product is associative but generally non-commutative.
    }
    class operator *(const ALeft, ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric product of a multivector and a real scalar.
      Each component is scaled by @code(ARight).
    }
    class operator *(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;

    { Returns the geometric product of a real scalar and a multivector.
      Each component is scaled by @code(ALeft).
    }
    class operator *(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric quotient of two multivectors: @code(ALeft / ARight).
      The inverse @code(1/ARight) is computed using the reverse and the scalar norm.
      Not all multivectors are invertible; behaviour is undefined if @code(ARight)
      has no inverse.
    }
    class operator /(const ALeft, ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric quotient of a multivector divided by a real scalar.
      Each component is divided by @code(ARight).
    }
    class operator /(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;

    { Returns the geometric quotient of a real scalar divided by a multivector: @code(ALeft / ARight). }
    class operator /(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
  public
    property m0:   double read fm0   write fm0;
    property m1:   double read fm1   write fm1;
    property m2:   double read fm2   write fm2;
    property m3:   double read fm3   write fm3;
    property m12:  double read fm12  write fm12;
    property m13:  double read fm13  write fm13;
    property m23:  double read fm23  write fm23;
    property m123: double read fm123 write fm123;
  end;

  { Represents a pure trivector (pseudoscalar) in the Clifford algebra @code(Cl(3,0)).

    A trivector is a grade-3 element of the algebra, expressed as:
    @code(T = m123·e1∧e2∧e3)

    In @code(Cl(3,0)) the pseudoscalar @code(e123 = e1∧e2∧e3) satisfies:
    @code(e123² = -1), making it analogous to the imaginary unit in complex algebra.
    The pseudoscalar commutes with all elements of @code(Cl(3,0)) and generates
    the duality transformation between vectors and bivectors.

    When combined with elements of other grades the result is a full
    @link(TCL3Multivector). Operations between two trivectors produce a real
    scalar, since @code((m123·e123)·(n123·e123) = -m123·n123).
  }
  TCL3Trivector = record
  private
    fm123: double;
  public
    { Implicit conversion from a trivector to a full multivector.
      All components of the result are zero except @code(m123).
    }
    class operator :=(const AValue: TCL3Trivector): TCL3Multivector;

    { Implicit conversion from a multivector to a trivector.
      Returns only the grade-3 component @code(m123). All other components are discarded.
      Use with care: this conversion is only meaningful for pure-trivector multivectors.
    }
    class operator :=(const AValue: TCL3Multivector): TCL3Trivector;

    { Returns @true if the two trivectors have different @code(m123) coefficients. }
    class operator <>(const ALeft, ARight: TCL3Trivector): boolean;

    { Returns @true if the trivector and the multivector differ in any component. }
    class operator <>(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector and the trivector differ in any component. }
    class operator <>(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): boolean;

    { Returns @true if the two trivectors have equal @code(m123) coefficients. }
    class operator =(const ALeft, ARight: TCL3Trivector): boolean;

    { Returns @true if the trivector equals the multivector,
      i.e. all non-trivector components of @code(ARight) are zero.
    }
    class operator =(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector equals the trivector,
      i.e. all non-trivector components of @code(ALeft) are zero.
    }
    class operator =(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): boolean;

    { Returns the sum of two trivectors. The result is a pure trivector. }
    class operator +(const ALeft, ARight: TCL3Trivector): TCL3Trivector;

    { Returns the sum of a trivector and a real scalar.
      The result is a full multivector with @code(m0 = ARight) and @code(m123 = ALeft.m123).
    }
    class operator +(const ALeft: TCL3Trivector; const ARight: double): TCL3Multivector;

    { Returns the sum of a real scalar and a trivector.
      The result is a full multivector with @code(m0 = ALeft) and @code(m123 = ARight.m123).
    }
    class operator +(const ALeft: double; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the sum of a trivector and a multivector.
      The trivector contributes only to the grade-3 component.
    }
    class operator +(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the sum of a multivector and a trivector.
      The trivector contributes only to the grade-3 component.
    }
    class operator +(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;

    { Unary minus. Returns the negation of the trivector.
      The coefficient @code(m123) becomes @code(-m123).
    }
    class operator -(const ASelf: TCL3Trivector): TCL3Trivector;

    { Returns the difference of two trivectors. The result is a pure trivector. }
    class operator -(const ALeft, ARight: TCL3Trivector): TCL3Trivector;

    { Returns the difference of a trivector and a real scalar.
      The result is a full multivector with @code(m0 = -ARight) and @code(m123 = ALeft.m123).
    }
    class operator -(const ALeft: TCL3Trivector; const ARight: double): TCL3Multivector;

    { Returns the difference of a real scalar and a trivector.
      The result is a full multivector with @code(m0 = ALeft) and @code(m123 = -ARight.m123).
    }
    class operator -(const ALeft: double; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the difference of a trivector and a multivector.
      The trivector contributes only to the grade-3 component.
    }
    class operator -(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the difference of a multivector and a trivector.
      The trivector contributes only to the grade-3 component.
    }
    class operator -(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the geometric product of two trivectors as a real scalar.
      Since @code(e123² = -1), the result is:
      @code((m123·e123)·(n123·e123) = -m123·n123).
    }
    class operator *(const ALeft, ARight: TCL3Trivector): double;

    { Returns the geometric product of a real scalar and a trivector.
      The coefficient @code(m123) is scaled by @code(ALeft).
    }
    class operator *(const ALeft: double; const ARight: TCL3Trivector): TCL3Trivector;

    { Returns the geometric product of a trivector and a real scalar.
      The coefficient @code(m123) is scaled by @code(ARight).
    }
    class operator *(const ALeft: TCL3Trivector; const ARight: double): TCL3Trivector;

    { Returns the geometric product of a trivector and a multivector.
      The result is a full multivector. Grade mixing occurs according to the
      Clifford multiplication rules of @code(Cl(3,0)).
    }
    class operator *(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric product of a multivector and a trivector.
      The result is a full multivector. Grade mixing occurs according to the
      Clifford multiplication rules of @code(Cl(3,0)).
    }
    class operator *(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the geometric quotient of two trivectors as a real scalar.
      Computed as @code(ALeft / ARight). Since @code(e123² = -1),
      the result is: @code(m123 / (-n123) = -m123/n123).
    }
    class operator /(const ALeft, ARight: TCL3Trivector): double;

    { Returns the geometric quotient of a trivector divided by a real scalar.
      The coefficient @code(m123) is divided by @code(ARight).
    }
    class operator /(const ALeft: TCL3Trivector; const ARight: double): TCL3Trivector;

    { Returns the geometric quotient of a real scalar divided by a trivector: @code(ALeft / ARight).
      The inverse of a trivector @code(T = m123·e123) is @code(T⁻¹ = -e123/m123).
    }
    class operator /(const ALeft: double; const ARight: TCL3Trivector): TCL3Trivector;

    { Returns the geometric quotient of a trivector divided by a multivector: @code(ALeft / ARight).
      The result is a full multivector.
    }
    class operator /(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric quotient of a multivector divided by a trivector: @code(ALeft / ARight).
      The result is a full multivector.
    }
    class operator /(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;

  public
    property m123: double read fm123 write fm123;
  end;

  { Represents a pure bivector (grade-2 element) in the Clifford algebra @code(Cl(3,0)).

    A bivector is expressed as:
    @code(B = m12·e1∧e2 + m13·e1∧e3 + m23·e1∧e3)

    Geometrically, a bivector represents an oriented plane segment in @code(R3).
    In @code(Cl(3,0)) the basis bivectors satisfy:
    @unorderedList(
      @item(@code((e1∧e2)² = -1))
      @item(@code((e1∧e3)² = -1))
      @item(@code((e2∧e3)² = -1))
    )
    making bivectors analogous to quaternion basis elements @code(i, j, k).
    The subalgebra of even-grade elements (scalars and bivectors) is in fact
    isomorphic to the quaternion algebra @code(ℍ).

    The geometric product of two bivectors produces a mixed-grade result
    (scalar + bivector), hence the return type @link(TCL3Multivector).
    When combined with elements of other grades the result is always
    a full @link(TCL3Multivector).
  }
  TCL3Bivector = record
  private
    fm12: double;
    fm13: double;
    fm23: double;
  public
    { Implicit conversion from a bivector to a full multivector.
      All components of the result are zero except @code(m12), @code(m13), @code(m23).
    }
    class operator :=(const AValue: TCL3Bivector): TCL3Multivector;

    { Implicit conversion from a multivector to a bivector.
      Returns only the grade-2 components @code(m12), @code(m13), @code(m23).
      All other components are discarded.

      Use with care: this conversion is only meaningful for pure-bivector multivectors.
    }
    class operator :=(const AValue: TCL3Multivector): TCL3Bivector;

    { Returns @true if the two bivectors differ in at least one component. }
    class operator <>(const ALeft, ARight: TCL3Bivector): boolean;

    { Returns @true if the bivector and the multivector differ in any component. }
    class operator <>(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector and the bivector differ in any component. }
    class operator <>(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): boolean;

    { Returns @true if all corresponding components of the two bivectors are equal. }
    class operator =(const ALeft, ARight: TCL3Bivector): boolean;

    { Returns @true if the bivector equals the multivector,
      i.e. all non-bivector components of @code(ARight) are zero.
    }
    class operator =(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector equals the bivector,
      i.e. all non-bivector components of @code(ALeft) are zero.
    }
    class operator =(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): boolean;

    { Returns the component-wise sum of two bivectors.
      The result is a pure bivector.
    }
    class operator +(const ALeft, ARight: TCL3Bivector): TCL3Bivector;

    { Returns the sum of a bivector and a real scalar.
      The result is a full multivector with @code(m0 = ARight) and the bivector components of @code(ALeft).
    }
    class operator +(const ALeft: TCL3Bivector; const ARight: double): TCL3Multivector;

    { Returns the sum of a real scalar and a bivector.
      The result is a full multivector with @code(m0 = ALeft) and the bivector components of @code(ARight).
    }
    class operator +(const ALeft: double; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the sum of a bivector and a trivector.
      The result is a full multivector with grade-2 components from @code(ALeft)
      and grade-3 component from @code(ARight).
    }
    class operator +(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the sum of a trivector and a bivector.
      The result is a full multivector with grade-3 component from @code(ALeft)
      and grade-2 components from @code(ARight).
    }
    class operator +(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the sum of a bivector and a multivector.
      The bivector contributes only to the grade-2 components.
    }
    class operator +(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the sum of a multivector and a bivector.
      The bivector contributes only to the grade-2 components.
    }
    class operator +(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;

    { Unary minus. Returns the negation of the bivector.
      Each component @code(mₖ) becomes @code(-mₖ).
    }
    class operator -(const ASelf: TCL3Bivector): TCL3Bivector;

    { Returns the component-wise difference of two bivectors.
      The result is a pure bivector.
    }
    class operator -(const ALeft, ARight: TCL3Bivector): TCL3Bivector;

    { Returns the difference of a bivector and a real scalar.
      The result is a full multivector with @code(m0 = -ARight) and the bivector components of @code(ALeft).
    }
    class operator -(const ALeft: TCL3Bivector; const ARight: double): TCL3Multivector;

    { Returns the difference of a real scalar and a bivector.
      The result is a full multivector with @code(m0 = ALeft) and negated bivector components of @code(ARight).
    }
    class operator -(const ALeft: double; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the difference of a bivector and a trivector.
      The result is a full multivector with grade-2 components from @code(ALeft)
      and negated grade-3 component from @code(ARight).
    }
    class operator -(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the difference of a trivector and a bivector.
      The result is a full multivector with grade-3 component from @code(ALeft)
      and negated grade-2 components from @code(ARight).
    }
    class operator -(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the difference of a bivector and a multivector.
      The bivector contributes only to the grade-2 components.
    }
    class operator -(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the difference of a multivector and a bivector.
      The bivector contributes only to the grade-2 components.
    }
    class operator -(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric product of two bivectors.
      The result is a mixed-grade element (scalar + bivector), hence a full @link(TCL3Multivector).
      For example: @code((e₁∧e₂)·(e₁∧e₂) = -1) and @code((e₁∧e₂)·(e₁∧e₃) = -e₂∧e₃).
    }
    class operator *(const ALeft, ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric product of a real scalar and a bivector.
      Each component is scaled by @code(ALeft).
    }
    class operator *(const ALeft: double; const ARight: TCL3Bivector): TCL3Bivector;

    { Returns the geometric product of a bivector and a real scalar.
      Each component is scaled by @code(ARight).
    }
    class operator *(const ALeft: TCL3Bivector; const ARight: double): TCL3Bivector;

    { Returns the geometric product of a bivector and a multivector.
      Grade mixing occurs according to the Clifford multiplication rules of @code(Cl(3,0)).
    }
    class operator *(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric product of a bivector and a trivector.
      Since @code((e₁∧e₂)·(e₁∧e₂∧e₃) = e₃), the result mixes grades and
      is returned as a full @link(TCL3Multivector).
    }
    class operator *(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the geometric product of a trivector and a bivector.
      Grade mixing occurs according to the Clifford multiplication rules of @code(Cl(3,0)).
    }
    class operator *(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric product of a multivector and a bivector.
      Grade mixing occurs according to the Clifford multiplication rules of @code(Cl(3,0)).
    }
    class operator *(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric quotient of two bivectors: @code(ALeft / ARight).
      The result is a mixed-grade element, hence a full @link(TCL3Multivector).
      The inverse of a bivector @code(B) is @code(1/B = -B / |B|²) since @code(B² ≤ 0)
      for pure bivectors in @code(Cl(3,0)).
    }
    class operator /(const ALeft, ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric quotient of a bivector divided by a real scalar.
      Each component is divided by @code(ARight).
    }
    class operator /(const ALeft: TCL3Bivector; const ARight: double): TCL3Bivector;

    { Returns the geometric quotient of a real scalar divided by a bivector: @code(ALeft / ARight).
      The inverse of a bivector @code(B) is @code(1/B = -B / |B|²).
    }
    class operator /(const ALeft: double; const ARight: TCL3Bivector): TCL3Bivector;

    { Returns the geometric quotient of a bivector divided by a trivector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the geometric quotient of a trivector divided by a bivector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric quotient of a bivector divided by a multivector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric quotient of a multivector divided by a bivector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;

  public
    property m12:   double read fm12   write fm12;
    property m13:   double read fm13   write fm13;
    property m23:   double read fm23   write fm23;
  end;

  { Represents a pure vector (grade-1 element) in the Clifford algebra @code(Cl(3,0)).

    A vector is expressed as:
    @code(v = m1·e₁ + m2·e₂ + m3·e₃)

    Geometrically, a vector represents an oriented line segment in @code(R3).
    The basis vectors satisfy the fundamental Clifford relations:
    @unorderedList(
      @item(@code(ei² = +1) for @code(i = 1, 2, 3))
      @item(@code(ei·ej = -ej·ei) for @code(i ≠ j))
    )

    The geometric product of two vectors decomposes into a scalar (inner product)
    and a bivector (outer product):
    @code(uv = u·v + u∧v)
    where @code(u·v = Σ ui·vi) is the symmetric part and
    @code(u∧v) is the antisymmetric part, hence the return type @link(TCL3Multivector).

    Notable special products:
    @unorderedList(
      @item(@code(v · e₁₂₃ = v · (e₁∧e₂∧e₃)) maps a vector to a bivector (left dual))
      @item(@code(e₁₂₃ · v) maps a vector to a bivector (right dual))
    )
    These are reflected in the return type @link(TCL3Bivector) for products
    involving a @link(TCL3Trivector).
  }

  TCL3Vector = record
  private
    fm1: double;
    fm2: double;
    fm3: double;
  public
    { Implicit conversion from a vector to a full multivector.
      All components of the result are zero except @code(m1), @code(m2), @code(m3).
    }
    class operator :=(const AValue: TCL3Vector): TCL3Multivector;

    { Implicit conversion from a multivector to a vector.
      Returns only the grade-1 components @code(m1), @code(m2), @code(m3).
      All other components are discarded.
      Use with care: this conversion is only meaningful for pure-vector multivectors.
    }
    class operator :=(const AValue: TCL3Multivector): TCL3Vector;

    { Returns @true if the two vectors differ in at least one component. }
    class operator <>(const ALeft, ARight: TCL3Vector): boolean;

    { Returns @true if the vector and the multivector differ in any component. }
    class operator <>(const ALeft: TCL3Vector; const ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector and the vector differ in any component. }
    class operator <>(const ALeft: TCL3Multivector; const ARight: TCL3Vector): boolean;

    { Returns @true if all corresponding components of the two vectors are equal. }
    class operator =(const ALeft, ARight: TCL3Vector): boolean;

    { Returns @true if the vector equals the multivector, i.e. all non-vector components of @code(ARight) are zero. }
    class operator =(const ALeft: TCL3Vector; const ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector equals the vector, i.e. all non-vector components of @code(ALeft) are zero. }
    class operator =(const ALeft: TCL3Multivector; const ARight: TCL3Vector): boolean;

    { Returns the component-wise sum of two vectors. The result is a pure vector. }
    class operator +(const ALeft, ARight: TCL3Vector): TCL3Vector;

    { Returns the sum of a vector and a real scalar.
      The result is a full multivector with @code(m0 = ARight) and
      the vector components of @code(ALeft).
    }
    class operator +(const ALeft: TCL3Vector; const ARight: double): TCL3Multivector;

    { Returns the sum of a real scalar and a vector.
      The result is a full multivector with @code(m0 = ALeft) and
      the vector components of @code(ARight).
    }
    class operator +(const ALeft: double; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the sum of a vector and a bivector.
      The result is a full multivector with grade-1 components from @code(ALeft)
      and grade-2 components from @code(ARight).
    }
    class operator +(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the sum of a bivector and a vector.
      The result is a full multivector with grade-2 components from @code(ALeft)
      and grade-1 components from @code(ARight).
    }
    class operator +(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the sum of a vector and a trivector.
      The result is a full multivector with grade-1 components from @code(ALeft)
      and grade-3 component from @code(ARight).
    }
    class operator +(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the sum of a trivector and a vector.
      The result is a full multivector with grade-3 component from @code(ALeft)
      and grade-1 components from @code(ARight).
    }
    class operator +(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the sum of a vector and a multivector. The vector contributes only to the grade-1 components. }
    class operator +(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the sum of a multivector and a vector. The vector contributes only to the grade-1 components. }
    class operator +(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;

    { Unary minus. Returns the negation of the vector.
      Each component @code(mₖ) becomes @code(-mₖ).
    }
    class operator -(const ASelf: TCL3Vector): TCL3Vector;

    { Returns the component-wise difference of two vectors.
      The result is a pure vector.
    }
    class operator -(const ALeft, ARight: TCL3Vector): TCL3Vector;

    { Returns the difference of a vector and a real scalar.
      The result is a full multivector with @code(m0 = -ARight) and
      the vector components of @code(ALeft).
    }
    class operator -(const ALeft: TCL3Vector; const ARight: double): TCL3Multivector;

    { fference of a real scalar and a vector.
      The result is a full multivector with @code(m0 = ALeft) and
      negated vector components of @code(ARight).
    }
    class operator -(const ALeft: double; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the difference of a vector and a bivector.
      The result is a full multivector with grade-1 components from @code(ALeft)
      and negated grade-2 components from @code(ARight).
    }
    class operator -(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the difference of a bivector and a vector.
      The result is a full multivector with grade-2 components from @code(ALeft)
      and negated grade-1 components from @code(ARight).
    }
    class operator -(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the difference of a vector and a trivector.
      The result is a full multivector with grade-1 components from @code(ALeft)
      and negated grade-3 component from @code(ARight).
    }
    class operator -(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the difference of a trivector and a vector.
      The result is a full multivector with grade-3 component from @code(ALeft)
      and negated grade-1 components from @code(ARight).
    }
    class operator -(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the difference of a vector and a multivector.
      The vector contributes only to the grade-1 components.
    }
    class operator -(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the difference of a multivector and a vector.
      The vector contributes only to the grade-1 components.
    }
    class operator -(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the geometric product of two vectors.
      The result decomposes into a scalar and a bivector:
      @code(uv = u·v + u∧v)
      hence the return type is a full @link(TCL3Multivector).
    }
    class operator *(const ALeft, ARight: TCL3Vector): TCL3Multivector;

    { Returns the geometric product of a real scalar and a vector.
      Each component is scaled by @code(ALeft).
    }
    class operator *(const ALeft: double; const ARight: TCL3Vector): TCL3Vector;

    { Returns the geometric product of a vector and a real scalar.
      Each component is scaled by @code(ARight).
    }
    class operator *(const ALeft: TCL3Vector; const ARight: double): TCL3Vector;

    { Returns the geometric product of a vector and a bivector.
      The result mixes grades (scalar and trivector parts may appear),
      hence the return type is a full @link(TCL3Multivector).
    }
    class operator *(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric product of a vector and the pseudoscalar @code(e₁₂₃).
      Since @code(v · e₁₂₃) maps each basis vector to its complementary bivector
      (e.g. @code(e₁·e₁₂₃ = e₂₃)), the result is a pure @link(TCL3Bivector).
      This operation corresponds to the left Hodge dual of the vector.
    }
    class operator *(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Bivector;

    { Returns the geometric product of a vector and a full multivector.
      Grade mixing occurs according to the Clifford multiplication rules of @code(Cl(3,0)).
    }
    class operator *(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric product of a bivector and a vector.
      The result mixes grades, hence the return type is a full @link(TCL3Multivector).
    }
    class operator *(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the geometric product of the pseudoscalar @code(e₁₂₃) and a vector.
      Since @code(e₁₂₃ · v) maps each basis vector to its complementary bivector
      (e.g. @code(e₁₂₃·e₁ = e₂₃)), the result is a pure @link(TCL3Bivector).
      This operation corresponds to the right Hodge dual of the vector.
    }
    class operator *(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Bivector;

    { Returns the geometric product of a full multivector and a vector.
      Grade mixing occurs according to the Clifford multiplication rules of @code(Cl(3,0)).
    }
    class operator *(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the geometric quotient of a real scalar divided by a vector: @code(ALeft / ARight).
      The inverse of a vector @code(v) in @code(Cl(3,0)) is @code(1/v = v / |v|²),
      since @code(v² = |v|²) for vectors with positive norm.
      The result is a pure vector.
    }
    class operator /(const ALeft: double; const ARight: TCL3Vector): TCL3Vector;

    { Returns the geometric quotient of a vector divided by a real scalar.
      Each component is divided by @code(ARight).
    }
    class operator /(const ALeft: TCL3Vector; const ARight: double): TCL3Vector;

    { Returns the geometric quotient of two vectors: @code(ALeft / ARight).
      The result is a mixed-grade element (scalar + bivector),
      hence the return type is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft, ARight: TCL3Vector): TCL3Multivector;

    { Returns the geometric quotient of a vector divided by a bivector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric quotient of a vector divided by the pseudoscalar: @code(ALeft / ARight).
      Since the inverse of @code(e₁₂₃) is @code(-e₁₂₃), this maps the vector
      to its complementary bivector, returning a pure @link(TCL3Bivector).
      This corresponds to the Hodge dual of the vector.
    }
    class operator /(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Bivector;

    { Returns the geometric quotient of a vector divided by a full multivector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric quotient of a bivector divided by a vector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the geometric quotient of the pseudoscalar divided by a vector: @code(ALeft / ARight).
      Since @code(e₁₂₃ · v⁻¹) maps the vector to its complementary bivector,
      the result is a pure @link(TCL3Bivector).
    }
    class operator /(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Bivector;

    { Returns the geometric quotient of a full multivector divided by a vector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;

  public
    property m1:   double read fm1   write fm1;
    property m2:   double read fm2   write fm2;
    property m3:   double read fm3   write fm3;
  end;

  { Record helper for @link(TCL3Multivector) providing the full set of geometric algebra
    operations for @code(Cl(3,0)).

    Extends @link(TCL3Multivector) with grade-aware operations including duality,
    reversion, conjugation, projection, rejection, reflection, and rotation,
    as well as utility functions for grade testing, component extraction, and
    string conversion.
  }
  TCL3MultivectorHelper = record helper for TCL3Multivector

    { Returns the Hodge dual of the multivector.
      In @code(Cl(3,0)) the dual is defined as @code(M* = M · e₁₂₃⁻¹).
      The dual exchanges grade @code(k) elements with grade @code(3-k) elements:
      scalars ↔ trivector, vectors ↔ bivectors.
    }
    function Dual: TCL3Multivector;

    { Returns the inverse of the multivector: @code(1/M) such that @code(M · M⁻¹ = 1).
      Not all multivectors are invertible. Behaviour is undefined if the
      multivector has no inverse.
    }
    function Inverse: TCL3Multivector;

    { Returns the reverse of the multivector.
      The reverse @code(M†) is obtained by reversing the order of basis vectors
      in each blade: @code((ei∧ej)† = ei∧ej = -ej∧ei).
      Grade-@code(k) components are multiplied by @code((-1)^(k(k-1)/2)):
      @unorderedList(
        @item(Grade 0 and 1: unchanged)
        @item(Grade 2: negated)
        @item(Grade 3: negated)
      )
    }
    function Reverse: TCL3Multivector;

    { Returns the Clifford conjugate of the multivector.
      The conjugate combines reversion and grade involution.
      Grade-@code(k) components are multiplied by @code((-1)^(k(k+1)/2)):
      @unorderedList(
        @item(Grade 0: unchanged)
        @item(Grade 1: negated)
        @item(Grade 2: negated)
        @item(Grade 3: unchanged)
      )
    }
    function Conjugate: TCL3Multivector;

    { Returns the right reciprocal of the multivector: @code(M⁻¹) such that @code(M · M⁻¹ = 1).
      Computed as @code(Reverse / SquaredNorm) when the multivector is
      norm-invertible. Equivalent to @link(Inverse) for versors.
    }
    function Reciprocal: TCL3Multivector;

    { Returns the left reciprocal of the multivector: @code(M⁻¹) such that @code(M⁻¹ · M = 1).
      For non-symmetric multivectors the left and right reciprocals may differ.
    }
    function LeftReciprocal: TCL3Multivector;

    { Returns the unit multivector in the same direction.
      Each component is divided by @link(Norm).
      The result satisfies @code(|Normalized| = 1).
    }
    function Normalized: TCL3Multivector;

    { Returns the norm of the multivector.
      Defined as @code(|M| = √|M · Reverse(M)|).
    }
    function Norm: double;

    { Returns the squared norm of the multivector.
      Defined as @code(|M|² = |M · Reverse(M)|).
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: double;

    { Returns the inner (dot) product of the multivector with a vector.
      The inner product extracts the grade @code(|p-q|) part of the geometric product,
      contracting the two operands.
      @param(AVector The right-hand vector operand.)
    }
    function Dot(const AVector: TCL3Vector): TCL3Multivector; overload;

    { Returns the inner (dot) product of the multivector with a bivector.
      @param(AVector The right-hand bivector operand.)
    }
    function Dot(const AVector: TCL3Bivector): TCL3Multivector; overload;

    { Returns the inner (dot) product of the multivector with a trivector.
      @param(AVector The right-hand trivector operand.)
    }
    function Dot(const AVector: TCL3Trivector): TCL3Multivector; overload;

    { Returns the inner (dot) product of two multivectors.
      @param(AVector The right-hand multivector operand.)
    }
    function Dot(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the outer (wedge) product of the multivector with a vector.
      The wedge product extracts the grade @code(p+q) part of the geometric product,
      constructing a higher-grade blade from the two operands.
      @param(AVector The right-hand vector operand.)
    }
    function Wedge(const AVector: TCL3Vector): TCL3Multivector; overload;

    { Returns the outer (wedge) product of the multivector with a bivector.
      @param(AVector The right-hand bivector operand.)
    }
    function Wedge(const AVector: TCL3Bivector): TCL3Multivector; overload;

    { Returns the outer (wedge) product of the multivector with a trivector.
      Since @code(e₁₂₃) is the highest-grade element in @code(Cl(3,0)),
      the result is a pure @link(TCL3Trivector) (only the scalar part of the
      multivector contributes).
      @param(AVector The right-hand trivector operand.)
    }
    function Wedge(const AVector: TCL3Trivector): TCL3Trivector; overload;

    { Returns the outer (wedge) product of two multivectors.
      @param(AVector The right-hand multivector operand.)
    }
    function Wedge(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the projection of the multivector onto a vector subspace.
      Defined as @code(Proj_v(M) = (M · v) · v⁻¹).
      @param(AVector The vector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Vector): TCL3Multivector; overload;

    { Returns the projection of the multivector onto a bivector subspace.
      Defined as @code(Proj_B(M) = (M · B) · B⁻¹).
      @param(AVector The bivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Bivector): TCL3Multivector; overload;

    { Returns the projection of the multivector onto the trivector subspace.
      Since the trivector spans the entire space in @code(Cl(3,0)), the
      projection returns the full multivector scaled accordingly.
      @param(AVector The trivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Trivector): TCL3Multivector; overload;

    { Returns the projection of the multivector onto a general multivector subspace.
      @param(AVector The multivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the rejection of the multivector from a vector subspace.
      Defined as @code(Rej_v(M) = (M ∧ v) · v⁻¹).
      The rejection is the component of @code(M) orthogonal to @code(v):
      @code(M = Projection + Rejection).
      @param(AVector The vector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Vector): TCL3Multivector; overload;

    { Returns the rejection of the multivector from a bivector subspace.
      Defined as @code(Rej_B(M) = (M ∧ B) · B⁻¹).
      @param(AVector The bivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Bivector): TCL3Multivector; overload;

    { Returns the rejection of the multivector from the trivector subspace as a scalar.
      Since the trivector spans the entire space, the rejection reduces to a
      scalar coefficient.
      @param(AVector The trivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Trivector): double; overload;

    { Returns the rejection of the multivector from a general multivector subspace.
      @param(AVector The multivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the reflection of the multivector through a vector hyperplane.
      Defined as @code(v · M · v⁻¹), which reflects all components of @code(M)
      through the hyperplane perpendicular to @code(v).
      @param(AVector The vector defining the hyperplane of reflection.)
    }
    function Reflection(const AVector: TCL3Vector): TCL3Multivector; overload;

    { Returns the reflection of the multivector through a bivector subspace.
      Defined as @code(B · M · B⁻¹).
      @param(AVector The bivector defining the subspace of reflection.)
    }
    function Reflection(const AVector: TCL3Bivector): TCL3Multivector; overload;

    { Returns the reflection of the multivector through the trivector subspace.
      Defined as @code(e₁₂₃ · M · e₁₂₃⁻¹).
      @param(AVector The trivector defining the subspace of reflection.)
    }
    function Reflection(const AVector: TCL3Trivector): TCL3Multivector; overload;

    { Returns the reflection of the multivector through a general multivector subspace.
      Defined as @code(N · M · N⁻¹).
      @param(AVector The multivector defining the subspace of reflection.)
    }
    function Reflection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the rotation of the multivector in the plane defined by two vectors.
      The rotation is performed by the versor @code(R = v₁·v₂), applied as
      @code(R · M · R⁻¹). The rotation angle is twice the angle between
      @code(AVector1) and @code(AVector2).
      @param(AVector1 The first vector defining the rotation plane.)
      @param(AVector2 The second vector defining the rotation plane.)
    }
    function Rotation(const AVector1, AVector2: TCL3Vector): TCL3Multivector; overload;

    { Returns the rotation of the multivector using a bivector rotor sandwich product.
      Applied as @code(R · M · R⁻¹) where @code(R = AVector1 · AVector2).
      @param(AVector1 The first bivector operand of the rotor.)
      @param(AVector2 The second bivector operand of the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Multivector; overload;

    { Returns the rotation of the multivector using a trivector rotor sandwich product.
      Applied as @code(R · M · R⁻¹) where @code(R = AVector1 · AVector2).
      @param(AVector1 The first trivector operand of the rotor.)
      @param(AVector2 The second trivector operand of the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Multivector; overload;

    { Returns the rotation of the multivector using a general multivector rotor.
      Applied as @code(R · M · R⁻¹) where @code(R = AVector1 · AVector2).
      @param(AVector1 The first multivector operand of the rotor.)
      @param(AVector2 The second multivector operand of the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector; overload;

    { Returns @true if all components of the multivector are numerically close
      to the corresponding components of @code(AValue), within floating point tolerance.
      @param(AValue The multivector to compare against.)
    }
    function SameValue(const AValue: TCL3Multivector): boolean; overload;

    { Returns @true if the multivector is numerically close to the trivector @code(AValue),
      i.e. all non-trivector components are negligible.
      @param(AValue The trivector to compare against.)
    }
    function SameValue(const AValue: TCL3Trivector): boolean; overload;

    { Returns @true if the multivector is numerically close to the bivector @code(AValue),
      i.e. all non-bivector components are negligible.
      @param(AValue The bivector to compare against.)
    }
    function SameValue(const AValue: TCL3Bivector): boolean; overload;

    { Returns @true if the multivector is numerically close to the vector @code(AValue),
      i.e. all non-vector components are negligible.
      @param(AValue The vector to compare against.)
    }
    function SameValue(const AValue: TCL3Vector): boolean; overload;

    { Returns @true if the multivector is numerically close to the scalar @code(AValue),
      i.e. all non-scalar components are negligible.
      @param(AValue The scalar to compare against.)
    }
    function SameValue(const AValue: double): boolean; overload;

    { Extracts selected components from the multivector as a @link(TCL3Multivector).
      Only the components specified in @code(AComponents) are retained;
      all others are set to zero.
      @param(AComponents The set of components to extract.)
    }
    function ExtractMultivector(AComponents: TCL3MultivectorComponents): TCL3Multivector;

    { Extracts selected bivector components from the multivector.
      Only grade-2 components present in @code(AComponents) are retained.
      @param(AComponents The set of components to extract.)
    }
    function ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3Bivector; overload;

    { Extracts selected vector components from the multivector.
      Only grade-1 components present in @code(AComponents) are retained.
      @param(AComponents The set of components to extract.)
    }
    function ExtractVector(AComponents: TCL3MultivectorComponents): TCL3Vector; overload;

    { Extracts the grade-3 (pseudoscalar) component of the multivector.
      All other components are discarded.
    }
    function ExtractTrivector: TCL3Trivector;

    { Extracts all grade-2 (bivector) components of the multivector.
      All other components are discarded.
    }
    function ExtractBivector: TCL3Bivector; overload;

    { Extracts all grade-1 (vector) components of the multivector.
      All other components are discarded.
    }
    function ExtractVector: TCL3Vector; overload;

    { Extracts the grade-0 (scalar) component of the multivector.
      All other components are discarded.
    }
    function ExtractScalar: double;

    { Returns @true if all components of the multivector are zero or numerically negligible. }
    function IsNull: boolean;

    { Returns @true if the multivector is a pure scalar, i.e. all non-scalar components are zero. }
    function IsScalar: boolean;

    { Returns @true if the multivector is a pure vector (grade 1), i.e. only grade-1 components are non-zero. }
    function IsVector: boolean;

    { Returns @true if the multivector is a pure bivector (grade 2), i.e. only grade-2 components are non-zero. }
    function IsBiVector: boolean;

    { Returns @true if the multivector is a pure trivector (grade 3), i.e. only the grade-3 component is non-zero. }
    function IsTrivector: boolean;

    { Returns a string identifying the grade structure of the multivector.
      Examples of possible return values: @code('scalar'), @code('vector'),
      @code('bivector'), @code('trivector'), @code('multivector').
    }
    function IsA: string;

    { Converts the multivector to a formatted string with controlled precision.
      Only non-zero components are included in the output.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: longint): string;

    { Converts the multivector to its default string representation.
      Only non-zero components are included in the output.
    }
    function ToString: string;
  end;

  { Record helper for @link(TCL3Trivector) providing geometric operations
    specific to grade-3 elements of @code(Cl(3,0)).

    All operations follow the conventions of Clifford algebra over @code(ℝ³):
    @unorderedList(
      @item(The geometric product is the fundamental product of the algebra.)
      @item(The inner (dot) product lowers the grade of the result.)
      @item(The outer (wedge) product raises the grade of the result.)
      @item(The dual maps a grade-@code(k) element to a grade-@code(3-k) element
            via multiplication by @code(e₁₂₃⁻¹).)
      @item(Projection, rejection, reflection and rotation are defined via the
            geometric product and its inverse.)
    )
  }
  TCL3TrivectorHelper = record helper for TCL3Trivector

    { Returns the dual of the trivector with respect to the pseudoscalar @code(e₁₂₃).
      For @code(T = m123·e₁₂₃), the dual is the scalar:
      @code(T* = T · e₁₂₃⁻¹ = -m123).
      The dual maps grade-3 elements to grade-0 (scalar) elements.
    }
    function Dual: double;

    { Returns the inverse of the trivector under the geometric product.
      For @code(T = m123·e₁₂₃):
      @code(T⁻¹ = -e₁₂₃ / m123), since @code(e₁₂₃² = -1).
    }
    function Inverse: TCL3Trivector;

    { Returns the reverse of the trivector.
      The reverse of a grade-@code(k) blade changes sign by @code((-1)^(k·(k-1)/2)).
      For a trivector (@code(k = 3)): @code(T̃ = -T).
    }
    function Reverse: TCL3Trivector;

    { Returns the Clifford conjugate of the trivector.
      The conjugate combines reversion and grade involution.
      For a trivector (@code(k = 3)): @code(T† = -T).
    }
    function Conjugate: TCL3Trivector;

    { Returns the reciprocal of the trivector: @code(T̃ / (T · T̃)).
      Equivalent to @link(Inverse) for non-zero trivectors.
    }
    function Reciprocal: TCL3Trivector;

    { Returns the unit trivector in the same direction.
      The coefficient @code(m123) is divided by @link(Norm).
    }
    function Normalized: TCL3Trivector;

    { Returns the norm of the trivector: @code(|T| = |m123|).
      Defined as the square root of @code(T · T̃).
    }
    function Norm: double;

    { Returns the squared norm of the trivector: @code(|T|² = m123²).
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: double;

    { Returns the inner (dot) product of the trivector and a vector.
      Lowers the grade: @code(grade(3) · grade(1) → grade(2) = bivector).
      @param(AVector The grade-1 right operand.)
    }
    function Dot(const AVector: TCL3Vector): TCL3Bivector; overload;

    { Returns the inner (dot) product of the trivector and a bivector.
      Lowers the grade: @code(grade(3) · grade(2) → grade(1) = vector).
      @param(AVector The grade-2 right operand.)
    }
    function Dot(const AVector: TCL3Bivector): TCL3Vector; overload;

    { Returns the inner (dot) product of two trivectors.
      Lowers the grade: @code(grade(3) · grade(3) → grade(0) = scalar).
      Result: @code(T₁ · T₂ = -m123₁ · m123₂).
      @param(AVector The grade-3 right operand.)
    }
    function Dot(const AVector: TCL3Trivector): double; overload;

    { Returns the inner (dot) product of the trivector and a multivector.
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The right operand.)
    }
    function Dot(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the outer (wedge) product of the trivector and a vector.
      Always zero in @code(ℝ³): @code(grade(3) ∧ grade(1) → grade(4) = 0).
      @param(AVector The grade-1 right operand.)
    }
    function Wedge(const AVector: TCL3Vector): double; overload;

    { Returns the outer (wedge) product of the trivector and a bivector.
      Always zero in @code(ℝ³): @code(grade(3) ∧ grade(2) → grade(5) = 0).
      @param(AVector The grade-2 right operand.)
    }
    function Wedge(const AVector: TCL3Bivector): double; overload;

    { Returns the outer (wedge) product of two trivectors.
      Always zero in @code(ℝ³): @code(grade(3) ∧ grade(3) → grade(6) = 0).
      @param(AVector The grade-3 right operand.)
    }
    function Wedge(const AVector: TCL3Trivector): double; overload;

    { Returns the outer (wedge) product of the trivector and a multivector.
      Only the scalar part of @code(AVector) contributes to a non-zero result,
      since any higher-grade wedge product vanishes in @code(ℝ³).
      @param(AVector The right operand.)
    }
    function Wedge(const AVector: TCL3Multivector): TCL3Trivector; overload;

    { Returns the projection of the trivector onto a vector subspace.
      Defined as: @code(proj(T, v) = (T · v⁻¹) ∧ v).
      @param(AVector The vector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Vector): TCL3Trivector; overload;

    { Returns the projection of the trivector onto a bivector subspace.
      Defined as: @code(proj(T, B) = (T · B⁻¹) ∧ B).
      @param(AVector The bivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Bivector): TCL3Trivector; overload;

    { Returns the projection of the trivector onto a trivector subspace.
      Defined as: @code(proj(T₁, T₂) = (T₁ · T₂⁻¹) ∧ T₂).
      @param(AVector The trivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Trivector): TCL3Trivector; overload;

    { Returns the projection of the trivector onto a multivector subspace.
      Defined as: @code(proj(T, M) = (T · M⁻¹) ∧ M).
      @param(AVector The multivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Multivector): TCL3Trivector; overload;

    { Returns the rejection of the trivector from a vector subspace.
      Defined as: @code(rej(T, v) = T - proj(T, v)).
      In @code(ℝ³) the rejection of a trivector from a vector is a scalar.
      @param(AVector The vector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Vector): double; overload;

    { Returns the rejection of the trivector from a bivector subspace.
      Defined as: @code(rej(T, B) = T - proj(T, B)).
      In @code(ℝ³) the rejection of a trivector from a bivector is a scalar.
      @param(AVector The bivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Bivector): double; overload;

    { Returns the rejection of the trivector from another trivector subspace.
      Defined as: @code(rej(T₁, T₂) = T₁ - proj(T₁, T₂)).
      In @code(ℝ³) the rejection of a trivector from a trivector is a scalar.
      @param(AVector The trivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Trivector): double; overload;

    { Returns the rejection of the trivector from a multivector subspace.
      Defined as: @code(rej(T, M) = T - proj(T, M)).
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The multivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the reflection of the trivector through a vector.
      Defined as: @code(reflect(T, v) = -v · T · v⁻¹).
      Since the trivector is the pseudoscalar up to a scalar factor, the
      reflection preserves the grade-3 part.
      @param(AVector The vector defining the reflection hyperplane normal.)
    }
    function Reflection(const AVector: TCL3Vector): TCL3Trivector; overload;

    { Returns the reflection of the trivector through a bivector.
      Defined as: @code(reflect(T, B) = -B · T · B⁻¹).
      @param(AVector The bivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Bivector): TCL3Trivector; overload;

    { Returns the reflection of the trivector through another trivector.
      Defined as: @code(reflect(T₁, T₂) = -T₂ · T₁ · T₂⁻¹).
      @param(AVector The trivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Trivector): TCL3Trivector; overload;

    { Returns the reflection of the trivector through a multivector.
      Defined as: @code(reflect(T, M) = -M · T · M⁻¹).
      @param(AVector The multivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Multivector): TCL3Trivector; overload;

    { Returns the trivector rotated by the rotor defined by two vectors.
      The rotor is constructed as @code(R = AVector2 · AVector1)
      (normalised to a unit rotor). The rotation is applied as:
      @code(T' = R · T · R⁻¹).
      @param(AVector1 The first vector defining the rotation plane.)
      @param(AVector2 The second vector defining the rotation plane.)
    }
    function Rotation(const AVector1, AVector2: TCL3Vector): TCL3Trivector; overload;

    { Returns the trivector rotated by the rotor defined by two bivectors.
      The rotation is applied as: @code(T' = R · T · R⁻¹).
      @param(AVector1 The first bivector defining the rotor.)
      @param(AVector2 The second bivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Trivector; overload;

    { Returns the trivector rotated by the rotor defined by two trivectors.
      The rotation is applied as: @code(T' = R · T · R⁻¹).
      @param(AVector1 The first trivector defining the rotor.)
      @param(AVector2 The second trivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Trivector; overload;

    { Returns the trivector rotated by the rotor defined by two multivectors.
      The rotation is applied as: @code(T' = R · T · R⁻¹).
      @param(AVector1 The first multivector defining the rotor.)
      @param(AVector2 The second multivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Trivector; overload;

    { Returns @true if the trivector is numerically equal to the given multivector
      within the default floating point tolerance.
      All non-trivector components of @code(AValue) must be negligible.
      @param(AValue The multivector to compare against.)
    }
    function SameValue(const AValue: TCL3Multivector): boolean;

    { Returns @true if the two trivectors are numerically equal
      within the default floating point tolerance.
      @param(AValue The trivector to compare against.)
    }
    function SameValue(const AValue: TCL3Trivector): boolean;

    { Converts the trivector to a full @link(TCL3Multivector).
      All components are zero except @code(m123).
    }
    function ToMultivector: TCL3Multivector;

    { Converts the trivector to a formatted string with controlled precision.
      The format is @code(m123·e₁₂₃).
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: longint): string;

    { Converts the trivector to its default string representation.
      The format is @code(m123·e₁₂₃).
    }
    function ToString: string;
  end;

  { Record helper for @link(TCL3Bivector) providing geometric operations
    specific to grade-2 elements of @code(Cl(3,0)).

    All operations follow the conventions of Clifford algebra over @code(ℝ³):
    @unorderedList(
      @item(The geometric product is the fundamental product of the algebra.)
      @item(The inner (dot) product lowers the grade of the result.)
      @item(The outer (wedge) product raises the grade of the result.)
      @item(The dual maps a grade-@code(k) element to a grade-@code(3-k) element
            via multiplication by @code(e₁₂₃⁻¹).)
      @item(Projection, rejection, reflection and rotation are defined via the
            geometric product and its inverse.)
    )
  }
  TCL3BivectorHelper = record helper for TCL3Bivector

    { Returns the dual of the bivector with respect to the pseudoscalar @code(e₁₂₃).
      The dual maps grade-2 elements to grade-1 (vector) elements:
      @code(B* = B · e₁₂₃⁻¹).
      For example: @code((e₁∧e₂)* = -e₃),  @code((e₁∧e₃)* = e₂),  @code((e₂∧e₃)* = -e₁).
    }
    function Dual: TCL3Vector;

    { Returns the inverse of the bivector under the geometric product.
      For a pure bivector @code(B), the inverse is:
      @code(B⁻¹ = -B / |B|²), since @code(B² ≤ 0) in @code(Cl(3,0)).
    }
    function Inverse: TCL3Bivector;

    { Returns the reverse of the bivector.
      The reverse of a grade-@code(k) blade changes sign by @code((-1)^(k·(k-1)/2)).
      For a bivector (@code(k = 2)): @code(B̃ = -B).
    }
    function Reverse: TCL3Bivector;

    { Returns the Clifford conjugate of the bivector.
      The conjugate combines reversion and grade involution.
      For a bivector (@code(k = 2)): @code(B† = -B).
    }
    function Conjugate: TCL3Bivector;

    {
      Returns the reciprocal of the bivector: @code(B̃ / (B · B̃)).
      Equivalent to @link(Inverse) for non-zero bivectors.
    }
    function Reciprocal: TCL3Bivector;

    { Returns the unit bivector in the same orientation.
      Each component is divided by @link(Norm).
    }
    function Normalized: TCL3Bivector;

    { Returns the norm of the bivector: @code(|B| = √(m12² + m13² + m23²)).
      Defined as the square root of @code(-B²) since @code(B² ≤ 0) for pure bivectors.
    }
    function Norm: double;

    { Returns the squared norm of the bivector: @code(|B|² = m12² + m13² + m23²).
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: double;

    { Returns the inner (dot) product of the bivector and a vector.
      Lowers the grade: @code(grade(2) · grade(1) → grade(1) = vector).
      @param(AVector The grade-1 right operand.)
    }
    function Dot(const AVector: TCL3Vector): TCL3Vector; overload;

    { Returns the inner (dot) product of two bivectors.
      Lowers the grade: @code(grade(2) · grade(2) → grade(0) = scalar).
      Result: @code(B₁ · B₂ = -(m12₁·m12₂ + m13₁·m13₂ + m23₁·m23₂)).
      @param(AVector The grade-2 right operand.)
    }
    function Dot(const AVector: TCL3Bivector): double; overload;

    { Returns the inner (dot) product of the bivector and a trivector.
      Lowers the grade: @code(grade(2) · grade(3) → grade(1) = vector).
      @param(AVector The grade-3 right operand.)
    }
    function Dot(const AVector: TCL3Trivector): TCL3Vector; overload;

    { Returns the inner (dot) product of the bivector and a multivector.
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The right operand.)
    }
    function Dot(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the outer (wedge) product of the bivector and a vector.
      Raises the grade: @code(grade(2) ∧ grade(1) → grade(3) = trivector).
      @param(AVector The grade-1 right operand.)
    }
    function Wedge(const AVector: TCL3Vector): TCL3Trivector; overload;

    { Returns the outer (wedge) product of two bivectors.
      Always zero in @code(ℝ³): @code(grade(2) ∧ grade(2) → grade(4) = 0).
      @param(AVector The grade-2 right operand.)
    }
    function Wedge(const AVector: TCL3Bivector): double; overload;

    { Returns the outer (wedge) product of the bivector and a trivector.
      Always zero in @code(ℝ³): @code(grade(2) ∧ grade(3) → grade(5) = 0).
      @param(AVector The grade-3 right operand.)
    }
    function Wedge(const AVector: TCL3Trivector): double; overload;

    { Returns the outer (wedge) product of the bivector and a multivector.
      Only the scalar and vector parts of @code(AVector) contribute to a
      non-zero result; higher-grade wedge products vanish in @code(ℝ³).
      @param(AVector The right operand.)
    }
    function Wedge(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the projection of the bivector onto a vector subspace.
      Defined as: @code(proj(B, v) = (B · v⁻¹) ∧ v).
      The result is the component of @code(B) that lies in the plane
      containing @code(v).
      @param(AVector The vector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Vector): TCL3Bivector; overload;

    { Returns the projection of the bivector onto another bivector subspace.
      Defined as: @code(proj(B₁, B₂) = (B₁ · B₂⁻¹) ∧ B₂).
      @param(AVector The bivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Bivector): TCL3Bivector; overload;

    { Returns the projection of the bivector onto a trivector subspace.
      Defined as: @code(proj(B, T) = (B · T⁻¹) ∧ T).
      Since the trivector spans all of @code(ℝ³), the projection of any
      bivector onto it returns the bivector unchanged.
      @param(AVector The trivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Trivector): TCL3Bivector; overload;

    { Returns the projection of the bivector onto a multivector subspace.
      Defined as: @code(proj(B, M) = (B · M⁻¹) ∧ M).
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The multivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the rejection of the bivector from a vector subspace.
      Defined as: @code(rej(B, v) = B - proj(B, v)).
      The result is the component of @code(B) orthogonal to @code(v).
      @param(AVector The vector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Vector): TCL3Bivector; overload;

    { Returns the rejection of the bivector from another bivector subspace.
      Defined as: @code(rej(B₁, B₂) = B₁ - proj(B₁, B₂)).
      In @code(ℝ³) the rejection of a bivector from a bivector is a scalar.
      @param(AVector The bivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Bivector): double; overload;

    { Returns the rejection of the bivector from a trivector subspace.
      Defined as: @code(rej(B, T) = B - proj(B, T)).
      In @code(ℝ³) the rejection of a bivector from a trivector is a scalar.
      @param(AVector The trivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Trivector): double; overload;

    { Returns the rejection of the bivector from a multivector subspace.
      Defined as: @code(rej(B, M) = B - proj(B, M)).
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The multivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the reflection of the bivector through a vector.
      Defined as: @code(reflect(B, v) = -v · B · v⁻¹).
      Reflects the oriented plane of @code(B) through the hyperplane
      orthogonal to @code(v).
      @param(AVector The vector defining the reflection hyperplane normal.)
    }
    function Reflection(const AVector: TCL3Vector): TCL3Bivector; overload;

    { Returns the reflection of the bivector through another bivector.
      Defined as: @code(reflect(B₁, B₂) = -B₂ · B₁ · B₂⁻¹).
      @param(AVector The bivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Bivector): TCL3Bivector; overload;

    { Returns the reflection of the bivector through a trivector.
      Defined as: @code(reflect(B, T) = -T · B · T⁻¹).
      Since the pseudoscalar commutes with all even-grade elements, the
      reflection through a trivector returns the bivector unchanged.
      @param(AVector The trivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Trivector): TCL3Bivector; overload;

    { Returns the reflection of the bivector through a multivector.
      Defined as: @code(reflect(B, M) = -M · B · M⁻¹).
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The multivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the bivector rotated by the rotor defined by two vectors.
      The rotor is constructed as @code(R = AVector2 · AVector1)
      (normalised to a unit rotor). The rotation is applied as:
      @code(B' = R · B · R⁻¹).
      @param(AVector1 The first vector defining the rotation plane.)
      @param(AVector2 The second vector defining the rotation plane.)
    }
    function Rotation(const AVector1, AVector2: TCL3Vector): TCL3Bivector; overload;

    { Returns the bivector rotated by the rotor defined by two bivectors.
      The rotation is applied as: @code(B' = R · B · R⁻¹).
      @param(AVector1 The first bivector defining the rotor.)
      @param(AVector2 The second bivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Bivector; overload;

    { Returns the bivector rotated by the rotor defined by two trivectors.
      The rotation is applied as: @code(B' = R · B · R⁻¹).
      @param(AVector1 The first trivector defining the rotor.)
      @param(AVector2 The second trivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Bivector; overload;

    { Returns the bivector rotated by the rotor defined by two multivectors.
      The rotation is applied as: @code(B' = R · B · R⁻¹).
      The result is a full @link(TCL3Multivector) due to potential grade mixing.
      @param(AVector1 The first multivector defining the rotor.)
      @param(AVector2 The second multivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector; overload;

    { Returns @true if the bivector is numerically equal to the given multivector
      within the default floating point tolerance.
      All non-bivector components of @code(AValue) must be negligible.
      @param(AValue The multivector to compare against.)
    }
    function SameValue(const AValue: TCL3Multivector): boolean;

    { Returns @true if the two bivectors are numerically equal
      within the default floating point tolerance.
      @param(AValue The bivector to compare against.)
    }
    function SameValue(const AValue: TCL3Bivector): boolean;

    { Returns a new bivector containing only the components specified by @code(AComponents).
      Components not present in @code(AComponents) are set to zero.
      Useful for extracting specific basis blade contributions from a bivector.
      @param(AComponents A set of @link(TCL3MultivectorComponent) values identifying
                         the components to retain. Valid values are @code(mcm12),
                         @code(mcm13), @code(mcm23).)
    }
    function ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3Bivector;

    { Converts the bivector to a full @link(TCL3Multivector).
      All components are zero except @code(m12), @code(m13), @code(m23).
    }
    function ToMultivector: TCL3Multivector;

    { Converts the bivector to a formatted string with controlled precision.
      The format is @code(m12·e₁₂ + m13·e₁₃ + m23·e₂₃).
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: longint): string;

    { Converts the bivector to its default string representation.
      The format is @code(m12·e₁₂ + m13·e₁₃ + m23·e₂₃).
    }
    function ToString: string;
  end;

  { Record helper for @link(TCL3Vector) providing geometric operations
    specific to grade-1 elements of @code(Cl(3,0)).

    All operations follow the conventions of Clifford algebra over @code(R3):
    @unorderedList(
      @item(The geometric product is the fundamental product of the algebra.)
      @item(The inner (dot) product lowers the grade of the result.)
      @item(The outer (wedge) product raises the grade of the result.)
      @item(The dual maps a grade-@code(k) element to a grade-@code(3-k) element
            via multiplication by @code(e₁₂₃⁻¹)* )
      @item(The cross product is the dual of the wedge product:
            @code(u × v = (u ∧ v)* ) and is specific to @code(ℝ³).)
      @item(Projection, rejection, reflection and rotation are defined via the
            geometric product and its inverse.)
    )
  }
  TCL3VectorHelper = record helper for TCL3Vector

    { Returns the dual of the vector with respect to the pseudoscalar @code(e₁₂₃).
      The dual maps grade-1 elements to grade-2 (bivector) elements:
      @code(v* = v · e₁₂₃⁻¹).
      For example: @code(e₁* = -e₂∧e₃), @code(e₂* = e₁∧e₃), @code(e₃* = -e₁∧e₂).
    }
    function Dual: TCL3Bivector;

    { Returns the inverse of the vector under the geometric product.
      For a non-zero vector @code(v):
      @code(v⁻¹ = v / |v|²), since @code(v² = |v|² > 0) in @code(Cl(3,0)).
    }
    function Inverse: TCL3Vector;

    { Returns the reverse of the vector.
      The reverse of a grade-@code(k) blade changes sign by @code((-1)^(k·(k-1)/2)).
      For a vector (@code(k = 1)): @code(ṽ = v) (unchanged).
    }
    function Reverse: TCL3Vector;

    { Returns the Clifford conjugate of the vector.
      The conjugate combines reversion and grade involution.
      For a vector (@code(k = 1)): @code(v† = -v).
    }
    function Conjugate: TCL3Vector;

    { Returns the reciprocal of the vector: @code(ṽ / (v · ṽ)).
      Equivalent to @link(Inverse) for non-zero vectors.
    }
    function Reciprocal: TCL3Vector;

    { Returns the unit vector in the same direction.
      Each component is divided by @link(Norm).
    }
    function Normalized: TCL3Vector;

    { Returns the Euclidean norm of the vector: @code(|v| = √(m1² + m2² + m3²)).
      Defined as the square root of @code(v · ṽ = v²) since @code(v² ≥ 0)
      for vectors in @code(Cl(3,0)).
    }
    function Norm: double;

    { Returns the squared Euclidean norm of the vector:
      @code(|v|² = m1² + m2² + m3²).
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: double;

    { Returns the inner (dot) product of two vectors.
      Lowers the grade: @code(grade(1) · grade(1) → grade(0) = scalar).
      Result: @code(u · v = m1₁·m1₂ + m2₁·m2₂ + m3₁·m3₂).
      @param(AVector The grade-1 right operand.)
    }
    function Dot(const AVector: TCL3Vector): double; overload;

    { Returns the inner (dot) product of a vector and a bivector.
      Lowers the grade: @code(grade(1) · grade(2) → grade(1) = vector).
      @param(AVector The grade-2 right operand.)
    }
    function Dot(const AVector: TCL3Bivector): TCL3Vector; overload;

    { Returns the inner (dot) product of a vector and a trivector.
      Lowers the grade: @code(grade(1) · grade(3) → grade(2) = bivector).
      @param(AVector The grade-3 right operand.)
    }
    function Dot(const AVector: TCL3Trivector): TCL3Bivector; overload;

    { Returns the inner (dot) product of a vector and a multivector.
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The right operand.)
    }
    function Dot(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the outer (wedge) product of two vectors.
      Raises the grade: @code(grade(1) ∧ grade(1) → grade(2) = bivector).
      The result represents the oriented plane spanned by the two vectors.
      @param(AVector The grade-1 right operand.)
    }
    function Wedge(const AVector: TCL3Vector): TCL3Bivector; overload;

    { Returns the outer (wedge) product of a vector and a bivector.
      Raises the grade: @code(grade(1) ∧ grade(2) → grade(3) = trivector).
      The result represents the oriented volume spanned by the vector and the bivector.
      @param(AVector The grade-2 right operand.)
    }
    function Wedge(const AVector: TCL3Bivector): TCL3Trivector; overload;

    { Returns the outer (wedge) product of a vector and a trivector.
      Always zero in @code(ℝ³): @code(grade(1) ∧ grade(3) → grade(4) = 0).
      @param(AVector The grade-3 right operand.)
    }
    function Wedge(const AVector: TCL3Trivector): double; overload;

    { Returns the outer (wedge) product of a vector and a multivector.
      Only components of @code(AVector) up to grade 2 contribute to a non-zero result.
      @param(AVector The right operand.)
    }
    function Wedge(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the cross product of two vectors.
      The cross product is the dual of the wedge product:
      @code(u × v = (u ∧ v)* = -(u ∧ v) · e₁₂₃⁻¹).
      The result is a vector perpendicular to both operands with magnitude
      @code(|u||v|sin(θ)), specific to @code(ℝ³).
      @param(AVector The right operand.)
    }
    function Cross(const AVector: TCL3Vector): TCL3Vector;

    { Returns the projection of the vector onto another vector.
      Defined as: @code(proj(u, v) = (u · v⁻¹) ∧ v = (u · v / |v|²) · v).
      The result is the component of @code(u) parallel to @code(v).
      @param(AVector The vector defining the direction to project onto.)
    }
    function Projection(const AVector: TCL3Vector): TCL3Vector; overload;

    { Returns the projection of the vector onto a bivector subspace.
      Defined as: @code(proj(v, B) = (v · B⁻¹) ∧ B).
      The result is the component of @code(v) lying in the plane of @code(B).
      @param(AVector The bivector defining the plane to project onto.)
    }
    function Projection(const AVector: TCL3Bivector): TCL3Vector; overload;

    { Returns the projection of the vector onto a trivector subspace.
      Defined as: @code(proj(v, T) = (v · T⁻¹) ∧ T).
      Since the trivector spans all of @code(ℝ³), the projection of any
      vector onto it returns the vector unchanged.
      @param(AVector The trivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Trivector): TCL3Vector; overload;

    { Returns the projection of the vector onto a multivector subspace.
      Defined as: @code(proj(v, M) = (v · M⁻¹) ∧ M).
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The multivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the rejection of the vector from another vector.
      Defined as: @code(rej(u, v) = u - proj(u, v)).
      The result is the component of @code(u) perpendicular to @code(v).
      @param(AVector The vector defining the direction to reject from.)
    }
    function Rejection(const AVector: TCL3Vector): TCL3Vector; overload;

    { Returns the rejection of the vector from a bivector subspace.
      Defined as: @code(rej(v, B) = v - proj(v, B)).
      The result is the component of @code(v) perpendicular to the plane of @code(B).
      @param(AVector The bivector defining the plane to reject from.)
    }
    function Rejection(const AVector: TCL3Bivector): TCL3Vector; overload;

    { Returns the rejection of the vector from a trivector subspace.
      Defined as: @code(rej(v, T) = v - proj(v, T)).
      In @code(ℝ³) the rejection of a vector from a trivector is always zero,
      returned as a scalar @code(0).
      @param(AVector The trivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Trivector): double; overload;

    { Returns the rejection of the vector from a multivector subspace.
      Defined as: @code(rej(v, M) = v - proj(v, M)).
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The multivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the reflection of the vector through another vector.
      Defined as: @code(reflect(u, v) = v · u · v⁻¹).
      Reflects @code(u) through the line defined by @code(v),
      reversing the perpendicular component and preserving the parallel one.
      @param(AVector The vector defining the reflection axis.)
    }
    function Reflection(const AVector: TCL3Vector): TCL3Vector; overload;

    { Returns the reflection of the vector through a bivector.
      Defined as: @code(reflect(v, B) = B · v · B⁻¹).
      Reflects @code(v) through the plane represented by @code(B),
      reversing the normal component and preserving the in-plane component.
      @param(AVector The bivector defining the reflection plane.)
    }
    function Reflection(const AVector: TCL3Bivector): TCL3Vector; overload;

    { Returns the reflection of the vector through a trivector.
      Defined as: @code(reflect(v, T) = T · v · T⁻¹).
      Since the pseudoscalar commutes with odd-grade elements up to a sign,
      the reflection through a trivector negates the vector: @code(T·v·T⁻¹ = -v).
      @param(AVector The trivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Trivector): TCL3Vector; overload;

    { Returns the reflection of the vector through a multivector.
      Defined as: @code(reflect(v, M) = M · v · M⁻¹).
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The multivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the vector rotated by the rotor defined by two vectors.
      The rotor is constructed as @code(R = AVector2 · AVector1)
      (normalised to a unit rotor). The rotation is applied as:
      @code(v' = R · v · R⁻¹).
      The rotation is in the plane spanned by @code(AVector1) and @code(AVector2),
      by twice the angle between them.
      @param(AVector1 The first vector defining the rotation plane.)
      @param(AVector2 The second vector defining the rotation plane.)
    }
    function Rotation(const AVector1, AVector2: TCL3Vector): TCL3Vector; overload;

    { Returns the vector rotated by the rotor defined by two bivectors.
      The rotation is applied as: @code(v' = R · v · R⁻¹).
      @param(AVector1 The first bivector defining the rotor.)
      @param(AVector2 The second bivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Vector; overload;

    { Returns the vector rotated by the rotor defined by two trivectors.
      The rotation is applied as: @code(v' = R · v · R⁻¹).
      @param(AVector1 The first trivector defining the rotor.)
      @param(AVector2 The second trivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Vector; overload;

    { Returns the vector rotated by the rotor defined by two multivectors.
      The rotation is applied as: @code(v' = R · v · R⁻¹).
      The result is a full @link(TCL3Multivector) due to potential grade mixing.
      @param(AVector1 The first multivector defining the rotor.)
      @param(AVector2 The second multivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector; overload;

    { Returns @true if the vector is numerically equal to the given multivector
      within the default floating point tolerance.
      All non-vector components of @code(AValue) must be negligible.
      @param(AValue The multivector to compare against.)
    }
    function SameValue(const AValue: TCL3Multivector): boolean;

    { Returns @true if the two vectors are numerically equal
      within the default floating point tolerance.
      @param(AValue The vector to compare against.)
    }
    function SameValue(const AValue: TCL3Vector): boolean;

    { Returns a new vector containing only the components specified by @code(AComponents).
      Components not present in @code(AComponents) are set to zero.
      Useful for extracting specific basis blade contributions from a vector.
      @param(AComponents A set of @link(TCL3MultivectorComponent) values identifying
                         the components to retain. Valid values are @code(mcm1),
                         @code(mcm2), @code(mcm3).)
    }
    function ExtractVector(AComponents: TCL3MultivectorComponents): TCL3Vector;

    { Converts the vector to a full @link(TCL3Multivector).
      All components are zero except @code(m1), @code(m2), @code(m3).
    }
    function ToMultivector: TCL3Multivector;

    { Converts the vector to a formatted string with controlled precision.
      The format is @code(m1·e₁ + m2·e₂ + m3·e₃).
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: longint): string;

    { Converts the vector to its default string representation.
      The format is @code(m1·e₁ + m2·e₂ + m3·e₃).
    }
    function ToString: string;
  end;

  { Represents the basis vector @code(e₁) of @code(Cl(3,0)).
    Acts as a compile-time constant unit vector along the first axis.
    Multiplying a scalar by this record yields a grade-1 vector scaled along @code(e₁).
  }
  TCL3Versor1 = record
    { Returns the vector @code(AValue · e₁).
      @code(AValue * e₁ = (0, AValue, 0, 0, ...))
    }
    class operator *(const AValue: double; const ASelf: TCL3Versor1): TCL3Vector;
  end;

  { Represents the basis vector @code(e₂) of @code(Cl(3,0)).
    Acts as a compile-time constant unit vector along the second axis.
    Multiplying a scalar by this record yields a grade-1 vector scaled along @code(e₂).
  }
  TCL3Versor2 = record
    { Returns the vector @code(AValue · e₂).
      @code(AValue * e₂ = (0, 0, AValue, 0, ...))
    }
    class operator *(const AValue: double; const ASelf: TCL3Versor2): TCL3Vector;
  end;

  { Represents the basis vector @code(e₃) of @code(Cl(3,0)).
    Acts as a compile-time constant unit vector along the third axis.
    Multiplying a scalar by this record yields a grade-1 vector scaled along @code(e₃).
  }
  TCL3Versor3 = record
    { Returns the vector @code(AValue · e₃).
      @code(AValue * e₃ = (0, 0, 0, AValue, ...))
    }
    class operator *(const AValue: double; const ASelf: TCL3Versor3): TCL3Vector;
  end;

  { Represents the basis bivector @code(e₁∧e₂) of @code(Cl(3,0)).
    Acts as a compile-time constant unit bivector in the @code(e₁e₂) plane.
    Multiplying a scalar by this record yields a grade-2 bivector scaled along @code(e₁∧e₂).
    Satisfies @code((e₁∧e₂)² = -1).
  }
  TCL3Biversor12 = record
    { Returns the bivector @code(AValue · e₁∧e₂).
      @code(AValue * e₁₂ = (0, ..., AValue, 0, 0, 0))
    }
    class operator *(const AValue: double; const ASelf: TCL3Biversor12): TCL3Bivector;
  end;

  { Represents the basis bivector @code(e₁∧e₃) of @code(Cl(3,0)).
    Acts as a compile-time constant unit bivector in the @code(e₁e₃) plane.
    Multiplying a scalar by this record yields a grade-2 bivector scaled along @code(e₁∧e₃).
    Satisfies @code((e₁∧e₃)² = -1).
  }
  TCL3Biversor13 = record
    { Returns the bivector @code(AValue · e₁∧e₃).
      @code(AValue * e₁₃ = (0, ..., 0, AValue, 0, 0))
    }
    class operator *(const AValue: double; const ASelf: TCL3Biversor13): TCL3Bivector;
  end;

  { Represents the basis bivector @code(e₂∧e₃) of @code(Cl(3,0)).
    Acts as a compile-time constant unit bivector in the @code(e₂e₃) plane.
    Multiplying a scalar by this record yields a grade-2 bivector scaled along @code(e₂∧e₃).
    Satisfies @code((e₂∧e₃)² = -1).
  }
  TCL3Biversor23 = record
    { Returns the bivector @code(AValue · e₂∧e₃).
      @code(AValue * e₂₃ = (0, ..., 0, 0, AValue, 0))
    }
    class operator *(const AValue: double; const ASelf: TCL3Biversor23): TCL3Bivector;
  end;

  { Represents the unit pseudoscalar @code(e₁∧e₂∧e₃) of @code(Cl(3,0)).
    Acts as a compile-time constant unit trivector (the oriented unit volume of @code(ℝ³)).
    Multiplying a scalar by this record yields a grade-3 trivector scaled along @code(e₁∧e₂∧e₃).
    Satisfies @code((e₁∧e₂∧e₃)² = -1).
    The pseudoscalar commutes with all elements of @code(Cl(3,0)) and generates
    the duality transformation between vectors and bivectors.
  }
  TCL3Triversor123 = record
    { Returns the trivector @code(AValue · e₁∧e₂∧e₃).
      @code(AValue * e₁₂₃ = (0, ..., AValue))
    }
    class operator *(const AValue: double; const ASelf: TCL3Triversor123): TCL3Trivector;
  end;

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

// TCL3Multivector

class operator TCL3Multivector.:=(const AValue: double): TCL3Multivector;
begin
  result.fm0   := AValue;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

class operator TCL3Multivector.:=(const AValue: TCL3Multivector): double;
begin
  result := AValue;
end;

class operator TCL3Multivector.<>(const ALeft, ARight: TCL3Multivector): boolean;
begin
  result := (ALeft.fm0   <> ARight.fm0  ) or
            (ALeft.fm1   <> ARight.fm1  ) or
            (ALeft.fm2   <> ARight.fm2  ) or
            (ALeft.fm3   <> ARight.fm3  ) or
            (ALeft.fm12  <> ARight.fm12 ) or
            (ALeft.fm13  <> ARight.fm13 ) or
            (ALeft.fm23  <> ARight.fm23 ) or
            (ALeft.fm123 <> ARight.fm123);
end;

class operator TCL3Multivector.<>(const ALeft: TCL3Multivector; const ARight: double): boolean;
begin
  result := (ALeft.fm0   <> ARight) or
            (ALeft.fm1   <>    0.0) or
            (ALeft.fm2   <>    0.0) or
            (ALeft.fm3   <>    0.0) or
            (ALeft.fm12  <>    0.0) or
            (ALeft.fm13  <>    0.0) or
            (ALeft.fm23  <>    0.0) or
            (ALeft.fm123 <>    0.0);
end;

class operator TCL3Multivector.<>(const ALeft: double; const ARight: TCL3Multivector): boolean;
begin
  result := (ALeft <> ARight.fm0  ) or
            (0.0   <> ARight.fm1  ) or
            (0.0   <> ARight.fm2  ) or
            (0.0   <> ARight.fm3  ) or
            (0.0   <> ARight.fm12 ) or
            (0.0   <> ARight.fm13 ) or
            (0.0   <> ARight.fm23 ) or
            (0.0   <> ARight.fm123);
end;

class operator TCL3Multivector.=(const ALeft: TCL3Multivector; const ARight: double): boolean;
begin
  result := (ARight <> ALeft.fm0  ) or
            (0.0    <> ALeft.fm1  ) or
            (0.0    <> ALeft.fm2  ) or
            (0.0    <> ALeft.fm3  ) or
            (0.0    <> ALeft.fm12 ) or
            (0.0    <> ALeft.fm13 ) or
            (0.0    <> ALeft.fm23 ) or
            (0.0    <> ALeft.fm123);
end;

class operator TCL3Multivector.=(const ALeft: double; const ARight: TCL3Multivector): boolean;
begin
  result := (ALeft = ARight.fm0  ) or
            (0.0   = ARight.fm1  ) or
            (0.0   = ARight.fm2  ) or
            (0.0   = ARight.fm3  ) or
            (0.0   = ARight.fm12 ) or
            (0.0   = ARight.fm13 ) or
            (0.0   = ARight.fm23 ) or
            (0.0   = ARight.fm123);
end;

class operator TCL3Multivector.=(const ALeft, ARight: TCL3Multivector): boolean;
begin
  result := (ALeft.fm0   = ARight.fm0  ) or
            (ALeft.fm1   = ARight.fm1  ) or
            (ALeft.fm2   = ARight.fm2  ) or
            (ALeft.fm3   = ARight.fm3  ) or
            (ALeft.fm12  = ARight.fm12 ) or
            (ALeft.fm13  = ARight.fm13 ) or
            (ALeft.fm23  = ARight.fm23 ) or
            (ALeft.fm123 = ARight.fm123);
end;

class operator TCL3Multivector.+(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0 + ARight;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Multivector.+(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ARight.fm0 + ALeft;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Multivector.+(const ALeft, ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0   + ARight.fm0;
  result.fm1   := ALeft.fm1   + ARight.fm1;
  result.fm2   := ALeft.fm2   + ARight.fm2;
  result.fm3   := ALeft.fm3   + ARight.fm3;
  result.fm12  := ALeft.fm12  + ARight.fm12;
  result.fm13  := ALeft.fm13  + ARight.fm13;
  result.fm23  := ALeft.fm23  + ARight.fm23;
  result.fm123 := ALeft.fm123 + ARight.fm123;
end;

class operator TCL3Multivector.-(const ASelf: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := -ASelf.fm0;
  result.fm1   := -ASelf.fm1;
  result.fm2   := -ASelf.fm2;
  result.fm3   := -ASelf.fm3;
  result.fm12  := -ASelf.fm12;
  result.fm13  := -ASelf.fm13;
  result.fm23  := -ASelf.fm23;
  result.fm123 := -ASelf.fm123;
end;

class operator TCL3Multivector.-(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0 - ARight;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Multivector.-(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ALeft - ARight.fm0;
  result.fm1   :=       - ARight.fm1;
  result.fm2   :=       - ARight.fm2;
  result.fm3   :=       - ARight.fm3;
  result.fm12  :=       - ARight.fm12;
  result.fm13  :=       - ARight.fm13;
  result.fm23  :=       - ARight.fm23;
  result.fm123 :=       - ARight.fm123;
end;

class operator TCL3Multivector.-(const ALeft, ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0   - ARight.fm0;
  result.fm1   := ALeft.fm1   - ARight.fm1;
  result.fm2   := ALeft.fm2   - ARight.fm2;
  result.fm3   := ALeft.fm3   - ARight.fm3;
  result.fm12  := ALeft.fm12  - ARight.fm12;
  result.fm13  := ALeft.fm13  - ARight.fm13;
  result.fm23  := ALeft.fm23  - ARight.fm23;
  result.fm123 := ALeft.fm123 - ARight.fm123;
end;

class operator TCL3Multivector.*(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0   * ARight;
  result.fm1   := ALeft.fm1   * ARight;
  result.fm2   := ALeft.fm2   * ARight;
  result.fm3   := ALeft.fm3   * ARight;
  result.fm12  := ALeft.fm12  * ARight;
  result.fm13  := ALeft.fm13  * ARight;
  result.fm23  := ALeft.fm23  * ARight;
  result.fm123 := ALeft.fm123 * ARight;
end;

class operator TCL3Multivector.*(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ALeft * ARight.fm0;
  result.fm1   := ALeft * ARight.fm1;
  result.fm2   := ALeft * ARight.fm2;
  result.fm3   := ALeft * ARight.fm3;
  result.fm12  := ALeft * ARight.fm12;
  result.fm13  := ALeft * ARight.fm13;
  result.fm23  := ALeft * ARight.fm23;
  result.fm123 := ALeft * ARight.fm123;
end;

class operator TCL3Multivector.*(const ALeft, ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0 :=     ALeft.fm0   * ARight.fm0
                  + ALeft.fm1   * ARight.fm1
                  + ALeft.fm2   * ARight.fm2
                  + ALeft.fm3   * ARight.fm3
                  - ALeft.fm12  * ARight.fm12
                  - ALeft.fm13  * ARight.fm13
                  - ALeft.fm23  * ARight.fm23
                  - ALeft.fm123 * ARight.fm123;

  result.fm1 :=     ALeft.fm0   * ARight.fm1
                  + ALeft.fm1   * ARight.fm0
                  - ALeft.fm2   * ARight.fm12
                  - ALeft.fm3   * ARight.fm13
                  + ALeft.fm12  * ARight.fm2
                  + ALeft.fm13  * ARight.fm3
                  - ALeft.fm23  * ARight.fm123
                  - ALeft.fm123 * ARight.fm23;

  result.fm2 :=     ALeft.fm0   * ARight.fm2
                  + ALeft.fm1   * ARight.fm12
                  + ALeft.fm2   * ARight.fm0
                  - ALeft.fm3   * ARight.fm23
                  - ALeft.fm12  * ARight.fm1
                  + ALeft.fm13  * ARight.fm123
                  + ALeft.fm23  * ARight.fm3
                  + ALeft.fm123 * ARight.fm13;

  result.fm3 :=     ALeft.fm0   * ARight.fm3
                  + ALeft.fm1   * ARight.fm13
                  + ALeft.fm2   * ARight.fm23
                  + ALeft.fm3   * ARight.fm0
                  - ALeft.fm12  * ARight.fm123
                  - ALeft.fm13  * ARight.fm1
                  - ALeft.fm23  * ARight.fm2
                  - ALeft.fm123 * ARight.fm12;

  result.fm12 :=    ALeft.fm0   * ARight.fm12
                  + ALeft.fm1   * ARight.fm2
                  - ALeft.fm2   * ARight.fm1
                  + ALeft.fm3   * ARight.fm123
                  + ALeft.fm12  * ARight.fm0
                  - ALeft.fm13  * ARight.fm23
                  + ALeft.fm23  * ARight.fm13
                  + ALeft.fm123 * ARight.fm3;

  result.fm23 :=    ALeft.fm0   * ARight.fm23
                  + ALeft.fm1   * ARight.fm123
                  + ALeft.fm2   * ARight.fm3
                  - ALeft.fm3   * ARight.fm2
                  - ALeft.fm12  * ARight.fm13
                  + ALeft.fm13  * ARight.fm12
                  + ALeft.fm23  * ARight.fm0
                  + ALeft.fm123 * ARight.fm1;

  result.fm13  :=   ALeft.fm0   * ARight.fm13
                  + ALeft.fm1   * ARight.fm3
                  - ALeft.fm2   * ARight.fm123
                  - ALeft.fm3   * ARight.fm1
                  + ALeft.fm12  * ARight.fm23
                  + ALeft.fm13  * ARight.fm0
                  - ALeft.fm23  * ARight.fm12
                  - ALeft.fm123 * ARight.fm2;

  result.fm123 := + ALeft.fm0   * ARight.fm123
                  + ALeft.fm1   * ARight.fm23
                  - ALeft.fm2   * ARight.fm13
                  + ALeft.fm3   * ARight.fm12
                  + ALeft.fm12  * ARight.fm3
                  - ALeft.fm13  * ARight.fm2
                  + ALeft.fm23  * ARight.fm1
                  + ALeft.fm123 * ARight.fm0;
end;

class operator TCL3Multivector./(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0   / ARight;
  result.fm1   := ALeft.fm1   / ARight;
  result.fm2   := ALeft.fm2   / ARight;
  result.fm3   := ALeft.fm3   / ARight;
  result.fm12  := ALeft.fm12  / ARight;
  result.fm13  := ALeft.fm13  / ARight;
  result.fm23  := ALeft.fm23  / ARight;
  result.fm123 := ALeft.fm123 / ARight;
end;

class operator TCL3Multivector./(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Multivector./(const ALeft, ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

// TCL3Trivector

class operator TCL3Trivector.:=(const AValue: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := AValue.fm123;
end;

class operator TCL3Trivector.:=(const AValue: TCL3Multivector): TCL3Trivector;
begin
  result.fm123 := AValue.fm123;
end;

class operator TCL3Trivector.<>(const ALeft, ARight: TCL3Trivector): boolean;
begin
  result := ALeft.fm123 <> ARight.fm123;
end;

class operator TCL3Trivector.<>(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): boolean;
begin
  result := (ALeft.fm0   <>          0.0) or
            (ALeft.fm1   <>          0.0) or
            (ALeft.fm2   <>          0.0) or
            (ALeft.fm3   <>          0.0) or
            (ALeft.fm12  <>          0.0) or
            (ALeft.fm13  <>          0.0) or
            (ALeft.fm23  <>          0.0) or
            (ALeft.fm123 <> ARight.fm123);
end;

class operator TCL3Trivector.<>(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): boolean;
begin
  result := (0.0         <> ARight.fm0  ) or
            (0.0         <> ARight.fm1  ) or
            (0.0         <> ARight.fm2  ) or
            (0.0         <> ARight.fm3  ) or
            (0.0         <> ARight.fm12 ) or
            (0.0         <> ARight.fm13 ) or
            (0.0         <> ARight.fm23 ) or
            (ALeft.fm123 <> ARight.fm123);
end;

class operator TCL3Trivector.=(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): boolean;
begin
  result := (ALeft.fm0   =          0.0) or
            (ALeft.fm1   =          0.0) or
            (ALeft.fm2   =          0.0) or
            (ALeft.fm3   =          0.0) or
            (ALeft.fm12  =          0.0) or
            (ALeft.fm13  =          0.0) or
            (ALeft.fm23  =          0.0) or
            (ALeft.fm123 = ARight.fm123);
end;

class operator TCL3Trivector.=(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): boolean;
begin
  result := (0.0         = ARight.fm0  ) or
            (0.0         = ARight.fm1  ) or
            (0.0         = ARight.fm2  ) or
            (0.0         = ARight.fm3  ) or
            (0.0         = ARight.fm12 ) or
            (0.0         = ARight.fm13 ) or
            (0.0         = ARight.fm23 ) or
            (ALeft.fm123 = ARight.fm123);
end;

class operator TCL3Trivector.=(const ALeft, ARight: TCL3Trivector): boolean;
begin
  result := ALeft.fm123 = ARight.fm123;
end;

class operator TCL3Trivector.+(const ALeft, ARight: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := ALeft.fm123 + ARight.fm123;
end;

class operator TCL3Trivector.+(const ALeft: TCL3Trivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ARight;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Trivector.+(const ALeft: double; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := ALeft;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Trivector.+(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123 + ARight.fm123;
end;

class operator TCL3Trivector.+(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ARight.fm0;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := ARight.fm123 + ALeft.fm123;
end;

class operator TCL3Trivector.-(const ASelf: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := -ASelf.fm123;
end;

class operator TCL3Trivector.-(const ALeft, ARight: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := ALeft.fm123 - ARight.fm123;
end;

class operator TCL3Trivector.-(const ALeft: TCL3Trivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := -ARight;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 :=  ALeft.fm123;
end;

class operator TCL3Trivector.-(const ALeft: double; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   :=  ALeft;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 := -ARight.fm123;
end;

class operator TCL3Trivector.-(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123 - ARight.fm123;
end;

class operator TCL3Trivector.-(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=             - ARight.fm0;
  result.fm1   :=             - ARight.fm1;
  result.fm2   :=             - ARight.fm2;
  result.fm3   :=             - ARight.fm3;
  result.fm12  :=             - ARight.fm12;
  result.fm13  :=             - ARight.fm13;
  result.fm23  :=             - ARight.fm23;
  result.fm123 := ALeft.fm123 - ARight.fm123;
end;

class operator TCL3Trivector.*(const ALeft: double; const ARight: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := ALeft * ARight.fm123;
end;

class operator TCL3Trivector.*(const ALeft: TCL3Trivector; const ARight: double): TCL3Trivector;
begin
  result.fm123 := ALeft.fm123 * ARight;
end;

class operator TCL3Trivector.*(const ALeft, ARight: TCL3Trivector): double;
begin
  result := -ALeft.fm123 * ARight.fm123;
end;

class operator TCL3Trivector.*(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := -ALeft.fm123 * ARight.fm123;
  result.fm1   := -ALeft.fm23  * ARight.fm123;
  result.fm2   :=  ALeft.fm13  * ARight.fm123;
  result.fm3   := -ALeft.fm12  * ARight.fm123;
  result.fm12  :=  ALeft.fm3   * ARight.fm123;
  result.fm13  := -ALeft.fm2   * ARight.fm123;
  result.fm23  :=  ALeft.fm1   * ARight.fm123;
  result.fm123 :=  ALeft.fm0   * ARight.fm123;
end;

class operator TCL3Trivector.*(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := -ALeft.fm123 * ARight.fm123;
  result.fm1   := -ALeft.fm123 * ARight.fm23;
  result.fm2   :=  ALeft.fm123 * ARight.fm13;
  result.fm3   := -ALeft.fm123 * ARight.fm12;
  result.fm12  :=  ALeft.fm123 * ARight.fm3;
  result.fm13  := -ALeft.fm123 * ARight.fm2;
  result.fm23  :=  ALeft.fm123 * ARight.fm1;
  result.fm123 :=  ALeft.fm123 * ARight.fm0;
end;

class operator TCL3Trivector./(const ALeft, ARight: TCL3Trivector): double;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Trivector./(const ALeft: TCL3Trivector; const ARight: double): TCL3Trivector;
begin
  result.fm123 := ALeft.fm123 / ARight;
end;

class operator TCL3Trivector./(const ALeft: double; const ARight: TCL3Trivector): TCL3Trivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Trivector./(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Trivector./(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

// TCL3Bivector

class operator TCL3Bivector.:=(const AValue: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := AValue.fm12;
  result.fm13  := AValue.fm13;
  result.fm23  := AValue.fm23;
  result.fm123 := 0.0;
end;

class operator TCL3Bivector.:=(const AValue: TCL3Multivector): TCL3Bivector;
begin
  result.fm12 := AValue.fm12;
  result.fm13 := AValue.fm13;
  result.fm23 := AValue.fm23;
end;

class operator TCL3Bivector.<>(const ALeft, ARight: TCL3Bivector): boolean;
begin
  result := (ALeft.fm12 <> ARight.fm12) or
            (ALeft.fm13 <> ARight.fm13) or
            (ALeft.fm23 <> ARight.fm23);
end;

class operator TCL3Bivector.<>(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): boolean;
begin
  result := (ALeft.fm0   <>         0.0) or
            (ALeft.fm1   <>         0.0) or
            (ALeft.fm2   <>         0.0) or
            (ALeft.fm3   <>         0.0) or
            (ALeft.fm12  <> ARight.fm12) or
            (ALeft.fm13  <> ARight.fm13) or
            (ALeft.fm23  <> ARight.fm23) or
            (ALeft.fm123 <>         0.0);
end;

class operator TCL3Bivector.<>(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): boolean;
begin
  result := (ARight.fm0   <>        0.0) or
            (ARight.fm1   <>        0.0) or
            (ARight.fm2   <>        0.0) or
            (ARight.fm3   <>        0.0) or
            (ARight.fm12  <> ALeft.fm12) or
            (ARight.fm13  <> ALeft.fm13) or
            (ARight.fm23  <> ALeft.fm23) or
            (ARight.fm123 <>        0.0);
end;

class operator TCL3Bivector.=(const ALeft, ARight: TCL3Bivector): boolean;
begin
  result := (ALeft.fm12 = ARight.fm12) or
            (ALeft.fm13 = ARight.fm13) or
            (ALeft.fm23 = ARight.fm23);
end;

class operator TCL3Bivector.=(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): boolean;
begin
  result := (ALeft.fm0   =         0.0) or
            (ALeft.fm1   =         0.0) or
            (ALeft.fm2   =         0.0) or
            (ALeft.fm3   =         0.0) or
            (ALeft.fm12  = ARight.fm12) or
            (ALeft.fm13  = ARight.fm13) or
            (ALeft.fm23  = ARight.fm23) or
            (ALeft.fm123 =         0.0);
end;

class operator TCL3Bivector.=(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): boolean;
begin
  result := (ARight.fm0   =        0.0) or
            (ARight.fm1   =        0.0) or
            (ARight.fm2   =        0.0) or
            (ARight.fm3   =        0.0) or
            (ARight.fm12  = ALeft.fm12) or
            (ARight.fm13  = ALeft.fm13) or
            (ARight.fm23  = ALeft.fm23) or
            (ARight.fm123 =        0.0);
end;

class operator TCL3Bivector.+(const ALeft, ARight: TCL3Bivector): TCL3Bivector;
begin
  result.fm12 := ALeft.fm12 + ARight.fm12;
  result.fm13 := ALeft.fm13 + ARight.fm13;
  result.fm23 := ALeft.fm23 + ARight.fm23;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Bivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ARight;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := 0.0;
end;

class operator TCL3Bivector.+(const ALeft: double; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := ALeft;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := 0.0;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ARight.fm0;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := ARight.fm12 + ALeft.fm12;
  result.fm13  := ARight.fm13 + ALeft.fm13;
  result.fm23  := ARight.fm23 + ALeft.fm23;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12 + ARight.fm12;
  result.fm13  := ALeft.fm13 + ARight.fm13;
  result.fm23  := ALeft.fm23 + ARight.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Bivector.-(const ASelf: TCL3Bivector): TCL3Bivector;
begin
  result.fm12 := -ASelf.fm12;
  result.fm13 := -ASelf.fm13;
  result.fm23 := -ASelf.fm23;
end;

class operator TCL3Bivector.-(const ALeft, ARight: TCL3Bivector): TCL3Bivector;
begin
  result.fm12  := ALeft.fm12 - ARight.fm12;
  result.fm13  := ALeft.fm13 - ARight.fm13;
  result.fm23  := ALeft.fm23 - ARight.fm23;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Bivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := -ARight;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  ALeft.fm12;
  result.fm13  :=  ALeft.fm13;
  result.fm23  :=  ALeft.fm23;
  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.-(const ALeft: double; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  ALeft;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  := -ARight.fm12;
  result.fm13  := -ARight.fm13;
  result.fm23  := -ARight.fm23;
  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  ALeft.fm12;
  result.fm13  :=  ALeft.fm13;
  result.fm23  :=  ALeft.fm23;
  result.fm123 := -ARight.fm123;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  := -ARight.fm12;
  result.fm13  := -ARight.fm13;
  result.fm23  := -ARight.fm23;
  result.fm123 :=  ALeft.fm123;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=             - ARight.fm0;
  result.fm1   :=             - ARight.fm1;
  result.fm2   :=             - ARight.fm2;
  result.fm3   :=             - ARight.fm3;
  result.fm12  :=  ALeft.fm12 - ARight.fm12;
  result.fm13  :=  ALeft.fm13 - ARight.fm13;
  result.fm23  :=  ALeft.fm23 - ARight.fm23;
  result.fm123 :=             - ARight.fm123;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12 - ARight.fm12;
  result.fm13  := ALeft.fm13 - ARight.fm13;
  result.fm23  := ALeft.fm23 - ARight.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Bivector.*(const ALeft: double; const ARight: TCL3Bivector): TCL3Bivector;
begin
  result.fm12 := ALeft * ARight.fm12;
  result.fm13 := ALeft * ARight.fm13;
  result.fm23 := ALeft * ARight.fm23;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Bivector; const ARight: double): TCL3Bivector;
begin
  result.fm12 := ARight * ALeft.fm12;
  result.fm13 := ARight * ALeft.fm13;
  result.fm23 := ARight * ALeft.fm23;
end;

class operator TCL3Bivector.*(const ALeft, ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := -ALeft.fm12 * ARight.fm12
                  -ALeft.fm13 * ARight.fm13
                  -ALeft.fm23 * ARight.fm23;

  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;

  result.fm12  := -ALeft.fm13 * ARight.fm23
                  +ALeft.fm23 * ARight.fm13;

  result.fm13  := +ALeft.fm12 * ARight.fm23
                  -ALeft.fm23 * ARight.fm12;

  result.fm23  := -ALeft.fm12 * ARight.fm13
                  +ALeft.fm13 * ARight.fm12;

  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0 :=   -ALeft.fm12 * ARight.fm12
                  -ALeft.fm13 * ARight.fm13
                  -ALeft.fm23 * ARight.fm23;

  result.fm1 :=    ALeft.fm12 * ARight.fm2
                  +ALeft.fm13 * ARight.fm3
                  -ALeft.fm23 * ARight.fm123;

  result.fm2 :=   -ALeft.fm12 * ARight.fm1
                  +ALeft.fm13 * ARight.fm123
                  +ALeft.fm23 * ARight.fm3;

  result.fm3 :=   -ALeft.fm12 * ARight.fm123
                  -ALeft.fm13 * ARight.fm1
                  -ALeft.fm23 * ARight.fm2;

  result.fm12 :=   ALeft.fm12 * ARight.fm0
                  -ALeft.fm13 * ARight.fm23
                  +ALeft.fm23 * ARight.fm13;

  result.fm23 :=  -ALeft.fm12 * ARight.fm13
                  +ALeft.fm13 * ARight.fm12
                  +ALeft.fm23 * ARight.fm0;

  result.fm13 :=  +ALeft.fm12 * ARight.fm23
                  +ALeft.fm13 * ARight.fm0
                  -ALeft.fm23 * ARight.fm12;

  result.fm123 :=  ALeft.fm12 * ARight.fm3
                  -ALeft.fm13 * ARight.fm2
                  +ALeft.fm23 * ARight.fm1;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   := -ALeft.fm23 * ARight.fm123;
  result.fm2   :=  ALeft.fm13 * ARight.fm123;
  result.fm3   := -ALeft.fm12 * ARight.fm123;
  result.fm12  :=  0.0;
  result.fm23  :=  0.0;
  result.fm13  :=  0.0;
  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   := -ARight.fm23 * ALeft.fm123;
  result.fm2   :=  ARight.fm13 * ALeft.fm123;
  result.fm3   := -ARight.fm12 * ALeft.fm123;
  result.fm12  :=  0.0;
  result.fm23  :=  0.0;
  result.fm13  :=  0.0;
  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0 :=   -ALeft.fm12  * ARight.fm12
                  -ALeft.fm13  * ARight.fm13
                  -ALeft.fm23  * ARight.fm23;

  result.fm1 :=   -ALeft.fm2   * ARight.fm12
                  -ALeft.fm3   * ARight.fm13
                  -ALeft.fm123 * ARight.fm23;

  result.fm2 :=    ALeft.fm1   * ARight.fm12
                  -ALeft.fm3   * ARight.fm23
                  +ALeft.fm123 * ARight.fm13;

  result.fm3 :=    ALeft.fm1   * ARight.fm13
                  +ALeft.fm2   * ARight.fm23
                  -ALeft.fm123 * ARight.fm12;

  result.fm12 :=   ALeft.fm0   * ARight.fm12
                  -ALeft.fm13  * ARight.fm23
                  +ALeft.fm23  * ARight.fm13;

  result.fm23 :=   ALeft.fm0   * ARight.fm23
                  -ALeft.fm12  * ARight.fm13
                  +ALeft.fm13  * ARight.fm12;

  result.fm13 :=   ALeft.fm0   * ARight.fm13
                  +ALeft.fm12  * ARight.fm23
                  -ALeft.fm23  * ARight.fm12;

  result.fm123 :=  ALeft.fm1   * ARight.fm23
                  -ALeft.fm2   * ARight.fm13
                  +ALeft.fm3   * ARight.fm12;
end;

class operator TCL3Bivector./(const ALeft, ARight: TCL3Bivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Bivector; const ARight: double): TCL3Bivector;
begin
  result.fm12 := ALeft.fm12 / ARight;
  result.fm13 := ALeft.fm13 / ARight;
  result.fm23 := ALeft.fm23 / ARight;
end;

class operator TCL3Bivector./(const ALeft: double; const ARight: TCL3Bivector): TCL3Bivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

// TCL3Vector

class operator TCL3Vector.:=(const AValue: TCL3Vector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := AValue.fm1;
  result.fm2   := AValue.fm2;
  result.fm3   := AValue.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

class operator TCL3Vector.:=(const AValue: TCL3Multivector): TCL3Vector;
begin
  result.fm1 := AValue.fm1;
  result.fm2 := AValue.fm2;
  result.fm3 := AValue.fm3;
end;

class operator TCL3Vector.<>(const ALeft, ARight: TCL3Vector): boolean;
begin
  result := (ALeft.fm1 <> ARight.fm1) or
            (ALeft.fm2 <> ARight.fm2) or
            (ALeft.fm3 <> ARight.fm3);
end;

class operator TCL3Vector.<>(const ALeft: TCL3Multivector; const ARight: TCL3Vector): boolean;
begin
  result := (ALeft.fm0   <>        0.0) or
            (ALeft.fm1   <> ARight.fm1) or
            (ALeft.fm2   <> ARight.fm2) or
            (ALeft.fm3   <> ARight.fm3) or
            (ALeft.fm12  <>        0.0) or
            (ALeft.fm13  <>        0.0) or
            (ALeft.fm23  <>        0.0) or
            (ALeft.fm123 <>        0.0);
end;

class operator TCL3Vector.<>(const ALeft: TCL3Vector; const ARight: TCL3Multivector): boolean;
begin
  result := (ARight.fm0   <>       0.0) or
            (ARight.fm1   <> ALeft.fm1) or
            (ARight.fm2   <> ALeft.fm2) or
            (ARight.fm3   <> ALeft.fm3) or
            (ARight.fm12  <>       0.0) or
            (ARight.fm13  <>       0.0) or
            (ARight.fm23  <>       0.0) or
            (ARight.fm123 <>       0.0);
end;

class operator TCL3Vector.=(const ALeft, ARight: TCL3Vector): boolean;
begin
  result := (ALeft.fm1 = ARight.fm1) or
            (ALeft.fm2 = ARight.fm2) or
            (ALeft.fm3 = ARight.fm3);
end;

class operator TCL3Vector.=(const ALeft: TCL3Vector; const ARight: TCL3Multivector): boolean;
begin
  result := (ARight.fm0   =       0.0) or
            (ARight.fm1   = ALeft.fm1) or
            (ARight.fm2   = ALeft.fm2) or
            (ARight.fm3   = ALeft.fm3) or
            (ARight.fm12  =       0.0) or
            (ARight.fm13  =       0.0) or
            (ARight.fm23  =       0.0) or
            (ARight.fm123 =       0.0);
end;

class operator TCL3Vector.=(const ALeft: TCL3Multivector; const ARight: TCL3Vector): boolean;
begin
  result := (ALeft.fm0   =        0.0) or
            (ALeft.fm1   = ARight.fm1) or
            (ALeft.fm2   = ARight.fm2) or
            (ALeft.fm3   = ARight.fm3) or
            (ALeft.fm12  =        0.0) or
            (ALeft.fm13  =        0.0) or
            (ALeft.fm23  =        0.0) or
            (ALeft.fm123 =        0.0);
end;

class operator TCL3Vector.+(const ALeft, ARight: TCL3Vector): TCL3Vector;
begin
  result.fm1 := ALeft.fm1 + ARight.fm1;
  result.fm2 := ALeft.fm2 + ARight.fm2;
  result.fm3 := ALeft.fm3 + ARight.fm3;
end;

class operator TCL3Vector.+(const ALeft: TCL3Vector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ARight;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

class operator TCL3Vector.+(const ALeft: double; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   := ALeft;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

class operator TCL3Vector.+(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := 0.0;
end;

class operator TCL3Vector.+(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := 0.0;
end;

class operator TCL3Vector.+(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Vector.+(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Vector.+(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ARight.fm0;
  result.fm1   := ARight.fm1 + ALeft.fm1;
  result.fm2   := ARight.fm2 + ALeft.fm2;
  result.fm3   := ARight.fm3 + ALeft.fm3;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Vector.+(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1 + ARight.fm1;
  result.fm2   := ALeft.fm2 + ARight.fm2;
  result.fm3   := ALeft.fm3 + ARight.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Vector.-(const ASelf: TCL3Vector): TCL3Vector;
begin
  result.fm1 := -ASelf.fm1;
  result.fm2 := -ASelf.fm2;
  result.fm3 := -ASelf.fm3;
end;

class operator TCL3Vector.-(const ALeft, ARight: TCL3Vector): TCL3Vector;
begin
  result.fm1 := ALeft.fm1 - ARight.fm1;
  result.fm2 := ALeft.fm2 - ARight.fm2;
  result.fm3 := ALeft.fm3 - ARight.fm3;
end;

class operator TCL3Vector.-(const ALeft: TCL3Vector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := -ARight;
  result.fm1   :=  ALeft.fm1;
  result.fm2   :=  ALeft.fm2;
  result.fm3   :=  ALeft.fm3;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 :=  0.0;
end;

class operator TCL3Vector.-(const ALeft: double; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  ALeft;
  result.fm1   := -ARight.fm1;
  result.fm2   := -ARight.fm2;
  result.fm3   := -ARight.fm3;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 :=  0.0;
end;

class operator TCL3Vector.-(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  ALeft.fm1;
  result.fm2   :=  ALeft.fm2;
  result.fm3   :=  ALeft.fm3;
  result.fm12  := -ARight.fm12;
  result.fm13  := -ARight.fm13;
  result.fm23  := -ARight.fm23;
  result.fm123 :=  0.0;
end;

class operator TCL3Vector.-(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   := -ARight.fm1;
  result.fm2   := -ARight.fm2;
  result.fm3   := -ARight.fm3;
  result.fm12  :=  ALeft.fm12;
  result.fm13  :=  ALeft.fm13;
  result.fm23  :=  ALeft.fm23;
  result.fm123 :=  0.0;
end;

class operator TCL3Vector.-(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  ALeft.fm1;
  result.fm2   :=  ALeft.fm2;
  result.fm3   :=  ALeft.fm3;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 := -ARight.fm123;
end;

class operator TCL3Vector.-(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   := -ARight.fm1;
  result.fm2   := -ARight.fm2;
  result.fm3   := -ARight.fm3;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 :=  ALeft.fm123;
end;

class operator TCL3Vector.-(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=            - ARight.fm0;
  result.fm1   :=  ALeft.fm1 - ARight.fm1;
  result.fm2   :=  ALeft.fm2 - ARight.fm2;
  result.fm3   :=  ALeft.fm3 - ARight.fm3;
  result.fm12  :=            - ARight.fm12;
  result.fm13  :=            - ARight.fm13;
  result.fm23  :=            - ARight.fm23;
  result.fm123 :=            - ARight.fm123;
end;

class operator TCL3Vector.-(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1 - ARight.fm1;
  result.fm2   := ALeft.fm2 - ARight.fm2;
  result.fm3   := ALeft.fm3 - ARight.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Vector.*(const ALeft: double; const ARight: TCL3Vector): TCL3Vector;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TCL3Vector.*(const ALeft: TCL3Vector; const ARight: double): TCL3Vector;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TCL3Vector.*(const ALeft, ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  ALeft.fm1 * ARight.fm1
                  +ALeft.fm2 * ARight.fm2
                  +ALeft.fm3 * ARight.fm3;

  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;

  result.fm12  :=  ALeft.fm1 * ARight.fm2
                  -ALeft.fm2 * ARight.fm1;

  result.fm13  :=  ALeft.fm1 * ARight.fm3
                  -ALeft.fm3 * ARight.fm1;

  result.fm23  :=  ALeft.fm2 * ARight.fm3
                  -ALeft.fm3 * ARight.fm2;

  result.fm123 :=  0.0;
end;

class operator TCL3Vector.*(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;

  result.fm1   := -ALeft.fm2 * ARight.fm12
                  -ALeft.fm3 * ARight.fm13;

  result.fm2   :=  ALeft.fm1 * ARight.fm12
                  -ALeft.fm3 * ARight.fm23;

  result.fm3   :=  ALeft.fm1 * ARight.fm13
                  +ALeft.fm2 * ARight.fm23;

  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;

  result.fm123 :=  ALeft.fm1 * ARight.fm23
                  -ALeft.fm2 * ARight.fm13
                  +ALeft.fm3 * ARight.fm12;
end;

class operator TCL3Vector.*(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  ALeft.fm12 * ARight.fm2
                  +ALeft.fm13 * ARight.fm3;

  result.fm2   := -ALeft.fm12 * ARight.fm1
                  +ALeft.fm23 * ARight.fm3;

  result.fm3   := -ALeft.fm13 * ARight.fm1
                  -ALeft.fm23 * ARight.fm2;

  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;

  result.fm123 :=  ALeft.fm12 * ARight.fm3
                  -ALeft.fm13 * ARight.fm2
                  +ALeft.fm23 * ARight.fm1;
end;

class operator TCL3Vector.*(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Bivector;
begin
  result.fm12 :=  ALeft.fm3 * ARight.fm123;
  result.fm13 := -ALeft.fm2 * ARight.fm123;
  result.fm23 :=  ALeft.fm1 * ARight.fm123;
end;

class operator TCL3Vector.*(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Bivector;
begin
  result.fm12 :=  ALeft.fm123 * ARight.fm3;
  result.fm13 := -ALeft.fm123 * ARight.fm2;
  result.fm23 :=  ALeft.fm123 * ARight.fm1;
end;

class operator TCL3Vector.*(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  ALeft.fm1 * ARight.fm1
                  +ALeft.fm2 * ARight.fm2
                  +ALeft.fm3 * ARight.fm3;

  result.fm1   :=  ALeft.fm1 * ARight.fm0
                  -ALeft.fm2 * ARight.fm12
                  -ALeft.fm3 * ARight.fm13;

  result.fm2   :=  ALeft.fm1 * ARight.fm12
                  +ALeft.fm2 * ARight.fm0
                  -ALeft.fm3 * ARight.fm23;

  result.fm3   :=  ALeft.fm1 * ARight.fm13
                  +ALeft.fm2 * ARight.fm23
                  +ALeft.fm3 * ARight.fm0;

  result.fm12  :=  ALeft.fm1 * ARight.fm2
                  -ALeft.fm2 * ARight.fm1
                  +ALeft.fm3 * ARight.fm123;

  result.fm23  :=  ALeft.fm1 * ARight.fm123
                  +ALeft.fm2 * ARight.fm3
                  -ALeft.fm3 * ARight.fm2;

  result.fm13  :=  ALeft.fm1 * ARight.fm3
                  -ALeft.fm2 * ARight.fm123
                  -ALeft.fm3 * ARight.fm1;

  result.fm123 :=  ALeft.fm1 * ARight.fm23
                  -ALeft.fm2 * ARight.fm13
                  +ALeft.fm3 * ARight.fm12;
end;

class operator TCL3Vector.*(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  ALeft.fm1   * ARight.fm1
                  +ALeft.fm2   * ARight.fm2
                  +ALeft.fm3   * ARight.fm3;

  result.fm1   :=  ALeft.fm0   * ARight.fm1
                  +ALeft.fm12  * ARight.fm2
                  +ALeft.fm13  * ARight.fm3;

  result.fm2   :=  ALeft.fm0   * ARight.fm2
                  -ALeft.fm12  * ARight.fm1
                  +ALeft.fm23  * ARight.fm3;

  result.fm3   :=  ALeft.fm0   * ARight.fm3
                  -ALeft.fm13  * ARight.fm1
                  -ALeft.fm23  * ARight.fm2;

  result.fm12  :=  ALeft.fm1   * ARight.fm2
                  -ALeft.fm2   * ARight.fm1
                  +ALeft.fm123 * ARight.fm3;

  result.fm23  :=  ALeft.fm2   * ARight.fm3
                  -ALeft.fm3   * ARight.fm2
                  +ALeft.fm123 * ARight.fm1;

  result.fm13  :=  ALeft.fm1   * ARight.fm3
                  -ALeft.fm3   * ARight.fm1
                  -ALeft.fm123 * ARight.fm2;

  result.fm123 :=  ALeft.fm12  * ARight.fm3
                  -ALeft.fm13  * ARight.fm2
                  +ALeft.fm23  * ARight.fm1;
end;

class operator TCL3Vector./(const ALeft, ARight: TCL3Vector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Vector./ (const ALeft: TCL3Vector; const ARight: double): TCL3Vector;
begin
  result.fm1 := ALeft.fm1 / ARight;
  result.fm2 := ALeft.fm2 / ARight;
  result.fm3 := ALeft.fm3 / ARight;
end;

class operator TCL3Vector./(const ALeft: double; const ARight: TCL3Vector): TCL3Vector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Vector./(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Vector./(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Vector./(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Bivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Vector./(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Bivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Vector./(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Vector./(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

// TCL3MultivectorHelper

function TCL3MultivectorHelper.Dual: TCL3Multivector;
begin
  result.fm0   := -fm123;
  result.fm1   := -fm23;
  result.fm2   :=  fm13;
  result.fm3   := -fm12;
  result.fm12  :=  fm3;
  result.fm13  := -fm2;
  result.fm23  :=  fm1;
  result.fm123 :=  fm0;
end;

function TCL3MultivectorHelper.Inverse: TCL3Multivector;
begin
  result.fm0   :=  fm0;
  result.fm1   := -fm1;
  result.fm2   := -fm2;
  result.fm3   := -fm3;
  result.fm12  :=  fm12;
  result.fm13  :=  fm13;
  result.fm23  :=  fm23;
  result.fm123 := -fm123;
end;

function TCL3MultivectorHelper.Reverse: TCL3Multivector;
begin
  result.fm0   :=  fm0;
  result.fm1   :=  fm1;
  result.fm2   :=  fm2;
  result.fm3   :=  fm3;
  result.fm12  := -fm12;
  result.fm13  := -fm13;
  result.fm23  := -fm23;
  result.fm123 := -fm123;
end;

function TCL3MultivectorHelper.Conjugate: TCL3Multivector;
begin
  result.fm0   :=  fm0;
  result.fm1   := -fm1;
  result.fm2   := -fm2;
  result.fm3   := -fm3;
  result.fm12  := -fm12;
  result.fm13  := -fm13;
  result.fm23  := -fm23;
  result.fm123 :=  fm123;
end;

function TCL3MultivectorHelper.Reciprocal: TCL3Multivector;
var
  Numerator: TCL3Multivector;
begin
  if ((fm0  <>0) and ((fm1 <>0) or (fm2 <>0) or (fm3 <>0))) or
     ((fm123<>0) and ((fm12<>0) or (fm23<>0) or (fm13<>0))) then
  begin
    Numerator := Conjugate * Inverse * Reverse;
    result    := Numerator / (Self*Numerator).fm0;
  end else
    result := Reverse / SquaredNorm;
end;

function TCL3MultivectorHelper.LeftReciprocal: TCL3Multivector;
begin
  if ((fm0  <>0) and ((fm1 <>0) or (fm2 <>0) or (fm3 <>0))) or
     ((fm123<>0) and ((fm12<>0) or (fm23<>0) or (fm13<>0))) then
  begin
    result := (Inverse*Reverse*Conjugate) / (Self*Conjugate*Inverse*Reverse).fm0;
  end else
    result := Reverse / SquaredNorm;
end;

function TCL3MultivectorHelper.Normalized: TCL3Multivector;
begin
  result := Self / Norm;
end;

function TCL3MultivectorHelper.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TCL3MultivectorHelper.SquaredNorm: double;
begin
  result := fm0*fm0 +fm1*fm1 +fm2*fm2 +fm3*fm3 +fm12*fm12 +fm23*fm23 +fm13*fm13 +fm123*fm123;
end;

function TCL3MultivectorHelper.Dot(const AVector: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  fm1   * AVector.fm1
                  +fm2   * AVector.fm2
                  +fm3   * AVector.fm3;

  result.fm1   :=  fm0   * AVector.fm1
                  +fm12  * AVector.fm2
                  +fm13  * AVector.fm3;

  result.fm2   :=  fm0   * AVector.fm2
                  -fm12  * AVector.fm1
                  +fm23  * AVector.fm3;

  result.fm3   :=  fm0   * AVector.fm3
                  -fm23  * AVector.fm2
                  -fm13  * AVector.fm1;

  result.fm12  :=  fm123 * AVector.fm3;
  result.fm13  := -fm123 * AVector.fm2;
  result.fm23  :=  fm123 * AVector.fm1;
  result.fm123 :=  0.0;
end;

function TCL3MultivectorHelper.Dot(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := -fm12  * AVector.fm12
                  -fm13  * AVector.fm13
                  -fm23  * AVector.fm23;

  result.fm1   := -fm2   * AVector.fm12
                  -fm3   * AVector.fm13
                  -fm123 * AVector.fm23;

  result.fm2   :=  fm1   * AVector.fm12
                  -fm3   * AVector.fm23
                  +fm123 * AVector.fm13;

  result.fm3   :=  fm1   * AVector.fm13
                  +fm2   * AVector.fm23
                  -fm123 * AVector.fm12;

  result.fm12  :=  fm0   * AVector.fm12;
  result.fm13  :=  fm0   * AVector.fm13;
  result.fm23  :=  fm0   * AVector.fm23;
  result.fm123 :=  0;
end;

function TCL3MultivectorHelper.Dot(const AVector: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := -fm123 * AVector.fm123;
  result.fm1   := -fm23  * AVector.fm123;
  result.fm2   :=  fm13  * AVector.fm123;
  result.fm3   := -fm12  * AVector.fm123;
  result.fm12  :=  fm3   * AVector.fm123;
  result.fm13  := -fm2   * AVector.fm123;
  result.fm23  :=  fm1   * AVector.fm123;
  result.fm123 :=  fm0   * AVector.fm123;
end;

function TCL3MultivectorHelper.Dot(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0 :=    fm0   * AVector.fm0
                  +fm1   * AVector.fm1
                  +fm2   * AVector.fm2
                  +fm3   * AVector.fm3
                  -fm12  * AVector.fm12
                  -fm13  * AVector.fm13
                  -fm23  * AVector.fm23
                  -fm123 * AVector.fm123;

  result.fm1 :=    fm0   * AVector.fm1
                  +fm1   * AVector.fm0
                  -fm2   * AVector.fm12
                  -fm3   * AVector.fm13
                  +fm12  * AVector.fm2
                  +fm13  * AVector.fm3
                  -fm23  * AVector.fm123
                  -fm123 * AVector.fm23;

  result.fm2 :=    fm0   * AVector.fm2
                  +fm1   * AVector.fm12
                  +fm2   * AVector.fm0
                  -fm3   * AVector.fm23
                  -fm12  * AVector.fm1
                  +fm13  * AVector.fm123
                  +fm23  * AVector.fm3
                  +fm123 * AVector.fm13;

  result.fm3 :=    fm0   * AVector.fm3
                  +fm1   * AVector.fm13
                  +fm2   * AVector.fm23
                  +fm3   * AVector.fm0
                  -fm12  * AVector.fm123
                  -fm13  * AVector.fm1
                  -fm23  * AVector.fm2
                  -fm123 * AVector.fm12;

  result.fm12 :=   fm0   * AVector.fm12
                  +fm3   * AVector.fm123
                  +fm12  * AVector.fm0
                  +fm123 * AVector.fm3;

  result.fm23 :=   fm0   * AVector.fm23
                  +fm1   * Avector.fm123
                  +fm23  * AVector.fm0
                  +fm123 * AVector.fm1;

  result.fm13 :=   fm0   * AVector.fm13
                  -fm2   * AVector.fm123
                  +fm13  * AVector.fm0
                  -fm123 * AVector.fm2;

  result.fm123 :=  fm0   * AVector.fm123
                  +fm123 * AVector.fm0;
end;

function TCL3MultivectorHelper.Wedge(const AVector: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  fm0  * AVector.fm1;
  result.fm2   :=  fm0  * AVector.fm2;
  result.fm3   :=  fm0  * AVector.fm3;

  result.fm12  :=  fm1  * AVector.fm2
                  -fm2  * AVector.fm1;

  result.fm23  :=  fm2  * AVector.fm3
                  -fm3  * AVector.fm2;

  result.fm13  := +fm1  * AVector.fm3
                  -fm3  * AVector.fm1;

  result.fm123 :=  fm12 * AVector.fm3
                  -fm13 * AVector.fm2
                  +fm23 * AVector.fm1;
end;

function TCL3MultivectorHelper.Wedge(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  fm0 * AVector.fm12;
  result.fm23  :=  fm0 * AVector.fm23;
  result.fm13  :=  fm0 * AVector.fm13;

  result.fm123 :=  fm1 * AVector.fm23
                  -fm2 * AVector.fm13
                  +fm3 * AVector.fm12
end;

function TCL3MultivectorHelper.Wedge(const AVector: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := fm0 * AVector.fm123;
end;

function TCL3MultivectorHelper.Wedge(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  fm0   * AVector.fm0;

  result.fm1   :=  fm0   * AVector.fm1
                  +fm1   * AVector.fm0;

  result.fm2   :=  fm0   * AVector.fm2
                  +fm2   * AVector.fm0;

  result.fm3   :=  fm0   * AVector.fm3
                  +fm3   * AVector.fm0;

  result.fm12  :=  fm0   * AVector.fm12
                  +fm1   * AVector.fm2
                  -fm2   * AVector.fm1
                  +fm12  * AVector.fm0;

  result.fm23  :=  fm0   * AVector.fm23
                  +fm2   * AVector.fm3
                  -fm3   * AVector.fm2
                  +fm23  * AVector.fm0;

  result.fm13  :=  fm0   * AVector.fm13
                  +fm1   * AVector.fm3
                  -fm3   * AVector.fm1
                  +fm13  * AVector.fm0;

  result.fm123 := +fm0   * AVector.fm123
                  +fm1   * AVector.fm23
                  -fm2   * AVector.fm13
                  +fm3   * AVector.fm12
                  +fm12  * AVector.fm3
                  -fm13  * AVector.fm2
                  +fm23  * AVector.fm1
                  +fm123 * AVector.fm0;
end;

function TCL3MultivectorHelper.Projection(const AVector: TCL3Vector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Projection(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Projection(const AVector: TCL3Trivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Projection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rejection(const AVector: TCL3Vector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rejection(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rejection(const AVector: TCL3Trivector): double;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rejection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Reflection(const AVector: TCL3Vector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Reflection(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Reflection(const AVector: TCL3Trivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Reflection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rotation(const AVector1, AVector2: TCL3Vector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3MultivectorHelper.Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3MultivectorHelper.Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3MultivectorHelper.Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3MultivectorHelper.SameValue(const AValue: TCL3Multivector): boolean;
begin
  result := SameValueEx(fm0,   AValue.fm0  ) and
            SameValueEx(fm1,   AValue.fm1  ) and
            SameValueEx(fm2,   AValue.fm2  ) and
            SameValueEx(fm3,   AValue.fm3  ) and
            SameValueEx(fm12,  AValue.fm12 ) and
            SameValueEx(fm13,  AValue.fm13 ) and
            SameValueEx(fm23,  AValue.fm23 ) and
            SameValueEx(fm123, AValue.fm123);
end;

function TCL3MultivectorHelper.SameValue(const AValue: TCL3Trivector): boolean;
begin
  result := SameValueEx(fm0,            0.0) and
            SameValueEx(fm1,            0.0) and
            SameValueEx(fm2,            0.0) and
            SameValueEx(fm3,            0.0) and
            SameValueEx(fm12,           0.0) and
            SameValueEx(fm23,           0.0) and
            SameValueEx(fm13,           0.0) and
            SameValueEx(fm123, AValue.fm123);
end;

function TCL3MultivectorHelper.SameValue(const AValue: TCL3Bivector): boolean;
begin
  result := SameValueEx(fm0,           0.0) and
            SameValueEx(fm1,           0.0) and
            SameValueEx(fm2,           0.0) and
            SameValueEx(fm3,           0.0) and
            SameValueEx(fm12,  AValue.fm12) and
            SameValueEx(fm13,  AValue.fm13) and
            SameValueEx(fm23,  AValue.fm23) and
            SameValueEx(fm123,         0.0);
end;

function TCL3MultivectorHelper.SameValue(const AValue: TCL3Vector): boolean;
begin
  result := SameValueEx(fm0,          0.0) and
            SameValueEx(fm1,   AValue.fm1) and
            SameValueEx(fm2,   AValue.fm2) and
            SameValueEx(fm3,   AValue.fm3) and
            SameValueEx(fm12,         0.0) and
            SameValueEx(fm23,         0.0) and
            SameValueEx(fm13,         0.0) and
            SameValueEx(fm123,        0.0);
end;

function TCL3MultivectorHelper.SameValue(const AValue: double): boolean;
begin
  result := SameValueEx(fm0,   AValue) and
            SameValueEx(fm1,      0.0) and
            SameValueEx(fm2,      0.0) and
            SameValueEx(fm3,      0.0) and
            SameValueEx(fm12,     0.0) and
            SameValueEx(fm23,     0.0) and
            SameValueEx(fm13,     0.0) and
            SameValueEx(fm123,    0.0);
end;

function TCL3MultivectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm0,   0.0) then result := result + Fmt(fm0,   APrecision, ADigits) + ' ';
  if not SameValueEx(fm1,   0.0) then result := result + Fmt(fm1,   APrecision, ADigits) + 'e1 ';
  if not SameValueEx(fm2,   0.0) then result := result + Fmt(fm2,   APrecision, ADigits) + 'e2 ';
  if not SameValueEx(fm3,   0.0) then result := result + Fmt(fm3,   APrecision, ADigits) + 'e3 ';
  if not SameValueEx(fm12,  0.0) then result := result + Fmt(fm12,  APrecision, ADigits) + 'e12 ';
  if not SameValueEx(fm23,  0.0) then result := result + Fmt(fm23,  APrecision, ADigits) + 'e23 ';
  if not SameValueEx(fm13,  0.0) then result := result + Fmt(fm13,  APrecision, ADigits) + 'e31 ';
  if not SameValueEx(fm123, 0.0) then result := result + Fmt(fm123, APrecision, ADigits) + 'e123 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0';

  result := '(' + result + ')';
end;

function TCL3MultivectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm0,   0.0) then result := result + Fmt(fm0  ) + ' ';
  if not SameValueEx(fm1,   0.0) then result := result + Fmt(fm1  ) + 'e1 ';
  if not SameValueEx(fm2,   0.0) then result := result + Fmt(fm2  ) + 'e2 ';
  if not SameValueEx(fm3,   0.0) then result := result + Fmt(fm3  ) + 'e3 ';
  if not SameValueEx(fm12,  0.0) then result := result + Fmt(fm12 ) + 'e12 ';
  if not SameValueEx(fm23,  0.0) then result := result + Fmt(fm23 ) + 'e23 ';
  if not SameValueEx(fm13,  0.0) then result := result + Fmt(fm13 ) + 'e31 ';
  if not SameValueEx(fm123, 0.0) then result := result + Fmt(fm123) + 'e123 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0';

  result := '(' + result + ')';
end;

function TCL3MultivectorHelper.ExtractMultivector(AComponents: TCL3MultivectorComponents): TCL3Multivector;
begin
  if mcm0   in AComponents then result.fm0   := fm0   else result.fm0   := 0;
  if mcm1   in AComponents then result.fm1   := fm1   else result.fm1   := 0;
  if mcm2   in AComponents then result.fm2   := fm2   else result.fm2   := 0;
  if mcm3   in AComponents then result.fm3   := fm3   else result.fm3   := 0;
  if mcm12  in AComponents then result.fm12  := fm12  else result.fm12  := 0;
  if mcm13  in AComponents then result.fm13  := fm13  else result.fm13  := 0;
  if mcm23  in AComponents then result.fm23  := fm23  else result.fm23  := 0;
  if mcm123 in AComponents then result.fm123 := fm123 else result.fm123 := 0;
end;

function TCL3MultivectorHelper.ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3Bivector;
begin
  if mcm12 in AComponents then result.fm12 := fm12 else result.fm12 := 0;
  if mcm13 in AComponents then result.fm13 := fm13 else result.fm13 := 0;
  if mcm23 in AComponents then result.fm23 := fm23 else result.fm23 := 0;
end;

function TCL3MultivectorHelper.ExtractVector(AComponents: TCL3MultivectorComponents): TCL3Vector;
begin
  if mcm1 in AComponents then result.fm1 := fm1 else result.fm1 := 0;
  if mcm2 in AComponents then result.fm2 := fm2 else result.fm2 := 0;
  if mcm3 in AComponents then result.fm3 := fm3 else result.fm3 := 0;
end;

function TCL3MultivectorHelper.ExtractTrivector: TCL3Trivector;
begin
  result.fm123 := fm123;
end;

function TCL3MultivectorHelper.ExtractBivector: TCL3Bivector;
begin
  result.fm12 := fm12;
  result.fm13 := fm13;
  result.fm23 := fm23;
end;

function TCL3MultivectorHelper.ExtractVector: TCL3Vector;
begin
  result.fm1 := fm1;
  result.fm2 := fm2;
  result.fm3 := fm3;
end;

function TCL3MultivectorHelper.ExtractScalar: double;
begin
  result := fm0;
end;

function TCL3MultivectorHelper.IsNull: boolean;
begin
  result := (SameValueEx(fm0,   0.0)) and
            (SameValueEx(fm1,   0.0)) and
            (SameValueEx(fm2,   0.0)) and
            (SameValueEx(fm3,   0.0)) and
            (SameValueEx(fm12,  0.0)) and
            (SameValueEx(fm23,  0.0)) and
            (SameValueEx(fm13,  0.0)) and
            (SameValueEx(fm123, 0.0));
end;

function TCL3MultivectorHelper.IsScalar: boolean;
begin
  result := (not SameValueEx(fm0,   0.0)) and
            (    SameValueEx(fm1,   0.0)) and
            (    SameValueEx(fm2,   0.0)) and
            (    SameValueEx(fm3,   0.0)) and
            (    SameValueEx(fm12,  0.0)) and
            (    SameValueEx(fm23,  0.0)) and
            (    SameValueEx(fm13,  0.0)) and
            (    SameValueEx(fm123, 0.0));
end;

function TCL3MultivectorHelper.IsVector: boolean;
begin
  result :=  (    SameValueEx(fm0,   0.0))  and
            ((not SameValueEx(fm1,   0.0))  or
             (not SameValueEx(fm2,   0.0))  or
             (not SameValueEx(fm3,   0.0))) and
             (    SameValueEx(fm12,  0.0))  and
             (    SameValueEx(fm23,  0.0))  and
             (    SameValueEx(fm13,  0.0))  and
             (    SameValueEx(fm123, 0.0));
end;

function TCL3MultivectorHelper.IsBiVector: boolean;
begin
  result :=  (    SameValueEx(fm0,   0.0))  and
             (    SameValueEx(fm1,   0.0))  and
             (    SameValueEx(fm2,   0.0))  and
             (    SameValueEx(fm3,   0.0))  and
            ((not SameValueEx(fm12,  0.0))  or
             (not SameValueEx(fm23,  0.0))  or
             (not SameValueEx(fm13,  0.0))) and
             (    SameValueEx(fm123, 0.0));
end;

function TCL3MultivectorHelper.IsTrivector: boolean;
begin
  result := (    SameValueEx(fm0,   0.0)) and
            (    SameValueEx(fm1,   0.0)) and
            (    SameValueEx(fm2,   0.0)) and
            (    SameValueEx(fm3,   0.0)) and
            (    SameValueEx(fm12,  0.0)) and
            (    SameValueEx(fm23,  0.0)) and
            (    SameValueEx(fm13,  0.0)) and
            (not SameValueEx(fm123, 0.0));
end;

function TCL3MultivectorHelper.IsA: string;
begin
  if IsNull      then Result := 'Null'       else
  if IsTrivector then Result := 'TCL3Trivector' else
  if IsBivector  then Result := 'TCL3Bivector'  else
  if IsVector    then Result := 'TCL3Vector'    else
  if IsScalar    then Result := 'TScalar'    else Result := 'TCL3Multivector';
end;

// TCL3TrivectorHelper

function TCL3TrivectorHelper.Dual: double;
begin
  // Self * e123
  result := -fm123;
end;

function TCL3TrivectorHelper.Inverse: TCL3Trivector;
begin
  result.fm123 := -fm123;
end;

function TCL3TrivectorHelper.Reverse: TCL3Trivector;
begin
  result.fm123 := -fm123;
end;

function TCL3TrivectorHelper.Conjugate: TCL3Trivector;
begin
  result.fm123 := fm123;
end;

function TCL3TrivectorHelper.Reciprocal: TCL3Trivector;
begin
  result := Reverse / SquaredNorm;
end;

function TCL3TrivectorHelper.Normalized: TCL3Trivector;
begin
  result := Self / Norm;
end;

function TCL3TrivectorHelper.Norm: double;
begin
  result := abs(fm123);
end;

function TCL3TrivectorHelper.SquaredNorm: double;
begin
  result := fm123 * fm123;
end;

function TCL3TrivectorHelper.Dot(const AVector: TCL3Vector): TCL3Bivector;
begin
  result.fm12 :=  fm123 * AVector.fm3;
  result.fm13 := -fm123 * AVector.fm2;
  result.fm23 :=  fm123 * AVector.fm1;
end;

function TCL3TrivectorHelper.Dot(const AVector: TCL3Bivector): TCL3Vector;
begin
  result.fm1 := -fm123 * AVector.fm23;
  result.fm2 :=  fm123 * AVector.fm13;
  result.fm3 := -fm123 * AVector.fm12;
end;

function TCL3TrivectorHelper.Dot(const AVector: TCL3Trivector): double;
begin
  result := -fm123 * AVector.fm123;
end;

function TCL3TrivectorHelper.Dot(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := -fm123 * AVector.fm123;
  result.fm1   := -fm123 * AVector.fm23;
  result.fm2   :=  fm123 * AVector.fm13;
  result.fm3   := -fm123 * AVector.fm12;
  result.fm12  :=  fm123 * AVector.fm3;
  result.fm13  := -fm123 * AVector.fm2;
  result.fm23  :=  fm123 * AVector.fm1;
  result.fm123 :=  fm123 * AVector.fm0;
end;

function TCL3TrivectorHelper.Wedge(const AVector: TCL3Vector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Wedge(const AVector: TCL3Bivector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Wedge(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Wedge(const AVector: TCL3Multivector): TCL3Trivector;
begin
  result.fm123 := fm123 * AVector.fm0;
end;

function TCL3TrivectorHelper.Projection(const AVector: TCL3Vector): TCL3Trivector;
begin
  result.fm123 := fm123 * AVector.Norm;
end;

function TCL3TrivectorHelper.Projection(const AVector: TCL3Bivector): TCL3Trivector;
begin
  result.fm123 := fm123 * AVector.Norm;
end;

function TCL3TrivectorHelper.Projection(const AVector: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := fm123 * AVector.Norm;
end;

function TCL3TrivectorHelper.Projection(const AVector: TCL3Multivector): TCL3Trivector;
begin
  // inplicit ExtracTCL3Trivector
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Rejection(const AVector: TCL3Vector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Rejection(const AVector: TCL3Bivector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Rejection(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Rejection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Reflection(const AVector: TCL3Vector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Reflection(const AVector: TCL3Bivector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Reflection(const AVector: TCL3Trivector): TCL3Trivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Reflection(const AVector: TCL3Multivector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Rotation(const AVector1, AVector2: TCL3Vector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3TrivectorHelper.Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3TrivectorHelper.Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Trivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3TrivectorHelper.Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3TrivectorHelper.SameValue(const AValue: TCL3Multivector): boolean;
begin
  result := SameValueEx(0.0,   AValue.fm0  ) and
            SameValueEx(0.0,   AValue.fm1  ) and
            SameValueEx(0.0,   AValue.fm2  ) and
            SameValueEx(0.0,   AValue.fm3  ) and
            SameValueEx(0.0,   AValue.fm12 ) and
            SameValueEx(0.0,   AValue.fm13 ) and
            SameValueEx(0.0,   AValue.fm23 ) and
            SameValueEx(fm123, AValue.fm123);
end;

function TCL3TrivectorHelper.SameValue(const AValue: TCL3Trivector): boolean;
begin
  result := SameValueEx(fm123, AValue.fm123);
end;

function TCL3TrivectorHelper.ToString(APrecision, ADigits: longint): string;
begin
  if not SameValueEx(fm123, 0.0) then
    result := Fmt(fm123, APrecision, ADigits) + 'e123'
  else
    result := '0e123';

  result := '(' + result + ')';
end;

function TCL3TrivectorHelper.ToString: string;
begin
  if not SameValueEx(fm123, 0.0) then
    result := Fmt(fm123) + 'e123'
  else
    result := '0e123';

  result := '(' + result + ')';
end;

function TCL3TrivectorHelper.ToMultivector: TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := fm123;
end;

// TCL3BivectorHelper

function TCL3BivectorHelper.Dual: TCL3Vector;
begin
  result.fm1 := -fm23;
  result.fm2 :=  fm13;
  result.fm3 := -fm12;
end;

function TCL3BivectorHelper.Inverse: TCL3Bivector;
begin
  result.fm12 := fm12;
  result.fm13 := fm13;
  result.fm23 := fm23;
end;

function TCL3BivectorHelper.Conjugate: TCL3Bivector;
begin
  result.fm12 := -fm12;
  result.fm13 := -fm13;
  result.fm23 := -fm23;
end;

function TCL3BivectorHelper.Reverse: TCL3Bivector;
begin
  result.fm12 := -fm12;
  result.fm13 := -fm13;
  result.fm23 := -fm23;
end;

function TCL3BivectorHelper.Reciprocal: TCL3Bivector;
begin
  result := Reverse / SquaredNorm;
end;

function TCL3BivectorHelper.Normalized: TCL3Bivector;
begin
  result := Self / Norm;
end;

function TCL3BivectorHelper.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TCL3BivectorHelper.SquaredNorm: double;
begin
  result := fm12*fm12 + fm13*fm13 + fm23*fm23;
end;

function TCL3BivectorHelper.Dot(const AVector: TCL3Vector): TCL3Vector;
begin
  result.fm1 :=  fm12 * AVector.fm2
                +fm13 * AVector.fm3;

  result.fm2 :=  fm23 * AVector.fm3
                -fm12 * AVector.fm1;

  result.fm3 := -fm13 * AVector.fm1
                -fm23 * AVector.fm2;
end;

function TCL3BivectorHelper.Dot(const AVector: TCL3Bivector): double;
begin
  result := -fm12 * AVector.fm12
            -fm13 * AVector.fm13
            -fm23 * AVector.fm23;
end;

function TCL3BivectorHelper.Dot(const AVector: TCL3Trivector): TCL3Vector;
begin
  result.fm1 := -fm23 * AVector.fm123;
  result.fm2 :=  fm13 * AVector.fm123;
  result.fm3 := -fm12 * AVector.fm123;
end;

function TCL3BivectorHelper.Dot(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := -fm12 * AVector.fm12
                  -fm13 * AVector.fm13
                  -fm23 * AVector.fm23;

  result.fm1   :=  fm12 * AVector.fm2
                  -fm23 * AVector.fm123
                  +fm13 * AVector.fm3;

  result.fm2   := -fm12 * AVector.fm1
                  +fm13 * AVector.fm123
                  +fm23 * AVector.fm3;

  result.fm3   := -fm12 * AVector.fm123
                  -fm23 * AVector.fm2
                  -fm13 * AVector.fm1;

  result.fm12  :=  fm12 * AVector.fm0;
  result.fm13  :=  fm13 * AVector.fm0;
  result.fm23  :=  fm23 * AVector.fm0;
  result.fm123 :=  0.0;
end;

function TCL3BivectorHelper.Wedge(const AVector: TCL3Vector): TCL3Trivector;
begin
  result.fm123 :=  fm12 * AVector.fm3
                  -fm13 * AVector.fm2
                  +fm23 * AVector.fm1;
end;

function TCL3BivectorHelper.Wedge(const AVector: TCL3Bivector): double;
begin
  result := 0.0;
end;

function TCL3BivectorHelper.Wedge(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3BivectorHelper.Wedge (const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  fm12 * AVector.fm0;
  result.fm13  :=  fm13 * AVector.fm0;
  result.fm23  :=  fm23 * AVector.fm0;

  result.fm123 :=  fm12 * AVector.fm3
                  +fm23 * AVector.fm1
                  -fm13 * AVector.fm2;
end;

function TCL3BivectorHelper.Projection(const AVector: TCL3Vector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Projection(const AVector: TCL3Bivector): TCL3Bivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Projection(const AVector: TCL3Trivector): TCL3Bivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Projection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Rejection(const AVector: TCL3Vector): TCL3Bivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Rejection (const AVector: TCL3Bivector): double;
begin
  result := 0.0;
end;

function TCL3BivectorHelper.Rejection (const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3BivectorHelper.Rejection (const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Reflection(const AVector: TCL3Vector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Reflection(const AVector: TCL3Bivector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Reflection(const AVector: TCL3Trivector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Reflection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Rotation(const AVector1, AVector2: TCL3Vector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3BivectorHelper.Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3BivectorHelper.Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3BivectorHelper.Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3BivectorHelper.SameValue(const AValue: TCL3Multivector): boolean;
begin
  result := SameValueEx(0.0,  AValue.fm0  ) and
            SameValueEx(0.0,  AValue.fm1  ) and
            SameValueEx(0.0,  AValue.fm2  ) and
            SameValueEx(0.0,  AValue.fm3  ) and
            SameValueEx(fm12, AValue.fm12 ) and
            SameValueEx(fm13, AValue.fm13 ) and
            SameValueEx(fm23, AValue.fm23 ) and
            SameValueEx(0.0,  AValue.fm123);
end;

function TCL3BivectorHelper.SameValue(const AValue: TCL3Bivector): boolean;
begin
  result := SameValueEx(fm12, AValue.fm12) and
            SameValueEx(fm13, AValue.fm13) and
            SameValueEx(fm23, AValue.fm23);
end;

function TCL3BivectorHelper.ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3Bivector;
begin
  if mcm12 in AComponents then result.fm12 := fm12 else result.fm12 := 0;
  if mcm13 in AComponents then result.fm13 := fm13 else result.fm13 := 0;
  if mcm23 in AComponents then result.fm23 := fm23 else result.fm23 := 0;
end;

function TCL3BivectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm12, 0.0) then result := result + Fmt(fm12,  APrecision, ADigits) + 'e12 ';
  if not SameValueEx(fm13, 0.0) then result := result + Fmt(fm13,  APrecision, ADigits) + 'e13 ';
  if not SameValueEx(fm23, 0.0) then result := result + Fmt(fm23,  APrecision, ADigits) + 'e23 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e12';

  result := '(' + result + ')';
end;

function TCL3BivectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm12, 0.0) then result := result + Fmt(fm12) + 'e12 ';
  if not SameValueEx(fm13, 0.0) then result := result + Fmt(fm13) + 'e13 ';
  if not SameValueEx(fm23, 0.0) then result := result + Fmt(fm23) + 'e23 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e12';

  result := '(' + result + ')';
end;

function TCL3BivectorHelper.ToMultivector: TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := fm12;
  result.fm13  := fm13;
  result.fm23  := fm23;
  result.fm123 := 0.0;
end;

// TCL3VectorHelper

function TCL3VectorHelper.Dual: TCL3Bivector;
begin
  result.fm12 :=  fm3;
  result.fm13 := -fm2;
  result.fm23 :=  fm1;
end;

function TCL3VectorHelper.Inverse: TCL3Vector;
begin
  result.fm1 := -fm1;
  result.fm2 := -fm2;
  result.fm3 := -fm3;
end;

function TCL3VectorHelper.Reverse: TCL3Vector;
begin
  result.fm1 := fm1;
  result.fm2 := fm2;
  result.fm3 := fm3;
end;

function TCL3VectorHelper.Conjugate: TCL3Vector;
begin
  result.fm1 := -fm1;
  result.fm2 := -fm2;
  result.fm3 := -fm3;
end;

function TCL3VectorHelper.Reciprocal: TCL3Vector;
begin
  result := Reverse / SquaredNorm;
end;

function TCL3VectorHelper.Normalized: TCL3Vector;
begin
  result := Self / Norm;
end;

function TCL3VectorHelper.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TCL3VectorHelper.SquaredNorm: double;
begin
  result := fm1*fm1 + fm2*fm2 + fm3*fm3;
end;

function TCL3VectorHelper.Dot(const AVector: TCL3Vector): double;
begin
 result :=  fm1 * AVector.fm1
           +fm2 * AVector.fm2
           +fm3 * AVector.fm3;
end;

function TCL3VectorHelper.Dot(const AVector: TCL3Bivector): TCL3Vector;
begin
  result.fm1 := -fm3 * AVector.fm13
                -fm2 * AVector.fm12;

  result.fm2 :=  fm1 * AVector.fm12
                -fm3 * AVector.fm23;

  result.fm3 :=  fm2 * AVector.fm23
                +fm1 * AVector.fm13;
end;

function TCL3VectorHelper.Dot(const AVector: TCL3Trivector): TCL3Bivector;
begin
  result.fm12 :=  fm3 * AVector.fm123;
  result.fm13 := -fm2 * AVector.fm123;
  result.fm23 :=  fm1 * Avector.fm123;
end;

function TCL3VectorHelper.Dot(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  fm1 * AVector.fm1
                  +fm2 * AVector.fm2
                  +fm3 * AVector.fm3;

  result.fm1   :=  fm1 * AVector.fm0
                  -fm2 * AVector.fm12
                  -fm3 * AVector.fm13;

  result.fm2   :=  fm1 * AVector.fm12
                  +fm2 * AVector.fm0
                  -fm3 * AVector.fm23;

  result.fm3   :=  fm1 * AVector.fm13
                  +fm2 * AVector.fm23
                  +fm3 * AVector.fm0;

  result.fm12  :=  fm3 * AVector.fm123;
  result.fm13  := -fm2 * AVector.fm123;
  result.fm23  :=  fm1 * Avector.fm123;
  result.fm123 :=  0.0;
end;

function TCL3VectorHelper.Wedge(const AVector: TCL3Vector): TCL3Bivector;
begin
  result.fm12 :=  fm1 * AVector.fm2
                 -fm2 * AVector.fm1;

  result.fm13 :=  fm1 * AVector.fm3
                 -fm3 * AVector.fm1;

  result.fm23 :=  fm2 * AVector.fm3
                 -fm3 * AVector.fm2;
end;

function TCL3VectorHelper.Wedge(const AVector: TCL3Bivector): TCL3Trivector;
begin
  result.fm123 :=  fm1 * AVector.fm23
                  -fm2 * AVector.fm13
                  +fm3 * AVector.fm12;
end;

function TCL3VectorHelper.Wedge(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3VectorHelper.Wedge(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  fm1 * AVector.fm0;
  result.fm2   :=  fm2 * AVector.fm0;
  result.fm3   :=  fm3 * AVector.fm0;

  result.fm12  :=  fm1 * AVector.fm2
                  -fm2 * AVector.fm1;

  result.fm13  :=  fm1 * AVector.fm3
                  -fm3 * AVector.fm1;

  result.fm23  :=  fm2 * AVector.fm3
                  -fm3 * AVector.fm2;

  result.fm123 :=  fm1 * AVector.fm23
                  -fm2 * AVector.fm13
                  +fm3 * AVector.fm12;
end;

function TCL3VectorHelper.Projection(const AVector: TCL3Vector): TCL3Vector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3VectorHelper.Projection(const AVector: TCL3Bivector): TCL3Vector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3VectorHelper.Projection(const AVector: TCL3Trivector): TCL3Vector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3VectorHelper.Projection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3VectorHelper.Rejection(const AVector: TCL3Vector): TCL3Vector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function  TCL3VectorHelper.Rejection(const AVector: TCL3Bivector): TCL3Vector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3VectorHelper.Rejection(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3VectorHelper.Rejection (const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3VectorHelper.Reflection(const AVector: TCL3Vector): TCL3Vector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3VectorHelper.Reflection(const AVector: TCL3Bivector): TCL3Vector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3VectorHelper.Reflection(const AVector: TCL3Trivector): TCL3Vector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3VectorHelper.Reflection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3VectorHelper.Rotation(const AVector1, AVector2: TCL3Vector): TCL3Vector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3VectorHelper.Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Vector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal  * AVector2.Reciprocal;
end;

function TCL3VectorHelper.Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Vector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal  * AVector2.Reciprocal;
end;

function TCL3VectorHelper.Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal  * AVector2.Reciprocal;
end;

function TCL3VectorHelper.Cross(const AVector: TCL3Vector): TCL3Vector;
begin
  result.fm1 :=  fm2*AVector.fm3
                -fm3*AVector.fm2;

  result.fm2 :=  fm1*AVector.fm3
                -fm3*AVector.fm1;

  result.fm3 :=  fm1*AVector.fm2
                -fm2*AVector.fm1;
end;

function TCL3VectorHelper.SameValue(const AValue: TCL3Multivector): boolean;
begin
  result := SameValueEx(0.0, AValue.fm0  ) and
            SameValueEx(fm1, AValue.fm1  ) and
            SameValueEx(fm2, AValue.fm2  ) and
            SameValueEx(fm3, AValue.fm3  ) and
            SameValueEx(0.0, AValue.fm12 ) and
            SameValueEx(0.0, AValue.fm13 ) and
            SameValueEx(0.0, AValue.fm23 ) and
            SameValueEx(0.0, AValue.fm123);
end;

function TCL3VectorHelper.SameValue(const AValue: TCL3Vector): boolean;
begin
  result := SameValueEx(fm1, AValue.fm1) and
            SameValueEx(fm2, AValue.fm2) and
            SameValueEx(fm3, AValue.fm3);
end;

function TCL3VectorHelper.ExtractVector(AComponents: TCL3MultivectorComponents): TCL3Vector;
begin
  if mcm1 in AComponents then result.fm1 := fm1 else result.fm1 := 0;
  if mcm2 in AComponents then result.fm2 := fm2 else result.fm2 := 0;
  if mcm3 in AComponents then result.fm3 := fm3 else result.fm3 := 0;
end;

function TCL3VectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm1, 0.0) then result := result + Fmt(fm1,  APrecision, ADigits) + 'e1 ';
  if not SameValueEx(fm2, 0.0) then result := result + Fmt(fm2,  APrecision, ADigits) + 'e2 ';
  if not SameValueEx(fm3, 0.0) then result := result + Fmt(fm3,  APrecision, ADigits) + 'e3 ';

    i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

function TCL3VectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm1, 0.0) then result := result + Fmt(fm1) + 'e1 ';
  if not SameValueEx(fm2, 0.0) then result := result + Fmt(fm2) + 'e2 ';
  if not SameValueEx(fm3, 0.0) then result := result + Fmt(fm3) + 'e3 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

function TCL3VectorHelper.ToMultivector: TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := fm1;
  result.fm2   := fm2;
  result.fm3   := fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

// TCL3Versors

class operator TCL3Versor1.*(const AValue: double; const ASelf: TCL3Versor1): TCL3Vector;
begin
  result.fm1 := AValue;
  result.fm2 := 0.0;
  result.fm3 := 0.0;
end;

class operator TCL3Versor2.*(const AValue: double; const ASelf: TCL3Versor2): TCL3Vector;
begin
  result.fm1 := 0.0;
  result.fm2 := AValue;
  result.fm3 := 0.0;
end;

class operator TCL3Versor3.*(const AValue: double; const ASelf: TCL3Versor3): TCL3Vector;
begin
  result.fm1 := 0.0;
  result.fm2 := 0.0;
  result.fm3 := AValue;
end;

// TCL3Biversors

class operator TCL3Biversor12.*(const AValue: double; const ASelf: TCL3Biversor12): TCL3Bivector;
begin
  result.fm12 := AValue;
  result.fm13 := 0.0;
  result.fm23 := 0.0;
end;

class operator TCL3Biversor13.*(const AValue: double; const ASelf: TCL3Biversor13): TCL3Bivector;
begin
  result.fm12 := 0.0;
  result.fm13 := AValue;
  result.fm23 := 0.0;
end;

class operator TCL3Biversor23.*(const AValue: double; const ASelf: TCL3Biversor23): TCL3Bivector;
begin
  result.fm12 := 0.0;
  result.fm13 := 0.0;
  result.fm23 := AValue;
end;

// TCL3Triversor

class operator TCL3Triversor123.*(const AValue: double; const ASelf: TCL3Triversor123): TCL3Trivector;
begin
  result.fm123 := AValue;
end;

end.

