{ TestComplexNumbers.pas - Complex numbers (scalar algebra) tests for ADimMath.

  Part of the modular ADimMath test suite.  Registers itself with
  TestFramework; the main program runs it automatically.

  To add a new test case here: add statements inside an existing Test*
  procedure, or write a new Test* procedure and call it from Run below.

  @author  Melchiorre Caruso
}
unit TestComplexNumbers;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}

interface

implementation

uses
  Math, SysUtils, StrUtils, ADimMath, TestFramework;

procedure TestTComplex;
var
  z1, z2, zr: TComplex;
begin
  Section('TComplex - arithmetic');

  z1 := C(3, 4);
  z2 := C(1, -2);

  // Basic operators
  CheckCplxNear('Add (3+4i)+(1-2i) = 4+2i',       z1+z2,     C(4, 2),    EPS);
  CheckCplxNear('Sub (3+4i)-(1-2i) = 2+6i',        z1-z2,     C(2, 6),    EPS);
  CheckCplxNear('Mul (3+4i)*(1-2i) = 11-2i',       z1*z2,     C(11,-2),   EPS);
  CheckCplxNear('Div (3+4i)/(1-2i) = -1+2i',       z1/z2,     C(-1, 2),   EPS);
  CheckCplxNear('Neg -(3+4i) = -3-4i',             -z1,        C(-3,-4),   EPS);
  CheckCplxNear('Pos +(3+4i) = 3+4i',              +z1,        C(3, 4),    EPS);

  // Mixed real/complex
  CheckCplxNear('(3+4i)+2.0 = 5+4i',               z1+2.0,    C(5, 4),    EPS);
  CheckCplxNear('2.0+(3+4i) = 5+4i',               2.0+z1,    C(5, 4),    EPS);
  CheckCplxNear('(3+4i)-2.0 = 1+4i',               z1-2.0,    C(1, 4),    EPS);
  CheckCplxNear('2.0-(3+4i) = -1-4i',              2.0-z1,    C(-1,-4),   EPS);
  CheckCplxNear('2.5*(3+4i) = 7.5+10i',            2.5*z1,    C(7.5,10),  EPS);
  CheckCplxNear('(3+4i)*2.5 = 7.5+10i',            z1*2.5,    C(7.5,10),  EPS);
  CheckCplxNear('(3+4i)/2.0 = 1.5+2i',             z1/2.0,    C(1.5, 2),  EPS);
  CheckCplxNear('2.0/(3+4i) = 0.12-0.16i',         2.0/z1,    C(0.24,-0.32), EPS);

  // Methods
  CheckCplxNear('Conjugate(3+4i) = 3-4i',          z1.Conjugate, C(3,-4),  EPS);
  CheckCplxNear('Reciprocal(3+4i) = 0.12-0.16i',   z1.Reciprocal,C(0.12,-0.16),EPS);
  CheckNear(    'Norm(3+4i) = 5',                   z1.Norm,   5.0,        EPS);
  CheckNear(    'SquaredNorm(3+4i) = 25',           z1.SquaredNorm, 25.0,  EPS);
  CheckNear(    'Arg(3+4i) = arctan(4/3)',          z1.Arg, ArcTan2(4,3),  EPS);

  // Equality / inequality
  Check('(3+4i) = (3+4i)',  z1 = C(3,4));
  Check('(3+4i) <> (1-2i)', z1 <> z2);

  // IsNull / IsNotNull
  zr := C(0, 0);
  Check('IsNull  (0+0i)',      zr.IsNull);
  Check('IsNotNull (3+4i)',    z1.IsNotNull);

  // Zero procedure
  z1.Zero;
  Check('Zero sets Re=0', Math.SameValue(z1.Re, 0, EPS));
  Check('Zero sets Im=0', Math.SameValue(z1.Im, 0, EPS));

  // Assignment from double
  zr := 5.0;
  Check(':=(5.0) sets Re=5', Math.SameValue(zr.Re, 5, EPS));
  Check(':=(5.0) sets Im=0', Math.SameValue(zr.Im, 0, EPS));

  Section('TComplex - standalone functions (Norm, SquareNorm, Abs)');
  z1 := C(3, 4);
  CheckNear('Abs(3+4i) = 5',            Abs(z1),         5.0,   EPS);
  CheckNear('Norm(3+4i) = 5',           Norm(z1),        5.0,   EPS);
  CheckNear('SquareNorm(3+4i) = 25',    SquareNorm(z1),  25.0,  EPS);
  CheckNear('Abs(real 3.0) = 3',        Abs(3.0),        3.0,   EPS);
  CheckNear('SquareNorm(real 3.0) = 9', SquareNorm(3.0), 9.0,   EPS);
  CheckNear('Norm(real 3.0) = 3',       Norm(3.0),       3.0,   EPS);
