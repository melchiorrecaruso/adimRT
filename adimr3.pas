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

  function Vector(const m1, m2: double): TR2Vector;
  function Vector(const m1, m2, m3: double): TR3Vector;
  function Vector(const m1, m2, m3, m4: double): TR4Vector;

  function Matrix(const m11, m12, m21, m22: double): TR2Matrix;
  function Matrix(const m11, m12, m13, m21, m22, m23, m31, m32, m33: double): TR3Matrix;
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

