{ TestRealMatrix.pas - Real matrix tests for ADimMath.

  Updated for the fixed-dimension generic matrix/vector API.
  Existing numerical/stress cases are retained; initialization now uses Assign.

  @author Melchiorre Caruso
}
unit TestRealMatrix;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}

interface

implementation

uses
  Math, SysUtils, StrUtils, ADimMath, TestFramework;


type
  TArrayOfDouble = array of double;

  T1DTestSpace  = record const N = 1;  end;
  T5DTestSpace  = record const N = 5;  end;
  T6DTestSpace  = record const N = 6;  end;
  T7DTestSpace  = record const N = 7;  end;
  T8DTestSpace  = record const N = 8;  end;
  T9DTestSpace  = record const N = 9;  end;
  T10DTestSpace = record const N = 10; end;
  T12DTestSpace = record const N = 12; end;
  T16DTestSpace = record const N = 16; end;
  T24DTestSpace = record const N = 24; end;
  T32DTestSpace = record const N = 32; end;
  T64DTestSpace = record const N = 64; end;
  T100DTestSpace = record const N = 100; end;
  T1000DTestSpace = record const N = 1000; end;

  T1RealMatrix  = specialize TRealMatrix<T1DTestSpace>;
  T5RealMatrix  = specialize TRealMatrix<T5DTestSpace>;
  T6RealMatrix  = specialize TRealMatrix<T6DTestSpace>;
  T7RealMatrix  = specialize TRealMatrix<T7DTestSpace>;
  T8RealMatrix  = specialize TRealMatrix<T8DTestSpace>;
  T9RealMatrix  = specialize TRealMatrix<T9DTestSpace>;
  T10RealMatrix = specialize TRealMatrix<T10DTestSpace>;
  T12RealMatrix = specialize TRealMatrix<T12DTestSpace>;
  T16RealMatrix = specialize TRealMatrix<T16DTestSpace>;
  T24RealMatrix = specialize TRealMatrix<T24DTestSpace>;
  T32RealMatrix = specialize TRealMatrix<T32DTestSpace>;
  T64RealMatrix = specialize TRealMatrix<T64DTestSpace>;
  T100RealMatrix = specialize TRealMatrix<T100DTestSpace>;
  T1000RealMatrix = specialize TRealMatrix<T1000DTestSpace>;

  T5RealVector = specialize TRealVector<T5DTestSpace>;
  T6RealVector = specialize TRealVector<T6DTestSpace>;
  T7RealVector = specialize TRealVector<T7DTestSpace>;
  T8RealVector = specialize TRealVector<T8DTestSpace>;

  T1ComplexVector  = specialize TComplexVector<T1DTestSpace>;
  T5ComplexVector  = specialize TComplexVector<T5DTestSpace>;
  T6ComplexVector  = specialize TComplexVector<T6DTestSpace>;
  T7ComplexVector  = specialize TComplexVector<T7DTestSpace>;
  T8ComplexVector  = specialize TComplexVector<T8DTestSpace>;
  T9ComplexVector  = specialize TComplexVector<T9DTestSpace>;
  T10ComplexVector = specialize TComplexVector<T10DTestSpace>;

  T12ComplexVector = specialize TComplexVector<T12DTestSpace>;
  T16ComplexVector = specialize TComplexVector<T16DTestSpace>;
  T24ComplexVector = specialize TComplexVector<T24DTestSpace>;
  T32ComplexVector = specialize TComplexVector<T32DTestSpace>;
  T64ComplexVector = specialize TComplexVector<T64DTestSpace>;
  T100ComplexVector = specialize TComplexVector<T100DTestSpace>;
  T1000ComplexVector = specialize TComplexVector<T1000DTestSpace>;
  T12ComplexMatrix = specialize TComplexMatrix<T12DTestSpace>;

  T5ComplexMatrix = specialize TComplexMatrix<T5DTestSpace>;

function ExtractRealEigenvalues(const AValues: T1ComplexVector): TArrayOfDouble; overload;
begin
  SetLength(result, 1);
  result[0] := AValues[0].Re;
end;

function ExtractRealEigenvalues(const AValues: T2ComplexVector): TArrayOfDouble; overload;
var
  i: integer;
begin
  SetLength(result, 2);
  for i := 0 to 1 do result[i] := AValues[i].Re;
end;

function ExtractRealEigenvalues(const AValues: T3ComplexVector): TArrayOfDouble; overload;
var
  i: integer;
begin
  SetLength(result, 3);
  for i := 0 to 2 do result[i] := AValues[i].Re;
end;

function ExtractRealEigenvalues(const AValues: T4ComplexVector): TArrayOfDouble; overload;
var
  i: integer;
begin
  SetLength(result, 4);
  for i := 0 to 3 do result[i] := AValues[i].Re;
end;

function ExtractRealEigenvalues(const AValues: T5ComplexVector): TArrayOfDouble; overload;
var
  i: integer;
begin
  SetLength(result, 5);
  for i := 0 to 4 do result[i] := AValues[i].Re;
end;

function ExtractRealEigenvalues(const AValues: T6ComplexVector): TArrayOfDouble; overload;
var
  i: integer;
begin
  SetLength(result, 6);
  for i := 0 to 5 do result[i] := AValues[i].Re;
end;

function ExtractRealEigenvalues(const AValues: T7ComplexVector): TArrayOfDouble; overload;
var
  i: integer;
begin
  SetLength(result, 7);
  for i := 0 to 6 do result[i] := AValues[i].Re;
end;

function ExtractRealEigenvalues(const AValues: T8ComplexVector): TArrayOfDouble; overload;
var
  i: integer;
begin
  SetLength(result, 8);
  for i := 0 to 7 do result[i] := AValues[i].Re;
end;

function ExtractRealEigenvalues(const AValues: T9ComplexVector): TArrayOfDouble; overload;
var
  i: integer;
begin
  SetLength(result, 9);
  for i := 0 to 8 do result[i] := AValues[i].Re;
end;

function ExtractRealEigenvalues(const AValues: T10ComplexVector): TArrayOfDouble; overload;
var
  i: integer;
begin
  SetLength(result, 10);
  for i := 0 to 9 do result[i] := AValues[i].Re;
end;

procedure TestTRMatrix;
var
  A1: T1RealMatrix;
  A2, Res2: T2RealMatrix;
  A3, B3, C3, Res3: T3RealMatrix;
  A4: T4RealMatrix;
  eigs: TArrayOfDouble;
  Raised: boolean;

  procedure LoadA;
  begin
    A3.Assign([1,2,3, 4,5,6, 7,8,10]);
  end;

  procedure LoadB;
  begin
    B3.Assign([2,0,1, 1,3,0, 0,1,2]);
  end;

begin
  Section('TRealMatrix - Assign / Clone');

  A3 := A3.Null;
  Check('3x3 all zero', A3.IsNull);

  LoadA;
  Check('Assign with data: a[0,0]=1', Math.SameValue(A3[0,0],1, EPS));
  Check('Assign with data: a[2,2]=10', Math.SameValue(A3[2,2],10,EPS));

  C3 := A3.Clone;
  Check('Clone: same data', C3.SameValue(A3));
  C3[0,0] := 999;
  Check('Clone: independent storage', not Math.SameValue(C3[0,0], A3[0,0], EPS));

  Raised := False;
  try
    A3.Assign([1,2,3,4,5]);
  except
    on EArgumentException do Raised := True;
  end;
  Check('Assign with 5 values raises EArgumentException', Raised);

  Section('TRealMatrix - Identity / Null / Diagonalize');

  Res3 := A3.Identity;
  Check('Identity[0,0]=1', Math.SameValue(Res3[0,0],1,EPS));
  Check('Identity[0,1]=0', Math.SameValue(Res3[0,1],0,EPS));
  Check('Identity[1,1]=1', Math.SameValue(Res3[1,1],1,EPS));

  Res3 := A3.Null;
  Check('Null is zero', Res3.IsNull);

  Section('TRealMatrix - Determinant / Trace / Rank / Norm');

  LoadA;
  CheckNear('det(A) = -3', A3.Determinant, -3.0, EPS);
  LoadB;
  CheckNear('det(B) = 13', B3.Determinant, 13.0, EPS);
  LoadA;
  Check('rank(A) = 3', A3.Rank = 3);
  CheckNear('trace(A) = 16', A3.Trace, 16.0, EPS);
  CheckNear('norm(A) frob', A3.Norm, 17.4355957741627, EPS);

  C3.Assign([1,2,3, 2,4,6, 3,6,9]);
  Check('rank([[1,2,3],[2,4,6],[3,6,9]]) = 1', C3.Rank = 1);

  C3 := C3.Null;
  Check('rank(zeros) = 0', C3.Rank = 0);

  Section('TRealMatrix - Add / Sub / Mul / ScalarMul / Transpose');

  LoadA;
  LoadB;
  Res3 := A3 + B3;
  Check('A+B [0,0]=3', Math.SameValue(Res3[0,0],3,EPS));
  Check('A+B [1,1]=8', Math.SameValue(Res3[1,1],8,EPS));
  Check('A+B [2,2]=12', Math.SameValue(Res3[2,2],12,EPS));

  Res3 := A3 - B3;
  Check('A-B [0,0]=-1', Math.SameValue(Res3[0,0],-1,EPS));
  Check('A-B [2,2]=8', Math.SameValue(Res3[2,2],8,EPS));

  Res3 := A3 * B3;
  Check('A*B [0,0]=4', Math.SameValue(Res3[0,0],4,EPS));
  Check('A*B [0,1]=9', Math.SameValue(Res3[0,1],9,EPS));
  Check('A*B [1,0]=13', Math.SameValue(Res3[1,0],13,EPS));
  Check('A*B [2,1]=34', Math.SameValue(Res3[2,1],34,EPS));
  Check('A*B [2,2]=27', Math.SameValue(Res3[2,2],27,EPS));

  Res3 := 2.0 * A3;
  Check('2*A [0,0]=2', Math.SameValue(Res3[0,0],2,EPS));
  Check('2*A [2,2]=20', Math.SameValue(Res3[2,2],20,EPS));

  Res3 := A3 * 2.0;
  Check('A*2 [0,0]=2', Math.SameValue(Res3[0,0],2,EPS));

  Res3 := 0.5 * A3;
  Check('A/2 [0,0]=0.5', Math.SameValue(Res3[0,0],0.5,EPS));
  Check('A/2 [2,2]=5', Math.SameValue(Res3[2,2],5,EPS));

  Res3 := A3.Transpose;
  Check('A^T [0,1]=4', Math.SameValue(Res3[0,1],4,EPS));
  Check('A^T [1,0]=2', Math.SameValue(Res3[1,0],2,EPS));
  Check('A^T [2,0]=3', Math.SameValue(Res3[2,0],3,EPS));

  Section('TRealMatrix - Inverse');

  Res3 := A3.Inverse;
  CheckNear('inv(A)[0,0] ~= -0.6667', Res3[0,0], -2/3, EPS);
  CheckNear('inv(A)[0,1] ~= -1.3333', Res3[0,1], -4/3, EPS);
  CheckNear('inv(A)[0,2] ~= 1', Res3[0,2], 1.0, EPS);
  CheckNear('inv(A)[1,1] ~= 3.6667', Res3[1,1], 11/3, EPS);
  CheckNear('inv(A)[2,0] ~= 1', Res3[2,0], 1.0, EPS);

  C3 := A3 * Res3;
  Check('A*inv(A)[0,0]~=1', Math.SameValue(C3[0,0],1,EPS));
  Check('A*inv(A)[0,1]~=0', Math.SameValue(C3[0,1],0,EPS));
  Check('A*inv(A)[1,1]~=1', Math.SameValue(C3[1,1],1,EPS));
  Check('A*inv(A)[2,2]~=1', Math.SameValue(C3[2,2],1,EPS));

  A2.Assign([3,1, 2,4]);
  CheckNear('det([[3,1],[2,4]]) = 10', A2.Determinant, 10.0, EPS);
  Res2 := A2.Inverse;
  CheckNear('inv(2x2)[0,0]=0.4', Res2[0,0], 0.4, EPS);
  CheckNear('inv(2x2)[0,1]=-0.1', Res2[0,1], -0.1, EPS);
  CheckNear('inv(2x2)[1,0]=-0.2', Res2[1,0], -0.2, EPS);
  CheckNear('inv(2x2)[1,1]=0.3', Res2[1,1], 0.3, EPS);

  Section('TRealMatrix - RowReduction');

  A3.Assign([2,1,-1, 4,3,1, 2,2,3]);
  Res3 := A3.RowReduction;
  Check('RREF[0,0]=1', Math.SameValue(Res3[0,0],1,EPS));
  Check('RREF[0,1]=0', Math.SameValue(Res3[0,1],0,EPS));
  Check('RREF[0,2]=0', Math.SameValue(Res3[0,2],0,EPS));
  Check('RREF[1,0]=0', Math.SameValue(Res3[1,0],0,EPS));
  Check('RREF[1,1]=1', Math.SameValue(Res3[1,1],1,EPS));
  Check('RREF[1,2]=0', Math.SameValue(Res3[1,2],0,EPS));
  Check('RREF[2,0]=0', Math.SameValue(Res3[2,0],0,EPS));
  Check('RREF[2,1]=0', Math.SameValue(Res3[2,1],0,EPS));
  Check('RREF[2,2]=1', Math.SameValue(Res3[2,2],1,EPS));

  Section('TRealMatrix - Eigenvalues');

  A3.Assign([4,2,1, 2,5,3, 1,3,6]);
  eigs := ExtractRealEigenvalues(A3.Eigenvalues);
  SortAscArray(eigs);
  CheckNear('S3 eig[0] ~= 1.9213', eigs[0], 1.9213469419616895, 1e-6);
  CheckNear('S3 eig[1] ~= 3.7302', eigs[1], 3.730159123688258, 1e-6);
  CheckNear('S3 eig[2] ~= 9.3485', eigs[2], 9.348493934350051, 1e-6);

  A4.Assign([5,1,0,2, 1,4,1,0, 0,1,3,1, 2,0,1,6]);
  eigs := ExtractRealEigenvalues(A4.Eigenvalues);
  SortAscArray(eigs);
  CheckNear('S4 eig[0] ~= 1.8122', eigs[0], 1.81216339, 1e-5);
  CheckNear('S4 eig[1] ~= 3.7838', eigs[1], 3.78382333, 1e-5);
  CheckNear('S4 eig[2] ~= 4.5484', eigs[2], 4.54837849, 1e-5);
  CheckNear('S4 eig[3] ~= 7.8556', eigs[3], 7.85563479, 1e-5);

  A1.Assign([7]);
  eigs := ExtractRealEigenvalues(A1.Eigenvalues);
  CheckNear('1x1 eigenvalue = 7', eigs[0], 7.0, EPS);

  A2.Assign([3,1, 1,3]);
  eigs := ExtractRealEigenvalues(A2.Eigenvalues);
  SortAscArray(eigs);
  CheckNear('2x2 symm eig[0]=2', eigs[0], 2.0, 1e-6);
  CheckNear('2x2 symm eig[1]=4', eigs[1], 4.0, 1e-6);

  A3.Assign([3,0,0, 0,1,0, 0,0,5]);
  eigs := ExtractRealEigenvalues(A3.Eigenvalues);
  SortAscArray(eigs);
  CheckNear('diag(3,1,5) eig[0]=1', eigs[0], 1.0, 1e-6);
  CheckNear('diag(3,1,5) eig[1]=3', eigs[1], 3.0, 1e-6);
  CheckNear('diag(3,1,5) eig[2]=5', eigs[2], 5.0, 1e-6);

  Section('TRealMatrix - IsUnitary (orthogonal)');

  Res3 := A3.Identity;
  Check('I3 IsUnitary=true', (Res3.Transpose * Res3).SameValue(Res3.Identity));

  A3.Assign([
    cos(Pi/4), -sin(Pi/4), 0,
    sin(Pi/4),  cos(Pi/4), 0,
    0,          0,         1
  ]);
  Check('Rz(45deg) IsUnitary=true', (A3.Transpose * A3).SameValue(A3.Identity));

  LoadA;
  Check('A IsUnitary=false', not (A3.Transpose * A3).SameValue(A3.Identity));

  Section('TRealMatrix - SameValue / = / <>');

  C3 := A3.Clone;
  Check('A = Clone(A)', A3 = C3);
  Check('A.SameValue(A)', A3.SameValue(C3));
  C3[0,0] := 0;
  Check('A <> modified', A3 <> C3);

  Section('TRealMatrix - Swap');

  A2.Assign([1,2, 3,4]);
  A2.Swap(0,1);
  Check('Swap rows: [0,0]=3', Math.SameValue(A2[0,0],3,EPS));
  Check('Swap rows: [1,0]=1', Math.SameValue(A2[1,0],1,EPS));
end;

procedure TestSolveLinear;
var
  A2: T2RealMatrix;
  A3, Inv3, Prod3, Id3: T3RealMatrix;
  A4: T4RealMatrix;
  A5: T5RealMatrix;
  A6: T6RealMatrix;
  A7: T7RealMatrix;
  A8: T8RealMatrix;
  xt2, b2, x2: T2RealVector;
  xt3, b3, x3: T3RealVector;
  xt4, b4, x4: T4RealVector;
  xt5, b5, x5: T5RealVector;
  xt6, b6, x6: T6RealVector;
  xt7, b7, x7: T7RealVector;
  xt8, b8, x8, r8: T8RealVector;
  i, j: integer;
  Raised: boolean;
begin
  Section('TRealMatrix - linear systems via public API');

  A2.Assign([2,1, 1,3]);
  b2.Assign([4,7]);
  x2 := A2.SolveLinear(b2);
  CheckNear('2x2 known x[0]=1', x2[0], 1.0, EPS);
  CheckNear('2x2 known x[1]=2', x2[1], 2.0, EPS);

  BeginCategory('Scaled real matrix (numpy reference)');
  A3.Assign([
    4e-15, 1e-15, 2e-15,
    1e-15, 3e-15, 0,
    2e-15, 0,     5e-15]);
  xt3.Assign([1, -2, 3]);
  b3.Assign([8e-15, -5e-15, 1.7e-14]);
  x3 := A3.SolveLinear(b3);
  CmpRAbs('scaled solve x[0]', x3[0], xt3[0], 1e-14);
  CmpRAbs('scaled solve x[1]', x3[1], xt3[1], 1e-14);
  CmpRAbs('scaled solve x[2]', x3[2], xt3[2], 1e-14);
  CmpRAbs('scaled determinant / 1e-44', A3.Determinant * 1e44,
    4.2999999999999827, 1e-12);

  Inv3 := A3.Inverse;
  CmpRRel('scaled inverse[0,0] * 1e-15', Inv3[0,0] * 1e-15,
    0.3488372093023256, 1e-14);
  CmpRRel('scaled inverse[1,1] * 1e-15', Inv3[1,1] * 1e-15,
    0.37209302325581395, 1e-14);
  CmpRRel('scaled inverse[2,2] * 1e-15', Inv3[2,2] * 1e-15,
    0.25581395348837205, 1e-14);
  Prod3 := A3 * Inv3;
  Id3 := A3.Identity;
  for i := 0 to 2 do
    for j := 0 to 2 do
      CmpRAbs('scaled inverse reconstruction', Prod3[i,j], Id3[i,j], 1e-13);

  A2.Assign([1e200, -1e200, 1e-200, -1e-200]);
  CmpRRel('extreme matrix Frobenius norm', A2.Norm,
    1.414213562373095e200, 1e-15);

  BeginCategory('Linear system forward error (random)');

  A4 := A4.Null;
  for i := 0 to 3 do
  begin
    xt4[i] := i + 1;
    for j := 0 to 3 do A4[i,j] := Sin(7.0*i + 13.0*j);
    A4[i,i] := A4[i,i] + 4;
  end;
  b4 := A4 * xt4;
  x4 := A4.SolveLinear(b4);
  for i := 0 to 3 do
    CmpRRel(Format('n=4 x[%d]', [i]), x4[i], xt4[i], 1e-10);

  A5 := A5.Null;
  for i := 0 to 4 do
  begin
    xt5[i] := i + 1;
    for j := 0 to 4 do A5[i,j] := Sin(7.0*i + 13.0*j);
    A5[i,i] := A5[i,i] + 5;
  end;
  b5 := A5 * xt5;
  x5 := A5.SolveLinear(b5);
  for i := 0 to 4 do
    CmpRRel(Format('n=5 x[%d]', [i]), x5[i], xt5[i], 1e-10);

  A6 := A6.Null;
  for i := 0 to 5 do
  begin
    xt6[i] := i + 1;
    for j := 0 to 5 do A6[i,j] := Sin(7.0*i + 13.0*j);
    A6[i,i] := A6[i,i] + 6;
  end;
  b6 := A6 * xt6;
  x6 := A6.SolveLinear(b6);
  for i := 0 to 5 do
    CmpRRel(Format('n=6 x[%d]', [i]), x6[i], xt6[i], 1e-10);

  A7 := A7.Null;
  for i := 0 to 6 do
  begin
    xt7[i] := i + 1;
    for j := 0 to 6 do A7[i,j] := Sin(7.0*i + 13.0*j);
    A7[i,i] := A7[i,i] + 7;
  end;
  b7 := A7 * xt7;
  x7 := A7.SolveLinear(b7);
  for i := 0 to 6 do
    CmpRRel(Format('n=7 x[%d]', [i]), x7[i], xt7[i], 1e-10);

  A8 := A8.Null;
  for i := 0 to 7 do
  begin
    xt8[i] := i + 1;
    for j := 0 to 7 do A8[i,j] := Sin(7.0*i + 13.0*j);
    A8[i,i] := A8[i,i] + 8;
  end;
  b8 := A8 * xt8;
  x8 := A8.SolveLinear(b8);
  for i := 0 to 7 do
    CmpRRel(Format('n=8 x[%d]', [i]), x8[i], xt8[i], 1e-10);

  BeginCategory('Linear system residual (Hilbert 8, ill-cond)');
  A8 := A8.Null;
  for i := 0 to 7 do
    for j := 0 to 7 do
      A8[i,j] := 1.0 / (i + j + 1);
  for i := 0 to 7 do xt8[i] := 1.0;
  b8 := A8 * xt8;
  x8 := A8.SolveLinear(b8);
  r8 := A8 * x8 - b8;
  CmpRAbs('residual |Ax-b|', r8.Norm, 0.0, 1e-13);

  Section('TRealMatrix - linear system exceptions');

  Raised := False;
  try
    A3.Assign([1,2,3,4]);
  except
    on EArgumentException do Raised := True;
  end;
  Check('size mismatch represented by Assign raises EArgumentException', Raised);

  Raised := False;
  A2.Assign([1,2, 2,4]);
  b2.Assign([1,1]);
  try
    x2 := A2.SolveLinear(b2);
  except
    on EZeroDivide do Raised := True;
  end;
  Check('singular system raises EZeroDivide', Raised);
