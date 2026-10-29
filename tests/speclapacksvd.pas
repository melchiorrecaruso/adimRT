{ SpecLapackSvd - The singular value routines of the internal LAPACK
  layer (xGEBRD with xLABRD and xGEBD2, DBDSQR without singular vectors
  and the dqds algorithm DLASQ1..DLASQ6, xGESVD with JOBU = JOBVT = 'N'),
  checked as LAPACK checks them in xCHKBD and xDRVBD
  (TESTING/EIG/dchkbd.f, ddrvbd.f, zchkbd.f, zdrvbd.f) with the input of
  TESTING/svd.in.

  The matrix types of xCHKBD: zero; identity; diagonal with entries
  evenly spaced 1 .. ulp, geometric 1 .. ulp and clustered at 1 and ulp
  (xLATM1 modes 4, 3, 1) and random signs, also scaled near the overflow
  and underflow thresholds; U*D*V^H with U, V random orthogonal (unitary)
  and the same D; random entries in (-1, 1), unscaled and scaled; a
  bidiagonal matrix with entries exp(t), t uniform in (2 log ulp,
  -2 log ulp). The generators follow the description of xCHKBD (xLATMS,
  xLATMR); they do not reproduce LAPACK's random streams.

  For every matrix with M >= N (the layer reduces only these), as xCHKBD,
  with ^H the conjugate transpose:
    (1) |A - Q*B*P^H| / (|A| n ulp)     xGEBRD, Q and P formed from the
                                         reflectors (xBDT01)
    (2) |I - Q^H*Q| / (m ulp)            (xORT01, xUNT01)
    (3) |I - P^H*P| / (n ulp)
  and for the bidiagonal B (upper; lower for the bidiagonal type with
  M < N):
    (8) the singular values of DBDSQR are nonnegative and decreasing
    (10) they are the true singular values of B within the tolerance
         THRESH*(1/2 - ulp), doubled until DSVDCH accepts them, as the
         ratio (DSVDCH and DSVDCT: Sturm counts of the 2n x 2n
         tridiagonal matrix [0 B; B^T 0])
  and as xDRVBD for xGESVD of the square matrices:
    (4) the singular values are nonnegative and decreasing, INFO = 0.
  The tests that need singular vectors (xCHKBD 4-7, 9, 11-14, xDRVBD 1-3,
  5-7) are not run: the layer does not compute them. Threshold 50
  (svd.in). The sizes are the (M, N) pairs of svd.in, each with the five
  block sizes and crossover points of svd.in (NB 1 3 3 3 20, NX 1 0 5 9
  1), so that the blocked xGEBRD runs on small matrices; then M = N = 40
  with the default block sizes (unblocked: crossover 128). --extended
  adds 140 x 140 and 200 x 160 with the default block sizes (xGEBRD
  blocked). Residuals are accumulated in double-double. }
unit SpecLapackSvd;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}

interface

implementation

uses
  SysUtils, Math, ADimMath, ADimLapack, TestRunner, TestDoubleDouble,
  TestGenerators, TestMeasures;

const
  { KTYPE, KMAGN, KMODE of xCHKBD. }
  KTYPE: array[1..16] of Integer =
    (1, 2, 4, 4, 4, 4, 4, 6, 6, 6, 6, 6, 9, 9, 9, 10);
  KMAGN: array[1..16] of Integer =
    (1, 1, 1, 1, 1, 2, 3, 1, 1, 1, 2, 3, 1, 2, 3, 0);
  KMODE: array[1..16] of Integer =
    (0, 0, 4, 3, 1, 4, 4, 4, 3, 1, 4, 4, 0, 0, 0, 0);
  SvdM: array[0..18] of Integer =
    (0, 0, 0, 1, 1, 1, 2, 2, 3, 3, 3, 10, 10, 16, 16, 30, 30, 40, 40);
  SvdN: array[0..18] of Integer =
    (0, 1, 3, 0, 1, 2, 0, 1, 0, 1, 3, 10, 16, 10, 16, 30, 40, 30, 40);
  SvdBlocks: array[0..4] of Integer = (1, 3, 3, 3, 20);
  SvdCrossovers: array[0..4] of Integer = (1, 0, 5, 9, 1);
  Overflow = 1.7976931348623157E+308;
  TestCount = 4;
  TestNames: array[0..TestCount - 1] of string = (
    'xCHKBD (1) |A - Q*B*P^H| / (|A| n ulp), xGEBRD',
    'xCHKBD (2) |I - Q^H*Q| / (m ulp), xGEBRD',
    'xCHKBD (3) |I - P^H*P| / (n ulp), xGEBRD',
    'xCHKBD (10) DBDSQR singular values against the Sturm counts (DSVDCH)');

