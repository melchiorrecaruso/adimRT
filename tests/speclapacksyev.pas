{ SpecLapackSyev - The symmetric and Hermitian eigenvalue routines of the
  internal LAPACK layer (xSYTRD/xHETRD with xLATRD and xSYTD2,
  xORGTR/xUNGTR with xORGQR and xORGQL, xSTEQR, xSYEV/xHEEV), checked as
  LAPACK checks them in xCHKST and xDRVST (TESTING/EIG/dchkst.f,
  ddrvst.f, zchkst.f, zdrvst.f) with the input of TESTING/sep.in.

  The matrix types of xCHKST listed in sep.in (1 to 8 and 10 to 21): zero;
  identity; diagonal with eigenvalues evenly spaced 1 .. ulp, geometric
  1 .. ulp and clustered at 1 and ulp (xLATM1 modes 4, 3, 1), random
  signs, also scaled near the overflow and underflow thresholds; Q*D*Q^H
  with Q random orthogonal (unitary) and the same eigenvalues; random
  symmetric (Hermitian) matrices with entries in (-1, 1), unscaled and
  scaled; positive definite Q*D*Q^H with modes 4, 3, 1, unscaled and
  scaled; a positive definite tridiagonal matrix with off-diagonal
  entries at most half the geometric mean of their diagonal neighbours.
  The generators follow the description of xCHKST (xLATMS, xLATMR); they
  do not reproduce LAPACK's random streams.

  For every matrix, as xCHKST, with ^H the conjugate transpose:
    (1) |A - Q*T*Q^H| / (|A| n ulp)     xSYTRD and xORGTR with UPLO = 'U'
    (2) |I - Q*Q^H| / (n ulp)
    (3), (4) the same with UPLO = 'L'
    (9) |A - Z*D*Z^H| / (|A| n ulp)     xSTEQR with COMPZ = 'V' from Q
    (10) |I - Z*Z^H| / (n ulp)
  and as xDRVST for xSYEV (xHEEV) with JOBZ = 'V' and UPLO = 'L', 'U':
    (1) |A - Z*D*Z^H| / (|A| n ulp)
    (2) |I - Z*Z^H| / (n ulp)
  measured as xSYT21 (xHET21) and with the eigenvalues checked to be in
  ascending order. The tests that compare with the eigenvalues computed
  without eigenvectors (xSTERF, xSTEQR with COMPZ = 'N') are not run: the
  layer does not provide that path. Threshold 50 (sep.in). The orders are
  those of sep.in (0, 1, 2, 3, 5, 20), each with the five block sizes and
  crossover points of sep.in (NB 1 3 3 3 10, NX 1 0 5 9 1), so that the
  blocked xSYTRD, xORGQR and xORGQL run on small matrices; then order 40
  with the default block sizes. --extended adds orders 100 and 140
  (xORGQR and xORGQL blocked with the default crossover 128). Residuals
  are accumulated in double-double. }
unit SpecLapackSyev;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}

interface

implementation

uses
  SysUtils, Math, ADimMath, ADimLapack, TestRunner, TestDoubleDouble,
  TestGenerators, TestMeasures;

