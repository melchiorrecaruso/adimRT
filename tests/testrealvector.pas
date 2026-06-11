{ TestRealVector.pas - Real vector (TRVector) tests for ADimMath.

  Part of the modular ADimMath test suite.  Registers itself with
  TestFramework; the main program runs it automatically.

  To add a new test case here: add statements inside an existing Test*
  procedure, or write a new Test* procedure and call it from Run below.

  @author  Melchiorre Caruso
}
unit TestRealVector;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}

interface

implementation

uses
  Math, SysUtils, StrUtils, ADimMath, TestFramework;

procedure TestTRVector;
var
  u, v, w, r: TRVector;
  A: TRMatrix;
  d: double;
  i: integer;
begin
  Section('TRVector - Init / New / Clone');

  u.Init(TArrayOfDouble.Create(1,2,3));
  Check('Init order=3',        u.Order = 3);
  Check('Init a[0]=1',         Math.SameValue(u[0],1,EPS));
  Check('Init a[2]=3',         Math.SameValue(u[2],3,EPS));

  v := u;  // triggers Copy operator
  Check('Copy: order same',   v.Order = u.Order);
  Check('Copy: data same',    Math.SameValue(v[0],u[0],EPS));
  v[0] := 999;
  Check('Copy: independent',  not Math.SameValue(v[0],u[0],EPS));

  Section('TRVector - Arithmetic');

  u.Init(TArrayOfDouble.Create(1,2,3));
  v.Init(TArrayOfDouble.Create(4,-1,2));

  r := u + v;
  Check('u+v [0]=5',  Math.SameValue(r[0],5,EPS));
  Check('u+v [1]=1',  Math.SameValue(r[1],1,EPS));
  Check('u+v [2]=5',  Math.SameValue(r[2],5,EPS));

  r := u - v;
  Check('u-v [0]=-3', Math.SameValue(r[0],-3,EPS));
  Check('u-v [1]=3',  Math.SameValue(r[1], 3,EPS));
  Check('u-v [2]=1',  Math.SameValue(r[2], 1,EPS));

  r := 2.0 * u;
  Check('2*u [0]=2',  Math.SameValue(r[0],2,EPS));
  Check('2*u [2]=6',  Math.SameValue(r[2],6,EPS));

  r := u * 2.0;
  Check('u*2 [0]=2',  Math.SameValue(r[0],2,EPS));

  r := u / 2.0;
  Check('u/2 [0]=0.5',Math.SameValue(r[0],0.5,EPS));
  Check('u/2 [2]=1.5',Math.SameValue(r[2],1.5,EPS));

  r := -u;
  Check('-u [0]=-1',  Math.SameValue(r[0],-1,EPS));
  Check('-u [2]=-3',  Math.SameValue(r[2],-3,EPS));

  Section('TRVector - Dot / Cross / Norm');

  // dot(u,v) = 1*4 + 2*(-1) + 3*2 = 4-2+6 = 8
  d := u * v;
  CheckNear('dot(u,v)=8', d, 8.0, EPS);
  CheckNear('u.Dot(v)=8', u.Dot(v), 8.0, EPS);

  // cross([1,2,3],[4,-1,2]) = [2*2-3*(-1), 3*4-1*2, 1*(-1)-2*4]
  //                         = [4+3, 12-2, -1-8] = [7, 10, -9]
  r := u.Cross(v);
  CheckNear('cross [0]=7',   r[0],  7.0, EPS);
  CheckNear('cross [1]=10',  r[1], 10.0, EPS);
  CheckNear('cross [2]=-9',  r[2], -9.0, EPS);

  // Verify cross is orthogonal to both operands
  CheckNear('cross perp u', u*r, 0.0, EPS);
  CheckNear('cross perp v', v*r, 0.0, EPS);

  // norm([1,2,3]) = sqrt(14) ~= 3.74165738677394
  CheckNear('norm(u)=sqrt(14)', u.Norm, sqrt(14), EPS);
  CheckNear('sqnorm(u)=14',     u.SquaredNorm, 14.0, EPS);

  // normalize
  r := u.Normalize;
  CheckNear('|normalize(u)|=1', r.Norm, 1.0, EPS);
  CheckNear('normalize[0]',     r[0], 1/sqrt(14), EPS);

  // reciprocal: each component / sqnorm
  r := u.Reciprocal;
  CheckNear('recip[0]=1/14',  r[0], 1/14.0, EPS);
  CheckNear('recip[1]=2/14',  r[1], 2/14.0, EPS);
  CheckNear('recip[2]=3/14',  r[2], 3/14.0, EPS);

  Section('TRVector - Matrix * Vector / Vector * Matrix');

  // A = [[1,2,3],[4,5,6],[7,8,10]]
  A.Init(TArrayOfDouble.Create(1,2,3, 4,5,6, 7,8,10));
  // A*u = [1+4+9, 4+10+18, 7+16+30] = [14, 32, 53]
  r := A * u;
  CheckNear('A*u [0]=14', r[0], 14.0, EPS);
  CheckNear('A*u [1]=32', r[1], 32.0, EPS);
  CheckNear('A*u [2]=53', r[2], 53.0, EPS);

  // u*A = [1*1+2*4+3*7, 1*2+2*5+3*8, 1*3+2*6+3*10]
  //     = [1+8+21, 2+10+24, 3+12+30] = [30, 36, 45]
  r := u * A;
  CheckNear('u*A [0]=30', r[0], 30.0, EPS);
  CheckNear('u*A [1]=36', r[1], 36.0, EPS);
  CheckNear('u*A [2]=45', r[2], 45.0, EPS);

  Section('TRVector - IsNull / IsNotNull / = / <>');

  w.Init(3);
  Check('zeros IsNull',     w.IsNull);
  Check('u IsNotNull',      u.IsNotNull);
  Check('u = u',            u = u);
  Check('u <> v',           u <> v);