end;

procedure TestTImaginaryUnit;
var
  z: TComplex;
begin
  Section('TImaginaryUnit');

  // i*i = -1
  CheckNear('img*img = -1', img*img, -1.0, EPS);

  // i/i = 1
  CheckNear('img/img = 1', img/img, 1.0, EPS);

  // Conversione implicita
  z := img;
  CheckCplxNear(':=(img) = 0+1i', z, C(0,1), EPS);

  // Unary
  CheckCplxNear('+img = 0+1i',    +img,       C(0, 1),  EPS);
  CheckCplxNear('-img = 0-1i',    -img,       C(0,-1),  EPS);

  // real +/- img
  CheckCplxNear('3.0+img = 3+1i', 3.0+img,    C(3, 1),  EPS);
  CheckCplxNear('img+3.0 = 3+1i', img+3.0,    C(3, 1),  EPS);
  CheckCplxNear('3.0-img = 3-1i', 3.0-img,    C(3,-1),  EPS);
  CheckCplxNear('img-3.0 = -3+i', img-3.0,    C(-3,1),  EPS);

  // real * img
  CheckCplxNear('2.0*img = 0+2i', 2.0*img,    C(0, 2),  EPS);
  CheckCplxNear('img*2.0 = 0+2i', img*2.0,    C(0, 2),  EPS);

  // real / img
  CheckCplxNear('4.0/img = 0-4i', 4.0/img,    C(0,-4),  EPS);
  CheckCplxNear('img/2.0 = 0+0.5i',img/2.0,   C(0,0.5), EPS);

  // complex +/- img
  z := C(3,4);
  CheckCplxNear('(3+4i)+img = 3+5i', z+img,   C(3, 5),  EPS);
  CheckCplxNear('img+(3+4i) = 3+5i', img+z,   C(3, 5),  EPS);
  CheckCplxNear('(3+4i)-img = 3+3i', z-img,   C(3, 3),  EPS);
  CheckCplxNear('img-(3+4i) = -3-3i',img-z,   C(-3,-3), EPS);

  // complex * img = rotation by 90deg: (3+4i)*i = -4+3i
  CheckCplxNear('(3+4i)*img = -4+3i', z*img,  C(-4, 3), EPS);
  CheckCplxNear('img*(3+4i) = -4+3i', img*z,  C(-4, 3), EPS);

  // complex / img: (3+4i)/i = 4-3i
  CheckCplxNear('(3+4i)/img = 4-3i',  z/img,  C(4,-3),  EPS);

  // img / complex: i/(3+4i) = (4+3i)/25
  CheckCplxNear('img/(3+4i) = 0.16+0.12i', img/z, C(0.16,0.12), EPS);
end;

procedure TestSolveEquation;
var
  roots2: TArrayOfComplex;
  roots3: TArrayOfComplex;
  roots4: TArrayOfComplex;
  r:      array[0..3] of TComplex;
  i:      integer;

  procedure SortRoots2;
  var tmp: TComplex;
  begin
    if roots2[0].Re > roots2[1].Re then
    begin tmp := roots2[0]; roots2[0] := roots2[1]; roots2[1] := tmp; end;
  end;

  procedure SortRoots3;
  var tmp: TComplex; j, k: integer;
  begin
    for j := 0 to 1 do
      for k := j+1 to 2 do
        if roots3[j].Re > roots3[k].Re then
        begin tmp := roots3[j]; roots3[j] := roots3[k]; roots3[k] := tmp; end;
  end;

  procedure SortRoots4;
  var tmp: TComplex; j, k: integer;
  begin
    for j := 0 to 2 do
      for k := j+1 to 3 do
        if roots4[j].Re > roots4[k].Re then
        begin tmp := roots4[j]; roots4[j] := roots4[k]; roots4[k] := tmp; end;
  end;