const
  Types: array[0..19] of Integer =
    (1, 2, 3, 4, 5, 6, 7, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21);
  { KTYPE, KMAGN, KMODE of xCHKST. }
  KTYPE: array[1..21] of Integer =
    (1, 2, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 8, 8, 8, 9, 9, 9, 9, 9, 10);
  KMAGN: array[1..21] of Integer =
    (1, 1, 1, 1, 1, 2, 3, 1, 1, 1, 2, 3, 1, 2, 3, 1, 1, 1, 2, 3, 1);
  KMODE: array[1..21] of Integer =
    (0, 0, 4, 3, 1, 4, 4, 4, 3, 1, 4, 4, 0, 0, 0, 4, 3, 1, 4, 4, 3);
  SepOrders: array[0..5] of Integer = (0, 1, 2, 3, 5, 20);
  SepBlocks: array[0..4] of Integer = (1, 3, 3, 3, 10);
  SepCrossovers: array[0..4] of Integer = (1, 0, 5, 9, 1);
  TestCount = 16;
  TestNames: array[0..TestCount - 1] of string = (
    'xCHKST (1) |A - Q*T*Q^H| / (|A| n ulp), UPLO = U',
    'xCHKST (2) |I - Q*Q^H| / (n ulp), UPLO = U',
    'xCHKST (3) |A - Q*T*Q^H| / (|A| n ulp), UPLO = L',
    'xCHKST (4) |I - Q*Q^H| / (n ulp), UPLO = L',
    'xCHKST (9) |A - Z*D*Z^H| / (|A| n ulp), xSTEQR',
    'xCHKST (10) |I - Z*Z^H| / (n ulp), xSTEQR',
    'xDRVST (1) |A - Z*D*Z^H| / (|A| n ulp), xSYEV',
    'xDRVST (2) |I - Z*Z^H| / (n ulp), xSYEV',
    'xCHKST (18) |W(DSTEBZ A) - W(xSTEQR)| / (|W| ulp)',
    'xCHKST (19) W(DSTEBZ I) against W(DSTEBZ V) / (|W| ulp)',
    'xCHKST (20) |S - Y*W*Y^T| / (|S| n ulp), DSTEBZ and DSTEIN',
    'xCHKST (21) |I - Y*Y^T| / (n ulp), DSTEBZ and DSTEIN',
    'xDRVST |S - Z*W*Z^T| / (|S| n ulp), DSTEVX RANGE = A (DSTT21)',
    'xDRVST |I - Z*Z^T| / (n ulp), DSTEVX RANGE = A (DSTT21)',
    'xDRVST |Z^T*S*Z - W| / (|S| m eps), DSTEVX RANGE = I, V (DSTT22)',
    'xDRVST |I - Z^T*Z| / (m eps), DSTEVX RANGE = I, V (DSTT22)');

var
  Labels: array[0..TestCount - 1] of array of string;
  Ratios: array[0..TestCount - 1] of array of Double;
  OrderLabels: array of string;
  OrderOk: array of Boolean;

procedure AddRatio(ATest: Integer; const ALabel: string; ARatio: Double);
var
  K: Integer;
begin
  K := Length(Ratios[ATest]);
  SetLength(Ratios[ATest], K + 1);
  SetLength(Labels[ATest], K + 1);
  Ratios[ATest][K] := ARatio;
  Labels[ATest][K] := ALabel;
end;

function ModeValues(N, AMode: Integer; ACond: Double): TArrayOfReal;
var
  I: Integer;
begin
  result := nil;
  SetLength(result, N);
  for I := 0 to N - 1 do
    case AMode of
      1: if I = 0 then result[I] := 1 else result[I] := 1 / ACond;
      3: if N = 1 then result[I] := 1
         else result[I] := Power(ACond, -I / (N - 1));
      4: if N = 1 then result[I] := 1
         else result[I] := 1 - I / (N - 1) * (1 - 1 / ACond);
    end;
end;

{ Q*diag(D)*Q^H with Q random orthogonal (unitary), in double-double,
  made exactly Hermitian. }
function SpectrumMatrix(N: Integer; const D: TArrayOfReal;
  AComplex: Boolean): TArrayOfComplex;
var
  Q: TComplexMatrix;
  I, J, K: Integer;
  LSum: TDDComplex;
begin
  if AComplex then Q := RandomUnitary(Max(N, 1))
  else Q := RealToComplexMatrix(RandomOrthogonal(Max(N, 1)));
  result := nil;
  SetLength(result, N * N);
  for I := 0 to N - 1 do
    for J := I to N - 1 do
    begin
      LSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
        LSum := LSum + TDDComplex(Q[I, K] * D[K]) *
          TDDComplex(Q[J, K].Conjugate);
      result[I * N + J] := LSum.ToComplex;
      if I = J then result[I * N + J].Im := 0;
      result[J * N + I] := result[I * N + J].Conjugate;
    end;
end;

{ Householder reduction of a Hermitian matrix to real symmetric
  tridiagonal form (same eigenvalues), for the generator of type 21. }
procedure Tridiagonalize(N: Integer; var A: TArrayOfComplex);
var
  I, J, K: Integer;
  LNorm, LScale: Double;
  LAlpha, LDot: TComplex;
  V: TArrayOfComplex;
  B: TArrayOfComplex;
