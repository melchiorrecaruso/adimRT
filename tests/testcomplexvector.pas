{ TestComplexVector.pas - Complex vector (TCVector) tests for ADimMath.

  Part of the modular ADimMath test suite.  Registers itself with
  TestFramework; the main program runs it automatically.

  To add a new test case here: add statements inside an existing Test*
  procedure, or write a new Test* procedure and call it from Run below.

  @author  Melchiorre Caruso
}
unit TestComplexVector;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}

interface

implementation

uses
  Math, SysUtils, StrUtils, ADimMath, TestFramework;

procedure TestTCVector;
var
  zv1, zv2, zvr: TCVector;
  d: TComplex;
begin
  Section('TCVector - Init / arithmetic / Dot / Norm');

  // zv1 = [1+i, 2-i, 3i]  zv2 = [1, i, 2]
  zv1.Init(TArrayOfComplex.Create(C(1,1),C(2,-1),C(0,3)));
  zv2.Init(TArrayOfComplex.Create(C(1,0),C(0,1),C(2,0)));

  // zv1+zv2 = [2+i, 2+0i, 2+3i]  (from numpy)
  zvr := zv1 + zv2;
  CheckCplxNear('zv1+zv2 [0]=2+1i', zvr[0], C(2,1), EPS);
  CheckCplxNear('zv1+zv2 [1]=2+0i', zvr[1], C(2,0), EPS);
  CheckCplxNear('zv1+zv2 [2]=2+3i', zvr[2], C(2,3), EPS);

  // dot(zv1,zv2) = (1+i)*1 + (2-i)*i + 3i*2
  //             = (1+i) + (2i-i^2) + 6i
  //             = (1+i) + (1+2i) + 6i = 2+9i
  d := zv1 * zv2;
  CheckCplxNear('dot(zv1,zv2)=2+9i', d, C(2,9), EPS);
  CheckCplxNear('zv1.Dot(zv2)=2+9i', zv1.Dot(zv2), C(2,9), EPS);

  // norm(zv1) = sqrt(|1+i|^2+|2-i|^2+|3i|^2) = sqrt(2+5+9) = sqrt(16) = 4
  CheckNear('norm(zv1)=4', zv1.Norm, 4.0, EPS);
  CheckNear('sqnorm(zv1)=16', zv1.SquaredNorm, 16.0, EPS);

  // scalar multiplication
  zvr := C(2,0) * zv1;
  CheckCplxNear('2*zv1 [0]=2+2i', zvr[0], C(2,2), EPS);

  // negation
  zvr := -zv1;
  CheckCplxNear('-zv1 [0]=-1-i', zvr[0], C(-1,-1), EPS);

  // IsNull / IsNotNull
  zvr.Init(3);
  Check('zero TCVector IsNull',    zvr.IsNull);
  Check('zv1 IsNotNull',           zv1.IsNotNull);
end;

procedure TestComplexVectors;
var
  zu, zv: TCVector;
begin
  BeginCategory('Complex vector ops');
  zu.Init(TArrayOfComplex.Create(C(1,1), C(2,-1), C(0,3)));
  zv.Init(TArrayOfComplex.Create(C(2,0), C(1,1),  C(1,-2)));

  // dot (bilinear, no conjugation - matches numpy.dot)
  CmpC('dot(zu,zv)', zu * zv, 11.0, 6.0);
  CmpC('zu.Dot(zv)', zu.Dot(zv), 11.0, 6.0);

  // norm (uses conjugate -> real)
  CmpR('norm(zu)',   zu.Norm, 4.0);
  CmpR('sqnorm(zu)', zu.SquaredNorm, 16.0);
end;

{ Entry point: runs every test procedure in this unit. }
procedure Run;
begin
  TestTCVector;
  TestComplexVectors;
end;

initialization
  RegisterSuite('Complex vector (TCVector)', @Run);

end.
