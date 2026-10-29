{ SpecLapackGe - The LU routines of the internal LAPACK layer (xGETRF with
  xGETRF2, xGETRS, xGETRI with xTRTRI, xGECON with xLACN2 and xLATRS),
  checked as LAPACK checks them in xCHKGE (TESTING/LIN/dchkge.f,
  zchkge.f) with the input of TESTING/dtest.in and ztest.in.

  The 11 matrix types of xCHKGE (xLATB4 for path GE): diagonal, upper
  triangular and lower triangular with condition 2; general with
  condition 2; the same with the first, the last or the columns from the
  middle on set to zero (exactly singular, xGETRF must return INFO = the
  first zero column); condition sqrt(0.1/eps) and 0.1/eps; condition 2
  scaled near the underflow and the overflow threshold. The singular
  values decrease geometrically (xLATMS mode 3) and the matrices are
  U*diag(s)*V^T with random orthogonal (unitary) U and V; the
  triangular types are the triangular factor of the QR factorization of
  such a matrix, which has the same singular values. The generators
  follow the description of xCHKGE and xLATMS; they do not reproduce
  LAPACK's random streams.

  For every matrix, as xCHKGE:
    (1) |L*U - P*A|_1 / (n |A|_1 eps)                 xGETRF  (xGET01)
    (2) |I - inv(A)*A|_1 / (n |A|_1 |inv(A)|_1 eps)   xGETRI  (xGET03)
  and for square nonsingular matrices, for TRANS = 'N', 'T', 'C' and the
  numbers of right-hand sides of dtest.in:
    (3) |B - op(A)*X|_1 / (|op(A)|_1 |X|_1 eps)       xGETRS  (xGET02)
    (4) |X - XACT|_inf / (|XACT|_inf rcond eps)               (xGET04)
  and for NORM = 'O' and 'I':
    (8) max(rcond, rcond_est)/min(rcond, rcond_est) - (1 - eps),
        with rcond = 1/(|A| |inv(A)|) from xGETRI             (xGET06)
  with eps = 2^-53 and ^T the conjugate transpose for TRANS = 'C'.
  Tests (5) to (7) check the iterative refinement xGERFS, which the layer
  does not provide. Threshold 30 (dtest.in). The orders M and N are those
  of dtest.in (0, 1, 2, 3, 5, 10, 50, also rectangular for test (1)), the
  numbers of right-hand sides 1, 2, 15, and the block sizes of xGETRF and
  xGETRI 1, 3 and 20 (LapackBlockSize, as XLAENV in the test program;
  dtest.in lists 1 3 3 3 20, whose repetitions differ only in the
  crossover NX that xGETRF does not use). Tests (2) to (8) run with the
  first block size, as in xCHKGE. The residuals are accumulated in
  double-double. --extended adds the orders 64, 65 and 100, where the
  default block size 64 is used. }
unit SpecLapackGe;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}

interface

implementation

uses
  SysUtils, Math, ADimMath, ADimLapack, TestRunner, TestDoubleDouble,
  TestGenerators, TestMeasures;

const
  TypeCount = 11;
  Eps = 1.1102230246251565E-16; { DLAMCH('Epsilon') = 2^-53 }
  PrecisionEps = 2.2204460492503131E-16; { DLAMCH('Precision') = 2^-52 }
  Orders: array[0..6] of Integer = (0, 1, 2, 3, 5, 10, 50);
  ExtendedOrders: array[0..2] of Integer = (64, 65, 100);
  RightHandSides: array[0..2] of Integer = (1, 2, 15);
  BlockSizes: array[0..2] of Integer = (1, 3, 20);
  Transposes: array[0..2] of Char = ('N', 'T', 'C');

type
  { A matrix stored by rows, real or complex, kept as complex numbers
    (with zero imaginary parts for real matrices). }
  TMat = record
    M, N: Integer;
    Data: TArrayOfComplex;
  end;

  TResults = record
    Labels: array[1..8] of array of string;
    Ratios: array[1..8] of array of Double;
    InfoLabels: array of string;
    InfoOk: array of Boolean;
  end;

