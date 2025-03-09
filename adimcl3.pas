{
  Description: ADim CL3 vector space utils.

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

implementation

end.