var
  Labels: array[0..TestCount - 1] of array of string;
  Ratios: array[0..TestCount - 1] of array of Double;
  OrderLabels: array of string;
  OrderOk: array of Boolean;
  DriverLabels: array of string;
  DriverOk: array of Boolean;

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

procedure AddOrder(const ALabel: string; AOk: Boolean);
begin
  SetLength(OrderLabels, Length(OrderLabels) + 1);
  SetLength(OrderOk, Length(OrderOk) + 1);
  OrderLabels[High(OrderLabels)] := ALabel;
  OrderOk[High(OrderOk)] := AOk;
end;

procedure AddDriver(const ALabel: string; AOk: Boolean);
begin
  SetLength(DriverLabels, Length(DriverLabels) + 1);
  SetLength(DriverOk, Length(DriverOk) + 1);
  DriverLabels[High(DriverLabels)] := ALabel;
  DriverOk[High(DriverOk)] := AOk;
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

{ A random orthogonal (unitary) matrix of order N, by rows. }
function RandomQ(N: Integer; AComplex: Boolean): TComplexMatrix;
begin
  if AComplex then result := RandomUnitary(Max(N, 1))
  else result := RealToComplexMatrix(RandomOrthogonal(Max(N, 1)));
end;

{ The M x N matrix (by rows) of type AType of xCHKBD; nil for the
  bidiagonal type. }
function TypeMatrix(AType, M, N: Integer; AComplex: Boolean): TArrayOfComplex;
var
  I, J, K, MNMIN: Integer;
  D: TArrayOfReal;
  U, V: TComplexMatrix;
  ANORM, LMax: Double;
  LSum: TDDComplex;
begin
  MNMIN := Min(M, N);
  case KMAGN[AType] of
    2: ANORM := (Sqrt(Overflow) * Ulp) / Max(Max(M, N), 1);
    3: ANORM := Sqrt(SafeMinimum) * Max(M, N) / Ulp;
  else
    ANORM := 1;
  end;
  result := nil;
  if KTYPE[AType] = 10 then Exit;
  SetLength(result, M * N);
  case KTYPE[AType] of
    1: ;
    2: for I := 0 to MNMIN - 1 do result[I * N + I] := ANORM;
    4, 6:
      begin
        D := ModeValues(MNMIN, KMODE[AType], 1 / Ulp);
        for I := 0 to MNMIN - 1 do
        begin
          D[I] := D[I] * ANORM;
          if RandomUniform < 0 then D[I] := -D[I];
        end;
        if KTYPE[AType] = 4 then
          for I := 0 to MNMIN - 1 do result[I * N + I] := D[I]
        else
        begin
          U := RandomQ(M, AComplex);
          V := RandomQ(N, AComplex);
          for I := 0 to M - 1 do
            for J := 0 to N - 1 do
            begin
              LSum := DDComplex(0, 0);
              for K := 0 to MNMIN - 1 do
                LSum := LSum + TDDComplex(U[I, K] * D[K]) *
                  TDDComplex(V[J, K].Conjugate);
              result[I * N + J] := LSum.ToComplex;
            end;
        end;
      end;
    9:
      begin
        { Random entries in (-1, 1), scaled to the largest entry ANORM
          (xLATMR). }
        LMax := 0;
        for I := 0 to M * N - 1 do
        begin
          if AComplex then result[I] := RandomComplex
          else result[I] := RandomUniform;
          LMax := Max(LMax, result[I].Norm);
        end;
        if LMax > 0 then
          for I := 0 to M * N - 1 do result[I] := (ANORM / LMax) * result[I];
      end;
  end;
  if not AComplex then
    for I := 0 to M * N - 1 do result[I].Im := 0;
end;

{ The orthogonal (unitary) factors of xGEBRD with M >= N, from the
  reflectors in AF (by rows): Q (M x M) = H(0)*...*H(n-1) with
  H(i) = I - tauq(i)*v*v^H, v(i) = 1 and v(i+1:m-1) = AF(i+1:m-1, i);
  P (N x N) = G(0)*...*G(n-2) with G(i) = I - taup(i)*u*u^H, u(i+1) = 1
  and u(i+2:n-1) the conjugate of AF(i, i+2:n-1) (xGEBD2 conjugates the
  row before xLARFG and back after). }