end;

procedure TestEigenvectors;
var
  A2: T2RealMatrix;
  A3: T3RealMatrix;
  A4: T4RealMatrix;
  A5: T5RealMatrix;
  V2, ZA2: T2ComplexMatrix;
  V3, ZA3: T3ComplexMatrix;
  V4, ZA4: T4ComplexMatrix;
  V5, ZA5: T5ComplexMatrix;
  ev2: T2ComplexVector;
  ev3: T3ComplexVector;
  ev4: T4ComplexVector;
  ev5: T5ComplexVector;
  col2, res2: T2ComplexVector;
  col3, res3: T3ComplexVector;
  col4, res4: T4ComplexVector;
  col5, res5: T5ComplexVector;
  proj: TComplex;
  i, j, k: integer;
  offdiag: double;
begin
  Section('TRealMatrix - Eigenvectors');

  A3.Assign([4,2,1, 2,5,3, 1,3,6]);
  BeginCategory('Eigenvectors sym 3x3');
  ev3 := A3.Eigenvalues;
  V3 := A3.Eigenvectors(ev3);
  ZA3 := A3.ToComplex;
  for j := 0 to 2 do
  begin
    for i := 0 to 2 do col3[i] := V3[i,j];
    res3 := ZA3 * col3 - ev3[j] * col3;
    CmpRAbs(Format('sym3 |Av-lv| col %d', [j]), res3.Norm, 0.0, 1e-9);
    CmpRAbs(Format('sym3 |v|=1 col %d', [j]), col3.Norm, 1.0, 1e-9);
  end;
  for j := 0 to 2 do
    for k := j+1 to 2 do
    begin
      proj := 0;
      for i := 0 to 2 do proj := proj + V3[i,j] * V3[i,k].Conjugate;
      CmpRAbs(Format('sym3 ortho %d.%d', [j, k]), Abs(proj), 0.0, 1e-9);
    end;
  for j := 0 to 2 do
    for i := 0 to 2 do
      CmpRAbs(Format('sym3 Im=0 [%d,%d]', [i, j]), Abs(V3[i,j].Im), 0.0, 1e-12);

  A5.Assign([
    3.9681451856646284, -0.6470635423949582, -1.0683766715308218, 0.6550202348522072, -0.20412897125396062,
    -0.6470635423949582, 2.39008949997781, 0.07219196833991376, -0.2941787990675794, 0.712498847669345,
    -1.0683766715308218, 0.07219196833991376, 3.019026569770013, -0.23153568981902073, -0.904663136857451,
    0.6550202348522072, -0.2941787990675794, -0.23153568981902073, 2.253034895825433, -0.35479089535141245,
    -0.20412897125396062, 0.712498847669345, -0.904663136857451, -0.35479089535141245, 4.369703848762114
  ]);
  BeginCategory('Eigenvectors degenerate 2,2,2,5,5');
  ev5 := A5.Eigenvalues;
  V5 := A5.Eigenvectors(ev5);
  ZA5 := A5.ToComplex;
  for j := 0 to 4 do
  begin
    for i := 0 to 4 do col5[i] := V5[i,j];
    res5 := ZA5 * col5 - ev5[j] * col5;
    CmpRAbs(Format('deg5 |Av-lv| col %d', [j]), res5.Norm, 0.0, 1e-7);
    CmpRAbs(Format('deg5 |v|=1 col %d', [j]), col5.Norm, 1.0, 1e-9);
  end;
  offdiag := 0;
  for j := 0 to 4 do
    for k := j+1 to 4 do
    begin
      proj := 0;
      for i := 0 to 4 do proj := proj + V5[i,j] * V5[i,k].Conjugate;
      if Abs(proj) > offdiag then offdiag := Abs(proj);
    end;
  CmpRAbs('deg5 max |<vi,vj>|', offdiag, 0.0, 1e-7);

  A2.Assign([0,-1, 1,0]);
  BeginCategory('Eigenvectors rotation 2x2');
  ev2 := A2.Eigenvalues;
  V2 := A2.Eigenvectors(ev2);
  ZA2 := A2.ToComplex;
  for j := 0 to 1 do
  begin
    for i := 0 to 1 do col2[i] := V2[i,j];
    res2 := ZA2 * col2 - ev2[j] * col2;
    CmpRAbs(Format('rot2 |Av-lv| col %d', [j]), res2.Norm, 0.0, 1e-9);
    CmpRAbs(Format('rot2 |v|=1 col %d', [j]), col2.Norm, 1.0, 1e-9);
  end;

  A4.Assign([
    1,-2,5,0.5,
    2,1,-1,0.25,
    0,0,3,1,
    0,0,0,-2
  ]);
  BeginCategory('Eigenvectors general 4x4 (mixed spectrum)');
  ev4 := A4.Eigenvalues;
  V4 := A4.Eigenvectors(ev4);
  ZA4 := A4.ToComplex;
  for j := 0 to 3 do
  begin
    for i := 0 to 3 do col4[i] := V4[i,j];
    res4 := ZA4 * col4 - ev4[j] * col4;
    CmpRAbs(Format('gen4 |Av-lv| col %d', [j]), res4.Norm, 0.0, 1e-8);
    CmpRAbs(Format('gen4 |v|=1 col %d', [j]), col4.Norm, 1.0, 1e-9);
  end;
end;

procedure TestComplexEigenvalues;
var
  A2: T2RealMatrix;
  A3: T3RealMatrix;
  ev2: T2ComplexVector;
  ev3: T3ComplexVector;
  i, j: integer;
  tmp: TComplex;
begin
  Section('TRealMatrix - complex eigenvalues');

  A2.Assign([0,-1, 1,0]);
  ev2 := A2.Eigenvalues;
  if ev2[0].Im > ev2[1].Im then
  begin
    tmp := ev2[0]; ev2[0] := ev2[1]; ev2[1] := tmp;
  end;
  CheckCplxNear('rot90 eig[0] = -i', ev2[0], C(0,-1), EPS);
  CheckCplxNear('rot90 eig[1] = +i', ev2[1], C(0, 1), EPS);

  A3.Assign([1,-2,5, 2,1,-1, 0,0,3]);
  ev3 := A3.Eigenvalues;
  for i := 0 to 1 do
    for j := i+1 to 2 do
      if (ev3[i].Re > ev3[j].Re) or
         ((ev3[i].Re = ev3[j].Re) and (ev3[i].Im > ev3[j].Im)) then
      begin
        tmp := ev3[i]; ev3[i] := ev3[j]; ev3[j] := tmp;
      end;
  CheckCplxNear('block eig[0] = 1-2i', ev3[0], C(1,-2), EPS);
  CheckCplxNear('block eig[1] = 1+2i', ev3[1], C(1, 2), EPS);
  CheckCplxNear('block eig[2] = 3', ev3[2], C(3, 0), EPS);
end;

procedure TestExceptions;
var
  A2, R2: T2RealMatrix;
  A3: T3RealMatrix;
  Raised: boolean;
begin
  Section('TRealMatrix - exceptions');

  Raised := False;
  try
    A2.Assign([1,2,3,4,5]);
  except
    on EArgumentException do Raised := True;
  end;
  Check('Assign with 5 values raises EArgumentException', Raised);

  Raised := False;
  try
    A3.Assign([1,2,3,4]);
  except
    on EArgumentException do Raised := True;
  end;
  Check('3x3 Assign with 4 values raises EArgumentException', Raised);

  Raised := False;
  A2.Assign([1,2, 2,4]);
  try
    R2 := A2.Inverse;
  except
    on EZeroDivide do Raised := True;
  end;
  Check('singular Inverse raises EZeroDivide', Raised);
end;

procedure TestRealMatrices;
var
  M3, G3, Inv3, Prod3, Id3: T3RealMatrix;
  M4, H4, Inv4, Prod4, Id4: T4RealMatrix;
  S5, D5: T5RealMatrix;
  ev: TArrayOfDouble;
  i, j: integer;

  procedure SortAsc(var A: TArrayOfDouble);
  var p, q: integer; t: double;
  begin
    for p := 0 to High(A)-1 do
      for q := p+1 to High(A) do
        if A[p] > A[q] then begin t:=A[p]; A[p]:=A[q]; A[q]:=t; end;
  end;

begin
  // M3 = tridiagonal SPD [[2,-1,0],[-1,2,-1],[0,-1,2]]
  M3.Assign([2,-1,0, -1,2,-1, 0,-1,2]);
  // M4 SPD-ish
  M4.Assign([4,1,2,0.5, 1,3,0,1, 2,0,5,1, 0.5,1,1,4]);
  // G3 general non-symmetric
  G3.Assign([3,2,-1, 2,-2,4, -1,0.5,-1]);
  // H4 Hilbert 4x4 (ill-conditioned)
  H4.Assign([
    1, 1/2, 1/3, 1/4,
    1/2, 1/3, 1/4, 1/5,
    1/3, 1/4, 1/5, 1/6,
    1/4, 1/5, 1/6, 1/7]);

  // -- Determinant --
  BeginCategory('Real determinant');
  CmpR('det(M3)', M3.Determinant, 4.0);
  CmpR('det(M4)', M4.Determinant, 148.25000000000003);
  CmpR('det(G3)', G3.Determinant, -3.0000000000000036);
  CmpR('det(H4)', H4.Determinant, 1.6534391534392967e-07);

  // -- Trace --
  BeginCategory('Real trace');
  CmpR('trace(M3)', M3.Trace, 6.0);
  CmpR('trace(M4)', M4.Trace, 16.0);
  CmpR('trace(G3)', G3.Trace, 0.0);
  CmpR('trace(H4)', H4.Trace, 1.676190476190476);

  // -- Frobenius norm --
  BeginCategory('Real Frobenius norm');
  CmpR('norm(M3)', M3.Norm, 4.0);
  CmpR('norm(M4)', M4.Norm, 8.972179222463181);
  CmpR('norm(G3)', G3.Norm, 6.34428877022476);
  CmpR('norm(H4)', H4.Norm, 1.5097340998183073);

  // -- Inverse (M3, well-conditioned) --
  BeginCategory('Real inverse (M3)');
  Inv3 := M3.Inverse;
  CmpR('inv(M3)[0,0]', Inv3[0,0], 0.75);
  CmpR('inv(M3)[0,1]', Inv3[0,1], 0.5);
  CmpR('inv(M3)[0,2]', Inv3[0,2], 0.24999999999999994);
  CmpR('inv(M3)[1,1]', Inv3[1,1], 1.0);
  CmpR('inv(M3)[2,2]', Inv3[2,2], 0.7499999999999999);
  // Verify M3 * inv = I
  Prod3 := M3 * Inv3;
  Id3   := M3.Identity;
  for i := 0 to 2 do
    for j := 0 to 2 do
      CmpR(Format('M3*inv-I[%d,%d]',[i,j]), Prod3[i,j], Id3[i,j]);

  // -- Inv3erse (M4) --
  BeginCategory('Real inverse (M4)');
  Inv4 := M4.Inverse;
  CmpR('inv(M4)[0,0]', Inv4[0,0],  0.35075885328836426);
  CmpR('inv(M4)[0,1]', Inv4[0,1], -0.12478920741989882);
  CmpR('inv(M4)[1,1]', Inv4[1,1],  0.40978077571669475);
  CmpR('inv(M4)[2,2]', Inv4[2,2],  0.2715008431703204);
  CmpR('inv(M4)[3,3]', Inv4[3,3],  0.2900505902192243);
  Prod4 := M4 * Inv4;
  Id4   := M4.Identity;
  for i := 0 to 3 do
    for j := 0 to 3 do
      CmpR(Format('M4*inv-I[%d,%d]',[i,j]), Prod4[i,j], Id4[i,j]);

  // -- Inv4erse (H4, ill-conditioned - stress test) --
  BeginCategory('Real inverse (Hilbert4, ill-cond)');
  Inv4 := H4.Inverse;
  CmpR('inv(H4)[0,0]', Inv4[0,0],  15.999999999999346);
  CmpR('inv(H4)[1,1]', Inv4[1,1],  1199.9999999999045);
  CmpR('inv(H4)[2,2]', Inv4[2,2],  6479.99999999942);
  CmpR('inv(H4)[3,3]', Inv4[3,3],  2799.999999999749);
  // Reconstruction error H4*inv ~= I (looser by nature of conditioning)
  Prod4 := H4 * Inv4;
  Id4   := H4.Identity;
  for i := 0 to 3 do
    for j := 0 to 3 do
      CmpR(Format('H4*inv-I[%d,%d]',[i,j]), Prod4[i,j], Id4[i,j]);

  // -- Eigenvalues (symmetric matrices) --
  BeginCategory('Real eigenvalues (symmetric)');
  ev := ExtractRealEigenvalues(M3.Eigenvalues); SortAsc(ev);
  CmpR('eig(M3)[0]', ev[0], 0.585786437626905);
  CmpR('eig(M3)[1]', ev[1], 1.9999999999999998);
  CmpR('eig(M3)[2]', ev[2], 3.414213562373095);

  ev := ExtractRealEigenvalues(M4.Eigenvalues); SortAsc(ev);
  CmpR('eig(M4)[0]', ev[0], 1.6144288690811686);
  CmpR('eig(M4)[1]', ev[1], 3.166099049437209);
  CmpR('eig(M4)[2]', ev[2], 4.039519599886666);
  CmpR('eig(M4)[3]', ev[3], 7.179952481594955);

  ev := ExtractRealEigenvalues(H4.Eigenvalues); SortAsc(ev);
  CmpR('eig(H4)[0]', ev[0], 9.670230402260876e-05);
  CmpR('eig(H4)[1]', ev[1], 0.006738273605760613);
  CmpR('eig(H4)[2]', ev[2], 0.16914122022145006);
  CmpR('eig(H4)[3]', ev[3], 1.5002142800592426);

  // -- Sum of eigenvalues = trace (consistency) --
  BeginCategory('Real eig-trace consistency');
  ev := ExtractRealEigenvalues(M4.Eigenvalues);
  CmpR('sum eig(M4) = trace', ev[0]+ev[1]+ev[2]+ev[3], 16.0);
  ev := ExtractRealEigenvalues(M3.Eigenvalues);
  CmpR('sum eig(M3) = trace', ev[0]+ev[1]+ev[2], 6.0);

  // -- Rank --
  BeginCategory('Real rank');
  Track(IfThen(M3.Rank = 3, 0.0, 1.0));
  Track(IfThen(M4.Rank = 4, 0.0, 1.0));
  Track(IfThen(H4.Rank = 4, 0.0, 1.0));

  // -- Eigenvalues (5x5 symmetric - QR convergence stress) --
  BeginCategory('Real eigenvalues (5x5 symmetric)');
  S5.Assign([
    -0.14235884270194815, 0.9940954392257044, 0.058106254249750605, -0.05259808280494438, -0.443119050750149,
    0.9940954392257044, 0.7551804850779186, 0.755522308012678, 0.384873968241723, -1.053041066678274,
    0.058106254249750605, 0.755522308012678, 0.02350010848492948, -0.06194019222457631, -0.29265139847469945,
    -0.05259808280494438, 0.384873968241723, -0.06194019222457631, -0.5015653039496065, 0.20171369107721246,
    -0.443119050750149, -1.053041066678274, -0.29265139847469945, 0.20171369107721246, -0.3734862894349501]);
  ev := ExtractRealEigenvalues(S5.Eigenvalues); SortAsc(ev);
  CmpR('eig(S5)[0]', ev[0], -1.311948101249088);
  CmpR('eig(S5)[1]', ev[1], -0.7562480655457912);
  CmpR('eig(S5)[2]', ev[2], -0.30347353323147597);
  CmpR('eig(S5)[3]', ev[3], -0.07801795708958013);
  CmpR('eig(S5)[4]', ev[4],  2.210957814592279);

  // -- Eigenvalues (degenerate spectrum 2,2,2,5,5) --
  BeginCategory('Real eigenvalues (degenerate)');
  D5.Assign([
    3.9681451856646284, -0.6470635423949582, -1.0683766715308218, 0.6550202348522072, -0.20412897125396062,
    -0.6470635423949582, 2.39008949997781, 0.07219196833991376, -0.2941787990675794, 0.712498847669345,
    -1.0683766715308218, 0.07219196833991376, 3.019026569770013, -0.23153568981902073, -0.904663136857451,
    0.6550202348522072, -0.2941787990675794, -0.23153568981902073, 2.253034895825433, -0.35479089535141245,
    -0.20412897125396062, 0.712498847669345, -0.904663136857451, -0.35479089535141245, 4.369703848762114]);
  ev := ExtractRealEigenvalues(D5.Eigenvalues); SortAsc(ev);
  CmpR('eig(D5)[0]=2', ev[0], 2.0);
  CmpR('eig(D5)[1]=2', ev[1], 2.0);
  CmpR('eig(D5)[2]=2', ev[2], 2.0);
  CmpR('eig(D5)[3]=5', ev[3], 5.0);
  CmpR('eig(D5)[4]=5', ev[4], 5.0);
end;

procedure TestLargeRealInverse;
var
  M5, Inv5, Prod5, Id5: T5RealMatrix;
  M6, Inv6, Prod6, Id6: T6RealMatrix;
  M7, Inv7, Prod7, Id7: T7RealMatrix;
  M8, Inv8, Prod8, Id8: T8RealMatrix;
  i, j: integer;
