{
  Description: ADim C/C2/C3 vector space utils.

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

unit ADimC;

{$mode ObjFPC}{$H+}

interface

uses
  ADim;

var
  img: TImaginaryNumber;

  function Ket(const a1, a2: TComplex): TC2Ket;
  function Ket(const a1, a2, a3: TComplex): TC3Ket;
  function Bra(const a1, a2: TComplex): TC2Bra;
  function Bra(const a1, a2, a3: TComplex): TC3Bra;
  function Matrix(const a11, a12, a21, a22: TComplex): TC2Matrix;
  function Matrix(const a11, a12, a13, a21, a22, a23, a31, a32, a33: TComplex): TC3Matrix;

implementation

function Ket(const a1, a2: TComplex): TC2Ket;
begin
  result.a1 := a1;
  result.a2 := a2;
end;

function Ket(const a1, a2, a3: TComplex): TC3Ket;
begin
  result.a1 := a1;
  result.a2 := a2;
  result.a3 := a3;
end;

function Bra(const a1, a2: TComplex): TC2Bra;
begin
  result.a1 := a1;
  result.a2 := a2;
end;

function Bra(const a1, a2, a3: TComplex): TC3Bra;
begin
  result.a1 := a1;
  result.a2 := a2;
  result.a3 := a3;
end;

function Matrix(const a11, a12, a21, a22: TComplex): TC2Matrix;
begin
  result.a11 := a11;
  result.a12 := a12;
  result.a21 := a21;
  result.a22 := a22;
end;

function Matrix(const a11, a12, a13, a21, a22, a23, a31, a32, a33: TComplex): TC3Matrix;
begin
  result.a11 := a11;
  result.a12 := a12;
  result.a13 := a13;
  result.a21 := a21;
  result.a22 := a22;
  result.a23 := a23;
  result.a31 := a31;
  result.a32 := a32;
  result.a33 := a33;
end;

end.