procedure FormFactors(M, N: Integer; const AF, TAUQ, TAUP: TArrayOfComplex;
  out Q, P: TArrayOfComplex);
var
  I, J, K: Integer;
  V: TArrayOfComplex;
  LDot: TComplex;
begin
  Q := nil;
  P := nil;
  V := nil;
  SetLength(Q, M * M);
  SetLength(P, N * N);
  SetLength(V, Max(M, N));
  for I := 0 to M - 1 do Q[I * M + I] := 1;
  for I := 0 to N - 1 do P[I * N + I] := 1;
  { Q := H(i)*Q for i = n-1 .. 0. }
  for I := N - 1 downto 0 do
  begin
    for K := 0 to M - 1 do
      if K < I then V[K] := 0
      else if K = I then V[K] := 1
      else V[K] := AF[K * N + I];
    for J := 0 to M - 1 do
    begin
      LDot := 0;
      for K := I to M - 1 do LDot := LDot + V[K].Conjugate * Q[K * M + J];
      LDot := TAUQ[I] * LDot;
      for K := I to M - 1 do Q[K * M + J] := Q[K * M + J] - V[K] * LDot;
    end;
  end;
  { P := G(i)*P for i = n-2 .. 0. }
  for I := N - 2 downto 0 do
  begin
    for K := 0 to N - 1 do
      if K <= I then V[K] := 0
      else if K = I + 1 then V[K] := 1
      else V[K] := AF[I * N + K].Conjugate;
    for J := 0 to N - 1 do
    begin
      LDot := 0;
      for K := I + 1 to N - 1 do LDot := LDot + V[K].Conjugate * P[K * N + J];
      LDot := TAUP[I] * LDot;
      for K := I + 1 to N - 1 do P[K * N + J] := P[K * N + J] - V[K] * LDot;
    end;
  end;
end;

{ SRe + i*SIm += X*Y in double-double; only the real parts when not
  AComplex. }
procedure MulAdd(var SRe, SIm: TDD; const X, Y: TComplex; AComplex: Boolean);
  inline;
begin
  SRe := SRe + TwoProd(X.Re, Y.Re);
  if AComplex then
  begin
    SRe := SRe - TwoProd(X.Im, Y.Im);
    SIm := SIm + TwoProd(X.Re, Y.Im) + TwoProd(X.Im, Y.Re);
  end;
end;

{ xBDT01 with KD = 1 and M >= N: |A - Q*B*P^H| / (|A| n ulp), the norms
  1-norms and B upper bidiagonal (D, E). }
function Bdt01(M, N: Integer; const A, Q, P: TArrayOfComplex;
  const D, E: TArrayOfReal; AComplex: Boolean): Double;
var
  I, J, K: Integer;
  W: TArrayOfComplex;
  SRe, SIm: TDD;
  RESID, ANORM, LCol: Double;
begin
  if (M <= 0) or (N <= 0) then Exit(0);
  W := nil;
  SetLength(W, N);
  RESID := 0;
  for J := 0 to N - 1 do
  begin
    { W = -B*P^H(:, j). }
    for I := 0 to N - 1 do
    begin
      SRe := 0;
      SIm := 0;
      MulAdd(SRe, SIm, P[J * N + I].Conjugate, -D[I], AComplex);
      if I < N - 1 then
        MulAdd(SRe, SIm, P[J * N + I + 1].Conjugate, -E[I], AComplex);
      W[I] := Complex(SRe.ToDouble, SIm.ToDouble);
    end;
    LCol := 0;
    for I := 0 to M - 1 do
    begin
      SRe := A[I * N + J].Re;
      SIm := A[I * N + J].Im;
      for K := 0 to N - 1 do MulAdd(SRe, SIm, Q[I * M + K], W[K], AComplex);
      LCol := LCol + Hypot(SRe.ToDouble, SIm.ToDouble);
    end;
    RESID := Max(RESID, LCol);
  end;
  ANORM := 0;
  for J := 0 to N - 1 do
  begin
    LCol := 0;
    for I := 0 to M - 1 do LCol := LCol + A[I * N + J].Norm;
    ANORM := Max(ANORM, LCol);
  end;
  if ANORM <= 0 then
  begin
    if RESID <> 0 then result := 1 / Ulp else result := 0;
  end else if ANORM >= RESID then
    result := (RESID / ANORM) / (N * Ulp)
  else if ANORM < 1 then
    result := (Min(RESID, N * ANORM) / ANORM) / (N * Ulp)
  else
    result := Min(RESID / ANORM, N) / (N * Ulp);