var
  Results: TResults;

procedure AddRatio(ATest: Integer; const ALabel: string; ARatio: Double);
var
  K: Integer;
begin
  K := Length(Results.Ratios[ATest]);
  SetLength(Results.Ratios[ATest], K + 1);
  SetLength(Results.Labels[ATest], K + 1);
  Results.Ratios[ATest][K] := ARatio;
  Results.Labels[ATest][K] := ALabel;
end;

procedure AddInfo(const ALabel: string; AOk: Boolean);
var
  K: Integer;
begin
  K := Length(Results.InfoOk);
  SetLength(Results.InfoOk, K + 1);
  SetLength(Results.InfoLabels, K + 1);
  Results.InfoOk[K] := AOk;
  Results.InfoLabels[K] := ALabel;
end;

function NewMat(M, N: Integer): TMat;
begin
  result.M := M;
  result.N := N;
  result.Data := nil;
  SetLength(result.Data, M * N);
end;

function Abs1(const Z: TComplex): Double; inline;
begin
  result := System.Abs(Z.Re) + System.Abs(Z.Im);
end;

{ xLANGE with NORM = '1' or 'I' (moduli of the entries). }
function NormOf(const A: TMat; ANorm: Char): Double;
var
  I, J: Integer;
  LSum: Double;
begin
  result := 0;
  if ANorm = '1' then
    for J := 0 to A.N - 1 do
    begin
      LSum := 0;
      for I := 0 to A.M - 1 do LSum := LSum + A.Data[I * A.N + J].Norm;
      result := Max(result, LSum);
    end
  else
    for I := 0 to A.M - 1 do
    begin
      LSum := 0;
      for J := 0 to A.N - 1 do LSum := LSum + A.Data[I * A.N + J].Norm;
      result := Max(result, LSum);
    end;
end;

{ Householder QR of the M x N matrix A in place: on exit the upper
  trapezoid holds R (the rest is set to zero). }
procedure TriangularFactor(var A: TMat);
var
  I, J, K: Integer;
  LNorm, LScale: Double;
  LAlpha, LDot: TComplex;
  V: TArrayOfComplex;
begin
  V := nil;
  SetLength(V, A.M);
  for K := 0 to Min(A.M, A.N) - 1 do
  begin
    LNorm := 0;
    for I := K to A.M - 1 do LNorm := Hypot(LNorm, A.Data[I * A.N + K].Norm);
    if LNorm = 0 then Continue;
    if A.Data[K * A.N + K].Norm = 0 then
      LAlpha := -LNorm
    else
      LAlpha := -LNorm * (A.Data[K * A.N + K] / A.Data[K * A.N + K].Norm);
    for I := K to A.M - 1 do V[I] := A.Data[I * A.N + K];
    V[K] := V[K] - LAlpha;
    LScale := 0;
    for I := K to A.M - 1 do LScale := Hypot(LScale, V[I].Norm);
    for I := K to A.M - 1 do V[I] := V[I] / LScale;
    { A := (I - 2 v v^H) A on rows K.. }
    for J := K to A.N - 1 do
    begin
      LDot := 0;
      for I := K to A.M - 1 do LDot := LDot + V[I].Conjugate * A.Data[I * A.N + J];
      for I := K to A.M - 1 do
        A.Data[I * A.N + J] := A.Data[I * A.N + J] - 2 * V[I] * LDot;
    end;
    for I := K + 1 to A.M - 1 do A.Data[I * A.N + K] := 0;
  end;
end;

{ U*diag(s)*V^H (M x N) with s the singular values of xLATMS mode 3:
  s(i) = cond^(-(i-1)/(min(M,N)-1)), random signs (phases), scaled to
  largest value ANorm. }
function SigmaMatrix(M, N: Integer; ACond, ANorm: Double;
  AComplex: Boolean): TMat;
var
  I, J, K, P: Integer;
  S: TArrayOfReal;
  Sign: TArrayOfComplex;
  U, V: TComplexMatrix;
  LSum: TDDComplex;