begin
  V := nil;
  SetLength(V, N);
  for K := 0 to N - 3 do
  begin
    LNorm := 0;
    for I := K + 1 to N - 1 do LNorm := Hypot(LNorm, A[I * N + K].Norm);
    if LNorm = 0 then Continue;
    if A[(K + 1) * N + K].Norm = 0 then LAlpha := -LNorm
    else LAlpha := -LNorm * (A[(K + 1) * N + K] / A[(K + 1) * N + K].Norm);
    for I := 0 to N - 1 do V[I] := 0;
    for I := K + 1 to N - 1 do V[I] := A[I * N + K];
    V[K + 1] := V[K + 1] - LAlpha;
    LScale := 0;
    for I := K + 1 to N - 1 do LScale := Hypot(LScale, V[I].Norm);
    for I := K + 1 to N - 1 do V[I] := V[I] / LScale;
    { A := H*A*H with H = I - 2 v v^H. }
    B := System.Copy(A);
    for J := 0 to N - 1 do
    begin
      LDot := 0;
      for I := K + 1 to N - 1 do LDot := LDot + V[I].Conjugate * A[I * N + J];
      for I := K + 1 to N - 1 do B[I * N + J] := A[I * N + J] - 2 * V[I] * LDot;
    end;
    for I := 0 to N - 1 do
    begin
      LDot := 0;
      for J := K + 1 to N - 1 do LDot := LDot + B[I * N + J] * V[J];
      for J := K + 1 to N - 1 do
        A[I * N + J] := B[I * N + J] - 2 * LDot * V[J].Conjugate;
      for J := 0 to K do A[I * N + J] := B[I * N + J];
    end;
  end;
  { Make it exactly tridiagonal, real and symmetric. }
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
      if System.Abs(I - J) > 1 then A[I * N + J] := 0
      else if I = J then A[I * N + J] := A[I * N + J].Re
      else if J = I + 1 then
      begin
        A[I * N + J] := A[I * N + J].Norm;
        A[J * N + I] := A[I * N + J];
      end;
end;

{ A matrix of type AType of xCHKST, Hermitian (real symmetric when not
  AComplex). }
function TypeMatrix(AType, N: Integer; AComplex: Boolean): TArrayOfComplex;
var
  I, J: Integer;
  D: TArrayOfReal;
  ANORM, LMax, TEMP1: Double;
begin
  case KMAGN[AType] of
    2: ANORM := (Sqrt(1.7976931348623157E+308) * ULP) / Max(1, N);
    3: ANORM := Sqrt(SafeMinimum) * N / ULP;
  else
    ANORM := 1;
  end;
  result := nil;
  SetLength(result, N * N);
  case KTYPE[AType] of
    1: ;
    2: for I := 0 to N - 1 do result[I * N + I] := ANORM;
    4, 5, 9, 10:
      begin
        D := ModeValues(N, KMODE[AType], 1 / ULP);
        for I := 0 to N - 1 do
        begin
          D[I] := D[I] * ANORM;
          { Random signs, except for the positive definite types. }
          if (KTYPE[AType] in [4, 5]) and (RandomUniform < 0) then
            D[I] := -D[I];
        end;
        if KTYPE[AType] = 4 then
          for I := 0 to N - 1 do result[I * N + I] := D[I]
        else
        begin
          result := SpectrumMatrix(N, D, AComplex);
          if KTYPE[AType] = 10 then
          begin
            Tridiagonalize(N, result);
            { Diagonal dominance as in xCHKST. }
            for I := 1 to N - 1 do
            begin
              TEMP1 := result[(I - 1) * N + I].Norm /
                Sqrt(System.Abs(result[(I - 1) * N + I - 1].Re *
                result[I * N + I].Re));
              if TEMP1 > 0.5 then
              begin
                result[(I - 1) * N + I] := 0.5 * Sqrt(System.Abs(
                  result[(I - 1) * N + I - 1].Re * result[I * N + I].Re));
                result[I * N + I - 1] := result[(I - 1) * N + I];
              end;
            end;
          end;
        end;
      end;
    8:
      begin
        { Random Hermitian entries in (-1, 1), scaled to the largest
          entry ANORM (xLATMR). }
        LMax := 0;
        for I := 0 to N - 1 do
          for J := I to N - 1 do
          begin
            if I = J then
              result[I * N + J] := RandomUniform
            else if AComplex then
              result[I * N + J] := RandomComplex
            else
              result[I * N + J] := RandomUniform;
            result[J * N + I] := result[I * N + J].Conjugate;
            LMax := Max(LMax, result[I * N + J].Norm);
          end;
        if LMax > 0 then
          for I := 0 to N * N - 1 do
            result[I] := (ANORM / LMax) * result[I];
      end;
  end;
  if not AComplex then
    for I := 0 to N * N - 1 do result[I].Im := 0;