end;

{ xORT01 (xUNT01) for the square matrix U of order N, by rows, with
  ROWCOL = 'C' (|I - U^H*U|) or 'R' (|I - U*U^H|): the 1-norm of the
  Hermitian residual from its upper triangle (xLANSY), over (N ulp). }
function Ort01(AColumns: Boolean; N: Integer; const U: TArrayOfComplex;
  AComplex: Boolean): Double;
var
  I, J, K: Integer;
  W: TArrayOfReal;
  SRe, SIm: TDD;
  LCol: Double;
begin
  if N <= 0 then Exit(0);
  W := nil;
  SetLength(W, N * N);
  for I := 0 to N - 1 do
    for J := I to N - 1 do
    begin
      if I = J then SRe := 1 else SRe := 0;
      SIm := 0;
      for K := 0 to N - 1 do
        if AColumns then
          MulAdd(SRe, SIm, -U[K * N + I].Conjugate, U[K * N + J], AComplex)
        else
          MulAdd(SRe, SIm, -U[I * N + K], U[J * N + K].Conjugate, AComplex);
      W[I * N + J] := Hypot(SRe.ToDouble, SIm.ToDouble);
      W[J * N + I] := W[I * N + J];
    end;
  result := 0;
  for J := 0 to N - 1 do
  begin
    LCol := 0;
    for I := 0 to N - 1 do LCol := LCol + W[I * N + J];
    result := Max(result, LCol);
  end;
  result := (result / N) / Ulp;
end;

{ DSVDCT: the number of eigenvalues of the 2n x 2n tridiagonal matrix
  with zero diagonal and off-diagonal S(1), E(1), S(2), ..., S(n) that are
  less than or equal to SHIFT, by Sturm sequence with scaling. }
function Svdct(N: Integer; const S, E: TArrayOfReal; SHIFT: Double): Integer;
var
  I: Integer;
  UNFL, OVFL, MX, SUN, SSUN, SOV, TOM, M1, M2, U, SSHIFT, TMP: Double;

  procedure Count;
  begin
    if U <= SUN then
      if U <= 0 then
      begin
        Inc(result);
        if U > -SUN then U := -SUN;
      end else
        U := SUN;
  end;

begin
  UNFL := 2 * SafeMinimum;
  OVFL := 1 / UNFL;
  MX := System.Abs(S[0]);
  for I := 0 to N - 2 do
    MX := Max(MX, Max(System.Abs(S[I + 1]), System.Abs(E[I])));
  if MX = 0 then
  begin
    if SHIFT < 0 then result := 0 else result := 2 * N;
    Exit;
  end;
  SUN := Sqrt(UNFL);
  SSUN := Sqrt(SUN);
  SOV := Sqrt(OVFL);
  TOM := SSUN * SOV;
  if MX <= 1 then
  begin
    M1 := 1 / MX;
    M2 := TOM;
  end else
  begin
    M1 := 1;
    M2 := TOM / MX;
  end;
  result := 0;
  SSHIFT := (SHIFT * M1) * M2;
  U := -SSHIFT;
  Count;
  TMP := (S[0] * M1) * M2;
  U := -TMP * (TMP / U) - SSHIFT;
  Count;
  for I := 0 to N - 2 do
  begin
    TMP := (E[I] * M1) * M2;
    U := -TMP * (TMP / U) - SSHIFT;
    Count;
    TMP := (S[I + 1] * M1) * M2;
    U := -TMP * (TMP / U) - SSHIFT;
    Count;
  end;
end;

{ DSVDCH: 0 when every computed singular value SVD (decreasing) of the
  bidiagonal (S, E) agrees with the Sturm counts within TOL; otherwise
  the index (from 1) of the first cluster that fails. }
function Svdch(N: Integer; const S, E, SVD: TArrayOfReal; TOL: Double): Integer;
var
  TPNT, BPNT, NUML, NUMU, COUNT_: Integer;
  UNFL, OVFL, EPS, UNFLEP, UPPER, LOWER, TUPPR: Double;