begin
  // --- general real matrix, order 5 #1, cond=1.63 ---
  M5.Assign([
    4.464600132057632, 0.6562114398235255, 0.05593869930914064, 0.8112058585830866, -0.664874906936775, 0.4715117142980525, 5.810568567370548, -0.2887185821356433,
    0.6295604388561127, 0.3315677508053454, -0.5141257122993563, 0.5687109426080146, 5.55476944777156, -0.012793148535181098, 0.17183074116486186, 0.2577061034992283,
    0.02534851804401428, -0.07966838246171459, 5.565743799499041, -0.3622834652402058, -0.335999068783676, 0.22021516675755848, 0.3336940833724975, -0.4748997191142621,
    4.868771577594321
  ]);
  BeginCategory('Real det/trace/norm order 5 #1');
  CmpRRel('det',   M5.Determinant, 3776.702013078322, 1e-9);
  CmpRRel('trace', M5.Trace,       26.264453524293103,  1e-12);
  CmpRRel('norm',  M5.Norm,        11.954056087316632, 1e-12);
  BeginCategory('Real inverse order 5 #1 (vs numpy, element-wise)');
  Inv5 := M5.Inverse;
  CmpRRel('inv[0,0]', Inv5[0,0], 0.23005976198307748, 1e-8);
  CmpRRel('inv[0,1]', Inv5[0,1], -0.026463459628932918, 1e-8);
  CmpRRel('inv[0,2]', Inv5[0,2], -0.005975720743830631, 1e-8);
  CmpRRel('inv[0,3]', Inv5[0,3], -0.027876089344033263, 1e-8);
  CmpRRel('inv[0,4]', Inv5[0,4], 0.03135558045239509, 1e-8);
  CmpRRel('inv[1,0]', Inv5[1,0], -0.017345389307521247, 1e-8);
  CmpRRel('inv[1,1]', Inv5[1,1], 0.1737743713929499, 1e-8);
  CmpRRel('inv[1,2]', Inv5[1,2], 0.00989880980313908, 1e-8);
  CmpRRel('inv[1,3]', Inv5[1,3], -0.018464282963598824, 1e-8);
  CmpRRel('inv[1,4]', Inv5[1,4], -0.01592613548953108, 1e-8);
  CmpRRel('inv[2,0]', Inv5[2,0], 0.022608408461884655, 1e-8);
  CmpRRel('inv[2,1]', Inv5[2,1], -0.019983246922791634, 1e-8);
  CmpRRel('inv[2,2]', Inv5[2,2], 0.17886335049490182, 1e-8);
  CmpRRel('inv[2,3]', Inv5[2,3], -0.0007877400887874118, 1e-8);
  CmpRRel('inv[2,4]', Inv5[2,4], -0.0019228759112186117, 1e-8);
  CmpRRel('inv[3,0]', Inv5[3,0], -0.009325216510331885, 1e-8);
  CmpRRel('inv[3,1]', Inv5[3,1], -0.00039600932119755326, 1e-8);
  CmpRRel('inv[3,2]', Inv5[3,2], 0.0019503125611993633, 1e-8);
  CmpRRel('inv[3,3]', Inv5[3,3], 0.18212300667800616, 1e-8);
  CmpRRel('inv[3,4]', Inv5[3,4], 0.012236399021264265, 1e-8);
  CmpRRel('inv[4,0]', Inv5[4,0], 0.014202093412701957, 1e-8);
  CmpRRel('inv[4,1]', Inv5[4,1], -0.008355130810511365, 1e-8);
  CmpRRel('inv[4,2]', Inv5[4,2], -0.012928752675776969, 1e-8);
  CmpRRel('inv[4,3]', Inv5[4,3], 0.016729641700238024, 1e-8);
  CmpRRel('inv[4,4]', Inv5[4,4], 0.20960016729575948, 1e-8);
  BeginCategory('Real inverse order 5 #1 (reconstruction A*inv=I)');
  Prod5 := M5 * Inv5;
  Id5   := M5.Identity;
  for i := 0 to 4 do
    for j := 0 to 4 do
      CmpRAbs('M5*inv-I', Prod5[i,j], Id5[i,j], 1e-9);
  // --- general real matrix, order 5 #2, cond=1.88 ---
  M5.Assign([
    4.337154366099732, -0.6287805869624594, 0.917330432390359, 0.7127002817895094, 0.8843207336202106, 0.16954441073997573, 4.8874628592336995, -0.73470257216417,
    0.13577726480032348, -0.4090937187688306, -0.21090886786373808, 0.7394991587410129, 5.727251959888948, -0.9949531306398611, 0.8241307977342749, 0.5788244482089171,
    0.11209706807903785, -0.10565914307134316, 4.303839717458031, 0.14196753671343787, 0.23208035161269103, -0.38769686405650194, 0.048953675363139215, -0.6213240077760216,
    4.230472661223737
  ]);
  BeginCategory('Real det/trace/norm order 5 #2');
  CmpRRel('det',   M5.Determinant, 2181.1137015812815, 1e-9);
  CmpRRel('trace', M5.Trace,       23.486181563904147,  1e-12);
  CmpRRel('norm',  M5.Norm,        10.882678893357816, 1e-12);
  BeginCategory('Real inverse order 5 #2 (vs numpy, element-wise)');
  Inv5 := M5.Inverse;
  CmpRRel('inv[0,0]', Inv5[0,0], 0.23675473826061083, 1e-8);
  CmpRRel('inv[0,1]', Inv5[0,1], 0.03387616692990263, 1e-8);
  CmpRRel('inv[0,2]', Inv5[0,2], -0.03424211406500225, 1e-8);
  CmpRRel('inv[0,3]', Inv5[0,3], -0.053639341841824444, 1e-8);
  CmpRRel('inv[0,4]', Inv5[0,4], -0.03774367156902895, 1e-8);
  CmpRRel('inv[1,0]', Inv5[1,0], -0.0078359575336906, 1e-8);
  CmpRRel('inv[1,1]', Inv5[1,1], 0.2006872453526425, 1e-8);
  CmpRRel('inv[1,2]', Inv5[1,2], 0.02692932174820268, 1e-8);
  CmpRRel('inv[1,3]', Inv5[1,3], 0.0034558472137165134, 1e-8);
  CmpRRel('inv[1,4]', Inv5[1,4], 0.01568276053471179, 1e-8);
  CmpRRel('inv[2,0]', Inv5[2,0], 0.00700531999474801, 1e-8);
  CmpRRel('inv[2,1]', Inv5[2,1], -0.028769422284713703, 1e-8);
  CmpRRel('inv[2,2]', Inv5[2,2], 0.17074206186091773, 1e-8);
  CmpRRel('inv[2,3]', Inv5[2,3], 0.033641492977694545, 1e-8);
  CmpRRel('inv[2,4]', Inv5[2,4], -0.03863732123886156, 1e-8);
  CmpRRel('inv[3,0]', Inv5[3,0], -0.03086082477710861, 1e-8);
  CmpRRel('inv[3,1]', Inv5[3,1], -0.010992467429426278, 1e-8);
  CmpRRel('inv[3,2]', Inv5[3,2], 0.007978694385871725, 1e-8);
  CmpRRel('inv[3,3]', Inv5[3,3], 0.23904774203708612, 1e-8);
  CmpRRel('inv[3,4]', Inv5[3,4], -0.004188323729771434, 1e-8);
  CmpRRel('inv[4,0]', Inv5[4,0], -0.018319845739504383, 1e-8);
  CmpRRel('inv[4,1]', Inv5[4,1], 0.015251796466786179, 1e-8);
  CmpRRel('inv[4,2]', Inv5[4,2], 0.003542450116261187, 1e-8);
  CmpRRel('inv[4,3]', Inv5[4,3], 0.0379786604748307, 1e-8);
  CmpRRel('inv[4,4]', Inv5[4,4], 0.23971998773058623, 1e-8);
  BeginCategory('Real inverse order 5 #2 (reconstruction A*inv=I)');
  Prod5 := M5 * Inv5;
  Id5   := M5.Identity;
  for i := 0 to 4 do
    for j := 0 to 4 do
      CmpRAbs('M5*inv-I', Prod5[i,j], Id5[i,j], 1e-9);
  // --- general real matrix, order 6 #1, cond=1.69 ---
  M6.Assign([
    6.696584559225658, 0.9764795662889532, 0.9173366500221565, -0.25408864396042397, -0.9237272317302081, 0.9251616408330574, 0.6483161770093875, 5.750713228492364,
    -0.6386514027296839, -0.3813109412283988, -0.2256207359992788, 0.7626090664741887, 0.11596190758196512, 0.5199661575524177, 5.756719270160521, 0.8510492250348294,
    0.9538742695287012, -0.907418381387584, 0.39859743161029315, 0.3571824226250191, 0.16319925082539233, 6.152524120501795, 0.8456291873972486, -0.04030843942427742,
    -0.42730692986596286, -0.9143601350785562, -0.6006966383089227, 0.9231343059130928, 6.9790458484595765, 0.6927937512902893, -0.5824819380131865, 0.7427489640272464,
    0.9858913283962738, 0.1019740401484539, -0.6151704390583215, 5.481450744565678
  ]);
  BeginCategory('Real det/trace/norm order 6 #1');
  CmpRRel('det',   M6.Determinant, 53634.391578387396, 1e-9);
  CmpRRel('trace', M6.Trace,       36.817037771405595,  1e-12);
  CmpRRel('norm',  M6.Norm,        15.542558587874089, 1e-12);
  BeginCategory('Real inverse order 6 #1 (vs numpy, element-wise)');
  Inv6 := M6.Inverse;
  CmpRRel('inv[0,0]', Inv6[0,0], 0.1497517205382073, 1e-8);
  CmpRRel('inv[0,1]', Inv6[0,1], -0.017396114130827704, 1e-8);
  CmpRRel('inv[0,2]', Inv6[0,2], -0.019138117138546913, 1e-8);
  CmpRRel('inv[0,3]', Inv6[0,3], 0.005414846615854621, 1e-8);
  CmpRRel('inv[0,4]', Inv6[0,4], 0.018719127215731476, 1e-8);
  CmpRRel('inv[0,5]', Inv6[0,5], -0.028349177982069252, 1e-8);
  CmpRRel('inv[1,0]', Inv6[1,0], -0.019551723625046848, 1e-8);
  CmpRRel('inv[1,1]', Inv6[1,1], 0.17622231636261748, 1e-8);
  CmpRRel('inv[1,2]', Inv6[1,2], 0.025036030440204034, 1e-8);
  CmpRRel('inv[1,3]', Inv6[1,3], 0.00732828443380395, 1e-8);
  CmpRRel('inv[1,4]', Inv6[1,4], -0.002670990243052744, 1e-8);
  CmpRRel('inv[1,5]', Inv6[1,5], -0.016681029246874805, 1e-8);
  CmpRRel('inv[2,0]', Inv6[2,0], 0.00211581321666465, 1e-8);
  CmpRRel('inv[2,1]', Inv6[2,1], -0.020743711794403256, 1e-8);
  CmpRRel('inv[2,2]', Inv6[2,2], 0.16442991035529772, 1e-8);
  CmpRRel('inv[2,3]', Inv6[2,3], -0.021857123126151682, 1e-8);
  CmpRRel('inv[2,4]', Inv6[2,4], -0.01741389086507625, 1e-8);
  CmpRRel('inv[2,5]', Inv6[2,5], 0.03178935886490152, 1e-8);
  CmpRRel('inv[3,0]', Inv6[3,0], -0.009341256134769814, 1e-8);
  CmpRRel('inv[3,1]', Inv6[3,1], -0.01193776268292025, 1e-8);
  CmpRRel('inv[3,2]', Inv6[3,2], -0.007605963977002201, 1e-8);
  CmpRRel('inv[3,3]', Inv6[3,3], 0.16538455556640863, 1e-8);
  CmpRRel('inv[3,4]', Inv6[3,4], -0.020116192654696847, 1e-8);
  CmpRRel('inv[3,5]', Inv6[3,5], 0.005736983467279341, 1e-8);
  CmpRRel('inv[4,0]', Inv6[4,0], 0.00613451986526241, 1e-8);
  CmpRRel('inv[4,1]', Inv6[4,1], 0.023713536244022698, 1e-8);
  CmpRRel('inv[4,2]', Inv6[4,2], 0.020499098676014002, 1e-8);
  CmpRRel('inv[4,3]', Inv6[4,3], -0.022260786452509642, 1e-8);
  CmpRRel('inv[4,4]', Inv6[4,4], 0.143068897050073, 1e-8);
  CmpRRel('inv[4,5]', Inv6[4,5], -0.019187047664059154, 1e-8);
  CmpRRel('inv[5,0]', Inv6[5,0], 0.019044241887073567, 1e-8);
  CmpRRel('inv[5,1]', Inv6[5,1], -0.01911275246296401, 1e-8);
  CmpRRel('inv[5,2]', Inv6[5,2], -0.03255836344967904, 1e-8);
  CmpRRel('inv[5,3]', Inv6[5,3], -0.002061386077934647, 1e-8);
  CmpRRel('inv[5,4]', Inv6[5,4], 0.021913672854285877, 1e-8);
  CmpRRel('inv[5,5]', Inv6[5,5], 0.17370360444186608, 1e-8);
  BeginCategory('Real inverse order 6 #1 (reconstruction A*inv=I)');
  Prod6 := M6 * Inv6;
  Id6   := M6.Identity;
  for i := 0 to 5 do
    for j := 0 to 5 do
      CmpRAbs('M6*inv-I', Prod6[i,j], Id6[i,j], 1e-9);
  // --- general real matrix, order 6 #2, cond=1.81 ---
  M6.Assign([
    6.3938768112421425, -0.1956233735108035, 0.4870507897637639, 0.648591401146299, 0.5348906261853137, -0.5767838074953968, 0.020203973647338058, 5.2619053338390325,
    -0.628862757799207, -0.8944805978443657, -0.748202160278761, 0.8708265516021823, 0.4078578056113058, -0.7654141481155421, 5.301351800072786, 0.4374342039612773,
    -0.593761458539815, -0.7040701933534241, 0.6362237219939635, 0.05125967025817446, -0.5649782082248371, 5.6717474303608615, -0.05813109913690728, 0.32613032879747217,
    0.41871302466786564, -0.8419703479182428, -0.12569610509793572, 0.5985387624615937, 6.091428380744137, 0.2580141184651945, 0.4016924323553632, -0.5313075604738464,
    -0.5335162253624728, 0.978705022121751, -0.17298731468830297, 6.223271162468301
  ]);
  BeginCategory('Real det/trace/norm order 6 #2');
  CmpRRel('det',   M6.Determinant, 36438.43446637963, 1e-9);
  CmpRRel('trace', M6.Trace,       34.943580918727264,  1e-12);
  CmpRRel('norm',  M6.Norm,        14.634723188877622, 1e-12);
  BeginCategory('Real inverse order 6 #2 (vs numpy, element-wise)');
  Inv6 := M6.Inverse;
  CmpRRel('inv[0,0]', Inv6[0,0], 0.15916986123386406, 1e-8);
  CmpRRel('inv[0,1]', Inv6[0,1], 0.0029516001657609874, 1e-8);
  CmpRRel('inv[0,2]', Inv6[0,2], -0.01505966063012312, 1e-8);
  CmpRRel('inv[0,3]', Inv6[0,3], -0.017452486622848568, 1e-8);
  CmpRRel('inv[0,4]', Inv6[0,4], -0.014846436419306469, 1e-8);
  CmpRRel('inv[0,5]', Inv6[0,5], 0.014165473709808848, 1e-8);
  CmpRRel('inv[1,0]', Inv6[1,0], -0.005300323194180388, 1e-8);
  CmpRRel('inv[1,1]', Inv6[1,1], 0.19455757934849954, 1e-8);
  CmpRRel('inv[1,2]', Inv6[1,2], 0.024750648864384706, 1e-8);
  CmpRRel('inv[1,3]', Inv6[1,3], 0.031377421307121796, 1e-8);
  CmpRRel('inv[1,4]', Inv6[1,4], 0.026289464793769736, 1e-8);
  CmpRRel('inv[1,5]', Inv6[1,5], -0.027649933562688227, 1e-8);
  CmpRRel('inv[2,0]', Inv6[2,0], -0.013778920929832638, 1e-8);
  CmpRRel('inv[2,1]', Inv6[2,1], 0.0334526510484071, 1e-8);
  CmpRRel('inv[2,2]', Inv6[2,2], 0.19459754050895597, 1e-8);
  CmpRRel('inv[2,3]', Inv6[2,3], -0.013470224388519888, 1e-8);
  CmpRRel('inv[2,4]', Inv6[2,4], 0.024605798736328236, 1e-8);
  CmpRRel('inv[2,5]', Inv6[2,5], 0.01574345957642274, 1e-8);
  CmpRRel('inv[3,0]', Inv6[3,0], -0.018748371082130302, 1e-8);
  CmpRRel('inv[3,1]', Inv6[3,1], 0.00036635022326943553, 1e-8);
  CmpRRel('inv[3,2]', Inv6[3,2], 0.019943872881144017, 1e-8);
  CmpRRel('inv[3,3]', Inv6[3,3], 0.1780056992039738, 1e-8);
  CmpRRel('inv[3,4]', Inv6[3,4], 0.005076439195860488, 1e-8);
  CmpRRel('inv[3,5]', Inv6[3,5], -0.009071394551597849, 1e-8);
  CmpRRel('inv[4,0]', Inv6[4,0], -0.009724843915382886, 1e-8);
  CmpRRel('inv[4,1]', Inv6[4,1], 0.026497855499795605, 1e-8);
  CmpRRel('inv[4,2]', Inv6[4,2], 0.005800812960528382, 1e-8);
  CmpRRel('inv[4,3]', Inv6[4,3], -0.011145347227513345, 1e-8);
  CmpRRel('inv[4,4]', Inv6[4,4], 0.16843883230980733, 1e-8);
  CmpRRel('inv[4,5]', Inv6[4,5], -0.01035223253555369, 1e-8);
  CmpRRel('inv[5,0]', Inv6[5,0], -0.009229528424403777, 1e-8);
  CmpRRel('inv[5,1]', Inv6[5,1], 0.019966517662777364, 1e-8);
  CmpRRel('inv[5,2]', Inv6[5,2], 0.01679258377690052, 1e-8);
  CmpRRel('inv[5,3]', Inv6[5,3], -0.025653400213044728, 1e-8);
  CmpRRel('inv[5,4]', Inv6[5,4], 0.009195892110055545, 1e-8);
  CmpRRel('inv[5,5]', Inv6[5,5], 0.15990079771684, 1e-8);
  BeginCategory('Real inverse order 6 #2 (reconstruction A*inv=I)');
  Prod6 := M6 * Inv6;
  Id6   := M6.Identity;
  for i := 0 to 5 do
    for j := 0 to 5 do
      CmpRAbs('M6*inv-I', Prod6[i,j], Id6[i,j], 1e-9);
  // --- general real matrix, order 7 #1, cond=1.71 ---
  M7.Assign([
    7.761796611320179, 0.7262296369747705, 0.1682250352414143, 0.62747740287845, -0.1192738838009264, 0.16540932592961943, -0.8318083252134258, -0.600425358283007,
    7.500453761824895, -0.3173329617152114, 0.6304382883509747, -0.6992450821326683, -0.5535728918641762, -0.27698968603457974, -0.18442383126925677, -0.9006732140736595,
    6.425129622199651, -0.7029621652321576, 0.016824203697030526, 0.7128751910877844, 0.6254878689899319, 0.35943323759673307, 0.12064518590891504, -0.6261672641023452,
    6.082945972745318, -0.4096334149354255, -0.3292972866207571, 0.967247747505791, -0.687972873802968, -0.7301908574999247, -0.05352265829764158, -0.44083005451889035,
    7.532323156334323, 0.448437741623388, -0.8696985879230672, -0.7295107012158475, 0.3352426053078088, -0.1135099250617786, 0.06846929812434199, -0.558919161625556,
    6.62354010945247, 0.4350231499035013, 0.9767270561100225, 0.8202591311707346, 0.2654206717085936, 0.20302470655037363, -0.3897930272001253, 0.1625218263012389,
    6.865176027991453
  ]);
  BeginCategory('Real det/trace/norm order 7 #1');
  CmpRRel('det',   M7.Determinant, 774830.8628913161, 1e-9);
  CmpRRel('trace', M7.Trace,       48.791365261868286,  1e-12);
  CmpRRel('norm',  M7.Norm,        18.845870547973146, 1e-12);
  BeginCategory('Real inverse order 7 #1 (vs numpy, element-wise)');
  Inv7 := M7.Inverse;
  CmpRRel('inv[0,0]', Inv7[0,0], 0.12558793884864022, 1e-8);
  CmpRRel('inv[0,1]', Inv7[0,1], -0.014311456932419848, 1e-8);
  CmpRRel('inv[0,2]', Inv7[0,2], -0.006024560595434665, 1e-8);
  CmpRRel('inv[0,3]', Inv7[0,3], -0.012654533156339116, 1e-8);
  CmpRRel('inv[0,4]', Inv7[0,4], 0.0005284567957436975, 1e-8);
  CmpRRel('inv[0,5]', Inv7[0,5], -0.0047743942194625475, 1e-8);
  CmpRRel('inv[0,6]', Inv7[0,6], 0.01734054524367794, 1e-8);
  CmpRRel('inv[1,0]', Inv7[1,0], 0.011788122949678103, 1e-8);
  CmpRRel('inv[1,1]', Inv7[1,1], 0.13282406911520092, 1e-8);
  CmpRRel('inv[1,2]', Inv7[1,2], 0.004764878231967872, 1e-8);
  CmpRRel('inv[1,3]', Inv7[1,3], -0.01390832268345498, 1e-8);
  CmpRRel('inv[1,4]', Inv7[1,4], 0.012867456329968788, 1e-8);
  CmpRRel('inv[1,5]', Inv7[1,5], 0.008500372127435669, 1e-8);
  CmpRRel('inv[1,6]', Inv7[1,6], 0.009404234639425175, 1e-8);
  CmpRRel('inv[2,0]', Inv7[2,0], 0.005110644571348844, 1e-8);
  CmpRRel('inv[2,1]', Inv7[2,1], 0.020544278041120315, 1e-8);
  CmpRRel('inv[2,2]', Inv7[2,2], 0.15845558151103564, 1e-8);
  CmpRRel('inv[2,3]', Inv7[2,3], 0.016345773328635113, 1e-8);
  CmpRRel('inv[2,4]', Inv7[2,4], 0.0007187263629022805, 1e-8);
  CmpRRel('inv[2,5]', Inv7[2,5], -0.014350130266449976, 1e-8);
  CmpRRel('inv[2,6]', Inv7[2,6], -0.014291419774699946, 1e-8);
  CmpRRel('inv[3,0]', Inv7[3,0], -0.0026066708458189628, 1e-8);
  CmpRRel('inv[3,1]', Inv7[3,1], 0.002929601139855311, 1e-8);
  CmpRRel('inv[3,2]', Inv7[3,2], 0.01777986030352745, 1e-8);
  CmpRRel('inv[3,3]', Inv7[3,3], 0.16778415595664584, 1e-8);
  CmpRRel('inv[3,4]', Inv7[3,4], 0.008534277556401461, 1e-8);
  CmpRRel('inv[3,5]', Inv7[3,5], 0.006768764622207625, 1e-8);
  CmpRRel('inv[3,6]', Inv7[3,6], -0.024804758761023372, 1e-8);
  CmpRRel('inv[4,0]', Inv7[4,0], 0.009359886317154441, 1e-8);
  CmpRRel('inv[4,1]', Inv7[4,1], 0.010640846260977851, 1e-8);
  CmpRRel('inv[4,2]', Inv7[4,2], 0.0012176616793621931, 1e-8);
  CmpRRel('inv[4,3]', Inv7[4,3], 0.0073216618350250475, 1e-8);
  CmpRRel('inv[4,4]', Inv7[4,4], 0.13458214647111086, 1e-8);
  CmpRRel('inv[4,5]', Inv7[4,5], -0.008665304925964798, 1e-8);
  CmpRRel('inv[4,6]', Inv7[4,6], 0.018019210721574058, 1e-8);
  CmpRRel('inv[5,0]', Inv7[5,0], 0.015402838335158044, 1e-8);
  CmpRRel('inv[5,1]', Inv7[5,1], -0.006162098913713412, 1e-8);
  CmpRRel('inv[5,2]', Inv7[5,2], 0.0021465417554409148, 1e-8);
  CmpRRel('inv[5,3]', Inv7[5,3], -0.0014157816752753997, 1e-8);
  CmpRRel('inv[5,4]', Inv7[5,4], 0.010326073835715046, 1e-8);
  CmpRRel('inv[5,5]', Inv7[5,5], 0.14923662890631595, 1e-8);
  CmpRRel('inv[5,6]', Inv7[5,6], -0.006526951275197753, 1e-8);
  CmpRRel('inv[6,0]', Inv7[6,0], -0.019229890664304534, 1e-8);
  CmpRRel('inv[6,1]', Inv7[6,1], -0.013964714405819114, 1e-8);
  CmpRRel('inv[6,2]', Inv7[6,2], -0.0063458598908185705, 1e-8);
  CmpRRel('inv[6,3]', Inv7[6,3], -0.0016824555357878833, 1e-8);
  CmpRRel('inv[6,4]', Inv7[6,4], 0.005504116590337264, 1e-8);
  CmpRRel('inv[6,5]', Inv7[6,5], -0.0040066733743381565, 1e-8);
  CmpRRel('inv[6,6]', Inv7[6,6], 0.1445356766896434, 1e-8);
  BeginCategory('Real inverse order 7 #1 (reconstruction A*inv=I)');
  Prod7 := M7 * Inv7;
  Id7   := M7.Identity;
  for i := 0 to 6 do
    for j := 0 to 6 do
      CmpRAbs('M7*inv-I', Prod7[i,j], Id7[i,j], 1e-9);
  // --- general real matrix, order 7 #2, cond=1.49 ---
  M7.Assign([
    7.973042603552368, 0.31474999730408015, -0.013139253082802282, -0.3868546286293073, -0.42944755064894014, -0.08388653307643157, 0.17219901381645397, 0.8568714551682437,
    6.821382808643177, 0.709846860710428, -0.5667770214823447, 0.14243752785674801, -0.3290176490385808, -0.3207761578467474, 0.07263391084515036, -0.3539358679417801,
    7.390428477042728, 0.9016149451909361, -0.758500229690255, -0.06078425625812667, -0.3208555347624493, -0.02708838605907249, -0.13686331614302905, -0.5934643752423716,
    7.648524469045494, 0.07412892501299306, -0.5374272996868992, 0.7047254671735022, -0.5337150554792236, -0.7708064603167872, -0.27838679526691057, -0.4096690821060853,
    7.408359118963802, 0.9857643709312314, -0.9043701409884866, 0.13912779639411776, 0.4746936366491148, -0.7403224965578745, -0.21981906317971367, -0.1852421093556753,
    7.906811270814808, -0.07171208363706238, -0.9769218907985864, 0.6937979883247165, -0.4470125566952363, -0.40640865147634053, -0.7218196744092427, -0.7079541461278169,
    7.156789617907356
  ]);
  BeginCategory('Real det/trace/norm order 7 #2');
  CmpRRel('det',   M7.Determinant, 1291844.8291557697, 1e-9);
  CmpRRel('trace', M7.Trace,       52.30533836596973,  1e-12);
  CmpRRel('norm',  M7.Norm,        20.08746851037215, 1e-12);
  BeginCategory('Real inverse order 7 #2 (vs numpy, element-wise)');
  Inv7 := M7.Inverse;
  CmpRRel('inv[0,0]', Inv7[0,0], 0.12604353638079635, 1e-8);
  CmpRRel('inv[0,1]', Inv7[0,1], -0.0045500997037116785, 1e-8);
  CmpRRel('inv[0,2]', Inv7[0,2], 0.0012930920468615006, 1e-8);
  CmpRRel('inv[0,3]', Inv7[0,3], 0.0061306295829962, 1e-8);
  CmpRRel('inv[0,4]', Inv7[0,4], 0.007196015524647737, 1e-8);
  CmpRRel('inv[0,5]', Inv7[0,5], 0.00042053384876843315, 1e-8);
  CmpRRel('inv[0,6]', Inv7[0,6], -0.0028688327285393824, 1e-8);
  CmpRRel('inv[1,0]', Inv7[1,0], -0.015325422254032906, 1e-8);
  CmpRRel('inv[1,1]', Inv7[1,1], 0.14540485514907878, 1e-8);
  CmpRRel('inv[1,2]', Inv7[1,2], -0.01218011861691272, 1e-8);
  CmpRRel('inv[1,3]', Inv7[1,3], 0.011667418154089605, 1e-8);
  CmpRRel('inv[1,4]', Inv7[1,4], -0.00439986260354769, 1e-8);
  CmpRRel('inv[1,5]', Inv7[1,5], 0.0075577151090794, 1e-8);
  CmpRRel('inv[1,6]', Inv7[1,6], 0.004710760706776999, 1e-8);
  CmpRRel('inv[2,0]', Inv7[2,0], 9.889681648059321e-05, 1e-8);
  CmpRRel('inv[2,1]', Inv7[2,1], 0.007420807839708387, 1e-8);
  CmpRRel('inv[2,2]', Inv7[2,2], 0.13454700668851213, 1e-8);
  CmpRRel('inv[2,3]', Inv7[2,3], -0.01402521040697124, 1e-8);
  CmpRRel('inv[2,4]', Inv7[2,4], 0.014699206191221285, 1e-8);
  CmpRRel('inv[2,5]', Inv7[2,5], -0.0005825952640904979, 1e-8);
  CmpRRel('inv[2,6]', Inv7[2,6], 0.009594973549887508, 1e-8);
  CmpRRel('inv[3,0]', Inv7[3,0], -0.0017782794221301561, 1e-8);
  CmpRRel('inv[3,1]', Inv7[3,1], 0.003710375667997249, 1e-8);
  CmpRRel('inv[3,2]', Inv7[3,2], 0.01004035725512876, 1e-8);
  CmpRRel('inv[3,3]', Inv7[3,3], 0.1292552707711942, 1e-8);
  CmpRRel('inv[3,4]', Inv7[3,4], -0.0014230941104862662, 1e-8);
  CmpRRel('inv[3,5]', Inv7[3,5], 0.008086214167545243, 1e-8);
  CmpRRel('inv[3,6]', Inv7[3,6], -0.012167282828267597, 1e-8);
  CmpRRel('inv[4,0]', Inv7[4,0], 0.009895679427131208, 1e-8);
  CmpRRel('inv[4,1]', Inv7[4,1], 0.014674294145532113, 1e-8);
  CmpRRel('inv[4,2]', Inv7[4,2], 0.004079936748736771, 1e-8);
  CmpRRel('inv[4,3]', Inv7[4,3], 0.008927913287626559, 1e-8);
  CmpRRel('inv[4,4]', Inv7[4,4], 0.1368920627342206, 1e-8);
  CmpRRel('inv[4,5]', Inv7[4,5], -0.01420156294818971, 1e-8);
  CmpRRel('inv[4,6]', Inv7[4,6], 0.016879516757694474, 1e-8);
  CmpRRel('inv[5,0]', Inv7[5,0], -0.0009292386909532889, 1e-8);
  CmpRRel('inv[5,1]', Inv7[5,1], -0.007628490513170248, 1e-8);
  CmpRRel('inv[5,2]', Inv7[5,2], 0.013790786530818779, 1e-8);
  CmpRRel('inv[5,3]', Inv7[5,3], 0.0017467770618131895, 1e-8);
  CmpRRel('inv[5,4]', Inv7[5,4], 0.0048313250701728025, 1e-8);
  CmpRRel('inv[5,5]', Inv7[5,5], 0.12594735753642092, 1e-8);
  CmpRRel('inv[5,6]', Inv7[5,6], 0.0019992318276332677, 1e-8);
  CmpRRel('inv[6,0]', Inv7[6,0], 0.01950231628437745, 1e-8);
  CmpRRel('inv[6,1]', Inv7[6,1], -0.013317422657049825, 1e-8);
  CmpRRel('inv[6,2]', Inv7[6,2], 0.012106923491354941, 1e-8);
  CmpRRel('inv[6,3]', Inv7[6,3], 0.0072429559091516625, 1e-8);
  CmpRRel('inv[6,4]', Inv7[6,4], 0.016530690432632934, 1e-8);
  CmpRRel('inv[6,5]', Inv7[6,5], 0.010773988298606376, 1e-8);
  CmpRRel('inv[6,6]', Inv7[6,6], 0.1406877424604634, 1e-8);
  BeginCategory('Real inverse order 7 #2 (reconstruction A*inv=I)');
  Prod7 := M7 * Inv7;
  Id7   := M7.Identity;
  for i := 0 to 6 do
    for j := 0 to 6 do
      CmpRAbs('M7*inv-I', Prod7[i,j], Id7[i,j], 1e-9);
  // --- general real matrix, order 8 #1, cond=1.57 ---
  M8.Assign([
    8.679366942343949, 0.27125239148089686, 0.08364802528462456, -0.49508273295225513, -0.36640601295898234, -0.49891537143664677, -0.36205756145592227, -0.23350963973559158,
    0.32876879798033465, 7.271618350255698, -0.6764952339453238, -0.8783722194737282, 0.6477055860238636, 0.17547842607649367, -0.9076836525543805, 0.8828335002581038,
    0.5087292481362922, -0.9926669303581988, 7.818784494920059, 0.29071564603595434, 0.4672484735427591, 0.5839632753220518, -0.5710301903742667, -0.20621378430110426,
    -0.5910953524649136, 0.06219704403498283, -0.12142689431968967, 7.237189400868017, 0.10069562986847447, 0.260897652905687, 0.7925989727070082, -0.02367369168933009,
    0.5581274790978581, 0.6631535001389695, 0.36786996163888164, -0.9088507071481366, 8.638869175585606, -0.06017142964281552, -0.5163224439990715, -0.6384663411431122,
    -0.2272341346210882, 0.19961894161951532, 0.28655061412932414, 0.5125282441956744, 0.38435440914202723, 7.985845993289648, 0.8503181341227628, 0.16108735600905222,
    0.6589484054940278, 0.7693624018379008, -0.8457279856427256, 0.38803925457657673, 0.14908034036739526, -0.3189070883701397, 8.39709082865754, -0.6787107750997863,
    -0.3168299962220962, -0.8274467286918143, -0.4307974551290292, 0.4608057309445821, 0.5420184554722265, 0.43567247955604915, 0.06264987271668399, 7.473693094104548
  ]);
  BeginCategory('Real det/trace/norm order 8 #1');
  CmpRRel('det',   M8.Determinant, 15271244.818469532, 1e-9);
  CmpRRel('trace', M8.Trace,       63.50245828002507,  1e-12);
  CmpRRel('norm',  M8.Norm,        22.846807848091704, 1e-12);
  BeginCategory('Real inverse order 8 #1 (vs numpy, element-wise)');
  Inv8 := M8.Inverse;
  CmpRRel('inv[0,0]', Inv8[0,0], 0.1157813756165526, 1e-8);
  CmpRRel('inv[0,1]', Inv8[0,1], -0.00499392523446439, 1e-8);
  CmpRRel('inv[0,2]', Inv8[0,2], -0.0014317071690996643, 1e-8);
  CmpRRel('inv[0,3]', Inv8[0,3], 0.006972787844662169, 1e-8);
  CmpRRel('inv[0,4]', Inv8[0,4], 0.004612286961192433, 1e-8);
  CmpRRel('inv[0,5]', Inv8[0,5], 0.0071258715123613805, 1e-8);
  CmpRRel('inv[0,6]', Inv8[0,6], 0.0032235818425940927, 1e-8);
  CmpRRel('inv[0,7]', Inv8[0,7], 0.00472316526048392, 1e-8);
  CmpRRel('inv[1,0]', Inv8[1,0], -0.006012502204795648, 1e-8);
  CmpRRel('inv[1,1]', Inv8[1,1], 0.13727210000779178, 1e-8);
  CmpRRel('inv[1,2]', Inv8[1,2], 0.01344712943183589, 1e-8);
  CmpRRel('inv[1,3]', Inv8[1,3], 0.01487795405589771, 1e-8);
  CmpRRel('inv[1,4]', Inv8[1,4], -0.010555131716523818, 1e-8);
  CmpRRel('inv[1,5]', Inv8[1,5], -0.0035370858280846474, 1e-8);
  CmpRRel('inv[1,6]', Inv8[1,6], 0.013914466834893063, 1e-8);
  CmpRRel('inv[1,7]', Inv8[1,7], -0.015546879261118206, 1e-8);
  CmpRRel('inv[2,0]', Inv8[2,0], -0.009255020183382243, 1e-8);
  CmpRRel('inv[2,1]', Inv8[2,1], 0.01840223705223403, 1e-8);
  CmpRRel('inv[2,2]', Inv8[2,2], 0.1316280164568888, 1e-8);
  CmpRRel('inv[2,3]', Inv8[2,3], -0.004780911677744455, 1e-8);
  CmpRRel('inv[2,4]', Inv8[2,4], -0.008687205051016916, 1e-8);
  CmpRRel('inv[2,5]', Inv8[2,5], -0.010150151362504588, 1e-8);
  CmpRRel('inv[2,6]', Inv8[2,6], 0.011473754629059788, 1e-8);
  CmpRRel('inv[2,7]', Inv8[2,7], 0.0016724015221133669, 1e-8);
  CmpRRel('inv[3,0]', Inv8[3,0], 0.010318924115456178, 1e-8);
  CmpRRel('inv[3,1]', Inv8[3,1], 6.831346962315176e-06, 1e-8);
  CmpRRel('inv[3,2]', Inv8[3,2], 0.0009178862995913018, 1e-8);
  CmpRRel('inv[3,3]', Inv8[3,3], 0.13973674901060787, 1e-8);
  CmpRRel('inv[3,4]', Inv8[3,4], -0.0008119148224826341, 1e-8);
  CmpRRel('inv[3,5]', Inv8[3,5], -0.004467900435683394, 1e-8);
  CmpRRel('inv[3,6]', Inv8[3,6], -0.012276894181391496, 1e-8);
  CmpRRel('inv[3,7]', Inv8[3,7], -0.0002984087684188951, 1e-8);
  CmpRRel('inv[4,0]', Inv8[4,0], -0.005825581767498803, 1e-8);
  CmpRRel('inv[4,1]', Inv8[4,1], -0.010290892338341951, 1e-8);
  CmpRRel('inv[4,2]', Inv8[4,2], -0.005024442697404023, 1e-8);
  CmpRRel('inv[4,3]', Inv8[4,3], 0.012121715875582221, 1e-8);
  CmpRRel('inv[4,4]', Inv8[4,4], 0.11562602070501653, 1e-8);
  CmpRRel('inv[4,5]', Inv8[4,5], 0.0002604642968010181, 1e-8);
  CmpRRel('inv[4,6]', Inv8[4,6], 0.004150415539298269, 1e-8);
  CmpRRel('inv[4,7]', Inv8[4,7], 0.011182419052631322, 1e-8);
  CmpRRel('inv[5,0]', Inv8[5,0], 0.004329702259985901, 1e-8);
  CmpRRel('inv[5,1]', Inv8[5,1], -0.0031361810159082327, 1e-8);
  CmpRRel('inv[5,2]', Inv8[5,2], -0.006464366530225684, 1e-8);
  CmpRRel('inv[5,3]', Inv8[5,3], -0.00834582411798762, 1e-8);
  CmpRRel('inv[5,4]', Inv8[5,4], -0.00427117352983086, 1e-8);
  CmpRRel('inv[5,5]', Inv8[5,5], 0.12597822263263922, 1e-8);
  CmpRRel('inv[5,6]', Inv8[5,6], -0.012794368245490415, 1e-8);
  CmpRRel('inv[5,7]', Inv8[5,7], -0.003941162638909367, 1e-8);
  CmpRRel('inv[6,0]', Inv8[6,0], -0.009407508515980921, 1e-8);
  CmpRRel('inv[6,1]', Inv8[6,1], -0.008890503708750731, 1e-8);
  CmpRRel('inv[6,2]', Inv8[6,2], 0.012714130198627218, 1e-8);
  CmpRRel('inv[6,3]', Inv8[6,3], -0.00996802168040223, 1e-8);
  CmpRRel('inv[6,4]', Inv8[6,4], -0.003217852384849295, 1e-8);
  CmpRRel('inv[6,5]', Inv8[6,5], 0.003099411529414516, 1e-8);
  CmpRRel('inv[6,6]', Inv8[6,6], 0.11892992935005356, 1e-8);
  CmpRRel('inv[6,7]', Inv8[6,7], 0.011534216967914521, 1e-8);
  CmpRRel('inv[7,0]', Inv8[7,0], 0.0033218582323119752, 1e-8);
  CmpRRel('inv[7,1]', Inv8[7,1], 0.017050312663005055, 1e-8);
  CmpRRel('inv[7,2]', Inv8[7,2], 0.009593432651274103, 1e-8);
  CmpRRel('inv[7,3]', Inv8[7,3], -0.007257569778235406, 1e-8);
  CmpRRel('inv[7,4]', Inv8[7,4], -0.00953341201294864, 1e-8);
  CmpRRel('inv[7,5]', Inv8[7,5], -0.007787780898751319, 1e-8);
  CmpRRel('inv[7,6]', Inv8[7,6], 0.0025433934898517543, 1e-8);
  CmpRRel('inv[7,7]', Inv8[7,7], 0.13171848908051614, 1e-8);
  BeginCategory('Real inverse order 8 #1 (reconstruction A*inv=I)');
  Prod8 := M8 * Inv8;
  Id8   := M8.Identity;
  for i := 0 to 7 do
    for j := 0 to 7 do
      CmpRAbs('M8*inv-I', Prod8[i,j], Id8[i,j], 1e-9);
  // --- general real matrix, order 8 #2, cond=1.71 ---
  M8.Assign([
    8.62520070811119, 0.9670855956168274, -0.14928643362077554, 0.4699234922157809, 0.8803754863392808, 0.9528370467488911, -0.6727788315143348, 0.37469264501442656,
    -0.15011099214581014, 7.369902282572006, 0.5791778267766876, 0.5632273996999897, 0.05660335590002785, -0.31878738517399197, -0.9596616502142654, -0.24301481464422414,
    -0.8136129096903901, -0.2931355700221534, 8.212837544743046, -0.7795415227822644, 0.039081031444150094, -0.013152306519579993, -0.9270280280862195, -0.5842440213809366,
    -0.9720999358779927, 0.4711131149367582, -0.10997708350546187, 7.581320762522733, -0.21615935974743228, -0.8614638071756302, 0.9663756880049845, 0.19381858768869265,
    0.35901776006966957, 0.8389575654863937, 0.3997006590707253, 0.262335132076676, 7.79771439409829, -0.4311862596452476, -0.7222035761711005, -0.7251474634899309,
    0.3066905059575764, 0.6943419343665296, -0.7897381862330195, 0.9819352073068206, 0.05466384543164038, 7.139707577289147, 0.7324633617322078, -0.5974217579491641,
    0.5799057577081417, -0.5109195385817744, -0.6762381291988606, 0.7716771363411128, -0.0698893665283471, -0.487784522407106, 7.21771295567365, -0.8460913013548179,
    0.8243329755583999, -0.38012842314624073, -0.15791617741112196, -0.5322912158539692, 0.40818404217842463, 0.4600510237798314, -0.36277040917715153, 7.057882259756383
  ]);
  BeginCategory('Real det/trace/norm order 8 #2');
  CmpRRel('det',   M8.Determinant, 11011681.573904397, 1e-9);
  CmpRRel('trace', M8.Trace,       61.00227848476645,  1e-12);
  CmpRRel('norm',  M8.Norm,        22.082647421096972, 1e-12);
  BeginCategory('Real inverse order 8 #2 (vs numpy, element-wise)');
  Inv8 := M8.Inverse;
  CmpRRel('inv[0,0]', Inv8[0,0], 0.11654456219829523, 1e-8);
  CmpRRel('inv[0,1]', Inv8[0,1], -0.011569653360577662, 1e-8);
  CmpRRel('inv[0,2]', Inv8[0,2], 0.0026224946222935235, 1e-8);
  CmpRRel('inv[0,3]', Inv8[0,3], -0.005144951712391097, 1e-8);
  CmpRRel('inv[0,4]', Inv8[0,4], -0.012622295103416021, 1e-8);
  CmpRRel('inv[0,5]', Inv8[0,5], -0.01624770365041336, 1e-8);
  CmpRRel('inv[0,6]', Inv8[0,6], 0.010351699242449802, 1e-8);
  CmpRRel('inv[0,7]', Inv8[0,7], -0.007658373382097711, 1e-8);
  CmpRRel('inv[1,0]', Inv8[1,0], -0.0018546739728661082, 1e-8);
  CmpRRel('inv[1,1]', Inv8[1,1], 0.13773980049665033, 1e-8);
  CmpRRel('inv[1,2]', Inv8[1,2], -0.007657101554870549, 1e-8);
  CmpRRel('inv[1,3]', Inv8[1,3], -0.012965328768254469, 1e-8);
  CmpRRel('inv[1,4]', Inv8[1,4], -0.0013566550560717822, 1e-8);
  CmpRRel('inv[1,5]', Inv8[1,5], 0.005546072780814126, 1e-8);
  CmpRRel('inv[1,6]', Inv8[1,6], 0.018552518636380702, 1e-8);
  CmpRRel('inv[1,7]', Inv8[1,7], 0.007117396274826339, 1e-8);
  CmpRRel('inv[2,0]', Inv8[2,0], 0.010831453931761768, 1e-8);
  CmpRRel('inv[2,1]', Inv8[2,1], 0.004694870918940891, 1e-8);
  CmpRRel('inv[2,2]', Inv8[2,2], 0.12348796286895121, 1e-8);
  CmpRRel('inv[2,3]', Inv8[2,3], 0.010804093291468617, 1e-8);
  CmpRRel('inv[2,4]', Inv8[2,4], -0.002025871452061409, 1e-8);
  CmpRRel('inv[2,5]', Inv8[2,5], 0.0005614119511660678, 1e-8);
  CmpRRel('inv[2,6]', Inv8[2,6], 0.016356722293081636, 1e-8);
  CmpRRel('inv[2,7]', Inv8[2,7], 0.011312338271051964, 1e-8);
  CmpRRel('inv[3,0]', Inv8[3,0], 0.01618043346440914, 1e-8);
  CmpRRel('inv[3,1]', Inv8[3,1], -0.013468156518998783, 1e-8);
  CmpRRel('inv[3,2]', Inv8[3,2], 0.002430078464915045, 1e-8);
  CmpRRel('inv[3,3]', Inv8[3,3], 0.13200901397976872, 1e-8);
  CmpRRel('inv[3,4]', Inv8[3,4], 0.0019635898449245773, 1e-8);
  CmpRRel('inv[3,5]', Inv8[3,5], 0.01236478671711585, 1e-8);
  CmpRRel('inv[3,6]', Inv8[3,6], -0.018993593656560597, 1e-8);
  CmpRRel('inv[3,7]', Inv8[3,7], -0.00577526244714505, 1e-8);
  CmpRRel('inv[4,0]', Inv8[4,0], -0.008807196929504461, 1e-8);
  CmpRRel('inv[4,1]', Inv8[4,1], -0.012560167532558422, 1e-8);
  CmpRRel('inv[4,2]', Inv8[4,2], -0.0037074574847127248, 1e-8);
  CmpRRel('inv[4,3]', Inv8[4,3], -0.004346266704488804, 1e-8);
  CmpRRel('inv[4,4]', Inv8[4,4], 0.12848449146649876, 1e-8);
  CmpRRel('inv[4,5]', Inv8[4,5], 0.007593954793951726, 1e-8);
  CmpRRel('inv[4,6]', Inv8[4,6], 0.010451420638249399, 1e-8);
  CmpRRel('inv[4,7]', Inv8[4,7], 0.014944123696992207, 1e-8);
  CmpRRel('inv[5,0]', Inv8[5,0], -0.005550693373626373, 1e-8);
  CmpRRel('inv[5,1]', Inv8[5,1], -0.010917338212723195, 1e-8);
  CmpRRel('inv[5,2]', Inv8[5,2], 0.012973414842295333, 1e-8);
  CmpRRel('inv[5,3]', Inv8[5,3], -0.013199191715234163, 1e-8);
  CmpRRel('inv[5,4]', Inv8[5,4], -0.001389424057176083, 1e-8);
  CmpRRel('inv[5,5]', Inv8[5,5], 0.13710838100904793, 1e-8);
  CmpRRel('inv[5,6]', Inv8[5,6], -0.012016564347482, 1e-8);
  CmpRRel('inv[5,7]', Inv8[5,7], 0.011377562981966278, 1e-8);
  CmpRRel('inv[6,0]', Inv8[6,0], -0.012077097311952207, 1e-8);
  CmpRRel('inv[6,1]', Inv8[6,1], 0.012867488641082657, 1e-8);
  CmpRRel('inv[6,2]', Inv8[6,2], 0.011655451424862004, 1e-8);
  CmpRRel('inv[6,3]', Inv8[6,3], -0.013305781229429327, 1e-8);
  CmpRRel('inv[6,4]', Inv8[6,4], 0.0009903971957593446, 1e-8);
  CmpRRel('inv[6,5]', Inv8[6,5], 0.009092080659570515, 1e-8);
  CmpRRel('inv[6,6]', Inv8[6,6], 0.1426125127725485, 1e-8);
  CmpRRel('inv[6,7]', Inv8[6,7], 0.020382023600376106, 1e-8);
  CmpRRel('inv[7,0]', Inv8[7,0], -0.011998787545173018, 1e-8);
  CmpRRel('inv[7,1]', Inv8[7,1], 0.009958484530705096, 1e-8);
  CmpRRel('inv[7,2]', Inv8[7,2], 0.002195405116212513, 1e-8);
  CmpRRel('inv[7,3]', Inv8[7,3], 0.010528013216943861, 1e-8);
  CmpRRel('inv[7,4]', Inv8[7,4], -0.005785343271709339, 1e-8);
  CmpRRel('inv[7,5]', Inv8[7,5], -0.005767478361776042, 1e-8);
  CmpRRel('inv[7,6]', Inv8[7,6], 0.006232703836034443, 1e-8);
  CmpRRel('inv[7,7]', Inv8[7,7], 0.14222263844465532, 1e-8);
  BeginCategory('Real inverse order 8 #2 (reconstruction A*inv=I)');
  Prod8 := M8 * Inv8;
  Id8   := M8.Identity;
  for i := 0 to 7 do
    for j := 0 to 7 do
      CmpRAbs('M8*inv-I', Prod8[i,j], Id8[i,j], 1e-9);