begin
  Section('SolveEquation');

  // Linear real: x + 3 = 0 => x = -3
  CheckNear('linear real: x+3=0 => -3', SolveEquation(3.0), -3.0, EPS);

  // Linear complex: x + (2+3i) = 0 => x = -2-3i
  CheckCplxNear('linear cplx: x+(2+3i)=0 => -2-3i',
                SolveEquation(C(2,3)), C(-2,-3), EPS);

  // Quadratic: x^2 - 5x + 6 = 0  (roots 2 and 3)
  // SolveEquation(a,b) solves x^2 + ax + b = 0 => a=-5, b=6
  roots2 := SolveEquation(C(-5,0), C(6,0));
  SortRoots2;
  CheckCplxNear('quadratic root[0]=2', roots2[0], C(2,0), EPS);
  CheckCplxNear('quadratic root[1]=3', roots2[1], C(3,0), EPS);

  // Cubic: x^3 - 6x^2 + 11x - 6 = 0  (roots 1, 2, 3)
  // SolveEquation(a,b,c) solves x^3 + ax^2 + bx + c = 0
  // This triple has q = 0, p <> 0 (depressed-cubic special branch).
  roots3 := SolveEquation(C(-6,0), C(11,0), C(-6,0));
  SortRoots3;
  CheckCplxNear('cubic(q=0) root[0]=1', roots3[0], C(1,0), EPS);
  CheckCplxNear('cubic(q=0) root[1]=2', roots3[1], C(2,0), EPS);
  CheckCplxNear('cubic(q=0) root[2]=3', roots3[2], C(3,0), EPS);

  // Cubic: x^3 - 8x^2 + 17x - 10 = 0  (roots 1, 2, 5)
  // Both p and q non-zero (general Cardano branch).
  roots3 := SolveEquation(C(-8,0), C(17,0), C(-10,0));
  SortRoots3;
  CheckCplxNear('cubic(general) root[0]=1', roots3[0], C(1,0), EPS);
  CheckCplxNear('cubic(general) root[1]=2', roots3[1], C(2,0), EPS);
  CheckCplxNear('cubic(general) root[2]=5', roots3[2], C(5,0), EPS);

  // Cubic: x^3 - 8 = 0  (a=b=0, p=0 branch): one real root 2,
  // two complex roots -1 +/- i*sqrt(3).
  roots3 := SolveEquation(C(0,0), C(0,0), C(-8,0));
  SortRoots3;
  // Sorted by real part: the two complex (Re=-1) come first, then 2.
  CheckCplxNear('cubic(p=0) real root = 2+0i', roots3[2], C(2,0), EPS);
  Check('cubic(p=0) root[0].Re = -1', Math.SameValue(roots3[0].Re, -1.0, EPS));
  Check('cubic(p=0) root[1].Re = -1', Math.SameValue(roots3[1].Re, -1.0, EPS));
  Check('cubic(p=0) |imag| = sqrt(3)', Math.SameValue(Abs(roots3[0].Im), sqrt(3), EPS));

  // Quartic: (x-1)(x-2)(x-3)(x-4)=0 => x^4 - 10x^3 + 35x^2 - 50x + 24
  // SolveEquation(a,b,c,d) solves x^4 + ax^3 + bx^2 + cx + d = 0
  roots4 := SolveEquation(C(-10,0), C(35,0), C(-50,0), C(24,0));
  SortRoots4;
  CheckCplxNear('quartic root[0]=1', roots4[0], C(1,0), EPS);
  CheckCplxNear('quartic root[1]=2', roots4[1], C(2,0), EPS);
  CheckCplxNear('quartic root[2]=3', roots4[2], C(3,0), EPS);
  CheckCplxNear('quartic root[3]=4', roots4[3], C(4,0), EPS);
end;

procedure TestRoots;
var
  sr: TArrayOfComplex;
  cr: TArrayOfComplex;
  qr: TArrayOfComplex;
  z:  TComplex;
  i:  integer;

  function CplxNear(A, B: TComplex): boolean;
  begin
    result := Math.SameValue(A.Re, B.Re, EPS) and
              Math.SameValue(A.Im, B.Im, EPS);
  end;

  function AnyNear(const Arr: TArrayOfComplex; AVal: TComplex): boolean;
  var k: integer;
  begin
    result := False;
    for k := 0 to High(Arr) do
      if CplxNear(Arr[k], AVal) then begin result := True; Break; end;
  end;