begin
  result := 0;
  if N <= 0 then Exit;
  UNFL := SafeMinimum;
  OVFL := Overflow;
  EPS := UnitRoundoff * 2;
  { UNFLEP is chosen so that when an eigenvalue is multiplied by the
    scale factor sqrt(OVFL)*sqrt(sqrt(UNFL))/MX in DSVDCT, it exceeds
    sqrt(UNFL), which is the lower limit for DSVDCT. }
  UNFLEP := (Sqrt(Sqrt(UNFL)) / Sqrt(OVFL)) * SVD[0] + UNFL / EPS;
  { The value of EPS works best when TOL .GE. 10. }
  EPS := TOL * Max(N div 10, 1) * EPS;
  { TPNT points to singular value at right endpoint of interval, BPNT to
    the one at the left endpoint (from 1). }
  TPNT := 1;
  BPNT := 1;
  repeat
    { Begin loop over all intervals. }
    UPPER := (1 + EPS) * SVD[TPNT - 1] + UNFLEP;
    LOWER := (1 - EPS) * SVD[BPNT - 1] - UNFLEP;
    if LOWER <= UNFLEP then LOWER := -UPPER;
    { Begin loop merging overlapping intervals. }
    while BPNT <> N do
    begin
      TUPPR := (1 + EPS) * SVD[BPNT] + UNFLEP;
      if TUPPR < LOWER then Break;
      { Merge. }
      BPNT := BPNT + 1;
      LOWER := (1 - EPS) * SVD[BPNT - 1] - UNFLEP;
      if LOWER <= UNFLEP then LOWER := -UPPER;
    end;
    { Count singular values in interval [LOWER, UPPER]. }
    NUML := Svdct(N, S, E, LOWER);
    NUMU := Svdct(N, S, E, UPPER);
    COUNT_ := NUMU - NUML;
    if LOWER < 0 then COUNT_ := COUNT_ div 2;
    if COUNT_ <> BPNT - TPNT + 1 then
      { Wrong number of singular values in interval. }
      Exit(TPNT);
    TPNT := BPNT + 1;
    BPNT := TPNT;
  until TPNT > N;
end;

function Ordered(N: Integer; const S: TArrayOfReal): Boolean;
var
  I: Integer;
begin
  result := True;
  for I := 0 to N - 1 do
  begin
    if S[I] < 0 then result := False;
    if (I < N - 1) and (S[I] < S[I + 1]) then result := False;
  end;
end;

{ DBDSQR on the bidiagonal (BD, BE) with UPLO: tests (8) and (10). }
procedure CheckBidiagonal(const AUplo: Char; MNMIN: Integer;
  const BD, BE: TArrayOfReal; const LName: string);
var
  S1, E1: TArrayOfReal;
  INFO, J, LOG2UI: Integer;
  TEMP1: Double;
begin
  S1 := System.Copy(BD, 0, MNMIN);
  E1 := nil;
  SetLength(E1, Max(MNMIN, 1));
  for J := 0 to MNMIN - 2 do E1[J] := BE[J];
  DBDSQR(AUplo, MNMIN, S1, E1, INFO);
  AddOrder(LName, (INFO = 0) and Ordered(MNMIN, S1));
  { (10): the smallest tolerance of the ladder THRESH*(1/2 - ulp)*2^j
    that DSVDCH accepts. }
  LOG2UI := Trunc(Ln(1 / Ulp) / Ln(2));
  TEMP1 := LAPACKSVDThreshold * (0.5 - Ulp);
  for J := 0 to LOG2UI do
  begin
    if (INFO = 0) and (Svdch(MNMIN, BD, BE, S1, TEMP1) = 0) then Break;
    TEMP1 := TEMP1 * 2;
  end;
  AddRatio(3, LName, TEMP1);
end;

procedure CheckMatrix(AComplex: Boolean; AType, M, N: Integer;
  const AName: string);
var
  A, AF, Q, P, TAUQ, TAUP: TArrayOfComplex;
  RA, RTQ, RTP, BD, BE, S: TArrayOfReal;
  MNMIN, I, INFO: Integer;
  TEMP1: Double;
  LName: string;
