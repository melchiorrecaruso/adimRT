{
  ADim complex vector space utilities.

  Provides factory functions for constructing @link(TComplex) numbers,
  complex vectors (@link(TC2Vector), @link(TC3Vector), @link(TC4Vector))
  and complex matrices (@link(TC2Matrix), @link(TC3Matrix), @link(TC4Matrix))
  from their individual components, as well as the global imaginary unit
  constant @link(img).

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

unit ADimC;

{$mode ObjFPC}{$H+}

interface

uses
  ADim;

var
  { The imaginary unit @code(i), defined by @code(i² = -1).
    Can be used directly in expressions to construct complex numbers idiomatically:
    @code(z := 3.0 + 2.0*img;)
  }
  img: TImaginaryUnit;

  { Creates a @link(TComplex) number from its real and imaginary parts.
    @param(ARe The real part.)
    @param(AIm The imaginary part.)
  }
  function Complex(const ARe, AIm: double): TComplex;

  { Creates a 2-component complex vector from two complex numbers.
    The result is @code(v = (a1, a2)ᵀ).
    @param(a1 The first component.)
    @param(a2 The second component.)
  }
  function Vector(const a1, a2: TComplex): TC2Vector;

  { Creates a 3-component complex vector from three complex numbers.
    The result is @code(v = (a1, a2, a3)ᵀ).
    @param(a1 The first component.)
    @param(a2 The second component.)
    @param(a3 The third component.)
  }
  function Vector(const a1, a2, a3: TComplex): TC3Vector;

  { Creates a 4-component complex vector from four complex numbers.
    The result is @code(v = (a1, a2, a3, a4)ᵀ).
    @param(a1 The first component.)
    @param(a2 The second component.)
    @param(a3 The third component.)
    @param(a4 The fourth component.)
  }
  function Vector(const a1, a2, a3, a4: TComplex): TC4Vector;

  { Creates a 2×2 complex matrix from its elements in row-major order.
    The result is:
    @code(| a11  a12 |)
    @code(| a21  a22 |)
    @param(a11 Element at row 1, column 1.)
    @param(a12 Element at row 1, column 2.)
    @param(a21 Element at row 2, column 1.)
    @param(a22 Element at row 2, column 2.)
  }
  function Matrix(const a11, a12, a21, a22: TComplex): TC2Matrix;

  { Creates a 3×3 complex matrix from its elements in row-major order.
    The result is:
    @code(| a11  a12  a13 |)
    @code(| a21  a22  a23 |)
    @code(| a31  a32  a33 |)
    @param(a11 Element at row 1, column 1.)
    @param(a12 Element at row 1, column 2.)
    @param(a13 Element at row 1, column 3.)
    @param(a21 Element at row 2, column 1.)
    @param(a22 Element at row 2, column 2.)
    @param(a23 Element at row 2, column 3.)
    @param(a31 Element at row 3, column 1.)
    @param(a32 Element at row 3, column 2.)
    @param(a33 Element at row 3, column 3.)
  }
  function Matrix(const a11, a12, a13, a21, a22, a23, a31, a32, a33: TComplex): TC3Matrix;

  { Creates a 4×4 complex matrix from its elements in row-major order.
    The result is:
    @code(| a11  a12  a13  a14 |)
    @code(| a21  a22  a23  a24 |)
    @code(| a31  a32  a33  a34 |)
    @code(| a41  a42  a43  a44 |)
    @param(a11 Element at row 1, column 1.)
    @param(a12 Element at row 1, column 2.)
    @param(a13 Element at row 1, column 3.)
    @param(a14 Element at row 1, column 4.)
    @param(a21 Element at row 2, column 1.)
    @param(a22 Element at row 2, column 2.)
    @param(a23 Element at row 2, column 3.)
    @param(a24 Element at row 2, column 4.)
    @param(a31 Element at row 3, column 1.)
    @param(a32 Element at row 3, column 2.)
    @param(a33 Element at row 3, column 3.)
    @param(a34 Element at row 3, column 4.)
    @param(a41 Element at row 4, column 1.)
    @param(a42 Element at row 4, column 2.)
    @param(a43 Element at row 4, column 3.)
    @param(a44 Element at row 4, column 4.)
  }
  function Matrix(const a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44: TComplex): TC4Matrix;

implementation

function Complex(const ARe, AIm: double): TComplex;
begin
  result.Re := ARe;
  result.Im := AIm;
end;

function Vector(const a1, a2: TComplex): TC2Vector;
begin
  result[1] := a1;
  result[2] := a2;
end;

function Vector(const a1, a2, a3: TComplex): TC3Vector;
begin
  result[1] := a1;
  result[2] := a2;
  result[3] := a3;
end;

function Vector(const a1, a2, a3, a4: TComplex): TC4Vector;
begin
  result[1] := a1;
  result[2] := a2;
  result[3] := a3;
  result[4] := a4;
end;

function Matrix(const a11, a12, a21, a22: TComplex): TC2Matrix;
begin
  result[1,1] := a11;
  result[1,2] := a12;
  result[2,1] := a21;
  result[2,2] := a22;
end;

function Matrix(const a11, a12, a13, a21, a22, a23, a31, a32, a33: TComplex): TC3Matrix;
begin
  result[1,1] := a11;
  result[1,2] := a12;
  result[1,3] := a13;
  result[2,1] := a21;
  result[2,2] := a22;
  result[2,3] := a23;
  result[3,1] := a31;
  result[3,2] := a32;
  result[3,3] := a33;
end;

function Matrix(const a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44: TComplex): TC4Matrix;
begin
  result[1,1] := a11;
  result[1,2] := a12;
  result[1,3] := a13;
  result[1,4] := a14;
  result[2,1] := a21;
  result[2,2] := a22;
  result[2,3] := a23;
  result[2,4] := a24;
  result[3,1] := a31;
  result[3,2] := a32;
  result[3,3] := a33;
  result[3,4] := a34;
  result[4,1] := a41;
  result[4,2] := a42;
  result[4,3] := a43;
  result[4,4] := a44;
end;

end.