end;

procedure TestLargeRealEigen;
var
  M5: T5RealMatrix;
  M6: T6RealMatrix;
  M7: T7RealMatrix;
  M8: T8RealMatrix;
  M9: T9RealMatrix;
  M10: T10RealMatrix;
  ev: TArrayOfDouble;
  s: double;
  i: integer;
begin
  // --- symmetric, order 5 #1 (well-sep) ---
  M5.Assign([
    1.877038618100526, 0.37675191946407327, 2.2546487118191565, -0.7746835299354351, -0.030433597245280775, 0.37675191946407327, 1.3423252971070254, -1.9613643482167642,
    0.8960361461072767, 0.318857598837507, 2.2546487118191565, -1.9613643482167642, 0.9917374187508881, -1.014298552761613, -2.0494425368630704, -0.7746835299354351,
    0.8960361461072767, -1.014298552761613, 0.2460588289725014, -0.4187620819579271, -0.030433597245280775, 0.318857598837507, -2.0494425368630704, -0.4187620819579271,
    -0.957160162930941
  ]);
  ev := ExtractRealEigenvalues(M5.Eigenvalues); SortAscArray(ev);
  BeginCategory('Eigenvalues sym order 5 #1 (well-sep)');
  CmpRRel('eig[0]', ev[0], -2.9999999999999987, 1e-6);
  CmpRRel('eig[1]', ev[1], -1.0000000000000002, 1e-6);
  CmpRRel('eig[2]', ev[2], 0.5, 1e-6);
  CmpRRel('eig[3]', ev[3], 1.9999999999999993, 1e-6);
  CmpRRel('eig[4]', ev[4], 5.0, 1e-6);
  s := 0; for i := 0 to High(ev) do s := s + ev[i];
  CmpRRel('sum=trace', s, 3.5, 1e-9);
  // --- symmetric, order 5 #2 (well-sep) ---
  M5.Assign([
    3.9932502297285004, 0.2774892985808819, 0.9195588924553463, 0.4854068576102204, -0.07896346913254619, 0.2774892985808819, 2.6142794805711964, -0.8256175367371235,
    0.49715476094451855, -0.971990534170303, 0.9195588924553463, -0.8256175367371235, 2.8271658623359515, 0.8987240463996049, 0.4616652277387977, 0.4854068576102204,
    0.49715476094451855, 0.8987240463996049, 2.9743108867097865, 0.5239957289859325, -0.07896346913254619, -0.971990534170303, 0.4616652277387977, 0.5239957289859325,
    2.5909935406545666
  ]);
  ev := ExtractRealEigenvalues(M5.Eigenvalues); SortAscArray(ev);
  BeginCategory('Eigenvalues sym order 5 #2 (well-sep)');
  CmpRRel('eig[0]', ev[0], 0.9999999999999997, 1e-6);
  CmpRRel('eig[1]', ev[1], 2.0000000000000004, 1e-6);
  CmpRRel('eig[2]', ev[2], 3.0, 1e-6);
  CmpRRel('eig[3]', ev[3], 3.9999999999999987, 1e-6);
  CmpRRel('eig[4]', ev[4], 5.000000000000001, 1e-6);
  s := 0; for i := 0 to High(ev) do s := s + ev[i];
  CmpRRel('sum=trace', s, 15.0, 1e-9);
  // --- symmetric, order 6 #1 (well-sep) ---
  M6.Assign([
    -0.6121084908600687, 2.245343023674996, 0.16674229500224264, -0.49847519974089755, 1.5221706349740396, 0.20748750728111692, 2.245343023674996, -1.2032325169660814,
    1.5563671977822997, 3.17414482661633, -0.16417971387666466, 0.3563533913707971, 0.16674229500224264, 1.5563671977822997, 0.8012098925577938, -1.295853738177847,
    0.4276105071339328, -1.858701979390446, -0.49847519974089755, 3.17414482661633, -1.295853738177847, 2.3691910552547886, -0.5849273230609542, 2.8333598073865778,
    1.5221706349740396, -0.16417971387666466, 0.4276105071339328, -0.5849273230609542, -1.1444600586666092, -0.0711255735728339, 0.20748750728111692, 0.3563533913707971,
    -1.858701979390446, 2.8333598073865778, -0.0711255735728339, 3.289400118680177
  ]);
  ev := ExtractRealEigenvalues(M6.Eigenvalues); SortAscArray(ev);
  BeginCategory('Eigenvalues sym order 6 #1 (well-sep)');
  CmpRRel('eig[0]', ev[0], -5.000000000000001, 1e-6);
  CmpRRel('eig[1]', ev[1], -2.0, 1e-6);
  CmpRRel('eig[2]', ev[2], -0.5000000000000007, 1e-6);
  CmpRRel('eig[3]', ev[3], 0.9999999999999996, 1e-6);
  CmpRRel('eig[4]', ev[4], 3.000000000000002, 1e-6);
  CmpRRel('eig[5]', ev[5], 6.999999999999998, 1e-6);
  s := 0; for i := 0 to High(ev) do s := s + ev[i];
  CmpRRel('sum=trace', s, 3.5, 1e-9);
  // --- symmetric, order 6 #2 (well-sep) ---
  M6.Assign([
    2.480402734497463, 1.441374863657384, 0.3670830522428436, 0.7575301121341951, 0.35746768233559023, -0.11114766738372994, 1.441374863657384, 3.7732825343897685,
    -0.5157016692239338, 0.6810159404958745, 0.3753263455229465, 0.6011392517099333, 0.3670830522428436, -0.5157016692239338, 2.214517669948381, -0.8059040074582409,
    -1.7958168118429223, -0.09141629028725604, 0.7575301121341951, 0.6810159404958745, -0.8059040074582409, 4.470035011193196, 1.6015415642401545, -0.5555025428202363,
    0.35746768233559023, 0.3753263455229465, -1.7958168118429223, 1.6015415642401545, 2.0288163340574665, -0.19026139001087655, -0.11114766738372994, 0.6011392517099333,
    -0.09141629028725604, -0.5555025428202363, -0.19026139001087655, 1.032945715913725
  ]);
  ev := ExtractRealEigenvalues(M6.Eigenvalues); SortAscArray(ev);
  BeginCategory('Eigenvalues sym order 6 #2 (well-sep)');
  CmpRRel('eig[0]', ev[0], 0.10000000000000014, 1e-6);
  CmpRRel('eig[1]', ev[1], 0.6999999999999997, 1e-6);
  CmpRRel('eig[2]', ev[2], 1.499999999999999, 1e-6);
  CmpRRel('eig[3]', ev[3], 2.9000000000000004, 1e-6);
  CmpRRel('eig[4]', ev[4], 4.199999999999998, 1e-6);
  CmpRRel('eig[5]', ev[5], 6.599999999999997, 1e-6);
  s := 0; for i := 0 to High(ev) do s := s + ev[i];
  CmpRRel('sum=trace', s, 16.000000000000004, 1e-9);
  // --- symmetric, order 7 #1 (well-sep) ---
  M7.Assign([
    3.2520735001205017, -0.2696725535453295, 1.1041108958273742, 0.5646037366301281, 1.5689608399073425, 0.31320424819472037, -1.0411975754057115, -0.2696725535453295,
    -0.025820031670374603, 0.18342177521235087, 1.6555473386903283, 1.1892624677715125, 0.04966500873481965, -0.7042812467242934, 1.1041108958273742, 0.18342177521235087,
    -1.9189221712118987, 0.23460451276070493, -1.7873327766661153, 0.18678090684145948, 1.4373698918714344, 0.5646037366301281, 1.6555473386903283, 0.23460451276070493,
    -0.46224177005804773, 0.7870896965320685, 1.1863591834857758, -0.028151586339222028, 1.5689608399073425, 1.1892624677715125, -1.7873327766661153, 0.7870896965320685,
    0.39784201213817766, 1.060571880780074, -1.3926393759010791, 0.31320424819472037, 0.04966500873481965, 0.18678090684145948, 1.1863591834857758, 1.060571880780074,
    -0.7819444055299198, -2.005328287462617, -1.0411975754057115, -0.7042812467242934, 1.4373698918714344, -0.028151586339222028, -1.3926393759010791, -2.005328287462617,
    2.5390128662115585
  ]);
  ev := ExtractRealEigenvalues(M7.Eigenvalues); SortAscArray(ev);
  BeginCategory('Eigenvalues sym order 7 #1 (well-sep)');
  CmpRRel('eig[0]', ev[0], -3.9999999999999987, 1e-6);
  CmpRRel('eig[1]', ev[1], -2.5000000000000027, 1e-6);
  CmpRRel('eig[2]', ev[2], -0.9999999999999998, 1e-6);
  CmpRRel('eig[3]', ev[3], 1.4815351382921052e-16, 1e-6);
  CmpRRel('eig[4]', ev[4], 1.5, 1e-6);
  CmpRRel('eig[5]', ev[5], 2.9999999999999973, 1e-6);
  CmpRRel('eig[6]', ev[6], 5.999999999999998, 1e-6);
  s := 0; for i := 0 to High(ev) do s := s + ev[i];
  CmpRRel('sum=trace', s, 2.999999999999997, 1e-9);
  // --- symmetric, order 8 #1 (well-sep) ---
  M8.Assign([
    4.440492093761296, -0.5454288725648272, 0.3853181859508925, -2.353027573744856, -2.627915472288499, 1.011306746322341, -0.7604210009826493, -0.3647430530025336,
    -0.5454288725648272, 4.6398238597801855, 0.0327703018616899, 1.6246084553179005, -1.7520692949355055, 1.2393644689067043, 1.020423820415878, -3.464091226299134,
    0.3853181859508925, 0.0327703018616899, 1.855397063999697, -1.4949978181169263, -1.1127550162283368, 2.8139822466746596, -1.3115345471815423, 1.688208744649234,
    -2.353027573744856, 1.6246084553179005, -1.4949978181169263, 1.9556867324014382, 1.488215668880256, -2.46366614306442, 2.209446798242253, 2.335094136824288,
    -2.627915472288499, -1.7520692949355055, -1.1127550162283368, 1.488215668880256, 0.17904513967639343, -0.22927594853144023, 1.0539931845162758, -0.4482863338686043,
    1.011306746322341, 1.2393644689067043, 2.8139822466746596, -2.46366614306442, -0.22927594853144023, 1.0577003626751755, -1.6104383066658008, -2.1838639094432892,
    -0.7604210009826493, 1.020423820415878, -1.3115345471815423, 2.209446798242253, 1.0539931845162758, -1.6104383066658008, 1.7573625655959244, -0.430846788827294,
    -0.3647430530025336, -3.464091226299134, 1.688208744649234, 2.335094136824288, -0.4482863338686043, -2.1838639094432892, -0.430846788827294, -2.3855078178901152
  ]);
  ev := ExtractRealEigenvalues(M8.Eigenvalues); SortAscArray(ev);
  BeginCategory('Eigenvalues sym order 8 #1 (well-sep)');
  CmpRRel('eig[0]', ev[0], -5.999999999999999, 1e-6);
  CmpRRel('eig[1]', ev[1], -2.9999999999999996, 1e-6);
  CmpRRel('eig[2]', ev[2], -0.9999999999999999, 1e-6);
  CmpRRel('eig[3]', ev[3], 0.5000000000000011, 1e-6);
  CmpRRel('eig[4]', ev[4], 1.9999999999999998, 1e-6);
  CmpRRel('eig[5]', ev[5], 3.9999999999999964, 1e-6);
  CmpRRel('eig[6]', ev[6], 6.999999999999993, 1e-6);
  CmpRRel('eig[7]', ev[7], 9.999999999999995, 1e-6);
  s := 0; for i := 0 to High(ev) do s := s + ev[i];
  CmpRRel('sum=trace', s, 13.499999999999996, 1e-9);
  // --- symmetric, order 9 #1 (well-sep) ---
  M9.Assign([
    -2.1352440038441967, -1.7405590219081462, 0.8792406557675978, -0.9695225716054277, -0.38956707785332645, 1.9933941415576224, -0.5532805878382351, 0.46931932035332147,
    -1.274780028823254, -1.7405590219081462, 4.667718563997424, -1.5358536472297188, 0.21657323489559638, -2.931080535769775, 1.4985118224916594, -0.8958563312137127,
    -0.40206836706182497, 0.049931731120945386, 0.8792406557675978, -1.5358536472297188, 1.777795463127532, -3.2430867234553773, 1.8345414025835458, 0.6856224932698044,
    0.20998841457603953, -1.0887336462403205, 1.36199468975751, -0.9695225716054277, 0.21657323489559638, -3.2430867234553773, 3.0701994344363377, -0.22957062964641234,
    -0.3902979285241767, 1.5945413621825004, 2.5076054114227913, -2.3635386203769, -0.38956707785332645, -2.931080535769775, 1.8345414025835458, -0.22957062964641234,
    -1.544234339687136, 1.328506282132597, 1.158243195610358, -0.5559301145362009, 0.9061689779747796, 1.9933941415576224, 1.4985118224916594, 0.6856224932698044,
    -0.3902979285241767, 1.328506282132597, 0.9200409152031159, 0.5894846818593646, 1.0227245465951706, 0.9198800765008541, -0.5532805878382351, -0.8958563312137127,
    0.20998841457603953, 1.5945413621825004, 1.158243195610358, 0.5894846818593646, -3.180888566082774, 2.771460431452428, 4.183207809192897, 0.46931932035332147,
    -0.40206836706182497, -1.0887336462403205, 2.5076054114227913, -0.5559301145362009, 1.0227245465951706, 2.771460431452428, 2.3822240480441783, -1.4625222346365154,
    -1.274780028823254, 0.049931731120945386, 1.36199468975751, -2.3635386203769, 0.9061689779747796, 0.9198800765008541, 4.183207809192897, -1.4625222346365154,
    -1.457611515194473
  ]);
  ev := ExtractRealEigenvalues(M9.Eigenvalues); SortAscArray(ev);
  BeginCategory('Eigenvalues sym order 9 #1 (well-sep)');
  CmpRRel('eig[0]', ev[0], -8.000000000000004, 1e-6);
  CmpRRel('eig[1]', ev[1], -4.999999999999999, 1e-6);
  CmpRRel('eig[2]', ev[2], -2.999999999999998, 1e-6);
  CmpRRel('eig[3]', ev[3], -0.9999999999999983, 1e-6);
  CmpRRel('eig[4]', ev[4], -5.001487802053936e-16, 1e-6);
  CmpRRel('eig[5]', ev[5], 2.000000000000001, 1e-6);
  CmpRRel('eig[6]', ev[6], 4.000000000000002, 1e-6);
  CmpRRel('eig[7]', ev[7], 6.500000000000005, 1e-6);
  CmpRRel('eig[8]', ev[8], 9.0, 1e-6);
  s := 0; for i := 0 to High(ev) do s := s + ev[i];
  CmpRRel('sum=trace', s, 4.500000000000007, 1e-9);
  // --- symmetric, order 10 #1 (well-sep) ---
  M10.Assign([
    3.5372119616224236, -2.0666971385722905, -0.7453494093768062, 2.740017630525798, 1.0240776930748223, 0.6531414288645745, -0.15100637549321372, 0.07366019052116873,
    0.8352507132149899, 4.601335885933053, -2.0666971385722905, 0.5818237434601758, -0.1576032927379089, 1.417181231577184, 2.1355865446663893, -2.3327371950176143,
    -5.413265153926185, 3.474044333611415, -0.35964769015022224, -0.4899815102322837, -0.7453494093768062, -0.1576032927379089, 2.6433903823467007, -1.8007475944525866,
    -0.3327875079905113, 0.9533285821231798, 1.8510002118478175, -0.2179751190112264, -1.5608457502039752, 1.7237970005813508, 2.740017630525798, 1.417181231577184,
    -1.8007475944525866, -1.372277712214737, 0.18747110986177318, 1.237731231636718, -1.2755142348373492, -0.2759109396436322, -2.4515456379764045, 1.7283645086718096,
    1.0240776930748223, 2.1355865446663893, -0.3327875079905113, 0.18747110986177318, 0.00849459564280706, 0.8187366467417538, -1.4829696057446315, -1.2271386372291615,
    -1.4106808232774906, 2.955268366124081, 0.6531414288645745, -2.3327371950176143, 0.9533285821231798, 1.237731231636718, 0.8187366467417538, 0.45591108517427326,
    1.4183860773031327, -1.5124776247573697, 1.0429537499603394, 2.163091450132446, -0.15100637549321372, -5.413265153926185, 1.8510002118478175, -1.2755142348373492,
    -1.4829696057446315, 1.4183860773031327, 3.771883846876254, -2.0357589624892567, -1.184484998153913, 3.3732303569583633, 0.07366019052116873, 3.474044333611415,
    -0.2179751190112264, -0.2759109396436322, -1.2271386372291615, -1.5124776247573697, -2.0357589624892567, -2.873099633475636, 0.08269406917585537, -1.2116010254373895,
    0.8352507132149899, -0.35964769015022224, -1.5608457502039752, -2.4515456379764045, -1.4106808232774906, 1.0429537499603394, -1.184484998153913, 0.08269406917585537,
    3.7796091749910596, 3.2657979927232215, 4.601335885933053, -0.4899815102322837, 1.7237970005813508, 1.7283645086718096, 2.955268366124081, 2.163091450132446,
    3.3732303569583633, -1.2116010254373895, 3.2657979927232215, -4.532947444423325
  ]);
  ev := ExtractRealEigenvalues(M10.Eigenvalues); SortAscArray(ev);
  BeginCategory('Eigenvalues sym order 10 #1 (well-sep)');
  CmpRRel('eig[0]', ev[0], -10.000000000000002, 1e-6);
  CmpRRel('eig[1]', ev[1], -7.000000000000001, 1e-6);
  CmpRRel('eig[2]', ev[2], -4.000000000000001, 1e-6);
  CmpRRel('eig[3]', ev[3], -1.9999999999999996, 1e-6);
  CmpRRel('eig[4]', ev[4], -0.49999999999999944, 1e-6);
  CmpRRel('eig[5]', ev[5], 1.0000000000000004, 1e-6);
  CmpRRel('eig[6]', ev[6], 2.9999999999999982, 1e-6);
  CmpRRel('eig[7]', ev[7], 5.499999999999996, 1e-6);
  CmpRRel('eig[8]', ev[8], 8.000000000000002, 1e-6);
  CmpRRel('eig[9]', ev[9], 12.0, 1e-6);
  s := 0; for i := 0 to High(ev) do s := s + ev[i];
  CmpRRel('sum=trace', s, 5.9999999999999964, 1e-9);
  // --- symmetric, order 6 #1 (clustered) ---
  M6.Assign([
    5.925050384913917, 1.2444925064804988, 1.623658325214669, 1.933493081770353, 0.6126905229278468, -1.756737547541638, 1.2444925064804988, 4.182060953292831,
    0.5071489557957389, -0.30710418490074437, -0.33901022161070726, 0.5699465652864619, 1.623658325214669, 0.5071489557957389, 3.020248780456357, 0.2654730321941132,
    -0.16348519174606854, -1.4199277376151365, 1.933493081770353, -0.30710418490074437, 0.2654730321941132, 4.257386600341189, 1.223724799808677, -0.38240217218546535,
    0.6126905229278468, -0.33901022161070726, -0.16348519174606854, 1.223724799808677, 2.758927637508219, 0.2175045264737569, -1.756737547541638, 0.5699465652864619,
    -1.4199277376151365, -0.38240217218546535, 0.2175045264737569, 4.856325643487482
  ]);
  ev := ExtractRealEigenvalues(M6.Eigenvalues); SortAscArray(ev);
  BeginCategory('Eigenvalues sym order 6 #1 (clustered)');
  CmpRRel('eig[0]', ev[0], 1.9999999999999987, 1e-5);
  CmpRRel('eig[1]', ev[1], 1.9999999999999993, 1e-5);
  CmpRRel('eig[2]', ev[2], 1.9999999999999996, 1e-5);
  CmpRRel('eig[3]', ev[3], 4.9999999999999964, 1e-5);
  CmpRRel('eig[4]', ev[4], 5.0, 1e-5);
  CmpRRel('eig[5]', ev[5], 9.0, 1e-5);
  s := 0; for i := 0 to High(ev) do s := s + ev[i];
  CmpRRel('sum=trace', s, 24.999999999999993, 1e-8);
  // --- symmetric, order 6 #2 (clustered) ---
  M6.Assign([
    3.062741796832745, -0.6669652865785141, 0.012600730538453758, -0.37761777800404034, -0.6976079886566673, 0.9416954189854538, -0.6669652865785141, 1.5922323950700792,
    -1.2631339799846288, 0.6038806167982181, 0.2997387318667559, 0.053088260834368114, 0.012600730538453758, -1.2631339799846288, 5.5031842472011006, -2.4582054425155304,
    0.4035731119675662, -0.9322854776390861, -0.37761777800404034, 0.6038806167982181, -2.4582054425155304, 4.124065238114904, -1.6707478937678157, -0.4593295127566775,
    -0.6976079886566673, 0.2997387318667559, 0.4035731119675662, -1.6707478937678157, 2.72094513633354, 0.3300346186508733, 0.9416954189854538, 0.053088260834368114,
    -0.9322854776390861, -0.4593295127566775, 0.3300346186508733, 1.9971311864476304
  ]);
  ev := ExtractRealEigenvalues(M6.Eigenvalues); SortAscArray(ev);
  BeginCategory('Eigenvalues sym order 6 #2 (clustered)');
  CmpRRel('eig[0]', ev[0], 0.9999999999999999, 1e-5);
  CmpRRel('eig[1]', ev[1], 1.0001000000000007, 1e-5);
  CmpRRel('eig[2]', ev[2], 1.0002, 1e-5);
  CmpRRel('eig[3]', ev[3], 3.9999999999999996, 1e-5);
  CmpRRel('eig[4]', ev[4], 4.0, 1e-5);
  CmpRRel('eig[5]', ev[5], 8.0, 1e-5);
  s := 0; for i := 0 to High(ev) do s := s + ev[i];
  CmpRRel('sum=trace', s, 19.0003, 1e-8);
  // --- symmetric, order 8 #1 (clustered) ---
  M8.Assign([
    6.234978496224475, -2.1760849770907154, 0.5177758267409841, 0.1889409563020285, -0.06602061550096633, -1.930319749289369, 0.7714197854685676, -1.3871552850974478,
    -2.1760849770907154, 5.219583570499929, -0.4448344735665426, 0.0016726506529782157, 0.9260476248057818, 0.10064770336902626, -0.05026372270939565, 0.3445287836910894,
    0.5177758267409841, -0.4448344735665426, 4.024392222750218, -1.266214382507782, -0.8401029540159997, -0.9557152762733626, 0.9648564013872885, -0.18228195617170495,
    0.1889409563020285, 0.0016726506529782157, -1.266214382507782, 5.631648325652612, 0.734948996854277, 0.008278381669252158, -0.8892223223266991, 1.2201853356031882,
    -0.06602061550096633, 0.9260476248057818, -0.8401029540159997, 0.734948996854277, 4.77350539405715, -0.36989930939681526, -0.2730303542830561, -1.2769842566422986,
    -1.930319749289369, 0.10064770336902626, -0.9557152762733626, 0.008278381669252158, -0.36989930939681526, 7.460561333608639, -2.190168343860455, 0.5335550365967634,
    0.7714197854685676, -0.05026372270939565, 0.9648564013872885, -0.8892223223266991, -0.2730303542830561, -2.190168343860455, 4.410603860843832, -0.3619267166442616,
    -1.3871552850974478, 0.3445287836910894, -0.18228195617170495, 1.2201853356031882, -1.2769842566422986, 0.5335550365967634, -0.3619267166442616, 6.2447267963631585
  ]);
  ev := ExtractRealEigenvalues(M8.Eigenvalues); SortAscArray(ev);
  BeginCategory('Eigenvalues sym order 8 #1 (clustered)');
  CmpRRel('eig[0]', ev[0], 2.9999999999999982, 1e-5);
  CmpRRel('eig[1]', ev[1], 2.9999999999999987, 1e-5);
  CmpRRel('eig[2]', ev[2], 3.0, 1e-5);
  CmpRRel('eig[3]', ev[3], 3.0000000000000018, 1e-5);
  CmpRRel('eig[4]', ev[4], 7.0, 1e-5);
  CmpRRel('eig[5]', ev[5], 7.000000000000003, 1e-5);
  CmpRRel('eig[6]', ev[6], 7.000000000000009, 1e-5);
  CmpRRel('eig[7]', ev[7], 10.999999999999998, 1e-5);
  s := 0; for i := 0 to High(ev) do s := s + ev[i];
  CmpRRel('sum=trace', s, 44.000000000000014, 1e-8);
  // --- symmetric, order 10 #1 (clustered) ---
  M10.Assign([
    2.4632029036275154, -0.8429906947748914, -0.5414650807133667, -0.01442687364489214, 0.4937673455536109, 0.8561820450313145, 0.45727095536309414, -2.269225303109905,
    0.24940046583090875, 0.9301344410516985, -0.8429906947748914, 2.642856253965738, 0.3580701180276382, 0.05741344697224389, -0.6395161475353561, -1.5327416181828615,
    -0.12656613463008237, -0.12882801474238215, -1.2433167093981974, -0.8499527814961385, -0.5414650807133667, 0.3580701180276382, 5.12925135199565, -0.30094835297882305,
    -0.7374017606314236, 1.1525256624538633, -0.6888957698191431, -0.9612044136503952, -0.5611969065639117, 1.804995863914624, -0.01442687364489214, 0.05741344697224389,
    -0.30094835297882305, 1.6895430611983289, -0.07423748058644758, 0.694765837719212, -0.6905467327581472, -0.003966909057530379, -0.2252333014147013, -1.4852249798164865,
    0.4937673455536109, -0.6395161475353561, -0.7374017606314236, -0.07423748058644758, 1.4380504067877584, 0.6182367571276228, 0.6701819464791814, -0.10319046257465185,
    0.06380088549675231, 0.4964547986708878, 0.8561820450313145, -1.5327416181828615, 1.1525256624538633, 0.694765837719212, 0.6182367571276228, 5.752185873525145,
    0.7493398913272242, -0.9958248781132066, -1.384872234711523, 0.8786295748664776, 0.45727095536309414, -0.12656613463008237, -0.6888957698191431, -0.6905467327581472,
    0.6701819464791814, 0.7493398913272242, 3.9777455321850383, -0.7017168628601058, -2.050605100625509, 2.3926427788819793, -2.269225303109905, -0.12882801474238215,
    -0.9612044136503952, -0.003966909057530379, -0.10319046257465185, -0.9958248781132066, -0.7017168628601058, 7.106457640172081, 1.3983260081749098, -1.9001851396346803,
    0.24940046583090875, -1.2433167093981974, -0.5611969065639117, -0.2252333014147013, 0.06380088549675231, -1.384872234711523, -2.050605100625509, 1.3983260081749098,
    4.898171731179211, -0.5470527256078043, 0.9301344410516985, -0.8499527814961385, 1.804995863914624, -1.4852249798164865, 0.4964547986708878, 0.8786295748664776,
    2.3926427788819793, -1.9001851396346803, -0.5470527256078043, 5.902535245363529
  ]);
  ev := ExtractRealEigenvalues(M10.Eigenvalues); SortAscArray(ev);
  BeginCategory('Eigenvalues sym order 10 #1 (clustered)');
  CmpRRel('eig[0]', ev[0], 0.9999999999999982, 1e-5);
  CmpRRel('eig[1]', ev[1], 0.9999999999999989, 1e-5);
  CmpRRel('eig[2]', ev[2], 1.0000000000000002, 1e-5);
  CmpRRel('eig[3]', ev[3], 1.0000000000000004, 1e-5);
  CmpRRel('eig[4]', ev[4], 1.0000000000000016, 1e-5);
  CmpRRel('eig[5]', ev[5], 5.9999999999999964, 1e-5);
  CmpRRel('eig[6]', ev[6], 5.999999999999998, 1e-5);
  CmpRRel('eig[7]', ev[7], 6.0, 1e-5);
  CmpRRel('eig[8]', ev[8], 6.000000000000004, 1e-5);
  CmpRRel('eig[9]', ev[9], 12.000000000000002, 1e-5);
  s := 0; for i := 0 to High(ev) do s := s + ev[i];
  CmpRRel('sum=trace', s, 40.99999999999999, 1e-8);
