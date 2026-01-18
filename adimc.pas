{
  Description: ADim C/C2/C3 vector space utils.

  Copyright (C) 2025-2026 Melchiorre Caruso <melchiorrecaruso@gmail.com>

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

unit ADimC;

{$mode ObjFPC}{$H+}

interface

uses
  ADim;

var
  img: TImaginaryNumber;

  function Complex(const ARe, AIm: double): TComplex;

  function Vector(const a1, a2: TComplex): TC2Vector;
  function Vector(const a1, a2, a3: TComplex): TC3Vector;
  function Vector(const a1, a2, a3, a4: TComplex): TC4Vector;

  function Matrix(const a11, a12, a21, a22: TComplex): TC2Matrix;
  function Matrix(const a11, a12, a13, a21, a22, a23, a31, a32, a33: TComplex): TC3Matrix;
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

