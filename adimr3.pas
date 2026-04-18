{
  ADim real vector space utilities.

  Provides factory functions for constructing real vectors
  (@link(TR2Vector), @link(TR3Vector), @link(TR4Vector))
  and real matrices (@link(TR2Matrix), @link(TR3Matrix), @link(TR4Matrix))
  from their individual @code(double) components.

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

unit ADimR3;

{$mode ObjFPC}{$H+}

interface

uses
  ADim;

  { Creates a 2-component real vector from two scalar values.
    The result is @code(v = (m1, m2)ᵀ).
    @param(m1 The first component.)
    @param(m2 The second component.)
  }
  function Vector(const m1, m2: double): TR2Vector;

  { Creates a 3-component real vector from three scalar values.
    The result is @code(v = (m1, m2, m3)ᵀ).
    @param(m1 The first component.)
    @param(m2 The second component.)
    @param(m3 The third component.)
  }
  function Vector(const m1, m2, m3: double): TR3Vector;

  { Creates a 4-component real vector from four scalar values.
    The result is @code(v = (m1, m2, m3, m4)ᵀ).
    @param(m1 The first component.)
    @param(m2 The second component.)
    @param(m3 The third component.)
    @param(m4 The fourth component.)
  }
  function Vector(const m1, m2, m3, m4: double): TR4Vector;

  { Creates a 2×2 real matrix from its elements in row-major order.
    The result is:
    @code(| m11  m12 |)
    @code(| m21  m22 |)
    @param(m11 Element at row 1, column 1.)
    @param(m12 Element at row 1, column 2.)
    @param(m21 Element at row 2, column 1.)
    @param(m22 Element at row 2, column 2.)
  }
  function Matrix(const m11, m12, m21, m22: double): TR2Matrix;

  { Creates a 3×3 real matrix from its elements in row-major order.
    The result is:
    @code(| m11  m12  m13 |)
    @code(| m21  m22  m23 |)
    @code(| m31  m32  m33 |)
    @param(m11 Element at row 1, column 1.)
    @param(m12 Element at row 1, column 2.)
    @param(m13 Element at row 1, column 3.)
    @param(m21 Element at row 2, column 1.)
    @param(m22 Element at row 2, column 2.)
    @param(m23 Element at row 2, column 3.)
    @param(m31 Element at row 3, column 1.)
    @param(m32 Element at row 3, column 2.)
    @param(m33 Element at row 3, column 3.)
  }
  function Matrix(const m11, m12, m13, m21, m22, m23, m31, m32, m33: double): TR3Matrix;

  { Creates a 4×4 real matrix from its elements in row-major order.
    The result is:
    @code(| m11  m12  m13  m14 |)
    @code(| m21  m22  m23  m24 |)
    @code(| m31  m32  m33  m34 |)
    @code(| m41  m42  m43  m44 |)
    @param(m11 Element at row 1, column 1.)
    @param(m12 Element at row 1, column 2.)
    @param(m13 Element at row 1, column 3.)
    @param(m14 Element at row 1, column 4.)
    @param(m21 Element at row 2, column 1.)
    @param(m22 Element at row 2, column 2.)
    @param(m23 Element at row 2, column 3.)
    @param(m24 Element at row 2, column 4.)
    @param(m31 Element at row 3, column 1.)
    @param(m32 Element at row 3, column 2.)
    @param(m33 Element at row 3, column 3.)
    @param(m34 Element at row 3, column 4.)
    @param(m41 Element at row 4, column 1.)
    @param(m42 Element at row 4, column 2.)
    @param(m43 Element at row 4, column 3.)
    @param(m44 Element at row 4, column 4.)
  }
  function Matrix(const m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44: double): TR4Matrix;

implementation

function Vector(const m1, m2: double): TR2Vector;
begin
  result[1] := m1;
  result[2] := m2;
end;

function Vector(const m1, m2, m3: double): TR3Vector;
begin
  result[1] := m1;
  result[2] := m2;
  result[3] := m3;
end;

function Vector(const m1, m2, m3, m4: double): TR4Vector;
begin
  result[1] := m1;
  result[2] := m2;
  result[3] := m3;
  result[4] := m4;
end;

function Matrix(const m11, m12, m21, m22: double): TR2Matrix;
begin
  result[1,1] := m11;
  result[1,2] := m12;
  result[2,1] := m21;
  result[2,2] := m22;
end;

function Matrix(const m11, m12, m13, m21, m22, m23, m31, m32, m33: double): TR3Matrix;
begin
  result[1,1] := m11;
  result[1,2] := m12;
  result[1,3] := m13;

  result[2,1] := m21;
  result[2,2] := m22;
  result[2,3] := m23;

  result[3,1] := m31;
  result[3,2] := m32;
  result[3,3] := m33;
end;

function Matrix(const m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44: double): TR4Matrix;
begin
  result[1,1] := m11;
  result[1,2] := m12;
  result[1,3] := m13;
  result[1,4] := m14;

  result[2,1] := m21;
  result[2,2] := m22;
  result[2,3] := m23;
  result[2,4] := m24;

  result[3,1] := m31;
  result[3,2] := m32;
  result[3,3] := m33;
  result[3,4] := m34;

  result[4,1] := m41;
  result[4,2] := m42;
  result[4,3] := m43;
  result[4,4] := m44;
end;

end.

