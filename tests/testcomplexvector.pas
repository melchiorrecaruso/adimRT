{ TestComplexVector.pas - Complex vector tests for ADimMath.

  Part of the modular ADimMath test suite. Registers itself with
  TestFramework; the main program runs it automatically.

  @author Melchiorre Caruso
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
  zv1, zv2, zvr, zcopy: T3ComplexVector;
  d: TComplex;
  Raised: boolean;
begin
  Section('T3ComplexVector - Assign / arithmetic / Dot / Norm');

  // zv1 = [1+i, 2-i, 3i]
  // zv2 = [1, i, 2]
  zv1.Assign([C(1,1), C(2,-1), C(0,3)]);
  zv2.Assign([C(1,0), C(0,1), C(2,0)]);

  CheckCplxNear('Assign zv1[0]=1+i', zv1[0], C(1,1), EPS);
  CheckCplxNear('Assign zv1[1]=2-i', zv1[1], C(2,-1), EPS);
  CheckCplxNear('Assign zv1[2]=3i',  zv1[2], C(0,3), EPS);

  Raised := False;
  try
    zv1.Assign([C(1,0), C(2,0)]);
  except
    on EArgumentException do
      Raised := True;
  end;
  Check('Assign rejects wrong dimension', Raised);

  // Restore data after exception test.
  zv1.Assign([C(1,1), C(2,-1), C(0,3)]);

  // Deep-copy semantics.
  zcopy := zv1;
  CheckCplxNear('copy same data', zcopy[0], zv1[0], EPS);
  zcopy[0] := C(99,99);
  Check('copy independent storage',
    not SameValueEx(zcopy[0], zv1[0]));

  // zv1+zv2 = [2+i, 2+0i, 2+3i]
  zvr := zv1 + zv2;
  CheckCplxNear('zv1+zv2 [0]=2+1i', zvr[0], C(2,1), EPS);
  CheckCplxNear('zv1+zv2 [1]=2+0i', zvr[1], C(2,0), EPS);
  CheckCplxNear('zv1+zv2 [2]=2+3i', zvr[2], C(2,3), EPS);

  // zv1-zv2 = [i, 2-2i, -2+3i]
  zvr := zv1 - zv2;
  CheckCplxNear('zv1-zv2 [0]=i',      zvr[0], C(0,1), EPS);
  CheckCplxNear('zv1-zv2 [1]=2-2i',   zvr[1], C(2,-2), EPS);
  CheckCplxNear('zv1-zv2 [2]=-2+3i',  zvr[2], C(-2,3), EPS);

  // dot(zv1,zv2) = (1+i)*1 + (2-i)*i + 3i*2 = 2+9i
  d := zv1 * zv2;
  CheckCplxNear('dot(zv1,zv2)=2+9i', d, C(2,9), EPS);
  CheckCplxNear('zv1.Dot(zv2)=2+9i', zv1.Dot(zv2), C(2,9), EPS);

  // Bilinear contract: no conjugation is applied.
  CheckCplxNear('dot is bilinear, no conjugation',
    zv1.Dot(zv2), C(2,9), EPS);

  // norm(zv1) = sqrt(2+5+9) = 4
  CheckNear('norm(zv1)=4', zv1.Norm, 4.0, EPS);
  CheckNear('sqnorm(zv1)=16', zv1.SquaredNorm, 16.0, EPS);

  // Scalar multiplication, both sides.
  zvr := C(2,0) * zv1;
  CheckCplxNear('2*zv1 [0]=2+2i', zvr[0], C(2,2), EPS);
  CheckCplxNear('2*zv1 [1]=4-2i', zvr[1], C(4,-2), EPS);

  zvr := zv1 * C(0,1);
  CheckCplxNear('zv1*i [0]=-1+i', zvr[0], C(-1,1), EPS);
  CheckCplxNear('zv1*i [1]=1+2i', zvr[1], C(1,2), EPS);
  CheckCplxNear('zv1*i [2]=-3',   zvr[2], C(-3,0), EPS);

  // Real scalar multiplication/division.
  zvr := 2.0 * zv1;
  CheckCplxNear('2.0*zv1 [2]=6i', zvr[2], C(0,6), EPS);

  zvr := zv1 * 2.0;
  CheckCplxNear('zv1*2.0 [1]=4-2i', zvr[1], C(4,-2), EPS);

  zvr := zv1 / 2.0;
  CheckCplxNear('zv1/2 [0]=0.5+0.5i', zvr[0], C(0.5,0.5), EPS);

  zvr := zv1 / C(0,1);
  CheckCplxNear('zv1/i [0]=1-i',  zvr[0], C(1,-1), EPS);
  CheckCplxNear('zv1/i [1]=-1-2i', zvr[1], C(-1,-2), EPS);
  CheckCplxNear('zv1/i [2]=3',     zvr[2], C(3,0), EPS);

  // Unary operators.
  zvr := -zv1;
  CheckCplxNear('-zv1 [0]=-1-i', zvr[0], C(-1,-1), EPS);
  CheckCplxNear('-zv1 [2]=-3i',   zvr[2], C(0,-3), EPS);

  zvr := +zv1;
  CheckCplxNear('+zv1 [1]=2-i', zvr[1], C(2,-1), EPS);

  Section('T3ComplexVector - Conjugate / Normalize / Reciprocal');

  zvr := zv1.Conjugate;
  CheckCplxNear('conj(zv1)[0]=1-i', zvr[0], C(1,-1), EPS);
  CheckCplxNear('conj(zv1)[1]=2+i', zvr[1], C(2,1), EPS);
  CheckCplxNear('conj(zv1)[2]=-3i', zvr[2], C(0,-3), EPS);

  zvr := zv1.Normalize;
  CheckNear('|normalize(zv1)|=1', zvr.Norm, 1.0, EPS);
  CheckCplxNear('normalize[0]=(1+i)/4', zvr[0], C(0.25,0.25), EPS);
  CheckCplxNear('normalize[1]=(2-i)/4', zvr[1], C(0.5,-0.25), EPS);
  CheckCplxNear('normalize[2]=3i/4',    zvr[2], C(0,0.75), EPS);

  zvr := zv1.Reciprocal;
  CheckCplxNear('reciprocal[0]=(1+i)/16',
    zvr[0], C(1/16,1/16), EPS);
  CheckCplxNear('reciprocal[1]=(2-i)/16',
    zvr[1], C(2/16,-1/16), EPS);
  CheckCplxNear('reciprocal[2]=3i/16',
    zvr[2], C(0,3/16), EPS);

  Section('T3ComplexVector - IsNull / equality');

  zvr.Assign([C(0,0), C(0,0), C(0,0)]);
  Check('zero T3ComplexVector IsNull', zvr.IsNull);
  Check('zero T3ComplexVector not IsNotNull', not zvr.IsNotNull);
  Check('zv1 IsNotNull', zv1.IsNotNull);

  zcopy := zv1;
  Check('zv1 = copy', zv1 = zcopy);
  zcopy[2] := C(1,3);
  Check('zv1 <> modified copy', zv1 <> zcopy);

  Section('T3ComplexVector - zero-vector exceptions');

  Raised := False;
  try
    zvr.Normalize;
  except
    on EZeroDivide do
      Raised := True;
  end;
  Check('Normalize(null) raises EZeroDivide', Raised);

  Raised := False;
  try
    zvr.Reciprocal;
  except
    on EZeroDivide do
      Raised := True;
  end;
  Check('Reciprocal(null) raises EZeroDivide', Raised);
end;

procedure TestComplexVectors;
var
  zu, zv, zr: T3ComplexVector;
begin
  BeginCategory('Complex vector ops');

  zu.Assign([C(1,1), C(2,-1), C(0,3)]);
  zv.Assign([C(2,0), C(1,1), C(1,-2)]);

  // dot (bilinear, no conjugation - matches numpy.dot)
  CmpC('dot(zu,zv)', zu * zv, 11.0, 6.0);
  CmpC('zu.Dot(zv)', zu.Dot(zv), 11.0, 6.0);

  // norm (uses squared modulus -> real)
  CmpR('norm(zu)',   zu.Norm, 4.0);
  CmpR('sqnorm(zu)', zu.SquaredNorm, 16.0);

  // Cross product in C^3, using the algebraic bilinear formula.
  zr := zu.Cross(zv);
  CmpC('cross[0]', zr[0],  3.0, -8.0);
  CmpC('cross[1]', zr[1], -3.0,  7.0);
  CmpC('cross[2]', zr[2], -4.0,  4.0);

  // Bilinear orthogonality of algebraic cross product.
  CmpC('cross dot zu = 0', zr * zu, 0.0, 0.0);
  CmpC('cross dot zv = 0', zr * zv, 0.0, 0.0);
end;

procedure TestT2ComplexCrossException;
var
  u, v: T2ComplexVector;
  Raised: boolean;
begin
  BeginCategory('Complex cross dimension check');

  u.Assign([C(1,0), C(2,0)]);
  v.Assign([C(3,0), C(4,0)]);

  Raised := False;
  try
    u.Cross(v);
  except
    on ERangeError do
      Raised := True;
  end;

  Check('T2ComplexVector.Cross raises ERangeError', Raised);
end;

procedure TestExtremeComplexVectorNorms;
var
  v, n, r: T3ComplexVector;
begin
  BeginCategory('Complex vector extreme norms (numpy hypot.reduce)');

  v.Assign([C(1e200, 1e200), C(-1e200, 1e200), C(0, 1e-200)]);
  CmpRRel('large complex norm', v.Norm, 2e200, 1e-15);

  v.Assign([C(1e-200, 0), C(0, -1e-200), C(0, 0)]);
  CmpRAbs('small complex norm scaled', v.Norm * 1e200,
    1.414213562373095, 1e-15);

  n := v.Normalize;
  CmpCRel('small complex normalize[0]', n[0],
    0.7071067811865475, 0, 1e-15);
  CmpCRel('small complex normalize[1]', n[1],
    0, -0.7071067811865475, 1e-15);

  r := v.Reciprocal;
  CmpCRel('small complex reciprocal[0] scaled', 1e-200 * r[0],
    0.5, 0, 1e-15);
  CmpCRel('small complex reciprocal[1] scaled', 1e-200 * r[1],
    0, -0.5, 1e-15);
end;

{ Entry point: runs every test procedure in this unit. }
procedure Run;
begin
  TestTCVector;
  TestComplexVectors;
  TestT2ComplexCrossException;
  TestExtremeComplexVectorNorms;
end;

initialization
  RegisterSuite('Complex vector (TComplexVector)', @Run);

end.