begin
  P := Min(M, N);
  S := nil;
  Sign := nil;
  SetLength(S, P);
  SetLength(Sign, P);
  for I := 0 to P - 1 do
  begin
    if P = 1 then S[I] := 1 else S[I] := Power(ACond, -I / (P - 1));
    S[I] := S[I] * ANorm;
    if AComplex then
      Sign[I] := RandomComplex / RandomComplex.Norm
    else if RandomUniform < 0 then
      Sign[I] := -1
    else
      Sign[I] := 1;
    if Sign[I].Norm = 0 then Sign[I] := 1;
  end;
  if AComplex then
  begin
    U := RandomUnitary(Max(M, 1));
    V := RandomUnitary(Max(N, 1));
  end else
  begin
    U := RealToComplexMatrix(RandomOrthogonal(Max(M, 1)));
    V := RealToComplexMatrix(RandomOrthogonal(Max(N, 1)));
  end;
  result := NewMat(M, N);
  for I := 0 to M - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := DDComplex(0, 0);
      for K := 0 to P - 1 do
        LSum := LSum + TDDComplex(U[I, K] * (S[K] * Sign[K])) *
          TDDComplex(V[J, K].Conjugate);
      result.Data[I * N + J] := LSum.ToComplex;
    end;
end;

{ A matrix of type AType (1..11) of xCHKGE, and the 1-based index IZERO
  of its first zero column (0 for the nonsingular types). }
function TypeMatrix(AType, M, N: Integer; AComplex: Boolean;
  out IZERO: Integer): TMat;
var
  BADC1, BADC2, SMALL, LARGE, CNDNUM, ANORM: Double;
  I, J, P: Integer;
  T: TMat;
begin
  BADC2 := 0.1 / PrecisionEps;
  BADC1 := Sqrt(BADC2);
  SMALL := 0.25 * (SafeMinimum / PrecisionEps);
  LARGE := 1 / SMALL;
  case AType of
    8: CNDNUM := BADC1;
    9: CNDNUM := BADC2;
  else
    CNDNUM := 2;
  end;
  case AType of
    10: ANORM := SMALL;
    11: ANORM := LARGE;
  else
    ANORM := 1;
  end;
  P := Min(M, N);
  case AType of
    1:
      begin
        { The singular values themselves, with random signs (phases). }
        result := NewMat(M, N);
        for I := 0 to P - 1 do
        begin
          if P = 1 then result.Data[I * N + I] := ANORM
          else result.Data[I * N + I] := ANORM * Power(CNDNUM, -I / (P - 1));
          if AComplex then
            result.Data[I * N + I] := result.Data[I * N + I] *
              (RandomComplex / RandomComplex.Norm)
          else if RandomUniform < 0 then
            result.Data[I * N + I] := -result.Data[I * N + I];
        end;
      end;
    2:
      begin
        result := SigmaMatrix(M, N, CNDNUM, ANORM, AComplex);
        TriangularFactor(result);
      end;
    3:
      begin
        T := SigmaMatrix(N, M, CNDNUM, ANORM, AComplex);
        TriangularFactor(T);
        result := NewMat(M, N);
        for I := 0 to M - 1 do
          for J := 0 to N - 1 do
            result.Data[I * N + J] := T.Data[J * M + I].Conjugate;
      end;
  else
    result := SigmaMatrix(M, N, CNDNUM, ANORM, AComplex);
  end;
  IZERO := 0;
  if (AType >= 5) and (AType <= 7) then
  begin
    case AType of
      5: IZERO := 1;
      6: IZERO := P;
    else
      IZERO := P div 2 + 1;
    end;
    for I := 0 to M - 1 do
      if AType < 7 then
        result.Data[I * N + IZERO - 1] := 0
      else
        for J := IZERO - 1 to N - 1 do result.Data[I * N + J] := 0;
  end;
end;

{ Real part of a complex matrix, for the real routines. }
function RealPart(const A: TArrayOfComplex): TArrayOfReal;
var
  I: Integer;
