{ TestRealVector.pas - Real vector tests for ADimMath.
  Part of the modular ADimMath test suite. Registers itself with
  TestFramework; the main program runs it automatically.

  @author Melchiorre Caruso
}
unit TestRealVector;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}

interface

implementation

uses
  Math, SysUtils, ADimMath, TestFramework;

type
  T5DSpace = record const N = 5; end;

  T5RealVector = specialize TRealVector<T5DSpace>;

procedure TestT3RealVector;
var
  u, v, w, r: T3RealVector;
  A: T3RealMatrix;
  c: T3ComplexVector;
  d: double;
  Raised: boolean;
begin
  Section('T3RealVector - Assign / Copy');

  u.Assign([1, 2, 3]);

  Check('Assign a[0]=1', Math.SameValue(u[0], 1, EPS));
  Check('Assign a[1]=2', Math.SameValue(u[1], 2, EPS));
  Check('Assign a[2]=3', Math.SameValue(u[2], 3, EPS));

  Raised := False;
  try
    u.Assign([1, 2]);
  except
    on EArgumentException do
      Raised := True;
  end;
  Check('Assign rejects wrong dimension', Raised);

  u.Assign([1, 2, 3]);
  v := u;

  Check('Copy: data same', Math.SameValue(v[0], u[0], EPS));

  v[0] := 999;
  Check('Copy: independent', not Math.SameValue(v[0], u[0], EPS));

  Section('T3RealVector - Arithmetic');

  u.Assign([1, 2, 3]);
  v.Assign([4, -1, 2]);

  r := u + v;
  CheckNear('u+v [0]=5', r[0], 5.0, EPS);
  CheckNear('u+v [1]=1', r[1], 1.0, EPS);
  CheckNear('u+v [2]=5', r[2], 5.0, EPS);

  r := u - v;
  CheckNear('u-v [0]=-3', r[0], -3.0, EPS);
  CheckNear('u-v [1]=3',  r[1],  3.0, EPS);
  CheckNear('u-v [2]=1',  r[2],  1.0, EPS);

  r := 2.0 * u;
  CheckNear('2*u [0]=2', r[0], 2.0, EPS);
  CheckNear('2*u [2]=6', r[2], 6.0, EPS);

  r := u * 2.0;
  CheckNear('u*2 [0]=2', r[0], 2.0, EPS);
  CheckNear('u*2 [2]=6', r[2], 6.0, EPS);

  r := u / 2.0;
  CheckNear('u/2 [0]=0.5', r[0], 0.5, EPS);
  CheckNear('u/2 [2]=1.5', r[2], 1.5, EPS);

  r := -u;
  CheckNear('-u [0]=-1', r[0], -1.0, EPS);
  CheckNear('-u [2]=-3', r[2], -3.0, EPS);

  Section('T3RealVector - Dot / Cross / Norm');

  d := u * v;
  CheckNear('dot(u,v)=8', d, 8.0, EPS);
  CheckNear('u.Dot(v)=8', u.Dot(v), 8.0, EPS);

  r := u.Cross(v);
  CheckNear('cross [0]=7',  r[0],  7.0, EPS);
  CheckNear('cross [1]=10', r[1], 10.0, EPS);
  CheckNear('cross [2]=-9', r[2], -9.0, EPS);

  CheckNear('cross perp u', u * r, 0.0, EPS);
  CheckNear('cross perp v', v * r, 0.0, EPS);

  CheckNear('norm(u)=sqrt(14)', u.Norm, sqrt(14), EPS);
  CheckNear('sqnorm(u)=14', u.SquaredNorm, 14.0, EPS);

  r := u.Normalize;
  CheckNear('|normalize(u)|=1', r.Norm, 1.0, EPS);
  CheckNear('normalize[0]', r[0], 1 / sqrt(14), EPS);

  r := u.Reciprocal;
  CheckNear('recip[0]=1/14', r[0], 1 / 14.0, EPS);
  CheckNear('recip[1]=2/14', r[1], 2 / 14.0, EPS);
  CheckNear('recip[2]=3/14', r[2], 3 / 14.0, EPS);

  Section('T3RealVector - Matrix * Vector / Vector * Matrix');

  A.Assign([
    1, 2, 3,
    4, 5, 6,
    7, 8, 10
  ]);

  r := A * u;
  CheckNear('A*u [0]=14', r[0], 14.0, EPS);
  CheckNear('A*u [1]=32', r[1], 32.0, EPS);
  CheckNear('A*u [2]=53', r[2], 53.0, EPS);

  r := u * A;
  CheckNear('u*A [0]=30', r[0], 30.0, EPS);
  CheckNear('u*A [1]=36', r[1], 36.0, EPS);
  CheckNear('u*A [2]=45', r[2], 45.0, EPS);

  Raised := False;
  try
    A.Assign([
      1, 2,
      3, 4
    ]);
  except
    on EArgumentException do
      Raised := True;
  end;
  Check('Matrix.Assign rejects wrong dimension', Raised);

  Section('T3RealVector - IsNull / IsNotNull / = / <>');

  w.Assign([0, 0, 0]);

  Check('zeros IsNull', w.IsNull);
  Check('u IsNotNull', u.IsNotNull);
  Check('u = u', u = u);
  Check('u <> v', u <> v);

  Section('T3RealVector - ToComplex');

  c := u.ToComplex;
  CheckNear('ToComplex[0].Re=1', c[0].Re, 1.0, EPS);
  CheckNear('ToComplex[1].Re=2', c[1].Re, 2.0, EPS);
  CheckNear('ToComplex[2].Re=3', c[2].Re, 3.0, EPS);
  CheckNear('ToComplex[0].Im=0', c[0].Im, 0.0, EPS);
  CheckNear('ToComplex[1].Im=0', c[1].Im, 0.0, EPS);
  CheckNear('ToComplex[2].Im=0', c[2].Im, 0.0, EPS);