begin
  MNMIN := Min(M, N);
  LName := Format('%s m=%d n=%d type %d', [AName, M, N, AType]);
  BD := nil;
  BE := nil;
  SetLength(BD, MNMIN);
  SetLength(BE, Max(MNMIN - 1, 0));
  if KTYPE[AType] = 10 then
  begin
    { Bidiagonal with entries exp(t), t uniform in (2 log ulp,
      -2 log ulp). }
    TEMP1 := -2 * Ln(Ulp);
    for I := 0 to MNMIN - 1 do
    begin
      BD[I] := Exp(TEMP1 * RandomUniform);
      if I < MNMIN - 1 then BE[I] := Exp(TEMP1 * RandomUniform);
    end;
    if M >= N then CheckBidiagonal('U', MNMIN, BD, BE, LName)
    else CheckBidiagonal('L', MNMIN, BD, BE, LName);
    Exit;
  end;
  { The layer reduces M >= N. }
  if M < N then Exit;
  A := TypeMatrix(AType, M, N, AComplex);
  { xGEBRD. }
  AF := System.Copy(A);
  TAUQ := nil;
  TAUP := nil;
  SetLength(TAUQ, N);
  SetLength(TAUP, N);
  if AComplex then
    ZGEBRD(M, N, AF, 0, N, BD, BE, TAUQ, TAUP)
  else
  begin
    RA := nil;
    SetLength(RA, M * N);
    for I := 0 to M * N - 1 do RA[I] := AF[I].Re;
    RTQ := nil;
    RTP := nil;
    SetLength(RTQ, N);
    SetLength(RTP, N);
    DGEBRD(M, N, RA, 0, N, BD, BE, RTQ, RTP);
    for I := 0 to M * N - 1 do AF[I] := RA[I];
    for I := 0 to N - 1 do
    begin
      TAUQ[I] := RTQ[I];
      TAUP[I] := RTP[I];
    end;
  end;
  FormFactors(M, N, AF, TAUQ, TAUP, Q, P);
  AddRatio(0, LName, Bdt01(M, N, A, Q, P, BD, BE, AComplex));
  AddRatio(1, LName, Ort01(True, M, Q, AComplex));
  AddRatio(2, LName, Ort01(False, N, P, AComplex));
  CheckBidiagonal('U', MNMIN, BD, BE, LName);
  { xDRVBD (4) for xGESVD with JOBU = JOBVT = 'N'. }
  if M = N then
  begin
    S := nil;
    SetLength(S, N);
    AF := System.Copy(A);
    if AComplex then
      ZGESVD(N, AF, 0, N, S, INFO)
    else
    begin
      for I := 0 to N * N - 1 do RA[I] := A[I].Re;
      DGESVD(N, RA, 0, N, S, INFO);
    end;
    AddDriver(LName, (INFO = 0) and Ordered(N, S));
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
  DriverLabels := nil;
  DriverOk := nil;
  SetSeed(1501 + Ord(AComplex));
  try
    for S := Low(SvdBlocks) to High(SvdBlocks) do
    begin
      LapackBlockSize := SvdBlocks[S];
      LapackCrossover := SvdCrossovers[S];
      for K := Low(SvdM) to High(SvdM) do
        for T := 1 to 16 do
          CheckMatrix(AComplex, T, SvdM[K], SvdN[K],
            Format('NB=%d NX=%d', [SvdBlocks[S], SvdCrossovers[S]]));
    end;
    LapackBlockSize := -1;
    LapackCrossover := -1;
    for T := 1 to 16 do
      CheckMatrix(AComplex, T, 40, 40, 'default blocks');
    if ExtendedMode then
      for T := 1 to 16 do
      begin
        CheckMatrix(AComplex, T, 140, 140, 'default blocks');
        CheckMatrix(AComplex, T, 200, 160, 'default blocks');
      end;
  finally
    LapackBlockSize := -1;
    LapackCrossover := -1;
  end;
  Group(Prefix[AComplex] +
    'CHKBD (8) DBDSQR singular values nonnegative and decreasing, INFO = 0',
    ckContract);
  for K := 0 to High(OrderOk) do Check(OrderLabels[K], OrderOk[K]);
  Group(Prefix[AComplex] +
    'DRVBD (4) xGESVD singular values nonnegative and decreasing, INFO = 0',
    ckContract);
  for K := 0 to High(DriverOk) do Check(DriverLabels[K], DriverOk[K]);
  for LTest := 0 to TestCount - 1 do
  begin
    Group(Prefix[AComplex] + Copy(TestNames[LTest], 2, MaxInt), ckStability,
      LAPACKSVDThreshold, tsLAPACK, 'svd.in');
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
  RegisterSpec('LAPACK layer: singular values (xCHKBD, xDRVBD)', @RunSpec);
end.