begin
  result := nil;
  SetLength(result, Length(A));
  for I := 0 to High(A) do result[I] := A[I].Re;
end;

function ToComplex(const A: TArrayOfReal): TArrayOfComplex;
var
  I: Integer;
begin
  result := nil;
  SetLength(result, Length(A));
  for I := 0 to High(A) do result[I] := A[I];
end;

{ xGET01, test (1). }
function LUResidual(const A, AFAC: TMat; const IPIV: array of longint): Double;
var
  M, N, P, I, J, K: Integer;
  LU: TMat;
  LSum: TDDComplex;
  LTemp: TComplex;
  ANORM, RESID: Double;
begin
  M := A.M;
  N := A.N;
  if (M <= 0) or (N <= 0) then Exit(0);
  P := Min(M, N);
  ANORM := NormOf(A, '1');
  LU := NewMat(M, N);
  for I := 0 to M - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := DDComplex(0, 0);
      for K := 0 to Min(Min(I, J), P - 1) do
        if K = I then
          LSum := LSum + TDDComplex(AFAC.Data[K * N + J])
        else
          LSum := LSum + TDDComplex(AFAC.Data[I * N + K]) *
            TDDComplex(AFAC.Data[K * N + J]);
      LU.Data[I * N + J] := LSum.ToComplex;
    end;
  { P^T*(L*U): undo the row interchanges in reverse order. }
  for K := P - 1 downto 0 do
    if IPIV[K] <> K then
      for J := 0 to N - 1 do
      begin
        LTemp := LU.Data[K * N + J];
        LU.Data[K * N + J] := LU.Data[IPIV[K] * N + J];
        LU.Data[IPIV[K] * N + J] := LTemp;
      end;
  for I := 0 to M * N - 1 do
    LU.Data[I] := (TDDComplex(LU.Data[I]) - TDDComplex(A.Data[I])).ToComplex;
  RESID := NormOf(LU, '1');
  if ANORM <= 0 then
  begin
    if RESID <> 0 then result := 1 / Eps else result := 0;
  end else
    result := ((RESID / N) / ANORM) / Eps;
end;

{ xGET03, test (2); RCOND receives 1/(|A|_1 |AINV|_1). }
function InverseResidual(const A, AINV: TMat; out RCOND: Double): Double;
var
  N, I, J, K: Integer;
  W: TMat;
  LSum: TDDComplex;
  ANORM, AINVNM: Double;