begin
  Section('SquareRoot / CubicRoot / QuarticRoot');

  // sqrt(3+4i) = 2+i  and  -2-i
  z  := C(3, 4);
  sr := SquareRoot(z);
  Check('sqrt(3+4i) contains  2+1i',  AnyNear(sr, C( 2, 1)));
  Check('sqrt(3+4i) contains -2-1i',  AnyNear(sr, C(-2,-1)));
  // Verify: each root squared gives back z
  for i := 0 to 1 do
    CheckCplxNear(Format('sqrt(3+4i)[%d]^2 = 3+4i', [i]),
                  sr[i]*sr[i], z, EPS);

  // cbrt(-8): roots are 2*exp(i*(pi/3 + 2*pi*k/3)) for k=0,1,2
  //   k=0: 2*(cos(pi/3)+i*sin(pi/3)) = 1 + i*sqrt(3)
  //   k=1: 2*(cos(pi)  +i*sin(pi)  ) = -2
  //   k=2: 2*(cos(5pi/3)+i*sin(5pi/3)) = 1 - i*sqrt(3)
  z  := C(-8, 0);
  cr := CubicRoot(z);
  Check('cbrt(-8) contains -2+0i',         AnyNear(cr, C(-2, 0)));
  Check('cbrt(-8) contains 1+i*sqrt(3)',   AnyNear(cr, C(1,  sqrt(3))));
  Check('cbrt(-8) contains 1-i*sqrt(3)',   AnyNear(cr, C(1, -sqrt(3))));
  // Verify: each root cubed gives back z
  for i := 0 to 2 do
    CheckCplxNear(Format('cbrt(-8)[%d]^3 = -8', [i]),
                  cr[i]*cr[i]*cr[i], z, EPS);

  // 4th roots of 16: |16|=16, arg=0 => roots are 2*exp(i*pi*k/2)
  //   k=0:  2, k=1: 2i, k=2: -2, k=3: -2i
  z  := C(16, 0);
  qr := QuarticRoot(z);
  Check('4rt(16) contains  2+0i',  AnyNear(qr, C( 2, 0)));
  Check('4rt(16) contains  0+2i',  AnyNear(qr, C( 0, 2)));
  Check('4rt(16) contains -2+0i',  AnyNear(qr, C(-2, 0)));
  Check('4rt(16) contains  0-2i',  AnyNear(qr, C( 0,-2)));
  // Verify: each root to the 4th gives back z
  for i := 0 to 3 do
    CheckCplxNear(Format('4rt(16)[%d]^4 = 16', [i]),
                  qr[i]*qr[i]*qr[i]*qr[i], z, EPS);
end;

procedure TestPowers;
var
  z: TComplex;
begin
  Section('SquarePower / CubicPower / QuarticPower');

  z := C(1, 1);  // 1+i
  // (1+i)^2 = 2i
  CheckCplxNear('(1+i)^2 = 0+2i',  SquarePower(z),  C(0,2),  EPS);
  // (1+i)^3 = (1+i)^2*(1+i) = 2i*(1+i) = 2i-2 = -2+2i
  CheckCplxNear('(1+i)^3 = -2+2i', CubicPower(z),   C(-2,2), EPS);
  // (1+i)^4 = ((1+i)^2)^2 = (2i)^2 = -4
  CheckCplxNear('(1+i)^4 = -4+0i', QuarticPower(z), C(-4,0), EPS);

  z := C(2, 0);
  CheckCplxNear('2^2 = 4',  SquarePower(z),  C(4,0),  EPS);
  CheckCplxNear('2^3 = 8',  CubicPower(z),   C(8,0),  EPS);
  CheckCplxNear('2^4 = 16', QuarticPower(z), C(16,0), EPS);
end;

procedure TestSameValueEx;
begin
  Section('SameValueEx');
  Check('1e-13 ~= 0 (below eps)',  SameValueEx(1e-13, 0.0));
  Check('1e-11 <> 0 (above eps)', not SameValueEx(1e-11, 0.0));
  Check('1.0 ~= 1.0',             SameValueEx(1.0, 1.0));
  Check('cplx (1+i)~=(1+i)',      SameValueEx(C(1,1), C(1,1)));
  Check('cplx (1+i)<>(1+2i)',     not SameValueEx(C(1,1), C(1,2)));
end;

{ Entry point: runs every test procedure in this unit. }
procedure Run;
begin
  TestTComplex;
  TestTImaginaryUnit;
  TestSolveEquation;
  TestRoots;
  TestPowers;
  TestSameValueEx;
end;

initialization
  RegisterSuite('Complex numbers (scalar algebra)', @Run);

end.
