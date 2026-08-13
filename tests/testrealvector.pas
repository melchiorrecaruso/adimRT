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

procedure TestRealVectorCore;
var
  u, v, w, r: TRealVector;
  A: TRealMatrix;
  c: TComplexVector;
  d: TReal;
begin
  Section('TRealVector - Init / Copy');

  u.Init([1, 2, 3]);

  Check('Init a[0]=1', Math.SameValue(u[0], 1, EPS));
  Check('Init a[1]=2', Math.SameValue(u[1], 2, EPS));
  Check('Init a[2]=3', Math.SameValue(u[2], 3, EPS));
  Check('real vector ToString uses scalar helper',
    u.ToString = '(1,2,3)');

  u.Init([1, 2]);
  Check('Init changes vector dimension', u.Size = 2);

  u.Init([1, 2, 3]);
  v := u;

  Check('Copy: data same', Math.SameValue(v[0], u[0], EPS));

  v[0] := 999;
  Check('Copy: independent', not Math.SameValue(v[0], u[0], EPS));

  Section('TRealVector - Arithmetic');

  u.Init([1, 2, 3]);
  v.Init([4, -1, 2]);

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

  Section('TRealVector - Dot / Cross / Norm');

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

  Section('TRealVector - Matrix * Vector / Vector * Matrix');

  A.Init([
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

  A.Init([
    1, 2,
    3, 4
  ]);
  Check('Matrix.Init changes order', A.Order = 2);
  Check('formatted real matrix ToString uses scalar helper',
    A.ToString(15, 0) = '((1, 2), (3, 4))');

  Section('TRealVector - IsNull / IsNotNull / = / <>');

  w.Init([0, 0, 0]);

  Check('zeros IsNull', w.IsNull);
  Check('u IsNotNull', u.IsNotNull);
  Check('u = u', u = u);
  Check('u <> v', u <> v);

  Section('TRealVector - ToComplex');

  c := u.ToComplex;
  CheckNear('ToComplex[0].Re=1', c[0].Re, 1.0, EPS);
  CheckNear('ToComplex[1].Re=2', c[1].Re, 2.0, EPS);
  CheckNear('ToComplex[2].Re=3', c[2].Re, 3.0, EPS);
  CheckNear('ToComplex[0].Im=0', c[0].Im, 0.0, EPS);
  CheckNear('ToComplex[1].Im=0', c[1].Im, 0.0, EPS);
  CheckNear('ToComplex[2].Im=0', c[2].Im, 0.0, EPS);
end;

procedure TestRealVector5;
var
  ru, rv, rn: TRealVector;
begin
  BeginCategory('Real vector ops (5-dim)');

  ru.Init([1, -2, 3, 0.5, 4]);
  rv.Init([2, 1, -1, 3, 0.25]);

  CmpR('dot(ru,rv)', ru * rv, -0.5);
  CmpR('norm(ru)', ru.Norm, 5.5);

  rn := ru.Normalize;
  CmpR('normalize[0]', rn[0], 0.18181818181818182);
  CmpR('normalize[1]', rn[1], -0.36363636363636365);
  CmpR('normalize[2]', rn[2], 0.5454545454545454);
  CmpR('normalize[4]', rn[4], 0.7272727272727273);
  CmpR('|normalize|=1', rn.Norm, 1.0);
end;

procedure TestRealMatrixVector4;
var
  M4: TRealMatrix;
  v4, mr: TRealVector;
begin
  BeginCategory('Real matrix*vector / vector*matrix (4-dim)');

  M4.Init([
    4,    1, 2, 0.5,
    2,    3, 0, 1,
    2,   -1, 5, 1,
    0.25, 1, 2, 4
  ]);

  v4.Init([1, 2, 3, 4]);

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

procedure TestRealCross;
var
  ru, rv, rn: TRealVector;
begin
  BeginCategory('Real cross product');

  ru.Init([1, -2, 3]);
  rv.Init([2, 1, -1]);

  rn := ru.Cross(rv);

  CmpR('cross[0]', rn[0], -1.0);
  CmpR('cross[1]', rn[1],  7.0);
  CmpR('cross[2]', rn[2],  5.0);
  CmpR('cross.u=0', rn * ru, 0.0);
  CmpR('cross.v=0', rn * rv, 0.0);
end;

procedure TestExtremeRealVectorNorms;
var
  v, n, r: TRealVector;
begin
  BeginCategory('Real vector extreme norms (numpy hypot.reduce)');

  v.Init([1e200, -1e200, 1e-200]);
  CmpRRel('large norm', v.Norm, 1.414213562373095e200, 1e-15);

  v.Init([1e-200, -1e-200, 0]);
  CmpRAbs('small norm scaled', v.Norm * 1e200,
    1.414213562373095, 1e-15);

  n := v.Normalize;
  CmpRAbs('small normalize[0]', n[0], 0.7071067811865475, 1e-15);
  CmpRAbs('small normalize[1]', n[1], -0.7071067811865475, 1e-15);

  r := v.Reciprocal;
  CmpRAbs('small reciprocal[0] scaled', r[0] * 1e-200, 0.5, 1e-15);
  CmpRAbs('small reciprocal[1] scaled', r[1] * 1e-200, -0.5, 1e-15);
end;

procedure TestRuntimeDimensionChecks;
var
  V2, V3, VR: TRealVector;
  M2, M3, MR: TRealMatrix;
  Raised: boolean;
begin
  Section('Runtime dimension checks');

  V2.Init([1, 2]);
  V3.Init([1, 2, 3]);
  M2.Init([1, 0, 0, 1]);
  M3.Init([1, 0, 0, 0, 1, 0, 0, 0, 1]);

  Check('vectors with different dimensions are not equal', V2 <> V3);
  Check('matrices with different orders are not equal', M2 <> M3);
  Check('SameValue returns false for different orders', not M2.SameValue(M3));

  Raised := False;
  try VR := V2 + V3 except on EDimensionError do Raised := True end;
  Check('vector addition checks dimensions', Raised);

  Raised := False;
  try VR := V2 - V3 except on EDimensionError do Raised := True end;
  Check('vector subtraction checks dimensions', Raised);

  Raised := False;
  try V2.Dot(V3) except on EDimensionError do Raised := True end;
  Check('dot product checks dimensions', Raised);

  Raised := False;
  try MR := M2 + M3 except on EDimensionError do Raised := True end;
  Check('matrix addition checks dimensions', Raised);

  Raised := False;
  try MR := M2 - M3 except on EDimensionError do Raised := True end;
  Check('matrix subtraction checks dimensions', Raised);

  Raised := False;
  try MR := M2 * M3 except on EDimensionError do Raised := True end;
  Check('matrix multiplication checks dimensions', Raised);

  Raised := False;
  try VR := M2 * V3 except on EDimensionError do Raised := True end;
  Check('matrix-vector product checks dimensions', Raised);

  Raised := False;
  try VR := V3 * M2 except on EDimensionError do Raised := True end;
  Check('vector-matrix product checks dimensions', Raised);

  Raised := False;
  try VR := M2.SolveLinear(V3) except on EDimensionError do Raised := True end;
  Check('SolveLinear checks dimensions', Raised);
end;

procedure Run;
begin
  TestRealVectorCore;
  TestRealVector5;
  TestRealMatrixVector4;
  TestRealCross;
  TestExtremeRealVectorNorms;
  TestRuntimeDimensionChecks;
end;

initialization
  RegisterSuite('Real vector (TRealVector)', @Run);

end.

