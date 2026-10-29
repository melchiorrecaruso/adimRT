{ SpecLapackHseqr - The Hessenberg QR routines of the internal LAPACK layer
  (xGEHRD, xORGHR, xHSEQR with xLAHQR and xLAQR0..5, xTREVC3, xGEEV), checked as
  LAPACK checks them in xCHKHS (TESTING/EIG/dchkhs.f, zchkhs.f) with the
  input of TESTING/nep.in.

  The 21 matrix types of xCHKHS: zero, identity, transposed Jordan block;
  diagonal matrices with evenly spaced, geometric and clustered entries
  1 .. ulp (xLATM1 modes 4, 3, 1) and random signs (complex: random
  phases), also scaled near the overflow and underflow thresholds;
  U^T*T*U with U orthogonal and T upper triangular with those diagonals
  or with random real/complex-pair eigenvalues in (ulp, 1) (mode 5) and
  random O(1) entries above the diagonal; X^-1*T*X with cond(X) =
  1/sqrt(ulp); random matrices with entries in (-1, 1), unscaled and
  scaled. The generators follow the description of xCHKHS (xLATMS,
  xLATME, xLATMR); they do not reproduce LAPACK's random streams.

  For every matrix, as xCHKHS:
    (1) |A - U*H*U^T| / (|A| n ulp)        xGEHRD, xORGHR  (xHST01)
    (2) |I - U^T*U| / (n ulp)                              (xORT01)
    (3) |H - Z*T*Z^T| / (|H| n ulp)        xHSEQR('S', 'V')
    (4) |I - Z^T*Z| / (n ulp)
    (5) |A - UZ*T*(UZ)^T| / (|A| n ulp)
    (6) |I - UZ*(UZ)^T| / (n ulp)
    (7) |T(Z computed) - T(Z not computed)| / (|T| n ulp)  (xGET10)
    (8) |W(Z computed) - W(Z not computed)| / (|W| ulp)
    (9) |T*R - R*W| / (|T| |R| ulp)        xTREVC3, right eigenvectors
  and, as xDRVEV (TESTING/EIG/ddrvev.f, zdrvev.f) for xGEEV with right
  eigenvectors only:
    (1) |A*VR - VR*W| / (n |A| ulp)        xGEEV
    (3) ||VR(i)| - 1| / ulp, or 1/ulp when the largest component of
        VR(i) is not real
  with ^T the conjugate transpose for complex matrices. Test (9) is
  measured as ZGET22 on the complex eigenvectors also for real T (DGET22
  takes the 2x2 blocks of a pair, the same quantity up to the norm of
  the columns). Threshold 20 (nep.in). Residuals are accumulated in
  double-double.

  The orders are those of nep.in (0, 1, 2, 3, 5, 10, 16), each with the
  five tuning sets of nep.in (NMIN, NWIN, NIBBLE, NSHFTS, KACC22), so that
  xLAQR0, the aggressive early deflation of xLAQR3/xLAQR2 and the
  multishift sweeps of xLAQR5 run on small matrices. With the default
  tuning, where xHSEQR switches from xLAHQR to xLAQR0 at order 75, order
  20 is checked with every type and order 80 with type 16.
  --extended adds order 40 with the nep.in sets (the window of xLAQR3 then
  exceeds NMIN and xLAQR4 is used), every type at order 80 and type 16
  at order 150 (more than 14 shifts: matrix products in
  xLAQR5). The double-double residuals make the larger orders slow. }
unit SpecLapackHseqr;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}

interface

implementation

uses
  SysUtils, Math, ADimMath, ADimLapack, TestRunner, TestDoubleDouble,
  TestGenerators, TestMeasures;