end;

procedure TestT5RealVector;
var
  ru, rv, rn: T5RealVector;
begin
  BeginCategory('Real vector ops (5-dim)');

  ru.Assign([1, -2, 3, 0.5, 4]);
  rv.Assign([2, 1, -1, 3, 0.25]);

  CmpR('dot(ru,rv)', ru * rv, -0.5);
  CmpR('norm(ru)', ru.Norm, 5.5);

  rn := ru.Normalize;
  CmpR('normalize[0]', rn[0], 0.18181818181818182);
  CmpR('normalize[1]', rn[1], -0.36363636363636365);
  CmpR('normalize[2]', rn[2], 0.5454545454545454);
  CmpR('normalize[4]', rn[4], 0.7272727272727273);
  CmpR('|normalize|=1', rn.Norm, 1.0);
end;

procedure TestT4RealMatrixVector;
var
  M4: T4RealMatrix;
  v4, mr: T4RealVector;
begin
  BeginCategory('Real matrix*vector / vector*matrix (4-dim)');

  M4.Assign([
    4,    1, 2, 0.5,
    2,    3, 0, 1,
    2,   -1, 5, 1,
    0.25, 1, 2, 4
  ]);

  v4.Assign([1, 2, 3, 4]);

  mr := M4 * v4;
  CmpR('M4*v4[0]', mr[0], 14.0);
  CmpR('M4*v4[1]', mr[1], 12.0);
  CmpR('M4*v4[2]', mr[2], 19.0);
  CmpR('M4*v4[3]', mr[3], 24.25);

  mr := v4 * M4;
  CmpR('v4*M4[0]', mr[0], 15.0);
  CmpR('v4*M4[1]', mr[1], 8.0);
  CmpR('v4*M4[2]', mr[2], 25.0);
  CmpR('v4*M4[3]', mr[3], 21.5);
end;

procedure TestT3RealCross;
var
  ru, rv, rn: T3RealVector;
begin
  BeginCategory('Real cross product');

  ru.Assign([1, -2, 3]);
  rv.Assign([2, 1, -1]);

  rn := ru.Cross(rv);

  CmpR('cross[0]', rn[0], -1.0);
  CmpR('cross[1]', rn[1],  7.0);
  CmpR('cross[2]', rn[2],  5.0);
  CmpR('cross.u=0', rn * ru, 0.0);
  CmpR('cross.v=0', rn * rv, 0.0);
end;

procedure TestExtremeRealVectorNorms;
var
  v, n, r: T3RealVector;
begin
  BeginCategory('Real vector extreme norms (numpy hypot.reduce)');

  v.Assign([1e200, -1e200, 1e-200]);
  CmpRRel('large norm', v.Norm, 1.414213562373095e200, 1e-15);

  v.Assign([1e-200, -1e-200, 0]);
  CmpRAbs('small norm scaled', v.Norm * 1e200,
    1.414213562373095, 1e-15);

  n := v.Normalize;
  CmpRAbs('small normalize[0]', n[0], 0.7071067811865475, 1e-15);
  CmpRAbs('small normalize[1]', n[1], -0.7071067811865475, 1e-15);

  r := v.Reciprocal;
  CmpRAbs('small reciprocal[0] scaled', r[0] * 1e-200, 0.5, 1e-15);
  CmpRAbs('small reciprocal[1] scaled', r[1] * 1e-200, -0.5, 1e-15);
end;

procedure Run;
begin
  TestT3RealVector;
  TestT5RealVector;
  TestT4RealMatrixVector;
  TestT3RealCross;
  TestExtremeRealVectorNorms;
end;

initialization
  RegisterSuite('Real vector (TRealVector)', @Run);

end.