end;

function OneNormOf(N: Integer; const A: TArrayOfComplex): Double;
var
  I, J: Integer;
  LSum: Double;
begin
  result := 0;
  for J := 0 to N - 1 do
  begin
    LSum := 0;
    for I := 0 to N - 1 do LSum := LSum + A[I * N + J].Norm;
    result := Max(result, LSum);
  end;
end;

{ xSYT21/xHET21 (1): |A - U*S*U^H| / (|A| n ulp), S given by rows. }
function DecompositionRatio(N: Integer; const A, U, S: TArrayOfComplex): Double;
var
  I, J, K, L: Integer;
  US, W: TArrayOfComplex;
  LSum: TDDComplex;
  ANORM, WNORM: Double;
begin
  if N <= 0 then Exit(0);
  ANORM := Max(OneNormOf(N, A), SafeMinimum);
  US := nil;
  W := nil;
  SetLength(US, N * N);
  SetLength(W, N * N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
        if S[K * N + J] <> 0 then
          LSum := LSum + TDDComplex(U[I * N + K]) * TDDComplex(S[K * N + J]);
      US[I * N + J] := LSum.ToComplex;
    end;
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := TDDComplex(A[I * N + J]);
      for L := 0 to N - 1 do
        LSum := LSum - TDDComplex(US[I * N + L]) *
          TDDComplex(U[J * N + L].Conjugate);
      W[I * N + J] := LSum.ToComplex;
    end;
  WNORM := OneNormOf(N, W);
  if ANORM > WNORM then
    result := (WNORM / ANORM) / (N * ULP)
  else if ANORM < 1 then
    result := (Min(WNORM, N * ANORM) / ANORM) / (N * ULP)
  else
    result := Min(WNORM / ANORM, N) / (N * ULP);
end;

{ xSYT21/xHET21 (2): |I - U*U^H| / (n ulp). }
function OrthogonalityRatio(N: Integer; const U: TArrayOfComplex): Double;
var
  I, J, K: Integer;
  W: TArrayOfComplex;
  LSum: TDDComplex;
begin
  if N <= 0 then Exit(0);
  W := nil;
  SetLength(W, N * N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      if I = J then LSum := DDComplex(-1, 0) else LSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
        LSum := LSum + TDDComplex(U[I * N + K]) * TDDComplex(U[J * N + K].Conjugate);
      W[I * N + J] := LSum.ToComplex;
    end;
  result := Min(OneNormOf(N, W), N) / (N * Ulp);
end;

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

{ Tridiagonal (or diagonal, E = nil) matrix by rows. }
function TridiagonalOf(N: Integer; const D, E: TArrayOfReal): TArrayOfComplex;
var
  I: Integer;
begin
  result := nil;
  SetLength(result, N * N);
  for I := 0 to N - 1 do
  begin
    result[I * N + I] := D[I];
    if (E <> nil) and (I < N - 1) then
    begin
      result[I * N + I + 1] := E[I];
      result[(I + 1) * N + I] := E[I];
    end;
  end;
end;

{ The infinity norm of the tridiagonal matrix (SD, SE), at least the
  underflow threshold (DSTT21, DSTT22). }
function TridiagonalNorm(N: Integer; const SD, SE: TArrayOfReal): Double;
var
  J: Integer;
begin
  result := 0;
  for J := 0 to N - 1 do
  begin
    if J > 0 then
      result := Max(result, System.Abs(SD[J]) + System.Abs(SE[J - 1]) +
        IfThen(J < N - 1, System.Abs(SE[Min(J, N - 2)]), 0))
    else if N > 1 then
      result := Max(result, System.Abs(SD[0]) + System.Abs(SE[0]))
    else
      result := Max(result, System.Abs(SD[0]));
  end;
  result := Max(result, SafeMinimum);
end;

{ (S*u)(k) for the tridiagonal S = (SD, SE) and column J of U (N x M by
  rows), in double-double. }
function TridiagonalTimes(N, M: Integer; const SD, SE, U: TArrayOfReal;
  K, J: Integer): TDD;
begin
  result := TwoProd(SD[K], U[K * M + J]);
  if K < N - 1 then result := result + TwoProd(SE[K], U[(K + 1) * M + J]);
  if K > 0 then result := result + TwoProd(SE[K - 1], U[(K - 1) * M + J]);
end;

{ DSTT21 with KBAND = 0: |S - U*diag(W)*U^T| / (|S| n ulp) and
  |I - U*U^T| / (n ulp), U N x N by rows. }
procedure Stt21(N: Integer; const SD, SE, W, U: TArrayOfReal;
  out R1, R2: Double);
var
  I, J, K: Integer;
  LSum: TDD;
  ANORM, WNORM, ONORM, LCol: Double;
begin
  R1 := 0;
  R2 := 0;
  if N <= 0 then Exit;
  ANORM := TridiagonalNorm(N, SD, SE);
  WNORM := 0;
  ONORM := 0;
  for J := 0 to N - 1 do
  begin
    LCol := 0;
    for I := 0 to N - 1 do
    begin
      if I = J then LSum := TDD(SD[I])
      else if I = J + 1 then LSum := TDD(SE[J])
      else if J = I + 1 then LSum := TDD(SE[I])
      else LSum := 0;
      for K := 0 to N - 1 do
        LSum := LSum - TwoProd(U[I * N + K] * W[K], U[J * N + K]);
      LCol := LCol + System.Abs(LSum.ToDouble);
    end;
    WNORM := Max(WNORM, LCol);
    LCol := 0;
    for I := 0 to N - 1 do
    begin
      if I = J then LSum := -1 else LSum := 0;
      for K := 0 to N - 1 do
        LSum := LSum + TwoProd(U[I * N + K], U[J * N + K]);
      LCol := LCol + System.Abs(LSum.ToDouble);
    end;
    ONORM := Max(ONORM, LCol);
  end;
  if ANORM > WNORM then
    R1 := (WNORM / ANORM) / (N * Ulp)
  else if ANORM < 1 then
    R1 := (Min(WNORM, N * ANORM) / ANORM) / (N * Ulp)
  else
    R1 := Min(WNORM / ANORM, N) / (N * Ulp);
  R2 := Min(N, ONORM) / (N * Ulp);
end;

{ DSTT22 with KBAND = 0: |U^T*S*U - diag(W)| / (|S| m eps) and
  |I - U^T*U| / (m eps), U N x M by rows, eps = 2^-53. }
procedure Stt22(N, M: Integer; const SD, SE, W, U: TArrayOfReal;
  out R1, R2: Double);
var
  I, J, K: Integer;
  LSum: TDD;
  ANORM, WNORM, ONORM, LCol, EPS: Double;
  SU: array of TDD;
begin
  R1 := 0;
  R2 := 0;
  if (N <= 0) or (M <= 0) then Exit;
  EPS := UnitRoundoff;
  ANORM := TridiagonalNorm(N, SD, SE);
  SU := nil;
  SetLength(SU, N * M);
  for K := 0 to N - 1 do
    for J := 0 to M - 1 do
      SU[K * M + J] := TridiagonalTimes(N, M, SD, SE, U, K, J);
  WNORM := 0;
  ONORM := 0;
  for J := 0 to M - 1 do
  begin
    LCol := 0;
    for I := 0 to M - 1 do
    begin
      if I = J then LSum := -TDD(W[I]) else LSum := 0;
      for K := 0 to N - 1 do LSum := LSum + TDD(U[K * M + I]) * SU[K * M + J];
      LCol := LCol + System.Abs(LSum.ToDouble);
    end;
    WNORM := Max(WNORM, LCol);
    LCol := 0;
    for I := 0 to M - 1 do
    begin
      if I = J then LSum := -1 else LSum := 0;
      for K := 0 to N - 1 do LSum := LSum + TwoProd(U[K * M + I], U[K * M + J]);
      LCol := LCol + System.Abs(LSum.ToDouble);
    end;
    ONORM := Max(ONORM, LCol);
  end;
  if ANORM > WNORM then
    R1 := (WNORM / ANORM) / (M * EPS)
  else if ANORM < 1 then
    R1 := (Min(WNORM, M * ANORM) / ANORM) / (M * EPS)
  else
    R1 := Min(WNORM / ANORM, M) / (M * EPS);
  R2 := Min(M, ONORM) / (M * EPS);
end;

{ DSXT1 with IJOB = 1: the largest distance from an entry of D1 to the
  nearest entry of D2 (both ascending). }
function Sxt1(const D1: TArrayOfReal; N1: Integer; const D2: TArrayOfReal;
  N2: Integer): Double;
var
  I, J: Integer;
  TEMP2: Double;
begin
  result := 0;
  J := 0;
  for I := 0 to N1 - 1 do
  begin
    while (D2[J] < D1[I]) and (J < N2 - 1) do Inc(J);
    if J = 0 then
      TEMP2 := System.Abs(D2[J] - D1[I])
    else
      TEMP2 := Min(System.Abs(D2[J] - D1[I]), System.Abs(D1[I] - D2[J - 1]));
    result := Max(result, TEMP2);
  end;
end;

{ The tests of DSTEBZ, DSTEIN (xCHKST 18-21) and DSTEVX (xDRVST) on the
  tridiagonal matrix (SD, SE) with eigenvalues D1 from xSTEQR. }
procedure CheckTridiagonal(N: Integer; const SD, SE, D1: TArrayOfReal;
  const LName: string);
const
  ABSTOL = 2 * SafeMinimum;
var
  WA1, WA2, WA3, Y, D, E: TArrayOfReal;
  IBLOCK, ISPLIT, IFAIL: array of longint;
  M, M2, M3, NSPLIT, INFO, IL, IU, J: longint;
  TEMP1, TEMP2, TEMP3, VL, VU, ANORM, R1, R2: Double;
begin
  WA1 := nil;
  WA2 := nil;
  WA3 := nil;
  IBLOCK := nil;
  ISPLIT := nil;
  IFAIL := nil;
  SetLength(WA1, Max(N, 1));
  SetLength(WA2, Max(N, 1));
  SetLength(WA3, Max(N, 1));
  SetLength(IBLOCK, Max(N, 1));
  SetLength(ISPLIT, Max(N, 1));
  SetLength(IFAIL, Max(N, 1));
  ANORM := TridiagonalNorm(N, SD, SE);
  { (18) DSTEBZ('A', 'E'). }
  DSTEBZ('A', 'E', N, 0, 0, 1, N, ABSTOL, SD, SE, M, NSPLIT, WA1, IBLOCK,
    ISPLIT, INFO);
  if (INFO <> 0) or (M <> N) then
    AddRatio(8, LName, 1 / Ulp)
  else
  begin
    TEMP1 := 0;
    TEMP2 := 0;
    for J := 0 to N - 1 do
    begin
      TEMP1 := Max(TEMP1, Max(System.Abs(D1[J]), System.Abs(WA1[J])));
      TEMP2 := Max(TEMP2, System.Abs(D1[J] - WA1[J]));
    end;
    AddRatio(8, LName, TEMP2 / Max(SafeMinimum, Ulp * Max(TEMP1, TEMP2)));
  end;
  { (19) DSTEBZ('I', 'E') against DSTEBZ('V', 'E'). }
  if N <= 1 then
  begin
    IL := 1;
    IU := N;
  end else
  begin
    IL := 1 + Trunc((N - 1) * (RandomUniform + 1) / 2);
    IU := 1 + Trunc((N - 1) * (RandomUniform + 1) / 2);
    if IU < IL then
    begin
      J := IU;
      IU := IL;
      IL := J;
    end;
  end;
  DSTEBZ('I', 'E', N, 0, 0, IL, IU, ABSTOL, SD, SE, M2, NSPLIT, WA2, IBLOCK,
    ISPLIT, INFO);
  if N > 0 then
  begin
    if IL <> 1 then
      VL := WA1[IL - 1] - Max(Max(0.5 * (WA1[IL - 1] - WA1[IL - 2]), Ulp * ANORM),
        2 * Sqrt(SafeMinimum))
    else
      VL := WA1[0] - Max(Max(0.5 * (WA1[N - 1] - WA1[0]), Ulp * ANORM),
        2 * Sqrt(SafeMinimum));
    if IU <> N then
      VU := WA1[IU - 1] + Max(Max(0.5 * (WA1[IU] - WA1[IU - 1]), Ulp * ANORM),
        2 * Sqrt(SafeMinimum))
    else
      VU := WA1[N - 1] + Max(Max(0.5 * (WA1[N - 1] - WA1[0]), Ulp * ANORM),
        2 * Sqrt(SafeMinimum));
  end else
  begin
    VL := 0;
    VU := 1;
  end;
  DSTEBZ('V', 'E', N, VL, VU, IL, IU, ABSTOL, SD, SE, M3, NSPLIT, WA3, IBLOCK,
    ISPLIT, INFO);
  if (M3 = 0) and (N <> 0) then
    AddRatio(9, LName, 1 / Ulp)
  else if N > 0 then
  begin
    TEMP1 := Sxt1(WA2, M2, WA3, M3);
    TEMP2 := Sxt1(WA3, M3, WA2, M2);
    TEMP3 := Max(System.Abs(WA1[N - 1]), System.Abs(WA1[0]));
    AddRatio(9, LName, (TEMP1 + TEMP2) / Max(SafeMinimum, TEMP3 * Ulp));
  end;
  { (20), (21) DSTEBZ('A', 'B') and DSTEIN. }
  DSTEBZ('A', 'B', N, 0, 0, 1, N, ABSTOL, SD, SE, M, NSPLIT, WA1, IBLOCK,
    ISPLIT, INFO);
  Y := nil;
  SetLength(Y, Max(N * N, 1));
  DSTEIN(N, SD, SE, M, WA1, IBLOCK, ISPLIT, Y, 0, N, IFAIL, INFO);
  if INFO <> 0 then
  begin
    AddRatio(10, LName, 1 / Ulp);
    AddRatio(11, LName, 1 / Ulp);
  end else
  begin
    Stt21(N, SD, SE, WA1, Y, R1, R2);
    AddRatio(10, LName, R1);
    AddRatio(11, LName, R2);
  end;
  { DSTEVX with RANGE = 'A', 'I' and 'V' (on copies: DSTEVX may scale
    D and E). }
  D := System.Copy(SD);
  E := System.Copy(SE);
  DSTEVX('A', N, D, E, 0, 0, 1, N, ABSTOL, M, WA1, Y, 0, N, IFAIL, INFO);
  if INFO <> 0 then
  begin
    AddRatio(12, LName, 1 / Ulp);
    AddRatio(13, LName, 1 / Ulp);
  end else
  begin
    Stt21(N, SD, SE, WA1, Y, R1, R2);
    AddRatio(12, LName, R1);
    AddRatio(13, LName, R2);
  end;
  for J := 0 to 1 do
  begin
    D := System.Copy(SD);
    E := System.Copy(SE);
    if J = 0 then
      DSTEVX('I', N, D, E, 0, 0, IL, IU, ABSTOL, M, WA1, Y, 0, N, IFAIL, INFO)
    else
      DSTEVX('V', N, D, E, VL, VU, IL, IU, ABSTOL, M, WA1, Y, 0, N, IFAIL,
        INFO);
    if INFO <> 0 then
    begin
      AddRatio(14, LName, 1 / Ulp);
      AddRatio(15, LName, 1 / Ulp);
    end else
    begin
      { Z is N x N here; take its first M columns. }
      WA2 := nil;
      SetLength(WA2, Max(N * M, 1));
      for IU := 0 to N - 1 do
        for IL := 0 to M - 1 do WA2[IU * M + IL] := Y[IU * N + IL];
      Stt22(N, M, SD, SE, WA1, WA2, R1, R2);
      AddRatio(14, LName + Copy(' RANGE=I RANGE=V', 1 + 8 * J, 8), R1);
      AddRatio(15, LName + Copy(' RANGE=I RANGE=V', 1 + 8 * J, 8), R2);
    end;
  end;
end;

procedure CheckMatrix(AComplex: Boolean; AType, N: Integer; const AName: string);
var
  A, Q, Z, TT: TArrayOfComplex;
  RA: TArrayOfReal;
  D, E, D2, E2, W: TArrayOfReal;
  TAU: TArrayOfComplex;
  RTAU: TArrayOfReal;
  INFO: longint;
  K: Integer;
  UPLO: Char;
  LOrdered: Boolean;
  LName: string;
begin
  A := TypeMatrix(AType, N, AComplex);
  LName := Format('%s n=%d type %d', [AName, N, AType]);
  D := nil;
  E := nil;
  W := nil;
  SetLength(D, N);
  SetLength(E, Max(N - 1, 0));
  SetLength(W, N);
  for K := 0 to 1 do
  begin
    if K = 0 then UPLO := 'U' else UPLO := 'L';
    { xSYTRD and xORGTR. }
    Q := System.Copy(A);
    if AComplex then
    begin
      TAU := nil;
      SetLength(TAU, Max(N - 1, 0));
      ZHETRD(UPLO, N, Q, 0, N, D, E, TAU);
      ZUNGTR(UPLO, N, Q, 0, N, TAU);
    end else
    begin
      RA := RealPart(Q);
      RTAU := nil;
      SetLength(RTAU, Max(N - 1, 0));
      DSYTRD(UPLO, N, RA, 0, N, D, E, RTAU);
      DORGTR(UPLO, N, RA, 0, N, RTAU);
      Q := ToComplex(RA);
    end;
    TT := TridiagonalOf(N, D, E);
    AddRatio(2 * K, LName, DecompositionRatio(N, A, Q, TT));
    AddRatio(2 * K + 1, LName, OrthogonalityRatio(N, Q));
    { xSTEQR from Q (UPLO = 'L' as the last reduction, as xCHKST). }
    if K = 1 then
    begin
      D2 := System.Copy(D);
      E2 := System.Copy(E);
      Z := System.Copy(Q);
      if AComplex then
        ZSTEQR('V', N, D2, E2, Z, 0, N, INFO)
      else
      begin
        RA := RealPart(Z);
        DSTEQR('V', N, D2, E2, RA, 0, N, INFO);
        Z := ToComplex(RA);
      end;
      AddRatio(4, LName, DecompositionRatio(N, A, Z, TridiagonalOf(N, D2, nil)));
      AddRatio(5, LName, OrthogonalityRatio(N, Z));
      CheckTridiagonal(N, D, E, D2, LName);
    end;
    { xSYEV. }
    Z := System.Copy(A);
    if AComplex then
      ZHEEV(UPLO, N, Z, 0, N, W, INFO)
    else
    begin
      RA := RealPart(Z);
      DSYEV(UPLO, N, RA, 0, N, W, INFO);
      Z := ToComplex(RA);
    end;
    AddRatio(6, LName + ' UPLO=' + UPLO,
      DecompositionRatio(N, A, Z, TridiagonalOf(N, W, nil)));
    AddRatio(7, LName + ' UPLO=' + UPLO, OrthogonalityRatio(N, Z));
    LOrdered := INFO = 0;
    for INFO := 1 to N - 1 do
      if W[INFO] < W[INFO - 1] then LOrdered := False;
    SetLength(OrderLabels, Length(OrderLabels) + 1);
    SetLength(OrderOk, Length(OrderOk) + 1);
    OrderLabels[High(OrderLabels)] := LName + ' UPLO=' + UPLO;
    OrderOk[High(OrderOk)] := LOrdered;
  end;
end;

procedure RunChecks(AComplex: Boolean);
const
  Prefix: array[Boolean] of string = ('D', 'Z');
var
  S, K, T, LTest: Integer;
begin
  for LTest := 0 to TestCount - 1 do
  begin
    Labels[LTest] := nil;
    Ratios[LTest] := nil;
  end;
  OrderLabels := nil;
  OrderOk := nil;
  SetSeed(1401 + Ord(AComplex));
  try
    for S := Low(SepBlocks) to High(SepBlocks) do
    begin
      LapackBlockSize := SepBlocks[S];
      LapackCrossover := SepCrossovers[S];
      for K := Low(SepOrders) to High(SepOrders) do
        for T := Low(Types) to High(Types) do
          CheckMatrix(AComplex, Types[T], SepOrders[K],
            Format('NB=%d NX=%d', [SepBlocks[S], SepCrossovers[S]]));
    end;
    LapackBlockSize := -1;
    LapackCrossover := -1;
    for T := Low(Types) to High(Types) do
      CheckMatrix(AComplex, Types[T], 40, 'default blocks');
    if ExtendedMode then
      for K := 0 to 1 do
        for T := Low(Types) to High(Types) do
          CheckMatrix(AComplex, Types[T], 100 + 40 * K, 'default blocks');
  finally
    LapackBlockSize := -1;
    LapackCrossover := -1;
  end;
  Group(Prefix[AComplex] + 'DRVST xSYEV eigenvalues in ascending order, INFO = 0',
    ckContract);
  for K := 0 to High(OrderOk) do Check(OrderLabels[K], OrderOk[K]);
  for LTest := 0 to TestCount - 1 do
  begin
    Group(Prefix[AComplex] + Copy(TestNames[LTest], 2, MaxInt), ckStability,
      LAPACKSymmetricEigenThreshold, tsLAPACK, 'sep.in');
    for K := 0 to High(Ratios[LTest]) do
      CheckRatio(Labels[LTest][K], Ratios[LTest][K]);
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
  RegisterSpec('LAPACK layer: symmetric eigenproblem (xCHKST, xDRVST)', @RunSpec);
end.