end;

procedure TestRealVectors;
var
  ru, rv, rn: TRVector;
  M4: TRMatrix;
  v4, mr: TRVector;
begin
  BeginCategory('Real vector ops (5-dim)');
  ru.Init(TArrayOfDouble.Create(1, -2, 3, 0.5, 4));
  rv.Init(TArrayOfDouble.Create(2, 1, -1, 3, 0.25));

  CmpR('dot(ru,rv)', ru * rv, -0.5);
  CmpR('norm(ru)',   ru.Norm, 5.5);

  rn := ru.Normalize;
  CmpR('normalize[0]', rn[0], 0.18181818181818182);
  CmpR('normalize[1]', rn[1], -0.36363636363636365);
  CmpR('normalize[2]', rn[2], 0.5454545454545454);
  CmpR('normalize[4]', rn[4], 0.7272727272727273);
  CmpR('|normalize|=1', rn.Norm, 1.0);

  BeginCategory('Real matrix*vector (4-dim)');
  M4.Init(TArrayOfDouble.Create(4,1,2,0.5, 1,3,0,1, 2,0,5,1, 0.5,1,1,4));
  v4.Init(TArrayOfDouble.Create(1, 2, 3, 4));

  mr := M4 * v4;
  CmpR('M4*v4[0]', mr[0], 14.0);
  CmpR('M4*v4[1]', mr[1], 11.0);
  CmpR('M4*v4[2]', mr[2], 21.0);
  CmpR('M4*v4[3]', mr[3], 21.5);

  mr := v4 * M4;
  CmpR('v4*M4[0]', mr[0], 14.0);
  CmpR('v4*M4[1]', mr[1], 11.0);
  CmpR('v4*M4[2]', mr[2], 21.0);
  CmpR('v4*M4[3]', mr[3], 21.5);

  // Cross product (3-dim) - verify orthogonality vs numpy values
  BeginCategory('Real cross product');
  ru.Init(TArrayOfDouble.Create(1, -2, 3));
  rv.Init(TArrayOfDouble.Create(2, 1, -1));
  rn := ru.Cross(rv);
  // numpy cross([1,-2,3],[2,1,-1]) = [(-2)(-1)-3*1, 3*2-1*(-1), 1*1-(-2)*2]
  //                                = [2-3, 6+1, 1+4] = [-1, 7, 5]
  CmpR('cross[0]', rn[0], -1.0);
  CmpR('cross[1]', rn[1],  7.0);
  CmpR('cross[2]', rn[2],  5.0);
  CmpR('cross.u=0', rn * ru, 0.0);
  CmpR('cross.v=0', rn * rv, 0.0);
end;

{ Entry point: runs every test procedure in this unit. }
procedure Run;
begin
  TestTRVector;
  TestRealVectors;
end;

initialization
  RegisterSuite('Real vector (TRVector)', @Run);

end.
