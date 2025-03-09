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

  NullVector : TR3Vector = (fm1: 0.0; fm2: 0.0; fm3: 0.0);
  NullScalar : double    = (0.0);

implementation

end.