end;

procedure TestEigenvaluesBeyondOrder10;
var
  M12, D12, Q12: T12RealMatrix;
  M16: T16RealMatrix;
  M24: T24RealMatrix;
  M32, D32, Q32: T32RealMatrix;
  M64: T64RealMatrix;
  V12: T12ComplexMatrix;
  E12: T12ComplexVector;
  E16: T16ComplexVector;
  E24: T24ComplexVector;
  E32: T32ComplexVector;
  E64: T64ComplexVector;
  Actual: TArrayOfDouble;
  Used: array of boolean;
  Expected, Sum, Dot: TComplex;
  Scale, URow, UCol, SumU2, CAngle, SAngle, X, Y: double;
  Err, BestErr, RNorm, VNorm, ANorm, MaxOrthogonality: double;
  i, j, k, p, pass, PairIndex, SignIndex, BestIndex: integer;
  AllFinite: boolean;

  procedure CheckToeplitz12;
  var
    ii: integer;
  begin
    M12 := M12.Null;
    for ii := 0 to 11 do
    begin
      M12[ii,ii] := 2;
      if ii < 11 then
      begin
        M12[ii,ii+1] := -1;
        M12[ii+1,ii] := -1;
      end;
    end;
    E12 := M12.Eigenvalues;
    SetLength(Actual, 12);
    AllFinite := True;
    for ii := 0 to 11 do
    begin
      AllFinite := AllFinite and not IsNan(E12[ii].Re) and
        not IsInfinite(E12[ii].Re) and not IsNan(E12[ii].Im) and
        not IsInfinite(E12[ii].Im);
      Actual[ii] := E12[ii].Re;
    end;
    Check('order 12 Toeplitz eigenvalues are finite', AllFinite);
    SortAscArray(Actual);
    BeginCategory('Eigenvalues sym Toeplitz order 12 (analytic/NumPy)');
    for ii := 0 to 11 do
      CmpRRel(Format('eig[%d]', [ii]), Actual[ii],
        2 - 2 * Cos((ii + 1) * Pi / 13), 1e-9);
  end;

  procedure CheckToeplitz16;
  var
    ii: integer;
  begin
    M16 := M16.Null;
    for ii := 0 to 15 do
    begin
      M16[ii,ii] := 2;
      if ii < 15 then
      begin
        M16[ii,ii+1] := -1;
        M16[ii+1,ii] := -1;
      end;
    end;
    E16 := M16.Eigenvalues;
    SetLength(Actual, 16);
    AllFinite := True;
    for ii := 0 to 15 do
    begin
      AllFinite := AllFinite and not IsNan(E16[ii].Re) and
        not IsInfinite(E16[ii].Re) and not IsNan(E16[ii].Im) and
        not IsInfinite(E16[ii].Im);
      Actual[ii] := E16[ii].Re;
    end;
    Check('order 16 Toeplitz eigenvalues are finite', AllFinite);
    SortAscArray(Actual);
    BeginCategory('Eigenvalues sym Toeplitz order 16 (analytic/NumPy)');
    for ii := 0 to 15 do
      CmpRRel(Format('eig[%d]', [ii]), Actual[ii],
        2 - 2 * Cos((ii + 1) * Pi / 17), 1e-9);
  end;

  procedure CheckToeplitz24;
  var
    ii: integer;
  begin
    M24 := M24.Null;
    for ii := 0 to 23 do
    begin
      M24[ii,ii] := 2;
      if ii < 23 then
      begin
        M24[ii,ii+1] := -1;
        M24[ii+1,ii] := -1;
      end;
    end;
    E24 := M24.Eigenvalues;
    SetLength(Actual, 24);
    AllFinite := True;
    for ii := 0 to 23 do
    begin
      AllFinite := AllFinite and not IsNan(E24[ii].Re) and
        not IsInfinite(E24[ii].Re) and not IsNan(E24[ii].Im) and
        not IsInfinite(E24[ii].Im);
      Actual[ii] := E24[ii].Re;
    end;
    Check('order 24 Toeplitz eigenvalues are finite', AllFinite);
    SortAscArray(Actual);
    BeginCategory('Eigenvalues sym Toeplitz order 24 (analytic/NumPy)');
    for ii := 0 to 23 do
      CmpRRel(Format('eig[%d]', [ii]), Actual[ii],
        2 - 2 * Cos((ii + 1) * Pi / 25), 1e-9);
  end;

  procedure CheckToeplitz32;
  var
    ii: integer;
  begin
    M32 := M32.Null;
    for ii := 0 to 31 do
    begin
      M32[ii,ii] := 2;
      if ii < 31 then
      begin
        M32[ii,ii+1] := -1;
        M32[ii+1,ii] := -1;
      end;
    end;
    E32 := M32.Eigenvalues;
    SetLength(Actual, 32);
    AllFinite := True;
    for ii := 0 to 31 do
    begin
      AllFinite := AllFinite and not IsNan(E32[ii].Re) and
        not IsInfinite(E32[ii].Re) and not IsNan(E32[ii].Im) and
        not IsInfinite(E32[ii].Im);
      Actual[ii] := E32[ii].Re;
    end;
    Check('order 32 Toeplitz eigenvalues are finite', AllFinite);
    SortAscArray(Actual);
    BeginCategory('Eigenvalues sym Toeplitz order 32 (analytic/NumPy)');
    for ii := 0 to 31 do
      CmpRRel(Format('eig[%d]', [ii]), Actual[ii],
        2 - 2 * Cos((ii + 1) * Pi / 33), 1e-9);
  end;

  procedure CheckToeplitz64;
  var
    ii: integer;
  begin
    M64 := M64.Null;
    for ii := 0 to 63 do
    begin
      M64[ii,ii] := 2;
      if ii < 63 then
      begin
        M64[ii,ii+1] := -1;
        M64[ii+1,ii] := -1;
      end;
    end;
    E64 := M64.Eigenvalues;
    SetLength(Actual, 64);
    AllFinite := True;
    for ii := 0 to 63 do
    begin
      AllFinite := AllFinite and not IsNan(E64[ii].Re) and
        not IsInfinite(E64[ii].Re) and not IsNan(E64[ii].Im) and
        not IsInfinite(E64[ii].Im);
      Actual[ii] := E64[ii].Re;
    end;
    Check('order 64 Toeplitz eigenvalues are finite', AllFinite);
    SortAscArray(Actual);
    BeginCategory('Eigenvalues sym Toeplitz order 64 (analytic/NumPy)');
    for ii := 0 to 63 do
      CmpRRel(Format('eig[%d]', [ii]), Actual[ii],
        2 - 2 * Cos((ii + 1) * Pi / 65), 1e-9);
  end;