const
  TypeCount = 21;
  TestCount = 11;

  { nep.in: INMIN (raised to at least 11 by xCHKEE), INWIN, INIBL, ISHFTS
    and IACC22. }
  NepTunings: array[0..4] of TLapackTuning = (
    (NMIN: 11; NWIN: 2; NIBBLE: 0; NSHFTS: 1; KACC22: 0),
    (NMIN: 12; NWIN: 3; NIBBLE: 5; NSHFTS: 2; KACC22: 1),
    (NMIN: 11; NWIN: 5; NIBBLE: 7; NSHFTS: 4; KACC22: 2),
    (NMIN: 15; NWIN: 3; NIBBLE: 3; NSHFTS: 2; KACC22: 0),
    (NMIN: 11; NWIN: 2; NIBBLE: 200; NSHFTS: 1; KACC22: 1));
  NepOrders: array[0..6] of Integer = (0, 1, 2, 3, 5, 10, 16);
  { Types used at the larger orders of the quick run. }
  QuickTypes = [16];

  TestNames: array[1..TestCount] of string = (
    '(1) |A - U*H*U^T| / (|A| n ulp)',
    '(2) |I - U^T*U| / (n ulp)',
    '(3) |H - Z*T*Z^T| / (|H| n ulp)',
    '(4) |I - Z^T*Z| / (n ulp)',
    '(5) |A - UZ*T*(UZ)^T| / (|A| n ulp)',
    '(6) |I - UZ*(UZ)^T| / (n ulp)',
    '(7) |T(Z computed) - T(Z not computed)| / (|T| n ulp)',
    '(8) |W(Z computed) - W(Z not computed)| / (|W| ulp)',
    '(9) |T*R - R*W| / (|T| |R| ulp)',
    '(1) |A*VR - VR*W| / (n |A| ulp), xGEEV',
    '(3) ||VR(i)| - 1| / ulp, largest component real, xGEEV');

type
  TRatios = array[1..TestCount] of Double;

{ Magnitude class of the xCHKHS types (KMAGN): 1 unscaled, 2 near
  overflow, 3 near underflow. }
function Magnitude(AType: Integer): Integer;
begin
  case AType of
    7, 17, 20: result := 2;
    8, 18, 21: result := 3;
  else
    result := 1;
  end;
end;

{ xLATM1 mode of the diagonal or of the eigenvalues (KMODE). }
function TypeMode(AType: Integer): Integer;
begin
  case AType of
    4, 7, 8, 9, 13: result := 4;
    5, 10, 14: result := 3;
    6, 11, 15: result := 1;
    12, 16, 17, 18: result := 5;
  else
    result := 0;
  end;
end;

{ xLATM1 modes 1, 3, 4, 5 with condition ACond: 1, 1/c, ..., 1/c;
  geometric 1 .. 1/c; arithmetic 1 .. 1/c; random log-uniform in
  (1/c, 1). }
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
      5: result[I] := Exp(-Ln(ACond) * (RandomUniform + 1) / 2);
    end;
end;

{ Scale factor of the type: 1, or the magnitudes of xCHKHS near the
  overflow and underflow thresholds. }
function TypeScale(AType, N: Integer): Double;
const
  Overflow = 1.7976931348623157E+308;
var
  LInverse: Double;
begin
  LInverse := 1 / Max(1, N);
  case Magnitude(AType) of
    2: result := (Sqrt(Overflow) * Ulp) * LInverse;
    3: result := Sqrt(SafeMinimum) * N / Ulp;
  else
    result := 1;
  end;
end;

{ A random matrix X = Q1*diag(s)*Q2^H with cond_2(X) = ACond and its
  inverse, both computed in double-double and rounded once. }
procedure ConditionedPair(N: Integer; ACond: Double; AComplex: Boolean;
  out X, XInverse: TArrayOfComplex);
var
  Q1, Q2: TComplexMatrix;
  R1, R2: TRealMatrix;
  Sigma: TArrayOfReal;
  I, J, K: Integer;
  LSum, LInverseSum: TDDComplex;
