{
  Description: ADim R3 vector space utils.

  Copyright (C) 2025 Melchiorre Caruso <melchiorrecaruso@gmail.com>

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

unit ADimR3;

{$mode ObjFPC}{$H+}

interface

uses
  ADim;

const
  e1 : TR3Versor1 = ();
  e2 : TR3Versor2 = ();
  e3 : TR3Versor3 = ();

  u1 : TR3Vector = (fm1:1.0; fm2:0.0; fm3:0.0);
  u2 : TR3Vector = (fm1:0.0; fm2:1.0; fm3:0.0);
  u3 : TR3Vector = (fm1:0.0; fm2:0.0; fm3:1.0);

  function Vector(const m1, m2, m3: double): TR3Vector;
  function Matrix(const m11, m12, m21, m22: double): TR2Matrix;
  function Matrix(const m11, m12, m13, m21, m22, m23, m31, m32, m33: double): TR3Matrix;
  function Matrix(const m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44: double): TR4Matrix;

implementation

function Vector(const m1, m2, m3: double): TR3Vector;
begin
  result.a1 := m1;
  result.a2 := m2;
  result.a3 := m3;
end;

function Matrix(const m11, m12, m21, m22: double): TR2Matrix;
begin
  result.a11 := m11;
  result.a12 := m12;
  result.a21 := m21;
  result.a22 := m22;
end;

function Matrix(const m11, m12, m13, m21, m22, m23, m31, m32, m33: double): TR3Matrix;
begin
  result.a11 := m11;
  result.a12 := m12;
  result.a13 := m13;

  result.a21 := m21;
  result.a22 := m22;
  result.a23 := m23;

  result.a31 := m31;
  result.a32 := m32;
  result.a33 := m33;
end;

function Matrix(const m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44: double): TR4Matrix;
begin
  result.a11 := m11;
  result.a12 := m12;
  result.a13 := m13;
  result.a14 := m14;

  result.a21 := m21;
  result.a22 := m22;
  result.a23 := m23;
  result.a24 := m24;

  result.a31 := m31;
  result.a32 := m32;
  result.a33 := m33;
  result.a34 := m34;

  result.a41 := m41;
  result.a42 := m42;
  result.a43 := m43;
  result.a44 := m44;
end;

end.