begin
  Section('TRealMatrix - eigenvalue limits beyond order 10');
  CheckToeplitz12;
  CheckToeplitz16;
  CheckToeplitz24;
  CheckToeplitz32;
  CheckToeplitz64;

  { Dense order-32 symmetric matrix Q*D*Q^T with a known, well-separated
    spectrum.  Unlike the Toeplitz cases, this exercises the complete
    Householder reduction before QR iteration. }
  Q32 := Q32.Identity;
  for pass := 0 to 4 do
    for p := 0 to 31 do
    begin
      j := (13 * p + 7 * pass + 5) mod 32;
      if j = p then Continue;
      CAngle := Cos(0.019 * (pass + 1) * (p + 1));
      SAngle := Sin(0.019 * (pass + 1) * (p + 1));
      for i := 0 to 31 do
      begin
        X := Q32[i,p];
        Y := Q32[i,j];
        Q32[i,p] := CAngle * X - SAngle * Y;
        Q32[i,j] := SAngle * X + CAngle * Y;
      end;
    end;
  D32 := D32.Null;
  for i := 0 to 31 do D32[i,i] := (i - 15.5) / 2;
  M32 := Q32 * D32 * Q32.Transpose;
  E32 := M32.Eigenvalues;
  SetLength(Actual, 32);
  AllFinite := True;
  for i := 0 to 31 do
  begin
    AllFinite := AllFinite and not IsNan(E32[i].Re) and
      not IsInfinite(E32[i].Re) and not IsNan(E32[i].Im) and
      not IsInfinite(E32[i].Im);
    Actual[i] := E32[i].Re;
  end;
  Check('order 32 dense symmetric eigenvalues are finite', AllFinite);
  SortAscArray(Actual);
  BeginCategory('Eigenvalues dense symmetric order 32 (analytic/NumPy)');
  for i := 0 to 31 do
    CmpRRel(Format('eig[%d]', [i]), Actual[i], (i - 15.5) / 2, 1e-9);

  { Dense symmetric rank-one update: I + u*u^T.  Its spectrum is 1 with
    multiplicity N-1 and 1+u^T*u once.  Scaling the complete matrix exposes
    absolute tolerances without changing its mathematical conditioning. }
  Scale := 1e-15;
  SumU2 := 0;
  for i := 0 to 11 do
  begin
    URow := (i + 1) / 12;
    SumU2 := SumU2 + Sqr(URow);
  end;
  M12 := M12.Null;
  for i := 0 to 11 do
  begin
    URow := (i + 1) / 12;
    for j := 0 to 11 do
    begin
      UCol := (j + 1) / 12;
      M12[i,j] := Scale * URow * UCol;
      if i = j then M12[i,j] := M12[i,j] + Scale;
    end;
  end;
  E12 := M12.Eigenvalues;
  SetLength(Actual, 12);
  AllFinite := True;
  for i := 0 to 11 do
  begin
    AllFinite := AllFinite and not IsNan(E12[i].Re) and
      not IsInfinite(E12[i].Re) and not IsNan(E12[i].Im) and
      not IsInfinite(E12[i].Im);
    Actual[i] := E12[i].Re / Scale;
  end;
  Check('scaled dense symmetric eigenvalues are finite', AllFinite);
  SortAscArray(Actual);
  BeginCategory('Eigenvalue scale invariance order 12 (analytic/NumPy)');
  for i := 0 to 10 do
    CmpRRel(Format('eig[%d]/scale', [i]), Actual[i], 1, 1e-9);
  CmpRRel('eig[11]/scale', Actual[11], 1 + SumU2, 1e-9);

  { Dense real normal matrix Q*D*Q^T with six known complex-conjugate
    eigenvalue pairs. }
  Q12 := Q12.Identity;
  for pass := 0 to 2 do
    for p := 0 to 10 do
    begin
      CAngle := Cos(0.071 * (pass + 1) * (p + 1));
      SAngle := Sin(0.071 * (pass + 1) * (p + 1));
      for i := 0 to 11 do
      begin
        X := Q12[i,p];
        Y := Q12[i,p+1];
        Q12[i,p]   := CAngle * X - SAngle * Y;
        Q12[i,p+1] := SAngle * X + CAngle * Y;
      end;
    end;
  D12 := D12.Null;
  for PairIndex := 0 to 5 do
  begin
    X := PairIndex - 2.5;
    Y := 0.25 + 0.2 * PairIndex;
    D12[2*PairIndex, 2*PairIndex]       := X;
    D12[2*PairIndex, 2*PairIndex+1]     := -Y;
    D12[2*PairIndex+1, 2*PairIndex]     := Y;
    D12[2*PairIndex+1, 2*PairIndex+1]   := X;
  end;
  M12 := Q12 * D12 * Q12.Transpose;
  E12 := M12.Eigenvalues;
  SetLength(Used, 12);
  AllFinite := True;
  for i := 0 to 11 do
    AllFinite := AllFinite and not IsNan(E12[i].Re) and
      not IsInfinite(E12[i].Re) and not IsNan(E12[i].Im) and
      not IsInfinite(E12[i].Im);
  Check('order 12 general eigenvalues are finite', AllFinite);
  BeginCategory('Eigenvalues general order 12, complex pairs (analytic/NumPy)');
  for PairIndex := 0 to 5 do
    for SignIndex := 0 to 1 do
    begin
      if SignIndex = 0 then
        Expected := Complex(PairIndex - 2.5, 0.25 + 0.2 * PairIndex)
      else
        Expected := Complex(PairIndex - 2.5, -(0.25 + 0.2 * PairIndex));
      BestErr := MaxDouble;
      BestIndex := -1;
      for j := 0 to 11 do
        if not Used[j] then
        begin
          Err := Abs(E12[j] - Expected) / (1 + Abs(Expected));
          if Err < BestErr then
          begin
            BestErr := Err;
            BestIndex := j;
          end;
        end;
      if BestIndex >= 0 then Used[BestIndex] := True;
      TrackTol(BestErr, 1e-9);
    end;

  V12 := M12.Eigenvectors(E12);
  ANorm := M12.Norm;
  MaxOrthogonality := 0;
  BeginCategory('Eigenvectors general order 12 (residual/norm/orthogonality)');
  for j := 0 to 11 do
  begin
    RNorm := 0;
    VNorm := 0;
    for i := 0 to 11 do
    begin
      Sum := 0;
      for k := 0 to 11 do
        Sum := Sum + M12[i,k] * V12[k,j];
      Sum := Sum - E12[j] * V12[i,j];
      RNorm := Hypot(RNorm, Abs(Sum));
      VNorm := Hypot(VNorm, Abs(V12[i,j]));
    end;
    TrackTol(RNorm / ((ANorm + Abs(E12[j])) * VNorm), 1e-9);
    TrackTol(Abs(VNorm - 1), 1e-9);
  end;
  for j := 0 to 10 do
    for k := j + 1 to 11 do
    begin
      Dot := 0;
      for i := 0 to 11 do
        Dot := Dot + V12[i,j].Conjugate * V12[i,k];
      if Abs(Dot) > MaxOrthogonality then MaxOrthogonality := Abs(Dot);
    end;
  TrackTol(MaxOrthogonality, 1e-8);