begin
  if AComplex then
  begin
    Q1 := RandomUnitary(N);
    Q2 := RandomUnitary(N);
  end else
  begin
    R1 := RandomOrthogonal(N);
    R2 := RandomOrthogonal(N);
    Q1 := RealToComplexMatrix(R1);
    Q2 := RealToComplexMatrix(R2);
  end;
  Sigma := ModeValues(N, 4, ACond);
  X := nil;
  XInverse := nil;
  SetLength(X, N * N);
  SetLength(XInverse, N * N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := DDComplex(0, 0);
      LInverseSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
      begin
        LSum := LSum + TDDComplex(Q1[I, K] * Sigma[K]) *
          TDDComplex(Q2[J, K].Conjugate);
        LInverseSum := LInverseSum + TDDComplex(Q2[I, K] / Sigma[K]) *
          TDDComplex(Q1[J, K].Conjugate);
      end;
      X[I * N + J] := LSum.ToComplex;
      XInverse[I * N + J] := LInverseSum.ToComplex;
    end;
end;

{ A matrix of type AType (1..21) and order N, stored by rows. For real
  types the imaginary parts are zero. }
function TypeMatrix(AType, N: Integer; AComplex: Boolean): TArrayOfComplex;
var
  I, J, K: Integer;
  D: TArrayOfReal;
  T, X, XInverse, W: TArrayOfComplex;
  LSum: TDDComplex;
  LScale, LMax, LAngle, LRe, LIm: Double;

  function RandomEntry: TComplex;
  begin
    if AComplex then result := RandomComplex else result := RandomUniform;
  end;

  { Random sign, or a random phase for complex matrices. }
  function RandomUnit: TComplex;
  begin
    if AComplex then
    begin
      LAngle := Pi * RandomUniform;
      result := Cos(LAngle);
      result.Im := Sin(LAngle);
    end else if RandomUniform < 0 then
      result := -1
    else
      result := 1;
  end;

begin
  result := nil;
  SetLength(result, N * N);
  LScale := TypeScale(AType, N);
  case AType of
    1: ;
    2: for I := 0 to N - 1 do result[I * N + I] := 1;
    3:
      for I := 0 to N - 1 do
      begin
        result[I * N + I] := 1;
        if I > 0 then result[I * N + I - 1] := 1;
      end;
    4..8:
      begin
        D := ModeValues(N, TypeMode(AType), 1 / Ulp);
        for I := 0 to N - 1 do result[I * N + I] := LScale * RandomUnit * D[I];
      end;
    9..18:
      begin
        { T upper (quasi-)triangular with the prescribed eigenvalues and
          random O(1) entries above the diagonal. }
        D := ModeValues(N, TypeMode(AType), 1 / Ulp);
        T := nil;
        SetLength(T, N * N);
        I := 0;
        while I < N do
        begin
          if (TypeMode(AType) = 5) and not AComplex and (I < N - 1) and
             (RandomUniform < 0) then
          begin
            { Complex-conjugate pair re +- i*im of modulus D[I]. }
            LAngle := Pi * (RandomUniform + 1) / 2;
            LRe := D[I] * Cos(LAngle);
            LIm := D[I] * Sin(LAngle);
            T[I * N + I] := LRe;
            T[I * N + I + 1] := LIm;
            T[(I + 1) * N + I] := -LIm;
            T[(I + 1) * N + I + 1] := LRe;
            Inc(I, 2);
          end else
          begin
            T[I * N + I] := RandomUnit * D[I];
            Inc(I);
          end;
        end;
        for I := 0 to N - 1 do
          for J := I + 1 to N - 1 do
            if T[I * N + J] = 0 then T[I * N + J] := RandomEntry;
        if AType <= 12 then
          ConditionedPair(N, 1, AComplex, X, XInverse)
        else
          ConditionedPair(N, 1 / Sqrt(Ulp), AComplex, X, XInverse);
        { A = X^-1 * T * X, W = T * X. }
        W := nil;
        SetLength(W, N * N);
        for I := 0 to N - 1 do
          for J := 0 to N - 1 do
          begin
            LSum := DDComplex(0, 0);
            for K := 0 to N - 1 do
              LSum := LSum + TDDComplex(T[I * N + K]) * TDDComplex(X[K * N + J]);
            W[I * N + J] := LSum.ToComplex;
          end;
        for I := 0 to N - 1 do
          for J := 0 to N - 1 do
          begin
            LSum := DDComplex(0, 0);
            for K := 0 to N - 1 do
              LSum := LSum + TDDComplex(XInverse[I * N + K]) * TDDComplex(W[K * N + J]);
            result[I * N + J] := LSum.ToComplex;
          end;
      end;
    19..21:
      for I := 0 to N * N - 1 do result[I] := RandomEntry;
  end;
  { xLATME and xLATMR scale the matrix to the maximum entry ANORM. }
  if AType >= 9 then
  begin
    LMax := 0;
    for I := 0 to N * N - 1 do
      LMax := Max(LMax, Max(System.Abs(result[I].Re), System.Abs(result[I].Im)));
    if LMax > 0 then
      for I := 0 to N * N - 1 do
        result[I] := (LScale / LMax) * result[I];
  end;
end;

{ One-norm (maximum column sum of moduli) of an N x N matrix by rows. }
function OneNorm(N: Integer; const A: TArrayOfComplex): Double; overload;
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

{ xHST01, test (1): min(|A - Q*H*Q^H|, |A|) / max(smlnum, |A| ulp) / n
  with smlnum = unfl*n/ulp. }
function DecompositionRatio(N: Integer; const A, H, Q: TArrayOfComplex): Double; overload;
var
  I, J, K: Integer;
  QH: array of TDDComplex;
  LSum: TDDComplex;
  R: TArrayOfComplex;
  ANorm, WNorm: Double;
begin
  if N = 0 then Exit(0);
  SetLength(QH, N * N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
        LSum := LSum + TDDComplex(Q[I * N + K]) * TDDComplex(H[K * N + J]);
      QH[I * N + J] := LSum;
    end;
  SetLength(R, N * N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := TDDComplex(A[I * N + J]);
      for K := 0 to N - 1 do
        LSum := LSum - QH[I * N + K] * TDDComplex(Q[J * N + K].Conjugate);
      R[I * N + J] := LSum.ToComplex;
    end;
  ANorm := Max(OneNorm(N, A), SafeMinimum);
  WNorm := OneNorm(N, R);
  result := Min(WNorm, ANorm) / Max(SafeMinimum * N / Ulp, ANorm * Ulp) / N;
end;

function Orthogonality(N: Integer; const Q: TArrayOfComplex): Double; overload;
var
  M: TComplexMatrix;
  I, J: Integer;
begin
  if N = 0 then Exit(0);
  M := NewComplexMatrix(N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do M[I, J] := Q[I * N + J];
  result := OrthogonalityRatio(M);
end;

{ xGET10, test (7). }
function DifferenceRatio(N: Integer; const A, B: TArrayOfComplex): Double;
var
  I, J: Integer;
  ANorm, WNorm, LSum: Double;
begin
  if N = 0 then Exit(0);
  WNorm := 0;
  for J := 0 to N - 1 do
  begin
    LSum := 0;
    for I := 0 to N - 1 do
      LSum := LSum + System.Abs(A[I * N + J].Re - B[I * N + J].Re) +
        System.Abs(A[I * N + J].Im - B[I * N + J].Im);
    WNorm := Max(WNorm, LSum);
  end;
  ANorm := Max(OneNorm(N, A), SafeMinimum);
  if ANorm > WNorm then
    result := (WNorm / ANorm) / (N * Ulp)
  else if ANorm < 1 then
    result := (Min(WNorm, N * ANorm) / ANorm) / (N * Ulp)
  else
    result := Min(WNorm / ANorm, N) / (N * Ulp);
end;

{ Test (8). }
function EigenvalueDifferenceRatio(const W1, W2: TArrayOfComplex): Double;
var
  J: Integer;
  T1, T2: Double;
begin
  T1 := 0;
  T2 := 0;
  for J := 0 to High(W1) do
  begin
    T1 := Max(T1, Max(System.Abs(W1[J].Re) + System.Abs(W1[J].Im),
      System.Abs(W2[J].Re) + System.Abs(W2[J].Im)));
    T2 := Max(T2, System.Abs(W1[J].Re - W2[J].Re) + System.Abs(W1[J].Im - W2[J].Im));
  end;
  result := T2 / Max(SafeMinimum, Ulp * Max(T1, T2));
end;

{ Test (9): ZGET22 on the right eigenvectors R of the Schur form T. }
function EigenvectorRatio(N: Integer; const T, R, W: TArrayOfComplex): Double;
var
  A, V: TComplexMatrix;
  D: TComplexVector;
  I, J: Integer;
begin
  if N = 0 then Exit(0);
  A := NewComplexMatrix(N);
  V := NewComplexMatrix(N);
  D := NewComplexVector(N);
  for I := 0 to N - 1 do
  begin
    D[I] := W[I];
    for J := 0 to N - 1 do
    begin
      A[I, J] := T[I * N + J];
      V[I, J] := R[I * N + J];
    end;
  end;
  result := GeneralEigenRatio(A, D, V);
end;

function Product(N: Integer; const A, B: TArrayOfComplex; AConjugateA: Boolean): TArrayOfComplex;
var
  I, J, K: Integer;
  LSum: TDDComplex;
begin
  result := nil;
  SetLength(result, N * N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
        if AConjugateA then
          LSum := LSum + TDDComplex(A[K * N + I].Conjugate) * TDDComplex(B[K * N + J])
        else
          LSum := LSum + TDDComplex(A[I * N + K]) * TDDComplex(B[K * N + J]);
      result[I * N + J] := LSum.ToComplex;
    end;
end;

{ Real counterparts of the measures above, with real double-double
  sums. }
function OneNorm(N: Integer; const A: TArrayOfReal): Double; overload;
var
  I, J: Integer;
  LSum: Double;
begin
  result := 0;
  for J := 0 to N - 1 do
  begin
    LSum := 0;
    for I := 0 to N - 1 do LSum := LSum + System.Abs(A[I * N + J]);
    result := Max(result, LSum);
  end;
end;

function DecompositionRatio(N: Integer; const A, H, Q: TArrayOfReal): Double; overload;
var
  I, J, K: Integer;
  QH: array of TDD;
  LSum: TDD;
  R: TArrayOfReal;
  ANorm, WNorm: Double;
begin
  if N = 0 then Exit(0);
  SetLength(QH, N * N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := 0;
      for K := 0 to N - 1 do
        LSum := LSum + TDD(Q[I * N + K]) * TDD(H[K * N + J]);
      QH[I * N + J] := LSum;
    end;
  SetLength(R, N * N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := A[I * N + J];
      for K := 0 to N - 1 do
        LSum := LSum - QH[I * N + K] * TDD(Q[J * N + K]);
      R[I * N + J] := LSum.ToDouble;
    end;
  ANorm := Max(OneNorm(N, A), SafeMinimum);
  WNorm := OneNorm(N, R);
  result := Min(WNorm, ANorm) / Max(SafeMinimum * N / Ulp, ANorm * Ulp) / N;
end;

function Orthogonality(N: Integer; const Q: TArrayOfReal): Double; overload;
var
  M: TRealMatrix;
  I, J: Integer;
begin
  if N = 0 then Exit(0);
  M := NewRealMatrix(N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do M[I, J] := Q[I * N + J];
  result := OrthogonalityRatio(M);
end;

{ A^T * B. }
function TransposeProduct(N: Integer; const A, B: TArrayOfReal): TArrayOfReal;
var
  I, J, K: Integer;
  LSum: TDD;
begin
  result := nil;
  SetLength(result, N * N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := 0;
      for K := 0 to N - 1 do
        LSum := LSum + TDD(A[K * N + I]) * TDD(B[K * N + J]);
      result[I * N + J] := LSum.ToDouble;
    end;
end;

function ToComplex(const A: TArrayOfReal): TArrayOfComplex;
var
  I: Integer;
begin
  result := nil;
  SetLength(result, Length(A));
  for I := 0 to High(A) do result[I] := A[I];
end;

{ xDRVEV for xGEEV (JOBVL = 'N', JOBVR = 'V'): test (1) as ZGET22 on the
  complex eigenvectors V and test (3), the largest deviation of the norm
  of a vector from one, in ulps, or 1/ulp when its largest component is
  not real. }
procedure DriverRatios(N: Integer; const A, V, W: TArrayOfComplex;
  out R1, R3: Double);
var
  I, J: Integer;
  TNRM, VMX, VRMX: Double;
begin
  R1 := EigenvectorRatio(N, A, V, W);
  R3 := 0;
  for J := 0 to N - 1 do
  begin
    TNRM := 0;
    VMX := 0;
    VRMX := 0;
    for I := 0 to N - 1 do
    begin
      TNRM := Hypot(TNRM, V[I * N + J].Norm);
      VMX := Max(VMX, V[I * N + J].Norm);
      if V[I * N + J].Im = 0 then VRMX := Max(VRMX, System.Abs(V[I * N + J].Re));
    end;
    R3 := Max(R3, Min(1 / Ulp, System.Abs(TNRM - 1) / Ulp));
    if (VMX > 0) and (VRMX / VMX < 1 - 2 * Ulp) then R3 := 1 / Ulp;
  end;
end;

{ xCHKHS for one real matrix (the real parts of AMatrix). }
function RealRatios(N: Integer; const AMatrix: TArrayOfComplex): TRatios;
var
  I, J, INFO: Integer;
  A, H, U, T1, T2, UZ, Z, WR1, WI1, WR2, WI2, ZDUM, TAU, R: TArrayOfReal;
  W1, W2, RC: TArrayOfComplex;
  Failed: Boolean;
begin
  for I := 1 to TestCount do result[I] := 0;
  SetLength(A, N * N);
  for I := 0 to N * N - 1 do A[I] := AMatrix[I].Re;
  { xGEHRD and xORGHR. }
  H := Copy(A);
  DGEHRD(N, 0, N - 1, H, TAU);
  U := Copy(H);
  DORGHR(N, 0, N - 1, U, TAU);
  for J := 0 to N - 2 do
    for I := J + 2 to N - 1 do H[I * N + J] := 0;
  result[1] := DecompositionRatio(N, A, H, U);
  result[2] := Orthogonality(N, U);
  { xHSEQR without and with Schur vectors. }
  SetLength(WR1, N);
  SetLength(WI1, N);
  SetLength(WR2, N);
  SetLength(WI2, N);
  SetLength(ZDUM, Max(1, N * N));
  Failed := False;
  T2 := Copy(H);
  DHSEQR('S', 'N', N, 0, N - 1, T2, WR2, WI2, ZDUM, INFO);
  Failed := Failed or (INFO <> 0);
  T1 := Copy(H);
  UZ := Copy(U);
  DHSEQR('S', 'V', N, 0, N - 1, T1, WR1, WI1, UZ, INFO);
  Failed := Failed or (INFO <> 0);
  if Failed then
  begin
    for I := 3 to TestCount do result[I] := Infinity;
    Exit;
  end;
  Z := TransposeProduct(N, U, UZ);
  result[3] := DecompositionRatio(N, H, T1, Z);
  result[4] := Orthogonality(N, Z);
  result[5] := DecompositionRatio(N, A, T1, UZ);
  result[6] := Orthogonality(N, UZ);
  result[7] := DifferenceRatio(N, ToComplex(T2), ToComplex(T1));
  SetLength(W1, N);
  SetLength(W2, N);
  for I := 0 to N - 1 do
  begin
    W1[I] := WR1[I];
    W1[I].Im := WI1[I];
    W2[I] := WR2[I];
    W2[I].Im := WI2[I];
  end;
  result[8] := EigenvalueDifferenceRatio(W1, W2);
  { xTREVC: right eigenvectors of T (back-transformed by the identity),
    a complex pair in two columns (real and imaginary part of the vector
    of the eigenvalue with positive imaginary part). }
  SetLength(R, N * N);
  for I := 0 to N - 1 do R[I * N + I] := 1;
  if N > 0 then DTREVC3(N, T1, 0, N, R, 0, N, -1);
  SetLength(RC, N * N);
  J := 0;
  while J < N do
    if WI1[J] = 0 then
    begin
      for I := 0 to N - 1 do RC[I * N + J] := R[I * N + J];
      Inc(J);
    end else
    begin
      for I := 0 to N - 1 do
      begin
        RC[I * N + J] := R[I * N + J];
        RC[I * N + J].Im := R[I * N + J + 1];
        RC[I * N + J + 1] := R[I * N + J];
        RC[I * N + J + 1].Im := -R[I * N + J + 1];
      end;
      Inc(J, 2);
    end;
  result[9] := EigenvectorRatio(N, ToComplex(T1), RC, W1);
  { xDRVEV: DGEEV on A. }
  T2 := Copy(A);
  DGEEV(N, T2, WR2, WI2, R);
  for I := 0 to N - 1 do
  begin
    W2[I] := WR2[I];
    W2[I].Im := WI2[I];
  end;
  J := 0;
  while J < N do
    if WI2[J] = 0 then
    begin
      for I := 0 to N - 1 do RC[I * N + J] := R[I * N + J];
      Inc(J);
    end else
    begin
      for I := 0 to N - 1 do
      begin
        RC[I * N + J] := R[I * N + J];
        RC[I * N + J].Im := R[I * N + J + 1];
        RC[I * N + J + 1] := R[I * N + J];
        RC[I * N + J + 1].Im := -R[I * N + J + 1];
      end;
      Inc(J, 2);
    end;
  DriverRatios(N, ToComplex(A), RC, W2, result[10], result[11]);
end;

{ xCHKHS for one complex matrix. }
function ComplexRatios(N: Integer; const A: TArrayOfComplex): TRatios;
var
  I, J, INFO: Integer;
  H, U, T1, T2, UZ, ZDUM, TAU, R, W1, W2: TArrayOfComplex;
begin
  for I := 1 to TestCount do result[I] := 0;
  H := Copy(A);
  ZGEHRD(N, 0, N - 1, H, TAU);
  U := Copy(H);
  ZUNGHR(N, 0, N - 1, U, TAU);
  for J := 0 to N - 2 do
    for I := J + 2 to N - 1 do H[I * N + J] := 0;
  result[1] := DecompositionRatio(N, A, H, U);
  result[2] := Orthogonality(N, U);
  SetLength(W1, N);
  SetLength(W2, N);
  SetLength(ZDUM, Max(1, N * N));
  T2 := Copy(H);
  ZHSEQR('S', 'N', N, 0, N - 1, T2, W2, ZDUM, INFO);
  if INFO = 0 then
  begin
    T1 := Copy(H);
    UZ := Copy(U);
    ZHSEQR('S', 'V', N, 0, N - 1, T1, W1, UZ, INFO);
  end;
  if INFO <> 0 then
  begin
    for I := 3 to TestCount do result[I] := Infinity;
    Exit;
  end;
  result[3] := DecompositionRatio(N, H, T1, Product(N, U, UZ, True));
  result[4] := Orthogonality(N, Product(N, U, UZ, True));
  result[5] := DecompositionRatio(N, A, T1, UZ);
  result[6] := Orthogonality(N, UZ);
  result[7] := DifferenceRatio(N, T2, T1);
  result[8] := EigenvalueDifferenceRatio(W1, W2);
  SetLength(R, N * N);
  for I := 0 to N - 1 do R[I * N + I] := 1;
  if N > 0 then ZTREVC3(N, T1, 0, N, R, 0, N, -1);
  result[9] := EigenvectorRatio(N, T1, R, W1);
  { xDRVEV: ZGEEV on A. }
  T2 := Copy(A);
  ZGEEV(N, T2, W2, R);
  DriverRatios(N, A, R, W2, result[10], result[11]);
end;

procedure RunChecks(AComplex: Boolean);
const
  Prefix: array[Boolean] of string = ('DCHKHS', 'ZCHKHS');
var
  S, K, N, R, LType, LTest, LCount: Integer;
  LRuns: array of record
    Tuning: TLapackTuning;
    Order: Integer;
    Name: string;
    AllTypes: Boolean;
  end;
  LRatios: array of TRatios;
  LLabels: array of string;
  A: TArrayOfComplex;
  LGroupPrefix: string;
begin
  { The runs: the nep.in sets with the nep.in orders, then the default
    tuning. }
  LRuns := nil;
  for S := Low(NepTunings) to High(NepTunings) do
    for K := Low(NepOrders) to High(NepOrders) + 1 do
    begin
      if K <= High(NepOrders) then N := NepOrders[K]
      else if ExtendedMode then N := 40
      else Break;
      SetLength(LRuns, Length(LRuns) + 1);
      LRuns[High(LRuns)].Tuning := NepTunings[S];
      LRuns[High(LRuns)].Order := N;
      LRuns[High(LRuns)].Name := Format('nep.in set %d', [S + 1]);
      LRuns[High(LRuns)].AllTypes := True;
    end;
  for K := 0 to 2 do
  begin
    case K of
      0: N := 20;
      1: N := 80;
    else
      if ExtendedMode then N := 150 else Break;
    end;
    SetLength(LRuns, Length(LRuns) + 1);
    LRuns[High(LRuns)].Tuning := LapackDefaultTuning;
    LRuns[High(LRuns)].Order := N;
    LRuns[High(LRuns)].Name := 'default tuning';
    LRuns[High(LRuns)].AllTypes := (N = 20) or ((N = 80) and ExtendedMode);
  end;
  SetSeed(1201 + Ord(AComplex));
  LCount := 0;
  SetLength(LRatios, Length(LRuns) * TypeCount);
  SetLength(LLabels, Length(LRuns) * TypeCount);
  try
    for R := 0 to High(LRuns) do
    begin
      LapackTuning := LRuns[R].Tuning;
      N := LRuns[R].Order;
      for LType := 1 to TypeCount do
      begin
        if not (LRuns[R].AllTypes or (LType in QuickTypes)) then Continue;
        A := TypeMatrix(LType, N, AComplex);
        if AComplex then
          LRatios[LCount] := ComplexRatios(N, A)
        else
          LRatios[LCount] := RealRatios(N, A);
        LLabels[LCount] := Format('%s n=%d type %d', [LRuns[R].Name, N, LType]);
        Inc(LCount);
      end;
    end;
  finally
    LapackTuning := LapackDefaultTuning;
  end;
  for LTest := 1 to TestCount do
  begin
    if LTest <= 9 then
      LGroupPrefix := Prefix[AComplex]
    else
      LGroupPrefix := Copy(Prefix[AComplex], 1, 1) + 'DRVEV';
    Group(Format('%s %s', [LGroupPrefix, TestNames[LTest]]), ckStability,
      LAPACKGeneralEigenThreshold, tsLAPACK, 'nep.in');
    for K := 0 to LCount - 1 do
      CheckRatio(LLabels[K], LRatios[K][LTest]);
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
  RegisterSpec('LAPACK layer: Hessenberg QR (xCHKHS)', @RunSpec);
end.