begin
  N := A.N;
  if N <= 0 then
  begin
    RCOND := 1;
    Exit(0);
  end;
  ANORM := NormOf(A, '1');
  AINVNM := NormOf(AINV, '1');
  if (ANORM <= 0) or (AINVNM <= 0) then
  begin
    RCOND := 0;
    Exit(1 / Eps);
  end;
  RCOND := (1 / ANORM) / AINVNM;
  W := NewMat(N, N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      if I = J then LSum := DDComplex(-1, 0) else LSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
        LSum := LSum + TDDComplex(AINV.Data[I * N + K]) *
          TDDComplex(A.Data[K * N + J]);
      W.Data[I * N + J] := LSum.ToComplex;
    end;
  result := ((NormOf(W, '1') * RCOND) / Eps) / N;
end;

{ op(A)(i, k). }
function OpEntry(const A: TMat; ATrans: Char; I, K: Integer): TComplex;
begin
  case ATrans of
    'N': result := A.Data[I * A.N + K];
    'T': result := A.Data[K * A.N + I];
  else
    result := A.Data[K * A.N + I].Conjugate;
  end;
end;

{ op(A)*X in double-double, rounded once (B of xLARHS). }
function OpProduct(const A: TMat; ATrans: Char; const X: TMat): TMat;
var
  I, J, K: Integer;
  LSum: TDDComplex;
begin
  result := NewMat(A.N, X.N);
  for I := 0 to A.N - 1 do
    for J := 0 to X.N - 1 do
    begin
      LSum := DDComplex(0, 0);
      for K := 0 to A.N - 1 do
        LSum := LSum + TDDComplex(OpEntry(A, ATrans, I, K)) *
          TDDComplex(X.Data[K * X.N + J]);
      result.Data[I * X.N + J] := LSum.ToComplex;
    end;
end;

{ xGET02, test (3). The norm of A is the 1-norm for TRANS = 'N' and the
  infinity norm otherwise (the 1-norm of op(A)); the column norms are
  sums of |re| + |im| (DZASUM). }
function SolveResidual(const A: TMat; ATrans: Char; const X, B: TMat): Double;
var
  N, J, I, K: Integer;
  ANORM, BNORM, XNORM: Double;
  LSum: TDDComplex;
begin
  N := A.N;
  if (N <= 0) or (X.N = 0) then Exit(0);
  if ATrans = 'N' then ANORM := NormOf(A, '1') else ANORM := NormOf(A, 'I');
  if ANORM <= 0 then Exit(1 / Eps);
  result := 0;
  for J := 0 to X.N - 1 do
  begin
    BNORM := 0;
    XNORM := 0;
    for I := 0 to N - 1 do
    begin
      LSum := TDDComplex(B.Data[I * B.N + J]);
      for K := 0 to N - 1 do
        LSum := LSum - TDDComplex(OpEntry(A, ATrans, I, K)) *
          TDDComplex(X.Data[K * X.N + J]);
      BNORM := BNORM + Abs1(LSum.ToComplex);
      XNORM := XNORM + Abs1(X.Data[I * X.N + J]);
    end;
    if XNORM <= 0 then Exit(1 / Eps);
    result := Max(result, ((BNORM / ANORM) / XNORM) / Eps);
  end;
end;

{ xGET04, test (4). }
function ForwardError(const X, XACT: TMat; RCOND: Double): Double;
var
  N, I, J: Integer;
  XNORM, DIFFNM: Double;
begin
  N := X.M;
  if (N <= 0) or (X.N <= 0) then Exit(0);
  if RCOND < 0 then Exit(1 / Eps);
  result := 0;
  for J := 0 to X.N - 1 do
  begin
    XNORM := 0;
    DIFFNM := 0;
    for I := 0 to N - 1 do
    begin
      XNORM := Max(XNORM, Abs1(XACT.Data[I * X.N + J]));
      DIFFNM := Max(DIFFNM, Abs1(X.Data[I * X.N + J] - XACT.Data[I * X.N + J]));
    end;
    if XNORM <= 0 then
    begin
      if DIFFNM > 0 then result := 1 / Eps;
    end else
      result := Max(result, (DIFFNM / XNORM) * RCOND);
  end;
  if result * Eps < 1 then result := result / Eps;
end;

{ xGET06, test (8). }
function ConditionRatio(RCOND, RCONDC: Double): Double;
begin
  if RCOND > 0 then
  begin
    if RCONDC > 0 then
      result := Max(RCOND, RCONDC) / Min(RCOND, RCONDC) - (1 - Eps)
    else
      result := RCOND / Eps;
  end else if RCONDC > 0 then
    result := RCONDC / Eps
  else
    result := 0;
end;

{ The routines under test on the real or complex copy of A. }
procedure Factor(AComplex: Boolean; var AFAC: TMat; var IPIV: array of longint;
  out INFO: longint);
var
  R: TArrayOfReal;
begin
  if AComplex then
    ZGETRF(AFAC.M, AFAC.N, AFAC.Data, 0, AFAC.N, IPIV, INFO)
  else
  begin
    R := RealPart(AFAC.Data);
    DGETRF(AFAC.M, AFAC.N, R, 0, AFAC.N, IPIV, INFO);
    AFAC.Data := ToComplex(R);
  end;
end;

procedure Invert(AComplex: Boolean; var AINV: TMat; const IPIV: array of longint;
  out INFO: longint);
var
  R: TArrayOfReal;
begin
  if AComplex then
    ZGETRI(AINV.N, AINV.Data, 0, AINV.N, IPIV, INFO)
  else
  begin
    R := RealPart(AINV.Data);
    DGETRI(AINV.N, R, 0, AINV.N, IPIV, INFO);
    AINV.Data := ToComplex(R);
  end;
end;

procedure Solve(AComplex: Boolean; ATrans: Char; const AFAC: TMat;
  const IPIV: array of longint; var X: TMat);
var
  R, B: TArrayOfReal;
begin
  if AComplex then
    ZGETRS(ATrans, AFAC.N, X.N, AFAC.Data, 0, AFAC.N, IPIV, X.Data, 0, X.N)
  else
  begin
    R := RealPart(AFAC.Data);
    B := RealPart(X.Data);
    DGETRS(ATrans, AFAC.N, X.N, R, 0, AFAC.N, IPIV, B, 0, X.N);
    X.Data := ToComplex(B);
  end;
end;

function Estimate(AComplex: Boolean; ANorm: Char; const AFAC: TMat;
  ANORMVALUE: Double): Double;
var
  INFO: longint;
begin
  if AComplex then
    ZGECON(ANorm, AFAC.N, AFAC.Data, 0, AFAC.N, ANORMVALUE, result, INFO)
  else
    DGECON(ANorm, AFAC.N, RealPart(AFAC.Data), 0, AFAC.N, ANORMVALUE,
      result, INFO);
end;

procedure CheckMatrix(AComplex: Boolean; AType, M, N: Integer);
var
  A, AFAC, AINV, XACT, B, X: TMat;
  IPIV: array of longint;
  IZERO, INB, IRHS, ITRAN, I, J: Integer;
  INFO: longint;
  RCONDO, RCONDI, RCONDC, ANORMI, AINVNM, RCOND: Double;
  LName: string;
  TRFCON: Boolean;
begin
  A := TypeMatrix(AType, M, N, AComplex, IZERO);
  if not AComplex then
    for I := 0 to M * N - 1 do A.Data[I].Im := 0;
  IPIV := nil;
  SetLength(IPIV, Max(Min(M, N), 1));
  for INB := Low(BlockSizes) to High(BlockSizes) do
  begin
    LapackBlockSize := BlockSizes[INB];
    LName := Format('M=%d N=%d NB=%d type %d', [M, N, BlockSizes[INB], AType]);
    AFAC := A;
    AFAC.Data := System.Copy(A.Data);
    Factor(AComplex, AFAC, IPIV, INFO);
    AddInfo(LName + Format(' INFO=%d (expected %d)', [INFO, IZERO]), INFO = IZERO);
    AddRatio(1, LName, LUResidual(A, AFAC, IPIV));
    RCONDO := 0;
    RCONDI := 0;
    TRFCON := not ((M = N) and (INFO = 0));
    if not TRFCON then
    begin
      AINV := AFAC;
      AINV.Data := System.Copy(AFAC.Data);
      Invert(AComplex, AINV, IPIV, INFO);
      AddRatio(2, LName, InverseResidual(A, AINV, RCONDO));
      ANORMI := NormOf(A, 'I');
      AINVNM := NormOf(AINV, 'I');
      if (ANORMI <= 0) or (AINVNM <= 0) then
        RCONDI := 1
      else
        RCONDI := (1 / ANORMI) / AINVNM;
    end;
    { The solves and the condition estimates run with the first block
      size only, and the solves on nonsingular square matrices. }
    if (INB > 0) or (M <> N) then Continue;
    if not TRFCON then
      for IRHS := Low(RightHandSides) to High(RightHandSides) do
        for ITRAN := Low(Transposes) to High(Transposes) do
        begin
          if ITRAN = 0 then RCONDC := RCONDO else RCONDC := RCONDI;
          XACT := NewMat(N, RightHandSides[IRHS]);
          for I := 0 to N - 1 do
            for J := 0 to XACT.N - 1 do
              if AComplex then
                XACT.Data[I * XACT.N + J] := RandomComplex
              else
                XACT.Data[I * XACT.N + J] := RandomUniform;
          B := OpProduct(A, Transposes[ITRAN], XACT);
          X := B;
          X.Data := System.Copy(B.Data);
          Solve(AComplex, Transposes[ITRAN], AFAC, IPIV, X);
          LName := Format('N=%d NRHS=%d TRANS=%s type %d',
            [N, XACT.N, Transposes[ITRAN], AType]);
          AddRatio(3, LName, SolveResidual(A, Transposes[ITRAN], X, B));
          AddRatio(4, LName, ForwardError(X, XACT, RCONDC));
        end;
    for ITRAN := 0 to 1 do
    begin
      if ITRAN = 0 then
        RCOND := Estimate(AComplex, 'O', AFAC, NormOf(A, '1'))
      else
        RCOND := Estimate(AComplex, 'I', AFAC, NormOf(A, 'I'));
      if ITRAN = 0 then RCONDC := RCONDO else RCONDC := RCONDI;
      AddRatio(8, Format('NORM=%s N=%d type %d', [Copy('OI', ITRAN + 1, 1),
        N, AType]), ConditionRatio(RCOND, RCONDC));
    end;
  end;
end;

procedure RunChecks(AComplex: Boolean);
const
  Prefix: array[Boolean] of string = ('DCHKGE', 'ZCHKGE');
  TestNames: array[1..8] of string = (
    '(1) |L*U - P*A| / (n |A| eps)',
    '(2) |I - inv(A)*A| / (n |A| |inv(A)| eps)',
    '(3) |B - op(A)*X| / (|op(A)| |X| eps)',
    '(4) |X - XACT| / (|XACT| rcond eps)',
    '', '', '',
    '(8) rcond estimate against 1/(|A| |inv(A)|)');
var
  IM, JN, LType, NIMAT, M, N, K, LTest: Integer;
  LOrders: array of Integer;
begin
  LOrders := nil;
  for K := Low(Orders) to High(Orders) do
  begin
    SetLength(LOrders, Length(LOrders) + 1);
    LOrders[High(LOrders)] := Orders[K];
  end;
  if ExtendedMode then
    for K := Low(ExtendedOrders) to High(ExtendedOrders) do
    begin
      SetLength(LOrders, Length(LOrders) + 1);
      LOrders[High(LOrders)] := ExtendedOrders[K];
    end;
  Results := Default(TResults);
  SetSeed(1301 + Ord(AComplex));
  try
    for IM := 0 to High(LOrders) do
      for JN := 0 to High(LOrders) do
      begin
        M := LOrders[IM];
        N := LOrders[JN];
        { The extended orders only as square matrices. }
        if (M <> N) and ((M > 50) or (N > 50)) then Continue;
        NIMAT := TypeCount;
        if (M <= 0) or (N <= 0) then NIMAT := 1;
        for LType := 1 to NIMAT do
        begin
          if (LType >= 5) and (LType <= 7) and (N < LType - 4) then Continue;
          CheckMatrix(AComplex, LType, M, N);
        end;
      end;
  finally
    LapackBlockSize := -1;
  end;
  Group(Format('%s xGETRF INFO (first exactly zero pivot)', [Prefix[AComplex]]),
    ckContract);
  for K := 0 to High(Results.InfoOk) do
    Check(Results.InfoLabels[K], Results.InfoOk[K]);
  for LTest := 1 to 8 do
  begin
    if Length(Results.Ratios[LTest]) = 0 then Continue;
    Group(Format('%s %s', [Prefix[AComplex], TestNames[LTest]]), ckStability,
      LAPACKLinearThreshold, tsLAPACK, 'dtest.in');
    for K := 0 to High(Results.Ratios[LTest]) do
      CheckRatio(Results.Labels[LTest][K], Results.Ratios[LTest][K]);
  end;
end;

procedure RealChecks;
begin
  RunChecks(False);
end;

procedure ComplexChecks;
begin
  RunChecks(True);
end;

procedure RunSpec;
begin
  Guard(@RealChecks);
  Guard(@ComplexChecks);
end;

initialization
  RegisterSpec('LAPACK layer: LU factorization (xCHKGE)', @RunSpec);
end.