end;

procedure TestEigenvaluesOrder100;
var
  M: T100RealMatrix;
  E: T100ComplexVector;
  Actual: TArrayOfDouble;
  i: integer;
  AllFinite: boolean;
begin
  Section('TRealMatrix - opt-in eigenvalue stress order 100');
  for i := 0 to 99 do
  begin
    M[i,i] := 2;
    if i < 99 then
    begin
      M[i,i+1] := -1;
      M[i+1,i] := -1;
    end;
  end;

  E := M.Eigenvalues;
  SetLength(Actual, 100);
  AllFinite := True;
  for i := 0 to 99 do
  begin
    AllFinite := AllFinite and not IsNan(E[i].Re) and
      not IsInfinite(E[i].Re) and not IsNan(E[i].Im) and
      not IsInfinite(E[i].Im);
    Actual[i] := E[i].Re;
  end;
  Check('order 100 Toeplitz eigenvalues are finite', AllFinite);
  SortAscArray(Actual);
  BeginCategory('Eigenvalues sym Toeplitz order 100 (analytic/NumPy)');
  for i := 0 to 99 do
    CmpRRel(Format('eig[%d]', [i]), Actual[i],
      2 - 2 * Cos((i + 1) * Pi / 101), 1e-9);
end;

procedure TestEigenvaluesOrder1000;
var
  M: T1000RealMatrix;
  E: T1000ComplexVector;
  Actual: TArrayOfDouble;
  i: integer;
  AllFinite: boolean;
begin
  Section('TRealMatrix - opt-in eigenvalue stress order 1000');
  { A diagonal matrix is deliberately the cheapest possible spectral case.
    It establishes the minimum overhead of the current Hessenberg pipeline
    before attempting dense matrices of this order. }
  for i := 0 to 999 do M[i,i] := i + 1;

  E := M.Eigenvalues;
  SetLength(Actual, 1000);
  AllFinite := True;
  for i := 0 to 999 do
  begin
    AllFinite := AllFinite and not IsNan(E[i].Re) and
      not IsInfinite(E[i].Re) and not IsNan(E[i].Im) and
      not IsInfinite(E[i].Im);
    Actual[i] := E[i].Re;
  end;
  Check('order 1000 diagonal eigenvalues are finite', AllFinite);
  SortAscArray(Actual);
  BeginCategory('Eigenvalues diagonal order 1000 (analytic/NumPy)');
  for i := 0 to 999 do
    CmpRRel(Format('eig[%d]', [i]), Actual[i], i + 1, 1e-12);
end;

procedure TestLargeRealProducts;
var
  A5, B5, P5: T5RealMatrix;
  A6, B6, P6: T6RealMatrix;
  A7, B7, P7: T7RealMatrix;
  A8, B8, P8: T8RealMatrix;
  u5, w5: T5RealVector;
  u6, w6: T6RealVector;
  u7, w7: T7RealVector;
  u8, w8: T8RealVector;
  i, j: integer;
begin
  // --- matrix product, order 5 ---
  A5.Assign([
    1.3558487040494454, -0.5777679637967572, -0.33083337758644094, -0.5947293810985288, -0.7805181361650892, 1.1993938145972192, 0.4091665052072475, 0.21204617419477811,
    1.6147056386372305, -0.07320837299860061, 1.8457342583287062, 0.61361494065275, 1.2323497586835863, 0.14875922860718127, 0.4863270871351921, 1.7076922888633321,
    1.0812578613868715, 1.3505324440275208, -1.5496062327209938, 1.2864224332968024, -1.104327978118632, 1.7264675641597758, 1.9394922228907352, -1.5964804996369848,
    -0.5713671999295311
  ]);
  B5.Assign([
    -0.00014634534230806295, -0.8363134325210688, -0.2394306562828339, 1.0711872778573164, -1.0595070780430849, -1.6417304168427687, -1.4546797738795125, 1.7601526917350685,
    1.2420245757001829, 0.9124121862492349, 1.3008406768312168, -1.282658211653449, 1.4971648952131944, 0.20296954845279824, -1.610700000695224, 1.8668500938903985,
    1.7663266448536712, -1.3064396290184623, -1.66703056830623, -0.2433591097412915, 1.3351474293293175, -1.6461050202011287, 0.09872400625694855, 1.7137102824026789,
    -0.5681439961226422
  ]);
  P5 := A5 * B5;
  BeginCategory('Real matrix*matrix order 5 (vs numpy)');
  CmpRRel('AB[0,0]', P5[0,0], -1.6343980809070637, 1e-11);
  CmpRRel('AB[0,1]', P5[0,1], 0.36522750570587, 1e-11);
  CmpRRel('AB[0,2]', P5[0,2], -1.1369815461428536, 1e-11);
  CmpRRel('AB[0,3]', P5[0,3], 0.3214668737406409, 1e-11);
  CmpRRel('AB[0,4]', P5[0,4], -0.8426410025318578, 1e-11);
  CmpRRel('AB[1,0]', P5[1,0], 2.5205910679894585, 1e-11);
  CmpRRel('AB[1,1]', P5[1,1], 1.1023480995492392, 1e-11);
  CmpRRel('AB[1,2]', P5[1,2], -1.36625089388275, 1e-11);
  CmpRRel('AB[1,3]', P5[1,3], -0.9812124334048552, 1e-11);
  CmpRRel('AB[1,4]', P5[1,4], -1.5903409324216322, 1e-11);
  CmpRRel('AB[2,0]', P5[2,0], 1.5224598073622546, 1e-11);
  CmpRRel('AB[2,1]', P5[2,1], -4.5546972042633795, 1e-11);
  CmpRRel('AB[2,2]', P5[2,2], 2.3368286289675773, 1e-11);
  CmpRRel('AB[2,3]', P5[2,3], 3.574818914619263, 1e-11);
  CmpRRel('AB[2,4]', P5[2,4], -3.6931502466854265, 1e-11);
  CmpRRel('AB[3,0]', P5[3,0], -1.1938752299310247, 1e-11);
  CmpRRel('AB[3,1]', P5[3,1], -9.588018673968683, 1e-11);
  CmpRRel('AB[3,2]', P5[3,2], 5.667742582927191, 1e-11);
  CmpRRel('AB[3,3]', P5[3,3], 8.234120361410039, 1e-11);
  CmpRRel('AB[3,4]', P5[3,4], -3.3518242152077, 1e-11);
  CmpRRel('AB[4,0]', P5[4,0], -4.054511543414003, 1e-11);
  CmpRRel('AB[4,1]', P5[4,1], -5.954974378277458, 1e-11);
  CmpRRel('AB[4,2]', P5[4,2], 8.236293906112662, 1e-11);
  CmpRRel('AB[4,3]', P5[4,3], 3.0372548728537407, 1e-11);
  CmpRRel('AB[4,4]', P5[4,4], 0.3344901465749805, 1e-11);
  u5.Assign([1.424954195784542, -1.7977301165340287, 1.910423984247195, -1.6741566519831728, 0.19931017979268129]);
  BeginCategory('Real matrix*vector order 5 (vs numpy)');
  w5 := A5 * u5;
  CmpRRel('Au[0]', w5[0], 3.1787660886850437, 1e-11);
  CmpRRel('Au[1]', w5[1], -1.3392529635340868, 1e-11);
  CmpRRel('Au[2]', w5[2], 3.729166939970804, 1e-11);
  CmpRRel('Au[3]', w5[3], 5.920343712478677, 1e-11);
  CmpRRel('Au[4]', w5[4], 1.5867920875028703, 1e-11);
  w5 := u5 * A5;
  BeginCategory('Real vector*matrix order 5 (vs numpy)');
  CmpRRel('uA[0]', w5[0], 0.22292270044627702, 1e-11);
  CmpRRel('uA[1]', w5[1], -1.8526916141057068, 1e-11);
  CmpRRel('uA[2]', w5[2], -0.37275599820968414, 1e-11);
  CmpRRel('uA[3]', w5[3], -1.1899851176126044, 1e-11);
  CmpRRel('uA[4]', w5[4], -2.3190547379500037, 1e-11);
  // --- matrix product, order 6 ---
  A6.Assign([
    0.6203045512449648, -1.1567275206419465, 0.4868410472493241, 0.8838748568447024, -1.6123830780717783, 1.0754412780834972, 1.9133504776627883, 1.9368413686450974,
    1.4607312165713364, -1.5837222537744298, 0.5528199793058337, 0.5011911169313752, -1.465989277644602, 1.1293172499549264, 0.9603097115639856, 0.01946917325047348,
    -0.45378692629771056, 1.5579969604587753, 0.030729062327908174, -0.8209594812499428, -0.1682618531882496, 0.2301721489158406, -0.07537106382295011, 1.527843602905461,
    0.3757351723598621, -0.5976901242179271, -1.870935934727469, -0.9113991199840847, 0.10150497680087778, -0.7701884114756421, -0.9861588960800529, 1.0756739618683655,
    0.24247412137973345, 0.46923767265645866, 1.579736565003199, -0.21295820474820504
  ]);
  B6.Assign([
    -1.364683497343325, -0.4932600835011254, 1.3472809043693528, 0.5661806262479132, -0.1775783931713235, 0.1679780656861447, 1.310041635965408, -1.7449387659873303,
    -1.574098603048812, 0.602983393160855, 0.2643908574176139, 0.23155923004182766, 0.005626960489368393, 0.25123182639219754, -0.40052930062621916, 1.2903467252811276,
    0.35194487594853197, 1.8500623266125125, -0.2410236256484546, 0.9460013057165715, -1.717348137636654, 0.903537178408949, -1.7808169212511231, -0.6193290195631387,
    0.7813948226290104, 1.9630615486386538, -0.5397561331278222, -1.1872359229454448, 1.0337600943835201, -0.6433996701185856, -1.6779387238397532, -0.8982090762442727,
    -0.8970982208924054, -0.6885820164309169, 1.4084916088240078, -0.6531925030089019
  ]);
  P6 := A6 * B6;
  BeginCategory('Real matrix*matrix order 6 (vs numpy)');
  CmpRRel('AB[0,0]', P6[0,0], -5.636608240209622, 1e-11);
  CmpRRel('AB[0,1]', P6[0,1], -1.4602743873430857, 1e-11);
  CmpRRel('AB[0,2]', P6[0,2], 0.8491299057571224, 1e-11);
  CmpRRel('AB[0,3]', P6[0,3], 2.254274067220145, 1e-11);
  CmpRRel('AB[0,4]', P6[0,4], -1.970726222830958, 1e-11);
  CmpRRel('AB[0,5]', P6[0,5], 0.524560116930537, 1e-11);
  CmpRRel('AB[1,0]', P6[1,0], -0.09283834331718058, 1e-11);
  CmpRRel('AB[1,1]', P6[1,1], -4.81962491811761, 1e-11);
  CmpRRel('AB[1,2]', P6[1,2], 0.9157724460145615, 1e-11);
  CmpRRel('AB[1,3]', P6[1,3], 1.7036440291470156, 1e-11);
  CmpRRel('AB[1,4]', P6[1,4], 4.784136418234125, 1e-11);
  CmpRRel('AB[1,5]', P6[1,5], 3.77012487955544, 1e-11);
  CmpRRel('AB[2,0]', P6[2,0], 0.511964899853903, 1e-11);
  CmpRRel('AB[2,1]', P6[2,1], -3.278015905922289, 1e-11);
  CmpRRel('AB[2,2]', P6[2,2], -5.323565615695015, 1e-11);
  CmpRRel('AB[2,3]', P6[2,3], 0.5736118851179969, 1e-11);
  CmpRRel('AB[2,4]', P6[2,4], 2.587533055103913, 1e-11);
  CmpRRel('AB[2,5]', P6[2,5], 1.0541192093626306, 1e-11);
  CmpRRel('AB[3,0]', P6[3,0], -3.7963727791136823, 1e-11);
  CmpRRel('AB[3,1]', P6[3,1], 0.07255599653119453, 1e-11);
  CmpRRel('AB[3,2]', P6[3,2], -0.3241638414276314, 1e-11);
  CmpRRel('AB[3,3]', P6[3,3], -1.4493361655287875, 1e-11);
  CmpRRel('AB[3,4]', P6[3,4], 1.3824149429344679, 1e-11);
  CmpRRel('AB[3,5]', P6[3,5], -1.588268413419742, 1e-11);
  CmpRRel('AB[4,0]', P6[4,0], 0.28502692411763847, 1e-11);
  CmpRRel('AB[4,1]', P6[4,1], 0.416424834383697, 1e-11);
  CmpRRel('AB[4,2]', P6[4,2], 4.397744975124563, 1e-11);
  CmpRRel('AB[4,3]', P6[4,3], -2.9754747552409024, 1e-11);
  CmpRRel('AB[4,4]', P6[4,4], -0.2400497135307631, 1e-11);
  CmpRRel('AB[4,5]', P6[4,5], -2.534404534747509, 1e-11);
  CmpRRel('AB[5,0]', P6[5,0], 4.234968266474025, 1e-11);
  CmpRRel('AB[5,1]', P6[5,1], 2.406665391291836, 1e-11);
  CmpRRel('AB[5,2]', P6[5,2], -4.58644043666, 1e-11);
  CmpRRel('AB[5,3]', P6[5,3], -0.9017619633786438, 1e-11);
  CmpRRel('AB[5,4]', P6[5,4], 1.0423487863930165, 1e-11);
  CmpRRel('AB[5,5]', P6[5,5], -0.6358903820432925, 1e-11);
  u6.Assign([-0.9978385936001821, -0.9465489884754725, -0.021353216666806674, 1.9213123665494587, -1.4501551569676479, -1.1181019199046665]);
  BeginCategory('Real matrix*vector order 6 (vs numpy)');
  w6 := A6 * u6;
  CmpRRel('Au[0]', w6[0], 3.2994921920642293, 1e-11);
  CmpRRel('Au[1]', w6[1], -8.178604143484787, 1e-11);
  CmpRRel('Au[2]', w6[2], -0.6731707009400056, 1e-11);
  CmpRRel('Au[3]', w6[3], -0.4067438786579649, 1e-11);
  CmpRRel('Au[4]', w6[4], -0.8063607971636277, 1e-11);
  CmpRRel('Au[5]', w6[5], -1.190530302530579, 1e-11);
  w6 := u6 * A6;
  BeginCategory('Real vector*matrix order 6 (vs numpy)');
  CmpRRel('uA[0]', w6[0], -1.7819482089226109, 1e-11);
  CmpRRel('uA[1]', w6[1], -2.6164917416910916, 1e-11);
  CmpRRel('uA[2]', w6[2], 0.22980489139762028, 1e-11);
  CmpRRel('uA[3]', w6[3], 1.855937711148242, 1e-11);
  CmpRRel('uA[4]', w6[4], -0.9629991275376699, 1e-11);
  CmpRRel('uA[5]', w6[5], 2.7096794788926775, 1e-11);
  // --- matrix product, order 7 ---
  A7.Assign([
    0.5373998529336239, -0.4115961189684323, -0.03258735795364753, -0.6215403050438351, -1.7850752548612308, -0.819909640538925, -1.3439304158633534, 0.1310483993327427,
    1.9464828546550974, -0.7091661311084407, -1.2831479751443071, 1.1717018638009127, -0.3125314388970266, -1.7564287205127878, 1.60985552538685, -0.803369737673501,
    0.47392506755082, 1.7545520138442643, 1.256790950595176, 1.6982206245365323, -0.8415766185083586, -1.4643325803172136, -0.41277327975010225, 0.3138237926674887,
    -0.05835103218657878, 1.0872423162774272, 0.28640948281544487, -0.9842500850716114, -1.0532080206330812, 1.4537498409821925, -1.2771549512782552, 0.6304973828873885,
    -0.1587017906070427, 0.24109219828925843, -0.05911871300647942, -0.26856724713175506, 0.7833953476803397, 0.18737528673634163, 0.6160133879262388, -0.839063111693692,
    -0.4739319563843871, 0.9624611424825678, -1.3631708271908192, 0.03161746541379662, -1.4268518214296684, 0.3796095276420699, -1.0288993713732424, 0.6032068789596456,
    -1.6730678529067795
  ]);
  B7.Assign([
    -1.8024253854372367, 0.06290293718821172, 1.0169055089201282, 0.22976391342389846, 1.362762194499298, 0.9373000638141256, -0.8658562963948127, 0.45695925514318425,
    0.7917315106346501, 1.5552022846319442, 1.605279965897381, 0.3391444419013907, 0.3170481862600618, -1.6515137933618185, 0.46742521969403317, 0.9046115818956677,
    0.31919856896240795, -1.23134460840771, -0.654462563976943, -0.40485754927161866, 1.7681891024471965, -1.5879921913740604, 0.8518342905255158, 0.49881004656100725,
    -1.3536422264688421, -0.2965146774963223, -1.363640641799559, 0.08413124081602241, -0.7586094165620247, -1.8805267766446416, -1.6796109079918082, 0.8636206143514089,
    1.5861578655462774, 1.7832153869488154, 1.1677890099393378, 1.0407019718633754, 1.0110444569809731, -0.5626324985336777, 0.20358852768164803, -1.9711481631997545,
    -0.23266582470672414, -0.014537147295520914, -0.03926090870420307, 1.4626555005370454, 1.9593280936598116, 0.2825407298546101, -1.079574705406015, 1.4750451156581112,
    -1.890433054890392
  ]);
  P7 := A7 * B7;
  BeginCategory('Real matrix*matrix order 7 (vs numpy)');
  CmpRRel('AB[0,0]', P7[0,0], 0.36872045239463613, 1e-11);
  CmpRRel('AB[0,1]', P7[0,1], -0.2887883313578879, 1e-11);
  CmpRRel('AB[0,2]', P7[0,2], 0.4122763194066565, 1e-11);
  CmpRRel('AB[0,3]', P7[0,3], -1.7440495060474508, 1e-11);
  CmpRRel('AB[0,4]', P7[0,4], 1.034006204431484, 1e-11);
  CmpRRel('AB[0,5]', P7[0,5], -3.740806732522371, 1e-11);
  CmpRRel('AB[0,6]', P7[0,6], 0.5724724174272394, 1e-11);
  CmpRRel('AB[1,0]', P7[1,0], 1.2142480596369987, 1e-11);
  CmpRRel('AB[1,1]', P7[1,1], -5.27366423797322, 1e-11);
  CmpRRel('AB[1,2]', P7[1,2], -2.9395565172887164, 1e-11);
  CmpRRel('AB[1,3]', P7[1,3], 6.216926712910141, 1e-11);
  CmpRRel('AB[1,4]', P7[1,4], 6.054067455735107, 1e-11);
  CmpRRel('AB[1,5]', P7[1,5], 2.348125094158746, 1e-11);
  CmpRRel('AB[1,6]', P7[1,6], 0.0032497660001442625, 1e-11);
  CmpRRel('AB[2,0]', P7[2,0], -4.986472905671758, 1e-11);
  CmpRRel('AB[2,1]', P7[2,1], -0.4888719763056878, 1e-11);
  CmpRRel('AB[2,2]', P7[2,2], -3.301185738365714, 1e-11);
  CmpRRel('AB[2,3]', P7[2,3], -2.684998273258667, 1e-11);
  CmpRRel('AB[2,4]', P7[2,4], 0.6455444447749948, 1e-11);
  CmpRRel('AB[2,5]', P7[2,5], -0.7255922286105386, 1e-11);
  CmpRRel('AB[2,6]', P7[2,6], 3.952398072204113, 1e-11);
  CmpRRel('AB[3,0]', P7[3,0], 2.2019969907784005, 1e-11);
  CmpRRel('AB[3,1]', P7[3,1], -3.379367574498713, 1e-11);
  CmpRRel('AB[3,2]', P7[3,2], -5.975723970912138, 1e-11);
  CmpRRel('AB[3,3]', P7[3,3], -0.5873224499565441, 1e-11);
  CmpRRel('AB[3,4]', P7[3,4], -0.10105690933774401, 1e-11);
  CmpRRel('AB[3,5]', P7[3,5], -1.1305358846459896, 1e-11);
  CmpRRel('AB[3,6]', P7[3,6], 5.625757961614064, 1e-11);
  CmpRRel('AB[4,0]', P7[4,0], 1.338052815977723, 1e-11);
  CmpRRel('AB[4,1]', P7[4,1], 0.9222073964221856, 1e-11);
  CmpRRel('AB[4,2]', P7[4,2], 1.1117724293479176, 1e-11);
  CmpRRel('AB[4,3]', P7[4,3], 2.7061583043499544, 1e-11);
  CmpRRel('AB[4,4]', P7[4,4], -0.9564739892071221, 1e-11);
  CmpRRel('AB[4,5]', P7[4,5], -1.2952653857848875, 1e-11);
  CmpRRel('AB[4,6]', P7[4,6], -3.771243088730994, 1e-11);
  CmpRRel('AB[5,0]', P7[5,0], 0.056923820281153566, 1e-11);
  CmpRRel('AB[5,1]', P7[5,1], 3.804051750618531, 1e-11);
  CmpRRel('AB[5,2]', P7[5,2], 4.874040542629347, 1e-11);
  CmpRRel('AB[5,3]', P7[5,3], -0.4179083233171089, 1e-11);
  CmpRRel('AB[5,4]', P7[5,4], -1.841341388086746, 1e-11);
  CmpRRel('AB[5,5]', P7[5,5], -0.8855240894960171, 1e-11);
  CmpRRel('AB[5,6]', P7[5,6], -3.470534089274472, 1e-11);
  CmpRRel('AB[6,0]', P7[6,0], 2.6756756097140713, 1e-11);
  CmpRRel('AB[6,1]', P7[6,1], -0.9304772840242225, 1e-11);
  CmpRRel('AB[6,2]', P7[6,2], -3.492462415544066, 1e-11);
  CmpRRel('AB[6,3]', P7[6,3], -0.25784428808435716, 1e-11);
  CmpRRel('AB[6,4]', P7[6,4], -2.0404987032971134, 1e-11);
  CmpRRel('AB[6,5]', P7[6,5], -5.6506004727726165, 1e-11);
  CmpRRel('AB[6,6]', P7[6,6], 0.5896030294073081, 1e-11);
  u7.Assign([-0.701614436224661, -1.66823687693759, -1.8471983871387563, -1.2278061957446877, -0.32865101494560234, 1.1786932958954432, -0.28409487131106514]);
  BeginCategory('Real matrix*vector order 7 (vs numpy)');
  w7 := A7 * u7;
  CmpRRel('Au[0]', w7[0], 1.13496721798212, 1e-11);
  CmpRRel('Au[1]', w7[1], -0.7081796869571625, 1e-11);
  CmpRRel('Au[2]', w7[2], -0.9912470636650819, 1e-11);
  CmpRRel('Au[3]', w7[3], 1.4678354878592745, 1e-11);
  CmpRRel('Au[4]', w7[4], 0.2519034156092277, 1e-11);
  CmpRRel('Au[5]', w7[5], -2.7772144831983034, 1e-11);
  CmpRRel('Au[6]', w7[6], 4.5977210861797175, 1e-11);
  w7 := u7 * A7;
  BeginCategory('Real vector*matrix order 7 (vs numpy)');
  CmpRRel('uA[0]', w7[0], -1.3546238705860985, 1e-11);
  CmpRRel('uA[1]', w7[1], -0.5309997016157053, 1e-11);
  CmpRRel('uA[2]', w7[2], 0.991129985017251, 1e-11);
  CmpRRel('uA[3]', w7[3], -0.1816533440395548, 1e-11);
  CmpRRel('uA[4]', w7[4], -5.003242284049874, 1e-11);
  CmpRRel('uA[5]', w7[5], -3.2011924204143294, 1e-11);
  CmpRRel('uA[6]', w7[6], 8.26527338690053, 1e-11);
  // --- matrix product, order 8 ---
  A8.Assign([
    0.7867892889901378, -1.4651139088060887, 0.3820827243948717, 1.6767096642265646, 0.7054678854683609, 0.16364307982053639, -1.0024075528722212, 1.9933619139561802,
    0.1353146904349316, 1.4385096719506612, 0.23354300810601147, -1.470912362310251, 0.05814087372759902, 0.44307542419613943, -0.6073770901995275, 0.22684685507142532,
    1.3741257027591542, 1.93165910059616, -1.5912755204527147, 1.6394475758430431, -0.9039176107131439, 1.9091613408443902, 0.38346121459227733, -0.1255524906811556,
    0.8007726000409501, 0.7603745562244182, -1.8433239251654507, -1.4448256979585237, -1.7285845520711973, -0.3098761433598578, 1.0105331399769253, -1.7933108415423211,
    -0.6143498971577253, 0.17162384808693165, 0.24817072050140343, -1.6616690413347603, -1.2847564651557306, 1.143947758061659, 0.6423236249869304, -0.2469304196108859,
    1.9942179945758616, 0.6444504516696088, 1.2001997734902172, 1.297327169384856, -0.7380989104806943, 0.503611478947231, 1.230465800427114, -1.1914734782108245,
    -0.21038189362673654, -0.67637492528833, -0.38226175878112967, -0.23662627171695627, -1.0953140015774832, 0.7085627325982204, 1.7047738933184728, 0.6562982541872655,
    -1.5534668374955785, 1.804626878061788, 0.33817571635233623, 0.18679957236241496, -1.1695559241999005, 0.4683967580204045, 0.8573374097408912, 0.5615451122151369
  ]);
  B8.Assign([
    -0.30162193701584483, 1.1781078027639786, 0.8633567243840115, -0.08654728576283688, -1.3774519150125544, -1.1327618933945391, -0.3638953049063396, -0.9628284933136468,
    -0.298741355779351, 1.9243745945614652, 0.08153293020065888, -0.802684546117018, -1.274396674383023, 1.2966798426727508, 1.3609109939840254, -1.7848452042049634,
    1.2443993604772978, 1.2759548699563283, 1.5342603167479747, 1.0618913701115473, 1.0610128183808625, -1.0846912347707058, 1.2815711276150061, -1.2512045273595356,
    -1.9734416432240987, -1.508381516932424, 0.031029730445019332, 1.2531166940641176, -1.907458534988283, 1.592256270387546, -1.810090879892857, 1.9404127073079454,
    0.7773260600549405, 1.8562929796161036, -0.26602863674785393, 1.1278091674149353, 1.9976830860799337, 0.1643581608837663, -0.2958010479324371, -1.6194069683260945,
    -0.8421146863111826, -0.4285485204747159, 0.4619969445605854, -1.1699231165442678, -1.888420833448683, 1.6406988294678393, -0.44847355744148665, -0.649669065091715,
    0.7859279799403169, -0.6072942902336274, -0.7986247814007403, -1.559571123756128, 0.5509920538989341, -1.419901868525455, 1.044594213859761, -0.5998536476962095,
    1.6856423107738414, 0.5330017049653626, 1.7469668016375524, 1.6817586660236543, -0.7894143099374369, 1.7382416880658678, 1.9020901119013418, 1.0940948556750367
  ]);
  P8 := A8 * B8;
  BeginCategory('Real matrix*matrix order 8 (vs numpy)');
  CmpRRel('AB[0,0]', P8[0,0], 0.34979939984501984, 1e-11);
  CmpRRel('AB[0,1]', P8[0,1], -1.0234551721236351, 1e-11);
  CmpRRel('AB[0,2]', P8[0,2], 5.368879547081963, 1e-11);
  CmpRRel('AB[0,3]', P8[0,3], 9.134635908130317, 1e-11);
  CmpRRel('AB[0,4]', P8[0,4], -3.0351203660897403, 1e-11);
  CmpRRel('AB[0,5]', P8[0,5], 4.736984646227267, 1e-11);
  CmpRRel('AB[0,6]', P8[0,6], -2.363152115291873, 1e-11);
  CmpRRel('AB[0,7]', P8[0,7], 6.16637487870854, 1e-11);
  CmpRRel('AB[1,0]', P8[1,0], 2.299926372366848, 1e-11);
  CmpRRel('AB[1,1]', P8[1,1], 5.852147695883406, 1e-11);
  CmpRRel('AB[1,2]', P8[1,2], 1.6173771876168352, 1e-11);
  CmpRRel('AB[1,3]', P8[1,3], -1.8856510694196724, 1e-11);
  CmpRRel('AB[1,4]', P8[1,4], -0.2004268822819451, 1e-11);
  CmpRRel('AB[1,5]', P8[1,5], 1.1098554667416813, 1e-11);
  CmpRRel('AB[1,6]', P8[1,6], 4.451345098173746, 1e-11);
  CmpRRel('AB[1,7]', P8[1,7], -5.613665829355486, 1e-11);
  CmpRRel('AB[2,0]', P8[2,0], -8.42770448418885, 1e-11);
  CmpRRel('AB[2,1]', P8[2,1], -1.9631019408336565, 1e-11);
  CmpRRel('AB[2,2]', P8[2,2], -0.44978776134814796, 1e-11);
  CmpRRel('AB[2,3]', P8[2,3], -5.3669849550112705, 1e-11);
  CmpRRel('AB[2,4]', P8[2,4], -14.270677968144721, 1e-11);
  CmpRRel('AB[2,5]', P8[2,5], 7.505724150239136, 1e-11);
  CmpRRel('AB[2,6]', P8[2,6], -3.3051830399544504, 1e-11);
  CmpRRel('AB[2,7]', P8[2,7], 0.2575566544000861, 1e-11);
  CmpRRel('AB[3,0]', P8[3,0], -3.2226347522177883, 1e-11);
  CmpRRel('AB[3,1]', P8[3,1], -2.411498982525289, 1e-11);
  CmpRRel('AB[3,2]', P8[3,2], -5.742823479411313, 1e-11);
  CmpRRel('AB[3,3]', P8[3,3], -10.626487165606768, 1e-11);
  CmpRRel('AB[3,4]', P8[3,4], -2.167416347855057, 1e-11);
  CmpRRel('AB[3,5]', P8[3,5], -5.566803761075354, 1e-11);
  CmpRRel('AB[3,6]', P8[3,6], -0.7088335687738242, 1e-11);
  CmpRRel('AB[3,7]', P8[3,7], -2.192965802842563, 1e-11);
  CmpRRel('AB[4,0]', P8[4,0], 1.8486344915466382, 1e-11);
  CmpRRel('AB[4,1]', P8[4,1], -0.9672316563767068, 1e-11);
  CmpRRel('AB[4,2]', P8[4,2], -0.2612852038348802, 1e-11);
  CmpRRel('AB[4,3]', P8[4,3], -6.1076421600831425, 1e-11);
  CmpRRel('AB[4,4]', P8[4,4], -0.11754772677548916, 1e-11);
  CmpRRel('AB[4,5]', P8[4,5], -1.6720859454899848, 1e-11);
  CmpRRel('AB[4,6]', P8[4,6], 3.85122985283428, 1e-11);
  CmpRRel('AB[4,7]', P8[4,7], -2.56775383800731, 1e-11);
  CmpRRel('AB[5,0]', P8[5,0], -3.8998782731469883, 1e-11);
  CmpRRel('AB[5,1]', P8[5,1], 0.19584224844071696, 1e-11);
  CmpRRel('AB[5,2]', P8[5,2], 1.0208173653057788, 1e-11);
  CmpRRel('AB[5,3]', P8[5,3], -3.1340916645555827, 1e-11);
  CmpRRel('AB[5,4]', P8[5,4], -5.576370371506685, 1e-11);
  CmpRRel('AB[5,5]', P8[5,5], -3.772744469872997, 1e-11);
  CmpRRel('AB[5,6]', P8[5,6], -1.6472640272492407, 1e-11);
  CmpRRel('AB[5,7]', P8[5,7], -3.2282621520694055, 1e-11);
  CmpRRel('AB[6,0]', P8[6,0], 1.2548052141023445, 1e-11);
  CmpRRel('AB[6,1]', P8[6,1], -4.702645896527607, 1e-11);
  CmpRRel('AB[6,2]', P8[6,2], -0.4268176563710015, 1e-11);
  CmpRRel('AB[6,3]', P8[6,3], -3.7605670649816045, 1e-11);
  CmpRRel('AB[6,4]', P8[6,4], -1.9073981722422306, 1e-11);
  CmpRRel('AB[6,5]', P8[6,5], -0.89815522550618, 1e-11);
  CmpRRel('AB[6,6]', P8[6,6], 2.1298490793510174, 1e-11);
  CmpRRel('AB[6,7]', P8[6,7], 2.437786785911591, 1e-11);
  CmpRRel('AB[7,0]', P8[7,0], 0.2984301581098659, 1e-11);
  CmpRRel('AB[7,1]', P8[7,1], -0.8007621564445552, 1e-11);
  CmpRRel('AB[7,2]', P8[7,2], 0.1544294054762005, 1e-11);
  CmpRRel('AB[7,3]', P8[7,3], -2.9806296276288564, 1e-11);
  CmpRRel('AB[7,4]', P8[7,4], -3.3493262215520767, 1e-11);
  CmpRRel('AB[7,5]', P8[7,5], 4.365385973147889, 1e-11);
  CmpRRel('AB[7,6]', P8[7,6], 5.216079289224521, 1e-11);
  CmpRRel('AB[7,7]', P8[7,7], -0.09612544195492402, 1e-11);
  u8.Assign([0.9070925915762484, -1.7460064414572276, 0.3285849551813822, 1.3473516677568789, -1.7461546500740175, -1.9228393747001915, -1.4973236931843341, -1.6694871356591952]);
  BeginCategory('Real matrix*vector order 8 (vs numpy)');
  w8 := A8 * u8;
  CmpRRel('Au[0]', w8[0], 2.282974375844187, 1e-11);
  CmpRRel('Au[1]', w8[1], -4.716765332809426, 1e-11);
  CmpRRel('Au[2]', w8[2], -2.8973747111146784, 1e-11);
  CmpRRel('Au[3]', w8[3], 1.9414113671841773, 1e-11);
  CmpRRel('Au[4]', w8[4], -3.51999951304225, 1e-11);
  CmpRRel('Au[5]', w8[5], 3.2932641543298766, 1e-11);
  CmpRRel('Au[6]', w8[6], -2.5524496644750068, 1e-11);
  CmpRRel('Au[7]', w8[7], -5.276854416448588, 1e-11);
  w8 := u8 * A8;
  BeginCategory('Real vector*matrix order 8 (vs numpy)');
  CmpRRel('uA[0]', w8[0], 2.154561487469883, 1e-11);
  CmpRRel('uA[1]', w8[1], -5.720340720766944, 1e-11);
  CmpRRel('uA[2]', w8[2], -5.801004207409791, 1e-11);
  CmpRRel('uA[3]', w8[3], 3.1305888688403427, 1e-11);
  CmpRRel('uA[4]', w8[4], 5.167612645031397, 1e-11);
  CmpRRel('uA[5]', w8[5], -5.224167372246652, 1e-11);
  CmpRRel('uA[6]', w8[6], -5.832745648962656, 1e-11);
  CmpRRel('uA[7]', w8[7], -0.24337970684357413, 1e-11);
end;

{ Entry point: runs every test procedure in this unit. }
procedure Run;
var
  StressOrder: integer;
begin
  TestTRMatrix;
  TestSolveLinear;
  TestEigenvectors;
  TestComplexEigenvalues;
  TestExceptions;
  TestRealMatrices;
  TestLargeRealInverse;
  TestLargeRealEigen;
  TestEigenvaluesBeyondOrder10;
  StressOrder := StrToIntDef(
    GetEnvironmentVariable('ADIMMATH_EIGEN_STRESS_ORDER'), 0);
  if StressOrder >= 100 then TestEigenvaluesOrder100;
  if StressOrder >= 1000 then TestEigenvaluesOrder1000;
  TestLargeRealProducts;
end;

initialization
  RegisterSuite('Real matrix (TRealMatrix)', @Run);

end.

