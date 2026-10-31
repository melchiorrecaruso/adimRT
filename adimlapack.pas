{ Internal LAPACK layer of ADimMath.

  Each routine follows the reference LAPACK routine of the same name: same
  algorithm, arguments and results, so that it can be checked one to one
  against LAPACK. The only differences of convention are that indices
  start at 0 and that an N x M matrix is stored by rows in a dynamic array
  of N*M entries (entry (i, j) at index i*M + j). Indices that LAPACK
  returns in floating point arrays (SCALE of xGEBAL) are 0-based as well.
  Routines shared by the real and the complex case are written once as
  generic procedures and specialized by the D and Z entry points.
  Routines that LAPACK applies to submatrices take the array with an
  offset and a row stride (entry (i, j) at A[AO + i*LDA + j]).

  The routines reproduce LAPACK 3.12.1 with the reference BLAS bit for
  bit, as compiled by gfortran: the order of every sum follows the
  reference BLAS, real-complex operations and complex divisions follow
  gfortran (FMUL, FADD, FDIV, ZLADIV), real constants are typed (Free
  Pascal evaluates untyped real constants in Extended on x86_64) and so
  are the arguments of Min and Max (with an integer literal Free Pascal
  selects their Single overload). The functions that gfortran takes from
  the C library (hypot for |z|, csqrt, log) are translations of those of
  glibc 2.43 (GLIBCHYPOT, GLIBCCSQRT, GLIBCLOG). The work arrays of LAPACK
  are allocated by the routines, as large as LAPACK's optimal workspace;
  where the layer uses an unblocked form of a blocked LAPACK routine the
  comment says so.

  This unit is an implementation detail of ADimMath and is not part of
  the public interface of the library.

  @author Melchiorre Caruso (melchiorrecaruso@@gmail.com)
  @copyright 2025-2026 Melchiorre Caruso
  @license MIT License, see the file LICENSE.

  This unit is part of the ADim library, distributed under the MIT License
  (see the file LICENSE).

  The routines of this unit are translations to Pascal of routines of
  LAPACK 3.12 (https://www.netlib.org/lapack), including parts of their
  comments, and are distributed under the license of LAPACK, reproduced
  below and in the file COPYING.LAPACK:

  Copyright (c) 1992-2025 The University of Tennessee and The University
                          of Tennessee Research Foundation.  All rights
                          reserved.
  Copyright (c) 2000-2025 The University of California Berkeley. All
                          rights reserved.
  Copyright (c) 2006-2025 The University of Colorado Denver.  All rights
                          reserved.

  $COPYRIGHT$

  Additional copyrights may follow

  $HEADER$

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:

  - Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.

  - Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer listed
    in this license in the documentation and/or other materials
    provided with the distribution.

  - Neither the name of the copyright holders nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

  The copyright holders provide no reassurances that the source code
  provided does not infringe any patent, copyright, or any other
  intellectual property rights of third parties.  The copyright holders
  disclaim any liability to any recipient for claims brought against
  recipient by any third party for infringement of that parties
  intellectual property rights.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}

unit ADimLapack;

{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function's return value.
{$WARN 6058 OFF} // Suppress warning for function marked as inline that cannot be inlined.
{ Free Pascal 3.2.x on x86_64 miscompiles accesses to open array
  parameters when local variables are kept in registers (REGVAR, enabled
  by -O2 and above): the element index and the array address are loaded
  into the same register, and the access raises an access violation. }
{$OPTIMIZATION NOREGVAR}

interface

uses
  ADimMath;

{ |Re| + |Im|, the modulus used by LAPACK to choose pivots
  (CABS1 in the complex routines); |x| for a real number. }
function CABS1(const AValue: TReal): TReal; overload; inline;

function CABS1(const AValue: TComplex): TReal; overload; inline;

{ Balancing of a general matrix, JOB = 'B': permutation to
  isolate eigenvalues, then diagonal scaling by powers of two
  (A := D^-1*P^T*A*P*D). On exit A[ILO..IHI, ILO..IHI] is the part left to
  the eigenvalue solver; SCALE holds the permutation indices outside
  ILO..IHI and the scaling factors inside. }
procedure DGEBAL(N: longint; var A: TArrayOfReal; out ILO, IHI: longint;
  out SCALE: TArrayOfReal);

procedure ZGEBAL(N: longint; var A: TArrayOfComplex; out ILO, IHI: longint;
  out SCALE: TArrayOfReal);

{ Back transformation of the M right eigenvectors V (N x M) of
  a matrix balanced by xGEBAL, JOB = 'B', SIDE = 'R'. }
procedure DGEBAK(N, ILO, IHI: longint; const SCALE: TArrayOfReal; M: longint;
  var V: TArrayOfReal);

procedure ZGEBAK(N, ILO, IHI: longint; const SCALE: TArrayOfReal; M: longint;
  var V: TArrayOfComplex);

{ Elementary reflector H = I - TAU*v*v^T (v[0] = 1) such that
  H*(ALPHA, x) = (beta, 0). X holds x in X[XOffset], X[XOffset + INCX],
  ... (N - 1 entries); on exit ALPHA = beta and X holds v[1..]. }
procedure DLARFG(N: longint; var ALPHA: TReal; var X: array of TReal;
  XOffset, INCX: longint; out TAU: TReal);

{ Complex reflector H = I - TAU*v*v^H with H^H*(ALPHA, x) =
  (beta, 0), beta real. }
procedure ZLARFG(N: longint; var ALPHA: TComplex; var X: array of TComplex;
  XOffset, INCX: longint; out TAU: TComplex);

{ Reduction to upper Hessenberg form Q^T*A*Q = H in rows and
  columns ILO..IHI (xGEHRD with the optimal work space: blocked with
  xLAHR2 when IHI-ILO+1 exceeds the crossover 128, then xGEHD2). On exit
  A holds H on and above the first subdiagonal and the reflectors below
  it; TAU has N - 1 entries. }
procedure DGEHRD(N, ILO, IHI: longint; var A: TArrayOfReal;
  out TAU: TArrayOfReal);

procedure ZGEHRD(N, ILO, IHI: longint; var A: TArrayOfComplex;
  out TAU: TArrayOfComplex);

{ Overwrites the output of xGEHRD with the orthogonal (unitary)
  matrix Q = H(ILO)*H(ILO+1)*...*H(IHI-1) (xORGHR, with xORGQR). }
procedure DORGHR(N, ILO, IHI: longint; var A: TArrayOfReal;
  const TAU: TArrayOfReal);

procedure ZUNGHR(N, ILO, IHI: longint; var A: TArrayOfComplex;
  const TAU: TArrayOfComplex);

{ Schur factorization of a real 2x2 block in standard form:
  [A B; C D] = [CS -SN; SN CS] * [AA BB; CC DD] * [CS SN; -SN CS], with
  CC = 0 (real eigenvalues) or AA = DD and BB*CC < 0 (complex pair). On
  exit A, B, C, D hold AA, BB, CC, DD; the eigenvalues are
  (RT1R, RT1I) and (RT2R, RT2I). }
procedure DLANV2(var A, B, C, D: TReal; out RT1R, RT1I, RT2R, RT2I, CS,
  SN: TReal);

{ Tuning parameters of xHSEQR and of the routines it calls, the values
  of ILAENV for ISPEC = 12 (NMIN, order from which xLAQR0 is used),
  13 (NWIN, deflation window), 14 (NIBBLE), 15 (NSHFTS, number of
  shifts) and 16 (KACC22). A negative value (the default) selects the
  value of LAPACK's IPARMQ; the LAPACK test programs set them to exercise
  xLAQR0 on small matrices (TESTING/nep.in), and so do the tests of this
  unit. }
type
  TLapackTuning = record
    NMIN, NWIN, NIBBLE, NSHFTS, KACC22: longint;
  end;

const
  LapackDefaultTuning: TLapackTuning =
    (NMIN: -1; NWIN: -1; NIBBLE: -1; NSHFTS: -1; KACC22: -1);

var
  LapackTuning: TLapackTuning =
    (NMIN: -1; NWIN: -1; NIBBLE: -1; NSHFTS: -1; KACC22: -1);

  { Block size of xGETRF, xGETRI and xTRTRI, the value of ILAENV for
    ISPEC = 1; a negative value (the default) selects 64, the value of
    LAPACK's ILAENV; it also sets the block size of xSYTRD, xORGQR and
    xORGQL (default 32). The LAPACK test programs set it to small values
    to exercise the blocked code on small matrices (TESTING/dtest.in,
    sep.in). }
  LapackBlockSize: longint = -1;

  { Crossover point from blocked to unblocked code of xSYTRD, xORGQR and
    xORGQL, the value of ILAENV for ISPEC = 3; a negative value (the
    default) selects that of LAPACK's ILAENV (32 and 128). }
  LapackCrossover: longint = -1;

{ Double-shift QR iteration on rows and columns ILO..IHI of the N x N
  Hessenberg matrix H (entry (i, j) at H[HO + i*LDH + j]), as DLAHQR: the
  full Schur form when WANTT, otherwise only the active block; the
  transformations are applied to rows ILOZ..IHIZ of Z (at Z[ZO], row
  stride LDZ) when WANTZ. The eigenvalues of rows ILO..IHI go to
  WR[WO + i] + i*WI[WO + i]. INFO > 0 when the iteration fails to
  converge: the eigenvalues INFO..IHI have been found and rows and
  columns ILO..INFO-1 still hold an unreduced block. }
procedure DLAHQR(WANTT, WANTZ: boolean; N, ILO, IHI: longint;
  var H: array of TReal; HO, LDH: longint; var WR, WI: array of TReal;
  WO, ILOZ, IHIZ: longint; var Z: array of TReal; ZO, LDZ: longint;
  out INFO: longint);

{ Small-bulge multishift QR with aggressive early deflation (DLAQR0);
  arguments as DLAHQR. The workspace is the optimal one of LAPACK. }
procedure DLAQR0(WANTT, WANTZ: boolean; N, ILO, IHI: longint;
  var H: array of TReal; HO, LDH: longint; var WR, WI: array of TReal;
  WO, ILOZ, IHIZ: longint; var Z: array of TReal; ZO, LDZ: longint;
  out INFO: longint);

{ Aggressive early deflation on the window of order NW at the bottom of
  rows KTOP..KBOT (DLAQR3): ND eigenvalues deflated, NS shifts returned in
  SR[SO + KBOT-ND-NS+1 ..], SI[..]. }
procedure DLAQR3(WANTT, WANTZ: boolean; N, KTOP, KBOT, NW: longint;
  var H: array of TReal; HO, LDH, ILOZ, IHIZ: longint; var Z: array of TReal;
  ZO, LDZ: longint; out NS, ND: longint; var SR, SI: array of TReal;
  SO: longint);

{ One small-bulge multishift QR sweep with the NSHFTS shifts
  SR[SO..] + i*SI[SO..] on rows KTOP..KBOT (DLAQR5). }
procedure DLAQR5(WANTT, WANTZ: boolean; KACC22, N, KTOP, KBOT,
  NSHFTS: longint; var SR, SI: array of TReal; SO: longint;
  var H: array of TReal; HO, LDH, ILOZ, IHIZ: longint; var Z: array of TReal;
  ZO, LDZ: longint);

{ Reordering of the real Schur form T (N x N, by rows) with Schur vectors
  Q so that the block at row IFST moves to row ILST (DTREXC, COMPQ =
  'V'). }
procedure DTREXC(N: longint; var T, Q: array of TReal; var IFST, ILST: longint;
  out INFO: longint);

{ Single-shift complex QR iteration, as DLAHQR; W[WO + i] receives the
  eigenvalues. }
procedure ZLAHQR(WANTT, WANTZ: boolean; N, ILO, IHI: longint;
  var H: array of TComplex; HO, LDH: longint; var W: array of TComplex;
  WO, ILOZ, IHIZ: longint; var Z: array of TComplex; ZO, LDZ: longint;
  out INFO: longint);

{ Complex counterparts of DLAQR0, DLAQR3 and DLAQR5. }
procedure ZLAQR0(WANTT, WANTZ: boolean; N, ILO, IHI: longint;
  var H: array of TComplex; HO, LDH: longint; var W: array of TComplex;
  WO, ILOZ, IHIZ: longint; var Z: array of TComplex; ZO, LDZ: longint;
  out INFO: longint);

procedure ZLAQR3(WANTT, WANTZ: boolean; N, KTOP, KBOT, NW: longint;
  var H: array of TComplex; HO, LDH, ILOZ, IHIZ: longint;
  var Z: array of TComplex; ZO, LDZ: longint; out NS, ND: longint;
  var SH: array of TComplex; SO: longint);

procedure ZLAQR5(WANTT, WANTZ: boolean; KACC22, N, KTOP, KBOT,
  NSHFTS: longint; var S: array of TComplex; SO: longint;
  var H: array of TComplex; HO, LDH, ILOZ, IHIZ: longint;
  var Z: array of TComplex; ZO, LDZ: longint);

{ Reordering of the complex Schur form (ZTREXC, COMPQ = 'V'). }
procedure ZTREXC(N: longint; var T, Q: array of TComplex; IFST,
  ILST: longint);

{ Schur factorization of the N x N Hessenberg matrix H (stored by rows)
  in rows and columns ILO..IHI, as DHSEQR: JOB = 'S' computes the Schur
  form T, 'E' only the eigenvalues WR + i*WI (N entries, allocated by the
  caller); COMPZ = 'V' multiplies Z by the Schur vectors, 'I' starts Z
  from the identity, 'N' leaves Z alone. xLAQR0 is used from order NMIN
  (75), xLAHQR below. INFO > 0 when the iteration fails to converge, with
  the eigenvalues INFO..N-1 found. }
procedure DHSEQR(JOB, COMPZ: char; N, ILO, IHI: longint; var H: array of TReal;
  var WR, WI: array of TReal; var Z: array of TReal; out INFO: longint);

{ Complex counterpart of DHSEQR. }
procedure ZHSEQR(JOB, COMPZ: char; N, ILO, IHI: longint;
  var H: array of TComplex; var W: array of TComplex; var Z: array of TComplex;
  out INFO: longint);

{ Plane rotation [CS SN; -SN CS] * (F, G) = (R, 0) (DLARTG,
  LAPACK 3.10). }
procedure DLARTG(F, G: TReal; out CS, SN, R: TReal);

{ Right eigenvectors of the real upper quasi-triangular Schur form T
  (N x N at T[TO], row stride LDT), back-transformed by the Schur vectors
  held in VR on entry (DTREVC3 with SIDE = 'R', HOWMNY = 'B'). A complex
  pair occupies two columns, real and imaginary part of the eigenvector
  of the eigenvalue with positive imaginary part; every vector is scaled
  so that its largest component has |Re| + |Im| = 1. LWORK is the work
  space of LAPACK, from which the block size of the back-transformation
  is derived (< 0: the optimal one). }
procedure DTREVC3(N: longint; const T: array of TReal; TO_, LDT: longint;
  var VR: array of TReal; VRO, LDVR: longint; LWORK: longint);

{ Complex counterpart of DTREVC3 (ZTREVC3) for the upper triangular T,
  whose diagonal is modified during the computation and restored. }
procedure ZTREVC3(N: longint; var T: array of TComplex; TO_, LDT: longint;
  var VR: array of TComplex; VRO, LDVR: longint; LWORK: longint);

{ Eigenvalues (WR + i*WI) and right eigenvectors of a general
  real matrix (JOBVL = 'N', JOBVR = 'V') with the optimal work space:
  scaling of A to a safe range, DGEBAL, DGEHRD, DORGHR, DHSEQR, DTREVC3,
  DGEBAK, and normalization of the eigenvectors to unit 2-norm with the
  largest component real. VR has the layout of DTREVC3. A is
  overwritten. }
procedure DGEEV(N: longint; var A: TArrayOfReal; out WR, WI: TArrayOfReal;
  out VR: TArrayOfReal);

{ Complex counterpart of DGEEV. }
procedure ZGEEV(N: longint; var A: TArrayOfComplex; out W: TArrayOfComplex;
  out VR: TArrayOfComplex);

{ Reference BLAS. Vectors are given by array, offset and increment,
  matrices by array, offset and row stride; TRANS = 'N', 'T' or 'C'
  selects op(A) = A, A^T or A^H. }
function DDOT(N: longint; const X: array of TReal; XO, INCX: longint;
  const Y: array of TReal; YO, INCY: longint): TReal;

function ZDOTU(N: longint; const X: array of TComplex; XO, INCX: longint;
  const Y: array of TComplex; YO, INCY: longint): TComplex;

function ZDOTC(N: longint; const X: array of TComplex; XO, INCX: longint;
  const Y: array of TComplex; YO, INCY: longint): TComplex;

function DNRM2(N: longint; const X: array of TReal; XO, INCX: longint): TReal;

function DZNRM2(N: longint; const X: array of TComplex;
  XO, INCX: longint): TReal;

{ y := alpha*op(A)*x + beta*y for the M x N matrix A. }
procedure DGEMV(TRANS: char; M, N: longint; ALPHA: TReal;
  const A: array of TReal; AO, LDA: longint; const X: array of TReal;
  XO, INCX: longint; BETA: TReal; var Y: array of TReal; YO, INCY: longint);

procedure ZGEMV(TRANS: char; M, N: longint; const ALPHA: TComplex;
  const A: array of TComplex; AO, LDA: longint; const X: array of TComplex;
  XO, INCX: longint; const BETA: TComplex; var Y: array of TComplex;
  YO, INCY: longint);

{ C := alpha*op(A)*op(B) + beta*C for the M x N matrix C, op(A) M x K.
  C must not overlap A or B. }
procedure DGEMM(TRANSA, TRANSB: char; M, N, K: longint; ALPHA: TReal;
  const A: array of TReal; AO, LDA: longint; const B: array of TReal;
  BO, LDB: longint; BETA: TReal; var C: array of TReal; CO, LDC: longint);

procedure ZGEMM(TRANSA, TRANSB: char; M, N, K: longint;
  const ALPHA: TComplex; const A: array of TComplex; AO, LDA: longint;
  const B: array of TComplex; BO, LDB: longint; const BETA: TComplex;
  var C: array of TComplex; CO, LDC: longint);

{ B := alpha*inv(op(A))*B (SIDE = 'L') or alpha*B*inv(op(A)) ('R') for
  the M x N matrix B and the UPLO ('U' or 'L') triangle of A, with a
  unit (DIAG = 'U') or non-unit ('N') diagonal. }
procedure DTRSM(SIDE, UPLO, TRANSA, DIAG: char; M, N: longint; ALPHA: TReal;
  const A: array of TReal; AO, LDA: longint; var B: array of TReal;
  BO, LDB: longint);

procedure ZTRSM(SIDE, UPLO, TRANSA, DIAG: char; M, N: longint;
  const ALPHA: TComplex; const A: array of TComplex; AO, LDA: longint;
  var B: array of TComplex; BO, LDB: longint);

{ B := alpha*op(A)*B (SIDE = 'L') or alpha*B*op(A) ('R'), A triangular. }
procedure DTRMM(SIDE, UPLO, TRANSA, DIAG: char; M, N: longint; ALPHA: TReal;
  const A: array of TReal; AO, LDA: longint; var B: array of TReal;
  BO, LDB: longint);

procedure ZTRMM(SIDE, UPLO, TRANSA, DIAG: char; M, N: longint;
  const ALPHA: TComplex; const A: array of TComplex; AO, LDA: longint;
  var B: array of TComplex; BO, LDB: longint);

{ Norm of the M x N matrix A: largest |a(i,j)| (NORM = 'M'), 1-norm
  ('1' or 'O'), infinity norm ('I') or Frobenius norm ('F' or 'E'). }
function DLANGE(NORM: char; M, N: longint; const A: array of TReal;
  AO, LDA: longint): TReal;

function ZLANGE(NORM: char; M, N: longint; const A: array of TComplex;
  AO, LDA: longint): TReal;

{ LU factorization with partial pivoting P*A = L*U of the M x N matrix
  A: blocked, with the recursive xGETRF2 on the panels (on the whole
  matrix when min(M, N) <= 64). On exit A holds U and the multipliers of
  the unit lower triangular L; IPIV[k] (min(M, N) entries, allocated by
  the caller) is the 0-based row exchanged with row k. INFO = k+1 when
  U(k,k) is exactly zero (the first such k); the factorization is
  completed anyway. }
procedure DGETRF(M, N: longint; var A: array of TReal; AO, LDA: longint;
  var IPIV: array of longint; out INFO: longint);

procedure ZGETRF(M, N: longint; var A: array of TComplex; AO, LDA: longint;
  var IPIV: array of longint; out INFO: longint);

{ Solves A*X = B (TRANS = 'N'), A^T*X = B ('T') or A^H*X = B ('C') with
  the factors computed by xGETRF. B is N x NRHS and is overwritten by X. }
procedure DGETRS(TRANS: char; N, NRHS: longint; const A: array of TReal;
  AO, LDA: longint; const IPIV: array of longint; var B: array of TReal;
  BO, LDB: longint);

procedure ZGETRS(TRANS: char; N, NRHS: longint; const A: array of TComplex;
  AO, LDA: longint; const IPIV: array of longint; var B: array of TComplex;
  BO, LDB: longint);

{ Inverse of A from the factors computed by xGETRF (blocked above order
  64). INFO = k+1 when U(k,k) is exactly zero; A is then not inverted. }
procedure DGETRI(N: longint; var A: array of TReal; AO, LDA: longint;
  const IPIV: array of longint; out INFO: longint);

procedure ZGETRI(N: longint; var A: array of TComplex; AO, LDA: longint;
  const IPIV: array of longint; out INFO: longint);

{ Solves op(A)*x = SCALE*b for the triangular matrix held in the
  UPLO ('U' or 'L') triangle of A, with op(A) = A ('N'), A^T ('T') or
  A^H ('C') and a unit (DIAG = 'U') or non-unit ('N') diagonal. SCALE in
  [0, 1] is chosen so that x does not overflow; SCALE = 0 means that A is
  singular and x is a null vector. CNORM holds the 1-norms of the
  off-diagonal parts of the columns, computed when NORMIN = 'N' and taken
  as given when NORMIN = 'Y'. Column norms beyond the overflow threshold
  are not handled: the summation raises EOverflow first. }
procedure DLATRS(UPLO, TRANS, DIAG, NORMIN: char; N: longint;
  const A: array of TReal; AO, LDA: longint; var X: array of TReal;
  out SCALE: TReal; var CNORM: array of TReal);

procedure ZLATRS(UPLO, TRANS, DIAG, NORMIN: char; N: longint;
  const A: array of TComplex; AO, LDA: longint; var X: array of TComplex;
  out SCALE: TReal; var CNORM: array of TReal);

{ Estimate of the 1-norm of a matrix A by reverse communication
  (Hager and Higham). Start with KASE = 0; on return with KASE = 1 the
  caller overwrites X with A*X, with KASE = 2 with A^T*X (A^H*X for
  ZLACN2), and calls again; KASE = 0 on return means that EST holds the
  estimate and V = A*W with EST = ||V||_1 / ||W||_1. ISAVE (3 entries)
  keeps the state between calls, with the 0-based index in ISAVE[1]. }
procedure DLACN2(N: longint; var V, X: array of TReal;
  var ISGN: array of longint; var EST: TReal; var KASE: longint;
  var ISAVE: array of longint);

procedure ZLACN2(N: longint; var V, X: array of TComplex; var EST: TReal;
  var KASE: longint; var ISAVE: array of longint);

{ Estimate of the reciprocal condition number in the 1-norm
  (NORM = '1'), RCOND = 1 / (ANORM * ||A^-1||_1), from the factors
  computed by xGETRF and ANORM = ||A||_1. RCOND = 0 when the estimate of
  ||A^-1||_1 overflows. INFO = -5 for an ANORM that is NaN or infinite,
  INFO = 1 when RCOND is NaN or infinite. }
procedure DGECON(NORM: char; N: longint; const A: array of TReal;
  AO, LDA: longint; ANORM: TReal; out RCOND: TReal; out INFO: longint);

procedure ZGECON(NORM: char; N: longint; const A: array of TComplex;
  AO, LDA: longint; ANORM: TReal; out RCOND: TReal; out INFO: longint);

{ All eigenvalues (ascending, in W, N entries allocated by the caller)
  and eigenvectors (in the columns of A) of a real symmetric (complex
  Hermitian) matrix stored in the UPLO ('U' or 'L') triangle of A, as
  xSYEV (xHEEV) with JOBZ = 'V': xSYTRD (xHETRD), xORGTR (xUNGTR) and
  xSTEQR. INFO = i > 0 when xSTEQR failed to converge. }
procedure DSYEV(UPLO: char; N: longint; var A: array of TReal;
  AO, LDA: longint; var W: array of TReal; out INFO: longint);

procedure ZHEEV(UPLO: char; N: longint; var A: array of TComplex;
  AO, LDA: longint; var W: array of TReal; out INFO: longint);

{ Reduction to real symmetric tridiagonal form Q^H*A*Q = T (xSYTRD,
  xHETRD): D (N entries), E and TAU (N-1 entries) allocated by the
  caller. }
procedure DSYTRD(UPLO: char; N: longint; var A: array of TReal;
  AO, LDA: longint; var D, E: array of TReal; var TAU: array of TReal);

procedure ZHETRD(UPLO: char; N: longint; var A: array of TComplex;
  AO, LDA: longint; var D, E: array of TReal; var TAU: array of TComplex);

{ The matrix Q of xSYTRD (xHETRD), overwriting A (xORGTR, xUNGTR). }
procedure DORGTR(UPLO: char; N: longint; var A: array of TReal;
  AO, LDA: longint; const TAU: array of TReal);

procedure ZUNGTR(UPLO: char; N: longint; var A: array of TComplex;
  AO, LDA: longint; const TAU: array of TComplex);

{ Eigenvalues and eigenvectors of the symmetric tridiagonal matrix with
  diagonal D and off-diagonal E by the implicit QL/QR method (xSTEQR):
  COMPZ = 'I' starts from the identity, 'V' from the matrix in Z. }
procedure DSTEQR(COMPZ: char; N: longint; var D, E: array of TReal;
  var Z: array of TReal; ZO, LDZ: longint; out INFO: longint);

procedure ZSTEQR(COMPZ: char; N: longint; var D, E: array of TReal;
  var Z: array of TComplex; ZO, LDZ: longint; out INFO: longint);

{ Selected eigenvalues of the symmetric tridiagonal matrix (D, E) by
  bisection (DSTEBZ): RANGE 'A', 'V' (in (VL, VU]) or 'I' (IL-th to
  IU-th, from 1); ORDER 'B' (by block) or 'E' (ascending). W, IBLOCK and
  ISPLIT (N entries each) receive the M eigenvalues, their block numbers
  and the last rows (from 1) of the NSPLIT blocks. }
procedure DSTEBZ(RANGE, ORDER: char; N: longint; VL, VU: TReal;
  IL, IU: longint; ABSTOL: TReal; const D, E: array of TReal;
  out M, NSPLIT: longint; var W: array of TReal;
  var IBLOCK, ISPLIT: array of longint; out INFO: longint);

{ Eigenvectors of the symmetric tridiagonal matrix (D, E) for the M
  eigenvalues of DSTEBZ with ORDER = 'B', by inverse iteration (DSTEIN),
  in the first M columns of Z (N rows, row stride LDZ). }
procedure DSTEIN(N: longint; const D, E: array of TReal; M: longint;
  const W: array of TReal; const IBLOCK, ISPLIT: array of longint;
  var Z: array of TReal; ZO, LDZ: longint; var IFAIL: array of longint;
  out INFO: longint);

{ Selected eigenvalues and eigenvectors of the symmetric tridiagonal
  matrix with diagonal D (N entries) and off-diagonal E (N-1), as DSTEVX
  with JOBZ = 'V': RANGE 'A' (all), 'V' (those in (VL, VU]) or 'I' (the
  IL-th to the IU-th, counted from 1). D and E may be scaled on exit. The
  M eigenvalues go to W (N entries) in ascending order and the
  eigenvectors to the first M columns of the N-row matrix Z (row stride
  LDZ, at least M columns, N when all are wanted). With ABSTOL <= 0 and
  all eigenvalues wanted xSTEQR is used, otherwise bisection (DSTEBZ,
  absolute tolerance ABSTOL, 2*safe minimum for the highest accuracy)
  and inverse iteration (DSTEIN). INFO > 0 is the number of eigenvectors
  that failed to converge, whose numbers (from 1) are in IFAIL (N
  entries). }
procedure DSTEVX(RANGE: char; N: longint; var D, E: array of TReal;
  VL, VU: TReal; IL, IU: longint; ABSTOL: TReal; out M: longint;
  var W, Z: array of TReal; ZO, LDZ: longint; var IFAIL: array of longint;
  out INFO: longint);

{ Singular values of the N x N bidiagonal matrix with diagonal D and
  off-diagonal E (N entries, the last one workspace), in decreasing
  order in D, by the dqds algorithm (DLASQ1). INFO = 2 when it did not
  converge. }
procedure DLASQ1(N: longint; var D, E: array of TReal; out INFO: longint);

{ Singular values of the bidiagonal matrix (D, E) with UPLO 'U' (upper)
  or 'L' (lower), as xBDSQR with NCVT = NRU = NCC = 0: DLASQ1, and the
  implicit zero-shift QR when dqds fails. E holds N entries. INFO > 0:
  that many off-diagonal entries did not converge. }
procedure DBDSQR(UPLO: char; N: longint; var D, E: array of TReal;
  out INFO: longint);

{ Reduction of the M x N matrix A, M >= N, to upper bidiagonal form
  Q^H*A*P = B (xGEBRD): D, TAUQ and TAUP (N entries) and E (N-1)
  allocated by the caller. }
procedure DGEBRD(M, N: longint; var A: array of TReal; AO, LDA: longint;
  var D, E: array of TReal; var TAUQ, TAUP: array of TReal);

procedure ZGEBRD(M, N: longint; var A: array of TComplex; AO, LDA: longint;
  var D, E: array of TReal; var TAUQ, TAUP: array of TComplex);

{ Singular values (decreasing, in S, N entries allocated by the caller)
  of the N x N matrix A, as xGESVD with JOBU = JOBVT = 'N': scaling,
  xGEBRD and xBDSQR. A is destroyed. INFO > 0 when xBDSQR did not
  converge. }
procedure DGESVD(N: longint; var A: array of TReal; AO, LDA: longint;
  var S: array of TReal; out INFO: longint);

procedure ZGESVD(N: longint; var A: array of TComplex; AO, LDA: longint;
  var S: array of TReal; out INFO: longint);

{ Overloads by element type, for the generic types of ADimMath. }
function XDOT(N: longint; const X: array of TReal; XO, INCX: longint;
  const Y: array of TReal; YO, INCY: longint): TReal; overload;

function XDOT(N: longint; const X: array of TComplex; XO, INCX: longint;
  const Y: array of TComplex; YO, INCY: longint): TComplex; overload;

function XNRM2(N: longint; const X: array of TReal;
  XO, INCX: longint): TReal; overload;

function XNRM2(N: longint; const X: array of TComplex;
  XO, INCX: longint): TReal; overload;

procedure XGEMV(TRANS: char; M, N: longint; const A: array of TReal;
  AO, LDA: longint; const X: array of TReal; XO, INCX: longint;
  var Y: array of TReal; YO, INCY: longint); overload;

procedure XGEMV(TRANS: char; M, N: longint; const A: array of TComplex;
  AO, LDA: longint; const X: array of TComplex; XO, INCX: longint;
  var Y: array of TComplex; YO, INCY: longint); overload;

procedure XGEMM(TRANSA, TRANSB: char; M, N, K: longint;
  const A: array of TReal; AO, LDA: longint; const B: array of TReal;
  BO, LDB: longint; var C: array of TReal; CO, LDC: longint); overload;

procedure XGEMM(TRANSA, TRANSB: char; M, N, K: longint;
  const A: array of TComplex; AO, LDA: longint; const B: array of TComplex;
  BO, LDB: longint; var C: array of TComplex; CO, LDC: longint); overload;

function XLANGE(NORM: char; M, N: longint; const A: array of TReal;
  AO, LDA: longint): TReal; overload;

function XLANGE(NORM: char; M, N: longint; const A: array of TComplex;
  AO, LDA: longint): TReal; overload;

procedure XGETRF(N: longint; var A: array of TReal; var IPIV: array of longint;
  out INFO: longint); overload;

procedure XGETRF(N: longint; var A: array of TComplex;
  var IPIV: array of longint; out INFO: longint); overload;

procedure XGETRS(TRANS: char; N, NRHS: longint; const A: array of TReal;
  const IPIV: array of longint; var B: array of TReal); overload;

procedure XGETRS(TRANS: char; N, NRHS: longint; const A: array of TComplex;
  const IPIV: array of longint; var B: array of TComplex); overload;

procedure XGETRI(N: longint; var A: array of TReal;
  const IPIV: array of longint; out INFO: longint); overload;

procedure XGETRI(N: longint; var A: array of TComplex;
  const IPIV: array of longint; out INFO: longint); overload;

procedure XSYEV(UPLO: char; N: longint; var A: array of TReal;
  var W: array of TReal; out INFO: longint); overload;

procedure XSYEV(UPLO: char; N: longint; var A: array of TComplex;
  var W: array of TReal; out INFO: longint); overload;

procedure XGESVD(N: longint; var A: array of TReal; var S: array of TReal;
  out INFO: longint); overload;

procedure XGESVD(N: longint; var A: array of TComplex; var S: array of TReal;
  out INFO: longint); overload;

procedure XGECON(N: longint; const A: array of TReal; ANORM: TReal;
  out RCOND: TReal; out INFO: longint); overload;

procedure XGECON(N: longint; const A: array of TComplex; ANORM: TReal;
  out RCOND: TReal; out INFO: longint); overload;

implementation

uses
  Math, SysUtils;

const
  { Machine parameters of LAPACK DLAMCH for binary64. Real constants are
    typed throughout this unit: Free Pascal evaluates expressions with
    untyped real constants in Extended precision where it exists (x87 on
    x86_64), which would differ from LAPACK. }
  LapackSafeMinimum: TReal = 2.2250738585072014E-308; { DLAMCH('S') = 2^-1022 }
  LapackEpsilon: TReal = 1.1102230246251565E-16;      { DLAMCH('E') = 2^-53 }
  LapackPrecision: TReal = 2.2204460492503131E-16;    { DLAMCH('P') = 2^-52 }
  LapackOverflow: TReal = MaxDouble;                  { DLAMCH('O') }

function CABS1(const AValue: TReal): TReal;
begin
  result := System.Abs(AValue);
end;

function CABS1(const AValue: TComplex): TReal;
begin
  result := System.Abs(AValue.Re) + System.Abs(AValue.Im);
end;

{ Complex conjugate; the identity for a real number. A local function
  instead of the Conjugate helpers of ADimMath: Free Pascal 3.2 at -O2
  miscompiles those helpers, inlined from another unit, on open array
  entries. }
function CONJ(const AValue: TReal): TReal; overload; inline;
begin
  result := AValue;
end;

function CONJ(const AValue: TComplex): TComplex; overload; inline;
begin
  result.Re := AValue.Re;
  result.Im := -AValue.Im;
end;

{ AValue, conjugated when AConjugate: the entry of op(A) in the
  routines that take TRANS. }
function CONJIF(const AValue: TReal; AConjugate: boolean): TReal; overload;
  inline;
begin
  result := AValue;
end;

function CONJIF(const AValue: TComplex; AConjugate: boolean): TComplex;
  overload; inline;
begin
  if AConjugate then result := CONJ(AValue) else result := AValue;
end;

{ Robust complex division (DLADIV, LAPACK 3.7, Baudin and Smith): P + iQ
  = (A + iB) / (C + iD). DLADIV1 and DLADIV2 are its helpers. }
function DLADIV2(A, B, C, D, R, T: TReal): TReal;
var
  BR: TReal;
begin
  if R <> 0 then
  begin
    BR := B * R;
    if BR <> 0 then
      result := (A + BR) * T
    else
      result := A * T + (B * T) * R;
  end else
    result := (A + D * (B / C)) * T;
end;

procedure DLADIV1(A, B, C, D: TReal; out P, Q: TReal);
var
  R, T: TReal;
begin
  R := D / C;
  T := 1 / (C + D * R);
  P := DLADIV2(A, B, C, D, R, T);
  A := -A;
  Q := DLADIV2(B, A, C, D, R, T);
end;

procedure DLADIV(A, B, C, D: TReal; out P, Q: TReal);
const
  BS: TReal = 2;
var
  AA, AB, BB, BE, CC, CD, DD, S: TReal;
begin
  AA := A;
  BB := B;
  CC := C;
  DD := D;
  AB := Max(System.Abs(A), System.Abs(B));
  CD := Max(System.Abs(C), System.Abs(D));
  S := 1;
  BE := BS / (LapackEpsilon * LapackEpsilon);
  if AB >= 0.5 * LapackOverflow then
  begin
    AA := 0.5 * AA;
    BB := 0.5 * BB;
    S := 2 * S;
  end;
  if CD >= 0.5 * LapackOverflow then
  begin
    CC := 0.5 * CC;
    DD := 0.5 * DD;
    S := 0.5 * S;
  end;
  if AB <= LapackSafeMinimum * BS / LapackEpsilon then
  begin
    AA := AA * BE;
    BB := BB * BE;
    S := S / BE;
  end;
  if CD <= LapackSafeMinimum * BS / LapackEpsilon then
  begin
    CC := CC * BE;
    DD := DD * BE;
    S := S * BE;
  end;
  if System.Abs(D) <= System.Abs(C) then
    DLADIV1(AA, BB, CC, DD, P, Q)
  else
  begin
    DLADIV1(BB, AA, DD, CC, P, Q);
    Q := -Q;
  end;
  P := P * S;
  Q := Q * S;
end;

{ X / Y by DLADIV (ZLADIV). The division operator of TComplex uses the
  same algorithm but may differ in the sign of zero parts. }
function ZLADIV(const X, Y: TComplex): TComplex;
var
  ZR, ZI: TReal;
begin
  DLADIV(X.Re, X.Im, Y.Re, Y.Im, ZR, ZI);
  result.Re := ZR;
  result.Im := ZI;
end;

{ Arithmetic as gfortran compiles it. With signed zeros (the default) a
  real operand of a complex operation becomes (r, +0) and the full complex
  operation is performed, and complex division uses Smith's algorithm as
  GCC expands it inline for Fortran. The values are those of the TComplex
  operators except for the sign of zero parts (and NaN/infinity cases);
  these functions are used where LAPACK mixes real and complex operands
  or divides complex numbers, so that the results match the reference bit
  for bit. }
const
  FZERO: TReal = 0;
  FONE: TReal = 1;

{ (R, 0) * Z, the same as Z * (R, 0). }
function FMUL(R: TReal; const Z: TComplex): TComplex; inline;
begin
  result.Re := R * Z.Re - FZERO * Z.Im;
  result.Im := R * Z.Im + FZERO * Z.Re;
end;

{ Z + (R, 0), the same as (R, 0) + Z. }
function FADD(const Z: TComplex; R: TReal): TComplex; inline;
begin
  result.Re := Z.Re + R;
  result.Im := Z.Im + FZERO;
end;

{ A / B by Smith's algorithm (GCC, -fcx-fortran-rules). }
function FDIV(const A, B: TComplex): TComplex; overload;
var
  RATIO, DIVISOR, TR, TI: TReal;
begin
  if System.Abs(B.Re) < System.Abs(B.Im) then
  begin
    RATIO := B.Re / B.Im;
    DIVISOR := (B.Re * RATIO) + B.Im;
    TR := (A.Re * RATIO) + A.Im;
    TI := (A.Im * RATIO) - A.Re;
  end else
  begin
    RATIO := B.Im / B.Re;
    DIVISOR := (B.Im * RATIO) + B.Re;
    TR := (A.Im * RATIO) + A.Re;
    TI := A.Im - (A.Re * RATIO);
  end;
  result.Re := TR / DIVISOR;
  result.Im := TI / DIVISOR;
end;

{ A / (R, 0). }
function FDIV(const A: TComplex; R: TReal): TComplex; overload;
var
  RATIO, DIVISOR: TReal;
begin
  RATIO := FZERO / R;
  DIVISOR := (FZERO * RATIO) + R;
  result.Re := ((A.Im * RATIO) + A.Re) / DIVISOR;
  result.Im := (A.Im - (A.Re * RATIO)) / DIVISOR;
end;

{ True when the factor of xSCAL is one: the reference BLAS then returns
  without touching X, which keeps the sign of zero components. }
function ISONE(const AValue: TReal): boolean; overload; inline;
begin
  result := AValue = 1;
end;

function ISONE(const AValue: TComplex): boolean; overload; inline;
begin
  result := (AValue.Re = 1) and (AValue.Im = 0);
end;

{ ---------------------------------------------------------------------
  Reference BLAS 3.12.1. Each routine performs the operations of the
  Fortran routine in the same order for every entry; the loops are
  arranged for the storage by rows where this does not change the order
  of the operations on any entry (the loops of the reference BLAS run
  down the columns, and every entry of the result receives the same
  sequence of operations in either arrangement). Vectors are given by
  array, offset and increment; with a negative increment the offset is
  that of the first entry in memory, as in Fortran.
  --------------------------------------------------------------------- }

function FDIV(A, B: TReal): TReal; overload; inline;
begin
  result := A / B;
end;

{ X = 0, for real and complex entries. }
function ISZERO(const AValue: TReal): boolean; overload; inline;
begin
  result := AValue = 0;
end;

function ISZERO(const AValue: TComplex): boolean; overload; inline;
begin
  result := (AValue.Re = 0) and (AValue.Im = 0);
end;

{ C := C + A*B, the update in the inner loops of the BLAS; written on
  the components for complex numbers, whose operators Free Pascal does
  not inline in the generic routines. }
procedure MADD(var C: TReal; const A, B: TReal); overload; inline;
begin
  C := C + A * B;
end;

procedure MADD(var C: TComplex; const A, B: TComplex); overload; inline;
var
  R, I: TReal;
begin
  R := C.Re + (A.Re * B.Re - A.Im * B.Im);
  I := C.Im + (A.Re * B.Im + A.Im * B.Re);
  C.Re := R;
  C.Im := I;
end;

{ C := C - A*B. }
procedure MSUB(var C: TReal; const A, B: TReal); overload; inline;
begin
  C := C - A * B;
end;

procedure MSUB(var C: TComplex; const A, B: TComplex); overload; inline;
var
  R, I: TReal;
begin
  R := C.Re - (A.Re * B.Re - A.Im * B.Im);
  I := C.Im - (A.Re * B.Im + A.Im * B.Re);
  C.Re := R;
  C.Im := I;
end;

{ Start of a vector of N entries with increment INC: KX of the BLAS. }
function VSTART(N, XO, INC: longint): longint; inline;
begin
  if INC > 0 then result := XO else result := XO - (N - 1) * INC;
end;

{ IDAMAX, IZAMAX: 0-based index, relative to the start of the vector, of
  the first entry of largest CABS1 (|x| for real entries). }
generic function IAMAX<T>(N: longint; const X: array of T;
  XO, INCX: longint): longint;
var
  I, IX: longint;
  DMAX: TReal;
begin
  result := -1;
  if (N < 1) or (INCX <= 0) then Exit;
  result := 0;
  if N = 1 then Exit;
  IX := XO;
  DMAX := CABS1(X[IX]);
  for I := 1 to N - 1 do
  begin
    IX := IX + INCX;
    if CABS1(X[IX]) > DMAX then
    begin
      result := I;
      DMAX := CABS1(X[IX]);
    end;
  end;
end;

{ DSCAL, ZSCAL: X := DA*X. }
generic procedure SCAL<T>(N: longint; const DA: T; var X: array of T;
  XO, INCX: longint);
var
  I: longint;
begin
  if (N <= 0) or (INCX <= 0) or ISONE(DA) then Exit;
  for I := 0 to N - 1 do X[XO + I * INCX] := DA * X[XO + I * INCX];
end;

{ ZDSCAL: X := DA*X on the components. }
procedure ZDSCAL(N: longint; DA: TReal; var X: array of TComplex;
  XO, INCX: longint);
var
  I: longint;
begin
  if (N <= 0) or (INCX <= 0) or (DA = 1) then Exit;
  for I := 0 to N - 1 do
  begin
    X[XO + I * INCX].Re := DA * X[XO + I * INCX].Re;
    X[XO + I * INCX].Im := DA * X[XO + I * INCX].Im;
  end;
end;

{ DSWAP, ZSWAP. }
generic procedure SWAP<T>(N: longint; var X: array of T; XO, INCX: longint;
  var Y: array of T; YO, INCY: longint);
var
  I, IX, IY: longint;
  TEMP: T;
begin
  if N <= 0 then Exit;
  IX := VSTART(N, XO, INCX);
  IY := VSTART(N, YO, INCY);
  for I := 0 to N - 1 do
  begin
    TEMP := X[IX];
    X[IX] := Y[IY];
    Y[IY] := TEMP;
    IX := IX + INCX;
    IY := IY + INCY;
  end;
end;

{ DAXPY, ZAXPY: Y := Y + DA*X. }
generic procedure AXPY<T>(N: longint; const DA: T; const X: array of T;
  XO, INCX: longint; var Y: array of T; YO, INCY: longint);
var
  I, IX, IY: longint;
begin
  if (N <= 0) or ISZERO(DA) then Exit;
  IX := VSTART(N, XO, INCX);
  IY := VSTART(N, YO, INCY);
  for I := 0 to N - 1 do
  begin
    MADD(Y[IY], DA, X[IX]);
    IX := IX + INCX;
    IY := IY + INCY;
  end;
end;

{ DDOT, ZDOTU (CONJX false) and ZDOTC (CONJX true): sum of
  conj(X(i))*Y(i) from zero in increasing i. DDOT unrolls its loop by 5
  but adds the products in the same order. }
generic function DOT<T>(CONJX: boolean; N: longint; const X: array of T;
  XO, INCX: longint; const Y: array of T; YO, INCY: longint): T;
var
  I, IX, IY: longint;
begin
  result := 0;
  if N <= 0 then Exit;
  IX := VSTART(N, XO, INCX);
  IY := VSTART(N, YO, INCY);
  for I := 0 to N - 1 do
  begin
    MADD(result, CONJIF(X[IX], CONJX), Y[IY]);
    IX := IX + INCX;
    IY := IY + INCY;
  end;
end;

{ DGEMV, ZGEMV: y := alpha*op(A)*x + beta*y for the M x N matrix A. }
generic procedure GEMV<T>(TRANS: char; M, N: longint; const ALPHA: T;
  const A: array of T; AO, LDA: longint; const X: array of T;
  XO, INCX: longint; const BETA: T; var Y: array of T; YO, INCY: longint);
var
  I, J, LENX, LENY, KX, KY, IX, IY, JX, JY: longint;
  NOCONJ: boolean;
  TEMP: T;
begin
  if (M = 0) or (N = 0) or (ISZERO(ALPHA) and ISONE(BETA)) then Exit;
  NOCONJ := TRANS = 'T';
  if TRANS = 'N' then
  begin
    LENX := N;
    LENY := M;
  end else
  begin
    LENX := M;
    LENY := N;
  end;
  KX := VSTART(LENX, XO, INCX);
  KY := VSTART(LENY, YO, INCY);
  { First form y := beta*y. }
  if not ISONE(BETA) then
  begin
    IY := KY;
    for I := 0 to LENY - 1 do
    begin
      if ISZERO(BETA) then Y[IY] := 0 else Y[IY] := BETA * Y[IY];
      IY := IY + INCY;
    end;
  end;
  if ISZERO(ALPHA) then Exit;
  if TRANS = 'N' then
  begin
    { y := alpha*A*x + y: y(i) receives the products TEMP*A(i, j) with
      TEMP = alpha*x(j), in increasing j. }
    JX := KX;
    for J := 0 to N - 1 do
    begin
      TEMP := ALPHA * X[JX];
      IY := KY;
      for I := 0 to M - 1 do
      begin
        MADD(Y[IY], TEMP, A[AO + I * LDA + J]);
        IY := IY + INCY;
      end;
      JX := JX + INCX;
    end;
  end else
  begin
    { y := alpha*A^T*x + y or y := alpha*A^H*x + y. }
    JY := KY;
    for J := 0 to N - 1 do
    begin
      TEMP := 0;
      IX := KX;
      for I := 0 to M - 1 do
      begin
        if NOCONJ then
          MADD(TEMP, A[AO + I * LDA + J], X[IX])
        else
          MADD(TEMP, CONJ(A[AO + I * LDA + J]), X[IX]);
        IX := IX + INCX;
      end;
      Y[JY] := Y[JY] + ALPHA * TEMP;
      JY := JY + INCY;
    end;
  end;
end;

{ DGER, ZGERU (CONJY false) and ZGERC (CONJY true):
  A := alpha*x*conj(y)^T + A. }
generic procedure GER<T>(CONJY: boolean; M, N: longint; const ALPHA: T;
  const X: array of T; XO, INCX: longint; const Y: array of T;
  YO, INCY: longint; var A: array of T; AO, LDA: longint);
var
  I, J, KX, IX, JY: longint;
  TEMP: T;
begin
  if (M = 0) or (N = 0) or ISZERO(ALPHA) then Exit;
  JY := VSTART(N, YO, INCY);
  KX := VSTART(M, XO, INCX);
  for J := 0 to N - 1 do
  begin
    if not ISZERO(Y[JY]) then
    begin
      TEMP := ALPHA * CONJIF(Y[JY], CONJY);
      IX := KX;
      for I := 0 to M - 1 do
      begin
        MADD(A[AO + I * LDA + J], X[IX], TEMP);
        IX := IX + INCX;
      end;
    end;
    JY := JY + INCY;
  end;
end;

{ DTRMV, ZTRMV: x := op(A)*x for the triangular N x N matrix A. }
generic procedure TRMV<T>(UPLO, TRANS, DIAG: char; N: longint;
  const A: array of T; AO, LDA: longint; var X: array of T;
  XO, INCX: longint);
var
  I, J, KX, IX, JX: longint;
  NOCONJ, NOUNIT: boolean;
  TEMP: T;
begin
  if N = 0 then Exit;
  NOCONJ := TRANS = 'T';
  NOUNIT := DIAG = 'N';
  KX := VSTART(N, XO, INCX);
  if TRANS = 'N' then
  begin
    { x := A*x. }
    if UPLO = 'U' then
    begin
      JX := KX;
      for J := 0 to N - 1 do
      begin
        if not ISZERO(X[JX]) then
        begin
          TEMP := X[JX];
          IX := KX;
          for I := 0 to J - 1 do
          begin
            MADD(X[IX], TEMP, A[AO + I * LDA + J]);
            IX := IX + INCX;
          end;
          if NOUNIT then X[JX] := X[JX] * A[AO + J * LDA + J];
        end;
        JX := JX + INCX;
      end;
    end else
    begin
      KX := KX + (N - 1) * INCX;
      JX := KX;
      for J := N - 1 downto 0 do
      begin
        if not ISZERO(X[JX]) then
        begin
          TEMP := X[JX];
          IX := KX;
          for I := N - 1 downto J + 1 do
          begin
            MADD(X[IX], TEMP, A[AO + I * LDA + J]);
            IX := IX - INCX;
          end;
          if NOUNIT then X[JX] := X[JX] * A[AO + J * LDA + J];
        end;
        JX := JX - INCX;
      end;
    end;
  end else
  begin
    { x := A^T*x or x := A^H*x. }
    if UPLO = 'U' then
    begin
      JX := KX + (N - 1) * INCX;
      for J := N - 1 downto 0 do
      begin
        TEMP := X[JX];
        IX := JX;
        if NOUNIT then TEMP := TEMP * CONJIF(A[AO + J * LDA + J], not NOCONJ);
        for I := J - 1 downto 0 do
        begin
          IX := IX - INCX;
          MADD(TEMP, CONJIF(A[AO + I * LDA + J], not NOCONJ), X[IX]);
        end;
        X[JX] := TEMP;
        JX := JX - INCX;
      end;
    end else
    begin
      JX := KX;
      for J := 0 to N - 1 do
      begin
        TEMP := X[JX];
        IX := JX;
        if NOUNIT then TEMP := TEMP * CONJIF(A[AO + J * LDA + J], not NOCONJ);
        for I := J + 1 to N - 1 do
        begin
          IX := IX + INCX;
          MADD(TEMP, CONJIF(A[AO + I * LDA + J], not NOCONJ), X[IX]);
        end;
        X[JX] := TEMP;
        JX := JX + INCX;
      end;
    end;
  end;
end;

{ DGEMM, ZGEMM: C := alpha*op(A)*op(B) + beta*C, C M x N, op(A) M x K.
  With op(A) = A every entry C(i, j) receives, after beta, the products
  TEMP*A(i, l) with TEMP = alpha*op(B)(l, j) in increasing l, as in the
  reference loop over the columns of C; otherwise C(i, j) = alpha*TEMP +
  beta*C(i, j) with TEMP the sum of op(A)(i, l)*op(B)(l, j) from zero.
  C must not overlap A or B. }
generic procedure GEMM<T>(TRANSA, TRANSB: char; M, N, K: longint;
  const ALPHA: T; const A: array of T; AO, LDA: longint;
  const B: array of T; BO, LDB: longint; const BETA: T;
  var C: array of T; CO, LDC: longint);
var
  NOTA, NOTB, CONJA, CONJB: boolean;
  I, J, L, IC: longint;
  TEMP: T;
  W: array of T;
begin
  NOTA := TRANSA = 'N';
  NOTB := TRANSB = 'N';
  CONJA := TRANSA = 'C';
  CONJB := TRANSB = 'C';
  if (M = 0) or (N = 0) or
     ((ISZERO(ALPHA) or (K = 0)) and ISONE(BETA)) then Exit;
  if ISZERO(ALPHA) then
  begin
    for I := 0 to M - 1 do
      for J := 0 to N - 1 do
        if ISZERO(BETA) then
          C[CO + I * LDC + J] := 0
        else
          C[CO + I * LDC + J] := BETA * C[CO + I * LDC + J];
    Exit;
  end;
  W := nil;
  SetLength(W, N);
  if NOTA then
  begin
    { C := alpha*A*op(B) + beta*C. }
    if not ISONE(BETA) then
      for I := 0 to M - 1 do
        for J := 0 to N - 1 do
          if ISZERO(BETA) then
            C[CO + I * LDC + J] := 0
          else
            C[CO + I * LDC + J] := BETA * C[CO + I * LDC + J];
    for L := 0 to K - 1 do
    begin
      for J := 0 to N - 1 do
        if NOTB then
          W[J] := ALPHA * B[BO + L * LDB + J]
        else
          W[J] := ALPHA * CONJIF(B[BO + J * LDB + L], CONJB);
      for I := 0 to M - 1 do
      begin
        TEMP := A[AO + I * LDA + L];
        IC := CO + I * LDC;
        for J := 0 to N - 1 do MADD(C[IC + J], W[J], TEMP);
      end;
    end;
  end else
  begin
    { C := alpha*op(A)*op(B) + beta*C with op(A) = A^T or A^H; W holds
      the sums TEMP of row i of C. }
    for I := 0 to M - 1 do
    begin
      for J := 0 to N - 1 do W[J] := 0;
      for L := 0 to K - 1 do
      begin
        TEMP := CONJIF(A[AO + L * LDA + I], CONJA);
        if NOTB then
          for J := 0 to N - 1 do MADD(W[J], TEMP, B[BO + L * LDB + J])
        else
          for J := 0 to N - 1 do
            MADD(W[J], TEMP, CONJIF(B[BO + J * LDB + L], CONJB));
      end;
      IC := CO + I * LDC;
      for J := 0 to N - 1 do
        if ISZERO(BETA) then
          C[IC + J] := ALPHA * W[J]
        else
          C[IC + J] := ALPHA * W[J] + BETA * C[IC + J];
    end;
  end;
end;

{ DTRSM, ZTRSM: B := alpha*inv(op(A))*B (SIDE = 'L') or
  B := alpha*B*inv(op(A)) (SIDE = 'R') for the M x N matrix B and the
  triangular matrix A. With SIDE = 'L' the columns of B are independent
  and are processed together, row by row; with SIDE = 'R' the rows are. }
generic procedure TRSM<T>(SIDE, UPLO, TRANSA, DIAG: char; M, N: longint;
  const ALPHA: T; const A: array of T; AO, LDA: longint;
  var B: array of T; BO, LDB: longint);
var
  LSIDE, UPPER, NOUNIT, NOCONJ: boolean;
  I, J, K, KK, I1, I2, IB, KB: longint;
  TEMP, ONE: T;
  W: array of T;
  NZ: array of boolean;
begin
  if (M = 0) or (N = 0) then Exit;
  LSIDE := SIDE = 'L';
  UPPER := UPLO = 'U';
  NOUNIT := DIAG = 'N';
  NOCONJ := TRANSA = 'T';
  ONE := 1;
  if ISZERO(ALPHA) then
  begin
    for I := 0 to M - 1 do
      for J := 0 to N - 1 do B[BO + I * LDB + J] := 0;
    Exit;
  end;
  if LSIDE then
  begin
    if TRANSA = 'N' then
    begin
      { B := alpha*inv(A)*B; NZ(j) records B(k, j) <> 0 before the
        division, the test of the reference loop. }
      if not ISONE(ALPHA) then
        for I := 0 to M - 1 do
          for J := 0 to N - 1 do
            B[BO + I * LDB + J] := ALPHA * B[BO + I * LDB + J];
      NZ := nil;
      SetLength(NZ, N);
      for KK := 0 to M - 1 do
      begin
        if UPPER then K := M - 1 - KK else K := KK;
        KB := BO + K * LDB;
        for J := 0 to N - 1 do
        begin
          NZ[J] := not ISZERO(B[KB + J]);
          if NZ[J] and NOUNIT then
            B[KB + J] := FDIV(B[KB + J], A[AO + K * LDA + K]);
        end;
        if UPPER then
        begin
          I1 := 0;
          I2 := K - 1;
        end else
        begin
          I1 := K + 1;
          I2 := M - 1;
        end;
        for I := I1 to I2 do
        begin
          TEMP := A[AO + I * LDA + K];
          IB := BO + I * LDB;
          for J := 0 to N - 1 do
            if NZ[J] then MSUB(B[IB + J], B[KB + J], TEMP);
        end;
      end;
    end else
    begin
      { B := alpha*inv(A^T)*B or B := alpha*inv(A^H)*B; W holds the
        sums TEMP of row i of B. }
      W := nil;
      SetLength(W, N);
      if UPPER then
        for I := 0 to M - 1 do
        begin
          IB := BO + I * LDB;
          for J := 0 to N - 1 do W[J] := ALPHA * B[IB + J];
          for K := 0 to I - 1 do
          begin
            TEMP := CONJIF(A[AO + K * LDA + I], not NOCONJ);
            KB := BO + K * LDB;
            for J := 0 to N - 1 do MSUB(W[J], TEMP, B[KB + J]);
          end;
          if NOUNIT then
          begin
            TEMP := CONJIF(A[AO + I * LDA + I], not NOCONJ);
            for J := 0 to N - 1 do W[J] := FDIV(W[J], TEMP);
          end;
          for J := 0 to N - 1 do B[IB + J] := W[J];
        end
      else
        for I := M - 1 downto 0 do
        begin
          IB := BO + I * LDB;
          for J := 0 to N - 1 do W[J] := ALPHA * B[IB + J];
          for K := I + 1 to M - 1 do
          begin
            TEMP := CONJIF(A[AO + K * LDA + I], not NOCONJ);
            KB := BO + K * LDB;
            for J := 0 to N - 1 do MSUB(W[J], TEMP, B[KB + J]);
          end;
          if NOUNIT then
          begin
            TEMP := CONJIF(A[AO + I * LDA + I], not NOCONJ);
            for J := 0 to N - 1 do W[J] := FDIV(W[J], TEMP);
          end;
          for J := 0 to N - 1 do B[IB + J] := W[J];
        end;
    end;
  end else
  begin
    if TRANSA = 'N' then
    begin
      { B := alpha*B*inv(A). }
      for I := 0 to M - 1 do
      begin
        IB := BO + I * LDB;
        if UPPER then
          for J := 0 to N - 1 do
          begin
            if not ISONE(ALPHA) then B[IB + J] := ALPHA * B[IB + J];
            for K := 0 to J - 1 do
              if not ISZERO(A[AO + K * LDA + J]) then
                MSUB(B[IB + J], A[AO + K * LDA + J], B[IB + K]);
            if NOUNIT then
              B[IB + J] := FDIV(ONE, A[AO + J * LDA + J]) * B[IB + J];
          end
        else
          for J := N - 1 downto 0 do
          begin
            if not ISONE(ALPHA) then B[IB + J] := ALPHA * B[IB + J];
            for K := J + 1 to N - 1 do
              if not ISZERO(A[AO + K * LDA + J]) then
                MSUB(B[IB + J], A[AO + K * LDA + J], B[IB + K]);
            if NOUNIT then
              B[IB + J] := FDIV(ONE, A[AO + J * LDA + J]) * B[IB + J];
          end;
      end;
    end else
    begin
      { B := alpha*B*inv(A^T) or B := alpha*B*inv(A^H). }
      for I := 0 to M - 1 do
      begin
        IB := BO + I * LDB;
        if UPPER then
          for K := N - 1 downto 0 do
          begin
            if NOUNIT then
              B[IB + K] := FDIV(ONE, CONJIF(A[AO + K * LDA + K], not NOCONJ)) *
                B[IB + K];
            for J := 0 to K - 1 do
              if not ISZERO(A[AO + J * LDA + K]) then
                MSUB(B[IB + J], CONJIF(A[AO + J * LDA + K], not NOCONJ),
                  B[IB + K]);
            if not ISONE(ALPHA) then B[IB + K] := ALPHA * B[IB + K];
          end
        else
          for K := 0 to N - 1 do
          begin
            if NOUNIT then
              B[IB + K] := FDIV(ONE, CONJIF(A[AO + K * LDA + K], not NOCONJ)) *
                B[IB + K];
            for J := K + 1 to N - 1 do
              if not ISZERO(A[AO + J * LDA + K]) then
                MSUB(B[IB + J], CONJIF(A[AO + J * LDA + K], not NOCONJ),
                  B[IB + K]);
            if not ISONE(ALPHA) then B[IB + K] := ALPHA * B[IB + K];
          end;
      end;
    end;
  end;
end;

{ DTRMM, ZTRMM: B := alpha*op(A)*B (SIDE = 'L') or B := alpha*B*op(A)
  (SIDE = 'R') for the M x N matrix B and the triangular matrix A. }
generic procedure TRMM<T>(SIDE, UPLO, TRANSA, DIAG: char; M, N: longint;
  const ALPHA: T; const A: array of T; AO, LDA: longint;
  var B: array of T; BO, LDB: longint);
var
  LSIDE, UPPER, NOUNIT, NOCONJ: boolean;
  I, J, K, KK, IB, KB: longint;
  TEMP: T;
  W: array of T;
  NZ: array of boolean;
begin
  if (M = 0) or (N = 0) then Exit;
  LSIDE := SIDE = 'L';
  UPPER := UPLO = 'U';
  NOUNIT := DIAG = 'N';
  NOCONJ := TRANSA = 'T';
  if ISZERO(ALPHA) then
  begin
    for I := 0 to M - 1 do
      for J := 0 to N - 1 do B[BO + I * LDB + J] := 0;
    Exit;
  end;
  W := nil;
  SetLength(W, N);
  if LSIDE then
  begin
    if TRANSA = 'N' then
    begin
      { B := alpha*A*B; W holds TEMP = alpha*B(k, j) and NZ records
        B(k, j) <> 0, the test of the reference loop. }
      NZ := nil;
      SetLength(NZ, N);
      for KK := 0 to M - 1 do
      begin
        if UPPER then K := KK else K := M - 1 - KK;
        KB := BO + K * LDB;
        for J := 0 to N - 1 do
        begin
          NZ[J] := not ISZERO(B[KB + J]);
          if NZ[J] then W[J] := ALPHA * B[KB + J];
        end;
        if UPPER then
        begin
          { The entries above row k are updated first, then B(k, j) is
            set; row k is not read by the updates. }
          for I := 0 to K - 1 do
          begin
            TEMP := A[AO + I * LDA + K];
            IB := BO + I * LDB;
            for J := 0 to N - 1 do
              if NZ[J] then MADD(B[IB + J], W[J], TEMP);
          end;
          for J := 0 to N - 1 do
            if NZ[J] then
              if NOUNIT then
                B[KB + J] := W[J] * A[AO + K * LDA + K]
              else
                B[KB + J] := W[J];
        end else
        begin
          for J := 0 to N - 1 do
            if NZ[J] then
            begin
              B[KB + J] := W[J];
              if NOUNIT then B[KB + J] := B[KB + J] * A[AO + K * LDA + K];
            end;
          for I := K + 1 to M - 1 do
          begin
            TEMP := A[AO + I * LDA + K];
            IB := BO + I * LDB;
            for J := 0 to N - 1 do
              if NZ[J] then MADD(B[IB + J], W[J], TEMP);
          end;
        end;
      end;
    end else
    begin
      { B := alpha*A^T*B or B := alpha*A^H*B; W holds the sums TEMP of
        row i of B. }
      if UPPER then
        for I := M - 1 downto 0 do
        begin
          IB := BO + I * LDB;
          for J := 0 to N - 1 do W[J] := B[IB + J];
          if NOUNIT then
          begin
            TEMP := CONJIF(A[AO + I * LDA + I], not NOCONJ);
            for J := 0 to N - 1 do W[J] := W[J] * TEMP;
          end;
          for K := 0 to I - 1 do
          begin
            TEMP := CONJIF(A[AO + K * LDA + I], not NOCONJ);
            KB := BO + K * LDB;
            for J := 0 to N - 1 do MADD(W[J], TEMP, B[KB + J]);
          end;
          for J := 0 to N - 1 do B[IB + J] := ALPHA * W[J];
        end
      else
        for I := 0 to M - 1 do
        begin
          IB := BO + I * LDB;
          for J := 0 to N - 1 do W[J] := B[IB + J];
          if NOUNIT then
          begin
            TEMP := CONJIF(A[AO + I * LDA + I], not NOCONJ);
            for J := 0 to N - 1 do W[J] := W[J] * TEMP;
          end;
          for K := I + 1 to M - 1 do
          begin
            TEMP := CONJIF(A[AO + K * LDA + I], not NOCONJ);
            KB := BO + K * LDB;
            for J := 0 to N - 1 do MADD(W[J], TEMP, B[KB + J]);
          end;
          for J := 0 to N - 1 do B[IB + J] := ALPHA * W[J];
        end;
    end;
  end else
  begin
    if TRANSA = 'N' then
    begin
      { B := alpha*B*A. }
      for I := 0 to M - 1 do
      begin
        IB := BO + I * LDB;
        if UPPER then
          for J := N - 1 downto 0 do
          begin
            TEMP := ALPHA;
            if NOUNIT then TEMP := TEMP * A[AO + J * LDA + J];
            B[IB + J] := TEMP * B[IB + J];
            for K := 0 to J - 1 do
              if not ISZERO(A[AO + K * LDA + J]) then
                MADD(B[IB + J], ALPHA * A[AO + K * LDA + J], B[IB + K]);
          end
        else
          for J := 0 to N - 1 do
          begin
            TEMP := ALPHA;
            if NOUNIT then TEMP := TEMP * A[AO + J * LDA + J];
            B[IB + J] := TEMP * B[IB + J];
            for K := J + 1 to N - 1 do
              if not ISZERO(A[AO + K * LDA + J]) then
                MADD(B[IB + J], ALPHA * A[AO + K * LDA + J], B[IB + K]);
          end;
      end;
    end else
    begin
      { B := alpha*B*A^T or B := alpha*B*A^H. }
      for I := 0 to M - 1 do
      begin
        IB := BO + I * LDB;
        if UPPER then
          for K := 0 to N - 1 do
          begin
            for J := 0 to K - 1 do
              if not ISZERO(A[AO + J * LDA + K]) then
                MADD(B[IB + J],
                  ALPHA * CONJIF(A[AO + J * LDA + K], not NOCONJ), B[IB + K]);
            TEMP := ALPHA;
            if NOUNIT then
              TEMP := TEMP * CONJIF(A[AO + K * LDA + K], not NOCONJ);
            if not ISONE(TEMP) then B[IB + K] := TEMP * B[IB + K];
          end
        else
          for K := N - 1 downto 0 do
          begin
            for J := K + 1 to N - 1 do
              if not ISZERO(A[AO + J * LDA + K]) then
                MADD(B[IB + J],
                  ALPHA * CONJIF(A[AO + J * LDA + K], not NOCONJ), B[IB + K]);
            TEMP := ALPHA;
            if NOUNIT then
              TEMP := TEMP * CONJIF(A[AO + K * LDA + K], not NOCONJ);
            if not ISONE(TEMP) then B[IB + K] := TEMP * B[IB + K];
          end;
      end;
    end;
  end;
end;

{ Accumulation of |AValue| into the three sums of DNRM2 (Blue's
  algorithm): small, medium and big magnitudes. }
procedure NRM2ACC(AValue: TReal; var ASML, AMED, ABIG: TReal;
  var NOTBIG: boolean); overload;
const
  TSML: TReal = 1.4916681462400413E-154; { 2^-511 }
  TBIG: TReal = 1.9979190722022350E+146; { 2^486 }
  SSML: TReal = 4.4989137945431964E+161; { 2^537 }
  SBIG: TReal = 1.1113793747425387E-162; { 2^-538 }
var
  AX: TReal;
begin
  AX := System.Abs(AValue);
  if AX > TBIG then
  begin
    ABIG := ABIG + Sqr(AX * SBIG);
    NOTBIG := False;
  end else if AX < TSML then
  begin
    if NOTBIG then ASML := ASML + Sqr(AX * SSML);
  end else
    AMED := AMED + Sqr(AX);
end;

{ Real and imaginary part in turn, as DZNRM2. }
procedure NRM2ACC(const AValue: TComplex; var ASML, AMED, ABIG: TReal;
  var NOTBIG: boolean); overload;
begin
  NRM2ACC(AValue.Re, ASML, AMED, ABIG, NOTBIG);
  NRM2ACC(AValue.Im, ASML, AMED, ABIG, NOTBIG);
end;

{ Euclidean norm of N entries of X from XOffset with stride INCX, as
  DNRM2 and DZNRM2 of LAPACK 3.10 (Blue's scaled sums). }
generic function NRM2<T>(N: longint; const X: array of T;
  XOffset, INCX: longint): TReal;
const
  SSML: TReal = 4.4989137945431964E+161; { 2^537 }
  SBIG: TReal = 1.1113793747425387E-162; { 2^-538 }
var
  LIndex: longint;
  ASML, AMED, ABIG, SCL, SUMSQ, YMIN, YMAX: TReal;
  NOTBIG: boolean;
begin
  result := 0;
  if N <= 0 then Exit;
  NOTBIG := True;
  ASML := 0;
  AMED := 0;
  ABIG := 0;
  for LIndex := 0 to N - 1 do
    NRM2ACC(X[XOffset + LIndex * INCX], ASML, AMED, ABIG, NOTBIG);
  { Combine the sums. }
  if ABIG > 0 then
  begin
    { Combine ABIG and AMED if AMED > 0. }
    if (AMED > 0) or (AMED > LapackOverflow) or IsNan(AMED) then
      ABIG := ABIG + (AMED * SBIG) * SBIG;
    SCL := 1 / SBIG;
    SUMSQ := ABIG;
  end else if ASML > 0 then
  begin
    { Combine AMED and ASML if ASML > 0. }
    if (AMED > 0) or (AMED > LapackOverflow) or IsNan(AMED) then
    begin
      AMED := Sqrt(AMED);
      ASML := Sqrt(ASML) / SSML;
      if ASML > AMED then
      begin
        YMIN := AMED;
        YMAX := ASML;
      end else
      begin
        YMIN := ASML;
        YMAX := AMED;
      end;
      SCL := 1;
      SUMSQ := Sqr(YMAX) * (1 + Sqr(YMIN / YMAX));
    end else
    begin
      SCL := 1 / SSML;
      SUMSQ := ASML;
    end;
  end else
  begin
    { Otherwise all values are mid-range. }
    SCL := 1;
    SUMSQ := AMED;
  end;
  result := SCL * Sqrt(SUMSQ);
end;

{ sqrt(x^2 + y^2) without unnecessary overflow (DLAPY2). }
function DLAPY2(X, Y: TReal): TReal;
var
  W, XABS, YABS, Z: TReal;
begin
  if IsNan(X) then Exit(X);
  if IsNan(Y) then Exit(Y);
  XABS := System.Abs(X);
  YABS := System.Abs(Y);
  W := Max(XABS, YABS);
  Z := Min(XABS, YABS);
  if (Z = 0) or (W > LapackOverflow) then
    result := W
  else
    result := W * Sqrt(1 + Sqr(Z / W));
end;

{ sqrt(x^2 + y^2 + z^2) without unnecessary overflow (DLAPY3). }
function DLAPY3(X, Y, Z: TReal): TReal;
var
  W, XABS, YABS, ZABS: TReal;
begin
  XABS := System.Abs(X);
  YABS := System.Abs(Y);
  ZABS := System.Abs(Z);
  W := Max(XABS, Max(YABS, ZABS));
  if (W = 0) or (W > LapackOverflow) then
    { W can be zero for max(0, nan, 0); adding all three entries
      together will make sure NaN will not disappear. }
    result := XABS + YABS + ZABS
  else
    result := W * Sqrt(Sqr(XABS / W) + Sqr(YABS / W) + Sqr(ZABS / W));
end;

{ |AMagnitude| with the sign bit of ASign, as Fortran SIGN (gfortran
  honours the sign of zero: SIGN(1, -0) = -1). }
function SIGN(AMagnitude, ASign: TReal): TReal; inline;
begin
  if (ASign < 0) or ((ASign = 0) and (PInt64(@ASign)^ < 0)) then
    result := -System.Abs(AMagnitude)
  else
    result := System.Abs(AMagnitude);
end;

procedure DLARFG(N: longint; var ALPHA: TReal; var X: array of TReal;
  XOffset, INCX: longint; out TAU: TReal);
const
  SAFMIN: TReal = 2.004168360008973E-292; { DLAMCH('S') / DLAMCH('E') = 2^-969 }
  RSAFMN: TReal = 4.9896007738368E+291; { 2^969 }
var
  XNORM, BETA, LScale: TReal;
  J, KNT: longint;
begin
  TAU := 0;
  if N <= 1 then Exit;
  XNORM := specialize NRM2<TReal>(N - 1, X, XOffset, INCX);
  if XNORM = 0 then Exit;
  BETA := -SIGN(DLAPY2(ALPHA, XNORM), ALPHA);
  KNT := 0;
  if System.Abs(BETA) < SAFMIN then
  begin
    repeat
      Inc(KNT);
      for J := 0 to N - 2 do
        X[XOffset + J * INCX] := X[XOffset + J * INCX] * RSAFMN;
      BETA := BETA * RSAFMN;
      ALPHA := ALPHA * RSAFMN;
    until (System.Abs(BETA) >= SAFMIN) or (KNT >= 20);
    XNORM := specialize NRM2<TReal>(N - 1, X, XOffset, INCX);
    BETA := -SIGN(DLAPY2(ALPHA, XNORM), ALPHA);
  end;
  TAU := (BETA - ALPHA) / BETA;
  LScale := 1 / (ALPHA - BETA);
  for J := 0 to N - 2 do
    X[XOffset + J * INCX] := X[XOffset + J * INCX] * LScale;
  for J := 1 to KNT do BETA := BETA * SAFMIN;
  ALPHA := BETA;
end;

procedure ZLARFG(N: longint; var ALPHA: TComplex; var X: array of TComplex;
  XOffset, INCX: longint; out TAU: TComplex);
const
  SAFMIN: TReal = 2.004168360008973E-292; { DLAMCH('S') / DLAMCH('E') = 2^-969 }
  RSAFMN: TReal = 4.9896007738368E+291; { 2^969 }
var
  XNORM, ALPHR, ALPHI, BETA: TReal;
  LScale, LOne: TComplex;
  J, KNT: longint;
begin
  TAU := 0;
  if N <= 0 then Exit;
  XNORM := specialize NRM2<TComplex>(N - 1, X, XOffset, INCX);
  ALPHR := ALPHA.Re;
  ALPHI := ALPHA.Im;
  if (XNORM = 0) and (ALPHI = 0) then Exit;
  BETA := -SIGN(DLAPY3(ALPHR, ALPHI, XNORM), ALPHR);
  KNT := 0;
  if System.Abs(BETA) < SAFMIN then
  begin
    repeat
      Inc(KNT);
      for J := 0 to N - 2 do
        X[XOffset + J * INCX] := X[XOffset + J * INCX] * RSAFMN;
      BETA := BETA * RSAFMN;
      ALPHI := ALPHI * RSAFMN;
      ALPHR := ALPHR * RSAFMN;
    until (System.Abs(BETA) >= SAFMIN) or (KNT >= 20);
    XNORM := specialize NRM2<TComplex>(N - 1, X, XOffset, INCX);
    ALPHA := Complex(ALPHR, ALPHI);
    BETA := -SIGN(DLAPY3(ALPHR, ALPHI, XNORM), ALPHR);
  end;
  TAU := Complex((BETA - ALPHR) / BETA, -ALPHI / BETA);
  LOne := 1;
  LScale := ZLADIV(LOne, ALPHA - BETA);
  if not ISONE(LScale) then
    for J := 0 to N - 2 do
      X[XOffset + J * INCX] := LScale * X[XOffset + J * INCX];
  for J := 1 to KNT do BETA := BETA * SAFMIN;
  ALPHA := BETA;
end;

{ Overloads that let the generic routines call the reflector of their
  type. }
procedure LARFG(N: longint; var ALPHA: TReal; var X: array of TReal;
  XOffset, INCX: longint; out TAU: TReal); overload;
begin
  DLARFG(N, ALPHA, X, XOffset, INCX, TAU);
end;

procedure LARFG(N: longint; var ALPHA: TComplex; var X: array of TComplex;
  XOffset, INCX: longint; out TAU: TComplex); overload;
begin
  ZLARFG(N, ALPHA, X, XOffset, INCX, TAU);
end;

{ Last nonzero column of the M x N matrix at A[AOff] with row stride LDA,
  as a count (ILADLC, ILAZLC); 0 when the matrix is zero. }
generic function ILALC<T>(M, N: longint; const A: array of T;
  AOff, LDA: longint): longint;
var
  I, J: longint;
begin
  result := N;
  if N = 0 then Exit;
  { Quick test for the common case where one corner is non-zero. }
  if (CABS1(A[AOff + N - 1]) <> 0) or
     (CABS1(A[AOff + (M - 1) * LDA + N - 1]) <> 0) then Exit;
  { Now scan each column from the end, returning with the first non-zero. }
  for J := N downto 1 do
    for I := 0 to M - 1 do
      if CABS1(A[AOff + I * LDA + J - 1]) <> 0 then Exit(J);
  result := 0;
end;

{ Last nonzero row, as a count (ILADLR, ILAZLR). }
generic function ILALR<T>(M, N: longint; const A: array of T;
  AOff, LDA: longint): longint;
var
  I, J: longint;
begin
  result := M;
  if M = 0 then Exit;
  { Quick test for the common case where one corner is non-zero. }
  if (CABS1(A[AOff + (M - 1) * LDA]) <> 0) or
     (CABS1(A[AOff + (M - 1) * LDA + N - 1]) <> 0) then Exit;
  { Scan up each column tracking the last zero row seen. }
  result := 0;
  for J := 0 to N - 1 do
  begin
    I := M;
    while (I >= 1) and (CABS1(A[AOff + (Max(I, 1) - 1) * LDA + J]) = 0) do
      Dec(I);
    result := Max(result, I);
  end;
end;

{ xLARF1F: applies H = I - tau*v*v^H (or H^H for the complex conjugate of
  tau passed by the caller) from the left (LEFT) or the right to the
  M x N matrix C at C[COff] with row stride LDC. v[0] = 1 is not read;
  v[1..] is at V[VOff + INCV], V[VOff + 2*INCV], ... The operations are
  those of the reference BLAS calls of LAPACK 3.12.1 (xGEMV, xAXPY,
  xGER/xGERC, xSCAL), entry by entry in the same order. WORK holds at
  least 2*max(M, N) entries. }
generic procedure LARF1F<T>(LEFT: boolean; M, N: longint;
  const V: array of T; VOff, INCV: longint; TAU: T; var C: array of T;
  COff, LDC: longint; var WORK: array of T);
var
  I, J, LASTV, LASTC: longint;
  LOne, LZero, LTemp, LMTau, LX: T;
begin
  LOne := 1;
  LZero := Default(T);
  LASTV := 1;
  LASTC := 0;
  if CABS1(TAU) <> 0 then
  begin
    { Set up variables for scanning V. LASTV begins pointing to the end
      of V. }
    if LEFT then LASTV := M else LASTV := N;
    { Look for the last non-zero row in V; v[0] = 1 is not accessed. }
    while (LASTV > 1) and (CABS1(V[VOff + (LASTV - 1) * INCV]) = 0) do
      Dec(LASTV);
    if LEFT then
      { Scan for the last non-zero column in C(0:lastv-1, :). }
      LASTC := specialize ILALC<T>(LASTV, N, C, COff, LDC)
    else
      { Scan for the last non-zero row in C(:, 0:lastv-1). }
      LASTC := specialize ILALR<T>(M, LASTV, C, COff, LDC);
  end;
  if LASTC = 0 then Exit;
  LMTau := -TAU;
  if LEFT then
  begin
    if LASTV = 1 then
    begin
      { v = 1: C := (1 - tau) * C. }
      LTemp := LOne - TAU;
      if not ISONE(LTemp) then
        for J := 0 to LASTC - 1 do C[COff + J] := LTemp * C[COff + J];
    end else
    begin
      { w := C(1:lastv-1, 0:lastc-1)^H * v(1:lastv-1) (xGEMV 'C'). }
      for J := 0 to LASTC - 1 do WORK[J] := LZero;
      for I := 1 to LASTV - 1 do
      begin
        LTemp := V[VOff + I * INCV];
        for J := 0 to LASTC - 1 do
          WORK[J] := WORK[J] + CONJ(C[COff + I * LDC + J]) * LTemp;
      end;
      for J := 0 to LASTC - 1 do WORK[J] := LZero + LOne * WORK[J];
      { w += C(0, :)^H; C(0, :) -= tau * w^H. }
      for J := 0 to LASTC - 1 do
      begin
        LX := C[COff + J];
        LTemp := WORK[J];
        LTemp := LTemp + CONJ(LX);
        WORK[J] := LTemp;
        C[COff + J] := LX - TAU * CONJ(LTemp);
      end;
      { C(1:lastv-1, :) -= tau * v * w^H (xGER, xGERC: columns with
        w(j) = 0 are skipped). }
      for J := 0 to LASTC - 1 do WORK[LASTC + J] := LMTau * CONJ(WORK[J]);
      for I := 1 to LASTV - 1 do
      begin
        LTemp := V[VOff + I * INCV];
        for J := 0 to LASTC - 1 do
          if CABS1(WORK[J]) <> 0 then
            C[COff + I * LDC + J] := C[COff + I * LDC + J] +
              LTemp * WORK[LASTC + J];
      end;
    end;
  end else
  begin
    if LASTV = 1 then
    begin
      { v = 1: C := C * (1 - tau). }
      LTemp := LOne - TAU;
      if not ISONE(LTemp) then
        for I := 0 to LASTC - 1 do
          C[COff + I * LDC] := LTemp * C[COff + I * LDC];
    end else
    begin
      { w := C(:, 1:lastv-1) * v(1:lastv-1) (xGEMV 'N'). }
      for J := 1 to LASTV - 1 do WORK[LASTC + J] := LOne * V[VOff + J * INCV];
      for I := 0 to LASTC - 1 do
      begin
        LTemp := LZero;
        for J := 1 to LASTV - 1 do
          LTemp := LTemp + WORK[LASTC + J] * C[COff + I * LDC + J];
        WORK[I] := LTemp;
      end;
      { w += C(:, 0); C(:, 0) -= tau * w (xAXPY). }
      for I := 0 to LASTC - 1 do
      begin
        WORK[I] := WORK[I] + LOne * C[COff + I * LDC];
        C[COff + I * LDC] := C[COff + I * LDC] + LMTau * WORK[I];
      end;
      { C(:, 1:lastv-1) -= tau * w * v^H (xGER, xGERC: columns with
        v(j) = 0 are skipped). }
      for J := 1 to LASTV - 1 do
        WORK[LASTC + J] := LMTau * CONJ(V[VOff + J * INCV]);
      for I := 0 to LASTC - 1 do
      begin
        LTemp := WORK[I];
        for J := 1 to LASTV - 1 do
          if CABS1(V[VOff + J * INCV]) <> 0 then
            C[COff + I * LDC + J] := C[COff + I * LDC + J] +
              LTemp * WORK[LASTC + J];
      end;
    end;
  end;
end;

{ xGEHD2 (LAPACK 3.12.1): H(i) = I - tau*v*v^H is applied from the right
  with tau and from the left with conj(tau), v stored below the
  subdiagonal. }
generic procedure GEHD2<T>(N, ILO, IHI: longint; var A: array of T;
  var TAU: array of T);
var
  I: longint;
  ALPHA, LTau: T;
  WORK: array of T;
begin
  WORK := nil;
  SetLength(WORK, 2 * N);
  for I := ILO to IHI - 1 do
  begin
    { Compute elementary reflector H(i) to annihilate A(i+2:ihi, i). }
    ALPHA := A[(I + 1) * N + I];
    LARFG(IHI - I, ALPHA, A, Min(I + 2, N - 1) * N + I, N, LTau);
    A[(I + 1) * N + I] := ALPHA;
    TAU[I] := LTau;
    { Apply H(i) to A(0:ihi, i+1:ihi) from the right. }
    specialize LARF1F<T>(False, IHI + 1, IHI - I, A, (I + 1) * N + I, N,
      LTau, A, I + 1, N, WORK);
    { Apply H(i)^H to A(i+1:ihi, i+1:n-1) from the left. }
    specialize LARF1F<T>(True, IHI - I, N - I - 1, A, (I + 1) * N + I, N,
      CONJ(LTau), A, (I + 1) * N + I + 1, N, WORK);
  end;
end;

{ xORG2R (LAPACK 3.12.1): the M x N matrix Q with orthonormal columns,
  the first N columns of H(0)*H(1)*...*H(K-1), from the reflectors held
  in the first K columns of the matrix at A[AOff] (row stride LDA) and
  TAU[TauOff..]. }
generic procedure ORG2R<T>(M, N, K: longint; var A: array of T;
  AOff, LDA: longint; const TAU: array of T; TauOff: longint);
var
  I, J, L: longint;
  LOne, LTau: T;
  WORK: array of T;
begin
  if N <= 0 then Exit;
  LOne := 1;
  WORK := nil;
  SetLength(WORK, 2 * Max(M, N));
  { Initialise columns k:n-1 to columns of the unit matrix. }
  for J := K to N - 1 do
  begin
    for L := 0 to M - 1 do A[AOff + L * LDA + J] := Default(T);
    A[AOff + J * LDA + J] := LOne;
  end;
  for I := K - 1 downto 0 do
  begin
    LTau := TAU[TauOff + I];
    { Apply H(i) to A(i:m-1, i+1:n-1) from the left. }
    if I < N - 1 then
      specialize LARF1F<T>(True, M - I, N - I - 1, A, AOff + I * LDA + I, LDA,
        LTau, A, AOff + I * LDA + I + 1, LDA, WORK);
    if (I < M - 1) and not ISONE(-LTau) then
      for L := I + 1 to M - 1 do
        A[AOff + L * LDA + I] := -LTau * A[AOff + L * LDA + I];
    A[AOff + I * LDA + I] := LOne - LTau;
    { Set A(0:i-1, i) to zero. }
    for L := 0 to I - 1 do A[AOff + L * LDA + I] := Default(T);
  end;
end;


{ xGEBAL, JOB = 'B' (LAPACK 3.12). }
generic procedure GEBAL<T>(N: longint; var A: array of T; out ILO, IHI: longint;
  out SCALE: TArrayOfReal);
const
  SFMIN1: TReal = 1.0020841800044864E-292; { DLAMCH('S') / DLAMCH('P') = 2^-970 }
  SFMAX1: TReal = 9.9792015476736E+291; { 2^970 }
  SFMIN2: TReal = 2.004168360008973E-292; { 2^-969 }
  SFMAX2: TReal = 4.9896007738368E+291; { 2^969 }
  FACTOR: TReal = 0.95;
var
  I, J, K, L, ICA, IRA: longint;
  C, R, CA, RA, F, G, S: TReal;
  NOCONV, CANSWAP: boolean;

  procedure Exchange(AFirst, ASecond: longint);
  var
    LIndex: longint;
    LValue: T;
  begin
    { Columns AFirst and ASecond in rows 0..L, rows in columns K..N-1. }
    for LIndex := 0 to L do
    begin
      LValue := A[LIndex * N + AFirst];
      A[LIndex * N + AFirst] := A[LIndex * N + ASecond];
      A[LIndex * N + ASecond] := LValue;
    end;
    for LIndex := K to N - 1 do
    begin
      LValue := A[AFirst * N + LIndex];
      A[AFirst * N + LIndex] := A[ASecond * N + LIndex];
      A[ASecond * N + LIndex] := LValue;
    end;
  end;

begin
  SCALE := nil;
  SetLength(SCALE, N);
  ILO := 0;
  IHI := N - 1;
  if N = 0 then Exit;
  K := 0;
  L := N - 1;

  { Search for rows isolating an eigenvalue and push them down. }
  NOCONV := True;
  while NOCONV do
  begin
    NOCONV := False;
    for I := L downto 0 do
    begin
      CANSWAP := True;
      for J := 0 to L do
        if (I <> J) and (CABS1(A[I * N + J]) <> 0) then
        begin
          CANSWAP := False;
          Break;
        end;
      if CANSWAP then
      begin
        SCALE[L] := I;
        if I <> L then Exchange(I, L);
        NOCONV := True;
        if L = 0 then
        begin
          ILO := 0;
          IHI := 0;
          Exit;
        end;
        Dec(L);
      end;
    end;
  end;

  { Search for columns isolating an eigenvalue and push them left. }
  NOCONV := True;
  while NOCONV do
  begin
    NOCONV := False;
    for J := K to L do
    begin
      CANSWAP := True;
      for I := K to L do
        if (I <> J) and (CABS1(A[I * N + J]) <> 0) then
        begin
          CANSWAP := False;
          Break;
        end;
      if CANSWAP then
      begin
        SCALE[K] := J;
        if J <> K then Exchange(J, K);
        NOCONV := True;
        Inc(K);
      end;
    end;
  end;

  { Balance the submatrix in rows K to L: iterative loop for norm
    reduction. }
  for I := K to L do SCALE[I] := 1;
  NOCONV := True;
  while NOCONV do
  begin
    NOCONV := False;
    for I := K to L do
    begin
      C := specialize NRM2<T>(L - K + 1, A, K * N + I, N);
      R := specialize NRM2<T>(L - K + 1, A, I * N + K, 1);
      ICA := 0;
      for J := 1 to L do
        if CABS1(A[J * N + I]) > CABS1(A[ICA * N + I]) then ICA := J;
      CA := Abs(A[ICA * N + I]);
      IRA := K;
      for J := K + 1 to N - 1 do
        if CABS1(A[I * N + J]) > CABS1(A[I * N + IRA]) then IRA := J;
      RA := Abs(A[I * N + IRA]);
      { Guard against zero C or R due to underflow. }
      if (C = 0) or (R = 0) then Continue;
      if IsNan(C + CA + R + RA) then
        raise EInvalidOp.Create('xGEBAL: NaN in the matrix.');
      G := R / 2;
      F := 1;
      S := C + R;
      while (C < G) and (Max(F, Max(C, CA)) < SFMAX2) and
        (Min(R, Min(G, RA)) > SFMIN2) do
      begin
        F := F * 2;
        C := C * 2;
        CA := CA * 2;
        R := R / 2;
        G := G / 2;
        RA := RA / 2;
      end;
      G := C / 2;
      while (G >= R) and (Max(R, RA) < SFMAX2) and
        (Min(Min(F, C), Min(G, CA)) > SFMIN2) do
      begin
        F := F / 2;
        C := C / 2;
        G := G / 2;
        CA := CA / 2;
        R := R * 2;
        RA := RA * 2;
      end;
      { Now balance. }
      if C + R >= FACTOR * S then Continue;
      if (F < 1) and (SCALE[I] < 1) and (F * SCALE[I] <= SFMIN1) then Continue;
      if (F > 1) and (SCALE[I] > 1) and (SCALE[I] >= SFMAX1 / F) then Continue;
      G := 1 / F;
      SCALE[I] := SCALE[I] * F;
      NOCONV := True;
      for J := K to N - 1 do A[I * N + J] := A[I * N + J] * G;
      for J := 0 to L do A[J * N + I] := A[J * N + I] * F;
    end;
  end;
  ILO := K;
  IHI := L;
end;

{ xGEBAK, JOB = 'B', SIDE = 'R'. }
generic procedure GEBAK<T>(N, ILO, IHI: longint; const SCALE: TArrayOfReal;
  M: longint; var V: array of T);
var
  I, II, J, K: longint;
  LValue: T;
begin
  if (N = 0) or (M = 0) then Exit;
  if ILO <> IHI then
    for I := ILO to IHI do
      for J := 0 to M - 1 do V[I * M + J] := V[I * M + J] * SCALE[I];
  for II := 0 to N - 1 do
  begin
    I := II;
    if (I >= ILO) and (I <= IHI) then Continue;
    if I < ILO then I := ILO - 1 - II;
    K := Round(SCALE[I]);
    if K = I then Continue;
    for J := 0 to M - 1 do
    begin
      LValue := V[I * M + J];
      V[I * M + J] := V[K * M + J];
      V[K * M + J] := LValue;
    end;
  end;
end;

procedure DGEBAL(N: longint; var A: TArrayOfReal; out ILO, IHI: longint;
  out SCALE: TArrayOfReal);
begin
  specialize GEBAL<TReal>(N, A, ILO, IHI, SCALE);
end;

procedure ZGEBAL(N: longint; var A: TArrayOfComplex; out ILO, IHI: longint;
  out SCALE: TArrayOfReal);
begin
  specialize GEBAL<TComplex>(N, A, ILO, IHI, SCALE);
end;

procedure DGEBAK(N, ILO, IHI: longint; const SCALE: TArrayOfReal; M: longint;
  var V: TArrayOfReal);
begin
  specialize GEBAK<TReal>(N, ILO, IHI, SCALE, M, V);
end;

procedure ZGEBAK(N, ILO, IHI: longint; const SCALE: TArrayOfReal; M: longint;
  var V: TArrayOfComplex);
begin
  specialize GEBAK<TComplex>(N, ILO, IHI, SCALE, M, V);
end;

procedure DLANV2(var A, B, C, D: TReal; out RT1R, RT1I, RT2R, RT2I, CS,
  SN: TReal);
const
  MULTPL = 4;
  { 2^-485 and 2^485: DLAMCH('B')**INT(LOG(SAFMIN/EPS)/LOG(BASE)/2). }
  SAFMN2: TReal = 1.0010415475915505E-146;
  SAFMX2: TReal = 9.989595361011175E+145;
var
  AA, BB, BCMAX, BCMIS, CC, CS1, DD, P, SAB, SAC, SCALE, SIGMA, SN1, TAU,
    TEMP, Z: TReal;
  COUNT: longint;
begin
  if C = 0 then
  begin
    CS := 1;
    SN := 0;
  end else if B = 0 then
  begin
    { Swap rows and columns. }
    CS := 0;
    SN := 1;
    TEMP := D;
    D := A;
    A := TEMP;
    B := -C;
    C := 0;
  end else if (A - D = 0) and (SIGN(1, B) <> SIGN(1, C)) then
  begin
    CS := 1;
    SN := 0;
  end else
  begin
    TEMP := A - D;
    P := TEMP / 2;
    BCMAX := Max(System.Abs(B), System.Abs(C));
    BCMIS := Min(System.Abs(B), System.Abs(C)) * SIGN(1, B) * SIGN(1, C);
    SCALE := Max(System.Abs(P), BCMAX);
    Z := (P / SCALE) * P + (BCMAX / SCALE) * BCMIS;
    { If Z is of the order of the machine accuracy, postpone the decision
      on the nature of the eigenvalues. }
    if Z >= MULTPL * LapackPrecision then
    begin
      { Real eigenvalues: compute A and D. }
      Z := P + SIGN(Sqrt(SCALE) * Sqrt(Z), P);
      A := D + Z;
      D := D - (BCMAX / Z) * BCMIS;
      { Compute B and the rotation matrix. }
      TAU := DLAPY2(C, Z);
      CS := Z / TAU;
      SN := C / TAU;
      B := B - C;
      C := 0;
    end else
    begin
      { Complex eigenvalues, or real (almost) equal eigenvalues: make the
        diagonal elements equal. }
      COUNT := 0;
      SIGMA := B + C;
      repeat
        Inc(COUNT);
        SCALE := Max(System.Abs(TEMP), System.Abs(SIGMA));
        if SCALE >= SAFMX2 then
        begin
          SIGMA := SIGMA * SAFMN2;
          TEMP := TEMP * SAFMN2;
        end else if SCALE <= SAFMN2 then
        begin
          SIGMA := SIGMA * SAFMX2;
          TEMP := TEMP * SAFMX2;
        end else
          Break;
      until COUNT > 20;
      P := TEMP / 2;
      TAU := DLAPY2(SIGMA, TEMP);
      CS := Sqrt((1 + System.Abs(SIGMA) / TAU) / 2);
      SN := -(P / (TAU * CS)) * SIGN(1, SIGMA);
      { [AA BB; CC DD] = [A B; C D] * [CS -SN; SN CS] }
      AA := A * CS + B * SN;
      BB := -A * SN + B * CS;
      CC := C * CS + D * SN;
      DD := -C * SN + D * CS;
      { [A B; C D] = [CS SN; -SN CS] * [AA BB; CC DD] }
      A := AA * CS + CC * SN;
      B := BB * CS + DD * SN;
      C := -AA * SN + CC * CS;
      D := -BB * SN + DD * CS;
      TEMP := (A + D) / 2;
      A := TEMP;
      D := TEMP;
      if C <> 0 then
      begin
        if B <> 0 then
        begin
          if SIGN(1, B) = SIGN(1, C) then
          begin
            { Real eigenvalues: reduce to upper triangular form. }
            SAB := Sqrt(System.Abs(B));
            SAC := Sqrt(System.Abs(C));
            P := SIGN(SAB * SAC, C);
            TAU := 1 / Sqrt(System.Abs(B + C));
            A := TEMP + P;
            D := TEMP - P;
            B := B - C;
            C := 0;
            CS1 := SAB * TAU;
            SN1 := SAC * TAU;
            TEMP := CS * CS1 - SN * SN1;
            SN := CS * SN1 + SN * CS1;
            CS := TEMP;
          end;
        end else
        begin
          B := -C;
          C := 0;
          TEMP := CS;
          CS := -SN;
          SN := TEMP;
        end;
      end;
    end;
  end;
  { Store eigenvalues in (RT1R, RT1I) and (RT2R, RT2I). }
  RT1R := A;
  RT2R := D;
  if C = 0 then
  begin
    RT1I := 0;
    RT2I := 0;
  end else
  begin
    RT1I := Sqrt(System.Abs(B)) * Sqrt(System.Abs(C));
    RT2I := -RT1I;
  end;
end;

{ Plane rotation of the pair (AX, AY), as DROT. }
procedure DROT(var AX, AY: TReal; ACos, ASin: TReal); inline;
var
  LTemp: TReal;
begin
  LTemp := ACos * AX + ASin * AY;
  AY := ACos * AY - ASin * AX;
  AX := LTemp;
end;

{ IPARMQ (LAPACK 3.12.1) for the routines of xHSEQR, with ISPEC = 12
  (NMIN), 13 (NWIN), 14 (NIBBLE), 15 (NSHFTS) and 16 (KACC22) and the
  order NH = IHI - ILO + 1 of the active block; a value of LapackTuning
  that is not negative replaces the result, as the ILAENV of the LAPACK
  test programs does. }
function IPARMQ(ISPEC, ILO, IHI: longint): longint;
const
  NMIN = 75;
  K22MIN = 14;
  KACMIN = 14;
  NIBBLE = 14;
  KNWSWP = 500;
var
  NH, NS: longint;
begin
  case ISPEC of
    12: result := LapackTuning.NMIN;
    13: result := LapackTuning.NWIN;
    14: result := LapackTuning.NIBBLE;
    15: result := LapackTuning.NSHFTS;
    16: result := LapackTuning.KACC22;
  else
    result := -1;
  end;
  if result >= 0 then Exit;
  NH := IHI - ILO + 1;
  NS := 2;
  if NH >= 30 then NS := 4;
  if NH >= 60 then NS := 10;
  if NH >= 150 then NS := Max(10, NH div Round(Ln(NH) / Ln(2)));
  if NH >= 590 then NS := 64;
  if NH >= 3000 then NS := 128;
  if NH >= 6000 then NS := 256;
  NS := Max(2, NS - NS mod 2);
  case ISPEC of
    12: result := NMIN;
    13: if NH <= KNWSWP then result := NS else result := 3 * NS div 2;
    14: result := NIBBLE;
    15: result := NS;
    16:
      begin
        { xHSEQR and xLAQRn: matrix products when NS >= K22MIN. }
        result := 0;
        if NS >= KACMIN then result := 1;
        if NS >= K22MIN then result := 2;
      end;
  end;
end;

procedure DLAHQR(WANTT, WANTZ: boolean; N, ILO, IHI: longint;
  var H: array of TReal; HO, LDH: longint; var WR, WI: array of TReal;
  WO, ILOZ, IHIZ: longint; var Z: array of TReal; ZO, LDZ: longint;
  out INFO: longint);
const
  DAT1: TReal = 0.75;
  DAT2: TReal = -0.4375;
  KEXSH = 10;
var
  I, I1, I2, ITS, ITMAX, J, K, L, M, NH, NR, KDEFL: longint;
  AA, AB, BA, BB, CS, DET, H11, H12, H21, H21S, H22, RT1I, RT1R, RT2I,
    RT2R, RTDISC, S, SMLNUM, SN, SUM, T1, T2, T3, TR, TST, ULP, V2, V3: TReal;
  V: array[0..2] of TReal;
  CONVERGED: boolean;
begin
  INFO := 0;
  if N = 0 then Exit;
  if ILO = IHI then
  begin
    WR[WO + ILO] := H[HO + ILO * LDH + ILO];
    WI[WO + ILO] := 0;
    Exit;
  end;
  { Clear out the trash. }
  for J := ILO to IHI - 3 do
  begin
    H[HO + (J + 2) * LDH + J] := 0;
    H[HO + (J + 3) * LDH + J] := 0;
  end;
  if ILO <= IHI - 2 then H[HO + IHI * LDH + IHI - 2] := 0;
  NH := IHI - ILO + 1;
  { Set machine-dependent constants for the stopping criterion. }
  ULP := LapackPrecision;
  SMLNUM := LapackSafeMinimum * (NH / ULP);
  { I1 and I2 are the indices of the first row and last column of H to
    which transformations must be applied. If eigenvalues only are being
    computed, I1 and I2 are set inside the main loop. }
  I1 := 0;
  I2 := 0;
  if WANTT then
  begin
    I1 := 0;
    I2 := N - 1;
  end;
  { ITMAX is the total number of QR iterations allowed. }
  ITMAX := 30 * Max(10, NH);
  { KDEFL counts the number of iterations since a deflation. }
  KDEFL := 0;
  { The main loop begins here. I is the loop index and decreases from IHI
    to ILO in steps of 1 or 2. }
  I := IHI;
  while I >= ILO do
  begin
    { Perform QR iterations on rows and columns ILO to I until a
      submatrix of order 1 or 2 splits off at the bottom. }
    L := ILO;
    CONVERGED := False;
    for ITS := 0 to ITMAX do
    begin
      { Look for a single small subdiagonal element. }
      K := I;
      while K > L do
      begin
        if System.Abs(H[HO + K * LDH + K - 1]) <= SMLNUM then Break;
        TST := System.Abs(H[HO + (K - 1) * LDH + K - 1]) +
          System.Abs(H[HO + K * LDH + K]);
        if TST = 0 then
        begin
          if K - 2 >= ILO then
            TST := TST + System.Abs(H[HO + (K - 1) * LDH + K - 2]);
          if K + 1 <= IHI then
            TST := TST + System.Abs(H[HO + (K + 1) * LDH + K]);
        end;
        { The following is a conservative small subdiagonal deflation
          criterion due to Ahues and Kressner (2004). }
        if System.Abs(H[HO + K * LDH + K - 1]) <= ULP * TST then
        begin
          AB := Max(System.Abs(H[HO + K * LDH + K - 1]),
            System.Abs(H[HO + (K - 1) * LDH + K]));
          BA := Min(System.Abs(H[HO + K * LDH + K - 1]),
            System.Abs(H[HO + (K - 1) * LDH + K]));
          AA := Max(System.Abs(H[HO + K * LDH + K]),
            System.Abs(H[HO + (K - 1) * LDH + K - 1] - H[HO + K * LDH + K]));
          BB := Min(System.Abs(H[HO + K * LDH + K]),
            System.Abs(H[HO + (K - 1) * LDH + K - 1] - H[HO + K * LDH + K]));
          S := AA + AB;
          if BA * (AB / S) <= Max(SMLNUM, ULP * (BB * (AA / S))) then Break;
        end;
        Dec(K);
      end;
      L := K;
      { H(L, L-1) is negligible. }
      if L > ILO then H[HO + L * LDH + L - 1] := 0;
      { Exit from loop if a submatrix of order 1 or 2 has split off. }
      if L >= I - 1 then
      begin
        CONVERGED := True;
        Break;
      end;
      Inc(KDEFL);
      { Now the active submatrix is in rows and columns L to I. If
        eigenvalues only are being computed, only the active submatrix
        need be transformed. }
      if not WANTT then
      begin
        I1 := L;
        I2 := I;
      end;
      if KDEFL mod (2 * KEXSH) = 0 then
      begin
        { Exceptional shift. }
        S := System.Abs(H[HO + I * LDH + I - 1]) +
          System.Abs(H[HO + (I - 1) * LDH + I - 2]);
        H11 := DAT1 * S + H[HO + I * LDH + I];
        H12 := DAT2 * S;
        H21 := S;
        H22 := H11;
      end else if KDEFL mod KEXSH = 0 then
      begin
        { Exceptional shift. }
        S := System.Abs(H[HO + (L + 1) * LDH + L]) +
          System.Abs(H[HO + (L + 2) * LDH + L + 1]);
        H11 := DAT1 * S + H[HO + L * LDH + L];
        H12 := DAT2 * S;
        H21 := S;
        H22 := H11;
      end else
      begin
        { Prepare to use Francis' double shift (i.e. 2nd degree
          generalized Rayleigh quotient). }
        H11 := H[HO + (I - 1) * LDH + I - 1];
        H21 := H[HO + I * LDH + I - 1];
        H12 := H[HO + (I - 1) * LDH + I];
        H22 := H[HO + I * LDH + I];
      end;
      S := System.Abs(H11) + System.Abs(H12) + System.Abs(H21) + System.Abs(H22);
      if S = 0 then
      begin
        RT1R := 0;
        RT1I := 0;
        RT2R := 0;
        RT2I := 0;
      end else
      begin
        H11 := H11 / S;
        H21 := H21 / S;
        H12 := H12 / S;
        H22 := H22 / S;
        TR := (H11 + H22) / 2;
        DET := (H11 - TR) * (H22 - TR) - H12 * H21;
        RTDISC := Sqrt(System.Abs(DET));
        if DET >= 0 then
        begin
          { Complex conjugate shifts. }
          RT1R := TR * S;
          RT2R := RT1R;
          RT1I := RTDISC * S;
          RT2I := -RT1I;
        end else
        begin
          { Real shifts (use only one of them). }
          RT1R := TR + RTDISC;
          RT2R := TR - RTDISC;
          if System.Abs(RT1R - H22) <= System.Abs(RT2R - H22) then
          begin
            RT1R := RT1R * S;
            RT2R := RT1R;
          end else
          begin
            RT2R := RT2R * S;
            RT1R := RT2R;
          end;
          RT1I := 0;
          RT2I := 0;
        end;
      end;
      { Look for two consecutive small subdiagonal elements. }
      M := I - 2;
      repeat
        { Determine the effect of starting the double-shift QR iteration
          at row M, and see if this would make H(M, M-1) negligible. (The
          following uses scaling to avoid overflows and most underflows.) }
        H21S := H[HO + (M + 1) * LDH + M];
        S := System.Abs(H[HO + M * LDH + M] - RT2R) + System.Abs(RT2I) +
          System.Abs(H21S);
        H21S := H[HO + (M + 1) * LDH + M] / S;
        V[0] := H21S * H[HO + M * LDH + M + 1] + (H[HO + M * LDH + M] - RT1R) *
          ((H[HO + M * LDH + M] - RT2R) / S) - RT1I * (RT2I / S);
        V[1] := H21S * (H[HO + M * LDH + M] + H[HO + (M + 1) * LDH + M + 1] -
          RT1R - RT2R);
        V[2] := H21S * H[HO + (M + 2) * LDH + M + 1];
        S := System.Abs(V[0]) + System.Abs(V[1]) + System.Abs(V[2]);
        V[0] := V[0] / S;
        V[1] := V[1] / S;
        V[2] := V[2] / S;
        if M = L then Break;
        if System.Abs(H[HO + M * LDH + M - 1]) *
           (System.Abs(V[1]) + System.Abs(V[2])) <=
           ULP * System.Abs(V[0]) * (System.Abs(H[HO + (M - 1) * LDH + M - 1]) +
           System.Abs(H[HO + M * LDH + M]) +
           System.Abs(H[HO + (M + 1) * LDH + M + 1])) then
          Break;
        Dec(M);
      until False;
      { Double-shift QR step. }
      for K := M to I - 1 do
      begin
        { The first iteration of this loop determines a reflection G from
          the vector V and applies it from left and right to H, thus
          creating a nonzero bulge below the subdiagonal. Each subsequent
          iteration determines a reflection G to restore the Hessenberg
          form in the (K-1)th column, and thus chases the bulge one step
          toward the bottom of the active submatrix. NR is the order of G. }
        NR := Min(3, I - K + 1);
        if K > M then
          for J := 0 to NR - 1 do V[J] := H[HO + (K + J) * LDH + K - 1];
        DLARFG(NR, V[0], V, 1, 1, T1);
        if K > M then
        begin
          H[HO + K * LDH + K - 1] := V[0];
          H[HO + (K + 1) * LDH + K - 1] := 0;
          if K < I - 1 then H[HO + (K + 2) * LDH + K - 1] := 0;
        end else if M > L then
          { Use the following instead of H(K, K-1) = -H(K, K-1) to avoid
            a bug when V(2) and V(3) underflow. }
          H[HO + K * LDH + K - 1] := H[HO + K * LDH + K - 1] * (1 - T1);
        V2 := V[1];
        T2 := T1 * V2;
        if NR = 3 then
        begin
          V3 := V[2];
          T3 := T1 * V3;
          { Apply G from the left to transform the rows of the matrix in
            columns K to I2. }
          for J := K to I2 do
          begin
            SUM := H[HO + K * LDH + J] + V2 * H[HO + (K + 1) * LDH + J] +
              V3 * H[HO + (K + 2) * LDH + J];
            H[HO + K * LDH + J] := H[HO + K * LDH + J] - SUM * T1;
            H[HO + (K + 1) * LDH + J] := H[HO + (K + 1) * LDH + J] - SUM * T2;
            H[HO + (K + 2) * LDH + J] := H[HO + (K + 2) * LDH + J] - SUM * T3;
          end;
          { Apply G from the right to transform the columns of the matrix
            in rows I1 to min(K+3, I). }
          for J := I1 to Min(K + 3, I) do
          begin
            SUM := H[HO + J * LDH + K] + V2 * H[HO + J * LDH + K + 1] +
              V3 * H[HO + J * LDH + K + 2];
            H[HO + J * LDH + K] := H[HO + J * LDH + K] - SUM * T1;
            H[HO + J * LDH + K + 1] := H[HO + J * LDH + K + 1] - SUM * T2;
            H[HO + J * LDH + K + 2] := H[HO + J * LDH + K + 2] - SUM * T3;
          end;
          if WANTZ then
            { Accumulate transformations in the matrix Z. }
            for J := ILOZ to IHIZ do
            begin
              SUM := Z[ZO + J * LDZ + K] + V2 * Z[ZO + J * LDZ + K + 1] +
                V3 * Z[ZO + J * LDZ + K + 2];
              Z[ZO + J * LDZ + K] := Z[ZO + J * LDZ + K] - SUM * T1;
              Z[ZO + J * LDZ + K + 1] := Z[ZO + J * LDZ + K + 1] - SUM * T2;
              Z[ZO + J * LDZ + K + 2] := Z[ZO + J * LDZ + K + 2] - SUM * T3;
            end;
        end else if NR = 2 then
        begin
          { Apply G from the left to transform the rows of the matrix in
            columns K to I2. }
          for J := K to I2 do
          begin
            SUM := H[HO + K * LDH + J] + V2 * H[HO + (K + 1) * LDH + J];
            H[HO + K * LDH + J] := H[HO + K * LDH + J] - SUM * T1;
            H[HO + (K + 1) * LDH + J] := H[HO + (K + 1) * LDH + J] - SUM * T2;
          end;
          { Apply G from the right to transform the columns of the matrix
            in rows I1 to min(K+3, I). }
          for J := I1 to I do
          begin
            SUM := H[HO + J * LDH + K] + V2 * H[HO + J * LDH + K + 1];
            H[HO + J * LDH + K] := H[HO + J * LDH + K] - SUM * T1;
            H[HO + J * LDH + K + 1] := H[HO + J * LDH + K + 1] - SUM * T2;
          end;
          if WANTZ then
            { Accumulate transformations in the matrix Z. }
            for J := ILOZ to IHIZ do
            begin
              SUM := Z[ZO + J * LDZ + K] + V2 * Z[ZO + J * LDZ + K + 1];
              Z[ZO + J * LDZ + K] := Z[ZO + J * LDZ + K] - SUM * T1;
              Z[ZO + J * LDZ + K + 1] := Z[ZO + J * LDZ + K + 1] - SUM * T2;
            end;
        end;
      end;
    end;
    { Failure to converge in remaining number of iterations. }
    if not CONVERGED then
    begin
      INFO := I + 1;
      Exit;
    end;
    if L = I then
    begin
      { H(I, I-1) is negligible: one eigenvalue has converged. }
      WR[WO + I] := H[HO + I * LDH + I];
      WI[WO + I] := 0;
    end else if L = I - 1 then
    begin
      { H(I-1, I-2) is negligible: a pair of eigenvalues have converged.
        Transform the 2-by-2 submatrix to standard Schur form, and compute
        and store the eigenvalues. }
      DLANV2(H[HO + (I - 1) * LDH + I - 1], H[HO + (I - 1) * LDH + I],
        H[HO + I * LDH + I - 1], H[HO + I * LDH + I], WR[WO + I - 1],
        WI[WO + I - 1], WR[WO + I], WI[WO + I], CS, SN);
      if WANTT then
      begin
        { Apply the transformation to the rest of H. }
        for J := I + 1 to I2 do
          DROT(H[HO + (I - 1) * LDH + J], H[HO + I * LDH + J], CS, SN);
        for J := I1 to I - 2 do
          DROT(H[HO + J * LDH + I - 1], H[HO + J * LDH + I], CS, SN);
      end;
      if WANTZ then
        { Apply the transformation to Z. }
        for J := ILOZ to IHIZ do
          DROT(Z[ZO + J * LDZ + I - 1], Z[ZO + J * LDZ + I], CS, SN);
    end;
    { Reset deflation counter. }
    KDEFL := 0;
    { Return to start of the main loop with new value of I. }
    I := L - 1;
  end;
end;

{ DLAQR1: a multiple of the first column of (H - (SR1 + i*SI1)*I) *
  (H - (SR2 + i*SI2)*I), for the 2x2 or 3x3 matrix H at H[HO] with row
  stride LDH; the shifts are real or a complex conjugate pair. }
procedure DLAQR1(N: longint; const H: array of TReal; HO, LDH: longint;
  SR1, SI1, SR2, SI2: TReal; var V: array of TReal; VO: longint);
var
  H21S, H31S, S, H11, H12, H13, H21, H22, H23, H31, H32, H33: TReal;
begin
  if (N <> 2) and (N <> 3) then Exit;
  H11 := H[HO];
  H12 := H[HO + 1];
  H21 := H[HO + LDH];
  H22 := H[HO + LDH + 1];
  if N = 2 then
  begin
    S := System.Abs(H11 - SR2) + System.Abs(SI2) + System.Abs(H21);
    if S = 0 then
    begin
      V[VO] := 0;
      V[VO + 1] := 0;
    end else
    begin
      H21S := H21 / S;
      V[VO] := H21S * H12 + (H11 - SR1) * ((H11 - SR2) / S) - SI1 * (SI2 / S);
      V[VO + 1] := H21S * (H11 + H22 - SR1 - SR2);
    end;
  end else
  begin
    H13 := H[HO + 2];
    H23 := H[HO + LDH + 2];
    H31 := H[HO + 2 * LDH];
    H32 := H[HO + 2 * LDH + 1];
    H33 := H[HO + 2 * LDH + 2];
    S := System.Abs(H11 - SR2) + System.Abs(SI2) + System.Abs(H21) +
      System.Abs(H31);
    if S = 0 then
    begin
      V[VO] := 0;
      V[VO + 1] := 0;
      V[VO + 2] := 0;
    end else
    begin
      H21S := H21 / S;
      H31S := H31 / S;
      V[VO] := (H11 - SR1) * ((H11 - SR2) / S) - SI1 * (SI2 / S) +
        H12 * H21S + H13 * H31S;
      V[VO + 1] := H21S * (H11 + H22 - SR1 - SR2) + H23 * H31S;
      V[VO + 2] := H31S * (H11 + H33 - SR1 - SR2) + H21S * H32;
    end;
  end;
end;

{ DLASY2 with LTRANL = LTRANR = false: solves TL*X + ISGN*X*TR =
  SCALE*B for the N1 x N1 TL and the N2 x N2 TR (N1, N2 in 1..2), all
  stored by rows in 2x2 arrays. INFO = 1 when TL and -ISGN*TR have close
  eigenvalues and the system was perturbed. }
procedure DLASY2(ISGN, N1, N2: longint; const TL, TR, B: array of TReal;
  out SCALE: TReal; out X: array of TReal; out XNORM: TReal;
  out INFO: longint);
const
  { Column-major positions 1..4 of the 2x2 TMP, as in DLASY2. }
  LOCU12: array[1..4] of longint = (3, 4, 1, 2);
  LOCL21: array[1..4] of longint = (2, 1, 4, 3);
  LOCU22: array[1..4] of longint = (4, 3, 2, 1);
  XSWPIV: array[1..4] of boolean = (False, False, True, True);
  BSWPIV: array[1..4] of boolean = (False, True, False, True);
var
  BSWAP, XSWAP: boolean;
  I, IP, IPSV, J, JP, JPSV, K, IPIV: longint;
  BET, EPS, GAM, L21, SGN, SMIN, SMLNUM, TAU1, TEMP, U11, U12, U22,
    XMAX: TReal;
  BTMP, TMP: array[1..4] of TReal;
  X2: array[1..2] of TReal;
  T16: array[1..4, 1..4] of TReal;
  JPIV: array[1..4] of longint;
begin
  INFO := 0;
  SCALE := 1;
  XNORM := 0;
  X[0] := 0; X[1] := 0; X[2] := 0; X[3] := 0;
  { Quick return if possible. }
  if (N1 = 0) or (N2 = 0) then Exit;
  { Set constants to control overflow. }
  EPS := LapackPrecision;
  SMLNUM := LapackSafeMinimum / EPS;
  SGN := ISGN;
  K := N1 + N1 + N2 - 2;
  if K = 1 then
  begin
    { 1 by 1: TL11*X + SGN*X*TR11 = B11. }
    TAU1 := TL[0] + SGN * TR[0];
    BET := System.Abs(TAU1);
    if BET <= SMLNUM then
    begin
      TAU1 := SMLNUM;
      BET := SMLNUM;
      INFO := 1;
    end;
    SCALE := 1;
    GAM := System.Abs(B[0]);
    if SMLNUM * GAM > BET then SCALE := 1 / GAM;
    X[0] := (B[0] * SCALE) / TAU1;
    XNORM := System.Abs(X[0]);
    Exit;
  end;
  if K <= 3 then
  begin
    if K = 2 then
    begin
      { 1 by 2: TL11*[X11 X12] + ISGN*[X11 X12]*op[TR11 TR12; TR21 TR22]
        = [B11 B12]. }
      SMIN := Max(EPS * Max(Max(System.Abs(TL[0]), System.Abs(TR[0])),
        Max(Max(System.Abs(TR[1]), System.Abs(TR[2])), System.Abs(TR[3]))),
        SMLNUM);
      TMP[1] := TL[0] + SGN * TR[0];
      TMP[4] := TL[0] + SGN * TR[3];
      TMP[2] := SGN * TR[1];
      TMP[3] := SGN * TR[2];
      BTMP[1] := B[0];
      BTMP[2] := B[1];
    end else
    begin
      { 2 by 1: op[TL11 TL12; TL21 TL22]*[X11; X21] + ISGN*[X11; X21]*TR11
        = [B11; B21]. }
      SMIN := Max(EPS * Max(Max(System.Abs(TR[0]), System.Abs(TL[0])),
        Max(Max(System.Abs(TL[1]), System.Abs(TL[2])), System.Abs(TL[3]))),
        SMLNUM);
      TMP[1] := TL[0] + SGN * TR[0];
      TMP[4] := TL[3] + SGN * TR[0];
      TMP[2] := TL[2];
      TMP[3] := TL[1];
      BTMP[1] := B[0];
      BTMP[2] := B[2];
    end;
    { Solve 2 by 2 system using complete pivoting. Set pivots near zero to
      SMIN. }
    IPIV := 1;
    for I := 2 to 4 do
      if System.Abs(TMP[I]) > System.Abs(TMP[IPIV]) then IPIV := I;
    U11 := TMP[IPIV];
    if System.Abs(U11) <= SMIN then
    begin
      INFO := 1;
      U11 := SMIN;
    end;
    U12 := TMP[LOCU12[IPIV]];
    L21 := TMP[LOCL21[IPIV]] / U11;
    U22 := TMP[LOCU22[IPIV]] - U12 * L21;
    XSWAP := XSWPIV[IPIV];
    BSWAP := BSWPIV[IPIV];
    if System.Abs(U22) <= SMIN then
    begin
      INFO := 1;
      U22 := SMIN;
    end;
    if BSWAP then
    begin
      TEMP := BTMP[2];
      BTMP[2] := BTMP[1] - L21 * TEMP;
      BTMP[1] := TEMP;
    end else
      BTMP[2] := BTMP[2] - L21 * BTMP[1];
    SCALE := 1;
    if ((2 * SMLNUM) * System.Abs(BTMP[2]) > System.Abs(U22)) or
       ((2 * SMLNUM) * System.Abs(BTMP[1]) > System.Abs(U11)) then
    begin
      SCALE := 0.5 / Max(System.Abs(BTMP[1]), System.Abs(BTMP[2]));
      BTMP[1] := BTMP[1] * SCALE;
      BTMP[2] := BTMP[2] * SCALE;
    end;
    X2[2] := BTMP[2] / U22;
    X2[1] := BTMP[1] / U11 - (U12 / U11) * X2[2];
    if XSWAP then
    begin
      TEMP := X2[2];
      X2[2] := X2[1];
      X2[1] := TEMP;
    end;
    X[0] := X2[1];
    if N1 = 1 then
    begin
      X[1] := X2[2];
      XNORM := System.Abs(X[0]) + System.Abs(X[1]);
    end else
    begin
      X[2] := X2[2];
      XNORM := Max(System.Abs(X[0]), System.Abs(X[2]));
    end;
    Exit;
  end;
  { 2 by 2: op[TL11 TL12; TL21 TL22]*[X11 X12; X21 X22] + ISGN*[X11 X12;
    X21 X22]*op[TR11 TR12; TR21 TR22] = [B11 B12; B21 B22]. Solve
    equivalent 4 by 4 system using complete pivoting. Set pivots near zero
    to SMIN. }
  SMIN := Max(Max(System.Abs(TR[0]), System.Abs(TR[1])),
    Max(System.Abs(TR[2]), System.Abs(TR[3])));
  SMIN := Max(Max(SMIN, System.Abs(TL[0])), Max(System.Abs(TL[1]),
    Max(System.Abs(TL[2]), System.Abs(TL[3]))));
  SMIN := Max(EPS * SMIN, SMLNUM);
  for I := 1 to 4 do
    for J := 1 to 4 do T16[I, J] := 0;
  T16[1, 1] := TL[0] + SGN * TR[0];
  T16[2, 2] := TL[3] + SGN * TR[0];
  T16[3, 3] := TL[0] + SGN * TR[3];
  T16[4, 4] := TL[3] + SGN * TR[3];
  T16[1, 2] := TL[1];
  T16[2, 1] := TL[2];
  T16[3, 4] := TL[1];
  T16[4, 3] := TL[2];
  T16[1, 3] := SGN * TR[2];
  T16[2, 4] := SGN * TR[2];
  T16[3, 1] := SGN * TR[1];
  T16[4, 2] := SGN * TR[1];
  BTMP[1] := B[0];
  BTMP[2] := B[2];
  BTMP[3] := B[1];
  BTMP[4] := B[3];
  { Perform elimination. }
  IPSV := 0;
  JPSV := 0;
  for I := 1 to 3 do
  begin
    XMAX := 0;
    for IP := I to 4 do
      for JP := I to 4 do
        if System.Abs(T16[IP, JP]) >= XMAX then
        begin
          XMAX := System.Abs(T16[IP, JP]);
          IPSV := IP;
          JPSV := JP;
        end;
    if IPSV <> I then
    begin
      for J := 1 to 4 do
      begin
        TEMP := T16[IPSV, J];
        T16[IPSV, J] := T16[I, J];
        T16[I, J] := TEMP;
      end;
      TEMP := BTMP[I];
      BTMP[I] := BTMP[IPSV];
      BTMP[IPSV] := TEMP;
    end;
    if JPSV <> I then
      for J := 1 to 4 do
      begin
        TEMP := T16[J, JPSV];
        T16[J, JPSV] := T16[J, I];
        T16[J, I] := TEMP;
      end;
    JPIV[I] := JPSV;
    if System.Abs(T16[I, I]) < SMIN then
    begin
      INFO := 1;
      T16[I, I] := SMIN;
    end;
    for J := I + 1 to 4 do
    begin
      T16[J, I] := T16[J, I] / T16[I, I];
      BTMP[J] := BTMP[J] - T16[J, I] * BTMP[I];
      for K := I + 1 to 4 do
        T16[J, K] := T16[J, K] - T16[J, I] * T16[I, K];
    end;
  end;
  if System.Abs(T16[4, 4]) < SMIN then
  begin
    INFO := 1;
    T16[4, 4] := SMIN;
  end;
  SCALE := 1;
  if ((8 * SMLNUM) * System.Abs(BTMP[1]) > System.Abs(T16[1, 1])) or
     ((8 * SMLNUM) * System.Abs(BTMP[2]) > System.Abs(T16[2, 2])) or
     ((8 * SMLNUM) * System.Abs(BTMP[3]) > System.Abs(T16[3, 3])) or
     ((8 * SMLNUM) * System.Abs(BTMP[4]) > System.Abs(T16[4, 4])) then
  begin
    SCALE := 0.125 / Max(Max(System.Abs(BTMP[1]), System.Abs(BTMP[2])),
      Max(System.Abs(BTMP[3]), System.Abs(BTMP[4])));
    BTMP[1] := BTMP[1] * SCALE;
    BTMP[2] := BTMP[2] * SCALE;
    BTMP[3] := BTMP[3] * SCALE;
    BTMP[4] := BTMP[4] * SCALE;
  end;
  for I := 1 to 4 do
  begin
    K := 5 - I;
    TEMP := 1 / T16[K, K];
    TMP[K] := BTMP[K] * TEMP;
    for J := K + 1 to 4 do
      TMP[K] := TMP[K] - (TEMP * T16[K, J]) * TMP[J];
  end;
  for I := 1 to 3 do
    if JPIV[4 - I] <> 4 - I then
    begin
      TEMP := TMP[4 - I];
      TMP[4 - I] := TMP[JPIV[4 - I]];
      TMP[JPIV[4 - I]] := TEMP;
    end;
  X[0] := TMP[1];
  X[2] := TMP[2];
  X[1] := TMP[3];
  X[3] := TMP[4];
  XNORM := Max(System.Abs(TMP[1]) + System.Abs(TMP[3]),
    System.Abs(TMP[2]) + System.Abs(TMP[4]));
end;

{ DLARFX for reflectors of order 3 (the orders used by DLAEXC): applies
  H = I - TAU*u*u^T to the M x N matrix C at C[CO] with row stride LDC,
  from the left (M = 3) or the right (N = 3). }
procedure DLARFX3(LEFT: boolean; M, N: longint; const U: array of TReal;
  TAU: TReal; var C: array of TReal; CO, LDC: longint);
var
  J: longint;
  SUM, T1, T2, T3, V1, V2, V3: TReal;
begin
  V1 := U[0];
  T1 := TAU * V1;
  V2 := U[1];
  T2 := TAU * V2;
  V3 := U[2];
  T3 := TAU * V3;
  if LEFT then
    for J := 0 to N - 1 do
    begin
      SUM := V1 * C[CO + J] + V2 * C[CO + LDC + J] + V3 * C[CO + 2 * LDC + J];
      C[CO + J] := C[CO + J] - SUM * T1;
      C[CO + LDC + J] := C[CO + LDC + J] - SUM * T2;
      C[CO + 2 * LDC + J] := C[CO + 2 * LDC + J] - SUM * T3;
    end
  else
    for J := 0 to M - 1 do
    begin
      SUM := V1 * C[CO + J * LDC] + V2 * C[CO + J * LDC + 1] +
        V3 * C[CO + J * LDC + 2];
      C[CO + J * LDC] := C[CO + J * LDC] - SUM * T1;
      C[CO + J * LDC + 1] := C[CO + J * LDC + 1] - SUM * T2;
      C[CO + J * LDC + 2] := C[CO + J * LDC + 2] - SUM * T3;
    end;
end;

{ DLAEXC with WANTQ = true: swaps adjacent diagonal blocks T11 (N1 x N1,
  at row and column J1) and T22 (N2 x N2) of the N x N upper
  quasi-triangular T (stored by rows), updating the Schur vectors Q.
  INFO = 1 when the swap was rejected because the result would be too far
  from upper quasi-triangular form. }
procedure DLAEXC(N: longint; var T, Q: array of TReal; J1, N1, N2: longint;
  out INFO: longint);
const
  TEN: TReal = 10;
var
  IERR, J2, J3, J4, K, ND, I, J: longint;
  CS, DNORM, EPS, SCALE, SMLNUM, SN, T11, T22, T33, TAU, TAU1, TAU2,
    TEMP, THRESH, WI1, WI2, WR1, WR2, XNORM: TReal;
  D: array[0..15] of TReal;
  X: array[0..3] of TReal;
  TL, TR, B: array[0..3] of TReal;
  U, U1, U2: array[0..2] of TReal;
begin
  INFO := 0;
  { Quick return if possible. }
  if (N = 0) or (N1 = 0) or (N2 = 0) then Exit;
  if J1 + N1 > N - 1 then Exit;
  J2 := J1 + 1;
  J3 := J1 + 2;
  J4 := J1 + 3;
  if (N1 = 1) and (N2 = 1) then
  begin
    { Swap two 1 by 1 blocks. }
    T11 := T[J1 * N + J1];
    T22 := T[J2 * N + J2];
    { Determine the transformation to perform the interchange. }
    DLARTG(T[J1 * N + J2], T22 - T11, CS, SN, TEMP);
    { Apply transformation to the matrix T. }
    if J3 <= N - 1 then
      for J := J3 to N - 1 do DROT(T[J1 * N + J], T[J2 * N + J], CS, SN);
    for I := 0 to J1 - 1 do DROT(T[I * N + J1], T[I * N + J2], CS, SN);
    T[J1 * N + J1] := T22;
    T[J2 * N + J2] := T11;
    for I := 0 to N - 1 do DROT(Q[I * N + J1], Q[I * N + J2], CS, SN);
    Exit;
  end;
  { Swapping involves at least one 2 by 2 block. Copy the diagonal block
    of order N1+N2 to the local array D (4 x 4, stored by rows) and
    compute its norm. }
  ND := N1 + N2;
  for I := 0 to 15 do D[I] := 0;
  DNORM := 0;
  for I := 0 to ND - 1 do
    for J := 0 to ND - 1 do
    begin
      D[I * 4 + J] := T[(J1 + I) * N + J1 + J];
      { DLANGE('Max'): NaN propagates. }
      TEMP := System.Abs(D[I * 4 + J]);
      if (DNORM < TEMP) or IsNan(TEMP) then DNORM := TEMP;
    end;
  { Compute machine-dependent threshold for test for accepting swap. }
  EPS := LapackPrecision;
  SMLNUM := LapackSafeMinimum / EPS;
  THRESH := Max(TEN * EPS * DNORM, SMLNUM);
  { Solve T11*X - X*T22 = scale*T12 for X. }
  for I := 0 to 3 do
  begin
    TL[I] := 0;
    TR[I] := 0;
    B[I] := 0;
  end;
  for I := 0 to N1 - 1 do
    for J := 0 to N1 - 1 do TL[I * 2 + J] := D[I * 4 + J];
  for I := 0 to N2 - 1 do
    for J := 0 to N2 - 1 do TR[I * 2 + J] := D[(N1 + I) * 4 + N1 + J];
  for I := 0 to N1 - 1 do
    for J := 0 to N2 - 1 do B[I * 2 + J] := D[I * 4 + N1 + J];
  DLASY2(-1, N1, N2, TL, TR, B, SCALE, X, XNORM, IERR);
  { Swap the adjacent diagonal blocks. }
  K := N1 + N1 + N2 - 3;
  if K = 1 then
  begin
    { N1 = 1, N2 = 2: generate elementary reflector H so that
      ( scale, X11, X12 ) H = ( 0, 0, * ). }
    U[0] := SCALE;
    U[1] := X[0];
    U[2] := X[1];
    DLARFG(3, U[2], U, 0, 1, TAU);
    U[2] := 1;
    T11 := T[J1 * N + J1];
    { Perform swap provisionally on diagonal block in D. }
    DLARFX3(True, 3, 3, U, TAU, D, 0, 4);
    DLARFX3(False, 3, 3, U, TAU, D, 0, 4);
    { Test whether to reject swap. }
    if Max(Max(System.Abs(D[2 * 4]), System.Abs(D[2 * 4 + 1])),
       System.Abs(D[2 * 4 + 2] - T11)) > THRESH then
    begin
      INFO := 1;
      Exit;
    end;
    { Accept swap: apply transformation to the entire matrix T. }
    DLARFX3(True, 3, N - J1, U, TAU, T, J1 * N + J1, N);
    DLARFX3(False, J2 + 1, 3, U, TAU, T, J1, N);
    T[J3 * N + J1] := 0;
    T[J3 * N + J2] := 0;
    T[J3 * N + J3] := T11;
    { Accumulate transformation in the matrix Q. }
    DLARFX3(False, N, 3, U, TAU, Q, J1, N);
  end else if K = 2 then
  begin
    { N1 = 2, N2 = 1: generate elementary reflector H so that
      H ( -X11 ) = ( * )
        ( -X21 ) = ( 0 )
        ( scale) = ( 0 ). }
    U[0] := -X[0];
    U[1] := -X[2];
    U[2] := SCALE;
    DLARFG(3, U[0], U, 1, 1, TAU);
    U[0] := 1;
    T33 := T[J3 * N + J3];
    { Perform swap provisionally on diagonal block in D. }
    DLARFX3(True, 3, 3, U, TAU, D, 0, 4);
    DLARFX3(False, 3, 3, U, TAU, D, 0, 4);
    { Test whether to reject swap. }
    if Max(Max(System.Abs(D[1 * 4]), System.Abs(D[2 * 4])),
       System.Abs(D[0] - T33)) > THRESH then
    begin
      INFO := 1;
      Exit;
    end;
    { Accept swap: apply transformation to the entire matrix T. }
    DLARFX3(False, J3 + 1, 3, U, TAU, T, J1, N);
    DLARFX3(True, 3, N - J1 - 1, U, TAU, T, J1 * N + J2, N);
    T[J1 * N + J1] := T33;
    T[J2 * N + J1] := 0;
    T[J3 * N + J1] := 0;
    { Accumulate transformation in the matrix Q. }
    DLARFX3(False, N, 3, U, TAU, Q, J1, N);
  end else
  begin
    { N1 = 2, N2 = 2: generate elementary reflectors H(1) and H(2) so that
      H(2) H(1) ( -X11 -X12 ) = ( * * )
                ( -X21 -X22 )   ( 0 * )
                ( scale  0  )   ( 0 0 )
                (   0  scale)   ( 0 0 ). }
    U1[0] := -X[0];
    U1[1] := -X[2];
    U1[2] := SCALE;
    DLARFG(3, U1[0], U1, 1, 1, TAU1);
    U1[0] := 1;
    TEMP := -TAU1 * (X[1] + U1[1] * X[3]);
    U2[0] := -TEMP * U1[1] - X[3];
    U2[1] := -TEMP * U1[2];
    U2[2] := SCALE;
    DLARFG(3, U2[0], U2, 1, 1, TAU2);
    U2[0] := 1;
    { Perform swap provisionally on diagonal block in D. }
    DLARFX3(True, 3, 4, U1, TAU1, D, 0, 4);
    DLARFX3(False, 4, 3, U1, TAU1, D, 0, 4);
    DLARFX3(True, 3, 4, U2, TAU2, D, 4, 4);
    DLARFX3(False, 4, 3, U2, TAU2, D, 1, 4);
    { Test whether to reject swap. }
    if Max(Max(System.Abs(D[2 * 4]), System.Abs(D[2 * 4 + 1])),
       Max(System.Abs(D[3 * 4]), System.Abs(D[3 * 4 + 1]))) > THRESH then
    begin
      INFO := 1;
      Exit;
    end;
    { Accept swap: apply transformation to the entire matrix T. }
    DLARFX3(True, 3, N - J1, U1, TAU1, T, J1 * N + J1, N);
    DLARFX3(False, J4 + 1, 3, U1, TAU1, T, J1, N);
    DLARFX3(True, 3, N - J1, U2, TAU2, T, J2 * N + J1, N);
    DLARFX3(False, J4 + 1, 3, U2, TAU2, T, J2, N);
    T[J3 * N + J1] := 0;
    T[J3 * N + J2] := 0;
    T[J4 * N + J1] := 0;
    T[J4 * N + J2] := 0;
    { Accumulate transformation in the matrix Q. }
    DLARFX3(False, N, 3, U1, TAU1, Q, J1, N);
    DLARFX3(False, N, 3, U2, TAU2, Q, J2, N);
  end;
  if N2 = 2 then
  begin
    { Standardize new 2 by 2 block T11. }
    DLANV2(T[J1 * N + J1], T[J1 * N + J2], T[J2 * N + J1], T[J2 * N + J2],
      WR1, WI1, WR2, WI2, CS, SN);
    for J := J1 + 2 to N - 1 do DROT(T[J1 * N + J], T[J2 * N + J], CS, SN);
    for I := 0 to J1 - 1 do DROT(T[I * N + J1], T[I * N + J2], CS, SN);
    for I := 0 to N - 1 do DROT(Q[I * N + J1], Q[I * N + J2], CS, SN);
  end;
  if N1 = 2 then
  begin
    { Standardize new 2 by 2 block T22. }
    J3 := J1 + N2;
    J4 := J3 + 1;
    DLANV2(T[J3 * N + J3], T[J3 * N + J4], T[J4 * N + J3], T[J4 * N + J4],
      WR1, WI1, WR2, WI2, CS, SN);
    if J3 + 2 <= N - 1 then
      for J := J3 + 2 to N - 1 do DROT(T[J3 * N + J], T[J4 * N + J], CS, SN);
    for I := 0 to J3 - 1 do DROT(T[I * N + J3], T[I * N + J4], CS, SN);
    for I := 0 to N - 1 do DROT(Q[I * N + J3], Q[I * N + J4], CS, SN);
  end;
end;

{ DTREXC with COMPQ = 'V': reorders the real Schur factorization of the
  N x N matrix T (stored by rows) so that the diagonal block starting at
  row IFST moves to row ILST, updating the Schur vectors Q. On exit IFST
  and ILST point to the first row of the moved block, which may differ by
  one from the input when a 2x2 block is involved. INFO = 1 when a swap
  was rejected (T may have been partially reordered, ILST is the current
  position of the block). }
procedure DTREXC(N: longint; var T, Q: array of TReal; var IFST, ILST: longint;
  out INFO: longint);
var
  HERE, NBF, NBL, NBNEXT: longint;
begin
  INFO := 0;
  { Quick return if possible. }
  if N <= 1 then Exit;
  { Determine the first row of specified block and find out if it is 1 by
    1 or 2 by 2. }
  if IFST > 0 then
    if T[IFST * N + IFST - 1] <> 0 then Dec(IFST);
  NBF := 1;
  if IFST < N - 1 then
    if T[(IFST + 1) * N + IFST] <> 0 then NBF := 2;
  { Determine the first row of the final block and find out if it is 1 by
    1 or 2 by 2. }
  if ILST > 0 then
    if T[ILST * N + ILST - 1] <> 0 then Dec(ILST);
  NBL := 1;
  if ILST < N - 1 then
    if T[(ILST + 1) * N + ILST] <> 0 then NBL := 2;
  if IFST = ILST then Exit;
  if IFST < ILST then
  begin
    { Update ILST. }
    if (NBF = 2) and (NBL = 1) then Dec(ILST);
    if (NBF = 1) and (NBL = 2) then Inc(ILST);
    HERE := IFST;
    repeat
      { Swap block with next one below. }
      if (NBF = 1) or (NBF = 2) then
      begin
        { Current block either 1 by 1 or 2 by 2. }
        NBNEXT := 1;
        if HERE + NBF + 1 <= N - 1 then
          if T[(HERE + NBF + 1) * N + HERE + NBF] <> 0 then NBNEXT := 2;
        DLAEXC(N, T, Q, HERE, NBF, NBNEXT, INFO);
        if INFO <> 0 then
        begin
          ILST := HERE;
          Exit;
        end;
        HERE := HERE + NBNEXT;
        { Test if 2 by 2 block breaks into two 1 by 1 blocks. }
        if NBF = 2 then
          if T[(HERE + 1) * N + HERE] = 0 then NBF := 3;
      end else
      begin
        { Current block consists of two 1 by 1 blocks each of which must be
          swapped individually. }
        NBNEXT := 1;
        if HERE + 3 <= N - 1 then
          if T[(HERE + 3) * N + HERE + 2] <> 0 then NBNEXT := 2;
        DLAEXC(N, T, Q, HERE + 1, 1, NBNEXT, INFO);
        if INFO <> 0 then
        begin
          ILST := HERE;
          Exit;
        end;
        if NBNEXT = 1 then
        begin
          { Swap two 1 by 1 blocks, no problems possible. }
          DLAEXC(N, T, Q, HERE, 1, NBNEXT, INFO);
          Inc(HERE);
        end else
        begin
          { Recompute NBNEXT in case 2 by 2 split. }
          if T[(HERE + 2) * N + HERE + 1] = 0 then NBNEXT := 1;
          if NBNEXT = 2 then
          begin
            { 2 by 2 block did not split. }
            DLAEXC(N, T, Q, HERE, 1, NBNEXT, INFO);
            if INFO <> 0 then
            begin
              ILST := HERE;
              Exit;
            end;
            Inc(HERE, 2);
          end else
          begin
            { 2 by 2 block did split. }
            DLAEXC(N, T, Q, HERE, 1, 1, INFO);
            DLAEXC(N, T, Q, HERE + 1, 1, 1, INFO);
            Inc(HERE, 2);
          end;
        end;
      end;
    until HERE >= ILST;
  end else
  begin
    HERE := IFST;
    repeat
      { Swap block with next one above. }
      if (NBF = 1) or (NBF = 2) then
      begin
        { Current block either 1 by 1 or 2 by 2. }
        NBNEXT := 1;
        if HERE >= 2 then
          if T[(HERE - 1) * N + HERE - 2] <> 0 then NBNEXT := 2;
        DLAEXC(N, T, Q, HERE - NBNEXT, NBNEXT, NBF, INFO);
        if INFO <> 0 then
        begin
          ILST := HERE;
          Exit;
        end;
        HERE := HERE - NBNEXT;
        { Test if 2 by 2 block breaks into two 1 by 1 blocks. }
        if NBF = 2 then
          if T[(HERE + 1) * N + HERE] = 0 then NBF := 3;
      end else
      begin
        { Current block consists of two 1 by 1 blocks each of which must be
          swapped individually. }
        NBNEXT := 1;
        if HERE >= 2 then
          if T[(HERE - 1) * N + HERE - 2] <> 0 then NBNEXT := 2;
        DLAEXC(N, T, Q, HERE - NBNEXT, NBNEXT, 1, INFO);
        if INFO <> 0 then
        begin
          ILST := HERE;
          Exit;
        end;
        if NBNEXT = 1 then
        begin
          { Swap two 1 by 1 blocks, no problems possible. }
          DLAEXC(N, T, Q, HERE, NBNEXT, 1, INFO);
          Dec(HERE);
        end else
        begin
          { Recompute NBNEXT in case 2 by 2 split. }
          if T[HERE * N + HERE - 1] = 0 then NBNEXT := 1;
          if NBNEXT = 2 then
          begin
            { 2 by 2 block did not split. }
            DLAEXC(N, T, Q, HERE - 1, 2, 1, INFO);
            if INFO <> 0 then
            begin
              ILST := HERE;
              Exit;
            end;
            Dec(HERE, 2);
          end else
          begin
            { 2 by 2 block did split. }
            DLAEXC(N, T, Q, HERE, 1, 1, INFO);
            DLAEXC(N, T, Q, HERE - 1, 1, 1, INFO);
            Dec(HERE, 2);
          end;
        end;
      end;
    until HERE <= ILST;
  end;
  ILST := HERE;
end;

{ ---------------------------------------------------------------------
  The functions that gfortran takes from the C library: |z| (cabs, that
  is hypot), the complex square root (csqrt) and log, translated from
  glibc 2.43 so that the results are those of the reference LAPACK on
  Linux. hypot and csqrt are compiled without FMA in glibc on x86_64;
  for log glibc selects at run time a variant compiled with FMA on
  processors that have it (x86-64-v3), and that variant is the one
  translated here, with every FMA of its machine code emulated exactly
  (the generic variant may differ from it in the last bit). Bit patterns
  are handled with range and overflow checks off.
  --------------------------------------------------------------------- }

{$PUSH}{$R-}{$Q-}

const
  { __log_data of glibc 2.43 (sysdeps/ieee754/dbl-64/e_log_data.c), as
    bit patterns: ln2hi, ln2lo, poly[0..4], poly1[0..10], then invc and
    logc of tab[0..127]. }
  GLIBCLOGDATA: array[0..273] of Int64 = (
    $3FE62E42FEFA3800, $3D2EF35793C76730, $BFE0000000000001,
    $3FD555555551305B, $BFCFFFFFFFEB4590, $3FC999B324F10111,
    $BFC55575E506C89F, $BFE0000000000000, $3FD5555555555577,
    $BFCFFFFFFFFFFDCB, $3FC999999995DD0C, $BFC55555556745A7,
    $3FC24924A344DE30, $BFBFFFFFA4423D65, $3FBC7184282AD6CA,
    $BFB999EB43B068FF, $3FB78182F7AFD085, $BFB5521375D145CD,
    $3FF734F0C3E0DE9F, $BFD7CC7F79E69000, $3FF713786A2CE91F,
    $BFD76FEEC20D0000, $3FF6F26008FAB5A0, $BFD713E31351E000,
    $3FF6D1A61F138C7D, $BFD6B85B38287800, $3FF6B1490BC5B4D1,
    $BFD65D5590807800, $3FF69147332F0CBA, $BFD602D076180000,
    $3FF6719F18224223, $BFD5A8CA86909000, $3FF6524F99A51ED9,
    $BFD54F4356035000, $3FF63356AA8F24C4, $BFD4F637C36B4000,
    $3FF614B36B9DDC14, $BFD49DA7FDA85000, $3FF5F66452C65C4C,
    $BFD445923989A800, $3FF5D867B5912C4F, $BFD3EDF439B0B800,
    $3FF5BABCCB5B90DE, $BFD396CE448F7000, $3FF59D61F2D91A78,
    $BFD3401E17BDA000, $3FF5805612465687, $BFD2E9E2EF468000,
    $3FF56397CEE76BD3, $BFD2941B3830E000, $3FF54725E2A77F93,
    $BFD23EC58CDA8800, $3FF52AFF42064583, $BFD1E9E129279000,
    $3FF50F22DBB2BDDF, $BFD1956D2B48F800, $3FF4F38F4734DED7,
    $BFD141679AB9F800, $3FF4D843CFDE2840, $BFD0EDD094EF9800,
    $3FF4BD3EC078A3C8, $BFD09AA518DB1000, $3FF4A27FC3E0258A,
    $BFD047E65263B800, $3FF4880524D48434, $BFCFEB224586F000,
    $3FF46DCE1B192D0B, $BFCF474A7517B000, $3FF453D9D3391854,
    $BFCEA4443D103000, $3FF43A2744B4845A, $BFCE020D44E9B000,
    $3FF420B54115F8FB, $BFCD60A22977F000, $3FF40782DA3EF4B1,
    $BFCCC00104959000, $3FF3EE8F5D57FE8F, $BFCC202956891000,
    $3FF3D5D9A00B4CE9, $BFCB81178D811000, $3FF3BD60C010C12B,
    $BFCAE2C9CCD3D000, $3FF3A5242B75DAB8, $BFCA45402E129000,
    $3FF38D22CD9FD002, $BFC9A877681DF000, $3FF3755BC5847A1C,
    $BFC90C6D69483000, $3FF35DCE49AD36E2, $BFC87120A645C000,
    $3FF34679984DD440, $BFC7D68FB4143000, $3FF32F5CCEFFCB24,
    $BFC73CB83C627000, $3FF3187775A10D49, $BFC6A39A9B376000,
    $3FF301C8373E3990, $BFC60B3154B7A000, $3FF2EB4EBB95F841,
    $BFC5737D76243000, $3FF2D50A0219A9D1, $BFC4DC7B8FC23000,
    $3FF2BEF9A8B7FD2A, $BFC4462C51D20000, $3FF2A91C7A0C1BAB,
    $BFC3B08ABC830000, $3FF293726014B530, $BFC31B996B490000,
    $3FF27DFA5757A1F5, $BFC2875490A44000, $3FF268B39B1D3BBF,
    $BFC1F3B9F879A000, $3FF2539D838FF5BD, $BFC160C8252CA000,
    $3FF23EB7AAC9083B, $BFC0CE7F57F72000, $3FF22A012BA940B6,
    $BFC03CDC49FEA000, $3FF2157996CC4132, $BFBF57BDBC4B8000,
    $3FF201201DD2FC9B, $BFBE370896404000, $3FF1ECF4494D480B,
    $BFBD17983EF94000, $3FF1D8F5528F6569, $BFBBF9674ED8A000,
    $3FF1C52311577E7C, $BFBADC79202F6000, $3FF1B17C74CB26E9,
    $BFB9C0C3E7288000, $3FF19E010C2C1AB6, $BFB8A646B372C000,
    $3FF18AB07BB670BD, $BFB78D01B3AC0000, $3FF1778A25EFBCB6,
    $BFB674F145380000, $3FF1648D354C31DA, $BFB55E0E6D878000,
    $3FF151B990275FDD, $BFB4485CDEA1E000, $3FF13F0EA432D24C,
    $BFB333D94D6AA000, $3FF12C8B7210F9DA, $BFB22079F8C56000,
    $3FF11A3028ECB531, $BFB10E4698622000, $3FF107FBDA8434AF,
    $BFAFFA6C6AD20000, $3FF0F5EE0F4E6BB3, $BFADDA8D4A774000,
    $3FF0E4065D2A9FCE, $BFABBCECE4850000, $3FF0D244632CA521,
    $BFA9A1894012C000, $3FF0C0A77CE2981A, $BFA788583302C000,
    $3FF0AF2F83C636D1, $BFA5715E67D68000, $3FF09DDB98A01339,
    $BFA35C8A49658000, $3FF08CABAF52E7DF, $BFA149E364154000,
    $3FF07B9F2F4E28FB, $BF9E72C082EB8000, $3FF06AB58C358F19,
    $BF9A55F152528000, $3FF059EEA5ECF92C, $BF963D62CF818000,
    $3FF04949CDD12C90, $BF9228FB8CAA0000, $3FF038C6C6F0ADA9,
    $BF8C317B20F90000, $3FF02865137932A9, $BF8419355DAA0000,
    $3FF0182427EA7348, $BF781203C2EC0000, $3FF008040614B195,
    $BF60040979240000, $3FEFE01FF726FA1A, $3F6FEFF384900000,
    $3FEFA11CC261EA74, $3F87DC41353D0000, $3FEF6310B081992E,
    $3F93CEA3C4C28000, $3FEF25F63CEEADCD, $3F9B9FC114890000,
    $3FEEE9C8039113E7, $3FA1B0D8CE110000, $3FEEAE8078CBB1AB,
    $3FA58A5BD001C000, $3FEE741AA29D0C9B, $3FA95C8340D88000,
    $3FEE3A91830A99B5, $3FAD276AEF578000, $3FEE01E009609A56,
    $3FB07598E598C000, $3FEDCA01E577BB98, $3FB253F5E30D2000,
    $3FED92F20B7C9103, $3FB42EDD8B380000, $3FED5CAC66FB5CCE,
    $3FB606598757C000, $3FED272CAA5EDE9D, $3FB7DA76356A0000,
    $3FECF26E3E6B2CCD, $3FB9AB434E1C6000, $3FECBE6DA2A77902,
    $3FBB78C7BB0D6000, $3FEC8B266D37086D, $3FBD431332E72000,
    $3FEC5894BD5D5804, $3FBF0A3171DE6000, $3FEC26B533BB9F8C,
    $3FC067152B914000, $3FEBF583EEECE73F, $3FC147858292B000,
    $3FEBC4FD75DB96C1, $3FC2266ECDCA3000, $3FEB951E0C864A28,
    $3FC303D7A6C55000, $3FEB65E2C5EF3E2C, $3FC3DFC33C331000,
    $3FEB374867C9888B, $3FC4BA366B7A8000, $3FEB094B211D304A,
    $3FC5933928D1F000, $3FEADBE885F2EF7E, $3FC66ACD2418F000,
    $3FEAAF1D31603DA2, $3FC740F8EC669000, $3FEA82E63FD358A7,
    $3FC815C0F51AF000, $3FEA5740EF09738B, $3FC8E92954F68000,
    $3FEA2C2A90AB4B27, $3FC9BB3602F84000, $3FEA01A01393F2D1,
    $3FCA8BED1C2C0000, $3FE9D79F24DB3C1B, $3FCB5B515C01D000,
    $3FE9AE2505C7B190, $3FCC2967CCBCC000, $3FE9852EF297CE2F,
    $3FCCF635D5486000, $3FE95CBAEEA44B75, $3FCDC1BD3446C000,
    $3FE934C69DE74838, $3FCE8C01B8CFE000, $3FE90D4F2F6752E6,
    $3FCF5509C0179000, $3FE8E6528EFFD79D, $3FD00E6C121FB800,
    $3FE8BFCE9FCC007C, $3FD071B80E93D000, $3FE899C0DABEC30E,
    $3FD0D46B9E867000, $3FE87427AA2317FB, $3FD13687334BD000,
    $3FE84F00ACB39A08, $3FD1980D67234800, $3FE82A49E8653E55,
    $3FD1F8FFE0CC8000, $3FE8060195F40260, $3FD2595FD7636800,
    $3FE7E22563E0A329, $3FD2B9300914A800, $3FE7BEB377DCB5AD,
    $3FD3187210436000, $3FE79BAA679725C2, $3FD377266DEC1800,
    $3FE77907F2170657, $3FD3D54FFBAF3000, $3FE756CADBD6130C,
    $3FD432EEE32FE000);

function ASUINT64(X: TReal): QWord; inline;
begin
  result := PQWord(@X)^;
end;

function ASDOUBLE(X: QWord): TReal; inline;
begin
  result := PDouble(@X)^;
end;

function GLIBCDATA(I: longint): TReal; inline;
begin
  result := PDouble(@GLIBCLOGDATA[I])^;
end;

{ copysign: |X| with the sign bit of Y (NaN included). }
function COPYSIGN(X, Y: TReal): TReal; inline;
begin
  result := ASDOUBLE((ASUINT64(X) and QWord($7FFFFFFFFFFFFFFF)) or
    (ASUINT64(Y) and QWord($8000000000000000)));
end;

{ A + B = S + E exactly (Knuth's TwoSum). }
function TWOSUM(A, B: TReal; out E: TReal): TReal; inline;
var
  BB: TReal;
begin
  result := A + B;
  BB := result - A;
  E := (A - (result - BB)) + (B - BB);
end;

{ A * B = P + E exactly (Dekker), for products far from overflow and
  underflow. }
function TWOPROD(A, B: TReal; out E: TReal): TReal; inline;
const
  SPLITTER: TReal = 134217729.0; { 2^27 + 1 }
var
  T, AH, AL, BH, BL: TReal;
begin
  T := SPLITTER * A;
  AH := T - (T - A);
  AL := A - AH;
  T := SPLITTER * B;
  BH := T - (T - B);
  BL := B - BH;
  result := A * B;
  E := ((AH * BH - result) + AH * BL + AL * BH) + AL * BL;
end;

{ A + B rounded to odd: the exact sum if representable, otherwise the
  neighbour of the two around it whose last significand bit is 1. }
function ADDODD(A, B: TReal): TReal; inline;
var
  E: TReal;
  BITS: QWord;
begin
  result := TWOSUM(A, B, E);
  BITS := ASUINT64(result);
  if (E <> 0) and (BITS and 1 = 0) then
  begin
    if (E > 0) = (result > 0) then Inc(BITS) else Dec(BITS);
    result := ASDOUBLE(BITS);
  end;
end;

{ fma(A, B, C) = A*B + C rounded once, emulated (Boldo and Melquiond,
  Emulation of FMA and correctly rounded sums: proved algorithms using
  rounding to odd, IEEE Trans. Comput. 57, 2008), for the moderate
  operands of GLIBCLOG. }
function FMA(A, B, C: TReal): TReal; inline;
var
  PH, PL, TH, TL: TReal;
begin
  PH := TWOPROD(A, B, PL);
  TH := TWOSUM(C, PH, TL);
  result := TH + ADDODD(TL, PL);
end;

{ The kernel of glibc's hypot (the variant without FMA): AX >= AY >= 0,
  squares neither overflowing nor underflowing. }
function HYPOTKERNEL(AX, AY: TReal): TReal;
var
  H, DELTA, T1, T2: TReal;
begin
  H := Sqrt(AX * AX + AY * AY);
  if H <= AY + AY then
  begin
    DELTA := H - AY;
    T1 := AX * ((DELTA + DELTA) - AX);
    T2 := (DELTA - ((AX - AY) + (AX - AY))) * DELTA;
  end else
  begin
    DELTA := H - AX;
    T1 := (DELTA + DELTA) * (AX - (AY + AY));
    T2 := (4 * DELTA - AY) * AY + DELTA * DELTA;
  end;
  result := H - (T1 + T2) / (H + H);
end;

{ hypot(X, Y) of glibc 2.43 (sysdeps/ieee754/dbl-64/e_hypot.c). }
function GLIBCHYPOT(X, Y: TReal): TReal;
const
  SCALE: TReal = 2.4099198651028841E-181;      { 2^-600 }
  LARGEVAL: TReal = 6.7039039649712985E+153;  { 2^511 }
  TINYVAL: TReal = 3.3409504593115239E-139;   { 2^-459 }
  EPS: TReal = 5.5511151231257827E-17;        { 2^-54 }
var
  AX, AY: TReal;
begin
  if IsNan(X) or IsNan(Y) or IsInfinite(X) or IsInfinite(Y) then
  begin
    if IsInfinite(X) or IsInfinite(Y) then
      result := Infinity
    else
      result := X + Y;
    Exit;
  end;
  X := System.Abs(X);
  Y := System.Abs(Y);
  if X < Y then
  begin
    AX := Y;
    AY := X;
  end else
  begin
    AX := X;
    AY := Y;
  end;
  { If AX is huge, scale both inputs down. }
  if AX > LARGEVAL then
  begin
    if AY <= AX * EPS then Exit(AX + AY);
    Exit(HYPOTKERNEL(AX * SCALE, AY * SCALE) / SCALE);
  end;
  { If AY is tiny, scale both inputs up. }
  if AY < TINYVAL then
  begin
    if AX >= AY / EPS then Exit(AX + AY);
    Exit(HYPOTKERNEL(AX / SCALE, AY / SCALE) * SCALE);
  end;
  { Common case: AX is not huge and AY is not tiny. }
  if AY <= AX * EPS then Exit(AX + AY);
  result := HYPOTKERNEL(AX, AY);
end;

{ csqrt(Z) of glibc 2.43 (math/s_csqrt_template.c); scalbn by powers of
  two is a multiplication by them (both round once). }
function GLIBCCSQRT(const Z: TComplex): TComplex;
const
  HALF: TReal = 0.5;
  DBLMIN: TReal = 2.2250738585072014E-308;     { 2^-1022 }
  DBLMAXQ: TReal = 4.4942328371557898E+307;    { DBL_MAX/4 }
  QUARTER: TReal = 0.25;
  TWO: TReal = 2;
  UP54: TReal = 18014398509481984.0;           { 2^54 }
  DOWN27: TReal = 7.4505805969238281E-09;      { 2^-27 }
var
  XR, XI, D, R, S, CNAN: TReal;
  SCALE: longint;
begin
  { The NaN of glibc (__builtin_nan), with the sign bit clear. }
  CNAN := ASDOUBLE(QWord($7FF8000000000000));
  XR := Z.Re;
  XI := Z.Im;
  if IsNan(XR) or IsNan(XI) or IsInfinite(XR) or IsInfinite(XI) then
  begin
    if IsInfinite(XI) then
    begin
      result.Re := Infinity;
      result.Im := XI;
    end else if IsInfinite(XR) then
    begin
      if XR < 0 then
      begin
        if IsNan(XI) then result.Re := CNAN else result.Re := 0;
        result.Im := COPYSIGN(Infinity, XI);
      end else
      begin
        result.Re := XR;
        if IsNan(XI) then result.Im := CNAN else result.Im := COPYSIGN(0, XI);
      end;
    end else
    begin
      result.Re := CNAN;
      result.Im := CNAN;
    end;
    Exit;
  end;
  if XI = 0 then
  begin
    if XR < 0 then
    begin
      result.Re := 0;
      result.Im := COPYSIGN(Sqrt(-XR), XI);
    end else
    begin
      result.Re := System.Abs(Sqrt(XR));
      result.Im := COPYSIGN(0, XI);
    end;
  end else if XR = 0 then
  begin
    if System.Abs(XI) >= TWO * DBLMIN then
      R := Sqrt(HALF * System.Abs(XI))
    else
      R := HALF * Sqrt(TWO * System.Abs(XI));
    result.Re := R;
    result.Im := COPYSIGN(R, XI);
  end else
  begin
    SCALE := 0;
    if System.Abs(XR) > DBLMAXQ then
    begin
      SCALE := 1;
      XR := XR * QUARTER;
      XI := XI * QUARTER;
    end else if System.Abs(XI) > DBLMAXQ then
    begin
      SCALE := 1;
      if System.Abs(XR) >= 4 * DBLMIN then
        XR := XR * QUARTER
      else
        XR := 0;
      XI := XI * QUARTER;
    end else if (System.Abs(XR) < TWO * DBLMIN) and
      (System.Abs(XI) < TWO * DBLMIN) then
    begin
      SCALE := -27;
      XR := XR * UP54;
      XI := XI * UP54;
    end;
    D := GLIBCHYPOT(XR, XI);
    { Use the identity 2 Re res Im res = Im x to avoid cancellation error
      in d +/- Re x. }
    if XR > 0 then
    begin
      R := Sqrt(HALF * (D + XR));
      if (SCALE = 1) and (System.Abs(XI) < 1) then
      begin
        { Avoid possible intermediate underflow. }
        S := XI / R;
        R := R * TWO;
        SCALE := 0;
      end else
        S := HALF * (XI / R);
    end else
    begin
      S := Sqrt(HALF * (D - XR));
      if (SCALE = 1) and (System.Abs(XI) < 1) then
      begin
        { Avoid possible intermediate underflow. }
        R := System.Abs(XI / S);
        S := S * TWO;
        SCALE := 0;
      end else
        R := System.Abs(HALF * (XI / S));
    end;
    if SCALE = 1 then
    begin
      R := R * TWO;
      S := S * TWO;
    end else if SCALE = -27 then
    begin
      R := R * DOWN27;
      S := S * DOWN27;
    end;
    result.Re := R;
    result.Im := COPYSIGN(S, XI);
  end;
end;

{ log(X) of glibc 2.43 (sysdeps/ieee754/dbl-64/e_log.c), the variant
  compiled with FMA: the order of the operations and the FMAs are those
  of its machine code. }
function GLIBCLOG(X: TReal): TReal;
const
  ONE: TReal = 1;
  TWO27: TReal = 134217728.0;                  { 2^27 }
  TWO52: TReal = 4503599627370496.0;           { 2^52 }
  LO = QWord($3FEE000000000000);               { asuint64(1 - 2^-4) }
  HI = QWord($3FF1090000000000);               { asuint64(1 + 0x1.09p-4) }
  OFF = QWord($3FE6000000000000);
var
  IX, IZ, TMP: QWord;
  TOP: longword;
  K, I: longint;
  R, R2, R3, P1, P2, P3, Q, W, RHI, RLO, HI_, LO_, T, Z, INVC, LOGC, KD,
    T1, T2: TReal;
begin
  IX := ASUINT64(X);
  TOP := IX shr 48;
  if IX - LO < HI - LO then
  begin
    { Handle close to 1.0 inputs separately. }
    if IX = ASUINT64(ONE) then Exit(0);
    R := X - ONE;
    P1 := FMA(R, GLIBCDATA(9), GLIBCDATA(8));
    P2 := FMA(R, GLIBCDATA(12), GLIBCDATA(11));
    P3 := FMA(R, GLIBCDATA(15), GLIBCDATA(14));
    R2 := R * R;
    P1 := FMA(R2, GLIBCDATA(10), P1);
    P2 := FMA(R2, GLIBCDATA(13), P2);
    R3 := R * R2;
    Q := FMA(R2, GLIBCDATA(16), P3);
    Q := FMA(R3, GLIBCDATA(17), Q);
    Q := FMA(Q, R3, P2);
    Q := FMA(Q, R3, P1);
    { Worst-case error is around 0.507 ULP. }
    W := R * TWO27;
    RHI := (R + W) - W;
    RLO := R - RHI;
    { B[0] = -0.5. }
    T := RHI * RHI;
    HI_ := FMA(T, GLIBCDATA(7), R);
    LO_ := FMA(T, GLIBCDATA(7), R - HI_);
    LO_ := FMA(GLIBCDATA(7) * RLO, RHI + R, LO_);
    result := HI_ + FMA(Q, R3, LO_);
    Exit;
  end;
  if longword(TOP - $0010) >= $7FF0 - $0010 then
  begin
    { x < 0x1p-1022 or inf or nan. }
    if IX * 2 = 0 then Exit(-Infinity);
    if IX = ASUINT64(Infinity) then Exit(X);
    { __math_invalid: (x - x) / (x - x), a quiet x for a NaN x, the
      default NaN of x86 (sign bit set) otherwise. }
    if (TOP and $8000 <> 0) or (TOP and $7FF0 = $7FF0) then
    begin
      if IsNan(X) then
        Exit(ASDOUBLE(IX or QWord($0008000000000000)));
      Exit(ASDOUBLE(QWord($FFF8000000000000)));
    end;
    { x is subnormal, normalize it. }
    IX := ASUINT64(X * TWO52);
    IX := IX - (QWord(52) shl 52);
  end;
  { x = 2^k z; where z is in range [OFF, 2*OFF) and exact. The range is
    split into N subintervals. The ith subinterval contains z and c is
    near its center. }
  TMP := IX - OFF;
  I := (TMP shr 45) and 127;
  K := SarInt64(int64(TMP), 52);
  IZ := IX - (TMP and (QWord($FFF) shl 52));
  INVC := GLIBCDATA(18 + 2 * I);
  LOGC := GLIBCDATA(19 + 2 * I);
  Z := ASDOUBLE(IZ);
  KD := K;
  { log(x) = log1p(z/c-1) + log(c) + k*Ln2; r ~= z/c - 1,
    |r| < 1/(2*N). hi + lo = r + log(c) + k*Ln2. }
  W := FMA(KD, GLIBCDATA(0), LOGC);
  R := FMA(Z, INVC, -ONE);
  T1 := FMA(R, GLIBCDATA(4), GLIBCDATA(3));
  HI_ := R + W;
  R2 := R * R;
  LO_ := FMA(KD, GLIBCDATA(1), (W - HI_) + R);
  R3 := R * R2;
  T2 := FMA(R, GLIBCDATA(6), GLIBCDATA(5));
  LO_ := FMA(R2, GLIBCDATA(2), LO_);
  T2 := FMA(T2, R2, T1);
  { log(x) = lo + (log1p(r) - r) + hi. }
  result := FMA(R3, T2, LO_) + HI_;
end;

{$POP}

{ |z| and the principal square root of z: the Fortran intrinsics ABS and
  SQRT on complex numbers. }
function ZABS(const Z: TComplex): TReal; inline;
begin
  result := GLIBCHYPOT(Z.Re, Z.Im);
end;

function ZSQRT(const Z: TComplex): TComplex;
begin
  result := GLIBCCSQRT(Z);
end;

procedure ZLAHQR(WANTT, WANTZ: boolean; N, ILO, IHI: longint;
  var H: array of TComplex; HO, LDH: longint; var W: array of TComplex;
  WO, ILOZ, IHIZ: longint; var Z: array of TComplex; ZO, LDZ: longint;
  out INFO: longint);
const
  DAT1: TReal = 0.75;
  KEXSH = 10;
var
  I, I1, I2, ITS, ITMAX, J, JHI, JLO, K, L, M, NH, KDEFL, R: longint;
  AA, AB, BA, BB, H10, H21, RTEMP, S, SMLNUM, SX, T2, TST, ULP: TReal;
  H11, H11S, H22, SC, T, T1, T1C, TEMP, U, V2, V2C, X, Y, HA, HB,
    LOne: TComplex;
  SR, SI: TReal;
  V: array[0..1] of TComplex;
  CONVERGED, FOUND: boolean;
begin
  INFO := 0;
  LOne := 1;
  if N = 0 then Exit;
  if ILO = IHI then
  begin
    W[WO + ILO] := H[HO + ILO * LDH + ILO];
    Exit;
  end;
  { Clear out the trash. }
  for J := ILO to IHI - 3 do
  begin
    H[HO + (J + 2) * LDH + J] := 0;
    H[HO + (J + 3) * LDH + J] := 0;
  end;
  if ILO <= IHI - 2 then H[HO + IHI * LDH + IHI - 2] := 0;
  { Ensure that subdiagonal entries are real. }
  if WANTT then
  begin
    JLO := 0;
    JHI := N - 1;
  end else
  begin
    JLO := ILO;
    JHI := IHI;
  end;
  for I := ILO + 1 to IHI do
    if H[HO + I * LDH + I - 1].Im <> 0 then
    begin
      { The following redundant normalization avoids problems with both
        gradual and sudden underflow in ABS(H(I, I-1)). }
      SC := FDIV(H[HO + I * LDH + I - 1], CABS1(H[HO + I * LDH + I - 1]));
      SC := FDIV(CONJ(SC), ZABS(SC));
      H[HO + I * LDH + I - 1] := ZABS(H[HO + I * LDH + I - 1]);
      if not ISONE(SC) then
      begin
        for J := I to JHI do H[HO + I * LDH + J] := SC * H[HO + I * LDH + J];
        for J := JLO to Min(JHI, I + 1) do
          H[HO + J * LDH + I] := CONJ(SC) * H[HO + J * LDH + I];
      end;
      if WANTZ and not ISONE(SC) then
        for J := ILOZ to IHIZ do
          Z[ZO + J * LDZ + I] := CONJ(SC) * Z[ZO + J * LDZ + I];
    end;
  NH := IHI - ILO + 1;
  { Set machine-dependent constants for the stopping criterion. }
  ULP := LapackPrecision;
  SMLNUM := LapackSafeMinimum * (NH / ULP);
  { I1 and I2 are the indices of the first row and last column of H to
    which transformations must be applied. If eigenvalues only are being
    computed, I1 and I2 are set inside the main loop. }
  I1 := 0;
  I2 := 0;
  if WANTT then
  begin
    I1 := 0;
    I2 := N - 1;
  end;
  { ITMAX is the total number of QR iterations allowed. }
  ITMAX := 30 * Max(10, NH);
  { KDEFL counts the number of iterations since a deflation. }
  KDEFL := 0;
  { The main loop begins here. I is the loop index and decreases from IHI
    to ILO in steps of 1. Each iteration of the loop works with the active
    submatrix in rows and columns L to I. Eigenvalues I+1 to IHI have
    already converged. Either L = ILO, or H(L, L-1) is negligible so that
    the matrix splits. }
  I := IHI;
  while I >= ILO do
  begin
    { Perform QR iterations on rows and columns ILO to I until a
      submatrix of order 1 splits off at the bottom because a subdiagonal
      element has become negligible. }
    L := ILO;
    CONVERGED := False;
    for ITS := 0 to ITMAX do
    begin
      { Look for a single small subdiagonal element. }
      K := I;
      while K > L do
      begin
        if CABS1(H[HO + K * LDH + K - 1]) <= SMLNUM then Break;
        TST := CABS1(H[HO + (K - 1) * LDH + K - 1]) + CABS1(H[HO + K * LDH + K]);
        if TST = 0 then
        begin
          if K - 2 >= ILO then
            TST := TST + System.Abs(H[HO + (K - 1) * LDH + K - 2].Re);
          if K + 1 <= IHI then
            TST := TST + System.Abs(H[HO + (K + 1) * LDH + K].Re);
        end;
        { The following is a conservative small subdiagonal deflation
          criterion due to Ahues and Kressner (2004). }
        if System.Abs(H[HO + K * LDH + K - 1].Re) <= ULP * TST then
        begin
          AB := Max(CABS1(H[HO + K * LDH + K - 1]), CABS1(H[HO + (K - 1) * LDH + K]));
          BA := Min(CABS1(H[HO + K * LDH + K - 1]), CABS1(H[HO + (K - 1) * LDH + K]));
          AA := Max(CABS1(H[HO + K * LDH + K]),
            CABS1(H[HO + (K - 1) * LDH + K - 1] - H[HO + K * LDH + K]));
          BB := Min(CABS1(H[HO + K * LDH + K]),
            CABS1(H[HO + (K - 1) * LDH + K - 1] - H[HO + K * LDH + K]));
          S := AA + AB;
          if BA * (AB / S) <= Max(SMLNUM, ULP * (BB * (AA / S))) then Break;
        end;
        Dec(K);
      end;
      L := K;
      { H(L, L-1) is negligible. }
      if L > ILO then H[HO + L * LDH + L - 1] := 0;
      { Exit from loop if a submatrix of order 1 has split off. }
      if L >= I then
      begin
        CONVERGED := True;
        Break;
      end;
      Inc(KDEFL);
      { Now the active submatrix is in rows and columns L to I. If
        eigenvalues only are being computed, only the active submatrix
        need be transformed. }
      if not WANTT then
      begin
        I1 := L;
        I2 := I;
      end;
      if KDEFL mod (2 * KEXSH) = 0 then
      begin
        { Exceptional shift. }
        S := DAT1 * System.Abs(H[HO + I * LDH + I - 1].Re);
        T := FADD(H[HO + I * LDH + I], S);
      end else if KDEFL mod KEXSH = 0 then
      begin
        { Exceptional shift. }
        S := DAT1 * System.Abs(H[HO + (L + 1) * LDH + L].Re);
        T := FADD(H[HO + L * LDH + L], S);
      end else
      begin
        { Wilkinson's shift. }
        T := H[HO + I * LDH + I];
        U := ZSQRT(H[HO + (I - 1) * LDH + I]) * ZSQRT(H[HO + I * LDH + I - 1]);
        S := CABS1(U);
        if S <> 0 then
        begin
          X := FMUL(0.5, H[HO + (I - 1) * LDH + I - 1] - T);
          SX := CABS1(X);
          S := Max(S, CABS1(X));
          Y := FMUL(S, ZSQRT(FDIV(X, S) * FDIV(X, S) + FDIV(U, S) * FDIV(U, S)));
          if SX > 0 then
            if FDIV(X, SX).Re * Y.Re + FDIV(X, SX).Im * Y.Im < 0 then Y := -Y;
          T := T - U * ZLADIV(U, X + Y);
        end;
      end;
      { Look for two consecutive small subdiagonal elements. }
      FOUND := False;
      for M := I - 1 downto L + 1 do
      begin
        { Determine the effect of starting the single-shift QR iteration
          at row M, and see if this would make H(M, M-1) negligible. }
        H11 := H[HO + M * LDH + M];
        H22 := H[HO + (M + 1) * LDH + M + 1];
        H11S := H11 - T;
        H21 := H[HO + (M + 1) * LDH + M].Re;
        S := CABS1(H11S) + System.Abs(H21);
        H11S := FDIV(H11S, S);
        H21 := H21 / S;
        V[0] := H11S;
        V[1] := H21;
        H10 := H[HO + M * LDH + M - 1].Re;
        if System.Abs(H10) * System.Abs(H21) <=
           ULP * (CABS1(H11S) * (CABS1(H11) + CABS1(H22))) then
        begin
          FOUND := True;
          Break;
        end;
      end;
      if not FOUND then
      begin
        M := L;
        H11 := H[HO + L * LDH + L];
        H22 := H[HO + (L + 1) * LDH + L + 1];
        H11S := H11 - T;
        H21 := H[HO + (L + 1) * LDH + L].Re;
        S := CABS1(H11S) + System.Abs(H21);
        H11S := FDIV(H11S, S);
        H21 := H21 / S;
        V[0] := H11S;
        V[1] := H21;
      end;
      { Single-shift QR step. }
      for K := M to I - 1 do
      begin
        { The first iteration of this loop determines a reflection G from
          the vector V and applies it from left and right to H, thus
          creating a nonzero bulge below the subdiagonal. Each subsequent
          iteration determines a reflection G to restore the Hessenberg
          form in the (K-1)th column, and thus chases the bulge one step
          toward the bottom of the active submatrix. V(2) is always real
          before the call to ZLARFG, and hence after the call T2 (=
          T1*V(2)) is also real. }
        if K > M then
        begin
          V[0] := H[HO + K * LDH + K - 1];
          V[1] := H[HO + (K + 1) * LDH + K - 1];
        end;
        ZLARFG(2, V[0], V, 1, 1, T1);
        if K > M then
        begin
          H[HO + K * LDH + K - 1] := V[0];
          H[HO + (K + 1) * LDH + K - 1] := 0;
        end;
        V2 := V[1];
        T2 := (T1 * V2).Re;
        T1C := CONJ(T1);
        V2C := CONJ(V2);
        { The three updates below are written on the real and imaginary
          parts: the same operations as the operators of TComplex, which
          Free Pascal 3.2 compiles about 2.5 times slower here. }
        { Apply G from the left to transform the rows of the matrix in
          columns K to I2. }
        for J := K to I2 do
        begin
          HA := H[HO + K * LDH + J];
          HB := H[HO + (K + 1) * LDH + J];
          SR := (T1C.Re * HA.Re - T1C.Im * HA.Im) + (T2 * HB.Re - FZERO * HB.Im);
          SI := (T1C.Re * HA.Im + T1C.Im * HA.Re) + (T2 * HB.Im + FZERO * HB.Re);
          HA.Re := HA.Re - SR;
          HA.Im := HA.Im - SI;
          HB.Re := HB.Re - (SR * V2.Re - SI * V2.Im);
          HB.Im := HB.Im - (SR * V2.Im + SI * V2.Re);
          H[HO + K * LDH + J] := HA;
          H[HO + (K + 1) * LDH + J] := HB;
        end;
        { Apply G from the right to transform the columns of the matrix in
          rows I1 to min(K+2, I). }
        for J := I1 to Min(K + 2, I) do
        begin
          HA := H[HO + J * LDH + K];
          HB := H[HO + J * LDH + K + 1];
          SR := (T1.Re * HA.Re - T1.Im * HA.Im) + (T2 * HB.Re - FZERO * HB.Im);
          SI := (T1.Re * HA.Im + T1.Im * HA.Re) + (T2 * HB.Im + FZERO * HB.Re);
          HA.Re := HA.Re - SR;
          HA.Im := HA.Im - SI;
          HB.Re := HB.Re - (SR * V2C.Re - SI * V2C.Im);
          HB.Im := HB.Im - (SR * V2C.Im + SI * V2C.Re);
          H[HO + J * LDH + K] := HA;
          H[HO + J * LDH + K + 1] := HB;
        end;
        if WANTZ then
          { Accumulate transformations in the matrix Z. }
          for J := ILOZ to IHIZ do
          begin
            HA := Z[ZO + J * LDZ + K];
            HB := Z[ZO + J * LDZ + K + 1];
            SR := (T1.Re * HA.Re - T1.Im * HA.Im) + (T2 * HB.Re - FZERO * HB.Im);
            SI := (T1.Re * HA.Im + T1.Im * HA.Re) + (T2 * HB.Im + FZERO * HB.Re);
            HA.Re := HA.Re - SR;
            HA.Im := HA.Im - SI;
            HB.Re := HB.Re - (SR * V2C.Re - SI * V2C.Im);
            HB.Im := HB.Im - (SR * V2C.Im + SI * V2C.Re);
            Z[ZO + J * LDZ + K] := HA;
            Z[ZO + J * LDZ + K + 1] := HB;
          end;
        if (K = M) and (M > L) then
        begin
          { If the QR step was started at row M > L because two
            consecutive small subdiagonals in rows M-1:M+1 have been found,
            then extra scaling must be performed to ensure that H(M, M-1)
            remains real. }
          TEMP := LOne - T1;
          TEMP := FDIV(TEMP, ZABS(TEMP));
          H[HO + (M + 1) * LDH + M] := H[HO + (M + 1) * LDH + M] * CONJ(TEMP);
          if M + 2 <= I then
            H[HO + (M + 2) * LDH + M + 1] := H[HO + (M + 2) * LDH + M + 1] * TEMP;
          for J := M to I do
            if (J <> M + 1) and not ISONE(TEMP) then
            begin
              for R := J + 1 to I2 do
                H[HO + J * LDH + R] := TEMP * H[HO + J * LDH + R];
              for R := I1 to J - 1 do
                H[HO + R * LDH + J] := CONJ(TEMP) * H[HO + R * LDH + J];
              if WANTZ then
                for R := ILOZ to IHIZ do
                  Z[ZO + R * LDZ + J] := CONJ(TEMP) * Z[ZO + R * LDZ + J];
            end;
        end;
      end;
      { Ensure that H(I, I-1) is real. }
      TEMP := H[HO + I * LDH + I - 1];
      if TEMP.Im <> 0 then
      begin
        RTEMP := ZABS(TEMP);
        H[HO + I * LDH + I - 1] := RTEMP;
        TEMP := FDIV(TEMP, RTEMP);
        if not ISONE(TEMP) then
          for R := I + 1 to I2 do
            H[HO + I * LDH + R] := CONJ(TEMP) * H[HO + I * LDH + R];
        if not ISONE(TEMP) then
          for R := I1 to I - 1 do
            H[HO + R * LDH + I] := TEMP * H[HO + R * LDH + I];
        if WANTZ and not ISONE(TEMP) then
          for R := ILOZ to IHIZ do
            Z[ZO + R * LDZ + I] := TEMP * Z[ZO + R * LDZ + I];
      end;
    end;
    { Failure to converge in remaining number of iterations. }
    if not CONVERGED then
    begin
      INFO := I + 1;
      Exit;
    end;
    { H(I, I-1) is negligible: one eigenvalue has converged. }
    W[WO + I] := H[HO + I * LDH + I];
    { Reset deflation counter. }
    KDEFL := 0;
    { Return to start of the main loop with new value of I. }
    I := L - 1;
  end;
end;

{ ZLAQR1: a multiple of the first column of (H - S1*I)*(H - S2*I) for
  the 2x2 or 3x3 matrix H at H[HO] with row stride LDH. }
procedure ZLAQR1(N: longint; const H: array of TComplex; HO, LDH: longint;
  const S1, S2: TComplex; var V: array of TComplex; VO: longint);
var
  S: TReal;
  H21S, H31S, H11, H12, H13, H21, H22, H23, H31, H32, H33: TComplex;
begin
  if (N <> 2) and (N <> 3) then Exit;
  H11 := H[HO];
  H12 := H[HO + 1];
  H21 := H[HO + LDH];
  H22 := H[HO + LDH + 1];
  if N = 2 then
  begin
    S := CABS1(H11 - S2) + CABS1(H21);
    if S = 0 then
    begin
      V[VO] := 0;
      V[VO + 1] := 0;
    end else
    begin
      H21S := FDIV(H21, S);
      V[VO] := H21S * H12 + (H11 - S1) * FDIV(H11 - S2, S);
      V[VO + 1] := H21S * (H11 + H22 - S1 - S2);
    end;
  end else
  begin
    H13 := H[HO + 2];
    H23 := H[HO + LDH + 2];
    H31 := H[HO + 2 * LDH];
    H32 := H[HO + 2 * LDH + 1];
    H33 := H[HO + 2 * LDH + 2];
    S := CABS1(H11 - S2) + CABS1(H21) + CABS1(H31);
    if S = 0 then
    begin
      V[VO] := 0;
      V[VO + 1] := 0;
      V[VO + 2] := 0;
    end else
    begin
      H21S := FDIV(H21, S);
      H31S := FDIV(H31, S);
      V[VO] := (H11 - S1) * FDIV(H11 - S2, S) + H12 * H21S + H13 * H31S;
      V[VO + 1] := H21S * (H11 + H22 - S1 - S2) + H23 * H31S;
      V[VO + 2] := H31S * (H11 + H33 - S1 - S2) + H21S * H32;
    end;
  end;
end;

{ ZLARTG (LAPACK 3.10, f90): plane rotation with real cosine C and
  complex sine S such that [C S; -conj(S) C] * (F, G) = (R, 0). }
procedure ZLARTG(const F, G: TComplex; out C: TReal; out S, R: TComplex);
const
  SAFMIN: TReal = 2.2250738585072014E-308; { 2^-1022 }
  SAFMAX: TReal = 4.49423283715579E+307;   { 2^1022 }
var
  D, F1, F2, G1, G2, H2, U, V, W, RTMIN, RTMAX: TReal;
  FS, GS: TComplex;

  function ABSSQ(const T: TComplex): TReal; inline;
  begin
    result := Sqr(T.Re) + Sqr(T.Im);
  end;

begin
  RTMIN := Sqrt(SAFMIN);
  if (G.Re = 0) and (G.Im = 0) then
  begin
    C := 1;
    S := 0;
    R := F;
  end else if (F.Re = 0) and (F.Im = 0) then
  begin
    C := 0;
    if G.Re = 0 then
    begin
      R := System.Abs(G.Im);
      S := FDIV(CONJ(G), R);
    end else if G.Im = 0 then
    begin
      R := System.Abs(G.Re);
      S := FDIV(CONJ(G), R);
    end else
    begin
      G1 := Max(System.Abs(G.Re), System.Abs(G.Im));
      RTMAX := Sqrt(SAFMAX / 2);
      if (G1 > RTMIN) and (G1 < RTMAX) then
      begin
        { Use unscaled algorithm. }
        G2 := ABSSQ(G);
        D := Sqrt(G2);
        S := FDIV(CONJ(G), D);
        R := D;
      end else
      begin
        { Use scaled algorithm. }
        U := Min(SAFMAX, Max(SAFMIN, G1));
        GS := FDIV(G, U);
        G2 := ABSSQ(GS);
        D := Sqrt(G2);
        S := FDIV(CONJ(GS), D);
        R := D * U;
      end;
    end;
  end else
  begin
    F1 := Max(System.Abs(F.Re), System.Abs(F.Im));
    G1 := Max(System.Abs(G.Re), System.Abs(G.Im));
    RTMAX := Sqrt(SAFMAX / 4);
    if (F1 > RTMIN) and (F1 < RTMAX) and (G1 > RTMIN) and (G1 < RTMAX) then
    begin
      { Use unscaled algorithm. }
      F2 := ABSSQ(F);
      G2 := ABSSQ(G);
      H2 := F2 + G2;
      { safmin <= f2 <= h2 <= safmax }
      if F2 >= H2 * SAFMIN then
      begin
        { safmin <= f2/h2 <= 1, and h2/f2 is finite. }
        C := Sqrt(F2 / H2);
        R := FDIV(F, C);
        RTMAX := RTMAX * 2;
        if (F2 > RTMIN) and (H2 < RTMAX) then
          { safmin <= sqrt( f2*h2 ) <= safmax }
          S := CONJ(G) * FDIV(F, Sqrt(F2 * H2))
        else
          S := CONJ(G) * FDIV(R, H2);
      end else
      begin
        { f2/h2 <= safmin may be subnormal, and h2/f2 may overflow. Moreover,
          safmin <= f2*f2 * safmax < f2 * h2 < h2*h2 * safmin <= safmax,
          sqrt(safmin) <= sqrt(f2 * h2) <= sqrt(safmax). Also,
          g2 >> f2, which means that h2 = g2. }
        D := Sqrt(F2 * H2);
        C := F2 / D;
        if C >= SAFMIN then
          R := FDIV(F, C)
        else
          { f2 / sqrt(f2 * h2) < safmin, then sqrt(safmin) <= f2 * sqrt(safmax)
            <= h2 / sqrt(f2 * h2) <= h2 * (safmin / f2) <= h2 <= safmax }
          R := FMUL(H2 / D, F);
        S := CONJ(G) * FDIV(F, D);
      end;
    end else
    begin
      { Use scaled algorithm. }
      U := Min(SAFMAX, Max(SAFMIN, Max(F1, G1)));
      GS := FDIV(G, U);
      G2 := ABSSQ(GS);
      if F1 / U < RTMIN then
      begin
        { f is not well-scaled when scaled by g1. Use a different scaling
          for f. }
        V := Min(SAFMAX, Max(SAFMIN, F1));
        W := V / U;
        FS := FDIV(F, V);
        F2 := ABSSQ(FS);
        H2 := F2 * Sqr(W) + G2;
      end else
      begin
        { Otherwise use the same scaling for f and g. }
        W := 1;
        FS := FDIV(F, U);
        F2 := ABSSQ(FS);
        H2 := F2 + G2;
      end;
      { safmin <= f2 <= h2 <= safmax }
      if F2 >= H2 * SAFMIN then
      begin
        { safmin <= f2/h2 <= 1, and h2/f2 is finite. }
        C := Sqrt(F2 / H2);
        R := FDIV(FS, C);
        RTMAX := RTMAX * 2;
        if (F2 > RTMIN) and (H2 < RTMAX) then
          { safmin <= sqrt( f2*h2 ) <= safmax }
          S := CONJ(GS) * FDIV(FS, Sqrt(F2 * H2))
        else
          S := CONJ(GS) * FDIV(R, H2);
      end else
      begin
        { f2/h2 <= safmin may be subnormal, and h2/f2 may overflow. }
        D := Sqrt(F2 * H2);
        C := F2 / D;
        if C >= SAFMIN then
          R := FDIV(FS, C)
        else
          R := FMUL(H2 / D, FS);
        S := CONJ(GS) * FDIV(FS, D);
      end;
      { Rescale c and r. }
      C := C * W;
      R := FMUL(U, R);
    end;
  end;
end;

{ Plane rotation of the pair (AX, AY) with real cosine and complex sine,
  as ZROT. }
procedure ZROT(var AX, AY: TComplex; C: TReal; const S: TComplex); inline;
var
  LTemp: TComplex;
begin
  LTemp := FMUL(C, AX) + S * AY;
  AY := FMUL(C, AY) - CONJ(S) * AX;
  AX := LTemp;
end;

{ ZTREXC with COMPQ = 'V': reorders the Schur factorization of the
  N x N upper triangular T (stored by rows) so that the diagonal entry at
  row IFST moves to row ILST, updating the Schur vectors Q. }
procedure ZTREXC(N: longint; var T, Q: array of TComplex; IFST,
  ILST: longint);
var
  K, M1, M2, M3, J: longint;
  CS: TReal;
  SN, TEMP, T11, T22: TComplex;
begin
  { Quick return if possible. }
  if (N <= 1) or (IFST = ILST) then Exit;
  if IFST < ILST then
  begin
    { Move the IFST-th diagonal element forward down the diagonal. }
    M1 := 0;
    M2 := -1;
    M3 := 1;
  end else
  begin
    { Move the IFST-th diagonal element backward up the diagonal. }
    M1 := -1;
    M2 := 0;
    M3 := -1;
  end;
  K := IFST + M1;
  while ((M3 > 0) and (K <= ILST + M2)) or ((M3 < 0) and (K >= ILST + M2)) do
  begin
    { Interchange the k-th and (k+1)-th diagonal elements. }
    T11 := T[K * N + K];
    T22 := T[(K + 1) * N + K + 1];
    { Determine the transformation to perform the interchange. }
    ZLARTG(T[K * N + K + 1], T22 - T11, CS, SN, TEMP);
    { Apply transformation to the matrix T. }
    if K + 2 <= N - 1 then
      for J := K + 2 to N - 1 do ZROT(T[K * N + J], T[(K + 1) * N + J], CS, SN);
    for J := 0 to K - 1 do
      ZROT(T[J * N + K], T[J * N + K + 1], CS, CONJ(SN));
    T[K * N + K] := T22;
    T[(K + 1) * N + K + 1] := T11;
    for J := 0 to N - 1 do
      ZROT(Q[J * N + K], Q[J * N + K + 1], CS, CONJ(SN));
    Inc(K, M3);
  end;
end;

{ xORM2R / xUNM2R with SIDE = 'R', TRANS = 'N': C := C*Q for the M x N
  matrix C at C[CO] (row stride LDC), Q = H(0)*H(1)*...*H(K-1) from the
  reflectors in the first K columns of A at A[AO] (row stride LDA) and
  TAU[0..K-1]. xORMQR calls it when the number of reflectors K does not
  exceed its block size 32; for larger K it uses the blocked xLARFB, which
  gives the same result up to rounding. }
generic procedure ORM2R<T>(M, N, K: longint; const A: array of T;
  AO, LDA: longint; const TAU: array of T; var C: array of T;
  CO, LDC: longint);
var
  I: longint;
  WORK: array of T;
begin
  if (M = 0) or (N = 0) or (K = 0) then Exit;
  WORK := nil;
  SetLength(WORK, 2 * Max(M, N));
  for I := 0 to K - 1 do
    { H(i) is applied to C(0:m-1, i:n-1). }
    specialize LARF1F<T>(False, M, N - I, A, AO + I * LDA + I, LDA, TAU[I],
      C, CO + I, LDC, WORK);
end;

{ The blocked xORMQR (SIDE = 'R', TRANS = 'N') of xLAQR3, defined with
  the general eigenproblem drivers. }
procedure ORMQRD(M, N, K: longint; const A: array of TReal; AO, LDA: longint;
  const TAU: array of TReal; var C: array of TReal; CO, LDC, LWORK: longint);
  forward;
procedure ORMQRZ(M, N, K: longint; const A: array of TComplex;
  AO, LDA: longint; const TAU: array of TComplex; var C: array of TComplex;
  CO, LDC, LWORK: longint); forward;

{ The blocked xGEHRD of xLAQR3 (N x N matrix by rows, optimal work
  space), defined with the general eigenproblem drivers. }
procedure GEHRDD(N, ILO, IHI: longint; var A: array of TReal;
  var TAU: array of TReal; LWORK: longint); forward;
procedure GEHRDZ(N, ILO, IHI: longint; var A: array of TComplex;
  var TAU: array of TComplex; LWORK: longint); forward;

{ The deflation check of DLAQR5 for H(K+1, K) after a reflection
  (the same code in two places of DLAQR5): the traditional
  small-compared-to-nearby-diagonals criterion and the Ahues & Kressner
  ultraconservative criterion must both be satisfied. }
procedure DLAQR5DEFL(var H: array of TReal; HO, LDH, K, KTOP, KBOT: longint;
  SMLNUM, ULP: TReal);
var
  H11, H12, H21, H22, SCL, TST1, TST2: TReal;
begin
  if H[HO + (K + 1) * LDH + K] = 0 then Exit;
  TST1 := System.Abs(H[HO + K * LDH + K]) + System.Abs(H[HO + (K + 1) * LDH + K + 1]);
  if TST1 = 0 then
  begin
    if K >= KTOP + 1 then TST1 := TST1 + System.Abs(H[HO + K * LDH + K - 1]);
    if K >= KTOP + 2 then TST1 := TST1 + System.Abs(H[HO + K * LDH + K - 2]);
    if K >= KTOP + 3 then TST1 := TST1 + System.Abs(H[HO + K * LDH + K - 3]);
    if K <= KBOT - 2 then TST1 := TST1 + System.Abs(H[HO + (K + 2) * LDH + K + 1]);
    if K <= KBOT - 3 then TST1 := TST1 + System.Abs(H[HO + (K + 3) * LDH + K + 1]);
    if K <= KBOT - 4 then TST1 := TST1 + System.Abs(H[HO + (K + 4) * LDH + K + 1]);
  end;
  if System.Abs(H[HO + (K + 1) * LDH + K]) <= Max(SMLNUM, ULP * TST1) then
  begin
    H12 := Max(System.Abs(H[HO + (K + 1) * LDH + K]), System.Abs(H[HO + K * LDH + K + 1]));
    H21 := Min(System.Abs(H[HO + (K + 1) * LDH + K]), System.Abs(H[HO + K * LDH + K + 1]));
    H11 := Max(System.Abs(H[HO + (K + 1) * LDH + K + 1]),
      System.Abs(H[HO + K * LDH + K] - H[HO + (K + 1) * LDH + K + 1]));
    H22 := Min(System.Abs(H[HO + (K + 1) * LDH + K + 1]),
      System.Abs(H[HO + K * LDH + K] - H[HO + (K + 1) * LDH + K + 1]));
    SCL := H11 + H12;
    TST2 := H22 * (H11 / SCL);
    if (TST2 = 0) or (H21 * (H12 / SCL) <= Max(SMLNUM, ULP * TST2)) then
      H[HO + (K + 1) * LDH + K] := 0;
  end;
end;

{ DLAQR5: one small-bulge multishift QR sweep with the NSHFTS shifts
  SR[SO..] + i*SI[SO..] (real or complex conjugate pairs) on rows and
  columns KTOP..KBOT of the N x N Hessenberg H (at H[HO], row stride
  LDH), accumulating the transformations in Z (rows ILOZ..IHIZ) when
  WANTZ. KACC22 = 1 or 2 accumulates the reflections of each chain in a
  small orthogonal matrix applied with matrix products (xGEMM). The work
  arrays of LAPACK (V, U, WV, WH) are allocated here. }
procedure DLAQR5(WANTT, WANTZ: boolean; KACC22, N, KTOP, KBOT,
  NSHFTS: longint; var SR, SI: array of TReal; SO: longint;
  var H: array of TReal; HO, LDH, ILOZ, IHIZ: longint; var Z: array of TReal;
  ZO, LDZ: longint);
var
  ALPHA, BETA, REFSUM, SMLNUM, SWAP, T1, T2, T3, ULP: TReal;
  I, I2, I4, INCOL, J, JBOT, JCOL, JLEN, JROW, JTOP, K, K1, KDU, KMS,
    KRCOL, M, M22, MBOT, MTOP, NBMPS, NDCOL, NS, NU, LDU: longint;
  ACCUM, BMP22: boolean;
  VT: array[0..2] of TReal;
  V, U, WH, WV: array of TReal;

begin
  { If there are no shifts, then there is nothing to do. }
  if NSHFTS < 2 then Exit;
  { If the active block is empty or 1-by-1, then there is nothing to do. }
  if KTOP >= KBOT then Exit;
  { Shuffle shifts into pairs of real shifts and pairs of complex
    conjugate shifts assuming complex conjugate shifts are already
    adjacent to one another. }
  I := 0;
  while I <= NSHFTS - 3 do
  begin
    if SI[SO + I] <> -SI[SO + I + 1] then
    begin
      SWAP := SR[SO + I];
      SR[SO + I] := SR[SO + I + 1];
      SR[SO + I + 1] := SR[SO + I + 2];
      SR[SO + I + 2] := SWAP;
      SWAP := SI[SO + I];
      SI[SO + I] := SI[SO + I + 1];
      SI[SO + I + 1] := SI[SO + I + 2];
      SI[SO + I + 2] := SWAP;
    end;
    Inc(I, 2);
  end;
  { NSHFTS is supposed to be even, but if it is odd, then simply reduce
    it by one. The shuffle above ensures that the dropped shift is real
    and that the remaining shifts are paired. }
  NS := NSHFTS - NSHFTS mod 2;
  { Machine constants for deflation. }
  ULP := LapackPrecision;
  SMLNUM := LapackSafeMinimum * (N / ULP);
  { Use accumulated reflections to update far-from-diagonal entries? }
  ACCUM := (KACC22 = 1) or (KACC22 = 2);
  { Clear trash. }
  if KTOP + 2 <= KBOT then H[HO + (KTOP + 2) * LDH + KTOP] := 0;
  { NBMPS = number of 2-shift bulges in the chain. }
  NBMPS := NS div 2;
  { KDU = width of slab. }
  KDU := 4 * NBMPS;
  LDU := KDU;
  V := nil;
  SetLength(V, 3 * NBMPS);
  U := nil;
  if ACCUM then SetLength(U, KDU * KDU);
  { Create and chase chains of NBMPS bulges. V(0:2, m) is stored in
    V[3*m..3*m+2]. }
  INCOL := KTOP - 2 * NBMPS + 1;
  while INCOL <= KBOT - 2 do
  begin
    { JTOP = index from which updates from the right start. }
    if ACCUM then JTOP := Max(KTOP, INCOL)
    else if WANTT then JTOP := 0
    else JTOP := KTOP;
    NDCOL := INCOL + KDU;
    if ACCUM then
      for I := 0 to KDU - 1 do
        for J := 0 to KDU - 1 do
          if I = J then U[I * LDU + J] := 1 else U[I * LDU + J] := 0;
    { Near-the-diagonal bulge chase. The following loop performs the near
      diagonal part of a small bulge multi-shift QR sweep. Each 4*NBMPS
      column diagonal chunk extends from column INCOL to column NDCOL
      (including both column INCOL and column NDCOL). The following loop
      chases a 2*NBMPS+1 column long chain of NBMPS bulges 2*NBMPS columns
      to the right. (INCOL may be less than KTOP and NDCOL may be greater
      than KBOT indicating phantom columns from which to chase bulges
      before they are actually introduced or to which to chase bulges
      beyond column KBOT.) }
    for KRCOL := INCOL to Min(INCOL + 2 * NBMPS - 1, KBOT - 2) do
    begin
      { Bulges number MTOP to MBOT are active double implicit shift
        bulges. There may or may not also be small 2-by-2 bulge, if there
        is room. The inactive bulges (if any) must wait until the active
        bulges have moved down the diagonal to make room. The phantom
        matrix paradigm described above helps keep track. (0-based M:
        bulge M occupies rows KRCOL + 2*M + 1 .. KRCOL + 2*M + 3.) }
      MTOP := Max(1, (KTOP - KRCOL) div 2 + 1);
      { Fortran integer division truncates toward zero, as Pascal div. }
      MBOT := Min(NBMPS, (KBOT - KRCOL - 1) div 2);
      M22 := MBOT + 1;
      BMP22 := (MBOT < NBMPS) and (KRCOL + 2 * (M22 - 1) = KBOT - 2);
      { Generate reflections to chase the chain right one column. (The
        minimum value of K is KTOP-1.) }
      if BMP22 then
      begin
        { Special case: 2-by-2 reflection at bottom treated separately. }
        K := KRCOL + 2 * (M22 - 1);
        if K = KTOP - 1 then
        begin
          DLAQR1(2, H, HO + (K + 1) * LDH + K + 1, LDH, SR[SO + 2 * M22 - 2],
            SI[SO + 2 * M22 - 2], SR[SO + 2 * M22 - 1], SI[SO + 2 * M22 - 1],
            V, 3 * (M22 - 1));
          BETA := V[3 * (M22 - 1)];
          DLARFG(2, BETA, V, 3 * (M22 - 1) + 1, 1, T1);
          V[3 * (M22 - 1)] := T1;
        end else
        begin
          BETA := H[HO + (K + 1) * LDH + K];
          V[3 * (M22 - 1) + 1] := H[HO + (K + 2) * LDH + K];
          DLARFG(2, BETA, V, 3 * (M22 - 1) + 1, 1, T1);
          V[3 * (M22 - 1)] := T1;
          H[HO + (K + 1) * LDH + K] := BETA;
          H[HO + (K + 2) * LDH + K] := 0;
        end;
        { Perform update from right within computational window. }
        T1 := V[3 * (M22 - 1)];
        T2 := T1 * V[3 * (M22 - 1) + 1];
        for J := JTOP to Min(KBOT, K + 3) do
        begin
          REFSUM := H[HO + J * LDH + K + 1] + V[3 * (M22 - 1) + 1] * H[HO + J * LDH + K + 2];
          H[HO + J * LDH + K + 1] := H[HO + J * LDH + K + 1] - REFSUM * T1;
          H[HO + J * LDH + K + 2] := H[HO + J * LDH + K + 2] - REFSUM * T2;
        end;
        { Perform update from left within computational window. }
        if ACCUM then JBOT := Min(NDCOL, KBOT)
        else if WANTT then JBOT := N - 1
        else JBOT := KBOT;
        T1 := V[3 * (M22 - 1)];
        T2 := T1 * V[3 * (M22 - 1) + 1];
        for J := K + 1 to JBOT do
        begin
          REFSUM := H[HO + (K + 1) * LDH + J] + V[3 * (M22 - 1) + 1] * H[HO + (K + 2) * LDH + J];
          H[HO + (K + 1) * LDH + J] := H[HO + (K + 1) * LDH + J] - REFSUM * T1;
          H[HO + (K + 2) * LDH + J] := H[HO + (K + 2) * LDH + J] - REFSUM * T2;
        end;
        { The following convergence test requires that the traditional
          small-compared-to-nearby-diagonals criterion and the
          Ahues & Kressner ultraconservative criterion are both satisfied.
          The latter improves accuracy in some examples. Falling back on an
          alternate convergence criterion when TST1 or TST2 is zero (as
          done here) is traditional but probably unnecessary. }
        if K >= KTOP then DLAQR5DEFL(H, HO, LDH, K, KTOP, KBOT, SMLNUM, ULP);
        { Accumulate orthogonal transformations. }
        if ACCUM then
        begin
          KMS := K - INCOL - 1;
          T1 := V[3 * (M22 - 1)];
          T2 := T1 * V[3 * (M22 - 1) + 1];
          for J := Max(0, KTOP - INCOL - 1) to KDU - 1 do
          begin
            REFSUM := U[J * LDU + KMS + 1] + V[3 * (M22 - 1) + 1] *
              U[J * LDU + KMS + 2];
            U[J * LDU + KMS + 1] := U[J * LDU + KMS + 1] - REFSUM * T1;
            U[J * LDU + KMS + 2] := U[J * LDU + KMS + 2] - REFSUM * T2;
          end;
        end else if WANTZ then
        begin
          T1 := V[3 * (M22 - 1)];
          T2 := T1 * V[3 * (M22 - 1) + 1];
          for J := ILOZ to IHIZ do
          begin
            REFSUM := Z[ZO + J * LDZ + K + 1] + V[3 * (M22 - 1) + 1] *
              Z[ZO + J * LDZ + K + 2];
            Z[ZO + J * LDZ + K + 1] := Z[ZO + J * LDZ + K + 1] - REFSUM * T1;
            Z[ZO + J * LDZ + K + 2] := Z[ZO + J * LDZ + K + 2] - REFSUM * T2;
          end;
        end;
      end;
      { Normal case: chain of 3-by-3 reflections. }
      for M := MBOT downto MTOP do
      begin
        K := KRCOL + 2 * (M - 1);
        if K = KTOP - 1 then
        begin
          DLAQR1(3, H, HO + KTOP * LDH + KTOP, LDH, SR[SO + 2 * M - 2],
            SI[SO + 2 * M - 2], SR[SO + 2 * M - 1], SI[SO + 2 * M - 1],
            V, 3 * (M - 1));
          ALPHA := V[3 * (M - 1)];
          DLARFG(3, ALPHA, V, 3 * (M - 1) + 1, 1, T1);
          V[3 * (M - 1)] := T1;
        end else
        begin
          { Perform delayed transformation of row below Mth bulge.
            Exploit fact that first two elements of row are actually
            zero. }
          T1 := V[3 * (M - 1)];
          T2 := T1 * V[3 * (M - 1) + 1];
          T3 := T1 * V[3 * (M - 1) + 2];
          REFSUM := V[3 * (M - 1) + 2] * H[HO + (K + 3) * LDH + K + 2];
          H[HO + (K + 3) * LDH + K] := -REFSUM * T1;
          H[HO + (K + 3) * LDH + K + 1] := -REFSUM * T2;
          H[HO + (K + 3) * LDH + K + 2] := H[HO + (K + 3) * LDH + K + 2] - REFSUM * T3;
          { Calculate reflection to move Mth bulge one step. }
          BETA := H[HO + (K + 1) * LDH + K];
          V[3 * (M - 1) + 1] := H[HO + (K + 2) * LDH + K];
          V[3 * (M - 1) + 2] := H[HO + (K + 3) * LDH + K];
          DLARFG(3, BETA, V, 3 * (M - 1) + 1, 1, T1);
          V[3 * (M - 1)] := T1;
          { A bulge may collapse because of vigilant deflation or
            destructive underflow. In the underflow case, try the
            two-small-subdiagonals trick to try to reinflate the bulge. }
          if (H[HO + (K + 3) * LDH + K] <> 0) or (H[HO + (K + 3) * LDH + K + 1] <> 0) or
             (H[HO + (K + 3) * LDH + K + 2] = 0) then
          begin
            { Typical case: not collapsed (yet). }
            H[HO + (K + 1) * LDH + K] := BETA;
            H[HO + (K + 2) * LDH + K] := 0;
            H[HO + (K + 3) * LDH + K] := 0;
          end else
          begin
            { Atypical case: collapsed. Attempt to reintroduce ignoring
              H(K+1,K) and H(K,K). If the fill resulting from the new
              reflector is too large, then abandon it. Otherwise, use the
              new one. }
            DLAQR1(3, H, HO + (K + 1) * LDH + K + 1, LDH, SR[SO + 2 * M - 2],
              SI[SO + 2 * M - 2], SR[SO + 2 * M - 1], SI[SO + 2 * M - 1],
              VT, 0);
            ALPHA := VT[0];
            DLARFG(3, ALPHA, VT, 1, 1, T1);
            VT[0] := T1;
            T1 := VT[0];
            T2 := T1 * VT[1];
            T3 := T1 * VT[2];
            REFSUM := H[HO + (K + 1) * LDH + K] + VT[1] * H[HO + (K + 2) * LDH + K];
            if System.Abs(H[HO + (K + 2) * LDH + K] - REFSUM * T2) +
               System.Abs(REFSUM * T3) > ULP * (System.Abs(H[HO + K * LDH + K]) +
               System.Abs(H[HO + (K + 1) * LDH + K + 1]) +
               System.Abs(H[HO + (K + 2) * LDH + K + 2])) then
            begin
              { Starting a new bulge here would create non-negligible
                fill. Use the old one with trepidation. }
              H[HO + (K + 1) * LDH + K] := BETA;
              H[HO + (K + 2) * LDH + K] := 0;
              H[HO + (K + 3) * LDH + K] := 0;
            end else
            begin
              { Starting a new bulge here would create only negligible
                fill. Replace the old reflector with the new one. }
              H[HO + (K + 1) * LDH + K] := H[HO + (K + 1) * LDH + K] - REFSUM * T1;
              H[HO + (K + 2) * LDH + K] := 0;
              H[HO + (K + 3) * LDH + K] := 0;
              V[3 * (M - 1)] := VT[0];
              V[3 * (M - 1) + 1] := VT[1];
              V[3 * (M - 1) + 2] := VT[2];
            end;
          end;
        end;
        { Apply reflection from the right and the first column of update
          from the left. These updates are required for the vigilant
          deflation check. We still delay most of the updates from the
          left for efficiency. }
        T1 := V[3 * (M - 1)];
        T2 := T1 * V[3 * (M - 1) + 1];
        T3 := T1 * V[3 * (M - 1) + 2];
        for J := JTOP to Min(KBOT, K + 3) do
        begin
          REFSUM := H[HO + J * LDH + K + 1] + V[3 * (M - 1) + 1] * H[HO + J * LDH + K + 2] +
            V[3 * (M - 1) + 2] * H[HO + J * LDH + K + 3];
          H[HO + J * LDH + K + 1] := H[HO + J * LDH + K + 1] - REFSUM * T1;
          H[HO + J * LDH + K + 2] := H[HO + J * LDH + K + 2] - REFSUM * T2;
          H[HO + J * LDH + K + 3] := H[HO + J * LDH + K + 3] - REFSUM * T3;
        end;
        { Perform update from left for subsequent column. }
        REFSUM := H[HO + (K + 1) * LDH + K + 1] + V[3 * (M - 1) + 1] *
          H[HO + (K + 2) * LDH + K + 1] + V[3 * (M - 1) + 2] * H[HO + (K + 3) * LDH + K + 1];
        H[HO + (K + 1) * LDH + K + 1] := H[HO + (K + 1) * LDH + K + 1] - REFSUM * T1;
        H[HO + (K + 2) * LDH + K + 1] := H[HO + (K + 2) * LDH + K + 1] - REFSUM * T2;
        H[HO + (K + 3) * LDH + K + 1] := H[HO + (K + 3) * LDH + K + 1] - REFSUM * T3;
        { The following convergence test requires that the traditional
          small-compared-to-nearby-diagonals criterion and the Ahues &
          Kressner ultraconservative criterion are both satisfied. The
          latter improves accuracy in some examples. Falling back on an
          alternate convergence criterion when TST1 or TST2 is zero (as
          done here) is traditional but probably unnecessary. }
        if K < KTOP then Continue;
        DLAQR5DEFL(H, HO, LDH, K, KTOP, KBOT, SMLNUM, ULP);
      end;
      { Multiply H by reflections from the left. }
      if ACCUM then JBOT := Min(NDCOL, KBOT)
      else if WANTT then JBOT := N - 1
      else JBOT := KBOT;
      for M := MBOT downto MTOP do
      begin
        K := KRCOL + 2 * (M - 1);
        T1 := V[3 * (M - 1)];
        T2 := T1 * V[3 * (M - 1) + 1];
        T3 := T1 * V[3 * (M - 1) + 2];
        for J := Max(KTOP, KRCOL + 2 * M) to JBOT do
        begin
          REFSUM := H[HO + (K + 1) * LDH + J] + V[3 * (M - 1) + 1] * H[HO + (K + 2) * LDH + J] +
            V[3 * (M - 1) + 2] * H[HO + (K + 3) * LDH + J];
          H[HO + (K + 1) * LDH + J] := H[HO + (K + 1) * LDH + J] - REFSUM * T1;
          H[HO + (K + 2) * LDH + J] := H[HO + (K + 2) * LDH + J] - REFSUM * T2;
          H[HO + (K + 3) * LDH + J] := H[HO + (K + 3) * LDH + J] - REFSUM * T3;
        end;
      end;
      { Accumulate orthogonal transformations. }
      if ACCUM then
      begin
        { Accumulate U. (If needed, update Z later with an efficient
          matrix-matrix multiply.) }
        for M := MBOT downto MTOP do
        begin
          K := KRCOL + 2 * (M - 1);
          KMS := K - INCOL - 1;
          I2 := Max(0, KTOP - INCOL - 1);
          I2 := Max(I2, KMS + 1 - (KRCOL - INCOL));
          I4 := Min(KDU, KRCOL + 2 * (MBOT - 1) - INCOL + 5) - 1;
          T1 := V[3 * (M - 1)];
          T2 := T1 * V[3 * (M - 1) + 1];
          T3 := T1 * V[3 * (M - 1) + 2];
          for J := I2 to I4 do
          begin
            REFSUM := U[J * LDU + KMS + 1] + V[3 * (M - 1) + 1] *
              U[J * LDU + KMS + 2] + V[3 * (M - 1) + 2] * U[J * LDU + KMS + 3];
            U[J * LDU + KMS + 1] := U[J * LDU + KMS + 1] - REFSUM * T1;
            U[J * LDU + KMS + 2] := U[J * LDU + KMS + 2] - REFSUM * T2;
            U[J * LDU + KMS + 3] := U[J * LDU + KMS + 3] - REFSUM * T3;
          end;
        end;
      end else if WANTZ then
      begin
        { U is not accumulated, so update Z now by multiplying by
          reflections from the right. }
        for M := MBOT downto MTOP do
        begin
          K := KRCOL + 2 * (M - 1);
          T1 := V[3 * (M - 1)];
          T2 := T1 * V[3 * (M - 1) + 1];
          T3 := T1 * V[3 * (M - 1) + 2];
          for J := ILOZ to IHIZ do
          begin
            REFSUM := Z[ZO + J * LDZ + K + 1] + V[3 * (M - 1) + 1] *
              Z[ZO + J * LDZ + K + 2] + V[3 * (M - 1) + 2] *
              Z[ZO + J * LDZ + K + 3];
            Z[ZO + J * LDZ + K + 1] := Z[ZO + J * LDZ + K + 1] - REFSUM * T1;
            Z[ZO + J * LDZ + K + 2] := Z[ZO + J * LDZ + K + 2] - REFSUM * T2;
            Z[ZO + J * LDZ + K + 3] := Z[ZO + J * LDZ + K + 3] - REFSUM * T3;
          end;
        end;
      end;
    end;
    { Use U (if accumulated) to update far-from-diagonal entries in H. If
      required, use U to update Z as well. }
    if ACCUM then
    begin
      if WANTT then
      begin
        JTOP := 0;
        JBOT := N - 1;
      end else
      begin
        JTOP := KTOP;
        JBOT := KBOT;
      end;
      K1 := Max(1, KTOP - INCOL);
      NU := (KDU - Max(0, NDCOL - KBOT)) - K1 + 1;
      { 0-based: rows and columns K1-1 .. K1+NU-2 of U act on rows and
        columns INCOL+K1 .. INCOL+K1+NU-1 of H. }
      { Horizontal multiply. }
      JCOL := Min(NDCOL, KBOT) + 1;
      if JCOL <= JBOT then
      begin
        JLEN := JBOT - JCOL + 1;
        WH := nil;
        SetLength(WH, NU * JLEN);
        DGEMM('T', 'N', NU, JLEN, NU, FONE, U, (K1 - 1) * LDU + K1 - 1, LDU, H,
          HO + (INCOL + K1) * LDH + JCOL, LDH, FZERO, WH, 0, JLEN);
        for I := 0 to NU - 1 do
          for J := 0 to JLEN - 1 do
            H[HO + (INCOL + K1 + I) * LDH + JCOL + J] := WH[I * JLEN + J];
      end;
      { Vertical multiply. }
      JROW := JTOP;
      if JROW <= Max(KTOP, INCOL) - 1 then
      begin
        JLEN := Max(KTOP, INCOL) - JROW;
        WV := nil;
        SetLength(WV, JLEN * NU);
        DGEMM('N', 'N', JLEN, NU, NU, FONE, H, HO + JROW * LDH + INCOL + K1,
          LDH, U, (K1 - 1) * LDU + K1 - 1, LDU, FZERO, WV, 0, NU);
        for I := 0 to JLEN - 1 do
          for J := 0 to NU - 1 do
            H[HO + (JROW + I) * LDH + INCOL + K1 + J] := WV[I * NU + J];
      end;
      { Z multiply (also vertical). }
      if WANTZ and (ILOZ <= IHIZ) then
      begin
        JLEN := IHIZ - ILOZ + 1;
        WV := nil;
        SetLength(WV, JLEN * NU);
        DGEMM('N', 'N', JLEN, NU, NU, FONE, Z, ZO + ILOZ * LDZ + INCOL + K1,
          LDZ, U, (K1 - 1) * LDU + K1 - 1, LDU, FZERO, WV, 0, NU);
        for I := 0 to JLEN - 1 do
          for J := 0 to NU - 1 do
            Z[ZO + (ILOZ + I) * LDZ + INCOL + K1 + J] := WV[I * NU + J];
      end;
    end;
    Inc(INCOL, 2 * NBMPS);
  end;
end;

procedure DLAQR04(RECURSIVE, WANTT, WANTZ: boolean; N, ILO, IHI: longint;
  var H: array of TReal; HO, LDH: longint; var WR, WI: array of TReal;
  WO, ILOZ, IHIZ: longint; var Z: array of TReal; ZO, LDZ: longint; LWORK: longint;
  out INFO: longint); forward;

{ DLAQR3 (RECURSIVE) and DLAQR2: aggressive early deflation on the
  window of order NW at the bottom of the active block KTOP..KBOT. NS is
  the number of unconverged eigenvalues of the window, returned in
  SR[SO + KBOT - ND - NS + 1 ..], SI[..] for use as shifts; ND the number
  of converged ones, which are deflated. DLAQR3 calls DLAQR4 for windows
  larger than NMIN, DLAQR2 always DLAHQR. }
procedure DLAQR23(RECURSIVE, WANTT, WANTZ: boolean; N, KTOP, KBOT,
  NW: longint; var H: array of TReal; HO, LDH, ILOZ, IHIZ: longint;
  var Z: array of TReal; ZO, LDZ: longint; out NS, ND: longint;
  var SR, SI: array of TReal; SO: longint; LWORK: longint);
var
  AA, BB, BETA, CC, CS, DD, EVI, EVK, FOO, S, SMLNUM, SN, TAU, ULP: TReal;
  I, IFST, ILST, INFO, INFQR, J, JW, K, KCOL, KEND, KLN, KROW, KWTOP, LTOP,
    NMIN: longint;
  BULGE, SORTED: boolean;
  T, V, WORK, WORK2, TAUH, WV: array of TReal;
begin
  NS := 0;
  ND := 0;
  { Quick return if possible. }
  if KTOP > KBOT then Exit;
  if NW < 1 then Exit;
  { Machine constants. }
  ULP := LapackPrecision;
  SMLNUM := LapackSafeMinimum * (N / ULP);
  { Setup deflation window. }
  JW := Min(NW, KBOT - KTOP + 1);
  KWTOP := KBOT - JW + 1;
  if KWTOP = KTOP then S := 0
  else S := H[HO + KWTOP * LDH + KWTOP - 1];
  if KBOT = KWTOP then
  begin
    { 1-by-1 deflation window: not much to do. }
    SR[SO + KWTOP] := H[HO + KWTOP * LDH + KWTOP];
    SI[SO + KWTOP] := 0;
    NS := 1;
    ND := 0;
    if System.Abs(S) <= Max(SMLNUM, ULP * System.Abs(H[HO + KWTOP * LDH + KWTOP])) then
    begin
      NS := 0;
      ND := 1;
      if KWTOP > KTOP then H[HO + KWTOP * LDH + KWTOP - 1] := 0;
    end;
    Exit;
  end;
  { Convert to spike-triangular form. (In case of a rare QR failure, this
    routine continues to do aggressive early deflation using that part of
    the deflation window that converged using INFQR here and there to keep
    track.) T is the JW x JW window (upper triangle and subdiagonal) and V
    the orthogonal matrix, both stored by rows with row stride JW. }
  T := nil;
  SetLength(T, JW * JW);
  for I := 0 to JW - 1 do
    for J := Max(I - 1, 0) to JW - 1 do
      T[I * JW + J] := H[HO + (KWTOP + I) * LDH + KWTOP + J];
  V := nil;
  SetLength(V, JW * JW);
  for I := 0 to JW - 1 do V[I * JW + I] := 1;
  NMIN := IPARMQ(12, 0, JW - 1);
  if RECURSIVE and (JW > NMIN) then
    DLAQR04(False, True, True, JW, 0, JW - 1, T, 0, JW, SR, SI, SO + KWTOP,
      0, JW - 1, V, 0, JW, LWORK, INFQR)
  else
    DLAHQR(True, True, JW, 0, JW - 1, T, 0, JW, SR, SI, SO + KWTOP, 0,
      JW - 1, V, 0, JW, INFQR);
  { DTREXC needs a clean margin near the diagonal. }
  for J := 0 to JW - 4 do
  begin
    T[(J + 2) * JW + J] := 0;
    T[(J + 3) * JW + J] := 0;
  end;
  if JW > 2 then T[(JW - 1) * JW + JW - 3] := 0;
  { Deflation check. ILST is the 0-based position of the next eigenvalue
    to test; NS the number of undeflated ones. }
  NS := JW;
  ILST := INFQR;
  while ILST <= NS - 1 do
  begin
    if NS = 1 then BULGE := False
    else BULGE := T[(NS - 1) * JW + NS - 2] <> 0;
    if not BULGE then
    begin
      { Real eigenvalue. }
      FOO := System.Abs(T[(NS - 1) * JW + NS - 1]);
      if FOO = 0 then FOO := System.Abs(S);
      if System.Abs(S * V[NS - 1]) <= Max(SMLNUM, ULP * FOO) then
        { Deflatable. }
        Dec(NS)
      else
      begin
        { Undeflatable. Move it up out of the way. (DTREXC can not fail
          in this case.) }
        IFST := NS - 1;
        DTREXC(JW, T, V, IFST, ILST, INFO);
        Inc(ILST);
      end;
    end else
    begin
      { Complex conjugate pair. }
      FOO := System.Abs(T[(NS - 1) * JW + NS - 1]) +
        Sqrt(System.Abs(T[(NS - 1) * JW + NS - 2])) *
        Sqrt(System.Abs(T[(NS - 2) * JW + NS - 1]));
      if FOO = 0 then FOO := System.Abs(S);
      if Max(System.Abs(S * V[NS - 1]), System.Abs(S * V[NS - 2])) <=
         Max(SMLNUM, ULP * FOO) then
        { Deflatable. }
        Dec(NS, 2)
      else
      begin
        { Undeflatable. Move them up out of the way. Fortunately, DTREXC
          does the right thing with ILST in case of a rare exchange
          failure. }
        IFST := NS - 1;
        DTREXC(JW, T, V, IFST, ILST, INFO);
        Inc(ILST, 2);
      end;
    end;
  end;
  { Return to Hessenberg form. }
  if NS = 0 then S := 0;
  if NS < JW then
  begin
    { Sorting diagonal blocks of T improves accuracy for graded matrices.
      Bubble sort deals well with exchange failures. }
    SORTED := False;
    I := NS;
    while not SORTED do
    begin
      SORTED := True;
      KEND := I - 1;
      I := INFQR;
      if I = NS - 1 then K := I + 1
      else if T[(I + 1) * JW + I] = 0 then K := I + 1
      else K := I + 2;
      while K <= KEND do
      begin
        if K = I + 1 then
          EVI := System.Abs(T[I * JW + I])
        else
          EVI := System.Abs(T[I * JW + I]) + Sqrt(System.Abs(T[(I + 1) * JW + I])) *
            Sqrt(System.Abs(T[I * JW + I + 1]));
        if K = KEND then
          EVK := System.Abs(T[K * JW + K])
        else if T[(K + 1) * JW + K] = 0 then
          EVK := System.Abs(T[K * JW + K])
        else
          EVK := System.Abs(T[K * JW + K]) + Sqrt(System.Abs(T[(K + 1) * JW + K])) *
            Sqrt(System.Abs(T[K * JW + K + 1]));
        if EVI >= EVK then
          I := K
        else
        begin
          SORTED := False;
          IFST := I;
          ILST := K;
          DTREXC(JW, T, V, IFST, ILST, INFO);
          if INFO = 0 then I := ILST else I := K;
        end;
        if I = KEND then K := I + 1
        else if T[(I + 1) * JW + I] = 0 then K := I + 1
        else K := I + 2;
      end;
    end;
  end;
  { Restore shift/eigenvalue array from T. }
  I := JW - 1;
  while I >= INFQR do
  begin
    if I = INFQR then
    begin
      SR[SO + KWTOP + I] := T[I * JW + I];
      SI[SO + KWTOP + I] := 0;
      Dec(I);
    end else if T[I * JW + I - 1] = 0 then
    begin
      SR[SO + KWTOP + I] := T[I * JW + I];
      SI[SO + KWTOP + I] := 0;
      Dec(I);
    end else
    begin
      AA := T[(I - 1) * JW + I - 1];
      CC := T[I * JW + I - 1];
      BB := T[(I - 1) * JW + I];
      DD := T[I * JW + I];
      DLANV2(AA, BB, CC, DD, SR[SO + KWTOP + I - 1], SI[SO + KWTOP + I - 1],
        SR[SO + KWTOP + I], SI[SO + KWTOP + I], CS, SN);
      Dec(I, 2);
    end;
  end;
  if (NS < JW) or (S = 0) then
  begin
    if (NS > 1) and (S <> 0) then
    begin
      { Reflect spike back into lower triangle. }
      WORK := nil;
      SetLength(WORK, JW);
      for I := 0 to NS - 1 do WORK[I] := V[I];
      BETA := WORK[0];
      DLARFG(NS, BETA, WORK, 1, 1, TAU);
      for J := 0 to JW - 3 do
        for I := J + 2 to JW - 1 do T[I * JW + J] := 0;
      WORK2 := nil;
      SetLength(WORK2, 2 * JW);
      specialize LARF1F<TReal>(True, NS, JW, WORK, 0, 1, TAU, T, 0, JW, WORK2);
      specialize LARF1F<TReal>(False, NS, NS, WORK, 0, 1, TAU, T, 0, JW, WORK2);
      specialize LARF1F<TReal>(False, JW, NS, WORK, 0, 1, TAU, V, 0, JW, WORK2);
      TAUH := nil;
      SetLength(TAUH, JW);
      GEHRDD(JW, 0, NS - 1, T, TAUH, LWORK - JW);
    end;
    { Copy updated reduced window into place. }
    if KWTOP > 0 then H[HO + KWTOP * LDH + KWTOP - 1] := S * V[0];
    for I := 0 to JW - 1 do
      for J := Max(I - 1, 0) to JW - 1 do
        H[HO + (KWTOP + I) * LDH + KWTOP + J] := T[I * JW + J];
    { Accumulate orthogonal matrix in order update H and Z, if requested. }
    if (NS > 1) and (S <> 0) then
      ORMQRD(JW, NS - 1, NS - 1, T, JW, JW, TAUH, V, 1, JW, LWORK - JW);
    { Update vertical slab in H. }
    if WANTT then LTOP := 0 else LTOP := KTOP;
    KLN := KWTOP - LTOP;
    if KLN > 0 then
    begin
      KROW := LTOP;
      WV := nil;
      SetLength(WV, KLN * JW);
      DGEMM('N', 'N', KLN, JW, JW, FONE, H, HO + KROW * LDH + KWTOP, LDH, V, 0,
        JW, FZERO, WV, 0, JW);
      for I := 0 to KLN - 1 do
        for J := 0 to JW - 1 do
          H[HO + (KROW + I) * LDH + KWTOP + J] := WV[I * JW + J];
    end;
    { Update horizontal slab in H. }
    if WANTT then
    begin
      KCOL := KBOT + 1;
      KLN := N - KCOL;
      if KLN > 0 then
      begin
        WV := nil;
        SetLength(WV, JW * KLN);
        DGEMM('T', 'N', JW, KLN, JW, FONE, V, 0, JW, H,
          HO + KWTOP * LDH + KCOL, LDH, FZERO, WV, 0, KLN);
        for I := 0 to JW - 1 do
          for J := 0 to KLN - 1 do
            H[HO + (KWTOP + I) * LDH + KCOL + J] := WV[I * KLN + J];
      end;
    end;
    { Update vertical slab in Z. }
    if WANTZ then
    begin
      KLN := IHIZ - ILOZ + 1;
      if KLN > 0 then
      begin
        WV := nil;
        SetLength(WV, KLN * JW);
        DGEMM('N', 'N', KLN, JW, JW, FONE, Z, ZO + ILOZ * LDZ + KWTOP, LDZ, V,
          0, JW, FZERO, WV, 0, JW);
        for I := 0 to KLN - 1 do
          for J := 0 to JW - 1 do
            Z[ZO + (ILOZ + I) * LDZ + KWTOP + J] := WV[I * JW + J];
      end;
    end;
  end;
  { Return the number of deflations. }
  ND := JW - NS;
  { ... and the number of shifts. (Subtracting INFQR from the spike
    length takes care of the case of a rare QR failure while calculating
    eigenvalues of the deflation window.) }
  NS := NS - INFQR;
end;

{ DLAQR0 (RECURSIVE) and DLAQR4: Schur factorization of the Hessenberg
  matrix H by the small-bulge multishift QR algorithm with aggressive
  early deflation; arguments as DLAHQR. The workspace of LAPACK is taken
  as large as the optimal one returned by a workspace query (as when
  DGEEV is called with the optimal LWORK), so it never limits the window
  and shift counts NWMAX = (N-1)/3, NSMAX = (N-3)/6; the work arrays that
  LAPACK places in the unused lower triangle of H are allocated
  separately. }
procedure DLAQR04(RECURSIVE, WANTT, WANTZ: boolean; N, ILO, IHI: longint;
  var H: array of TReal; HO, LDH: longint; var WR, WI: array of TReal;
  WO, ILOZ, IHIZ: longint; var Z: array of TReal; ZO, LDZ: longint; LWORK: longint;
  out INFO: longint);
const
  { Matrices of order NTINY or smaller must be processed by DLAHQR
    because of insufficient subdiagonal scratch space. (This is a hard
    limit.) }
  NTINY = 15;
  { Exceptional deflation windows: try to cure rare slow convergence by
    varying the size of the deflation window after KEXNW iterations. }
  KEXNW = 5;
  { Exceptional shifts: try to cure rare slow convergence with ad-hoc
    exceptional shifts every KEXSH iterations. }
  KEXSH = 6;
  { The constants WILK1 and WILK2 are used to form the exceptional
    shifts. }
  WILK1: TReal = 0.75;
  WILK2: TReal = -0.4375;
var
  AA, BB, CC, CS, DD, SN, SS, SWAP: TReal;
  I, INF, IT, ITMAX, K, KACC22, KBOT, KS, KT, KTOP, KWTOP, LD, LS, NDEC,
    NDFL, NH, NIBBLE, NMIN, NS, NSMAX, NSR, NW, NWMAX, NWR, NWUPBD: longint;
  SORTED: boolean;
  HS, ZDUM: array of TReal;
begin
  INFO := 0;
  { Quick return for N = 0: nothing to do. }
  if N = 0 then Exit;
  if N <= NTINY then
  begin
    { Tiny matrices must use DLAHQR. }
    DLAHQR(WANTT, WANTZ, N, ILO, IHI, H, HO, LDH, WR, WI, WO, ILOZ, IHIZ,
      Z, ZO, LDZ, INFO);
    Exit;
  end;
  { Use small bulge multi-shift QR with aggressive early deflation on
    larger-than-tiny matrices. Hope for the best. }
  INFO := 0;
  { NWR = recommended deflation window size. At this point, N > NTINY =
    15, so there is enough subdiagonal workspace for NWR >= 2 as
    required. (In fact, there is enough subdiagonal space for NWR >= 4.) }
  NWR := IPARMQ(13, ILO, IHI);
  NWR := Max(2, NWR);
  NWR := Min(Min(IHI - ILO + 1, (N - 1) div 3), NWR);
  { NSR = recommended number of simultaneous shifts. At this point
    N > NTINY = 15, so there is enough subdiagonal workspace for NSR to be
    even and greater than or equal to two as required. }
  NSR := IPARMQ(15, ILO, IHI);
  NSR := Min(Min(NSR, (N - 3) div 6), IHI - ILO);
  NSR := Max(2, NSR - NSR mod 2);
  { NMIN = the smallest matrix size for which this routine is
    recommended. }
  NMIN := IPARMQ(12, ILO, IHI);
  NMIN := Max(NTINY, NMIN);
  { NIBBLE = percent of the deflation window that must deflate to skip a
    sweep. }
  NIBBLE := IPARMQ(14, ILO, IHI);
  NIBBLE := Max(0, NIBBLE);
  { Accumulate reflections during the QR sweep? Use block 2-by-2
    structure during matrix-matrix multiply? }
  KACC22 := IPARMQ(16, ILO, IHI);
  KACC22 := Max(0, KACC22);
  KACC22 := Min(2, KACC22);
  { NWMAX = the largest possible deflation window for which there is
    sufficient workspace. }
  NWMAX := Min((N - 1) div 3, LWORK div 2);
  NW := NWMAX;
  { NSMAX = the largest number of simultaneous shifts for which there is
    sufficient workspace. }
  NSMAX := Min((N - 3) div 6, 2 * LWORK div 3);
  NSMAX := NSMAX - NSMAX mod 2;
  { NDFL: an iteration count restarted at deflation. }
  NDFL := 1;
  NDEC := 0;
  { ITMAX = iteration limit. }
  ITMAX := Max(30, 2 * KEXSH) * Max(10, IHI - ILO + 1);
  { Last row and column in the active block. }
  KBOT := IHI;
  { Main loop. }
  for IT := 1 to ITMAX do
  begin
    { Done when KBOT falls below ILO. }
    if KBOT < ILO then Exit;
    { Locate active block. }
    K := KBOT;
    while K >= ILO + 1 do
    begin
      if H[HO + K * LDH + K - 1] = 0 then Break;
      Dec(K);
    end;
    KTOP := K;
    { Select deflation window size: typical case: if possible and
      advisable, nibble the entire active block. If not, use size MIN(NWR,
      NWMAX) or MIN(NWR+1, NWMAX) depending upon which has the smaller
      corresponding subdiagonal entry (a heuristic). Exceptional case: if
      there have been no deflations in KEXNW or more iterations, then
      vary the deflation window size. At first, because, larger windows
      are, in general, more powerful than smaller ones, rapidly increase
      the window to the maximum possible. Then, gradually reduce the
      window size. }
    NH := KBOT - KTOP + 1;
    NWUPBD := Min(NH, NWMAX);
    if NDFL < KEXNW then
      NW := Min(NWUPBD, NWR)
    else
      NW := Min(NWUPBD, 2 * NW);
    if NW < NWMAX then
    begin
      if NW >= NH - 1 then
        NW := NH
      else
      begin
        KWTOP := KBOT - NW + 1;
        if System.Abs(H[HO + KWTOP * LDH + KWTOP - 1]) >
           System.Abs(H[HO + (KWTOP - 1) * LDH + KWTOP - 2]) then Inc(NW);
      end;
    end;
    if NDFL < KEXNW then
      NDEC := -1
    else if (NDEC >= 0) or (NW >= NWUPBD) then
    begin
      Inc(NDEC);
      if NW - NDEC < 2 then NDEC := 0;
      NW := NW - NDEC;
    end;
    { Aggressive early deflation: split workspace under the subdiagonal
      into the work arrays of DLAQR3 (allocated by DLAQR23). }
    DLAQR23(RECURSIVE, WANTT, WANTZ, N, KTOP, KBOT, NW, H, HO, LDH, ILOZ,
      IHIZ, Z, ZO, LDZ, LS, LD, WR, WI, WO, LWORK);
    { Adjust KBOT accounting for new deflations. }
    KBOT := KBOT - LD;
    { KS points to the shifts. }
    KS := KBOT - LS + 1;
    { Skip an expensive QR sweep if there is a (partly heuristic) reason
      to expect that many eigenvalues will deflate without it. Here, the
      QR sweep is skipped if many eigenvalues have just been deflated or
      if the remaining active block is small. }
    if (LD = 0) or ((100 * LD <= NW * NIBBLE) and
       (KBOT - KTOP + 1 > Min(NMIN, NWMAX))) then
    begin
      { NS = nominal number of simultaneous shifts. This may be lowered
        (slightly) if DLAQR3 did not provide that many shifts. }
      NS := Min(Min(NSMAX, NSR), Max(2, KBOT - KTOP));
      NS := NS - NS mod 2;
      { If there have been no deflations in a multiple of KEXSH
        iterations, then try exceptional shifts. Otherwise use shifts
        provided by DLAQR3 above or from the eigenvalues of a trailing
        principal submatrix. }
      if NDFL mod KEXSH = 0 then
      begin
        KS := KBOT - NS + 1;
        I := KBOT;
        while I >= Max(KS + 1, KTOP + 2) do
        begin
          SS := System.Abs(H[HO + I * LDH + I - 1]) +
            System.Abs(H[HO + (I - 1) * LDH + I - 2]);
          AA := WILK1 * SS + H[HO + I * LDH + I];
          BB := SS;
          CC := WILK2 * SS;
          DD := AA;
          DLANV2(AA, BB, CC, DD, WR[WO + I - 1], WI[WO + I - 1], WR[WO + I],
            WI[WO + I], CS, SN);
          Dec(I, 2);
        end;
        if KS = KTOP then
        begin
          WR[WO + KS + 1] := H[HO + (KS + 1) * LDH + KS + 1];
          WI[WO + KS + 1] := 0;
          WR[WO + KS] := WR[WO + KS + 1];
          WI[WO + KS] := WI[WO + KS + 1];
        end;
      end else
      begin
        { Got NS/2 or fewer shifts? Use DLAQR4 or DLAHQR on a trailing
          principal submatrix to get more. (Since NS <= NSMAX <= (N-3)/6,
          there is enough space below the subdiagonal to fit an NS-by-NS
          scratch array.) }
        if KBOT - KS + 1 <= NS div 2 then
        begin
          KS := KBOT - NS + 1;
          HS := nil;
          SetLength(HS, NS * NS);
          for I := 0 to NS - 1 do
            for K := 0 to NS - 1 do
              HS[I * NS + K] := H[HO + (KS + I) * LDH + KS + K];
          ZDUM := nil;
          SetLength(ZDUM, 1);
          if RECURSIVE and (NS > NMIN) then
            DLAQR04(False, False, False, NS, 0, NS - 1, HS, 0, NS, WR, WI,
              WO + KS, 0, 0, ZDUM, 0, 1, LWORK, INF)
          else
            DLAHQR(False, False, NS, 0, NS - 1, HS, 0, NS, WR, WI, WO + KS,
              0, 0, ZDUM, 0, 1, INF);
          KS := KS + INF;
          { In case of a rare QR failure use eigenvalues of the trailing
            2-by-2 principal submatrix. }
          if KS >= KBOT then
          begin
            AA := H[HO + (KBOT - 1) * LDH + KBOT - 1];
            CC := H[HO + KBOT * LDH + KBOT - 1];
            BB := H[HO + (KBOT - 1) * LDH + KBOT];
            DD := H[HO + KBOT * LDH + KBOT];
            DLANV2(AA, BB, CC, DD, WR[WO + KBOT - 1], WI[WO + KBOT - 1],
              WR[WO + KBOT], WI[WO + KBOT], CS, SN);
            KS := KBOT - 1;
          end;
        end;
        if KBOT - KS + 1 > NS then
        begin
          { Sort the shifts (helps a little). Bubble sort keeps complex
            conjugate pairs together. }
          SORTED := False;
          K := KBOT;
          while (K >= KS + 1) and not SORTED do
          begin
            SORTED := True;
            for I := KS to K - 1 do
              if System.Abs(WR[WO + I]) + System.Abs(WI[WO + I]) <
                 System.Abs(WR[WO + I + 1]) + System.Abs(WI[WO + I + 1]) then
              begin
                SORTED := False;
                SWAP := WR[WO + I];
                WR[WO + I] := WR[WO + I + 1];
                WR[WO + I + 1] := SWAP;
                SWAP := WI[WO + I];
                WI[WO + I] := WI[WO + I + 1];
                WI[WO + I + 1] := SWAP;
              end;
            Dec(K);
          end;
        end;
        { Shuffle shifts into pairs of real shifts and pairs of complex
          conjugate shifts assuming complex conjugate shifts are already
          adjacent to one another. (Yes, they are.) }
        I := KBOT;
        while I >= KS + 2 do
        begin
          if WI[WO + I] <> -WI[WO + I - 1] then
          begin
            SWAP := WR[WO + I];
            WR[WO + I] := WR[WO + I - 1];
            WR[WO + I - 1] := WR[WO + I - 2];
            WR[WO + I - 2] := SWAP;
            SWAP := WI[WO + I];
            WI[WO + I] := WI[WO + I - 1];
            WI[WO + I - 1] := WI[WO + I - 2];
            WI[WO + I - 2] := SWAP;
          end;
          Dec(I, 2);
        end;
      end;
      { If there are only two shifts and both are real, then use only
        one. }
      if KBOT - KS + 1 = 2 then
        if WI[WO + KBOT] = 0 then
          if System.Abs(WR[WO + KBOT] - H[HO + KBOT * LDH + KBOT]) <
             System.Abs(WR[WO + KBOT - 1] - H[HO + KBOT * LDH + KBOT]) then
            WR[WO + KBOT - 1] := WR[WO + KBOT]
          else
            WR[WO + KBOT] := WR[WO + KBOT - 1];
      { Use up to NS of the smallest magnitude shifts. If there aren't NS
        shifts available, then use them all, possibly dropping one to make
        the number of shifts even. }
      NS := Min(NS, KBOT - KS + 1);
      NS := NS - NS mod 2;
      KS := KBOT - NS + 1;
      { Small-bulge multi-shift QR sweep. }
      DLAQR5(WANTT, WANTZ, KACC22, N, KTOP, KBOT, NS, WR, WI, WO + KS, H, HO,
        LDH, ILOZ, IHIZ, Z, ZO, LDZ);
    end;
    { Note progress (or the lack of it). }
    if LD > 0 then NDFL := 1 else Inc(NDFL);
  end;
  { Iteration limit exceeded. Set INFO to show where the problem occurred
    and exit. }
  INFO := KBOT + 1;
end;

{ DHSEQR with the work space LWORK of LAPACK, on which xLAQR0 and
  xLAQR3 depend. }
procedure HSEQRD(JOB, COMPZ: char; N, ILO, IHI: longint; var H: array of TReal;
  var WR, WI: array of TReal; var Z: array of TReal; LWORK: longint;
  out INFO: longint);
const
  { Matrices of order NTINY or smaller must be processed by DLAHQR
    because of insufficient subdiagonal scratch space. }
  NTINY = 15;
  { NL allocates some local workspace to help small matrices through a
    rare DLAHQR failure. NL > NTINY = 15 is required and NL <= NMIN =
    IPARMQ(12, ...) is recommended. }
  NL = 49;
var
  I, J, KBOT, NMIN: longint;
  WANTT, WANTZ: boolean;
  HL: array of TReal;
begin
  WANTT := JOB = 'S';
  WANTZ := COMPZ <> 'N';
  INFO := 0;
  { Quick return if possible. }
  if N = 0 then Exit;
  { Copy eigenvalues isolated by DGEBAL. }
  for I := 0 to ILO - 1 do
  begin
    WR[I] := H[I * N + I];
    WI[I] := 0;
  end;
  for I := IHI + 1 to N - 1 do
  begin
    WR[I] := H[I * N + I];
    WI[I] := 0;
  end;
  { Initialize Z, if requested. }
  if COMPZ = 'I' then
    for I := 0 to N - 1 do
      for J := 0 to N - 1 do
        if I = J then Z[I * N + J] := 1 else Z[I * N + J] := 0;
  { Quick return if possible. }
  if ILO = IHI then
  begin
    WR[ILO] := H[ILO * N + ILO];
    WI[ILO] := 0;
    Exit;
  end;
  { DLAHQR/DLAQR0 crossover point. }
  NMIN := IPARMQ(12, ILO, IHI);
  NMIN := Max(NTINY, NMIN);
  if N > NMIN then
    { DLAQR0 for big matrices. }
    DLAQR04(True, WANTT, WANTZ, N, ILO, IHI, H, 0, N, WR, WI, 0, ILO, IHI,
      Z, 0, N, LWORK, INFO)
  else
  begin
    { Small matrix. }
    DLAHQR(WANTT, WANTZ, N, ILO, IHI, H, 0, N, WR, WI, 0, ILO, IHI, Z, 0, N,
      INFO);
    if INFO > 0 then
    begin
      { A rare DLAHQR failure! DLAQR0 sometimes succeeds when DLAHQR
        fails. }
      KBOT := INFO - 1;
      if N >= NL then
        { Larger matrices have enough subdiagonal scratch space to call
          DLAQR0 directly. }
        DLAQR04(True, WANTT, WANTZ, N, ILO, KBOT, H, 0, N, WR, WI, 0, ILO,
          IHI, Z, 0, N, LWORK, INFO)
      else
      begin
        { Tiny matrices don't have enough subdiagonal scratch space to
          benefit from DLAQR0. Hence, tiny matrices must be copied into a
          larger array before calling DLAQR0. }
        HL := nil;
        SetLength(HL, NL * NL);
        for I := 0 to N - 1 do
          for J := 0 to N - 1 do HL[I * NL + J] := H[I * N + J];
        DLAQR04(True, WANTT, WANTZ, NL, ILO, KBOT, HL, 0, NL, WR, WI, 0, ILO,
          IHI, Z, 0, N, NL, INFO);
        if WANTT or (INFO <> 0) then
          for I := 0 to N - 1 do
            for J := 0 to N - 1 do H[I * N + J] := HL[I * NL + J];
      end;
    end;
  end;
  { Clear out the trash, if necessary. }
  if (WANTT or (INFO <> 0)) and (N > 2) then
    for I := 2 to N - 1 do
      for J := 0 to I - 2 do H[I * N + J] := 0;
end;

{ The deflation check of ZLAQR5 for H(K+1, K) after a reflection, as
  DLAQR5DEFL with CABS1. }
procedure ZLAQR5DEFL(var H: array of TComplex; HO, LDH, K, KTOP,
  KBOT: longint; SMLNUM, ULP: TReal);
var
  H11, H12, H21, H22, SCL, TST1, TST2: TReal;
begin
  if CABS1(H[HO + (K + 1) * LDH + K]) = 0 then Exit;
  TST1 := CABS1(H[HO + K * LDH + K]) + CABS1(H[HO + (K + 1) * LDH + K + 1]);
  if TST1 = 0 then
  begin
    if K >= KTOP + 1 then TST1 := TST1 + CABS1(H[HO + K * LDH + K - 1]);
    if K >= KTOP + 2 then TST1 := TST1 + CABS1(H[HO + K * LDH + K - 2]);
    if K >= KTOP + 3 then TST1 := TST1 + CABS1(H[HO + K * LDH + K - 3]);
    if K <= KBOT - 2 then TST1 := TST1 + CABS1(H[HO + (K + 2) * LDH + K + 1]);
    if K <= KBOT - 3 then TST1 := TST1 + CABS1(H[HO + (K + 3) * LDH + K + 1]);
    if K <= KBOT - 4 then TST1 := TST1 + CABS1(H[HO + (K + 4) * LDH + K + 1]);
  end;
  if CABS1(H[HO + (K + 1) * LDH + K]) <= Max(SMLNUM, ULP * TST1) then
  begin
    H12 := Max(CABS1(H[HO + (K + 1) * LDH + K]), CABS1(H[HO + K * LDH + K + 1]));
    H21 := Min(CABS1(H[HO + (K + 1) * LDH + K]), CABS1(H[HO + K * LDH + K + 1]));
    H11 := Max(CABS1(H[HO + (K + 1) * LDH + K + 1]),
      CABS1(H[HO + K * LDH + K] - H[HO + (K + 1) * LDH + K + 1]));
    H22 := Min(CABS1(H[HO + (K + 1) * LDH + K + 1]),
      CABS1(H[HO + K * LDH + K] - H[HO + (K + 1) * LDH + K + 1]));
    SCL := H11 + H12;
    TST2 := H22 * (H11 / SCL);
    if (TST2 = 0) or (H21 * (H12 / SCL) <= Max(SMLNUM, ULP * TST2)) then
      H[HO + (K + 1) * LDH + K] := 0;
  end;
end;

{ REFSUM = X1 + V2*X2 + V3*X3; Xk := Xk - REFSUM*Tk (k = 1, 2, 3): one
  application of a 3x3 reflector in ZLAQR5, written on the real and
  imaginary parts with the operations of the TComplex operators, which
  Free Pascal does not inline here. }
procedure ZAPPLY3(var X1, X2, X3: TComplex; const V2, V3, T1, T2,
  T3: TComplex); inline;
var
  SR, SI, R, I: TReal;
begin
  SR := X1.Re + (V2.Re * X2.Re - V2.Im * X2.Im);
  SI := X1.Im + (V2.Re * X2.Im + V2.Im * X2.Re);
  SR := SR + (V3.Re * X3.Re - V3.Im * X3.Im);
  SI := SI + (V3.Re * X3.Im + V3.Im * X3.Re);
  R := X1.Re - (SR * T1.Re - SI * T1.Im);
  I := X1.Im - (SR * T1.Im + SI * T1.Re);
  X1.Re := R;
  X1.Im := I;
  R := X2.Re - (SR * T2.Re - SI * T2.Im);
  I := X2.Im - (SR * T2.Im + SI * T2.Re);
  X2.Re := R;
  X2.Im := I;
  R := X3.Re - (SR * T3.Re - SI * T3.Im);
  I := X3.Im - (SR * T3.Im + SI * T3.Re);
  X3.Re := R;
  X3.Im := I;
end;

{ ZLAQR5: complex counterpart of DLAQR5 with the NSHFTS shifts
  S[SO..]. }
procedure ZLAQR5(WANTT, WANTZ: boolean; KACC22, N, KTOP, KBOT,
  NSHFTS: longint; var S: array of TComplex; SO: longint;
  var H: array of TComplex; HO, LDH, ILOZ, IHIZ: longint;
  var Z: array of TComplex; ZO, LDZ: longint);
var
  SMLNUM, ULP: TReal;
  ALPHA, BETA, REFSUM, T1, T2, T3, V1, V2, V3: TComplex;
  I, I2, I4, INCOL, J, JBOT, JCOL, JLEN, JROW, JTOP, K, K1, KDU, KMS,
    KRCOL, M, M22, MBOT, MTOP, NBMPS, NDCOL, NS, NU, LDU, MV: longint;
  ACCUM, BMP22: boolean;
  VT: array[0..2] of TComplex;
  V, U, WH, WV: array of TComplex;
begin
  { If there are no shifts, then there is nothing to do. }
  if NSHFTS < 2 then Exit;
  { If the active block is empty or 1-by-1, then there is nothing to do. }
  if KTOP >= KBOT then Exit;
  { NSHFTS is supposed to be even, but if it is odd, then simply reduce
    it by one. }
  NS := NSHFTS - NSHFTS mod 2;
  { Machine constants for deflation. }
  ULP := LapackPrecision;
  SMLNUM := LapackSafeMinimum * (N / ULP);
  { Use accumulated reflections to update far-from-diagonal entries? }
  ACCUM := (KACC22 = 1) or (KACC22 = 2);
  { Clear trash. }
  if KTOP + 2 <= KBOT then H[HO + (KTOP + 2) * LDH + KTOP] := 0;
  { NBMPS = number of 2-shift bulges in the chain. }
  NBMPS := NS div 2;
  { KDU = width of slab. }
  KDU := 4 * NBMPS;
  LDU := KDU;
  V := nil;
  SetLength(V, 3 * NBMPS);
  U := nil;
  if ACCUM then SetLength(U, KDU * KDU);
  { Create and chase chains of NBMPS bulges. V(0:2, m) is stored in
    V[3*(m-1)..3*(m-1)+2] for the 1-based bulge number m. }
  INCOL := KTOP - 2 * NBMPS + 1;
  while INCOL <= KBOT - 2 do
  begin
    { JTOP = index from which updates from the right start. }
    if ACCUM then JTOP := Max(KTOP, INCOL)
    else if WANTT then JTOP := 0
    else JTOP := KTOP;
    NDCOL := INCOL + KDU;
    if ACCUM then
      for I := 0 to KDU - 1 do
        for J := 0 to KDU - 1 do
          if I = J then U[I * LDU + J] := 1 else U[I * LDU + J] := 0;
    { Near-the-diagonal bulge chase (see DLAQR5). }
    for KRCOL := INCOL to Min(INCOL + 2 * NBMPS - 1, KBOT - 2) do
    begin
      { Bulges number MTOP to MBOT are active double implicit shift
        bulges. There may or may not also be small 2-by-2 bulge, if there
        is room. }
      MTOP := Max(1, (KTOP - KRCOL) div 2 + 1);
      MBOT := Min(NBMPS, (KBOT - KRCOL - 1) div 2);
      M22 := MBOT + 1;
      BMP22 := (MBOT < NBMPS) and (KRCOL + 2 * (M22 - 1) = KBOT - 2);
      { Generate reflections to chase the chain right one column. (The
        minimum value of K is KTOP-1.) }
      if BMP22 then
      begin
        { Special case: 2-by-2 reflection at bottom treated separately. }
        MV := 3 * (M22 - 1);
        K := KRCOL + 2 * (M22 - 1);
        if K = KTOP - 1 then
        begin
          ZLAQR1(2, H, HO + (K + 1) * LDH + K + 1, LDH, S[SO + 2 * M22 - 2],
            S[SO + 2 * M22 - 1], V, MV);
          BETA := V[MV];
          ZLARFG(2, BETA, V, MV + 1, 1, T1);
          V[MV] := T1;
        end else
        begin
          BETA := H[HO + (K + 1) * LDH + K];
          V[MV + 1] := H[HO + (K + 2) * LDH + K];
          ZLARFG(2, BETA, V, MV + 1, 1, T1);
          V[MV] := T1;
          H[HO + (K + 1) * LDH + K] := BETA;
          H[HO + (K + 2) * LDH + K] := 0;
        end;
        { Perform update from right within computational window. }
        V1 := V[MV];
        V2 := V[MV + 1];
        T1 := V1;
        T2 := T1 * CONJ(V2);
        for J := JTOP to Min(KBOT, K + 3) do
        begin
          REFSUM := H[HO + J * LDH + K + 1] + V2 * H[HO + J * LDH + K + 2];
          H[HO + J * LDH + K + 1] := H[HO + J * LDH + K + 1] - REFSUM * T1;
          H[HO + J * LDH + K + 2] := H[HO + J * LDH + K + 2] - REFSUM * T2;
        end;
        { Perform update from left within computational window. }
        if ACCUM then JBOT := Min(NDCOL, KBOT)
        else if WANTT then JBOT := N - 1
        else JBOT := KBOT;
        T1 := CONJ(V1);
        T2 := T1 * V2;
        for J := K + 1 to JBOT do
        begin
          REFSUM := H[HO + (K + 1) * LDH + J] + CONJ(V2) * H[HO + (K + 2) * LDH + J];
          H[HO + (K + 1) * LDH + J] := H[HO + (K + 1) * LDH + J] - REFSUM * T1;
          H[HO + (K + 2) * LDH + J] := H[HO + (K + 2) * LDH + J] - REFSUM * T2;
        end;
        { The following convergence test requires that the traditional
          small-compared-to-nearby-diagonals criterion and the Ahues &
          Kressner ultraconservative criterion are both satisfied. }
        if K >= KTOP then ZLAQR5DEFL(H, HO, LDH, K, KTOP, KBOT, SMLNUM, ULP);
        { Accumulate orthogonal transformations. }
        if ACCUM then
        begin
          KMS := K - INCOL - 1;
          for J := Max(0, KTOP - INCOL - 1) to KDU - 1 do
          begin
            REFSUM := V1 * (U[J * LDU + KMS + 1] + V2 * U[J * LDU + KMS + 2]);
            U[J * LDU + KMS + 1] := U[J * LDU + KMS + 1] - REFSUM;
            U[J * LDU + KMS + 2] := U[J * LDU + KMS + 2] - REFSUM * CONJ(V2);
          end;
        end else if WANTZ then
          for J := ILOZ to IHIZ do
          begin
            REFSUM := V1 * (Z[ZO + J * LDZ + K + 1] + V2 * Z[ZO + J * LDZ + K + 2]);
            Z[ZO + J * LDZ + K + 1] := Z[ZO + J * LDZ + K + 1] - REFSUM;
            Z[ZO + J * LDZ + K + 2] := Z[ZO + J * LDZ + K + 2] - REFSUM * CONJ(V2);
          end;
      end;
      { Normal case: chain of 3-by-3 reflections. }
      for M := MBOT downto MTOP do
      begin
        MV := 3 * (M - 1);
        K := KRCOL + 2 * (M - 1);
        if K = KTOP - 1 then
        begin
          ZLAQR1(3, H, HO + KTOP * LDH + KTOP, LDH, S[SO + 2 * M - 2],
            S[SO + 2 * M - 1], V, MV);
          ALPHA := V[MV];
          ZLARFG(3, ALPHA, V, MV + 1, 1, T1);
          V[MV] := T1;
        end else
        begin
          { Perform delayed transformation of row below Mth bulge.
            Exploit fact that first two elements of row are actually
            zero. }
          T1 := V[MV];
          T2 := T1 * CONJ(V[MV + 1]);
          T3 := T1 * CONJ(V[MV + 2]);
          REFSUM := V[MV + 2] * H[HO + (K + 3) * LDH + K + 2];
          H[HO + (K + 3) * LDH + K] := -REFSUM * T1;
          H[HO + (K + 3) * LDH + K + 1] := -REFSUM * T2;
          H[HO + (K + 3) * LDH + K + 2] := H[HO + (K + 3) * LDH + K + 2] - REFSUM * T3;
          { Calculate reflection to move Mth bulge one step. }
          BETA := H[HO + (K + 1) * LDH + K];
          V[MV + 1] := H[HO + (K + 2) * LDH + K];
          V[MV + 2] := H[HO + (K + 3) * LDH + K];
          ZLARFG(3, BETA, V, MV + 1, 1, T1);
          V[MV] := T1;
          { A bulge may collapse because of vigilant deflation or
            destructive underflow. In the underflow case, try the
            two-small-subdiagonals trick to try to reinflate the bulge. }
          if (CABS1(H[HO + (K + 3) * LDH + K]) <> 0) or
             (CABS1(H[HO + (K + 3) * LDH + K + 1]) <> 0) or
             (CABS1(H[HO + (K + 3) * LDH + K + 2]) = 0) then
          begin
            { Typical case: not collapsed (yet). }
            H[HO + (K + 1) * LDH + K] := BETA;
            H[HO + (K + 2) * LDH + K] := 0;
            H[HO + (K + 3) * LDH + K] := 0;
          end else
          begin
            { Atypical case: collapsed. Attempt to reintroduce ignoring
              H(K+1,K) and H(K,K). If the fill resulting from the new
              reflector is too large, then abandon it. Otherwise, use the
              new one. }
            ZLAQR1(3, H, HO + (K + 1) * LDH + K + 1, LDH, S[SO + 2 * M - 2],
              S[SO + 2 * M - 1], VT, 0);
            ALPHA := VT[0];
            ZLARFG(3, ALPHA, VT, 1, 1, T1);
            VT[0] := T1;
            T1 := CONJ(VT[0]);
            T2 := T1 * VT[1];
            T3 := T1 * VT[2];
            REFSUM := H[HO + (K + 1) * LDH + K] + CONJ(VT[1]) * H[HO + (K + 2) * LDH + K];
            if CABS1(H[HO + (K + 2) * LDH + K] - REFSUM * T2) +
               CABS1(REFSUM * T3) > ULP * (CABS1(H[HO + K * LDH + K]) +
               CABS1(H[HO + (K + 1) * LDH + K + 1]) +
               CABS1(H[HO + (K + 2) * LDH + K + 2])) then
            begin
              { Starting a new bulge here would create non-negligible
                fill. Use the old one with trepidation. }
              H[HO + (K + 1) * LDH + K] := BETA;
              H[HO + (K + 2) * LDH + K] := 0;
              H[HO + (K + 3) * LDH + K] := 0;
            end else
            begin
              { Starting a new bulge here would create only negligible
                fill. Replace the old reflector with the new one. }
              H[HO + (K + 1) * LDH + K] := H[HO + (K + 1) * LDH + K] - REFSUM * T1;
              H[HO + (K + 2) * LDH + K] := 0;
              H[HO + (K + 3) * LDH + K] := 0;
              V[MV] := VT[0];
              V[MV + 1] := VT[1];
              V[MV + 2] := VT[2];
            end;
          end;
        end;
        { Apply reflection from the right and the first column of update
          from the left. These updates are required for the vigilant
          deflation check. We still delay most of the updates from the
          left for efficiency. }
        V1 := V[MV];
        V2 := V[MV + 1];
        V3 := V[MV + 2];
        T1 := V1;
        T2 := T1 * CONJ(V2);
        T3 := T1 * CONJ(V3);
        for J := JTOP to Min(KBOT, K + 3) do
          ZAPPLY3(H[HO + J * LDH + K + 1], H[HO + J * LDH + K + 2],
            H[HO + J * LDH + K + 3], V2, V3, T1, T2, T3);
        { Perform update from left for subsequent column. }
        T1 := CONJ(V1);
        T2 := T1 * V2;
        T3 := T1 * V3;
        REFSUM := H[HO + (K + 1) * LDH + K + 1] + CONJ(V2) * H[HO + (K + 2) * LDH + K + 1] +
          CONJ(V3) * H[HO + (K + 3) * LDH + K + 1];
        H[HO + (K + 1) * LDH + K + 1] := H[HO + (K + 1) * LDH + K + 1] - REFSUM * T1;
        H[HO + (K + 2) * LDH + K + 1] := H[HO + (K + 2) * LDH + K + 1] - REFSUM * T2;
        H[HO + (K + 3) * LDH + K + 1] := H[HO + (K + 3) * LDH + K + 1] - REFSUM * T3;
        { The following convergence test requires that the traditional
          small-compared-to-nearby-diagonals criterion and the Ahues &
          Kressner ultraconservative criterion are both satisfied. }
        if K < KTOP then Continue;
        ZLAQR5DEFL(H, HO, LDH, K, KTOP, KBOT, SMLNUM, ULP);
      end;
      { Multiply H by reflections from the left. }
      if ACCUM then JBOT := Min(NDCOL, KBOT)
      else if WANTT then JBOT := N - 1
      else JBOT := KBOT;
      for M := MBOT downto MTOP do
      begin
        MV := 3 * (M - 1);
        K := KRCOL + 2 * (M - 1);
        V2 := CONJ(V[MV + 1]);
        V3 := CONJ(V[MV + 2]);
        T1 := CONJ(V[MV]);
        T2 := T1 * V[MV + 1];
        T3 := T1 * V[MV + 2];
        for J := Max(KTOP, KRCOL + 2 * M) to JBOT do
          ZAPPLY3(H[HO + (K + 1) * LDH + J], H[HO + (K + 2) * LDH + J],
            H[HO + (K + 3) * LDH + J], V2, V3, T1, T2, T3);
      end;
      { Accumulate orthogonal transformations. }
      if ACCUM then
      begin
        { Accumulate U. (If needed, update Z later with an efficient
          matrix-matrix multiply.) }
        for M := MBOT downto MTOP do
        begin
          MV := 3 * (M - 1);
          K := KRCOL + 2 * (M - 1);
          KMS := K - INCOL - 1;
          I2 := Max(0, KTOP - INCOL - 1);
          I2 := Max(I2, KMS + 1 - (KRCOL - INCOL));
          I4 := Min(KDU, KRCOL + 2 * (MBOT - 1) - INCOL + 5) - 1;
          V2 := V[MV + 1];
          V3 := V[MV + 2];
          T1 := V[MV];
          T2 := T1 * CONJ(V2);
          T3 := T1 * CONJ(V3);
          for J := I2 to I4 do
            ZAPPLY3(U[J * LDU + KMS + 1], U[J * LDU + KMS + 2],
              U[J * LDU + KMS + 3], V2, V3, T1, T2, T3);
        end;
      end else if WANTZ then
      begin
        { U is not accumulated, so update Z now by multiplying by
          reflections from the right. }
        for M := MBOT downto MTOP do
        begin
          MV := 3 * (M - 1);
          K := KRCOL + 2 * (M - 1);
          V2 := V[MV + 1];
          V3 := V[MV + 2];
          T1 := V[MV];
          T2 := T1 * CONJ(V2);
          T3 := T1 * CONJ(V3);
          for J := ILOZ to IHIZ do
            ZAPPLY3(Z[ZO + J * LDZ + K + 1], Z[ZO + J * LDZ + K + 2],
              Z[ZO + J * LDZ + K + 3], V2, V3, T1, T2, T3);
        end;
      end;
    end;
    { Use U (if accumulated) to update far-from-diagonal entries in H. If
      required, use U to update Z as well. }
    if ACCUM then
    begin
      if WANTT then
      begin
        JTOP := 0;
        JBOT := N - 1;
      end else
      begin
        JTOP := KTOP;
        JBOT := KBOT;
      end;
      K1 := Max(1, KTOP - INCOL);
      NU := (KDU - Max(0, NDCOL - KBOT)) - K1 + 1;
      { Horizontal multiply. }
      JCOL := Min(NDCOL, KBOT) + 1;
      if JCOL <= JBOT then
      begin
        JLEN := JBOT - JCOL + 1;
        WH := nil;
        SetLength(WH, NU * JLEN);
        ZGEMM('C', 'N', NU, JLEN, NU, FONE, U, (K1 - 1) * LDU + K1 - 1, LDU, H,
          HO + (INCOL + K1) * LDH + JCOL, LDH, FZERO, WH, 0, JLEN);
        for I := 0 to NU - 1 do
          for J := 0 to JLEN - 1 do
            H[HO + (INCOL + K1 + I) * LDH + JCOL + J] := WH[I * JLEN + J];
      end;
      { Vertical multiply. }
      JROW := JTOP;
      if JROW <= Max(KTOP, INCOL) - 1 then
      begin
        JLEN := Max(KTOP, INCOL) - JROW;
        WV := nil;
        SetLength(WV, JLEN * NU);
        ZGEMM('N', 'N', JLEN, NU, NU, FONE, H, HO + JROW * LDH + INCOL + K1,
          LDH, U, (K1 - 1) * LDU + K1 - 1, LDU, FZERO, WV, 0, NU);
        for I := 0 to JLEN - 1 do
          for J := 0 to NU - 1 do
            H[HO + (JROW + I) * LDH + INCOL + K1 + J] := WV[I * NU + J];
      end;
      { Z multiply (also vertical). }
      if WANTZ and (ILOZ <= IHIZ) then
      begin
        JLEN := IHIZ - ILOZ + 1;
        WV := nil;
        SetLength(WV, JLEN * NU);
        ZGEMM('N', 'N', JLEN, NU, NU, FONE, Z, ZO + ILOZ * LDZ + INCOL + K1,
          LDZ, U, (K1 - 1) * LDU + K1 - 1, LDU, FZERO, WV, 0, NU);
        for I := 0 to JLEN - 1 do
          for J := 0 to NU - 1 do
            Z[ZO + (ILOZ + I) * LDZ + INCOL + K1 + J] := WV[I * NU + J];
      end;
    end;
    Inc(INCOL, 2 * NBMPS);
  end;
end;

procedure ZLAQR04(RECURSIVE, WANTT, WANTZ: boolean; N, ILO, IHI: longint;
  var H: array of TComplex; HO, LDH: longint; var W: array of TComplex;
  WO, ILOZ, IHIZ: longint; var Z: array of TComplex; ZO, LDZ: longint; LWORK: longint;
  out INFO: longint); forward;

{ ZLAQR3 (RECURSIVE) and ZLAQR2: complex counterparts of DLAQR3 and
  DLAQR2; the shifts are returned in SH[SO + KBOT - ND - NS + 1 ..]. }
procedure ZLAQR23(RECURSIVE, WANTT, WANTZ: boolean; N, KTOP, KBOT,
  NW: longint; var H: array of TComplex; HO, LDH, ILOZ, IHIZ: longint;
  var Z: array of TComplex; ZO, LDZ: longint; out NS, ND: longint;
  var SH: array of TComplex; SO: longint; LWORK: longint);
var
  FOO, SMLNUM, ULP: TReal;
  BETA, S, TAU: TComplex;
  I, IFST, ILST, INFQR, J, JW, KCOL, KLN, KNT, KROW, KWTOP, LTOP,
    NMIN: longint;
  T, V, WORK, WORK2, TAUH, WV: array of TComplex;
begin
  NS := 0;
  ND := 0;
  { Quick return if possible. }
  if KTOP > KBOT then Exit;
  if NW < 1 then Exit;
  { Machine constants. }
  ULP := LapackPrecision;
  SMLNUM := LapackSafeMinimum * (N / ULP);
  { Setup deflation window. }
  JW := Min(NW, KBOT - KTOP + 1);
  KWTOP := KBOT - JW + 1;
  if KWTOP = KTOP then S := 0
  else S := H[HO + KWTOP * LDH + KWTOP - 1];
  if KBOT = KWTOP then
  begin
    { 1-by-1 deflation window: not much to do. }
    SH[SO + KWTOP] := H[HO + KWTOP * LDH + KWTOP];
    NS := 1;
    ND := 0;
    if CABS1(S) <= Max(SMLNUM, ULP * CABS1(H[HO + KWTOP * LDH + KWTOP])) then
    begin
      NS := 0;
      ND := 1;
      if KWTOP > KTOP then H[HO + KWTOP * LDH + KWTOP - 1] := 0;
    end;
    Exit;
  end;
  { Convert to spike-triangular form. (In case of a rare QR failure, this
    routine continues to do aggressive early deflation using that part of
    the deflation window that converged using INFQR here and there to keep
    track.) }
  T := nil;
  SetLength(T, JW * JW);
  for I := 0 to JW - 1 do
    for J := Max(I - 1, 0) to JW - 1 do
      T[I * JW + J] := H[HO + (KWTOP + I) * LDH + KWTOP + J];
  V := nil;
  SetLength(V, JW * JW);
  for I := 0 to JW - 1 do V[I * JW + I] := 1;
  NMIN := IPARMQ(12, 0, JW - 1);
  if RECURSIVE and (JW > NMIN) then
    ZLAQR04(False, True, True, JW, 0, JW - 1, T, 0, JW, SH, SO + KWTOP, 0,
      JW - 1, V, 0, JW, LWORK, INFQR)
  else
    ZLAHQR(True, True, JW, 0, JW - 1, T, 0, JW, SH, SO + KWTOP, 0, JW - 1,
      V, 0, JW, INFQR);
  { Deflation check. }
  NS := JW;
  ILST := INFQR;
  for KNT := INFQR to JW - 1 do
  begin
    { Small spike tip deflation test. }
    FOO := CABS1(T[(NS - 1) * JW + NS - 1]);
    if FOO = 0 then FOO := CABS1(S);
    if CABS1(S) * CABS1(V[NS - 1]) <= Max(SMLNUM, ULP * FOO) then
      { One more converged eigenvalue. }
      Dec(NS)
    else
    begin
      { One undeflatable eigenvalue. Move it up out of the way. (ZTREXC
        can not fail in this case.) }
      IFST := NS - 1;
      ZTREXC(JW, T, V, IFST, ILST);
      Inc(ILST);
    end;
  end;
  { Return to Hessenberg form. }
  if NS = 0 then S := 0;
  if NS < JW then
  begin
    { Sorting the diagonal of T improves accuracy for graded matrices. }
    for I := INFQR to NS - 1 do
    begin
      IFST := I;
      for J := I + 1 to NS - 1 do
        if CABS1(T[J * JW + J]) > CABS1(T[IFST * JW + IFST]) then IFST := J;
      ILST := I;
      if IFST <> ILST then ZTREXC(JW, T, V, IFST, ILST);
    end;
  end;
  { Restore shift/eigenvalue array from T. }
  for I := INFQR to JW - 1 do SH[SO + KWTOP + I] := T[I * JW + I];
  if (NS < JW) or (CABS1(S) = 0) then
  begin
    if (NS > 1) and (CABS1(S) <> 0) then
    begin
      { Reflect spike back into lower triangle. }
      WORK := nil;
      SetLength(WORK, JW);
      for I := 0 to NS - 1 do WORK[I] := CONJ(V[I]);
      BETA := WORK[0];
      ZLARFG(NS, BETA, WORK, 1, 1, TAU);
      WORK[0] := BETA;
      for J := 0 to JW - 3 do
        for I := J + 2 to JW - 1 do T[I * JW + J] := 0;
      WORK2 := nil;
      SetLength(WORK2, 2 * JW);
      specialize LARF1F<TComplex>(True, NS, JW, WORK, 0, 1, CONJ(TAU), T, 0,
        JW, WORK2);
      specialize LARF1F<TComplex>(False, NS, NS, WORK, 0, 1, TAU, T, 0, JW,
        WORK2);
      specialize LARF1F<TComplex>(False, JW, NS, WORK, 0, 1, TAU, V, 0, JW,
        WORK2);
      TAUH := nil;
      SetLength(TAUH, JW);
      GEHRDZ(JW, 0, NS - 1, T, TAUH, LWORK - JW);
    end;
    { Copy updated reduced window into place. }
    if KWTOP > 0 then H[HO + KWTOP * LDH + KWTOP - 1] := S * CONJ(V[0]);
    for I := 0 to JW - 1 do
      for J := Max(I - 1, 0) to JW - 1 do
        H[HO + (KWTOP + I) * LDH + KWTOP + J] := T[I * JW + J];
    { Accumulate orthogonal matrix in order update H and Z, if requested. }
    if (NS > 1) and (CABS1(S) <> 0) then
      ORMQRZ(JW, NS - 1, NS - 1, T, JW, JW, TAUH, V, 1, JW, LWORK - JW);
    { Update vertical slab in H. }
    if WANTT then LTOP := 0 else LTOP := KTOP;
    KLN := KWTOP - LTOP;
    if KLN > 0 then
    begin
      KROW := LTOP;
      WV := nil;
      SetLength(WV, KLN * JW);
      ZGEMM('N', 'N', KLN, JW, JW, FONE, H, HO + KROW * LDH + KWTOP, LDH, V, 0,
        JW, FZERO, WV, 0, JW);
      for I := 0 to KLN - 1 do
        for J := 0 to JW - 1 do
          H[HO + (KROW + I) * LDH + KWTOP + J] := WV[I * JW + J];
    end;
    { Update horizontal slab in H. }
    if WANTT then
    begin
      KCOL := KBOT + 1;
      KLN := N - KCOL;
      if KLN > 0 then
      begin
        WV := nil;
        SetLength(WV, JW * KLN);
        ZGEMM('C', 'N', JW, KLN, JW, FONE, V, 0, JW, H,
          HO + KWTOP * LDH + KCOL, LDH, FZERO, WV, 0, KLN);
        for I := 0 to JW - 1 do
          for J := 0 to KLN - 1 do
            H[HO + (KWTOP + I) * LDH + KCOL + J] := WV[I * KLN + J];
      end;
    end;
    { Update vertical slab in Z. }
    if WANTZ then
    begin
      KLN := IHIZ - ILOZ + 1;
      if KLN > 0 then
      begin
        WV := nil;
        SetLength(WV, KLN * JW);
        ZGEMM('N', 'N', KLN, JW, JW, FONE, Z, ZO + ILOZ * LDZ + KWTOP, LDZ, V,
          0, JW, FZERO, WV, 0, JW);
        for I := 0 to KLN - 1 do
          for J := 0 to JW - 1 do
            Z[ZO + (ILOZ + I) * LDZ + KWTOP + J] := WV[I * JW + J];
      end;
    end;
  end;
  { Return the number of deflations. }
  ND := JW - NS;
  { ... and the number of shifts. (Subtracting INFQR from the spike
    length takes care of the case of a rare QR failure while calculating
    eigenvalues of the deflation window.) }
  NS := NS - INFQR;
end;

{ ZLAQR0 (RECURSIVE) and ZLAQR4: complex counterparts of DLAQR0 and
  DLAQR4, with the same workspace convention. }
procedure ZLAQR04(RECURSIVE, WANTT, WANTZ: boolean; N, ILO, IHI: longint;
  var H: array of TComplex; HO, LDH: longint; var W: array of TComplex;
  WO, ILOZ, IHIZ: longint; var Z: array of TComplex; ZO, LDZ: longint; LWORK: longint;
  out INFO: longint);
const
  NTINY = 15;
  KEXNW = 5;
  KEXSH = 6;
  WILK1: TReal = 0.75;
var
  S: TReal;
  AA, BB, CC, DD, DET, RTDISC, SWAP, TR2: TComplex;
  I, INF, IT, ITMAX, K, KACC22, KBOT, KS, KTOP, KWTOP, LD, LS, NDEC,
    NDFL, NH, NIBBLE, NMIN, NS, NSMAX, NSR, NW, NWMAX, NWR, NWUPBD: longint;
  SORTED: boolean;
  HS, ZDUM: array of TComplex;
begin
  INFO := 0;
  { Quick return for N = 0: nothing to do. }
  if N = 0 then Exit;
  if N <= NTINY then
  begin
    { Tiny matrices must use ZLAHQR. }
    ZLAHQR(WANTT, WANTZ, N, ILO, IHI, H, HO, LDH, W, WO, ILOZ, IHIZ, Z, ZO,
      LDZ, INFO);
    Exit;
  end;
  { Use small bulge multi-shift QR with aggressive early deflation on
    larger-than-tiny matrices. Hope for the best. }
  NWR := IPARMQ(13, ILO, IHI);
  NWR := Max(2, NWR);
  NWR := Min(Min(IHI - ILO + 1, (N - 1) div 3), NWR);
  NSR := IPARMQ(15, ILO, IHI);
  NSR := Min(Min(NSR, (N - 3) div 6), IHI - ILO);
  NSR := Max(2, NSR - NSR mod 2);
  NMIN := IPARMQ(12, ILO, IHI);
  NMIN := Max(NTINY, NMIN);
  NIBBLE := IPARMQ(14, ILO, IHI);
  NIBBLE := Max(0, NIBBLE);
  KACC22 := IPARMQ(16, ILO, IHI);
  KACC22 := Max(0, KACC22);
  KACC22 := Min(2, KACC22);
  NWMAX := Min((N - 1) div 3, LWORK div 2);
  NW := NWMAX;
  NSMAX := Min((N - 3) div 6, 2 * LWORK div 3);
  NSMAX := NSMAX - NSMAX mod 2;
  NDFL := 1;
  NDEC := 0;
  ITMAX := Max(30, 2 * KEXSH) * Max(10, IHI - ILO + 1);
  KBOT := IHI;
  { Main loop. }
  for IT := 1 to ITMAX do
  begin
    { Done when KBOT falls below ILO. }
    if KBOT < ILO then Exit;
    { Locate active block. }
    K := KBOT;
    while K >= ILO + 1 do
    begin
      if CABS1(H[HO + K * LDH + K - 1]) = 0 then Break;
      Dec(K);
    end;
    KTOP := K;
    { Select deflation window size (see DLAQR0). }
    NH := KBOT - KTOP + 1;
    NWUPBD := Min(NH, NWMAX);
    if NDFL < KEXNW then
      NW := Min(NWUPBD, NWR)
    else
      NW := Min(NWUPBD, 2 * NW);
    if NW < NWMAX then
    begin
      if NW >= NH - 1 then
        NW := NH
      else
      begin
        KWTOP := KBOT - NW + 1;
        if CABS1(H[HO + KWTOP * LDH + KWTOP - 1]) >
           CABS1(H[HO + (KWTOP - 1) * LDH + KWTOP - 2]) then Inc(NW);
      end;
    end;
    if NDFL < KEXNW then
      NDEC := -1
    else if (NDEC >= 0) or (NW >= NWUPBD) then
    begin
      Inc(NDEC);
      if NW - NDEC < 2 then NDEC := 0;
      NW := NW - NDEC;
    end;
    { Aggressive early deflation. }
    ZLAQR23(RECURSIVE, WANTT, WANTZ, N, KTOP, KBOT, NW, H, HO, LDH, ILOZ,
      IHIZ, Z, ZO, LDZ, LS, LD, W, WO, LWORK);
    { Adjust KBOT accounting for new deflations. }
    KBOT := KBOT - LD;
    { KS points to the shifts. }
    KS := KBOT - LS + 1;
    { Skip an expensive QR sweep if there is a (partly heuristic) reason
      to expect that many eigenvalues will deflate without it. }
    if (LD = 0) or ((100 * LD <= NW * NIBBLE) and
       (KBOT - KTOP + 1 > Min(NMIN, NWMAX))) then
    begin
      { NS = nominal number of simultaneous shifts. }
      NS := Min(Min(NSMAX, NSR), Max(2, KBOT - KTOP));
      NS := NS - NS mod 2;
      { If there have been no deflations in a multiple of KEXSH
        iterations, then try exceptional shifts. }
      if NDFL mod KEXSH = 0 then
      begin
        KS := KBOT - NS + 1;
        I := KBOT;
        while I >= KS + 1 do
        begin
          W[WO + I] := FADD(H[HO + I * LDH + I], WILK1 * CABS1(H[HO + I * LDH + I - 1]));
          W[WO + I - 1] := W[WO + I];
          Dec(I, 2);
        end;
      end else
      begin
        { Got NS/2 or fewer shifts? Use ZLAQR4 or ZLAHQR on a trailing
          principal submatrix to get more. }
        if KBOT - KS + 1 <= NS div 2 then
        begin
          KS := KBOT - NS + 1;
          HS := nil;
          SetLength(HS, NS * NS);
          for I := 0 to NS - 1 do
            for K := 0 to NS - 1 do
              HS[I * NS + K] := H[HO + (KS + I) * LDH + KS + K];
          ZDUM := nil;
          SetLength(ZDUM, 1);
          if RECURSIVE and (NS > NMIN) then
            ZLAQR04(False, False, False, NS, 0, NS - 1, HS, 0, NS, W, WO + KS,
              0, 0, ZDUM, 0, 1, LWORK, INF)
          else
            ZLAHQR(False, False, NS, 0, NS - 1, HS, 0, NS, W, WO + KS, 0, 0,
              ZDUM, 0, 1, INF);
          KS := KS + INF;
          { In case of a rare QR failure use eigenvalues of the trailing
            2-by-2 principal submatrix. Scale to avoid overflows,
            underflows and subnormals. (The scale factor S can not be
            zero, because H(KBOT,KBOT-1) is nonzero.) }
          if KS >= KBOT then
          begin
            S := CABS1(H[HO + (KBOT - 1) * LDH + KBOT - 1]) +
              CABS1(H[HO + KBOT * LDH + KBOT - 1]) +
              CABS1(H[HO + (KBOT - 1) * LDH + KBOT]) +
              CABS1(H[HO + KBOT * LDH + KBOT]);
            AA := FDIV(H[HO + (KBOT - 1) * LDH + KBOT - 1], S);
            CC := FDIV(H[HO + KBOT * LDH + KBOT - 1], S);
            BB := FDIV(H[HO + (KBOT - 1) * LDH + KBOT], S);
            DD := FDIV(H[HO + KBOT * LDH + KBOT], S);
            TR2 := FDIV(AA + DD, 2);
            DET := (AA - TR2) * (DD - TR2) - BB * CC;
            RTDISC := ZSQRT(-DET);
            W[WO + KBOT - 1] := FMUL(S, TR2 + RTDISC);
            W[WO + KBOT] := FMUL(S, TR2 - RTDISC);
            KS := KBOT - 1;
          end;
        end;
        if KBOT - KS + 1 > NS then
        begin
          { Sort the shifts (helps a little). }
          SORTED := False;
          K := KBOT;
          while (K >= KS + 1) and not SORTED do
          begin
            SORTED := True;
            for I := KS to K - 1 do
              if CABS1(W[WO + I]) < CABS1(W[WO + I + 1]) then
              begin
                SORTED := False;
                SWAP := W[WO + I];
                W[WO + I] := W[WO + I + 1];
                W[WO + I + 1] := SWAP;
              end;
            Dec(K);
          end;
        end;
      end;
      { If there are only two shifts, then use only one. }
      if KBOT - KS + 1 = 2 then
        if CABS1(W[WO + KBOT] - H[HO + KBOT * LDH + KBOT]) <
           CABS1(W[WO + KBOT - 1] - H[HO + KBOT * LDH + KBOT]) then
          W[WO + KBOT - 1] := W[WO + KBOT]
        else
          W[WO + KBOT] := W[WO + KBOT - 1];
      { Use up to NS of the smallest magnitude shifts. If there aren't NS
        shifts available, then use them all, possibly dropping one to make
        the number of shifts even. }
      NS := Min(NS, KBOT - KS + 1);
      NS := NS - NS mod 2;
      KS := KBOT - NS + 1;
      { Small-bulge multi-shift QR sweep. }
      ZLAQR5(WANTT, WANTZ, KACC22, N, KTOP, KBOT, NS, W, WO + KS, H, HO, LDH,
        ILOZ, IHIZ, Z, ZO, LDZ);
    end;
    { Note progress (or the lack of it). }
    if LD > 0 then NDFL := 1 else Inc(NDFL);
  end;
  { Iteration limit exceeded. Set INFO to show where the problem occurred
    and exit. }
  INFO := KBOT + 1;
end;

{ ZHSEQR with the work space LWORK of LAPACK. }
procedure HSEQRZ(JOB, COMPZ: char; N, ILO, IHI: longint;
  var H: array of TComplex; var W: array of TComplex; var Z: array of TComplex;
  LWORK: longint; out INFO: longint);
const
  NTINY = 15;
  NL = 49;
var
  I, J, KBOT, NMIN: longint;
  WANTT, WANTZ: boolean;
  HL: array of TComplex;
begin
  WANTT := JOB = 'S';
  WANTZ := COMPZ <> 'N';
  INFO := 0;
  { Quick return if possible. }
  if N = 0 then Exit;
  { Copy eigenvalues isolated by ZGEBAL. }
  for I := 0 to ILO - 1 do W[I] := H[I * N + I];
  for I := IHI + 1 to N - 1 do W[I] := H[I * N + I];
  { Initialize Z, if requested. }
  if COMPZ = 'I' then
    for I := 0 to N - 1 do
      for J := 0 to N - 1 do
        if I = J then Z[I * N + J] := 1 else Z[I * N + J] := 0;
  { Quick return if possible. }
  if ILO = IHI then
  begin
    W[ILO] := H[ILO * N + ILO];
    Exit;
  end;
  { ZLAHQR/ZLAQR0 crossover point. }
  NMIN := IPARMQ(12, ILO, IHI);
  NMIN := Max(NTINY, NMIN);
  if N > NMIN then
    ZLAQR04(True, WANTT, WANTZ, N, ILO, IHI, H, 0, N, W, 0, ILO, IHI, Z, 0,
      N, LWORK, INFO)
  else
  begin
    { Small matrix. }
    ZLAHQR(WANTT, WANTZ, N, ILO, IHI, H, 0, N, W, 0, ILO, IHI, Z, 0, N, INFO);
    if INFO > 0 then
    begin
      { A rare ZLAHQR failure! ZLAQR0 sometimes succeeds when ZLAHQR
        fails. }
      KBOT := INFO - 1;
      if N >= NL then
        ZLAQR04(True, WANTT, WANTZ, N, ILO, KBOT, H, 0, N, W, 0, ILO, IHI, Z,
          0, N, LWORK, INFO)
      else
      begin
        { Tiny matrices must be copied into a larger array before calling
          ZLAQR0. }
        HL := nil;
        SetLength(HL, NL * NL);
        for I := 0 to N - 1 do
          for J := 0 to N - 1 do HL[I * NL + J] := H[I * N + J];
        ZLAQR04(True, WANTT, WANTZ, NL, ILO, KBOT, HL, 0, NL, W, 0, ILO, IHI,
          Z, 0, N, NL, INFO);
        if WANTT or (INFO <> 0) then
          for I := 0 to N - 1 do
            for J := 0 to N - 1 do H[I * N + J] := HL[I * NL + J];
      end;
    end;
  end;
  { Clear out the trash, if necessary. }
  if (WANTT or (INFO <> 0)) and (N > 2) then
    for I := 2 to N - 1 do
      for J := 0 to I - 2 do H[I * N + J] := 0;
end;

procedure DLARTG(F, G: TReal; out CS, SN, R: TReal);
const
  SAFMIN: TReal = 2.2250738585072014E-308; { 2^-1022 }
  SAFMAX: TReal = 4.49423283715579E+307; { 2^1022 }
var
  F1, G1, D, U, FS, GS, RTMIN, RTMAX: TReal;
begin
  RTMIN := Sqrt(SAFMIN);
  RTMAX := Sqrt(SAFMAX / 2);
  F1 := System.Abs(F);
  G1 := System.Abs(G);
  if G = 0 then
  begin
    CS := 1;
    SN := 0;
    R := F;
  end else if F = 0 then
  begin
    CS := 0;
    SN := SIGN(1, G);
    R := G1;
  end else if (F1 > RTMIN) and (F1 < RTMAX) and (G1 > RTMIN) and (G1 < RTMAX) then
  begin
    D := Sqrt(F * F + G * G);
    CS := F1 / D;
    R := SIGN(D, F);
    SN := G / R;
  end else
  begin
    U := Min(SAFMAX, Max(SAFMIN, Max(F1, G1)));
    FS := F / U;
    GS := G / U;
    D := Sqrt(FS * FS + GS * GS);
    CS := System.Abs(FS) / D;
    R := SIGN(D, F);
    SN := GS / R;
    R := R * U;
  end;
end;

{ ---------------------------------------------------------------------
  LU factorization, solution and inverse (LAPACK 3.12.1). The block size
  of xGETRF, xGETRI and xTRTRI is 64, the value of ILAENV, unless
  LapackBlockSize sets another.
  --------------------------------------------------------------------- }

{ ILAENV(1, 'xGETRF'), ILAENV(1, 'xGETRI') and ILAENV(1, 'xTRTRI'). }
function LapackBlockLU: longint;
begin
  if LapackBlockSize < 0 then result := 64 else result := LapackBlockSize;
end;

{ |x|: ABS of Fortran, the modulus of a complex number. }
function ABSX(const AValue: TReal): TReal; overload; inline;
begin
  result := System.Abs(AValue);
end;

function ABSX(const AValue: TComplex): TReal; overload; inline;
begin
  result := ZABS(AValue);
end;

{ DLASWP, ZLASWP: the row interchanges IPIV[IPO+K1..IPO+K2] (0-based
  row indices of A) applied to the N columns of A, forward for INCX = 1 and
  backward for INCX = -1. The reference routine works on blocks of 32
  columns, with the same interchanges in each. }
generic procedure LASWP<T>(N: longint; var A: array of T; AO, LDA: longint;
  K1, K2: longint; const IPIV: array of longint; IPO, INCX: longint);
var
  I, IP, K: longint;
  TEMP: T;
begin
  if INCX = 0 then Exit;
  I := K1;
  if INCX < 0 then I := K2;
  while (INCX > 0) and (I <= K2) or (INCX < 0) and (I >= K1) do
  begin
    IP := IPIV[IPO + I];
    if IP <> I then
      for K := 0 to N - 1 do
      begin
        TEMP := A[AO + I * LDA + K];
        A[AO + I * LDA + K] := A[AO + IP * LDA + K];
        A[AO + IP * LDA + K] := TEMP;
      end;
    I := I + INCX;
  end;
end;

{ xGETRF2: recursive LU factorization with partial pivoting of the M x N
  matrix at A[AO], pivots in IPIV[IPO..] relative to the first row. }
generic procedure GETRF2<T>(M, N: longint; var A: array of T;
  AO, LDA: longint; var IPIV: array of longint; IPO: longint;
  out INFO: longint);
var
  I, N1, N2, IINFO: longint;
  SFMIN: TReal;
  TEMP, ONE: T;
begin
  INFO := 0;
  if (M = 0) or (N = 0) then Exit;
  ONE := 1;
  if M = 1 then
  begin
    { One row: just test for exact zero. }
    IPIV[IPO] := 0;
    if ISZERO(A[AO]) then INFO := 1;
  end else if N = 1 then
  begin
    { One column: find the pivot and scale the column. }
    SFMIN := LapackSafeMinimum;
    I := specialize IAMAX<T>(M, A, AO, LDA);
    IPIV[IPO] := I;
    if not ISZERO(A[AO + I * LDA]) then
    begin
      if I <> 0 then
      begin
        TEMP := A[AO];
        A[AO] := A[AO + I * LDA];
        A[AO + I * LDA] := TEMP;
      end;
      if ABSX(A[AO]) >= SFMIN then
        specialize SCAL<T>(M - 1, FDIV(ONE, A[AO]), A, AO + LDA, LDA)
      else
        for I := 1 to M - 1 do
          A[AO + I * LDA] := FDIV(A[AO + I * LDA], A[AO]);
    end else
      INFO := 1;
  end else
  begin
    { Use recursive code: factor [A11; A21], update [A12; A22], factor
      A22, apply its interchanges to [A11; A21]. }
    N1 := Min(M, N) div 2;
    N2 := N - N1;
    specialize GETRF2<T>(M, N1, A, AO, LDA, IPIV, IPO, IINFO);
    if (INFO = 0) and (IINFO > 0) then INFO := IINFO;
    specialize LASWP<T>(N2, A, AO + N1, LDA, 0, N1 - 1,
      IPIV, IPO, 1);
    specialize TRSM<T>('L', 'L', 'N', 'U', N1, N2, ONE, A, AO, LDA,
      A, AO + N1, LDA);
    specialize GEMM<T>('N', 'N', M - N1, N2, N1, -ONE, A, AO + N1 * LDA,
      LDA, A, AO + N1, LDA, ONE, A, AO + N1 * LDA + N1, LDA);
    specialize GETRF2<T>(M - N1, N2, A, AO + N1 * LDA + N1, LDA, IPIV,
      IPO + N1, IINFO);
    if (INFO = 0) and (IINFO > 0) then INFO := IINFO + N1;
    for I := N1 to Min(M, N) - 1 do IPIV[IPO + I] := IPIV[IPO + I] + N1;
    specialize LASWP<T>(N1, A, AO, LDA, N1, Min(M, N) - 1,
      IPIV, IPO, 1);
  end;
end;

{ xGETRF: blocked LU factorization; xGETRF2 when the block size is not
  smaller than min(M, N). }
generic procedure GETRF<T>(M, N: longint; var A: array of T;
  AO, LDA: longint; var IPIV: array of longint; out INFO: longint);
var
  I, J, JB, NB, IINFO: longint;
  ONE: T;
begin
  INFO := 0;
  if (M = 0) or (N = 0) then Exit;
  ONE := 1;
  NB := LapackBlockLU;
  if (NB <= 1) or (NB >= Min(M, N)) then
    specialize GETRF2<T>(M, N, A, AO, LDA, IPIV, 0, INFO)
  else
  begin
    J := 0;
    while J < Min(M, N) do
    begin
      JB := Min(Min(M, N) - J, NB);
      { Factor diagonal and subdiagonal blocks and test for exact
        singularity. }
      specialize GETRF2<T>(M - J, JB, A, AO + J * LDA + J, LDA, IPIV, J,
        IINFO);
      { Adjust INFO and the pivot indices. }
      if (INFO = 0) and (IINFO > 0) then INFO := IINFO + J;
      for I := J to Min(M, J + JB) - 1 do IPIV[I] := J + IPIV[I];
      { Apply interchanges to columns 0:J-1. }
      specialize LASWP<T>(J, A, AO, LDA, J, J + JB - 1, IPIV, 0, 1);
      if J + JB < N then
      begin
        { Apply interchanges to columns J+JB:N-1, compute the block row
          of U and update the trailing submatrix. }
        specialize LASWP<T>(N - J - JB, A, AO + J + JB, LDA, J, J + JB - 1,
          IPIV, 0, 1);
        specialize TRSM<T>('L', 'L', 'N', 'U', JB, N - J - JB, ONE, A,
          AO + J * LDA + J, LDA, A, AO + J * LDA + J + JB, LDA);
        if J + JB < M then
          specialize GEMM<T>('N', 'N', M - J - JB, N - J - JB, JB, -ONE, A,
            AO + (J + JB) * LDA + J, LDA, A, AO + J * LDA + J + JB, LDA, ONE,
            A, AO + (J + JB) * LDA + J + JB, LDA);
      end;
      J := J + NB;
    end;
  end;
end;

{ xGETRS: solves op(A)*X = B with the factors of xGETRF. }
generic procedure GETRS<T>(TRANS: char; N, NRHS: longint; const A: array of T;
  AO, LDA: longint; const IPIV: array of longint; var B: array of T;
  BO, LDB: longint);
var
  ONE: T;
begin
  if (N = 0) or (NRHS = 0) then Exit;
  ONE := 1;
  if TRANS = 'N' then
  begin
    { Solve A*X = B: apply the row interchanges, then solve L*X = B and
      U*X = B. }
    specialize LASWP<T>(NRHS, B, BO, LDB, 0, N - 1, IPIV, 0, 1);
    specialize TRSM<T>('L', 'L', 'N', 'U', N, NRHS, ONE, A, AO, LDA, B, BO, LDB);
    specialize TRSM<T>('L', 'U', 'N', 'N', N, NRHS, ONE, A, AO, LDA, B, BO, LDB);
  end else
  begin
    { Solve A^T*X = B or A^H*X = B: solve U^T*X = B and L^T*X = B (or
      with ^H), then apply the row interchanges. }
    specialize TRSM<T>('L', 'U', TRANS, 'N', N, NRHS, ONE, A, AO, LDA, B, BO, LDB);
    specialize TRSM<T>('L', 'L', TRANS, 'U', N, NRHS, ONE, A, AO, LDA, B, BO, LDB);
    specialize LASWP<T>(NRHS, B, BO, LDB, 0, N - 1, IPIV, 0, -1);
  end;
end;

{ xTRTI2: inverse of a triangular matrix, unblocked. }
generic procedure TRTI2<T>(UPLO, DIAG: char; N: longint; var A: array of T;
  AO, LDA: longint);
var
  J: longint;
  AJJ, ONE: T;
  NOUNIT: boolean;
begin
  NOUNIT := DIAG = 'N';
  ONE := 1;
  if UPLO = 'U' then
    { Compute the inverse of the upper triangular matrix. }
    for J := 0 to N - 1 do
    begin
      if NOUNIT then
      begin
        A[AO + J * LDA + J] := FDIV(ONE, A[AO + J * LDA + J]);
        AJJ := -A[AO + J * LDA + J];
      end else
        AJJ := -ONE;
      { Compute elements 0:J-1 of column J. }
      specialize TRMV<T>('U', 'N', DIAG, J, A, AO, LDA, A, AO + J, LDA);
      specialize SCAL<T>(J, AJJ, A, AO + J, LDA);
    end
  else
    { Compute the inverse of the lower triangular matrix. }
    for J := N - 1 downto 0 do
    begin
      if NOUNIT then
      begin
        A[AO + J * LDA + J] := FDIV(ONE, A[AO + J * LDA + J]);
        AJJ := -A[AO + J * LDA + J];
      end else
        AJJ := -ONE;
      if J < N - 1 then
      begin
        { Compute elements J+1:N-1 of column J. }
        specialize TRMV<T>('L', 'N', DIAG, N - 1 - J, A,
          AO + (J + 1) * LDA + J + 1, LDA, A, AO + (J + 1) * LDA + J, LDA);
        specialize SCAL<T>(N - 1 - J, AJJ, A, AO + (J + 1) * LDA + J, LDA);
      end;
    end;
end;

{ xTRTRI: inverse of a triangular matrix. INFO = i+1 when A(i, i) is
  exactly zero (non-unit diagonal); A is then unchanged. }
generic procedure TRTRI<T>(UPLO, DIAG: char; N: longint; var A: array of T;
  AO, LDA: longint; out INFO: longint);
var
  J, JB, NB, NN: longint;
  ONE: T;
begin
  INFO := 0;
  if N = 0 then Exit;
  ONE := 1;
  { Check for singularity if non-unit. }
  if DIAG = 'N' then
    for J := 0 to N - 1 do
      if ISZERO(A[AO + J * LDA + J]) then
      begin
        INFO := J + 1;
        Exit;
      end;
  NB := LapackBlockLU;
  if (NB <= 1) or (NB >= N) then
    specialize TRTI2<T>(UPLO, DIAG, N, A, AO, LDA)
  else if UPLO = 'U' then
  begin
    { Compute the inverse of the upper triangular matrix. }
    J := 0;
    while J < N do
    begin
      JB := Min(NB, N - J);
      { Compute rows 0:J-1 of the current block column. }
      specialize TRMM<T>('L', 'U', 'N', DIAG, J, JB, ONE, A, AO, LDA, A,
        AO + J, LDA);
      specialize TRSM<T>('R', 'U', 'N', DIAG, J, JB, -ONE, A,
        AO + J * LDA + J, LDA, A, AO + J, LDA);
      { Compute the inverse of the current diagonal block. }
      specialize TRTI2<T>('U', DIAG, JB, A, AO + J * LDA + J, LDA);
      J := J + NB;
    end;
  end else
  begin
    { Compute the inverse of the lower triangular matrix. }
    NN := ((N - 1) div NB) * NB;
    J := NN;
    while J >= 0 do
    begin
      JB := Min(NB, N - J);
      if J + JB < N then
      begin
        { Compute rows J+JB:N-1 of the current block column. }
        specialize TRMM<T>('L', 'L', 'N', DIAG, N - J - JB, JB, ONE, A,
          AO + (J + JB) * LDA + J + JB, LDA, A, AO + (J + JB) * LDA + J, LDA);
        specialize TRSM<T>('R', 'L', 'N', DIAG, N - J - JB, JB, -ONE, A,
          AO + J * LDA + J, LDA, A, AO + (J + JB) * LDA + J, LDA);
      end;
      { Compute the inverse of the current diagonal block. }
      specialize TRTI2<T>('L', DIAG, JB, A, AO + J * LDA + J, LDA);
      J := J - NB;
    end;
  end;
end;

{ xGETRI: inverse of a matrix from the factors of xGETRF. INFO = i+1
  when U(i, i) is exactly zero; A is then not inverted. }
generic procedure GETRI<T>(N: longint; var A: array of T; AO, LDA: longint;
  const IPIV: array of longint; out INFO: longint);
var
  I, J, JJ, JB, JP, NB, NN, LDWORK: longint;
  ONE: T;
  WORK: array of T;
begin
  INFO := 0;
  if N = 0 then Exit;
  ONE := 1;
  { Form inv(U); if INFO > 0 from xTRTRI, then U is singular. }
  specialize TRTRI<T>('U', 'N', N, A, AO, LDA, INFO);
  if INFO > 0 then Exit;
  NB := LapackBlockLU;
  WORK := nil;
  if (NB < 2) or (NB >= N) then
  begin
    { Use unblocked code: solve inv(A)*L = inv(U) for inv(A). }
    SetLength(WORK, N);
    for J := N - 1 downto 0 do
    begin
      { Copy current column of L to WORK and replace with zeros. }
      for I := J + 1 to N - 1 do
      begin
        WORK[I] := A[AO + I * LDA + J];
        A[AO + I * LDA + J] := 0;
      end;
      { Compute current column of inv(A). }
      if J < N - 1 then
        specialize GEMV<T>('N', N, N - 1 - J, -ONE, A, AO + J + 1, LDA, WORK,
          J + 1, 1, ONE, A, AO + J, LDA);
    end;
  end else
  begin
    { Use blocked code; WORK holds the N x NB block of L by columns
      (WORK(i + (jj-j)*LDWORK) of LAPACK), stored by rows here: entry
      (i, jj-j) at WORK[i*NB + jj-j]. }
    LDWORK := NB;
    SetLength(WORK, N * NB);
    NN := ((N - 1) div NB) * NB;
    J := NN;
    while J >= 0 do
    begin
      JB := Min(NB, N - J);
      { Copy current block column of L to WORK and replace with zeros. }
      for JJ := J to J + JB - 1 do
        for I := JJ + 1 to N - 1 do
        begin
          WORK[I * LDWORK + JJ - J] := A[AO + I * LDA + JJ];
          A[AO + I * LDA + JJ] := 0;
        end;
      { Compute current block column of inv(A). }
      if J + JB < N then
        specialize GEMM<T>('N', 'N', N, JB, N - J - JB, -ONE, A,
          AO + J + JB, LDA, WORK, (J + JB) * LDWORK, LDWORK, ONE, A, AO + J,
          LDA);
      specialize TRSM<T>('R', 'L', 'N', 'U', N, JB, ONE, WORK, J * LDWORK,
        LDWORK, A, AO + J, LDA);
      J := J - NB;
    end;
  end;
  { Apply column interchanges. }
  for J := N - 2 downto 0 do
  begin
    JP := IPIV[J];
    if JP <> J then
      specialize SWAP<T>(N, A, AO + J, LDA, A, AO + JP, LDA);
  end;
end;

{ xLASSQ (LAPACK 3.12, Blue's algorithm): updates SCALE and SUMSQ so
  that SCALE^2*SUMSQ grows by the sum of the squares of N entries of X. }
generic procedure LASSQ<T>(N: longint; const X: array of T; XO, INCX: longint;
  var SCALE, SUMSQ: TReal);
const
  TSML: TReal = 1.4916681462400413E-154; { 2^-511 }
  TBIG: TReal = 1.9979190722022350E+146; { 2^486 }
  SSML: TReal = 4.4989137945431964E+161; { 2^537 }
  SBIG: TReal = 1.1113793747425387E-162; { 2^-538 }
var
  I, IX: longint;
  NOTBIG: boolean;
  ABIG, AMED, ASML, AX, YMAX, YMIN: TReal;
begin
  if IsNan(SCALE) or IsNan(SUMSQ) then Exit;
  if SUMSQ = 0 then SCALE := 1;
  if SCALE = 0 then
  begin
    SCALE := 1;
    SUMSQ := 0;
  end;
  if N <= 0 then Exit;
  { Compute the sum of squares in 3 accumulators. }
  NOTBIG := True;
  ASML := 0;
  AMED := 0;
  ABIG := 0;
  IX := VSTART(N, XO, INCX);
  for I := 0 to N - 1 do
  begin
    NRM2ACC(X[IX], ASML, AMED, ABIG, NOTBIG);
    IX := IX + INCX;
  end;
  { Put the existing sum of squares into one of the accumulators. }
  if SUMSQ > 0 then
  begin
    AX := SCALE * Sqrt(SUMSQ);
    if AX > TBIG then
    begin
      if SCALE > 1 then
      begin
        SCALE := SCALE * SBIG;
        ABIG := ABIG + SCALE * (SCALE * SUMSQ);
      end else
        ABIG := ABIG + SCALE * (SCALE * (SBIG * (SBIG * SUMSQ)));
    end else if AX < TSML then
    begin
      if NOTBIG then
        if SCALE < 1 then
        begin
          SCALE := SCALE * SSML;
          ASML := ASML + SCALE * (SCALE * SUMSQ);
        end else
          ASML := ASML + SCALE * (SCALE * (SSML * (SSML * SUMSQ)));
    end else
      AMED := AMED + SCALE * (SCALE * SUMSQ);
  end;
  { Combine ABIG and AMED or AMED and ASML if more than one accumulator
    was used. }
  if ABIG > 0 then
  begin
    if (AMED > 0) or IsNan(AMED) then ABIG := ABIG + (AMED * SBIG) * SBIG;
    SCALE := 1 / SBIG;
    SUMSQ := ABIG;
  end else if ASML > 0 then
  begin
    if (AMED > 0) or IsNan(AMED) then
    begin
      AMED := Sqrt(AMED);
      ASML := Sqrt(ASML) / SSML;
      if ASML > AMED then
      begin
        YMIN := AMED;
        YMAX := ASML;
      end else
      begin
        YMIN := ASML;
        YMAX := AMED;
      end;
      SCALE := 1;
      SUMSQ := Sqr(YMAX) * (1 + Sqr(YMIN / YMAX));
    end else
    begin
      SCALE := 1 / SSML;
      SUMSQ := ASML;
    end;
  end else
  begin
    SCALE := 1;
    SUMSQ := AMED;
  end;
end;

{ xLANGE. }
generic function LANGE<T>(NORM: char; M, N: longint; const A: array of T;
  AO, LDA: longint): TReal;
var
  I, J: longint;
  SCALE, SUM, TEMP: TReal;
  WORK: array of TReal;
begin
  result := 0;
  if Min(M, N) = 0 then Exit;
  case NORM of
    'M':
      { Find max(abs(A(i,j))). }
      for J := 0 to N - 1 do
        for I := 0 to M - 1 do
        begin
          TEMP := ABSX(A[AO + I * LDA + J]);
          if (result < TEMP) or IsNan(TEMP) then result := TEMP;
        end;
    'O', '1':
      { Find norm1(A). }
      for J := 0 to N - 1 do
      begin
        SUM := 0;
        for I := 0 to M - 1 do SUM := SUM + ABSX(A[AO + I * LDA + J]);
        if (result < SUM) or IsNan(SUM) then result := SUM;
      end;
    'I':
      begin
        { Find normI(A). }
        WORK := nil;
        SetLength(WORK, M);
        for J := 0 to N - 1 do
          for I := 0 to M - 1 do
            WORK[I] := WORK[I] + ABSX(A[AO + I * LDA + J]);
        for I := 0 to M - 1 do
        begin
          TEMP := WORK[I];
          if (result < TEMP) or IsNan(TEMP) then result := TEMP;
        end;
      end;
    'F', 'E':
      begin
        { Find normF(A). }
        SCALE := 0;
        SUM := 1;
        for J := 0 to N - 1 do
          specialize LASSQ<T>(M, A, AO + J, LDA, SCALE, SUM);
        result := SCALE * Sqrt(SUM);
      end;
  end;
end;

{ DTRSV, ZTRSV: x := inv(op(A))*x for the triangular N x N matrix A
  (contiguous x). }
generic procedure TRSV<T>(UPLO, TRANS, DIAG: char; N: longint;
  const A: array of T; AO, LDA: longint; var X: array of T; XO: longint);
var
  I, J: longint;
  TEMP: T;
  NOUNIT, NOCONJ: boolean;
begin
  if N = 0 then Exit;
  NOUNIT := DIAG = 'N';
  NOCONJ := TRANS = 'T';
  if TRANS = 'N' then
  begin
    { x := inv(A)*x. }
    if UPLO = 'U' then
    begin
      for J := N - 1 downto 0 do
        if not ISZERO(X[XO + J]) then
        begin
          if NOUNIT then X[XO + J] := FDIV(X[XO + J], A[AO + J * LDA + J]);
          TEMP := X[XO + J];
          for I := J - 1 downto 0 do MSUB(X[XO + I], TEMP, A[AO + I * LDA + J]);
        end;
    end else
      for J := 0 to N - 1 do
        if not ISZERO(X[XO + J]) then
        begin
          if NOUNIT then X[XO + J] := FDIV(X[XO + J], A[AO + J * LDA + J]);
          TEMP := X[XO + J];
          for I := J + 1 to N - 1 do MSUB(X[XO + I], TEMP, A[AO + I * LDA + J]);
        end;
  end else
  begin
    { x := inv(A^T)*x or x := inv(A^H)*x. }
    if UPLO = 'U' then
    begin
      for J := 0 to N - 1 do
      begin
        TEMP := X[XO + J];
        for I := 0 to J - 1 do
          MSUB(TEMP, CONJIF(A[AO + I * LDA + J], not NOCONJ), X[XO + I]);
        if NOUNIT then
          TEMP := FDIV(TEMP, CONJIF(A[AO + J * LDA + J], not NOCONJ));
        X[XO + J] := TEMP;
      end;
    end else
      for J := N - 1 downto 0 do
      begin
        TEMP := X[XO + J];
        for I := N - 1 downto J + 1 do
          MSUB(TEMP, CONJIF(A[AO + I * LDA + J], not NOCONJ), X[XO + I]);
        if NOUNIT then
          TEMP := FDIV(TEMP, CONJIF(A[AO + J * LDA + J], not NOCONJ));
        X[XO + J] := TEMP;
      end;
  end;
end;

{ DASUM, DZASUM: sum of the CABS1 of N entries (|x| for real ones). }
generic function ASUM<T>(N: longint; const X: array of T;
  XO, INCX: longint): TReal;
var
  I: longint;
begin
  result := 0;
  if (N <= 0) or (INCX <= 0) then Exit;
  for I := 0 to N - 1 do result := result + CABS1(X[XO + I * INCX]);
end;

{ DLATRS (LAPACK 3.12.1). }
procedure DLATRS(UPLO, TRANS, DIAG, NORMIN: char; N: longint;
  const A: array of TReal; AO, LDA: longint; var X: array of TReal;
  out SCALE: TReal; var CNORM: array of TReal);
const
  HALF: TReal = 0.5;
  ONE: TReal = 1;
var
  UPPER, NOTRAN, NOUNIT: boolean;
  I, IMAX, J, JFIRST, JLAST, JINC: longint;
  BIGNUM, GROW, REC, SMLNUM, SUMJ, TJJ, TJJS, TMAX, TSCAL, USCAL, XBND,
    XJ, XMAX: TReal;
  SKIP: boolean;
begin
  UPPER := UPLO = 'U';
  NOTRAN := TRANS = 'N';
  NOUNIT := DIAG = 'N';
  SCALE := 1;
  if N = 0 then Exit;
  { Determine machine dependent parameters to control overflow. }
  SMLNUM := LapackSafeMinimum / LapackPrecision;
  BIGNUM := 1 / SMLNUM;
  if NORMIN = 'N' then
  begin
    { Compute the 1-norm of each column, not including the diagonal. }
    if UPPER then
      for J := 0 to N - 1 do
        CNORM[J] := specialize ASUM<TReal>(J, A, AO + J, LDA)
    else
    begin
      for J := 0 to N - 2 do
        CNORM[J] := specialize ASUM<TReal>(N - 1 - J, A,
          AO + (J + 1) * LDA + J, LDA);
      CNORM[N - 1] := 0;
    end;
  end;
  { Scale the column norms by TSCAL if the maximum element in CNORM is
    greater than BIGNUM. }
  IMAX := specialize IAMAX<TReal>(N, CNORM, 0, 1);
  TMAX := CNORM[IMAX];
  if TMAX <= BIGNUM then
    TSCAL := 1
  else
  begin
    { Avoid NaN generation if entries in CNORM exceed the overflow
      threshold. }
    if TMAX <= LapackOverflow then
    begin
      { Case 1: All entries in CNORM are valid floating-point numbers. }
      TSCAL := 1 / (SMLNUM * TMAX);
      specialize SCAL<TReal>(N, TSCAL, CNORM, 0, 1);
    end else
    begin
      { Case 2: At least one column norm of A cannot be represented as
        floating-point number. Find the offdiagonal entry A(I,J) with
        the largest absolute value. }
      TMAX := 0;
      if UPPER then
        for J := 1 to N - 1 do
          TMAX := Max(specialize LANGE<TReal>('M', J, 1, A, AO + J, LDA),
            TMAX)
      else
        for J := 0 to N - 2 do
          TMAX := Max(specialize LANGE<TReal>('M', N - 1 - J, 1, A,
            AO + (J + 1) * LDA + J, LDA), TMAX);
      if TMAX <= LapackOverflow then
      begin
        TSCAL := 1 / (SMLNUM * TMAX);
        for J := 0 to N - 1 do
          if CNORM[J] <= LapackOverflow then
            CNORM[J] := CNORM[J] * TSCAL
          else
          begin
            { Recompute the 1-norm without introducing Infinity in the
              summation. }
            CNORM[J] := 0;
            if UPPER then
              for I := 0 to J - 1 do
                CNORM[J] := CNORM[J] + TSCAL * System.Abs(A[AO + I * LDA + J])
            else
              for I := J + 1 to N - 1 do
                CNORM[J] := CNORM[J] + TSCAL * System.Abs(A[AO + I * LDA + J]);
          end;
      end else
      begin
        { At least one entry of A is not a valid floating-point entry.
          Rely on TRSV to propagate Inf and NaN. }
        specialize TRSV<TReal>(UPLO, TRANS, DIAG, N, A, AO, LDA, X, 0);
        Exit;
      end;
    end;
  end;
  { Compute a bound on the computed solution vector to see if the Level
    2 BLAS routine DTRSV can be used. }
  J := specialize IAMAX<TReal>(N, X, 0, 1);
  XMAX := System.Abs(X[J]);
  XBND := XMAX;
  if NOTRAN then
  begin
    { Compute the growth in A * x = b. }
    if UPPER then
    begin
      JFIRST := N - 1;
      JLAST := 0;
      JINC := -1;
    end else
    begin
      JFIRST := 0;
      JLAST := N - 1;
      JINC := 1;
    end;
    if TSCAL <> 1 then
      GROW := 0
    else if NOUNIT then
    begin
      { A is non-unit triangular. Compute GROW = 1/G(j) and XBND =
        1/M(j). Initially, G(0) = max(x(i), i=1,...,n). }
      GROW := 1 / Max(XBND, SMLNUM);
      XBND := GROW;
      J := JFIRST;
      SKIP := False;
      while J <> JLAST + JINC do
      begin
        { Exit the loop if the growth factor is too small. }
        if GROW <= SMLNUM then
        begin
          SKIP := True;
          Break;
        end;
        { M(j) = G(j-1) / abs(A(j,j)) }
        TJJ := System.Abs(A[AO + J * LDA + J]);
        XBND := Min(XBND, Min(ONE, TJJ) * GROW);
        if TJJ + CNORM[J] >= SMLNUM then
          { G(j) = G(j-1)*( 1 + CNORM(j) / abs(A(j,j)) ) }
          GROW := GROW * (TJJ / (TJJ + CNORM[J]))
        else
          { G(j) could overflow, set GROW to 0. }
          GROW := 0;
        J := J + JINC;
      end;
      if not SKIP then GROW := XBND;
    end else
    begin
      { A is unit triangular. Compute GROW = 1/G(j), where G(0) =
        max(x(i), i=1,...,n). }
      GROW := Min(ONE, 1 / Max(XBND, SMLNUM));
      J := JFIRST;
      while J <> JLAST + JINC do
      begin
        if GROW <= SMLNUM then Break;
        { G(j) = G(j-1)*( 1 + CNORM(j) ) }
        GROW := GROW * (1 / (1 + CNORM[J]));
        J := J + JINC;
      end;
    end;
  end else
  begin
    { Compute the growth in A**T * x = b. }
    if UPPER then
    begin
      JFIRST := 0;
      JLAST := N - 1;
      JINC := 1;
    end else
    begin
      JFIRST := N - 1;
      JLAST := 0;
      JINC := -1;
    end;
    if TSCAL <> 1 then
      GROW := 0
    else if NOUNIT then
    begin
      { A is non-unit triangular. Compute GROW = 1/G(j) and XBND =
        1/M(j). Initially, M(0) = max(x(i), i=1,...,n). }
      GROW := 1 / Max(XBND, SMLNUM);
      XBND := GROW;
      J := JFIRST;
      SKIP := False;
      while J <> JLAST + JINC do
      begin
        if GROW <= SMLNUM then
        begin
          SKIP := True;
          Break;
        end;
        { G(j) = max( G(j-1), M(j-1)*( 1 + CNORM(j) ) ) }
        XJ := 1 + CNORM[J];
        GROW := Min(GROW, XBND / XJ);
        { M(j) = M(j-1)*( 1 + CNORM(j) ) / abs(A(j,j)) }
        TJJ := System.Abs(A[AO + J * LDA + J]);
        if XJ > TJJ then XBND := XBND * (TJJ / XJ);
        J := J + JINC;
      end;
      if not SKIP then GROW := Min(GROW, XBND);
    end else
    begin
      { A is unit triangular. Compute GROW = 1/G(j), where G(0) =
        max(x(i), i=1,...,n). }
      GROW := Min(ONE, 1 / Max(XBND, SMLNUM));
      J := JFIRST;
      while J <> JLAST + JINC do
      begin
        if GROW <= SMLNUM then Break;
        { G(j) = ( 1 + CNORM(j) )*G(j-1) }
        XJ := 1 + CNORM[J];
        GROW := GROW / XJ;
        J := J + JINC;
      end;
    end;
  end;

  if GROW * TSCAL > SMLNUM then
    { Use the Level 2 BLAS solve if the reciprocal of the bound on
      elements of X is not too small. }
    specialize TRSV<TReal>(UPLO, TRANS, DIAG, N, A, AO, LDA, X, 0)
  else
  begin
    { Use a Level 1 BLAS solve, scaling intermediate results. }
    if XMAX > BIGNUM then
    begin
      { Scale X so that its components are less than or equal to BIGNUM
        in absolute value. }
      SCALE := BIGNUM / XMAX;
      specialize SCAL<TReal>(N, SCALE, X, 0, 1);
      XMAX := BIGNUM;
    end;
    if NOTRAN then
    begin
      { Solve A * x = b }
      J := JFIRST;
      while J <> JLAST + JINC do
      begin
        { Compute x(j) = b(j) / A(j,j), scaling x if necessary. }
        XJ := System.Abs(X[J]);
        SKIP := False;
        if NOUNIT then
          TJJS := A[AO + J * LDA + J] * TSCAL
        else
        begin
          TJJS := TSCAL;
          SKIP := TSCAL = 1;
        end;
        if not SKIP then
        begin
          TJJ := System.Abs(TJJS);
          if TJJ > SMLNUM then
          begin
            { abs(A(j,j)) > SMLNUM: }
            if TJJ < 1 then
              if XJ > TJJ * BIGNUM then
              begin
                { Scale x by 1/b(j). }
                REC := 1 / XJ;
                specialize SCAL<TReal>(N, REC, X, 0, 1);
                SCALE := SCALE * REC;
                XMAX := XMAX * REC;
              end;
            X[J] := X[J] / TJJS;
            XJ := System.Abs(X[J]);
          end else if TJJ > 0 then
          begin
            { 0 < abs(A(j,j)) <= SMLNUM: }
            if XJ > TJJ * BIGNUM then
            begin
              { Scale x by (1/abs(x(j)))*abs(A(j,j))*BIGNUM to avoid
                overflow when dividing by A(j,j). }
              REC := (TJJ * BIGNUM) / XJ;
              if CNORM[J] > 1 then
                { Scale by 1/CNORM(j) to avoid overflow when multiplying
                  x(j) times column j. }
                REC := REC / CNORM[J];
              specialize SCAL<TReal>(N, REC, X, 0, 1);
              SCALE := SCALE * REC;
              XMAX := XMAX * REC;
            end;
            X[J] := X[J] / TJJS;
            XJ := System.Abs(X[J]);
          end else
          begin
            { A(j,j) = 0: Set x(1:n) = 0, x(j) = 1, and scale = 0, and
              compute a solution to A*x = 0. }
            for I := 0 to N - 1 do X[I] := 0;
            X[J] := 1;
            XJ := 1;
            SCALE := 0;
            XMAX := 0;
          end;
        end;
        { Scale x if necessary to avoid overflow when adding a multiple of
          column j of A. }
        if XJ > 1 then
        begin
          REC := 1 / XJ;
          if CNORM[J] > (BIGNUM - XMAX) * REC then
          begin
            { Scale x by 1/(2*abs(x(j))). }
            REC := REC * HALF;
            specialize SCAL<TReal>(N, REC, X, 0, 1);
            SCALE := SCALE * REC;
          end;
        end else if XJ * CNORM[J] > BIGNUM - XMAX then
        begin
          { Scale x by 1/2. }
          specialize SCAL<TReal>(N, HALF, X, 0, 1);
          SCALE := SCALE * HALF;
        end;
        if UPPER then
        begin
          if J > 0 then
          begin
            { Compute the update x(1:j-1) := x(1:j-1) - x(j) * A(1:j-1,j) }
            specialize AXPY<TReal>(J, -X[J] * TSCAL, A, AO + J, LDA, X, 0, 1);
            I := specialize IAMAX<TReal>(J, X, 0, 1);
            XMAX := System.Abs(X[I]);
          end;
        end else if J < N - 1 then
        begin
          { Compute the update x(j+1:n) := x(j+1:n) - x(j) * A(j+1:n,j) }
          specialize AXPY<TReal>(N - 1 - J, -X[J] * TSCAL, A,
            AO + (J + 1) * LDA + J, LDA, X, J + 1, 1);
          I := J + 1 + specialize IAMAX<TReal>(N - 1 - J, X, J + 1, 1);
          XMAX := System.Abs(X[I]);
        end;
        J := J + JINC;
      end;
    end else
    begin
      { Solve A**T * x = b }
      J := JFIRST;
      while J <> JLAST + JINC do
      begin
        { Compute x(j) = b(j) - sum A(k,j)*x(k). k<>j }
        XJ := System.Abs(X[J]);
        USCAL := TSCAL;
        REC := 1 / Max(XMAX, ONE);
        if CNORM[J] > (BIGNUM - XJ) * REC then
        begin
          { If x(j) could overflow, scale x by 1/(2*XMAX). }
          REC := REC * HALF;
          if NOUNIT then
            TJJS := A[AO + J * LDA + J] * TSCAL
          else
            TJJS := TSCAL;
          TJJ := System.Abs(TJJS);
          if TJJ > 1 then
          begin
            { Divide by A(j,j) when scaling x if A(j,j) > 1. }
            REC := Min(ONE, REC * TJJ);
            USCAL := USCAL / TJJS;
          end;
          if REC < 1 then
          begin
            specialize SCAL<TReal>(N, REC, X, 0, 1);
            SCALE := SCALE * REC;
            XMAX := XMAX * REC;
          end;
        end;
        SUMJ := 0;
        if USCAL = 1 then
        begin
          { If the scaling needed for A in the dot product is 1, call
            DDOT to perform the dot product. }
          if UPPER then
            SUMJ := specialize DOT<TReal>(False, J, A, AO + J, LDA, X, 0, 1)
          else if J < N - 1 then
            SUMJ := specialize DOT<TReal>(False, N - 1 - J, A,
              AO + (J + 1) * LDA + J, LDA, X, J + 1, 1);
        end else
        begin
          { Otherwise, use in-line code for the dot product. }
          if UPPER then
            for I := 0 to J - 1 do
              SUMJ := SUMJ + (A[AO + I * LDA + J] * USCAL) * X[I]
          else if J < N - 1 then
            for I := J + 1 to N - 1 do
              SUMJ := SUMJ + (A[AO + I * LDA + J] * USCAL) * X[I];
        end;
        if USCAL = TSCAL then
        begin
          { Compute x(j) := ( x(j) - sumj ) / A(j,j) if 1/A(j,j) was not
            used to scale the dotproduct. }
          X[J] := X[J] - SUMJ;
          XJ := System.Abs(X[J]);
          SKIP := False;
          if NOUNIT then
            TJJS := A[AO + J * LDA + J] * TSCAL
          else
          begin
            TJJS := TSCAL;
            SKIP := TSCAL = 1;
          end;
          if not SKIP then
          begin
            { Compute x(j) = x(j) / A(j,j), scaling if necessary. }
            TJJ := System.Abs(TJJS);
            if TJJ > SMLNUM then
            begin
              { abs(A(j,j)) > SMLNUM: }
              if TJJ < 1 then
                if XJ > TJJ * BIGNUM then
                begin
                  { Scale X by 1/abs(x(j)). }
                  REC := 1 / XJ;
                  specialize SCAL<TReal>(N, REC, X, 0, 1);
                  SCALE := SCALE * REC;
                  XMAX := XMAX * REC;
                end;
              X[J] := X[J] / TJJS;
            end else if TJJ > 0 then
            begin
              { 0 < abs(A(j,j)) <= SMLNUM: }
              if XJ > TJJ * BIGNUM then
              begin
                { Scale x by (1/abs(x(j)))*abs(A(j,j))*BIGNUM. }
                REC := (TJJ * BIGNUM) / XJ;
                specialize SCAL<TReal>(N, REC, X, 0, 1);
                SCALE := SCALE * REC;
                XMAX := XMAX * REC;
              end;
              X[J] := X[J] / TJJS;
            end else
            begin
              { A(j,j) = 0: Set x(1:n) = 0, x(j) = 1, and scale = 0, and
                compute a solution to A**T*x = 0. }
              for I := 0 to N - 1 do X[I] := 0;
              X[J] := 1;
              SCALE := 0;
              XMAX := 0;
            end;
          end;
        end else
          { Compute x(j) := x(j) / A(j,j) - sumj if the dot product has
            already been divided by 1/A(j,j). }
          X[J] := X[J] / TJJS - SUMJ;
        XMAX := Max(XMAX, System.Abs(X[J]));
        J := J + JINC;
      end;
    end;
    SCALE := SCALE / TSCAL;
  end;
  { Scale the column norms by 1/TSCAL for return. }
  if TSCAL <> 1 then specialize SCAL<TReal>(N, 1 / TSCAL, CNORM, 0, 1);
end;

{ |re/2| + |im/2|: CABS2 of ZLATRS. }
function CABS2(const Z: TComplex): TReal; inline;
begin
  result := System.Abs(Z.Re / 2) + System.Abs(Z.Im / 2);
end;

{ ZLATRS (LAPACK 3.12.1). TRANS = 'C' conjugates the entries of A. }
procedure ZLATRS(UPLO, TRANS, DIAG, NORMIN: char; N: longint;
  const A: array of TComplex; AO, LDA: longint; var X: array of TComplex;
  out SCALE: TReal; var CNORM: array of TReal);
const
  HALF: TReal = 0.5;
  ONE: TReal = 1;
  TWO: TReal = 2;
var
  UPPER, NOTRAN, NOUNIT, CONJA, SKIP: boolean;
  I, IMAX, J, JFIRST, JLAST, JINC: longint;
  BIGNUM, GROW, REC, SMLNUM, TJJ, TMAX, TSCAL, XBND, XJ, XMAX: TReal;
  CSUMJ, TJJS, USCAL: TComplex;

  { op(A)(j, j) * TSCAL. }
  function DIAGSCALED: TComplex;
  begin
    result := FMUL(TSCAL, CONJIF(A[AO + J * LDA + J], CONJA));
  end;

begin
  UPPER := UPLO = 'U';
  NOTRAN := TRANS = 'N';
  NOUNIT := DIAG = 'N';
  CONJA := TRANS = 'C';
  SCALE := 1;
  if N = 0 then Exit;
  { Determine machine dependent parameters to control overflow. }
  SMLNUM := LapackSafeMinimum / LapackPrecision;
  BIGNUM := 1 / SMLNUM;
  if NORMIN = 'N' then
  begin
    { Compute the 1-norm of each column, not including the diagonal. }
    if UPPER then
      for J := 0 to N - 1 do
        CNORM[J] := specialize ASUM<TComplex>(J, A, AO + J, LDA)
    else
    begin
      for J := 0 to N - 2 do
        CNORM[J] := specialize ASUM<TComplex>(N - 1 - J, A,
          AO + (J + 1) * LDA + J, LDA);
      CNORM[N - 1] := 0;
    end;
  end;
  { Scale the column norms by TSCAL if the maximum element in CNORM is
    greater than BIGNUM/2. }
  IMAX := specialize IAMAX<TReal>(N, CNORM, 0, 1);
  TMAX := CNORM[IMAX];
  if TMAX <= BIGNUM * HALF then
    TSCAL := 1
  else
  begin
    { Avoid NaN generation if entries in CNORM exceed the overflow
      threshold. }
    if TMAX <= LapackOverflow then
    begin
      { Case 1: All entries in CNORM are valid floating-point numbers. }
      TSCAL := HALF / (SMLNUM * TMAX);
      specialize SCAL<TReal>(N, TSCAL, CNORM, 0, 1);
    end else
    begin
      { Case 2: At least one column norm of A cannot be represented as a
        floating-point number. Find the offdiagonal entry A(I,J) with the
        largest absolute value. }
      TMAX := 0;
      if UPPER then
      begin
        for J := 1 to N - 1 do
          for I := 0 to J - 1 do
            TMAX := Max(TMAX, Max(System.Abs(A[AO + I * LDA + J].Re),
              System.Abs(A[AO + I * LDA + J].Im)));
      end else
        for J := 0 to N - 2 do
          for I := J + 1 to N - 1 do
            TMAX := Max(TMAX, Max(System.Abs(A[AO + I * LDA + J].Re),
              System.Abs(A[AO + I * LDA + J].Im)));
      if TMAX <= LapackOverflow then
      begin
        TSCAL := 1 / (SMLNUM * TMAX);
        for J := 0 to N - 1 do
          if CNORM[J] <= LapackOverflow then
            CNORM[J] := CNORM[J] * TSCAL
          else
          begin
            { Recompute the 1-norm of each column without introducing
              Infinity in the summation. }
            TSCAL := TWO * TSCAL;
            CNORM[J] := 0;
            if UPPER then
              for I := 0 to J - 1 do
                CNORM[J] := CNORM[J] + TSCAL * CABS2(A[AO + I * LDA + J])
            else
              for I := J + 1 to N - 1 do
                CNORM[J] := CNORM[J] + TSCAL * CABS2(A[AO + I * LDA + J]);
            TSCAL := TSCAL * HALF;
          end;
      end else
      begin
        { At least one entry of A is not a valid floating-point entry.
          Rely on TRSV to propagate Inf and NaN. }
        specialize TRSV<TComplex>(UPLO, TRANS, DIAG, N, A, AO, LDA, X, 0);
        Exit;
      end;
    end;
  end;
  { Compute a bound on the computed solution vector to see if the Level
    2 BLAS routine ZTRSV can be used. }
  XMAX := 0;
  for J := 0 to N - 1 do XMAX := Max(XMAX, CABS2(X[J]));
  XBND := XMAX;
  if NOTRAN then
  begin
    { Compute the growth in A * x = b. }
    if UPPER then
    begin
      JFIRST := N - 1;
      JLAST := 0;
      JINC := -1;
    end else
    begin
      JFIRST := 0;
      JLAST := N - 1;
      JINC := 1;
    end;
    if TSCAL <> 1 then
      GROW := 0
    else if NOUNIT then
    begin
      { A is non-unit triangular. Compute GROW = 1/G(j) and XBND =
        1/M(j). Initially, G(0) = max(x(i), i=1,...,n). }
      GROW := HALF / Max(XBND, SMLNUM);
      XBND := GROW;
      J := JFIRST;
      SKIP := False;
      while J <> JLAST + JINC do
      begin
        { Exit the loop if the growth factor is too small. }
        if GROW <= SMLNUM then
        begin
          SKIP := True;
          Break;
        end;
        TJJS := A[AO + J * LDA + J];
        TJJ := CABS1(TJJS);
        if TJJ >= SMLNUM then
          { M(j) = G(j-1) / abs(A(j,j)) }
          XBND := Min(XBND, Min(ONE, TJJ) * GROW)
        else
          { M(j) could overflow, set XBND to 0. }
          XBND := 0;
        if TJJ + CNORM[J] >= SMLNUM then
          { G(j) = G(j-1)*( 1 + CNORM(j) / abs(A(j,j)) ) }
          GROW := GROW * (TJJ / (TJJ + CNORM[J]))
        else
          { G(j) could overflow, set GROW to 0. }
          GROW := 0;
        J := J + JINC;
      end;
      if not SKIP then GROW := XBND;
    end else
    begin
      { A is unit triangular. Compute GROW = 1/G(j), where G(0) =
        max(x(i), i=1,...,n). }
      GROW := Min(ONE, HALF / Max(XBND, SMLNUM));
      J := JFIRST;
      while J <> JLAST + JINC do
      begin
        if GROW <= SMLNUM then Break;
        { G(j) = G(j-1)*( 1 + CNORM(j) ) }
        GROW := GROW * (1 / (1 + CNORM[J]));
        J := J + JINC;
      end;
    end;
  end else
  begin
    { Compute the growth in A**T * x = b or A**H * x = b. }
    if UPPER then
    begin
      JFIRST := 0;
      JLAST := N - 1;
      JINC := 1;
    end else
    begin
      JFIRST := N - 1;
      JLAST := 0;
      JINC := -1;
    end;
    if TSCAL <> 1 then
      GROW := 0
    else if NOUNIT then
    begin
      { A is non-unit triangular. Compute GROW = 1/G(j) and XBND =
        1/M(j). Initially, M(0) = max(x(i), i=1,...,n). }
      GROW := HALF / Max(XBND, SMLNUM);
      XBND := GROW;
      J := JFIRST;
      SKIP := False;
      while J <> JLAST + JINC do
      begin
        if GROW <= SMLNUM then
        begin
          SKIP := True;
          Break;
        end;
        { G(j) = max( G(j-1), M(j-1)*( 1 + CNORM(j) ) ) }
        XJ := 1 + CNORM[J];
        GROW := Min(GROW, XBND / XJ);
        TJJS := A[AO + J * LDA + J];
        TJJ := CABS1(TJJS);
        if TJJ >= SMLNUM then
        begin
          { M(j) = M(j-1)*( 1 + CNORM(j) ) / abs(A(j,j)) }
          if XJ > TJJ then XBND := XBND * (TJJ / XJ);
        end else
          { M(j) could overflow, set XBND to 0. }
          XBND := 0;
        J := J + JINC;
      end;
      if not SKIP then GROW := Min(GROW, XBND);
    end else
    begin
      { A is unit triangular. Compute GROW = 1/G(j), where G(0) =
        max(x(i), i=1,...,n). }
      GROW := Min(ONE, HALF / Max(XBND, SMLNUM));
      J := JFIRST;
      while J <> JLAST + JINC do
      begin
        if GROW <= SMLNUM then Break;
        { G(j) = ( 1 + CNORM(j) )*G(j-1) }
        XJ := 1 + CNORM[J];
        GROW := GROW / XJ;
        J := J + JINC;
      end;
    end;
  end;

  if GROW * TSCAL > SMLNUM then
    { Use the Level 2 BLAS solve if the reciprocal of the bound on
      elements of X is not too small. }
    specialize TRSV<TComplex>(UPLO, TRANS, DIAG, N, A, AO, LDA, X, 0)
  else
  begin
    { Use a Level 1 BLAS solve, scaling intermediate results. }
    if XMAX > BIGNUM * HALF then
    begin
      { Scale X so that its components are less than or equal to BIGNUM
        in absolute value. }
      SCALE := (BIGNUM * HALF) / XMAX;
      ZDSCAL(N, SCALE, X, 0, 1);
      XMAX := BIGNUM;
    end else
      XMAX := XMAX * TWO;
    if NOTRAN then
    begin
      { Solve A * x = b }
      J := JFIRST;
      while J <> JLAST + JINC do
      begin
        { Compute x(j) = b(j) / A(j,j), scaling x if necessary. }
        XJ := CABS1(X[J]);
        SKIP := False;
        if NOUNIT then
          TJJS := DIAGSCALED
        else
        begin
          TJJS := TSCAL;
          SKIP := TSCAL = 1;
        end;
        if not SKIP then
        begin
          TJJ := CABS1(TJJS);
          if TJJ > SMLNUM then
          begin
            { abs(A(j,j)) > SMLNUM: }
            if TJJ < 1 then
              if XJ > TJJ * BIGNUM then
              begin
                { Scale x by 1/b(j). }
                REC := 1 / XJ;
                ZDSCAL(N, REC, X, 0, 1);
                SCALE := SCALE * REC;
                XMAX := XMAX * REC;
              end;
            X[J] := ZLADIV(X[J], TJJS);
            XJ := CABS1(X[J]);
          end else if TJJ > 0 then
          begin
            { 0 < abs(A(j,j)) <= SMLNUM: }
            if XJ > TJJ * BIGNUM then
            begin
              { Scale x by (1/abs(x(j)))*abs(A(j,j))*BIGNUM to avoid
                overflow when dividing by A(j,j). }
              REC := (TJJ * BIGNUM) / XJ;
              if CNORM[J] > 1 then
                { Scale by 1/CNORM(j) to avoid overflow when multiplying
                  x(j) times column j. }
                REC := REC / CNORM[J];
              ZDSCAL(N, REC, X, 0, 1);
              SCALE := SCALE * REC;
              XMAX := XMAX * REC;
            end;
            X[J] := ZLADIV(X[J], TJJS);
            XJ := CABS1(X[J]);
          end else
          begin
            { A(j,j) = 0: Set x(1:n) = 0, x(j) = 1, and scale = 0, and
              compute a solution to A*x = 0. }
            for I := 0 to N - 1 do X[I] := 0;
            X[J] := 1;
            XJ := 1;
            SCALE := 0;
            XMAX := 0;
          end;
        end;
        { Scale x if necessary to avoid overflow when adding a multiple of
          column j of A. }
        if XJ > 1 then
        begin
          REC := 1 / XJ;
          if CNORM[J] > (BIGNUM - XMAX) * REC then
          begin
            { Scale x by 1/(2*abs(x(j))). }
            REC := REC * HALF;
            ZDSCAL(N, REC, X, 0, 1);
            SCALE := SCALE * REC;
          end;
        end else if XJ * CNORM[J] > BIGNUM - XMAX then
        begin
          { Scale x by 1/2. }
          ZDSCAL(N, HALF, X, 0, 1);
          SCALE := SCALE * HALF;
        end;
        if UPPER then
        begin
          if J > 0 then
          begin
            { Compute the update x(1:j-1) := x(1:j-1) - x(j) * A(1:j-1,j) }
            specialize AXPY<TComplex>(J, -FMUL(TSCAL, X[J]), A, AO + J, LDA,
              X, 0, 1);
            I := specialize IAMAX<TComplex>(J, X, 0, 1);
            XMAX := CABS1(X[I]);
          end;
        end else if J < N - 1 then
        begin
          { Compute the update x(j+1:n) := x(j+1:n) - x(j) * A(j+1:n,j) }
          specialize AXPY<TComplex>(N - 1 - J, -FMUL(TSCAL, X[J]), A,
            AO + (J + 1) * LDA + J, LDA, X, J + 1, 1);
          I := J + 1 + specialize IAMAX<TComplex>(N - 1 - J, X, J + 1, 1);
          XMAX := CABS1(X[I]);
        end;
        J := J + JINC;
      end;
    end else
    begin
      { Solve A**T * x = b or A**H * x = b }
      J := JFIRST;
      while J <> JLAST + JINC do
      begin
        { Compute x(j) = b(j) - sum A(k,j)*x(k). k<>j }
        XJ := CABS1(X[J]);
        USCAL := TSCAL;
        REC := 1 / Max(XMAX, ONE);
        if CNORM[J] > (BIGNUM - XJ) * REC then
        begin
          { If x(j) could overflow, scale x by 1/(2*XMAX). }
          REC := REC * HALF;
          if NOUNIT then
            TJJS := DIAGSCALED
          else
            TJJS := TSCAL;
          TJJ := CABS1(TJJS);
          if TJJ > 1 then
          begin
            { Divide by A(j,j) when scaling x if A(j,j) > 1. }
            REC := Min(ONE, REC * TJJ);
            USCAL := ZLADIV(USCAL, TJJS);
          end;
          if REC < 1 then
          begin
            ZDSCAL(N, REC, X, 0, 1);
            SCALE := SCALE * REC;
            XMAX := XMAX * REC;
          end;
        end;
        CSUMJ := 0;
        if (USCAL.Re = 1) and (USCAL.Im = 0) then
        begin
          { If the scaling needed for A in the dot product is 1, call
            ZDOTU or ZDOTC to perform the dot product. }
          if UPPER then
            CSUMJ := specialize DOT<TComplex>(CONJA, J, A, AO + J, LDA, X, 0, 1)
          else if J < N - 1 then
            CSUMJ := specialize DOT<TComplex>(CONJA, N - 1 - J, A,
              AO + (J + 1) * LDA + J, LDA, X, J + 1, 1);
        end else
        begin
          { Otherwise, use in-line code for the dot product. }
          if UPPER then
            for I := 0 to J - 1 do
              CSUMJ := CSUMJ +
                (CONJIF(A[AO + I * LDA + J], CONJA) * USCAL) * X[I]
          else if J < N - 1 then
            for I := J + 1 to N - 1 do
              CSUMJ := CSUMJ +
                (CONJIF(A[AO + I * LDA + J], CONJA) * USCAL) * X[I];
        end;
        if (USCAL.Re = TSCAL) and (USCAL.Im = 0) then
        begin
          { Compute x(j) := ( x(j) - CSUMJ ) / A(j,j) if 1/A(j,j) was not
            used to scale the dotproduct. }
          X[J] := X[J] - CSUMJ;
          XJ := CABS1(X[J]);
          SKIP := False;
          if NOUNIT then
            TJJS := DIAGSCALED
          else
          begin
            TJJS := TSCAL;
            SKIP := TSCAL = 1;
          end;
          if not SKIP then
          begin
            { Compute x(j) = x(j) / A(j,j), scaling if necessary. }
            TJJ := CABS1(TJJS);
            if TJJ > SMLNUM then
            begin
              { abs(A(j,j)) > SMLNUM: }
              if TJJ < 1 then
                if XJ > TJJ * BIGNUM then
                begin
                  { Scale X by 1/abs(x(j)). }
                  REC := 1 / XJ;
                  ZDSCAL(N, REC, X, 0, 1);
                  SCALE := SCALE * REC;
                  XMAX := XMAX * REC;
                end;
              X[J] := ZLADIV(X[J], TJJS);
            end else if TJJ > 0 then
            begin
              { 0 < abs(A(j,j)) <= SMLNUM: }
              if XJ > TJJ * BIGNUM then
              begin
                { Scale x by (1/abs(x(j)))*abs(A(j,j))*BIGNUM. }
                REC := (TJJ * BIGNUM) / XJ;
                ZDSCAL(N, REC, X, 0, 1);
                SCALE := SCALE * REC;
                XMAX := XMAX * REC;
              end;
              X[J] := ZLADIV(X[J], TJJS);
            end else
            begin
              { A(j,j) = 0: Set x(1:n) = 0, x(j) = 1, and scale = 0, and
                compute a solution to A**T*x = 0. }
              for I := 0 to N - 1 do X[I] := 0;
              X[J] := 1;
              SCALE := 0;
              XMAX := 0;
            end;
          end;
        end else
          { Compute x(j) := x(j) / A(j,j) - CSUMJ if the dot product has
            already been divided by 1/A(j,j). }
          X[J] := ZLADIV(X[J], TJJS) - CSUMJ;
        XMAX := Max(XMAX, CABS1(X[J]));
        J := J + JINC;
      end;
    end;
    SCALE := SCALE / TSCAL;
  end;
  { Scale the column norms by 1/TSCAL for return. }
  if TSCAL <> 1 then specialize SCAL<TReal>(N, 1 / TSCAL, CNORM, 0, 1);
end;

{ DSCAL or ZDSCAL by a real factor, for the generic xRSCL. }
procedure SCALX(N: longint; DA: TReal; var X: array of TReal;
  XO, INCX: longint); overload;
begin
  specialize SCAL<TReal>(N, DA, X, XO, INCX);
end;

procedure SCALX(N: longint; DA: TReal; var X: array of TComplex;
  XO, INCX: longint); overload;
begin
  ZDSCAL(N, DA, X, XO, INCX);
end;

{ DRSCL, ZDRSCL: X := X/SA without overflow or underflow. }
generic procedure RSCL<T>(N: longint; SA: TReal; var X: array of T;
  XO, INCX: longint);
var
  SMLNUM, BIGNUM, CDEN, CDEN1, CNUM, CNUM1, MUL: TReal;
  DONE: boolean;
begin
  if N <= 0 then Exit;
  { Get machine parameters. }
  SMLNUM := LapackSafeMinimum;
  BIGNUM := 1 / SMLNUM;
  { Initialize the denominator to SA and the numerator to 1. }
  CDEN := SA;
  CNUM := 1;
  repeat
    CDEN1 := CDEN * SMLNUM;
    CNUM1 := CNUM / BIGNUM;
    if (System.Abs(CDEN1) > System.Abs(CNUM)) and (CNUM <> 0) then
    begin
      { Pre-multiply X by SMLNUM if CDEN is large compared to CNUM. }
      MUL := SMLNUM;
      DONE := False;
      CDEN := CDEN1;
    end else if System.Abs(CNUM1) > System.Abs(CDEN) then
    begin
      { Pre-multiply X by BIGNUM if CDEN is small compared to CNUM. }
      MUL := BIGNUM;
      DONE := False;
      CNUM := CNUM1;
    end else
    begin
      { Multiply X by CNUM / CDEN and return. }
      MUL := CNUM / CDEN;
      DONE := True;
    end;
    { Scale the vector X by MUL. }
    SCALX(N, MUL, X, XO, INCX);
  until DONE;
end;

{ DLACN2 (LAPACK 3.12.1): estimate of the 1-norm of a square matrix by
  reverse communication (see the interface). }
procedure DLACN2(N: longint; var V, X: array of TReal;
  var ISGN: array of longint; var EST: TReal; var KASE: longint;
  var ISAVE: array of longint);
const
  ITMAX = 5;
  ONE: TReal = 1;
  TWO: TReal = 2;
var
  I, JLAST: longint;
  ALTSGN, ESTOLD, TEMP, XS: TReal;
  CONVERGED: boolean;

  { Label 50 of DLACN2: X := e_j for the index j in ISAVE(2). }
  procedure UNITVECTOR;
  var
    LIndex: longint;
  begin
    for LIndex := 0 to N - 1 do X[LIndex] := 0;
    X[ISAVE[1]] := ONE;
    KASE := 1;
    ISAVE[0] := 3;
  end;

  { Label 120 of DLACN2: iteration complete, final stage. }
  procedure FINALSTAGE;
  var
    LIndex: longint;
  begin
    ALTSGN := ONE;
    for LIndex := 0 to N - 1 do
    begin
      X[LIndex] := ALTSGN * (ONE + TReal(LIndex) / TReal(N - 1));
      ALTSGN := -ALTSGN;
    end;
    KASE := 1;
    ISAVE[0] := 5;
  end;

begin
  if KASE = 0 then
  begin
    for I := 0 to N - 1 do X[I] := ONE / TReal(N);
    KASE := 1;
    ISAVE[0] := 1;
    Exit;
  end;
  case ISAVE[0] of
    1:
      { First iteration: X has been overwritten by A*X. }
      if N = 1 then
      begin
        V[0] := X[0];
        EST := System.Abs(V[0]);
        KASE := 0;
      end else
      begin
        EST := specialize ASUM<TReal>(N, X, 0, 1);
        for I := 0 to N - 1 do
        begin
          if X[I] >= 0 then X[I] := ONE else X[I] := -ONE;
          ISGN[I] := Round(X[I]);
        end;
        KASE := 2;
        ISAVE[0] := 2;
      end;
    2:
      { First iteration: X has been overwritten by A^T*X. }
      begin
        ISAVE[1] := specialize IAMAX<TReal>(N, X, 0, 1);
        ISAVE[2] := 2;
        UNITVECTOR;
      end;
    3:
      { X has been overwritten by A*X. }
      begin
        for I := 0 to N - 1 do V[I] := X[I];
        ESTOLD := EST;
        EST := specialize ASUM<TReal>(N, V, 0, 1);
        CONVERGED := True;
        for I := 0 to N - 1 do
        begin
          if X[I] >= 0 then XS := ONE else XS := -ONE;
          if Round(XS) <> ISGN[I] then
          begin
            CONVERGED := False;
            Break;
          end;
        end;
        { Repeated sign vector detected, hence algorithm has converged;
          otherwise test for cycling. }
        if CONVERGED or (EST <= ESTOLD) then
          FINALSTAGE
        else
        begin
          for I := 0 to N - 1 do
          begin
            if X[I] >= 0 then X[I] := ONE else X[I] := -ONE;
            ISGN[I] := Round(X[I]);
          end;
          KASE := 2;
          ISAVE[0] := 4;
        end;
      end;
    4:
      { X has been overwritten by A^T*X. }
      begin
        JLAST := ISAVE[1];
        ISAVE[1] := specialize IAMAX<TReal>(N, X, 0, 1);
        if (X[JLAST] <> System.Abs(X[ISAVE[1]])) and (ISAVE[2] < ITMAX) then
        begin
          Inc(ISAVE[2]);
          UNITVECTOR;
        end else
          FINALSTAGE;
      end;
    5:
      { X has been overwritten by A*X. }
      begin
        TEMP := TWO * (specialize ASUM<TReal>(N, X, 0, 1) / TReal(3 * N));
        if TEMP > EST then
        begin
          for I := 0 to N - 1 do V[I] := X[I];
          EST := TEMP;
        end;
        KASE := 0;
      end;
  end;
end;

{ IZMAX1: 0-based index of the first entry of largest modulus. }
function IZMAX1(N: longint; const X: array of TComplex): longint;
var
  I: longint;
  DMAX: TReal;
begin
  result := -1;
  if N < 1 then Exit;
  result := 0;
  if N = 1 then Exit;
  DMAX := ZABS(X[0]);
  for I := 1 to N - 1 do
    if ZABS(X[I]) > DMAX then
    begin
      result := I;
      DMAX := ZABS(X[I]);
    end;
end;

{ DZSUM1: sum of the moduli of N entries. }
function DZSUM1(N: longint; const X: array of TComplex): TReal;
var
  I: longint;
begin
  result := 0;
  for I := 0 to N - 1 do result := result + ZABS(X[I]);
end;

{ ZLACN2 (LAPACK 3.12.1): estimate of the 1-norm of a square complex
  matrix by reverse communication. }
procedure ZLACN2(N: longint; var V, X: array of TComplex; var EST: TReal;
  var KASE: longint; var ISAVE: array of longint);
const
  ITMAX = 5;
  ONE: TReal = 1;
  TWO: TReal = 2;
var
  I, JLAST: longint;
  ABSXI, ALTSGN, ESTOLD, SAFMIN, TEMP: TReal;

  { X(i) := X(i)/|X(i)|, or 1 when |X(i)| <= SAFMIN. }
  procedure SIGNVECTOR;
  var
    LIndex: longint;
  begin
    for LIndex := 0 to N - 1 do
    begin
      ABSXI := ZABS(X[LIndex]);
      if ABSXI > SAFMIN then
      begin
        X[LIndex].Re := X[LIndex].Re / ABSXI;
        X[LIndex].Im := X[LIndex].Im / ABSXI;
      end else
        X[LIndex] := ONE;
    end;
  end;

  { Label 50 of ZLACN2: X := e_j for the index j in ISAVE(2). }
  procedure UNITVECTOR;
  var
    LIndex: longint;
  begin
    for LIndex := 0 to N - 1 do X[LIndex] := 0;
    X[ISAVE[1]] := ONE;
    KASE := 1;
    ISAVE[0] := 3;
  end;

  { Label 100 of ZLACN2: iteration complete, final stage. }
  procedure FINALSTAGE;
  var
    LIndex: longint;
  begin
    ALTSGN := ONE;
    for LIndex := 0 to N - 1 do
    begin
      X[LIndex] := ALTSGN * (ONE + TReal(LIndex) / TReal(N - 1));
      ALTSGN := -ALTSGN;
    end;
    KASE := 1;
    ISAVE[0] := 5;
  end;

begin
  SAFMIN := LapackSafeMinimum;
  if KASE = 0 then
  begin
    for I := 0 to N - 1 do X[I] := ONE / TReal(N);
    KASE := 1;
    ISAVE[0] := 1;
    Exit;
  end;
  case ISAVE[0] of
    1:
      { First iteration: X has been overwritten by A*X. }
      if N = 1 then
      begin
        V[0] := X[0];
        EST := ZABS(V[0]);
        KASE := 0;
      end else
      begin
        EST := DZSUM1(N, X);
        SIGNVECTOR;
        KASE := 2;
        ISAVE[0] := 2;
      end;
    2:
      { First iteration: X has been overwritten by A^H*X. }
      begin
        ISAVE[1] := IZMAX1(N, X);
        ISAVE[2] := 2;
        UNITVECTOR;
      end;
    3:
      { X has been overwritten by A*X. }
      begin
        for I := 0 to N - 1 do V[I] := X[I];
        ESTOLD := EST;
        EST := DZSUM1(N, V);
        if EST <= ESTOLD then
          FINALSTAGE
        else
        begin
          SIGNVECTOR;
          KASE := 2;
          ISAVE[0] := 4;
        end;
      end;
    4:
      { X has been overwritten by A^H*X. }
      begin
        JLAST := ISAVE[1];
        ISAVE[1] := IZMAX1(N, X);
        if (ZABS(X[JLAST]) <> ZABS(X[ISAVE[1]])) and (ISAVE[2] < ITMAX) then
        begin
          Inc(ISAVE[2]);
          UNITVECTOR;
        end else
          FINALSTAGE;
      end;
    5:
      { X has been overwritten by A*X. }
      begin
        TEMP := TWO * (DZSUM1(N, X) / TReal(3 * N));
        if TEMP > EST then
        begin
          for I := 0 to N - 1 do V[I] := X[I];
          EST := TEMP;
        end;
        KASE := 0;
      end;
  end;
end;

{ Overloads that let the generic xGECON call the routines of its type. }
procedure LACN2(N: longint; var V, X: array of TReal;
  var ISGN: array of longint; var EST: TReal; var KASE: longint;
  var ISAVE: array of longint); overload;
begin
  DLACN2(N, V, X, ISGN, EST, KASE, ISAVE);
end;

procedure LACN2(N: longint; var V, X: array of TComplex;
  var ISGN: array of longint; var EST: TReal; var KASE: longint;
  var ISAVE: array of longint); overload;
begin
  ZLACN2(N, V, X, EST, KASE, ISAVE);
end;

procedure LATRS(UPLO, TRANS, DIAG, NORMIN: char; N: longint;
  const A: array of TReal; AO, LDA: longint; var X: array of TReal;
  out SCALE: TReal; var CNORM: array of TReal); overload;
begin
  DLATRS(UPLO, TRANS, DIAG, NORMIN, N, A, AO, LDA, X, SCALE, CNORM);
end;

procedure LATRS(UPLO, TRANS, DIAG, NORMIN: char; N: longint;
  const A: array of TComplex; AO, LDA: longint; var X: array of TComplex;
  out SCALE: TReal; var CNORM: array of TReal); overload;
begin
  ZLATRS(UPLO, TRANS, DIAG, NORMIN, N, A, AO, LDA, X, SCALE, CNORM);
end;

{ xGECON (LAPACK 3.12.1). TRANS 'C' of the transposed solves is 'T' in
  DGECON and 'C' in ZGECON, the same for real matrices. }
generic procedure GECON<T>(NORM: char; N: longint; const A: array of T;
  AO, LDA: longint; ANORM: TReal; out RCOND: TReal; out INFO: longint);
var
  ONENRM: boolean;
  SMLNUM, AINVNM, SCALE, SL, SU, HUGEVAL: TReal;
  NORMIN: char;
  KASE, KASE1, IX: longint;
  ISAVE: array[0..2] of longint;
  WORK, V: array of T;
  ISGN: array of longint;
  CNORML, CNORMU: array of TReal;
begin
  HUGEVAL := LapackOverflow;
  INFO := 0;
  ONENRM := (NORM = '1') or (NORM = 'O');
  { Quick return if possible. }
  RCOND := 0;
  if N = 0 then
  begin
    RCOND := 1;
    Exit;
  end else if ANORM = 0 then
    Exit
  else if IsNan(ANORM) then
  begin
    RCOND := ANORM;
    INFO := -5;
    Exit;
  end else if ANORM > HUGEVAL then
  begin
    INFO := -5;
    Exit;
  end;
  SMLNUM := LapackSafeMinimum;
  WORK := nil;
  V := nil;
  ISGN := nil;
  CNORML := nil;
  CNORMU := nil;
  SetLength(WORK, N);
  SetLength(V, N);
  SetLength(ISGN, N);
  SetLength(CNORML, N);
  SetLength(CNORMU, N);
  { Estimate the norm of inv(A). }
  AINVNM := 0;
  NORMIN := 'N';
  if ONENRM then KASE1 := 1 else KASE1 := 2;
  KASE := 0;
  repeat
    LACN2(N, V, WORK, ISGN, AINVNM, KASE, ISAVE);
    if KASE = 0 then Break;
    if KASE = KASE1 then
    begin
      { Multiply by inv(L), then by inv(U). }
      LATRS('L', 'N', 'U', NORMIN, N, A, AO, LDA, WORK, SL, CNORML);
      LATRS('U', 'N', 'N', NORMIN, N, A, AO, LDA, WORK, SU, CNORMU);
    end else
    begin
      { Multiply by inv(U^H), then by inv(L^H). }
      LATRS('U', 'C', 'N', NORMIN, N, A, AO, LDA, WORK, SU, CNORMU);
      LATRS('L', 'C', 'U', NORMIN, N, A, AO, LDA, WORK, SL, CNORML);
    end;
    { Divide X by 1/(SL*SU) if doing so will not cause overflow. }
    SCALE := SL * SU;
    NORMIN := 'Y';
    if SCALE <> 1 then
    begin
      IX := specialize IAMAX<T>(N, WORK, 0, 1);
      if (SCALE < CABS1(WORK[IX]) * SMLNUM) or (SCALE = 0) then Exit;
      specialize RSCL<T>(N, SCALE, WORK, 0, 1);
    end;
  until False;
  { Compute the estimate of the reciprocal condition number. }
  if AINVNM <> 0 then
    RCOND := (1 / AINVNM) / ANORM
  else
  begin
    INFO := 1;
    Exit;
  end;
  { Check for NaNs and Infs. }
  if IsNan(RCOND) or (RCOND > HUGEVAL) then INFO := 1;
end;

{ ---------------------------------------------------------------------
  Symmetric and Hermitian eigenproblem (LAPACK 3.12.1): xSYEV/xHEEV with
  xSYTRD/xHETRD, xORGTR/xUNGTR and xSTEQR, and the BLAS they use. The
  real (xSY) and the complex Hermitian (xHE) routines are written once;
  where the complex routine forces a diagonal entry to be real or
  conjugates a vector, the real one does nothing (MAKEREAL, LACGV).
  --------------------------------------------------------------------- }

{ ILAENV(1) and ILAENV(3) with the defaults of LAPACK's ILAENV, unless
  LapackBlockSize or LapackCrossover set other values. }
function ILAENVNB(ADefault: longint): longint;
begin
  if LapackBlockSize < 0 then result := ADefault else result := LapackBlockSize;
end;

function ILAENVNX(ADefault: longint): longint;
begin
  if LapackCrossover < 0 then result := ADefault else result := LapackCrossover;
end;

{ R*X, with gfortran's arithmetic for a complex X ((R, 0)*X). }
function RMUL(R: TReal; const X: TReal): TReal; overload; inline;
begin
  result := R * X;
end;

function RMUL(R: TReal; const X: TComplex): TComplex; overload; inline;
begin
  result := FMUL(R, X);
end;

{ DBLE(X) stored back as an entry: (Re X, 0); X for a real number. }
function MAKEREAL(const X: TReal): TReal; overload; inline;
begin
  result := X;
end;

function MAKEREAL(const X: TComplex): TComplex; overload; inline;
begin
  result.Re := X.Re;
  result.Im := 0;
end;

{ DBLE(X). }
function REALOF(const X: TReal): TReal; overload; inline;
begin
  result := X;
end;

function REALOF(const X: TComplex): TReal; overload; inline;
begin
  result := X.Re;
end;

{ TEMP1*A(j,j) of DSYMV, TEMP1*DBLE(A(j,j)) of ZHEMV. }
function DIAGMUL(const TEMP1, AJJ: TReal): TReal; overload; inline;
begin
  result := TEMP1 * AJJ;
end;

function DIAGMUL(const TEMP1, AJJ: TComplex): TComplex; overload; inline;
begin
  result := FMUL(AJJ.Re, TEMP1);
end;

{ The diagonal update of xSYR2 and xSYR2K: A(j,j) + X*T1 + Y*T2 for a real
  matrix, DBLE(A(j,j)) + DBLE(X*T1 + Y*T2) for a Hermitian one. }
function HERUPD(const AJJ, X, T1, Y, T2: TReal): TReal; overload; inline;
begin
  result := AJJ + X * T1 + Y * T2;
end;

function HERUPD(const AJJ, X, T1, Y, T2: TComplex): TComplex; overload; inline;
begin
  result.Re := AJJ.Re + (X * T1 + Y * T2).Re;
  result.Im := 0;
end;

{ BETA*A(j,j) of DSYR2K, BETA*DBLE(C(j,j)) of ZHER2K. }
function DIAGSCALE(BETA: TReal; const CJJ: TReal): TReal; overload; inline;
begin
  result := BETA * CJJ;
end;

function DIAGSCALE(BETA: TReal; const CJJ: TComplex): TComplex; overload;
  inline;
begin
  result.Re := BETA * CJJ.Re;
  result.Im := 0;
end;

{ ZLACGV: conjugates N entries; nothing for real ones. }
procedure LACGV(N: longint; var X: array of TReal; XO, INCX: longint);
  overload; inline;
begin
end;

procedure LACGV(N: longint; var X: array of TComplex; XO, INCX: longint);
  overload;
var
  I: longint;
begin
  for I := 0 to N - 1 do
    X[XO + I * INCX].Im := -X[XO + I * INCX].Im;
end;

{ DSYMV, ZHEMV: y := alpha*A*x + beta*y with A symmetric (Hermitian),
  stored in the UPLO triangle. }
generic procedure SYMV<T>(UPLO: char; N: longint; const ALPHA: T;
  const A: array of T; AO, LDA: longint; const X: array of T;
  XO, INCX: longint; const BETA: T; var Y: array of T; YO, INCY: longint);
var
  I, J, KX, KY, IX, IY, JX, JY: longint;
  TEMP1, TEMP2: T;
begin
  if (N = 0) or (ISZERO(ALPHA) and ISONE(BETA)) then Exit;
  KX := VSTART(N, XO, INCX);
  KY := VSTART(N, YO, INCY);
  { First form y := beta*y. }
  if not ISONE(BETA) then
  begin
    IY := KY;
    for I := 0 to N - 1 do
    begin
      if ISZERO(BETA) then Y[IY] := 0 else Y[IY] := BETA * Y[IY];
      IY := IY + INCY;
    end;
  end;
  if ISZERO(ALPHA) then Exit;
  JX := KX;
  JY := KY;
  if UPLO = 'U' then
    { Form y when A is stored in the upper triangle. }
    for J := 0 to N - 1 do
    begin
      TEMP1 := ALPHA * X[JX];
      TEMP2 := 0;
      IX := KX;
      IY := KY;
      for I := 0 to J - 1 do
      begin
        MADD(Y[IY], TEMP1, A[AO + I * LDA + J]);
        MADD(TEMP2, CONJ(A[AO + I * LDA + J]), X[IX]);
        IX := IX + INCX;
        IY := IY + INCY;
      end;
      Y[JY] := Y[JY] + DIAGMUL(TEMP1, A[AO + J * LDA + J]) + ALPHA * TEMP2;
      JX := JX + INCX;
      JY := JY + INCY;
    end
  else
    { Form y when A is stored in the lower triangle. }
    for J := 0 to N - 1 do
    begin
      TEMP1 := ALPHA * X[JX];
      TEMP2 := 0;
      Y[JY] := Y[JY] + DIAGMUL(TEMP1, A[AO + J * LDA + J]);
      IX := JX;
      IY := JY;
      for I := J + 1 to N - 1 do
      begin
        IX := IX + INCX;
        IY := IY + INCY;
        MADD(Y[IY], TEMP1, A[AO + I * LDA + J]);
        MADD(TEMP2, CONJ(A[AO + I * LDA + J]), X[IX]);
      end;
      Y[JY] := Y[JY] + ALPHA * TEMP2;
      JX := JX + INCX;
      JY := JY + INCY;
    end;
end;

{ DSYR2, ZHER2: A := alpha*x*y^H + conj(alpha)*y*x^H + A on the UPLO
  triangle. }
generic procedure SYR2<T>(UPLO: char; N: longint; const ALPHA: T;
  const X: array of T; XO, INCX: longint; const Y: array of T;
  YO, INCY: longint; var A: array of T; AO, LDA: longint);
var
  I, J, KX, KY, IX, IY, JX, JY: longint;
  TEMP1, TEMP2: T;
begin
  if (N = 0) or ISZERO(ALPHA) then Exit;
  KX := VSTART(N, XO, INCX);
  KY := VSTART(N, YO, INCY);
  JX := KX;
  JY := KY;
  for J := 0 to N - 1 do
  begin
    if not ISZERO(X[JX]) or not ISZERO(Y[JY]) then
    begin
      TEMP1 := ALPHA * CONJ(Y[JY]);
      TEMP2 := CONJ(ALPHA * X[JX]);
      if UPLO = 'U' then
      begin
        IX := KX;
        IY := KY;
        for I := 0 to J - 1 do
        begin
          A[AO + I * LDA + J] := A[AO + I * LDA + J] + X[IX] * TEMP1 +
            Y[IY] * TEMP2;
          IX := IX + INCX;
          IY := IY + INCY;
        end;
        A[AO + J * LDA + J] := HERUPD(A[AO + J * LDA + J], X[JX], TEMP1,
          Y[JY], TEMP2);
      end else
      begin
        A[AO + J * LDA + J] := HERUPD(A[AO + J * LDA + J], X[JX], TEMP1,
          Y[JY], TEMP2);
        IX := JX;
        IY := JY;
        for I := J + 1 to N - 1 do
        begin
          IX := IX + INCX;
          IY := IY + INCY;
          A[AO + I * LDA + J] := A[AO + I * LDA + J] + X[IX] * TEMP1 +
            Y[IY] * TEMP2;
        end;
      end;
    end else
      A[AO + J * LDA + J] := MAKEREAL(A[AO + J * LDA + J]);
    JX := JX + INCX;
    JY := JY + INCY;
  end;
end;

{ DSYR2K, ZHER2K with TRANS = 'N' (the only form xSYTRD uses):
  C := alpha*A*B^H + conj(alpha)*B*A^H + beta*C on the UPLO triangle of
  the N x N matrix C, A and B N x K, beta real. }
generic procedure SYR2K<T>(UPLO: char; N, K: longint; const ALPHA: T;
  const A: array of T; AO, LDA: longint; const B: array of T;
  BO, LDB: longint; BETA: TReal; var C: array of T; CO, LDC: longint);
var
  I, J, L, I1, I2: longint;
  UPPER: boolean;
  TEMP1, TEMP2: T;
begin
  UPPER := UPLO = 'U';
  if (N = 0) or ((ISZERO(ALPHA) or (K = 0)) and (BETA = 1)) then Exit;
  for J := 0 to N - 1 do
  begin
    if UPPER then
    begin
      I1 := 0;
      I2 := J - 1;
    end else
    begin
      I1 := J + 1;
      I2 := N - 1;
    end;
    { C := beta*C on column j of the triangle. }
    if BETA = 0 then
    begin
      for I := I1 to I2 do C[CO + I * LDC + J] := 0;
      C[CO + J * LDC + J] := 0;
    end else if BETA <> 1 then
    begin
      for I := I1 to I2 do
        C[CO + I * LDC + J] := RMUL(BETA, C[CO + I * LDC + J]);
      C[CO + J * LDC + J] := DIAGSCALE(BETA, C[CO + J * LDC + J]);
    end else if not ISZERO(ALPHA) then
      C[CO + J * LDC + J] := MAKEREAL(C[CO + J * LDC + J]);
    if ISZERO(ALPHA) then Continue;
    for L := 0 to K - 1 do
      if not ISZERO(A[AO + J * LDA + L]) or not ISZERO(B[BO + J * LDB + L]) then
      begin
        TEMP1 := ALPHA * CONJ(B[BO + J * LDB + L]);
        TEMP2 := CONJ(ALPHA * A[AO + J * LDA + L]);
        for I := I1 to I2 do
          C[CO + I * LDC + J] := C[CO + I * LDC + J] +
            A[AO + I * LDA + L] * TEMP1 + B[BO + I * LDB + L] * TEMP2;
        C[CO + J * LDC + J] := HERUPD(C[CO + J * LDC + J],
          A[AO + J * LDA + L], TEMP1, B[BO + J * LDB + L], TEMP2);
      end;
  end;
end;

{ xLANSY, xLANHE with NORM = 'M': the largest |A(i,j)| of the UPLO
  triangle (the real part of the diagonal for a Hermitian matrix). }
generic function LANSYMAX<T>(UPLO: char; N: longint; const A: array of T;
  AO, LDA: longint): TReal;
var
  I, J: longint;
  SUM: TReal;
begin
  result := 0;
  for J := 0 to N - 1 do
  begin
    if UPLO <> 'U' then
    begin
      SUM := System.Abs(REALOF(A[AO + J * LDA + J]));
      if (result < SUM) or IsNan(SUM) then result := SUM;
    end;
    if UPLO = 'U' then
      for I := 0 to J - 1 do
      begin
        SUM := ABSX(A[AO + I * LDA + J]);
        if (result < SUM) or IsNan(SUM) then result := SUM;
      end
    else
      for I := J + 1 to N - 1 do
      begin
        SUM := ABSX(A[AO + I * LDA + J]);
        if (result < SUM) or IsNan(SUM) then result := SUM;
      end;
    if UPLO = 'U' then
    begin
      SUM := System.Abs(REALOF(A[AO + J * LDA + J]));
      if (result < SUM) or IsNan(SUM) then result := SUM;
    end;
  end;
end;

{ xLASCL: multiplies the M x N matrix A by CTO/CFROM without overflow or
  underflow; TYPE 'G' (full), 'L' (lower triangle) or 'U' (upper). }
generic procedure LASCLT<T>(ATYPE: char; CFROM, CTO: TReal; M, N: longint;
  var A: array of T; AO, LDA: longint);
var
  SMLNUM, BIGNUM, CFROMC, CTOC, CFROM1, CTO1, MUL: TReal;
  DONE: boolean;
  I, J, I1, I2: longint;
begin
  if (N = 0) or (M = 0) then Exit;
  SMLNUM := LapackSafeMinimum;
  BIGNUM := 1 / SMLNUM;
  CFROMC := CFROM;
  CTOC := CTO;
  repeat
    CFROM1 := CFROMC * SMLNUM;
    if CFROM1 = CFROMC then
    begin
      { CFROMC is an inf. Multiply by a correctly signed zero for finite
        CTOC, or a NaN if CTOC is infinite. }
      MUL := CTOC / CFROMC;
      DONE := True;
    end else
    begin
      CTO1 := CTOC / BIGNUM;
      if CTO1 = CTOC then
      begin
        { CTOC is either 0 or an inf. }
        MUL := CTOC;
        DONE := True;
        CFROMC := 1;
      end else if (System.Abs(CFROM1) > System.Abs(CTOC)) and (CTOC <> 0) then
      begin
        MUL := SMLNUM;
        DONE := False;
        CFROMC := CFROM1;
      end else if System.Abs(CTO1) > System.Abs(CFROMC) then
      begin
        MUL := BIGNUM;
        DONE := False;
        CTOC := CTO1;
      end else
      begin
        MUL := CTOC / CFROMC;
        DONE := True;
        if MUL = 1 then Exit;
      end;
    end;
    for J := 0 to N - 1 do
    begin
      case ATYPE of
        'L':
          begin
            I1 := J;
            I2 := M - 1;
          end;
        'U':
          begin
            I1 := 0;
            I2 := Min(J, M - 1);
          end;
      else
        I1 := 0;
        I2 := M - 1;
      end;
      for I := I1 to I2 do
        A[AO + I * LDA + J] := RMUL(MUL, A[AO + I * LDA + J]);
    end;
  until DONE;
end;

{ xSYTD2, xHETD2: unblocked reduction of a symmetric (Hermitian) matrix
  to real symmetric tridiagonal form Q^H*A*Q = T, stored in the UPLO
  triangle; D (N entries), E and TAU (N-1 entries) at the offsets. }
generic procedure SYTD2<T>(UPLO: char; N: longint; var A: array of T;
  AO, LDA: longint; var D: array of TReal; DO_: longint;
  var E: array of TReal; EO: longint; var TAU: array of T; TO_: longint);
var
  I: longint;
  ALPHA, TAUI, ONE, HALF: T;
begin
  if N <= 0 then Exit;
  ONE := 1;
  HALF := 0.5;
  if UPLO = 'U' then
  begin
    { Reduce the upper triangle of A. }
    A[AO + (N - 1) * LDA + N - 1] := MAKEREAL(A[AO + (N - 1) * LDA + N - 1]);
    for I := N - 2 downto 0 do
    begin
      { Generate the elementary reflector H(i) = I - tau*v*v^H to
        annihilate A(0:i-1, i+1). }
      ALPHA := A[AO + I * LDA + I + 1];
      LARFG(I + 1, ALPHA, A, AO + I + 1, LDA, TAUI);
      E[EO + I] := REALOF(ALPHA);
      if not ISZERO(TAUI) then
      begin
        { Apply H(i) from both sides to A(0:i, 0:i). }
        A[AO + I * LDA + I + 1] := ONE;
        { Compute x := tau*A*v, storing x in TAU(0:i). }
        specialize SYMV<T>(UPLO, I + 1, TAUI, A, AO, LDA, A, AO + I + 1, LDA,
          0, TAU, TO_, 1);
        { Compute w := x - 1/2*tau*(x^H*v)*v. }
        ALPHA := -(HALF * TAUI * specialize DOT<T>(True, I + 1, TAU, TO_, 1,
          A, AO + I + 1, LDA));
        specialize AXPY<T>(I + 1, ALPHA, A, AO + I + 1, LDA, TAU, TO_, 1);
        { Apply the transformation as a rank-2 update:
          A := A - v*w^H - w*v^H. }
        specialize SYR2<T>(UPLO, I + 1, -ONE, A, AO + I + 1, LDA, TAU, TO_, 1,
          A, AO, LDA);
      end else
        A[AO + I * LDA + I] := MAKEREAL(A[AO + I * LDA + I]);
      A[AO + I * LDA + I + 1] := E[EO + I];
      D[DO_ + I + 1] := REALOF(A[AO + (I + 1) * LDA + I + 1]);
      TAU[TO_ + I] := TAUI;
    end;
    D[DO_] := REALOF(A[AO]);
  end else
  begin
    { Reduce the lower triangle of A. }
    A[AO] := MAKEREAL(A[AO]);
    for I := 0 to N - 2 do
    begin
      { Generate the elementary reflector H(i) = I - tau*v*v^H to
        annihilate A(i+2:n-1, i). }
      ALPHA := A[AO + (I + 1) * LDA + I];
      LARFG(N - 1 - I, ALPHA, A, AO + Min(I + 2, N - 1) * LDA + I, LDA, TAUI);
      E[EO + I] := REALOF(ALPHA);
      if not ISZERO(TAUI) then
      begin
        { Apply H(i) from both sides to A(i+1:n-1, i+1:n-1). }
        A[AO + (I + 1) * LDA + I] := ONE;
        { Compute x := tau*A*v, storing x in TAU(i:n-2). }
        specialize SYMV<T>(UPLO, N - 1 - I, TAUI, A,
          AO + (I + 1) * LDA + I + 1, LDA, A, AO + (I + 1) * LDA + I, LDA, 0,
          TAU, TO_ + I, 1);
        { Compute w := x - 1/2*tau*(x^H*v)*v. }
        ALPHA := -(HALF * TAUI * specialize DOT<T>(True, N - 1 - I, TAU,
          TO_ + I, 1, A, AO + (I + 1) * LDA + I, LDA));
        specialize AXPY<T>(N - 1 - I, ALPHA, A, AO + (I + 1) * LDA + I, LDA,
          TAU, TO_ + I, 1);
        { Apply the transformation as a rank-2 update. }
        specialize SYR2<T>(UPLO, N - 1 - I, -ONE, A, AO + (I + 1) * LDA + I,
          LDA, TAU, TO_ + I, 1, A, AO + (I + 1) * LDA + I + 1, LDA);
      end else
        A[AO + (I + 1) * LDA + I + 1] :=
          MAKEREAL(A[AO + (I + 1) * LDA + I + 1]);
      A[AO + (I + 1) * LDA + I] := E[EO + I];
      D[DO_ + I] := REALOF(A[AO + I * LDA + I]);
      TAU[TO_ + I] := TAUI;
    end;
    D[DO_ + N - 1] := REALOF(A[AO + (N - 1) * LDA + N - 1]);
  end;
end;

{ xLATRD: reduces NB rows and columns of a symmetric (Hermitian) matrix
  to tridiagonal form and returns the N x NB matrix W (row stride LDW)
  needed to update the rest, A := A - V*W^H - W*V^H. }
generic procedure LATRD<T>(UPLO: char; N, NB: longint; var A: array of T;
  AO, LDA: longint; var E: array of TReal; EO: longint; var TAU: array of T;
  TO_: longint; var W: array of T; WO, LDW: longint);
var
  I, IW: longint;
  ALPHA, ONE, HALF: T;
begin
  if N <= 0 then Exit;
  ONE := 1;
  HALF := 0.5;
  if UPLO = 'U' then
  begin
    { Reduce last NB columns of upper triangle. }
    for I := N - 1 downto N - NB do
    begin
      IW := I - N + NB;
      if I < N - 1 then
      begin
        { Update A(0:i, i). }
        A[AO + I * LDA + I] := MAKEREAL(A[AO + I * LDA + I]);
        LACGV(N - 1 - I, W, WO + I * LDW + IW + 1, 1);
        specialize GEMV<T>('N', I + 1, N - 1 - I, -ONE, A, AO + I + 1, LDA,
          W, WO + I * LDW + IW + 1, 1, ONE, A, AO + I, LDA);
        LACGV(N - 1 - I, W, WO + I * LDW + IW + 1, 1);
        LACGV(N - 1 - I, A, AO + I * LDA + I + 1, 1);
        specialize GEMV<T>('N', I + 1, N - 1 - I, -ONE, W, WO + IW + 1, LDW,
          A, AO + I * LDA + I + 1, 1, ONE, A, AO + I, LDA);
        LACGV(N - 1 - I, A, AO + I * LDA + I + 1, 1);
        A[AO + I * LDA + I] := MAKEREAL(A[AO + I * LDA + I]);
      end;
      if I > 0 then
      begin
        { Generate elementary reflector H(i) to annihilate A(0:i-2, i). }
        ALPHA := A[AO + (I - 1) * LDA + I];
        LARFG(I, ALPHA, A, AO + I, LDA, TAU[TO_ + I - 1]);
        E[EO + I - 1] := REALOF(ALPHA);
        A[AO + (I - 1) * LDA + I] := ONE;
        { Compute W(0:i-1, iw). }
        specialize SYMV<T>('U', I, ONE, A, AO, LDA, A, AO + I, LDA, 0, W,
          WO + IW, LDW);
        if I < N - 1 then
        begin
          specialize GEMV<T>('C', I, N - 1 - I, ONE, W, WO + IW + 1, LDW, A,
            AO + I, LDA, 0, W, WO + (I + 1) * LDW + IW, LDW);
          specialize GEMV<T>('N', I, N - 1 - I, -ONE, A, AO + I + 1, LDA, W,
            WO + (I + 1) * LDW + IW, LDW, ONE, W, WO + IW, LDW);
          specialize GEMV<T>('C', I, N - 1 - I, ONE, A, AO + I + 1, LDA, A,
            AO + I, LDA, 0, W, WO + (I + 1) * LDW + IW, LDW);
          specialize GEMV<T>('N', I, N - 1 - I, -ONE, W, WO + IW + 1, LDW, W,
            WO + (I + 1) * LDW + IW, LDW, ONE, W, WO + IW, LDW);
        end;
        specialize SCAL<T>(I, TAU[TO_ + I - 1], W, WO + IW, LDW);
        ALPHA := -(HALF * TAU[TO_ + I - 1] * specialize DOT<T>(True, I, W,
          WO + IW, LDW, A, AO + I, LDA));
        specialize AXPY<T>(I, ALPHA, A, AO + I, LDA, W, WO + IW, LDW);
      end;
    end;
  end else
  begin
    { Reduce first NB columns of lower triangle. }
    for I := 0 to NB - 1 do
    begin
      { Update A(i:n-1, i). }
      A[AO + I * LDA + I] := MAKEREAL(A[AO + I * LDA + I]);
      LACGV(I, W, WO + I * LDW, 1);
      specialize GEMV<T>('N', N - I, I, -ONE, A, AO + I * LDA, LDA, W,
        WO + I * LDW, 1, ONE, A, AO + I * LDA + I, LDA);
      LACGV(I, W, WO + I * LDW, 1);
      LACGV(I, A, AO + I * LDA, 1);
      specialize GEMV<T>('N', N - I, I, -ONE, W, WO + I * LDW, LDW, A,
        AO + I * LDA, 1, ONE, A, AO + I * LDA + I, LDA);
      LACGV(I, A, AO + I * LDA, 1);
      A[AO + I * LDA + I] := MAKEREAL(A[AO + I * LDA + I]);
      if I < N - 1 then
      begin
        { Generate elementary reflector H(i) to annihilate
          A(i+2:n-1, i). }
        ALPHA := A[AO + (I + 1) * LDA + I];
        LARFG(N - 1 - I, ALPHA, A, AO + Min(I + 2, N - 1) * LDA + I, LDA,
          TAU[TO_ + I]);
        E[EO + I] := REALOF(ALPHA);
        A[AO + (I + 1) * LDA + I] := ONE;
        { Compute W(i+1:n-1, i). }
        specialize SYMV<T>('L', N - 1 - I, ONE, A, AO + (I + 1) * LDA + I + 1,
          LDA, A, AO + (I + 1) * LDA + I, LDA, 0, W, WO + (I + 1) * LDW + I,
          LDW);
        specialize GEMV<T>('C', N - 1 - I, I, ONE, W, WO + (I + 1) * LDW, LDW,
          A, AO + (I + 1) * LDA + I, LDA, 0, W, WO + I, LDW);
        specialize GEMV<T>('N', N - 1 - I, I, -ONE, A, AO + (I + 1) * LDA,
          LDA, W, WO + I, LDW, ONE, W, WO + (I + 1) * LDW + I, LDW);
        specialize GEMV<T>('C', N - 1 - I, I, ONE, A, AO + (I + 1) * LDA, LDA,
          A, AO + (I + 1) * LDA + I, LDA, 0, W, WO + I, LDW);
        specialize GEMV<T>('N', N - 1 - I, I, -ONE, W, WO + (I + 1) * LDW,
          LDW, W, WO + I, LDW, ONE, W, WO + (I + 1) * LDW + I, LDW);
        specialize SCAL<T>(N - 1 - I, TAU[TO_ + I], W, WO + (I + 1) * LDW + I,
          LDW);
        ALPHA := -(HALF * TAU[TO_ + I] * specialize DOT<T>(True, N - 1 - I, W,
          WO + (I + 1) * LDW + I, LDW, A, AO + (I + 1) * LDA + I, LDA));
        specialize AXPY<T>(N - 1 - I, ALPHA, A, AO + (I + 1) * LDA + I, LDA,
          W, WO + (I + 1) * LDW + I, LDW);
      end;
    end;
  end;
end;

{ xSYTRD, xHETRD: reduction to real symmetric tridiagonal form, blocked
  (block size 32, crossover 32 of ILAENV). }
generic procedure SYTRD<T>(UPLO: char; N: longint; var A: array of T;
  AO, LDA: longint; var D, E: array of TReal; var TAU: array of T);
var
  I, J, KK, NB, NX, LDW: longint;
  ONE: T;
  WORK: array of T;
begin
  if N = 0 then Exit;
  ONE := 1;
  NB := ILAENVNB(32);
  NX := N;
  if (NB > 1) and (NB < N) then
  begin
    { Determine when to cross over from blocked to unblocked code (the
      last or only block is always handled by unblocked code). }
    NX := Max(NB, ILAENVNX(32));
    if NX >= N then NX := N;
  end else
    NB := 1;
  LDW := NB;
  WORK := nil;
  if NX < N then SetLength(WORK, N * LDW);
  if UPLO = 'U' then
  begin
    { Reduce the upper triangle of A; columns 0:kk-1 are handled by the
      unblocked method. }
    KK := N - ((N - NX + NB - 1) div NB) * NB;
    I := N - NB;
    while I >= KK do
    begin
      { Reduce columns i:i+nb-1 to tridiagonal form and form the matrix W
        which is needed to update the unreduced part of the matrix. }
      specialize LATRD<T>(UPLO, I + NB, NB, A, AO, LDA, E, 0, TAU, 0, WORK, 0,
        LDW);
      { Update the unreduced submatrix A(0:i-1, 0:i-1), using an update of
        the form A := A - V*W^H - W*V^H. }
      specialize SYR2K<T>(UPLO, I, NB, -ONE, A, AO + I, LDA, WORK, 0, LDW, 1,
        A, AO, LDA);
      { Copy superdiagonal elements back into A, and diagonal elements
        into D. }
      for J := I to I + NB - 1 do
      begin
        A[AO + (J - 1) * LDA + J] := E[J - 1];
        D[J] := REALOF(A[AO + J * LDA + J]);
      end;
      I := I - NB;
    end;
    { Use unblocked code to reduce the last or only block. }
    specialize SYTD2<T>(UPLO, KK, A, AO, LDA, D, 0, E, 0, TAU, 0);
  end else
  begin
    { Reduce the lower triangle of A. }
    I := 0;
    while I < N - NX do
    begin
      specialize LATRD<T>(UPLO, N - I, NB, A, AO + I * LDA + I, LDA, E, I,
        TAU, I, WORK, 0, LDW);
      specialize SYR2K<T>(UPLO, N - I - NB, NB, -ONE, A,
        AO + (I + NB) * LDA + I, LDA, WORK, NB * LDW, LDW, 1, A,
        AO + (I + NB) * LDA + I + NB, LDA);
      for J := I to I + NB - 1 do
      begin
        A[AO + (J + 1) * LDA + J] := E[J];
        D[J] := REALOF(A[AO + J * LDA + J]);
      end;
      I := I + NB;
    end;
    { Use unblocked code to reduce the last or only block. }
    specialize SYTD2<T>(UPLO, N - I, A, AO + I * LDA + I, LDA, D, I, E, I,
      TAU, I);
  end;
end;

{ xLARF1L with SIDE = 'L': H*C for the M x N matrix C with
  H = I - tau*v*v^H, v of M entries whose last one is 1 (not read). }
generic procedure LARF1L<T>(M, N: longint; const V: array of T;
  VO, INCV: longint; const TAU: T; var C: array of T; CO, LDC: longint;
  var WORK: array of T);
var
  I, J, FIRSTV, LASTV, LASTC: longint;
  ONE: T;
begin
  ONE := 1;
  FIRSTV := 1;
  LASTC := 0;
  I := 1;
  LASTV := 0;
  if not ISZERO(TAU) then
  begin
    LASTV := M;
    { Look for the first non-zero of V. }
    while (LASTV > FIRSTV) and ISZERO(V[VO + I - 1]) do
    begin
      Inc(FIRSTV);
      I := I + INCV;
    end;
    { Scan for the last non-zero column in C(0:lastv-1, :). }
    LASTC := specialize ILALC<T>(LASTV, N, C, CO, LDC);
  end;
  if LASTC = 0 then Exit;
  if LASTV > 0 then
    if LASTV = FIRSTV then
      specialize SCAL<T>(LASTC, ONE - TAU, C, CO + (LASTV - 1) * LDC, 1)
    else
    begin
      { w(0:lastc-1) := C(firstv-1:lastv-2, 0:lastc-1)^H * v }
      specialize GEMV<T>('C', LASTV - FIRSTV, LASTC, ONE, C,
        CO + (FIRSTV - 1) * LDC, LDC, V, VO + I - 1, INCV, 0, WORK,
        0, 1);
      { w += C(lastv-1, :)^H }
      for J := 0 to LASTC - 1 do
        WORK[J] := WORK[J] + CONJ(C[CO + (LASTV - 1) * LDC + J]);
      { C(lastv-1, :) -= tau * w^H }
      for J := 0 to LASTC - 1 do
        C[CO + (LASTV - 1) * LDC + J] := C[CO + (LASTV - 1) * LDC + J] -
          TAU * CONJ(WORK[J]);
      { C(firstv-1:lastv-2, :) -= tau * v * w^H }
      specialize GER<T>(True, LASTV - FIRSTV, LASTC, -TAU, V,
        VO + I - 1, INCV, WORK, 0, 1, C, CO + (FIRSTV - 1) * LDC, LDC);
    end;
end;

{ xORG2L, xUNG2L: the M x N matrix Q with orthonormal columns, the last N
  columns of H(k-1)*...*H(1)*H(0) (from xGEQLF). }
generic procedure ORG2L<T>(M, N, K: longint; var A: array of T;
  AO, LDA: longint; const TAU: array of T; TO_: longint);
var
  I, II, J, L: longint;
  ONE: T;
  WORK: array of T;
begin
  if N <= 0 then Exit;
  ONE := 1;
  WORK := nil;
  SetLength(WORK, N);
  { Initialise columns 0:n-k-1 to columns of the unit matrix. }
  for J := 0 to N - K - 1 do
  begin
    for L := 0 to M - 1 do A[AO + L * LDA + J] := 0;
    A[AO + (M - N + J) * LDA + J] := ONE;
  end;
  for I := 0 to K - 1 do
  begin
    II := N - K + I;
    { Apply H(i) to A(0:m-k+i, 0:n-k+i-1) from the left. }
    A[AO + (M - N + II) * LDA + II] := ONE;
    specialize LARF1L<T>(M - N + II + 1, II, A, AO + II, LDA, TAU[TO_ + I],
      A, AO, LDA, WORK);
    specialize SCAL<T>(M - N + II, -TAU[TO_ + I], A, AO + II, LDA);
    A[AO + (M - N + II) * LDA + II] := ONE - TAU[TO_ + I];
    { Set A(m-k+i+1:m-1, ii) to zero. }
    for L := M - N + II + 1 to M - 1 do A[AO + L * LDA + II] := 0;
  end;
end;

{ xLARFT with STOREV = 'C' (recursive, LAPACK 3.12.1): the K x K
  triangular factor T of the block reflector H = I - V*T*V^H, upper for
  DIRECT = 'F' and lower for 'B', from the N x K matrix V. }
generic procedure LARFT<T>(DIRECT: char; N, K: longint; const V: array of T;
  VO, LDV: longint; const TAU: array of T; TO_: longint; var TT: array of T;
  TTO, LDT: longint);
var
  I, J, L: longint;
  ONE, NEGONE: T;
begin
  if (N = 0) or (K = 0) then Exit;
  if (N = 1) or (K = 1) then
  begin
    TT[TTO] := TAU[TO_];
    Exit;
  end;
  ONE := 1;
  NEGONE := -1.0;
  L := K div 2;
  if DIRECT = 'F' then
  begin
    { QR: T = [T1 T3; 0 T2]. }
    specialize LARFT<T>(DIRECT, N, L, V, VO, LDV, TAU, TO_, TT, TTO, LDT);
    specialize LARFT<T>(DIRECT, N - L, K - L, V, VO + L * LDV + L, LDV, TAU,
      TO_ + L, TT, TTO + L * LDT + L, LDT);
    for J := 0 to L - 1 do
      for I := 0 to K - L - 1 do
        TT[TTO + J * LDT + L + I] := CONJ(V[VO + (L + I) * LDV + J]);
    specialize TRMM<T>('R', 'L', 'N', 'U', L, K - L, ONE, V, VO + L * LDV + L,
      LDV, TT, TTO + L, LDT);
    specialize GEMM<T>('C', 'N', L, K - L, N - K, ONE, V, VO + K * LDV, LDV,
      V, VO + K * LDV + L, LDV, ONE, TT, TTO + L, LDT);
    specialize TRMM<T>('L', 'U', 'N', 'N', L, K - L, NEGONE, TT, TTO, LDT, TT,
      TTO + L, LDT);
    specialize TRMM<T>('R', 'U', 'N', 'N', L, K - L, ONE, TT,
      TTO + L * LDT + L, LDT, TT, TTO + L, LDT);
  end else
  begin
    { QL: T = [T1 0; T3 T2]. }
    specialize LARFT<T>(DIRECT, N - L, K - L, V, VO, LDV, TAU, TO_, TT, TTO,
      LDT);
    specialize LARFT<T>(DIRECT, N, L, V, VO + K - L, LDV, TAU, TO_ + K - L,
      TT, TTO + (K - L) * LDT + K - L, LDT);
    for J := 0 to K - L - 1 do
      for I := 0 to L - 1 do
        TT[TTO + (K - L + I) * LDT + J] :=
          CONJ(V[VO + (N - K + J) * LDV + K - L + I]);
    specialize TRMM<T>('R', 'U', 'N', 'U', L, K - L, ONE, V,
      VO + (N - K) * LDV, LDV, TT, TTO + (K - L) * LDT, LDT);
    specialize GEMM<T>('C', 'N', L, K - L, N - K, ONE, V, VO + K - L, LDV, V,
      VO, LDV, ONE, TT, TTO + (K - L) * LDT, LDT);
    specialize TRMM<T>('L', 'L', 'N', 'N', L, K - L, NEGONE, TT,
      TTO + (K - L) * LDT + K - L, LDT, TT, TTO + (K - L) * LDT, LDT);
    specialize TRMM<T>('R', 'L', 'N', 'N', L, K - L, ONE, TT, TTO, LDT, TT,
      TTO + (K - L) * LDT, LDT);
  end;
end;

{ xLARFB with STOREV = 'C': C := H*C or H^H*C (SIDE = 'L', TRANS = 'N'
  or 'T'/'C'), or C := C*H (SIDE = 'R', TRANS = 'N', DIRECT = 'F'), for
  the M x N matrix C, H = I - V*T*V^H with the matrix V of K columns
  (DIRECT 'F': unit lower trapezoidal on top; 'B': unit upper at the
  bottom). WORK is N x K for SIDE = 'L', M x K for 'R' (row stride
  LDWORK). }
generic procedure LARFB<T>(SIDE, TRANS, DIRECT: char; M, N, K: longint;
  const V: array of T; VO, LDV: longint; const TT: array of T;
  TTO, LDT: longint; var C: array of T; CO, LDC: longint;
  var WORK: array of T; LDWORK: longint);
var
  I, J, CR: longint;
  TRANST: char;
  ONE: T;
begin
  if (M <= 0) or (N <= 0) then Exit;
  ONE := 1;
  if TRANS = 'N' then TRANST := 'C' else TRANST := 'N';
  if SIDE = 'R' then
  begin
    { Form C * H (DIRECT = 'F'): W := C1 (the first K columns). }
    for J := 0 to K - 1 do
      for I := 0 to M - 1 do WORK[I * LDWORK + J] := C[CO + I * LDC + J];
    { W := W * V1 }
    specialize TRMM<T>('R', 'L', 'N', 'U', M, K, ONE, V, VO, LDV, WORK, 0,
      LDWORK);
    { W := W + C2 * V2 }
    if N > K then
      specialize GEMM<T>('N', 'N', M, K, N - K, ONE, C, CO + K, LDC, V,
        VO + K * LDV, LDV, ONE, WORK, 0, LDWORK);
    { W := W * T or W * T^H }
    specialize TRMM<T>('R', 'U', TRANS, 'N', M, K, ONE, TT, TTO, LDT, WORK, 0,
      LDWORK);
    { C2 := C2 - W * V2^H }
    if N > K then
      specialize GEMM<T>('N', 'C', M, N - K, K, -ONE, WORK, 0, LDWORK, V,
        VO + K * LDV, LDV, ONE, C, CO + K, LDC);
    { W := W * V1^H }
    specialize TRMM<T>('R', 'L', 'C', 'U', M, K, ONE, V, VO, LDV, WORK, 0,
      LDWORK);
    { C1 := C1 - W }
    for J := 0 to K - 1 do
      for I := 0 to M - 1 do
        C[CO + I * LDC + J] := C[CO + I * LDC + J] - WORK[I * LDWORK + J];
    Exit;
  end;
  { Form H * C or H^H * C. W := C1^H (C1: the K rows of C next to the unit
    triangle of V). }
  if DIRECT = 'F' then CR := 0 else CR := M - K;
  for J := 0 to K - 1 do
  begin
    for I := 0 to N - 1 do WORK[I * LDWORK + J] := C[CO + (CR + J) * LDC + I];
    LACGV(N, WORK, J, LDWORK);
  end;
  if DIRECT = 'F' then
  begin
    { W := W * V1 }
    specialize TRMM<T>('R', 'L', 'N', 'U', N, K, ONE, V, VO, LDV, WORK, 0,
      LDWORK);
    { W := W + C2^H * V2 }
    if M > K then
      specialize GEMM<T>('C', 'N', N, K, M - K, ONE, C, CO + K * LDC, LDC, V,
        VO + K * LDV, LDV, ONE, WORK, 0, LDWORK);
    { W := W * T^H or W * T }
    specialize TRMM<T>('R', 'U', TRANST, 'N', N, K, ONE, TT, TTO, LDT, WORK, 0,
      LDWORK);
    { C2 := C2 - V2 * W^H }
    if M > K then
      specialize GEMM<T>('N', 'C', M - K, N, K, -ONE, V, VO + K * LDV, LDV,
        WORK, 0, LDWORK, ONE, C, CO + K * LDC, LDC);
    { W := W * V1^H }
    specialize TRMM<T>('R', 'L', 'C', 'U', N, K, ONE, V, VO, LDV, WORK, 0,
      LDWORK);
  end else
  begin
    { W := W * V2 }
    specialize TRMM<T>('R', 'U', 'N', 'U', N, K, ONE, V, VO + (M - K) * LDV,
      LDV, WORK, 0, LDWORK);
    { W := W + C1^H * V1 }
    if M > K then
      specialize GEMM<T>('C', 'N', N, K, M - K, ONE, C, CO, LDC, V, VO, LDV,
        ONE, WORK, 0, LDWORK);
    { W := W * T^H or W * T }
    specialize TRMM<T>('R', 'L', TRANST, 'N', N, K, ONE, TT, TTO, LDT, WORK, 0,
      LDWORK);
    { C1 := C1 - V1 * W^H }
    if M > K then
      specialize GEMM<T>('N', 'C', M - K, N, K, -ONE, V, VO, LDV, WORK, 0,
        LDWORK, ONE, C, CO, LDC);
    { W := W * V2^H }
    specialize TRMM<T>('R', 'U', 'C', 'U', N, K, ONE, V, VO + (M - K) * LDV,
      LDV, WORK, 0, LDWORK);
  end;
  { C := C - W^H }
  for J := 0 to K - 1 do
    for I := 0 to N - 1 do
      C[CO + (CR + J) * LDC + I] := C[CO + (CR + J) * LDC + I] -
        CONJ(WORK[I * LDWORK + J]);
end;

{ xORGQR, xUNGQR: blocked (block size 32, crossover 128 of ILAENV). }
generic procedure ORGQR<T>(M, N, K: longint; var A: array of T;
  AO, LDA: longint; const TAU: array of T; TO_: longint);
var
  I, J, L, IB, KI, KK, NB, NX: longint;
  TT, WORK: array of T;
begin
  if N <= 0 then Exit;
  NB := ILAENVNB(32);
  NX := 0;
  if (NB > 1) and (NB < K) then NX := Max(0, ILAENVNX(128));
  KI := 0;
  if (NB >= 2) and (NB < K) and (NX < K) then
  begin
    { Use blocked code after the last block. The first kk columns are
      handled by the block method. }
    KI := ((K - NX - 1) div NB) * NB;
    KK := Min(K, KI + NB);
    { Set A(0:kk-1, kk:n-1) to zero. }
    for J := KK to N - 1 do
      for I := 0 to KK - 1 do A[AO + I * LDA + J] := 0;
  end else
    KK := 0;
  { Use unblocked code for the last or only block. }
  if KK < N then
    specialize ORG2R<T>(M - KK, N - KK, K - KK, A, AO + KK * LDA + KK, LDA,
      TAU, TO_ + KK);
  if KK > 0 then
  begin
    TT := nil;
    WORK := nil;
    SetLength(TT, NB * NB);
    SetLength(WORK, N * NB);
    I := KI;
    while I >= 0 do
    begin
      IB := Min(NB, K - I);
      if I + IB < N then
      begin
        { Form the triangular factor of the block reflector
          H = H(i) H(i+1) . . . H(i+ib-1) and apply H to
          A(i:m-1, i+ib:n-1) from the left. }
        specialize LARFT<T>('F', M - I, IB, A, AO + I * LDA + I, LDA, TAU,
          TO_ + I, TT, 0, NB);
        specialize LARFB<T>('L', 'N', 'F', M - I, N - I - IB, IB, A, AO + I * LDA + I,
          LDA, TT, 0, NB, A, AO + I * LDA + I + IB, LDA, WORK, NB);
      end;
      { Apply H to rows i:m-1 of current block. }
      specialize ORG2R<T>(M - I, IB, IB, A, AO + I * LDA + I, LDA, TAU,
        TO_ + I);
      { Set rows 0:i-1 of current block to zero. }
      for J := I to I + IB - 1 do
        for L := 0 to I - 1 do A[AO + L * LDA + J] := 0;
      I := I - NB;
    end;
  end;
end;

{ xORGQL, xUNGQL: blocked (block size 32, crossover 128 of ILAENV). }
generic procedure ORGQL<T>(M, N, K: longint; var A: array of T;
  AO, LDA: longint; const TAU: array of T; TO_: longint);
var
  I, J, L, IB, KK, NB, NX: longint;
  TT, WORK: array of T;
begin
  if N <= 0 then Exit;
  NB := ILAENVNB(32);
  NX := 0;
  if (NB > 1) and (NB < K) then NX := Max(0, ILAENVNX(128));
  if (NB >= 2) and (NB < K) and (NX < K) then
  begin
    { Use blocked code after the first block. The last kk columns are
      handled by the block method. }
    KK := Min(K, ((K - NX + NB - 1) div NB) * NB);
    { Set A(m-kk:m-1, 0:n-kk-1) to zero. }
    for J := 0 to N - KK - 1 do
      for I := M - KK to M - 1 do A[AO + I * LDA + J] := 0;
  end else
    KK := 0;
  { Use unblocked code for the first or only block. }
  specialize ORG2L<T>(M - KK, N - KK, K - KK, A, AO, LDA, TAU, TO_);
  if KK > 0 then
  begin
    TT := nil;
    WORK := nil;
    SetLength(TT, NB * NB);
    SetLength(WORK, N * NB);
    I := K - KK;
    while I < K do
    begin
      IB := Min(NB, K - I);
      if N - K + I > 0 then
      begin
        { Form the triangular factor of the block reflector
          H = H(i+ib-1) . . . H(i+1) H(i) and apply H to
          A(0:m-k+i+ib-1, 0:n-k+i-1) from the left. }
        specialize LARFT<T>('B', M - K + I + IB, IB, A, AO + N - K + I, LDA,
          TAU, TO_ + I, TT, 0, NB);
        specialize LARFB<T>('L', 'N', 'B', M - K + I + IB, N - K + I, IB, A,
          AO + N - K + I, LDA, TT, 0, NB, A, AO, LDA, WORK, NB);
      end;
      { Apply H to rows 0:m-k+i+ib-1 of current block. }
      specialize ORG2L<T>(M - K + I + IB, IB, IB, A, AO + N - K + I, LDA, TAU,
        TO_ + I);
      { Set rows m-k+i+ib:m-1 of current block to zero. }
      for J := N - K + I to N - K + I + IB - 1 do
        for L := M - K + I + IB to M - 1 do A[AO + L * LDA + J] := 0;
      I := I + NB;
    end;
  end;
end;

{ xORGTR, xUNGTR: the orthogonal (unitary) Q of xSYTRD (xHETRD). }
generic procedure ORGTR<T>(UPLO: char; N: longint; var A: array of T;
  AO, LDA: longint; const TAU: array of T);
var
  I, J: longint;
  ONE: T;
begin
  if N = 0 then Exit;
  ONE := 1;
  if UPLO = 'U' then
  begin
    { Shift the vectors which define the elementary reflectors one
      column to the left, and set the last row and column of Q to those
      of the unit matrix. }
    for J := 0 to N - 2 do
    begin
      for I := 0 to J - 1 do A[AO + I * LDA + J] := A[AO + I * LDA + J + 1];
      A[AO + (N - 1) * LDA + J] := 0;
    end;
    for I := 0 to N - 2 do A[AO + I * LDA + N - 1] := 0;
    A[AO + (N - 1) * LDA + N - 1] := ONE;
    { Generate Q(0:n-2, 0:n-2). }
    specialize ORGQL<T>(N - 1, N - 1, N - 1, A, AO, LDA, TAU, 0);
  end else
  begin
    { Shift the vectors which define the elementary reflectors one
      column to the right, and set the first row and column of Q to
      those of the unit matrix. }
    for J := N - 1 downto 1 do
    begin
      A[AO + J] := 0;
      for I := J + 1 to N - 1 do A[AO + I * LDA + J] := A[AO + I * LDA + J - 1];
    end;
    A[AO] := ONE;
    for I := 1 to N - 1 do A[AO + I * LDA] := 0;
    { Generate Q(1:n-1, 1:n-1). }
    if N > 1 then
      specialize ORGQR<T>(N - 1, N - 1, N - 1, A, AO + LDA + 1, LDA, TAU, 0);
  end;
end;

{ DLAEV2: eigendecomposition of the symmetric 2x2 matrix [A B; B C]:
  RT1 >= RT2 in absolute value and (CS1, SN1) the unit right eigenvector
  of RT1. }
procedure DLAEV2(A, B, C: TReal; out RT1, RT2, CS1, SN1: TReal);
const
  ONE: TReal = 1;
  TWO: TReal = 2;
  HALF: TReal = 0.5;
var
  SGN1, SGN2: longint;
  AB, ACMN, ACMX, ACS, ADF, CS, CT, DF, RT, SM, TB, TN: TReal;
begin
  { Compute the eigenvalues. }
  SM := A + C;
  DF := A - C;
  ADF := System.Abs(DF);
  TB := B + B;
  AB := System.Abs(TB);
  if System.Abs(A) > System.Abs(C) then
  begin
    ACMX := A;
    ACMN := C;
  end else
  begin
    ACMX := C;
    ACMN := A;
  end;
  if ADF > AB then
    RT := ADF * Sqrt(ONE + Sqr(AB / ADF))
  else if ADF < AB then
    RT := AB * Sqrt(ONE + Sqr(ADF / AB))
  else
    { Includes case AB=ADF=0. }
    RT := AB * Sqrt(TWO);
  if SM < 0 then
  begin
    RT1 := HALF * (SM - RT);
    SGN1 := -1;
    { Order of execution important. To get fully accurate smaller
      eigenvalue, next line needs to be executed in higher precision. }
    RT2 := (ACMX / RT1) * ACMN - (B / RT1) * B;
  end else if SM > 0 then
  begin
    RT1 := HALF * (SM + RT);
    SGN1 := 1;
    RT2 := (ACMX / RT1) * ACMN - (B / RT1) * B;
  end else
  begin
    { Includes case RT1 = RT2 = 0. }
    RT1 := HALF * RT;
    RT2 := (-HALF) * RT;
    SGN1 := 1;
  end;
  { Compute the eigenvector. }
  if DF >= 0 then
  begin
    CS := DF + RT;
    SGN2 := 1;
  end else
  begin
    CS := DF - RT;
    SGN2 := -1;
  end;
  ACS := System.Abs(CS);
  if ACS > AB then
  begin
    CT := -TB / CS;
    SN1 := ONE / Sqrt(ONE + CT * CT);
    CS1 := CT * SN1;
  end else if AB = 0 then
  begin
    CS1 := ONE;
    SN1 := 0;
  end else
  begin
    TN := -CS / TB;
    CS1 := ONE / Sqrt(ONE + TN * TN);
    SN1 := TN * CS1;
  end;
  if SGN1 = SGN2 then
  begin
    TN := CS1;
    CS1 := -SN1;
    SN1 := TN;
  end;
end;

{ DLASR, ZLASR with SIDE = 'R', PIVOT = 'V': A := A*P^T for the M x N
  matrix A, P the product of the plane rotations (C(j), S(j)) in the
  planes (j, j+1), forward (DIRECT = 'F') or backward ('B'). The rows of
  A are independent and are processed in turn. }
generic procedure LASRRV<T>(DIRECT: char; M, N: longint;
  const C: array of TReal; CO: longint; const S: array of TReal;
  SO: longint; var A: array of T; AO, LDA: longint);
var
  I, J, JJ: longint;
  CTEMP, STEMP: TReal;
  TEMP: T;
begin
  if (M <= 0) or (N <= 0) then Exit;
  for I := 0 to M - 1 do
    for JJ := 0 to N - 2 do
    begin
      if DIRECT = 'F' then J := JJ else J := N - 2 - JJ;
      CTEMP := C[CO + J];
      STEMP := S[SO + J];
      if (CTEMP <> 1) or (STEMP <> 0) then
      begin
        TEMP := A[AO + I * LDA + J + 1];
        A[AO + I * LDA + J + 1] := RMUL(CTEMP, TEMP) -
          RMUL(STEMP, A[AO + I * LDA + J]);
        A[AO + I * LDA + J] := RMUL(STEMP, TEMP) +
          RMUL(CTEMP, A[AO + I * LDA + J]);
      end;
    end;
end;

{ DLANST with NORM = 'M' (largest |entry|) or 'I' (infinity norm) of the
  symmetric tridiagonal matrix with diagonal D[DO_..] and off-diagonal
  E[EO..]. }
function DLANST(NORM: char; N: longint; const D: array of TReal;
  DO_: longint; const E: array of TReal; EO: longint): TReal;
var
  I: longint;
  SUM: TReal;
begin
  result := 0;
  if N <= 0 then Exit;
  if NORM = 'M' then
  begin
    result := System.Abs(D[DO_ + N - 1]);
    for I := 0 to N - 2 do
    begin
      SUM := System.Abs(D[DO_ + I]);
      if (result < SUM) or IsNan(SUM) then result := SUM;
      SUM := System.Abs(E[EO + I]);
      if (result < SUM) or IsNan(SUM) then result := SUM;
    end;
  end else if N = 1 then
    result := System.Abs(D[DO_])
  else
  begin
    result := System.Abs(D[DO_]) + System.Abs(E[EO]);
    SUM := System.Abs(E[EO + N - 2]) + System.Abs(D[DO_ + N - 1]);
    if (result < SUM) or IsNan(SUM) then result := SUM;
    for I := 1 to N - 2 do
    begin
      SUM := System.Abs(D[DO_ + I]) + System.Abs(E[EO + I]) +
        System.Abs(E[EO + I - 1]);
      if (result < SUM) or IsNan(SUM) then result := SUM;
    end;
  end;
end;

{ Overloads for the generic xSTEQR: DSTEQR uses DLANST('M'), ZSTEQR
  DLANST('I'). }
function STEQRNORM(const Z: array of TReal): char; overload; inline;
begin
  result := 'M';
end;

function STEQRNORM(const Z: array of TComplex): char; overload; inline;
begin
  result := 'I';
end;

{ xSTEQR: eigenvalues and eigenvectors of a symmetric tridiagonal matrix
  by the implicit QL or QR method. COMPZ = 'V': Z holds the orthogonal
  (unitary) matrix that reduced the original matrix to tridiagonal form;
  'I': Z is initialized to the identity. On exit D holds the eigenvalues
  in ascending order and Z the eigenvectors in its columns. INFO = i > 0
  when the algorithm failed to find all the eigenvalues in 30*N
  iterations; i elements of E have not converged. }
generic procedure STEQR<T>(COMPZ: char; N: longint; var D, E: array of TReal;
  var Z: array of T; ZO, LDZ: longint; out INFO: longint);
const
  MAXIT = 30;
  ONE: TReal = 1;
  TWO: TReal = 2;
  THREE: TReal = 3;
var
  I, II, ISCALE, J, JTOT, K, L, L1, LEND, LENDM1, LENDP1, LENDSV, LM1, LSV,
    M, MM, MM1, NM1, NMAXIT: longint;
  ANORM, B, C, EPS, EPS2, F, G, P, R, RT1, RT2, S, SAFMAX, SAFMIN, SSFMAX,
    SSFMIN, TST: TReal;
  WORK: array of TReal;
  TEMPZ: T;
  CONVERGED: boolean;

  { DLASCL('G') on N entries of D or E. }
  procedure SCALEV(var X: array of TReal; XO, NX: longint;
    CFROM, CTO: TReal);
  begin
    specialize LASCLT<TReal>('G', CFROM, CTO, NX, 1, X, XO, 1);
  end;

begin
  INFO := 0;
  if N = 0 then Exit;
  if N = 1 then
  begin
    if COMPZ = 'I' then Z[ZO] := 1;
    Exit;
  end;
  { Determine the unit roundoff and over/underflow thresholds. }
  EPS := LapackEpsilon;
  EPS2 := EPS * EPS;
  SAFMIN := LapackSafeMinimum;
  SAFMAX := ONE / SAFMIN;
  SSFMAX := Sqrt(SAFMAX) / THREE;
  SSFMIN := Sqrt(SAFMIN) / EPS2;
  { Compute the eigenvalues and eigenvectors of the tridiagonal matrix. }
  if COMPZ = 'I' then
    for I := 0 to N - 1 do
      for J := 0 to N - 1 do
        if I = J then Z[ZO + I * LDZ + J] := 1 else Z[ZO + I * LDZ + J] := 0;
  WORK := nil;
  SetLength(WORK, 2 * N - 2);
  NMAXIT := N * MAXIT;
  JTOT := 0;
  { Determine where the matrix splits and choose QL or QR iteration for
    each block, according to whether top or bottom diagonal element is
    smaller. Indices are 0-based; L1 is the first row of the next block. }
  L1 := 0;
  NM1 := N - 1;
  CONVERGED := True;
  while L1 <= N - 1 do
  begin
    if L1 > 0 then E[L1 - 1] := 0;
    M := N - 1;
    for II := L1 to NM1 - 1 do
    begin
      TST := System.Abs(E[II]);
      if TST = 0 then
      begin
        M := II;
        Break;
      end;
      if TST <= (Sqrt(System.Abs(D[II])) * Sqrt(System.Abs(D[II + 1]))) * EPS then
      begin
        E[II] := 0;
        M := II;
        Break;
      end;
    end;
    L := L1;
    LSV := L;
    LEND := M;
    LENDSV := LEND;
    L1 := M + 1;
    if LEND = L then Continue;
    { Scale submatrix in rows and columns L to LEND. }
    ANORM := DLANST(STEQRNORM(Z), LEND - L + 1, D, L, E, L);
    ISCALE := 0;
    if ANORM = 0 then Continue;
    if ANORM > SSFMAX then
    begin
      ISCALE := 1;
      SCALEV(D, L, LEND - L + 1, ANORM, SSFMAX);
      SCALEV(E, L, LEND - L, ANORM, SSFMAX);
    end else if ANORM < SSFMIN then
    begin
      ISCALE := 2;
      SCALEV(D, L, LEND - L + 1, ANORM, SSFMIN);
      SCALEV(E, L, LEND - L, ANORM, SSFMIN);
    end;
    { Choose between QL and QR iteration. }
    if System.Abs(D[LEND]) < System.Abs(D[L]) then
    begin
      LEND := LSV;
      L := LENDSV;
    end;
    if LEND > L then
    begin
      { QL Iteration. Look for small subdiagonal element. }
      repeat
        M := LEND;
        if L <> LEND then
        begin
          LENDM1 := LEND - 1;
          for II := L to LENDM1 do
          begin
            TST := Sqr(System.Abs(E[II]));
            if TST <= (EPS2 * System.Abs(D[II])) * System.Abs(D[II + 1]) +
              SAFMIN then
            begin
              M := II;
              Break;
            end;
          end;
        end;
        if M < LEND then E[M] := 0;
        P := D[L];
        if M = L then
        begin
          { Eigenvalue found. }
          D[L] := P;
          L := L + 1;
          if L <= LEND then Continue;
          Break;
        end;
        { If remaining matrix is 2-by-2, use DLAE2 or DLAEV2 to compute
          its eigensystem. }
        if M = L + 1 then
        begin
          DLAEV2(D[L], E[L], D[L + 1], RT1, RT2, C, S);
          WORK[L] := C;
          WORK[N - 1 + L] := S;
          specialize LASRRV<T>('B', N, 2, WORK, L, WORK, N - 1 + L, Z, ZO + L, LDZ);
          D[L] := RT1;
          D[L + 1] := RT2;
          E[L] := 0;
          L := L + 2;
          if L <= LEND then Continue;
          Break;
        end;
        if JTOT = NMAXIT then Break;
        JTOT := JTOT + 1;
        { Form shift. }
        G := (D[L + 1] - P) / (TWO * E[L]);
        R := DLAPY2(G, ONE);
        G := D[M] - P + (E[L] / (G + SIGN(R, G)));
        S := ONE;
        C := ONE;
        P := 0;
        { Inner loop. }
        MM1 := M - 1;
        for I := MM1 downto L do
        begin
          F := S * E[I];
          B := C * E[I];
          DLARTG(G, F, C, S, R);
          if I <> M - 1 then E[I + 1] := R;
          G := D[I + 1] - P;
          R := (D[I] - G) * S + TWO * C * B;
          P := S * R;
          D[I + 1] := G + P;
          G := C * R - B;
          { If eigenvectors are desired, then save rotations. }
          WORK[I] := C;
          WORK[N - 1 + I] := -S;
        end;
        { If eigenvectors are desired, then apply saved rotations. }
        MM := M - L + 1;
        specialize LASRRV<T>('B', N, MM, WORK, L, WORK, N - 1 + L, Z, ZO + L, LDZ);
        D[L] := D[L] - P;
        E[L] := G;
      until False;
    end else
    begin
      { QR Iteration. Look for small superdiagonal element. }
      repeat
        M := LEND;
        if L <> LEND then
        begin
          LENDP1 := LEND + 1;
          for II := L downto LENDP1 do
          begin
            TST := Sqr(System.Abs(E[II - 1]));
            if TST <= (EPS2 * System.Abs(D[II])) * System.Abs(D[II - 1]) +
              SAFMIN then
            begin
              M := II;
              Break;
            end;
          end;
        end;
        if M > LEND then E[M - 1] := 0;
        P := D[L];
        if M = L then
        begin
          { Eigenvalue found. }
          D[L] := P;
          L := L - 1;
          if L >= LEND then Continue;
          Break;
        end;
        { If remaining matrix is 2-by-2, use DLAE2 or DLAEV2 to compute
          its eigensystem. }
        if M = L - 1 then
        begin
          DLAEV2(D[L - 1], E[L - 1], D[L], RT1, RT2, C, S);
          WORK[M] := C;
          WORK[N - 1 + M] := S;
          specialize LASRRV<T>('F', N, 2, WORK, M, WORK, N - 1 + M, Z, ZO + L - 1, LDZ);
          D[L - 1] := RT1;
          D[L] := RT2;
          E[L - 1] := 0;
          L := L - 2;
          if L >= LEND then Continue;
          Break;
        end;
        if JTOT = NMAXIT then Break;
        JTOT := JTOT + 1;
        { Form shift. }
        G := (D[L - 1] - P) / (TWO * E[L - 1]);
        R := DLAPY2(G, ONE);
        G := D[M] - P + (E[L - 1] / (G + SIGN(R, G)));
        S := ONE;
        C := ONE;
        P := 0;
        { Inner loop. }
        LM1 := L - 1;
        for I := M to LM1 do
        begin
          F := S * E[I];
          B := C * E[I];
          DLARTG(G, F, C, S, R);
          if I <> M then E[I - 1] := R;
          G := D[I] - P;
          R := (D[I + 1] - G) * S + TWO * C * B;
          P := S * R;
          D[I] := G + P;
          G := C * R - B;
          { If eigenvectors are desired, then save rotations. }
          WORK[I] := C;
          WORK[N - 1 + I] := S;
        end;
        { If eigenvectors are desired, then apply saved rotations. }
        MM := L - M + 1;
        specialize LASRRV<T>('F', N, MM, WORK, M, WORK, N - 1 + M, Z, ZO + M, LDZ);
        D[L] := D[L] - P;
        E[LM1] := G;
      until False;
    end;
    { Undo scaling if necessary. }
    if ISCALE = 1 then
    begin
      SCALEV(D, LSV, LENDSV - LSV + 1, SSFMAX, ANORM);
      SCALEV(E, LSV, LENDSV - LSV, SSFMAX, ANORM);
    end else if ISCALE = 2 then
    begin
      SCALEV(D, LSV, LENDSV - LSV + 1, SSFMIN, ANORM);
      SCALEV(E, LSV, LENDSV - LSV, SSFMIN, ANORM);
    end;
    { Check for no convergence to an eigenvalue after a total of N*MAXIT
      iterations. }
    if JTOT >= NMAXIT then
    begin
      CONVERGED := False;
      Break;
    end;
  end;
  if not CONVERGED then
  begin
    for I := 0 to N - 2 do
      if E[I] <> 0 then INFO := INFO + 1;
    Exit;
  end;
  { Order eigenvalues and eigenvectors: use selection sort to minimize
    swaps of eigenvectors. }
  for II := 1 to N - 1 do
  begin
    I := II - 1;
    K := I;
    P := D[I];
    for J := II to N - 1 do
      if D[J] < P then
      begin
        K := J;
        P := D[J];
      end;
    if K <> I then
    begin
      D[K] := D[I];
      D[I] := P;
      for J := 0 to N - 1 do
      begin
        TEMPZ := Z[ZO + J * LDZ + I];
        Z[ZO + J * LDZ + I] := Z[ZO + J * LDZ + K];
        Z[ZO + J * LDZ + K] := TEMPZ;
      end;
    end;
  end;
end;

{ xSYEV, xHEEV with JOBZ = 'V': all eigenvalues (ascending, in W) and
  eigenvectors (in the columns of A) of a symmetric (Hermitian) matrix
  stored in the UPLO triangle of A. INFO = i > 0: xSTEQR failed. }
generic procedure SYEV<T>(UPLO: char; N: longint; var A: array of T;
  AO, LDA: longint; var W: array of TReal; out INFO: longint);
const
  ONE: TReal = 1;
var
  ANRM, BIGNUM, EPS, RMAX, RMIN, SAFMIN, SIGMA, SMLNUM: TReal;
  ISCALE, IMAX: longint;
  E: array of TReal;
  TAU: array of T;
begin
  INFO := 0;
  if N = 0 then Exit;
  if N = 1 then
  begin
    W[0] := REALOF(A[AO]);
    A[AO] := 1;
    Exit;
  end;
  { Get machine constants. }
  SAFMIN := LapackSafeMinimum;
  EPS := LapackPrecision;
  SMLNUM := SAFMIN / EPS;
  BIGNUM := ONE / SMLNUM;
  RMIN := Sqrt(SMLNUM);
  RMAX := Sqrt(BIGNUM);
  { Scale matrix to allowable range, if necessary. }
  ANRM := specialize LANSYMAX<T>(UPLO, N, A, AO, LDA);
  ISCALE := 0;
  SIGMA := 1;
  if (ANRM > 0) and (ANRM < RMIN) then
  begin
    ISCALE := 1;
    SIGMA := RMIN / ANRM;
  end else if ANRM > RMAX then
  begin
    ISCALE := 1;
    SIGMA := RMAX / ANRM;
  end;
  if ISCALE = 1 then
    specialize LASCLT<T>(UPLO, ONE, SIGMA, N, N, A, AO, LDA);
  { Call xSYTRD to reduce symmetric matrix to tridiagonal form. }
  E := nil;
  TAU := nil;
  SetLength(E, N - 1);
  SetLength(TAU, N - 1);
  specialize SYTRD<T>(UPLO, N, A, AO, LDA, W, E, TAU);
  { Call xORGTR to generate the orthogonal matrix, then xSTEQR. }
  specialize ORGTR<T>(UPLO, N, A, AO, LDA, TAU);
  specialize STEQR<T>('V', N, W, E, A, AO, LDA, INFO);
  { If matrix was scaled, then rescale eigenvalues appropriately. }
  if ISCALE = 1 then
  begin
    if INFO = 0 then IMAX := N else IMAX := INFO - 1;
    specialize SCAL<TReal>(IMAX, ONE / SIGMA, W, 0, 1);
  end;
end;

{ ---------------------------------------------------------------------
  Selected eigenvalues and eigenvectors of a symmetric tridiagonal matrix
  (LAPACK 3.12.1): DSTEVX with DSTEBZ (bisection, DLAEBZ) and DSTEIN
  (inverse iteration, DLAGTF, DLAGTS, DLARNV). Block numbers (IBLOCK) and
  the ends of the blocks (ISPLIT) are counted from 1, as in LAPACK.
  --------------------------------------------------------------------- }

{ log(x) as gfortran takes it from the C library. }
function LOGX(X: TReal): TReal; inline;
begin
  result := GLIBCLOG(X);
end;

const
  { Multipliers of the random number generator of DLARUV. }
  MM: array[0..127, 0..3] of longint = (
    (494, 322, 2508, 2549),
    (2637, 789, 3754, 1145),
    (255, 1440, 1766, 2253),
    (2008, 752, 3572, 305),
    (1253, 2859, 2893, 3301),
    (3344, 123, 307, 1065),
    (4084, 1848, 1297, 3133),
    (1739, 643, 3966, 2913),
    (3143, 2405, 758, 3285),
    (3468, 2638, 2598, 1241),
    (688, 2344, 3406, 1197),
    (1657, 46, 2922, 3729),
    (1238, 3814, 1038, 2501),
    (3166, 913, 2934, 1673),
    (1292, 3649, 2091, 541),
    (3422, 339, 2451, 2753),
    (1270, 3808, 1580, 949),
    (2016, 822, 1958, 2361),
    (154, 2832, 2055, 1165),
    (2862, 3078, 1507, 4081),
    (697, 3633, 1078, 2725),
    (1706, 2970, 3273, 3305),
    (491, 637, 17, 3069),
    (931, 2249, 854, 3617),
    (1444, 2081, 2916, 3733),
    (444, 4019, 3971, 409),
    (3577, 1478, 2889, 2157),
    (3944, 242, 3831, 1361),
    (2184, 481, 2621, 3973),
    (1661, 2075, 1541, 1865),
    (3482, 4058, 893, 2525),
    (657, 622, 736, 1409),
    (3023, 3376, 3992, 3445),
    (3618, 812, 787, 3577),
    (1267, 234, 2125, 77),
    (1828, 641, 2364, 3761),
    (164, 4005, 2460, 2149),
    (3798, 1122, 257, 1449),
    (3087, 3135, 1574, 3005),
    (2400, 2640, 3912, 225),
    (2870, 2302, 1216, 85),
    (3876, 40, 3248, 3673),
    (1905, 1832, 3401, 3117),
    (1593, 2247, 2124, 3089),
    (1797, 2034, 2762, 1349),
    (1234, 2637, 149, 2057),
    (3460, 1287, 2245, 413),
    (328, 1691, 166, 65),
    (2861, 496, 466, 1845),
    (1950, 1597, 4018, 697),
    (617, 2394, 1399, 3085),
    (2070, 2584, 190, 3441),
    (3331, 1843, 2879, 1573),
    (769, 336, 153, 3689),
    (1558, 1472, 2320, 2941),
    (2412, 2407, 18, 929),
    (2800, 433, 712, 533),
    (189, 2096, 2159, 2841),
    (287, 1761, 2318, 4077),
    (2045, 2810, 2091, 721),
    (1227, 566, 3443, 2821),
    (2838, 442, 1510, 2249),
    (209, 41, 449, 2397),
    (2770, 1238, 1956, 2817),
    (3654, 1086, 2201, 245),
    (3993, 603, 3137, 1913),
    (192, 840, 3399, 1997),
    (2253, 3168, 1321, 3121),
    (3491, 1499, 2271, 997),
    (2889, 1084, 3667, 1833),
    (2857, 3438, 2703, 2877),
    (2094, 2408, 629, 1633),
    (1818, 1589, 2365, 981),
    (688, 2391, 2431, 2009),
    (1407, 288, 1113, 941),
    (634, 26, 3922, 2449),
    (3231, 512, 2554, 197),
    (815, 1456, 184, 2441),
    (3524, 171, 2099, 285),
    (1914, 1677, 3228, 1473),
    (516, 2657, 4012, 2741),
    (164, 2270, 1921, 3129),
    (303, 2587, 3452, 909),
    (2144, 2961, 3901, 2801),
    (3480, 1970, 572, 421),
    (119, 1817, 3309, 4073),
    (3357, 676, 3171, 2813),
    (837, 1410, 817, 2337),
    (2826, 3723, 3039, 1429),
    (2332, 2803, 1696, 1177),
    (2089, 3185, 1256, 1901),
    (3780, 184, 3715, 81),
    (1700, 663, 2077, 1669),
    (3712, 499, 3019, 2633),
    (150, 3784, 1497, 2269),
    (2000, 1631, 1101, 129),
    (3375, 1925, 717, 1141),
    (1621, 3912, 51, 249),
    (3090, 1398, 981, 3917),
    (3765, 1349, 1978, 2481),
    (1149, 1441, 1813, 3941),
    (3146, 2224, 3881, 2217),
    (33, 2411, 76, 2749),
    (3082, 1907, 3846, 3041),
    (2741, 3192, 3694, 1877),
    (359, 2786, 1682, 345),
    (3316, 382, 124, 2861),
    (1749, 37, 1660, 1809),
    (185, 759, 3997, 3141),
    (2784, 2948, 479, 2825),
    (2202, 1862, 1141, 157),
    (2199, 3802, 886, 2881),
    (1364, 2423, 3514, 3637),
    (1244, 2051, 1301, 1465),
    (2020, 2295, 3604, 2829),
    (3160, 1332, 1888, 2161),
    (2785, 1832, 1836, 3365),
    (2772, 2405, 1990, 361),
    (1217, 3638, 2058, 2685),
    (1822, 3661, 692, 3745),
    (1245, 327, 1194, 2325),
    (2252, 3660, 20, 3609),
    (3904, 716, 3285, 3821),
    (2774, 1842, 2046, 3537),
    (997, 3987, 2107, 517),
    (2573, 1368, 3508, 3017),
    (1148, 1848, 3525, 2141),
    (545, 2366, 3801, 1537));

{ DLARUV: N (at most 128) uniform random numbers in (0, 1) from the
  seed ISEED (4 integers in [0, 4095], ISEED[3] odd), updated. }
procedure DLARUV(var ISEED: array of longint; N: longint;
  var X: array of TReal; XO: longint);
const
  IPW2 = 4096;
  R: TReal = 1 / 4096;
var
  I, I1, I2, I3, I4, IT1, IT2, IT3, IT4: longint;
begin
  I1 := ISEED[0];
  I2 := ISEED[1];
  I3 := ISEED[2];
  I4 := ISEED[3];
  IT1 := 0;
  IT2 := 0;
  IT3 := 0;
  IT4 := 0;
  for I := 0 to Min(N, 128) - 1 do
    repeat
      { Multiply the seed by i-th power of the multiplier modulo 2**48. }
      IT4 := I4 * MM[I, 3];
      IT3 := IT4 div IPW2;
      IT4 := IT4 - IPW2 * IT3;
      IT3 := IT3 + I3 * MM[I, 3] + I4 * MM[I, 2];
      IT2 := IT3 div IPW2;
      IT3 := IT3 - IPW2 * IT2;
      IT2 := IT2 + I2 * MM[I, 3] + I3 * MM[I, 2] + I4 * MM[I, 1];
      IT1 := IT2 div IPW2;
      IT2 := IT2 - IPW2 * IT1;
      IT1 := IT1 + I1 * MM[I, 3] + I2 * MM[I, 2] + I3 * MM[I, 1] +
        I4 * MM[I, 0];
      IT1 := IT1 mod IPW2;
      { Convert 48-bit integer to a real number in the interval (0,1). }
      X[XO + I] := R * (TReal(IT1) + R * (TReal(IT2) + R * (TReal(IT3) +
        R * TReal(IT4))));
      if X[XO + I] = 1 then
      begin
        { If a real number has n bits of precision, and the first n bits
          of the 48-bit integer above happen to be all 1 (which will
          occur about once every 2**n calls), then X( I ) will be
          rounded to exactly 1.0. Since X( I ) is not supposed to return
          exactly 0.0 or 1.0, the statistically correct thing to do in
          this situation is simply to iterate again. }
        I1 := I1 + 2;
        I2 := I2 + 2;
        I3 := I3 + 2;
        I4 := I4 + 2;
      end else
        Break;
    until False;
  { Return final value of seed. }
  ISEED[0] := IT1;
  ISEED[1] := IT2;
  ISEED[2] := IT3;
  ISEED[3] := IT4;
end;

{ DLARNV with IDIST = 1 (uniform (0, 1)) or 2 (uniform (-1, 1)). }
procedure DLARNV(IDIST: longint; var ISEED: array of longint; N: longint;
  var X: array of TReal; XO: longint);
const
  LV = 128;
  ONE: TReal = 1;
  TWO: TReal = 2;
var
  IV, IL, I: longint;
  U: array[0..LV - 1] of TReal;
begin
  IV := 1;
  while IV <= N do
  begin
    IL := Min(LV div 2, N - IV + 1);
    { Call DLARUV to generate IL real numbers from a uniform (0,1)
      distribution. }
    DLARUV(ISEED, IL, U, 0);
    if IDIST = 1 then
      for I := 0 to IL - 1 do X[XO + IV - 1 + I] := U[I]
    else
      for I := 0 to IL - 1 do X[XO + IV - 1 + I] := TWO * U[I] - ONE;
    IV := IV + LV div 2;
  end;
end;

{ DLAGTF: factorization T - lambda*I = P*L*U of the tridiagonal matrix T
  with diagonal A, superdiagonal B and subdiagonal C (overwritten by the
  factors; D receives the second superdiagonal of U, IN the pivots). }
procedure DLAGTF(N: longint; var A: array of TReal; LAMBDA: TReal;
  var B, C: array of TReal; TOL: TReal; var D: array of TReal;
  var IN_: array of longint; out INFO: longint);
var
  K: longint;
  EPS, MULT, PIV1, PIV2, SCALE1, SCALE2, TEMP, TL: TReal;
begin
  INFO := 0;
  if N = 0 then Exit;
  A[0] := A[0] - LAMBDA;
  IN_[N - 1] := 0;
  if N = 1 then
  begin
    if A[0] = 0 then IN_[0] := 1;
    Exit;
  end;
  EPS := LapackEpsilon;
  TL := Max(TOL, EPS);
  SCALE1 := System.Abs(A[0]) + System.Abs(B[0]);
  for K := 0 to N - 2 do
  begin
    A[K + 1] := A[K + 1] - LAMBDA;
    SCALE2 := System.Abs(C[K]) + System.Abs(A[K + 1]);
    if K < N - 2 then SCALE2 := SCALE2 + System.Abs(B[K + 1]);
    if A[K] = 0 then
      PIV1 := 0
    else
      PIV1 := System.Abs(A[K]) / SCALE1;
    if C[K] = 0 then
    begin
      IN_[K] := 0;
      PIV2 := 0;
      SCALE1 := SCALE2;
      if K < N - 2 then D[K] := 0;
    end else
    begin
      PIV2 := System.Abs(C[K]) / SCALE2;
      if PIV2 <= PIV1 then
      begin
        IN_[K] := 0;
        SCALE1 := SCALE2;
        C[K] := C[K] / A[K];
        A[K + 1] := A[K + 1] - C[K] * B[K];
        if K < N - 2 then D[K] := 0;
      end else
      begin
        IN_[K] := 1;
        MULT := A[K] / C[K];
        A[K] := C[K];
        TEMP := A[K + 1];
        A[K + 1] := B[K] - MULT * TEMP;
        if K < N - 2 then
        begin
          D[K] := B[K + 1];
          B[K + 1] := -MULT * D[K];
        end;
        B[K] := TEMP;
        C[K] := MULT;
      end;
    end;
    if (Max(PIV1, PIV2) <= TL) and (IN_[N - 1] = 0) then IN_[N - 1] := K + 1;
  end;
  if (System.Abs(A[N - 1]) <= SCALE1 * TL) and (IN_[N - 1] = 0) then
    IN_[N - 1] := N;
end;

{ DLAGTS with JOB = 1 or -1: solves (T - lambda*I)*x = y with the
  factors of DLAGTF, overwriting Y; with JOB = -1 small pivots are
  perturbed by TOL (computed when TOL <= 0). }
procedure DLAGTS(JOB, N: longint; const A, B, C, D: array of TReal;
  const IN_: array of longint; var Y: array of TReal; var TOL: TReal;
  out INFO: longint);
const
  ONE: TReal = 1;
  TWO: TReal = 2;
var
  K: longint;
  ABSAK, AK, BIGNUM, EPS, PERT, SFMIN, TEMP: TReal;
begin
  INFO := 0;
  if N = 0 then Exit;
  EPS := LapackEpsilon;
  SFMIN := LapackSafeMinimum;
  BIGNUM := ONE / SFMIN;
  if JOB < 0 then
    if TOL <= 0 then
    begin
      TOL := System.Abs(A[0]);
      if N > 1 then
        TOL := Max(Max(TOL, System.Abs(A[1])), System.Abs(B[0]));
      for K := 2 to N - 1 do
        TOL := Max(Max(Max(TOL, System.Abs(A[K])), System.Abs(B[K - 1])),
          System.Abs(D[K - 2]));
      TOL := TOL * EPS;
      if TOL = 0 then TOL := EPS;
    end;
  for K := 1 to N - 1 do
    if IN_[K - 1] = 0 then
      Y[K] := Y[K] - C[K - 1] * Y[K - 1]
    else
    begin
      TEMP := Y[K - 1];
      Y[K - 1] := Y[K];
      Y[K] := TEMP - C[K - 1] * Y[K];
    end;
  for K := N - 1 downto 0 do
  begin
    if K <= N - 3 then
      TEMP := Y[K] - B[K] * Y[K + 1] - D[K] * Y[K + 2]
    else if K = N - 2 then
      TEMP := Y[K] - B[K] * Y[K + 1]
    else
      TEMP := Y[K];
    AK := A[K];
    if JOB = 1 then
    begin
      ABSAK := System.Abs(AK);
      if ABSAK < ONE then
        if ABSAK < SFMIN then
        begin
          if (ABSAK = 0) or (System.Abs(TEMP) * SFMIN > ABSAK) then
          begin
            INFO := K + 1;
            Exit;
          end else
          begin
            TEMP := TEMP * BIGNUM;
            AK := AK * BIGNUM;
          end;
        end else if System.Abs(TEMP) > ABSAK * BIGNUM then
        begin
          INFO := K + 1;
          Exit;
        end;
    end else
    begin
      PERT := SIGN(TOL, AK);
      repeat
        ABSAK := System.Abs(AK);
        if ABSAK < ONE then
          if ABSAK < SFMIN then
          begin
            if (ABSAK = 0) or (System.Abs(TEMP) * SFMIN > ABSAK) then
            begin
              AK := AK + PERT;
              PERT := TWO * PERT;
              Continue;
            end else
            begin
              TEMP := TEMP * BIGNUM;
              AK := AK * BIGNUM;
            end;
          end else if System.Abs(TEMP) > ABSAK * BIGNUM then
          begin
            AK := AK + PERT;
            PERT := TWO * PERT;
            Continue;
          end;
        Break;
      until False;
    end;
    Y[K] := TEMP / AK;
  end;
end;

{ DLAEBZ: bisection for the eigenvalue counts of a symmetric tridiagonal
  matrix (diagonal D, squared off-diagonal E2) on MINP intervals. AB and
  NAB are MMAX x 2 arrays stored by columns as in LAPACK
  (AB(i,j) at AB[(j-1)*MMAX + i-1]); interval indices are 0-based here. }
procedure DLAEBZ(IJOB, NITMAX, N, MMAX, MINP, NBMIN: longint;
  ABSTOL, RELTOL, PIVMIN: TReal; const D: array of TReal; DO_: longint;
  const E2: array of TReal; E2O: longint; var NVAL: array of longint;
  var AB, C: array of TReal; out MOUT: longint; var NAB: array of longint;
  out INFO: longint);
const
  HALF: TReal = 0.5;
var
  ITMP1, ITMP2, J, JI, JIT, JP, KF, KFNEW, KL, KLNEW: longint;
  TMP1, TMP2: TReal;
  WORK: array of TReal;
  IWORK: array of longint;
begin
  INFO := 0;
  MOUT := 0;
  if IJOB = 1 then
  begin
    { Compute the number of eigenvalues in the initial intervals. }
    for JI := 0 to MINP - 1 do
    begin
      for JP := 0 to 1 do
      begin
        TMP1 := D[DO_] - AB[JP * MMAX + JI];
        if System.Abs(TMP1) < PIVMIN then TMP1 := -PIVMIN;
        NAB[JP * MMAX + JI] := 0;
        if TMP1 <= 0 then NAB[JP * MMAX + JI] := 1;
        for J := 1 to N - 1 do
        begin
          TMP1 := D[DO_ + J] - E2[E2O + J - 1] / TMP1 - AB[JP * MMAX + JI];
          if System.Abs(TMP1) < PIVMIN then TMP1 := -PIVMIN;
          if TMP1 <= 0 then NAB[JP * MMAX + JI] := NAB[JP * MMAX + JI] + 1;
        end;
      end;
      MOUT := MOUT + NAB[MMAX + JI] - NAB[JI];
    end;
    Exit;
  end;
  { Initialize for loop: KF and KL are the first and last intervals not
    yet converged. }
  KF := 0;
  KL := MINP - 1;
  { If IJOB=2, initialize C. }
  if IJOB = 2 then
    for JI := 0 to MINP - 1 do C[JI] := HALF * (AB[JI] + AB[MMAX + JI]);
  WORK := nil;
  IWORK := nil;
  SetLength(WORK, MMAX);
  SetLength(IWORK, MMAX);
  { Iteration loop. }
  for JIT := 1 to NITMAX do
  begin
    if (KL - KF + 1 >= NBMIN) and (NBMIN > 0) then
    begin
      { Begin of Parallel Version of the loop. }
      for JI := KF to KL do
      begin
        { Compute N(c), the number of eigenvalues less than c. }
        WORK[JI] := D[DO_] - C[JI];
        IWORK[JI] := 0;
        if WORK[JI] <= PIVMIN then
        begin
          IWORK[JI] := 1;
          WORK[JI] := Min(WORK[JI], -PIVMIN);
        end;
        for J := 1 to N - 1 do
        begin
          WORK[JI] := D[DO_ + J] - E2[E2O + J - 1] / WORK[JI] - C[JI];
          if WORK[JI] <= PIVMIN then
          begin
            IWORK[JI] := IWORK[JI] + 1;
            WORK[JI] := Min(WORK[JI], -PIVMIN);
          end;
        end;
      end;
      if IJOB <= 2 then
      begin
        { IJOB=2: Choose all intervals containing eigenvalues. }
        KLNEW := KL;
        for JI := KF to KL do
        begin
          { Insure that N(w) is monotone. }
          IWORK[JI] := Min(NAB[MMAX + JI], Max(NAB[JI], IWORK[JI]));
          { Update the Queue -- add intervals if both halves contain
            eigenvalues. }
          if IWORK[JI] = NAB[MMAX + JI] then
            { No eigenvalue in the upper interval: just use the lower
              interval. }
            AB[MMAX + JI] := C[JI]
          else if IWORK[JI] = NAB[JI] then
            { No eigenvalue in the lower interval: just use the upper
              interval. }
            AB[JI] := C[JI]
          else
          begin
            KLNEW := KLNEW + 1;
            if KLNEW <= MMAX - 1 then
            begin
              { Eigenvalue in both intervals -- add upper to queue. }
              AB[MMAX + KLNEW] := AB[MMAX + JI];
              NAB[MMAX + KLNEW] := NAB[MMAX + JI];
              AB[KLNEW] := C[JI];
              NAB[KLNEW] := IWORK[JI];
              AB[MMAX + JI] := C[JI];
              NAB[MMAX + JI] := IWORK[JI];
            end else
              INFO := MMAX + 1;
          end;
        end;
        if INFO <> 0 then Exit;
        KL := KLNEW;
      end else
        { IJOB=3: Binary search. Keep only the interval containing w
          s.t. N(w) = NVAL. }
        for JI := KF to KL do
        begin
          if IWORK[JI] <= NVAL[JI] then
          begin
            AB[JI] := C[JI];
            NAB[JI] := IWORK[JI];
          end;
          if IWORK[JI] >= NVAL[JI] then
          begin
            AB[MMAX + JI] := C[JI];
            NAB[MMAX + JI] := IWORK[JI];
          end;
        end;
    end else
    begin
      { Begin of Serial Version of the loop. }
      KLNEW := KL;
      for JI := KF to KL do
      begin
        { Compute N(w), the number of eigenvalues less than w. }
        TMP1 := C[JI];
        TMP2 := D[DO_] - TMP1;
        ITMP1 := 0;
        if TMP2 <= PIVMIN then
        begin
          ITMP1 := 1;
          TMP2 := Min(TMP2, -PIVMIN);
        end;
        for J := 1 to N - 1 do
        begin
          TMP2 := D[DO_ + J] - E2[E2O + J - 1] / TMP2 - TMP1;
          if TMP2 <= PIVMIN then
          begin
            ITMP1 := ITMP1 + 1;
            TMP2 := Min(TMP2, -PIVMIN);
          end;
        end;
        if IJOB <= 2 then
        begin
          { IJOB=2: Choose all intervals containing eigenvalues. Insure
            that N(w) is monotone. }
          ITMP1 := Min(NAB[MMAX + JI], Max(NAB[JI], ITMP1));
          { Update the Queue -- add intervals if both halves contain
            eigenvalues. }
          if ITMP1 = NAB[MMAX + JI] then
            AB[MMAX + JI] := TMP1
          else if ITMP1 = NAB[JI] then
            AB[JI] := TMP1
          else if KLNEW < MMAX - 1 then
          begin
            { Eigenvalue in both intervals -- add upper to queue. }
            KLNEW := KLNEW + 1;
            AB[MMAX + KLNEW] := AB[MMAX + JI];
            NAB[MMAX + KLNEW] := NAB[MMAX + JI];
            AB[KLNEW] := TMP1;
            NAB[KLNEW] := ITMP1;
            AB[MMAX + JI] := TMP1;
            NAB[MMAX + JI] := ITMP1;
          end else
          begin
            INFO := MMAX + 1;
            Exit;
          end;
        end else
        begin
          { IJOB=3: Binary search. Keep only the interval containing w
            s.t. N(w) = NVAL. }
          if ITMP1 <= NVAL[JI] then
          begin
            AB[JI] := TMP1;
            NAB[JI] := ITMP1;
          end;
          if ITMP1 >= NVAL[JI] then
          begin
            AB[MMAX + JI] := TMP1;
            NAB[MMAX + JI] := ITMP1;
          end;
        end;
      end;
      KL := KLNEW;
    end;
    { Check for convergence. }
    KFNEW := KF;
    for JI := KF to KL do
    begin
      TMP1 := System.Abs(AB[MMAX + JI] - AB[JI]);
      TMP2 := Max(System.Abs(AB[MMAX + JI]), System.Abs(AB[JI]));
      if (TMP1 < Max(Max(ABSTOL, PIVMIN), RELTOL * TMP2)) or
         (NAB[JI] >= NAB[MMAX + JI]) then
      begin
        { Converged -- Swap with position KFNEW, then increment KFNEW. }
        if JI > KFNEW then
        begin
          TMP1 := AB[JI];
          TMP2 := AB[MMAX + JI];
          ITMP1 := NAB[JI];
          ITMP2 := NAB[MMAX + JI];
          AB[JI] := AB[KFNEW];
          AB[MMAX + JI] := AB[MMAX + KFNEW];
          NAB[JI] := NAB[KFNEW];
          NAB[MMAX + JI] := NAB[MMAX + KFNEW];
          AB[KFNEW] := TMP1;
          AB[MMAX + KFNEW] := TMP2;
          NAB[KFNEW] := ITMP1;
          NAB[MMAX + KFNEW] := ITMP2;
          if IJOB = 3 then
          begin
            ITMP1 := NVAL[JI];
            NVAL[JI] := NVAL[KFNEW];
            NVAL[KFNEW] := ITMP1;
          end;
        end;
        KFNEW := KFNEW + 1;
      end;
    end;
    KF := KFNEW;
    { Choose Midpoints. }
    for JI := KF to KL do C[JI] := HALF * (AB[JI] + AB[MMAX + JI]);
    { If no more intervals to refine, quit. }
    if KF > KL then Break;
  end;
  { Converged. }
  INFO := Max(KL + 1 - KF, 0);
  MOUT := KL + 1;
end;

{ DSTEBZ: selected eigenvalues of the symmetric tridiagonal matrix with
  diagonal D and off-diagonal E by bisection. RANGE 'A' (all), 'V'
  (in (VL, VU]) or 'I' (the IL-th to IU-th, counted from 1); ORDER 'B'
  (by block) or 'E' (whole matrix, ascending). W, IBLOCK and ISPLIT have
  N entries; on exit M eigenvalues are in W, their block numbers in
  IBLOCK and the last rows (from 1) of the NSPLIT blocks in ISPLIT. }
procedure DSTEBZ(RANGE, ORDER: char; N: longint; VL, VU: TReal;
  IL, IU: longint; ABSTOL: TReal; const D, E: array of TReal;
  out M, NSPLIT: longint; var W: array of TReal;
  var IBLOCK, ISPLIT: array of longint; out INFO: longint);
const
  ONE: TReal = 1;
  TWO: TReal = 2;
  HALF: TReal = 0.5;
  FUDGE: TReal = 2.1;
  RELFAC: TReal = 2;
var
  NCNVRG, TOOFEW: boolean;
  IB, IBEGIN, IDISCL, IDISCU, IE, IEND, IINFO, IM, IN_, IOFF, IORDER,
    IOUT, IRANGE, ITMAX, ITMP1, IW, IWOFF, J, JB, JDISC, JE, NB, NWL,
    NWU: longint;
  ATOLI, BNORM, GL, GU, PIVMIN, RTOLI, SAFEMN, TMP1, TMP2, TNORM, ULP,
    WKILL, WL, WLU, WU, WUL: TReal;
  WORK, AB, C: array of TReal;
  NAB, NVAL: array of longint;
  AB3, C3: array[0..3] of TReal;
  NAB3: array[0..3] of longint;
  NVAL3: array[0..1] of longint;
begin
  INFO := 0;
  M := 0;
  NSPLIT := 0;
  case RANGE of
    'V': IRANGE := 2;
    'I': IRANGE := 3;
  else
    IRANGE := 1;
  end;
  if ORDER = 'B' then IORDER := 2 else IORDER := 1;
  { Initialize error flags. }
  NCNVRG := False;
  TOOFEW := False;
  if N = 0 then Exit;
  { Simplifications. }
  if (IRANGE = 3) and (IL = 1) and (IU = N) then IRANGE := 1;
  { Get machine constants. NB is the minimum vector length for vector
    bisection, or 0 if only scalar is to be done. }
  SAFEMN := LapackSafeMinimum;
  ULP := LapackPrecision;
  RTOLI := ULP * RELFAC;
  NB := ILAENVNB(1);
  if NB <= 1 then NB := 0;
  { Special Case when N=1. }
  if N = 1 then
  begin
    NSPLIT := 1;
    ISPLIT[0] := 1;
    if (IRANGE = 2) and ((VL >= D[0]) or (VU < D[0])) then
      M := 0
    else
    begin
      W[0] := D[0];
      IBLOCK[0] := 1;
      M := 1;
    end;
    Exit;
  end;
  { Compute Splitting Points; WORK holds the squared off-diagonal. }
  WORK := nil;
  SetLength(WORK, N);
  NSPLIT := 1;
  WORK[N - 1] := 0;
  PIVMIN := ONE;
  for J := 2 to N do
  begin
    TMP1 := Sqr(E[J - 2]);
    if System.Abs(D[J - 1] * D[J - 2]) * Sqr(ULP) + SAFEMN > TMP1 then
    begin
      ISPLIT[NSPLIT - 1] := J - 1;
      NSPLIT := NSPLIT + 1;
      WORK[J - 2] := 0;
    end else
    begin
      WORK[J - 2] := TMP1;
      PIVMIN := Max(PIVMIN, TMP1);
    end;
  end;
  ISPLIT[NSPLIT - 1] := N;
  PIVMIN := PIVMIN * SAFEMN;
  { Compute Interval and ATOLI. }
  if IRANGE = 3 then
  begin
    { RANGE='I': Compute the interval containing eigenvalues IL through
      IU. Compute Gershgorin interval for entire (split) matrix and use
      it as the initial interval. }
    GU := D[0];
    GL := D[0];
    TMP1 := 0;
    for J := 1 to N - 1 do
    begin
      TMP2 := Sqrt(WORK[J - 1]);
      GU := Max(GU, D[J - 1] + TMP1 + TMP2);
      GL := Min(GL, D[J - 1] - TMP1 - TMP2);
      TMP1 := TMP2;
    end;
    GU := Max(GU, D[N - 1] + TMP1);
    GL := Min(GL, D[N - 1] - TMP1);
    TNORM := Max(System.Abs(GL), System.Abs(GU));
    GL := GL - FUDGE * TNORM * ULP * TReal(N) - FUDGE * TWO * PIVMIN;
    GU := GU + FUDGE * TNORM * ULP * TReal(N) + FUDGE * PIVMIN;
    { Compute Iteration parameters. }
    ITMAX := Trunc((LOGX(TNORM + PIVMIN) - LOGX(PIVMIN)) / LOGX(TWO)) + 2;
    if ABSTOL <= 0 then ATOLI := ULP * TNORM else ATOLI := ABSTOL;
    AB3[0] := GL;
    AB3[1] := GL;
    AB3[2] := GU;
    AB3[3] := GU;
    C3[0] := GL;
    C3[1] := GU;
    NAB3[0] := -1;
    NAB3[1] := -1;
    NAB3[2] := N + 1;
    NAB3[3] := N + 1;
    NVAL3[0] := IL - 1;
    NVAL3[1] := IU;
    DLAEBZ(3, ITMAX, N, 2, 2, NB, ATOLI, RTOLI, PIVMIN, D, 0, WORK, 0, NVAL3,
      AB3, C3, IOUT, NAB3, IINFO);
    if NVAL3[1] = IU then
    begin
      WL := AB3[0];
      WLU := AB3[2];
      NWL := NAB3[0];
      WU := AB3[3];
      WUL := AB3[1];
      NWU := NAB3[3];
    end else
    begin
      WL := AB3[1];
      WLU := AB3[3];
      NWL := NAB3[1];
      WU := AB3[2];
      WUL := AB3[0];
      NWU := NAB3[2];
    end;
    if (NWL < 0) or (NWL >= N) or (NWU < 1) or (NWU > N) then
    begin
      INFO := 4;
      Exit;
    end;
  end else
  begin
    { RANGE='A' or 'V' -- Set ATOLI. }
    TNORM := Max(System.Abs(D[0]) + System.Abs(E[0]),
      System.Abs(D[N - 1]) + System.Abs(E[N - 2]));
    for J := 2 to N - 1 do
      TNORM := Max(TNORM, System.Abs(D[J - 1]) + System.Abs(E[J - 2]) +
        System.Abs(E[J - 1]));
    if ABSTOL <= 0 then ATOLI := ULP * TNORM else ATOLI := ABSTOL;
    if IRANGE = 2 then
    begin
      WL := VL;
      WU := VU;
    end else
    begin
      WL := 0;
      WU := 0;
    end;
    WLU := 0;
    WUL := 0;
  end;
  { Find Eigenvalues -- Loop Over Blocks and recompute NWL and NWU. NWL
    accumulates the number of eigenvalues .le. WL, NWU accumulates the
    number of eigenvalues .le. WU. }
  M := 0;
  IEND := 0;
  INFO := 0;
  NWL := 0;
  NWU := 0;
  for JB := 1 to NSPLIT do
  begin
    IOFF := IEND;
    IBEGIN := IOFF + 1;
    IEND := ISPLIT[JB - 1];
    IN_ := IEND - IOFF;
    if IN_ = 1 then
    begin
      { Special Case -- IN=1. }
      if (IRANGE = 1) or (WL >= D[IBEGIN - 1] - PIVMIN) then NWL := NWL + 1;
      if (IRANGE = 1) or (WU >= D[IBEGIN - 1] - PIVMIN) then NWU := NWU + 1;
      if (IRANGE = 1) or ((WL < D[IBEGIN - 1] - PIVMIN) and
        (WU >= D[IBEGIN - 1] - PIVMIN)) then
      begin
        M := M + 1;
        W[M - 1] := D[IBEGIN - 1];
        IBLOCK[M - 1] := JB;
      end;
    end else
    begin
      { General Case -- IN > 1. Compute Gershgorin Interval and use it as
        the initial interval. }
      GU := D[IBEGIN - 1];
      GL := D[IBEGIN - 1];
      TMP1 := 0;
      for J := IBEGIN to IEND - 1 do
      begin
        TMP2 := System.Abs(E[J - 1]);
        GU := Max(GU, D[J - 1] + TMP1 + TMP2);
        GL := Min(GL, D[J - 1] - TMP1 - TMP2);
        TMP1 := TMP2;
      end;
      GU := Max(GU, D[IEND - 1] + TMP1);
      GL := Min(GL, D[IEND - 1] - TMP1);
      BNORM := Max(System.Abs(GL), System.Abs(GU));
      GL := GL - FUDGE * BNORM * ULP * TReal(IN_) - FUDGE * PIVMIN;
      GU := GU + FUDGE * BNORM * ULP * TReal(IN_) + FUDGE * PIVMIN;
      { Compute ATOLI for the current submatrix. }
      if ABSTOL <= 0 then
        ATOLI := ULP * Max(System.Abs(GL), System.Abs(GU))
      else
        ATOLI := ABSTOL;
      if IRANGE > 1 then
      begin
        if GU < WL then
        begin
          NWL := NWL + IN_;
          NWU := NWU + IN_;
          Continue;
        end;
        GL := Max(GL, WL);
        GU := Min(GU, WU);
        if GL >= GU then Continue;
      end;
      { Set Up Initial Interval. }
      AB := nil;
      C := nil;
      NAB := nil;
      NVAL := nil;
      SetLength(AB, 2 * IN_);
      SetLength(C, IN_);
      SetLength(NAB, 2 * IN_);
      SetLength(NVAL, IN_);
      AB[0] := GL;
      AB[IN_] := GU;
      DLAEBZ(1, 0, IN_, IN_, 1, NB, ATOLI, RTOLI, PIVMIN, D, IBEGIN - 1, WORK,
        IBEGIN - 1, NVAL, AB, C, IM, NAB, IINFO);
      NWL := NWL + NAB[0];
      NWU := NWU + NAB[IN_];
      IWOFF := M - NAB[0];
      { Compute Eigenvalues. }
      ITMAX := Trunc((LOGX(GU - GL + PIVMIN) - LOGX(PIVMIN)) / LOGX(TWO)) + 2;
      DLAEBZ(2, ITMAX, IN_, IN_, 1, NB, ATOLI, RTOLI, PIVMIN, D, IBEGIN - 1,
        WORK, IBEGIN - 1, NVAL, AB, C, IOUT, NAB, IINFO);
      { Copy Eigenvalues Into W and IBLOCK. Use -JB for block number for
        unconverged eigenvalues. }
      for J := 1 to IOUT do
      begin
        TMP1 := HALF * (AB[J - 1] + AB[IN_ + J - 1]);
        { Flag non-convergence. }
        if J > IOUT - IINFO then
        begin
          NCNVRG := True;
          IB := -JB;
        end else
          IB := JB;
        for JE := NAB[J - 1] + 1 + IWOFF to NAB[IN_ + J - 1] + IWOFF do
        begin
          W[JE - 1] := TMP1;
          IBLOCK[JE - 1] := IB;
        end;
      end;
      M := M + IM;
    end;
  end;
  { If RANGE='I', then (WL,WU) contains eigenvalues NWL+1,...,NWU. If
    NWL+1 < IL or NWU > IU, discard extra eigenvalues. }
  if IRANGE = 3 then
  begin
    IM := 0;
    IDISCL := IL - 1 - NWL;
    IDISCU := NWU - IU;
    if (IDISCL > 0) or (IDISCU > 0) then
    begin
      for JE := 1 to M do
        if (W[JE - 1] <= WLU) and (IDISCL > 0) then
          IDISCL := IDISCL - 1
        else if (W[JE - 1] >= WUL) and (IDISCU > 0) then
          IDISCU := IDISCU - 1
        else
        begin
          IM := IM + 1;
          W[IM - 1] := W[JE - 1];
          IBLOCK[IM - 1] := IBLOCK[JE - 1];
        end;
      M := IM;
    end;
    if (IDISCL > 0) or (IDISCU > 0) then
    begin
      { Code to deal with effects of bad arithmetic: some low eigenvalues
        to be discarded are not in (WL,WLU], or high eigenvalues to be
        discarded are not in (WUL,WU] so just kill off the smallest
        IDISCL/largest IDISCU eigenvalues, by simply finding the
        smallest/largest eigenvalue(s). }
      if IDISCL > 0 then
      begin
        WKILL := WU;
        for JDISC := 1 to IDISCL do
        begin
          IW := 0;
          for JE := 1 to M do
            if (IBLOCK[JE - 1] <> 0) and ((W[JE - 1] < WKILL) or (IW = 0)) then
            begin
              IW := JE;
              WKILL := W[JE - 1];
            end;
          IBLOCK[IW - 1] := 0;
        end;
      end;
      if IDISCU > 0 then
      begin
        WKILL := WL;
        for JDISC := 1 to IDISCU do
        begin
          IW := 0;
          for JE := 1 to M do
            if (IBLOCK[JE - 1] <> 0) and ((W[JE - 1] > WKILL) or (IW = 0)) then
            begin
              IW := JE;
              WKILL := W[JE - 1];
            end;
          IBLOCK[IW - 1] := 0;
        end;
      end;
      IM := 0;
      for JE := 1 to M do
        if IBLOCK[JE - 1] <> 0 then
        begin
          IM := IM + 1;
          W[IM - 1] := W[JE - 1];
          IBLOCK[IM - 1] := IBLOCK[JE - 1];
        end;
      M := IM;
    end;
    if (IDISCL < 0) or (IDISCU < 0) then TOOFEW := True;
  end;
  { If ORDER='B', do nothing -- the eigenvalues are already sorted by
    block. If ORDER='E', sort the eigenvalues from smallest to largest. }
  if (IORDER = 1) and (NSPLIT > 1) then
    for JE := 1 to M - 1 do
    begin
      IE := 0;
      TMP1 := W[JE - 1];
      for J := JE + 1 to M do
        if W[J - 1] < TMP1 then
        begin
          IE := J;
          TMP1 := W[J - 1];
        end;
      if IE <> 0 then
      begin
        ITMP1 := IBLOCK[IE - 1];
        W[IE - 1] := W[JE - 1];
        IBLOCK[IE - 1] := IBLOCK[JE - 1];
        W[JE - 1] := TMP1;
        IBLOCK[JE - 1] := ITMP1;
      end;
    end;
  INFO := 0;
  if NCNVRG then INFO := INFO + 1;
  if TOOFEW then INFO := INFO + 2;
end;

{ DSTEIN: eigenvectors of the symmetric tridiagonal matrix (D, E) for the
  M eigenvalues W from DSTEBZ (ORDER = 'B'), by inverse iteration; they
  go to the first M columns of the N-row matrix Z (row stride LDZ). IFAIL
  receives the numbers (from 1) of the eigenvectors that failed to
  converge; INFO is their count. }
procedure DSTEIN(N: longint; const D, E: array of TReal; M: longint;
  const W: array of TReal; const IBLOCK, ISPLIT: array of longint;
  var Z: array of TReal; ZO, LDZ: longint; var IFAIL: array of longint;
  out INFO: longint);
const
  ONE: TReal = 1;
  TEN: TReal = 10;
  ODM3: TReal = 1E-3;
  ODM1: TReal = 1E-1;
  MAXITS = 5;
  EXTRA = 2;
var
  B1, BLKSIZ, BN, GPIND, I, IINFO, ITS, J, J1, JBLK, JMAX, NBLK,
    NRMCHK: longint;
  DTPCRT, EPS, EPS1, NRM, ONENRM, ORTOL, PERTOL, SCL, SEP, TOL, XJ, XJM,
    ZTR: TReal;
  ISEED: array[0..3] of longint;
  RV1, RV2, RV3, RV4, RV5: array of TReal;
  IWORK: array of longint;
  FAILED: boolean;
begin
  INFO := 0;
  for I := 0 to M - 1 do IFAIL[I] := 0;
  for J := 2 to M do
    if (IBLOCK[J - 1] < IBLOCK[J - 2]) or
       ((IBLOCK[J - 1] = IBLOCK[J - 2]) and (W[J - 1] < W[J - 2])) then
    begin
      INFO := -6;
      Exit;
    end;
  { Quick return if possible. }
  if (N = 0) or (M = 0) then Exit;
  if N = 1 then
  begin
    Z[ZO] := ONE;
    Exit;
  end;
  { Get machine constants. }
  EPS := LapackPrecision;
  { Initialize seed for random number generator DLARNV. }
  for I := 0 to 3 do ISEED[I] := 1;
  RV1 := nil;
  RV2 := nil;
  RV3 := nil;
  RV4 := nil;
  RV5 := nil;
  IWORK := nil;
  SetLength(RV1, N);
  SetLength(RV2, N);
  SetLength(RV3, N);
  SetLength(RV4, N);
  SetLength(RV5, N);
  SetLength(IWORK, N);
  ONENRM := 0;
  ORTOL := 0;
  DTPCRT := 0;
  XJM := 0;
  GPIND := 0;
  { Compute eigenvectors of matrix blocks. }
  J1 := 1;
  for NBLK := 1 to IBLOCK[M - 1] do
  begin
    { Find starting and ending indices of block nblk. }
    if NBLK = 1 then B1 := 1 else B1 := ISPLIT[NBLK - 2] + 1;
    BN := ISPLIT[NBLK - 1];
    BLKSIZ := BN - B1 + 1;
    if BLKSIZ <> 1 then
    begin
      GPIND := J1;
      { Compute reorthogonalization criterion and stopping criterion. }
      ONENRM := System.Abs(D[B1 - 1]) + System.Abs(E[B1 - 1]);
      ONENRM := Max(ONENRM, System.Abs(D[BN - 1]) + System.Abs(E[BN - 2]));
      for I := B1 + 1 to BN - 1 do
        ONENRM := Max(ONENRM, System.Abs(D[I - 1]) + System.Abs(E[I - 2]) +
          System.Abs(E[I - 1]));
      ORTOL := ODM3 * ONENRM;
      DTPCRT := Sqrt(ODM1 / TReal(BLKSIZ));
    end;
    { Loop through eigenvalues of block nblk. }
    JBLK := 0;
    J := J1;
    while J <= M do
    begin
      if IBLOCK[J - 1] <> NBLK then
      begin
        J1 := J;
        Break;
      end;
      JBLK := JBLK + 1;
      XJ := W[J - 1];
      if BLKSIZ = 1 then
        { Skip all the work if the block size is one. }
        RV1[0] := ONE
      else
      begin
        { If eigenvalues j and j-1 are too close, add a relatively small
          perturbation. }
        if JBLK > 1 then
        begin
          EPS1 := System.Abs(EPS * XJ);
          PERTOL := TEN * EPS1;
          SEP := XJ - XJM;
          if SEP < PERTOL then XJ := XJM + PERTOL;
        end;
        ITS := 0;
        NRMCHK := 0;
        { Get random starting vector. }
        DLARNV(2, ISEED, BLKSIZ, RV1, 0);
        { Copy the matrix T so it won't be destroyed in factorization. }
        for I := 0 to BLKSIZ - 1 do RV4[I] := D[B1 - 1 + I];
        for I := 0 to BLKSIZ - 2 do
        begin
          RV2[I] := E[B1 - 1 + I];
          RV3[I] := E[B1 - 1 + I];
        end;
        { Compute LU factors with partial pivoting ( PT = LU ). }
        TOL := 0;
        DLAGTF(BLKSIZ, RV4, XJ, RV2, RV3, TOL, RV5, IWORK, IINFO);
        { Update iteration count. }
        FAILED := False;
        repeat
          ITS := ITS + 1;
          if ITS > MAXITS then
          begin
            FAILED := True;
            Break;
          end;
          { Normalize and scale the righthand side vector Pb. }
          JMAX := specialize IAMAX<TReal>(BLKSIZ, RV1, 0, 1);
          SCL := TReal(BLKSIZ) * ONENRM * Max(EPS, System.Abs(RV4[BLKSIZ - 1])) /
            System.Abs(RV1[JMAX]);
          specialize SCAL<TReal>(BLKSIZ, SCL, RV1, 0, 1);
          { Solve the system LU = Pb. }
          DLAGTS(-1, BLKSIZ, RV4, RV2, RV3, RV5, IWORK, RV1, TOL, IINFO);
          { Reorthogonalize by modified Gram-Schmidt if eigenvalues are
            close enough. }
          if JBLK <> 1 then
          begin
            if System.Abs(XJ - XJM) > ORTOL then GPIND := J;
            if GPIND <> J then
              for I := GPIND to J - 1 do
              begin
                ZTR := -specialize DOT<TReal>(False, BLKSIZ, RV1, 0, 1, Z,
                  ZO + (B1 - 1) * LDZ + I - 1, LDZ);
                specialize AXPY<TReal>(BLKSIZ, ZTR, Z,
                  ZO + (B1 - 1) * LDZ + I - 1, LDZ, RV1, 0, 1);
              end;
          end;
          { Check the infinity norm of the iterate. }
          JMAX := specialize IAMAX<TReal>(BLKSIZ, RV1, 0, 1);
          NRM := System.Abs(RV1[JMAX]);
          { Continue for additional iterations after norm reaches
            stopping criterion. }
          if NRM < DTPCRT then Continue;
          NRMCHK := NRMCHK + 1;
          if NRMCHK < EXTRA + 1 then Continue;
          Break;
        until False;
        if FAILED then
        begin
          { If stopping criterion was not satisfied, update info and
            store eigenvector number in array ifail. }
          INFO := INFO + 1;
          IFAIL[INFO - 1] := J;
        end;
        { Accept iterate as jth eigenvector. }
        SCL := ONE / specialize NRM2<TReal>(BLKSIZ, RV1, 0, 1);
        JMAX := specialize IAMAX<TReal>(BLKSIZ, RV1, 0, 1);
        if RV1[JMAX] < 0 then SCL := -SCL;
        specialize SCAL<TReal>(BLKSIZ, SCL, RV1, 0, 1);
      end;
      for I := 0 to N - 1 do Z[ZO + I * LDZ + J - 1] := 0;
      for I := 0 to BLKSIZ - 1 do Z[ZO + (B1 - 1 + I) * LDZ + J - 1] := RV1[I];
      { Save the shift to check eigenvalue spacing at next iteration. }
      XJM := XJ;
      J := J + 1;
    end;
  end;
end;

{ DSTEVX with JOBZ = 'V': selected eigenvalues (RANGE 'A', 'V' in
  (VL, VU] or 'I' the IL-th to IU-th from 1) and eigenvectors of the
  symmetric tridiagonal matrix (D, E), which may be scaled on exit. The
  M eigenvalues go to W in ascending order, the eigenvectors to the first
  M columns of the N-row matrix Z (row stride LDZ, at least N columns
  when all eigenvalues are requested). IFAIL (N entries) and INFO as in
  DSTEIN. }
procedure DSTEVX(RANGE: char; N: longint; var D, E: array of TReal;
  VL, VU: TReal; IL, IU: longint; ABSTOL: TReal; out M: longint;
  var W, Z: array of TReal; ZO, LDZ: longint; var IFAIL: array of longint;
  out INFO: longint);
const
  ONE: TReal = 1;
var
  ALLEIG, INDEIG, TEST, VALEIG: boolean;
  I, IMAX, ISCALE, ITMP1, J, JJ, NSPLIT: longint;
  BIGNUM, EPS, RMAX, RMIN, SAFMIN, SIGMA, SMLNUM, TMP1, TNRM, VLL,
    VUU: TReal;
  WORK: array of TReal;
  IBLOCK, ISPLIT: array of longint;
begin
  ALLEIG := RANGE = 'A';
  VALEIG := RANGE = 'V';
  INDEIG := RANGE = 'I';
  INFO := 0;
  M := 0;
  if N = 0 then Exit;
  if N = 1 then
  begin
    if ALLEIG or INDEIG then
    begin
      M := 1;
      W[0] := D[0];
    end else if (VL < D[0]) and (VU >= D[0]) then
    begin
      M := 1;
      W[0] := D[0];
    end;
    Z[ZO] := ONE;
    Exit;
  end;
  { Get machine constants. }
  SAFMIN := LapackSafeMinimum;
  EPS := LapackPrecision;
  SMLNUM := SAFMIN / EPS;
  BIGNUM := ONE / SMLNUM;
  RMIN := Sqrt(SMLNUM);
  RMAX := Min(Sqrt(BIGNUM), ONE / Sqrt(Sqrt(SAFMIN)));
  { Scale matrix to allowable range, if necessary. }
  ISCALE := 0;
  SIGMA := 1;
  if VALEIG then
  begin
    VLL := VL;
    VUU := VU;
  end else
  begin
    VLL := 0;
    VUU := 0;
  end;
  TNRM := DLANST('M', N, D, 0, E, 0);
  if (TNRM > 0) and (TNRM < RMIN) then
  begin
    ISCALE := 1;
    SIGMA := RMIN / TNRM;
  end else if TNRM > RMAX then
  begin
    ISCALE := 1;
    SIGMA := RMAX / TNRM;
  end;
  if ISCALE = 1 then
  begin
    specialize SCAL<TReal>(N, SIGMA, D, 0, 1);
    specialize SCAL<TReal>(N - 1, SIGMA, E, 0, 1);
    if VALEIG then
    begin
      VLL := VL * SIGMA;
      VUU := VU * SIGMA;
    end;
  end;
  IBLOCK := nil;
  ISPLIT := nil;
  SetLength(IBLOCK, N);
  SetLength(ISPLIT, N);
  { If all eigenvalues are desired and ABSTOL is less than zero, then
    call DSTERF or DSTEQR. If this fails for some eigenvalue, then try
    DSTEBZ. }
  TEST := INDEIG and (IL = 1) and (IU = N);
  if (ALLEIG or TEST) and (ABSTOL <= 0) then
  begin
    for I := 0 to N - 1 do W[I] := D[I];
    WORK := nil;
    SetLength(WORK, N - 1);
    for I := 0 to N - 2 do WORK[I] := E[I];
    specialize STEQR<TReal>('I', N, W, WORK, Z, ZO, LDZ, INFO);
    if INFO = 0 then
    begin
      for I := 0 to N - 1 do IFAIL[I] := 0;
      M := N;
    end else
      INFO := 0;
  end;
  if M = 0 then
  begin
    { Otherwise, call DSTEBZ and, if eigenvectors are desired, DSTEIN. }
    DSTEBZ(RANGE, 'B', N, VLL, VUU, IL, IU, ABSTOL, D, E, M, NSPLIT, W,
      IBLOCK, ISPLIT, INFO);
    DSTEIN(N, D, E, M, W, IBLOCK, ISPLIT, Z, ZO, LDZ, IFAIL, INFO);
  end;
  { If matrix was scaled, then rescale eigenvalues appropriately. }
  if ISCALE = 1 then
  begin
    if INFO = 0 then IMAX := M else IMAX := INFO - 1;
    specialize SCAL<TReal>(IMAX, ONE / SIGMA, W, 0, 1);
  end;
  { If eigenvalues are not in order, then sort them, along with
    eigenvectors. }
  for J := 1 to M - 1 do
  begin
    I := 0;
    TMP1 := W[J - 1];
    for JJ := J + 1 to M do
      if W[JJ - 1] < TMP1 then
      begin
        I := JJ;
        TMP1 := W[JJ - 1];
      end;
    if I <> 0 then
    begin
      ITMP1 := IBLOCK[I - 1];
      W[I - 1] := W[J - 1];
      IBLOCK[I - 1] := IBLOCK[J - 1];
      W[J - 1] := TMP1;
      IBLOCK[J - 1] := ITMP1;
      specialize SWAP<TReal>(N, Z, ZO + I - 1, LDZ, Z, ZO + J - 1, LDZ);
      if INFO <> 0 then
      begin
        ITMP1 := IFAIL[I - 1];
        IFAIL[I - 1] := IFAIL[J - 1];
        IFAIL[J - 1] := ITMP1;
      end;
    end;
  end;
end;
{ ---------------------------------------------------------------------
  Singular values (LAPACK 3.12.1): xGESVD with JOBU = JOBVT = 'N' for
  square matrices, with xGEBRD (xLABRD, xGEBD2) and DBDSQR, which calls
  the dqds algorithm DLASQ1..DLASQ6. The arithmetic is IEEE (ILAENV(10)
  = 1), so DLASQ5 runs its IEEE branch. In DLASQ1..DLASQ6 the array Z is
  indexed from 1, as in LAPACK (Z[0] is not used).
  --------------------------------------------------------------------- }

{ DLAS2: singular values SSMIN <= SSMAX of the 2x2 upper triangular
  matrix [F G; 0 H]. }
procedure DLAS2(F, G, H: TReal; out SSMIN, SSMAX: TReal);
const
  ONE: TReal = 1;
  TWO: TReal = 2;
var
  AS_, AT, AU, C, FA, FHMN, FHMX, GA, HA: TReal;
begin
  FA := System.Abs(F);
  GA := System.Abs(G);
  HA := System.Abs(H);
  FHMN := Min(FA, HA);
  FHMX := Max(FA, HA);
  if FHMN = 0 then
  begin
    SSMIN := 0;
    if FHMX = 0 then
      SSMAX := GA
    else
      SSMAX := Max(FHMX, GA) * Sqrt(ONE + Sqr(Min(FHMX, GA) / Max(FHMX, GA)));
  end else if GA < FHMX then
  begin
    AS_ := ONE + FHMN / FHMX;
    AT := (FHMX - FHMN) / FHMX;
    AU := Sqr(GA / FHMX);
    C := TWO / (Sqrt(AS_ * AS_ + AU) + Sqrt(AT * AT + AU));
    SSMIN := FHMN * C;
    SSMAX := FHMX / C;
  end else
  begin
    AU := FHMX / GA;
    if AU = 0 then
    begin
      { Avoid possible harmful underflow if exponent range asymmetric
        (true SSMIN may not underflow even if AU underflows). }
      SSMIN := (FHMN * FHMX) / GA;
      SSMAX := GA;
    end else
    begin
      AS_ := ONE + FHMN / FHMX;
      AT := (FHMX - FHMN) / FHMX;
      C := ONE / (Sqrt(ONE + Sqr(AS_ * AU)) + Sqrt(ONE + Sqr(AT * AU)));
      SSMIN := (FHMN * C) * AU;
      SSMIN := SSMIN + SSMIN;
      SSMAX := GA / (C + C);
    end;
  end;
end;

{ DLASV2: SVD of the 2x2 upper triangular matrix [F G; 0 H]. }
procedure DLASV2(F, G, H: TReal; out SSMIN, SSMAX, SNR, CSR, SNL,
  CSL: TReal);
const
  ONE: TReal = 1;
  TWO: TReal = 2;
  FOUR: TReal = 4;
  HALF: TReal = 0.5;
var
  GASMAL, SWAP: boolean;
  PMAX: longint;
  A, CLT, CRT, D, FA, FT, GA, GT, HA, HT, L, M, MM, R, S, SLT, SRT, T,
    TEMP, TSIGN, TT: TReal;
begin
  FT := F;
  FA := System.Abs(FT);
  HT := H;
  HA := System.Abs(H);
  { PMAX points to the maximum absolute element of matrix: 1 if F
    largest, 2 if G largest, 3 if H largest. }
  PMAX := 1;
  SWAP := HA > FA;
  if SWAP then
  begin
    PMAX := 3;
    TEMP := FT;
    FT := HT;
    HT := TEMP;
    TEMP := FA;
    FA := HA;
    HA := TEMP;
    { Now FA .ge. HA }
  end;
  GT := G;
  GA := System.Abs(GT);
  TSIGN := ONE;
  if GA = 0 then
  begin
    { Diagonal matrix. }
    SSMIN := HA;
    SSMAX := FA;
    CLT := ONE;
    CRT := ONE;
    SLT := 0;
    SRT := 0;
  end else
  begin
    GASMAL := True;
    if GA > FA then
    begin
      PMAX := 2;
      if (FA / GA) < LapackEpsilon then
      begin
        { Case of very large GA. }
        GASMAL := False;
        SSMAX := GA;
        if HA > ONE then
          SSMIN := FA / (GA / HA)
        else
          SSMIN := (FA / GA) * HA;
        CLT := ONE;
        SLT := HT / GT;
        SRT := ONE;
        CRT := FT / GT;
      end;
    end;
    if GASMAL then
    begin
      { Normal case. }
      D := FA - HA;
      if D = FA then
        { Copes with infinite F or H. }
        L := ONE
      else
        L := D / FA;
      { Note that 0 .le. L .le. 1 }
      M := GT / FT;
      { Note that abs(M) .le. 1/macheps }
      T := TWO - L;
      { Note that T .ge. 1 }
      MM := M * M;
      TT := T * T;
      S := Sqrt(TT + MM);
      { Note that 1 .le. S .le. 1 + 1/macheps }
      if L = 0 then
        R := System.Abs(M)
      else
        R := Sqrt(L * L + MM);
      { Note that 0 .le. R .le. 1 + 1/macheps }
      A := HALF * (S + R);
      { Note that 1 .le. A .le. 1 + abs(M) }
      SSMIN := HA / A;
      SSMAX := FA * A;
      if MM = 0 then
      begin
        { Note that M is very tiny. }
        if L = 0 then
          T := SIGN(TWO, FT) * SIGN(ONE, GT)
        else
          T := GT / SIGN(D, FT) + M / T;
      end else
        T := (M / (S + T) + M / (R + L)) * (ONE + A);
      L := Sqrt(T * T + FOUR);
      CRT := TWO / L;
      SRT := T / L;
      CLT := (CRT + SRT * M) / A;
      SLT := (HT / FT) * SRT / A;
    end;
  end;
  if SWAP then
  begin
    CSL := SRT;
    SNL := CRT;
    CSR := SLT;
    SNR := CLT;
  end else
  begin
    CSL := CLT;
    SNL := SLT;
    CSR := CRT;
    SNR := SRT;
  end;
  { Correct signs of SSMAX and SSMIN. }
  if PMAX = 1 then TSIGN := SIGN(ONE, CSR) * SIGN(ONE, CSL) * SIGN(ONE, F);
  if PMAX = 2 then TSIGN := SIGN(ONE, SNR) * SIGN(ONE, CSL) * SIGN(ONE, G);
  if PMAX = 3 then TSIGN := SIGN(ONE, SNR) * SIGN(ONE, SNL) * SIGN(ONE, H);
  SSMAX := SIGN(SSMAX, TSIGN);
  SSMIN := SIGN(SSMIN, TSIGN * SIGN(ONE, F) * SIGN(ONE, H));
end;

{ DLASRT: sorts D[DO_+1..DO_+N] (indices from 1 as in LAPACK, i.e.
  D[DO_ + i] for i = 1..N) in decreasing (ID = 'D') or increasing ('I')
  order, by insertion sort on short ranges and quicksort otherwise. }
procedure DLASRT(ID: char; N: longint; var D: array of TReal; DO_: longint);
const
  SELECT = 20;
var
  DIR, ENDD, I, J, START, STKPNT: longint;
  D1, D2, D3, DMNMX, TMP: TReal;
  STACK: array[1..2, 1..32] of longint;
begin
  if ID = 'D' then DIR := 0 else DIR := 1;
  if N <= 1 then Exit;
  STKPNT := 1;
  STACK[1, 1] := 1;
  STACK[2, 1] := N;
  repeat
    START := STACK[1, STKPNT];
    ENDD := STACK[2, STKPNT];
    STKPNT := STKPNT - 1;
    if (ENDD - START <= SELECT) and (ENDD - START > 0) then
    begin
      { Do Insertion sort on D( START:ENDD ). }
      for I := START + 1 to ENDD do
        for J := I downto START + 1 do
          if ((DIR = 0) and (D[DO_ + J] > D[DO_ + J - 1])) or
             ((DIR = 1) and (D[DO_ + J] < D[DO_ + J - 1])) then
          begin
            DMNMX := D[DO_ + J];
            D[DO_ + J] := D[DO_ + J - 1];
            D[DO_ + J - 1] := DMNMX;
          end else
            Break;
    end else if ENDD - START > SELECT then
    begin
      { Partition D( START:ENDD ) and stack parts, largest one first.
        Choose partition entry as median of 3. }
      D1 := D[DO_ + START];
      D2 := D[DO_ + ENDD];
      I := (START + ENDD) div 2;
      D3 := D[DO_ + I];
      if D1 < D2 then
      begin
        if D3 < D1 then
          DMNMX := D1
        else if D3 < D2 then
          DMNMX := D3
        else
          DMNMX := D2;
      end else
      begin
        if D3 < D2 then
          DMNMX := D2
        else if D3 < D1 then
          DMNMX := D3
        else
          DMNMX := D1;
      end;
      I := START - 1;
      J := ENDD + 1;
      repeat
        if DIR = 0 then
        begin
          { Sort into decreasing order. }
          repeat
            J := J - 1;
          until not (D[DO_ + J] < DMNMX);
          repeat
            I := I + 1;
          until not (D[DO_ + I] > DMNMX);
        end else
        begin
          { Sort into increasing order. }
          repeat
            J := J - 1;
          until not (D[DO_ + J] > DMNMX);
          repeat
            I := I + 1;
          until not (D[DO_ + I] < DMNMX);
        end;
        if I < J then
        begin
          TMP := D[DO_ + I];
          D[DO_ + I] := D[DO_ + J];
          D[DO_ + J] := TMP;
        end else
          Break;
      until False;
      if J - START > ENDD - J - 1 then
      begin
        STKPNT := STKPNT + 1;
        STACK[1, STKPNT] := START;
        STACK[2, STKPNT] := J;
        STKPNT := STKPNT + 1;
        STACK[1, STKPNT] := J + 1;
        STACK[2, STKPNT] := ENDD;
      end else
      begin
        STKPNT := STKPNT + 1;
        STACK[1, STKPNT] := J + 1;
        STACK[2, STKPNT] := ENDD;
        STKPNT := STKPNT + 1;
        STACK[1, STKPNT] := START;
        STACK[2, STKPNT] := J;
      end;
    end;
  until STKPNT <= 0;
end;

{ DLASQ6: one dqd (shift equal to zero) transform in ping-pong form, with
  protection against underflow and overflow. }
procedure DLASQ6(I0, N0: longint; var Z: array of TReal; PP: longint;
  var DMIN, DMIN1, DMIN2, DN, DNM1, DNM2: TReal);
var
  J4, J4P2: longint;
  D, EMIN, SAFMIN, TEMP: TReal;
begin
  if N0 - I0 - 1 <= 0 then Exit;
  SAFMIN := LapackSafeMinimum;
  J4 := 4 * I0 + PP - 3;
  EMIN := Z[J4 + 4];
  D := Z[J4];
  DMIN := D;
  if PP = 0 then
  begin
    J4 := 4 * I0;
    while J4 <= 4 * (N0 - 3) do
    begin
      Z[J4 - 2] := D + Z[J4 - 1];
      if Z[J4 - 2] = 0 then
      begin
        Z[J4] := 0;
        D := Z[J4 + 1];
        DMIN := D;
        EMIN := 0;
      end else if (SAFMIN * Z[J4 + 1] < Z[J4 - 2]) and
        (SAFMIN * Z[J4 - 2] < Z[J4 + 1]) then
      begin
        TEMP := Z[J4 + 1] / Z[J4 - 2];
        Z[J4] := Z[J4 - 1] * TEMP;
        D := D * TEMP;
      end else
      begin
        Z[J4] := Z[J4 + 1] * (Z[J4 - 1] / Z[J4 - 2]);
        D := Z[J4 + 1] * (D / Z[J4 - 2]);
      end;
      DMIN := Min(DMIN, D);
      EMIN := Min(EMIN, Z[J4]);
      J4 := J4 + 4;
    end;
  end else
  begin
    J4 := 4 * I0;
    while J4 <= 4 * (N0 - 3) do
    begin
      Z[J4 - 3] := D + Z[J4];
      if Z[J4 - 3] = 0 then
      begin
        Z[J4 - 1] := 0;
        D := Z[J4 + 2];
        DMIN := D;
        EMIN := 0;
      end else if (SAFMIN * Z[J4 + 2] < Z[J4 - 3]) and
        (SAFMIN * Z[J4 - 3] < Z[J4 + 2]) then
      begin
        TEMP := Z[J4 + 2] / Z[J4 - 3];
        Z[J4 - 1] := Z[J4] * TEMP;
        D := D * TEMP;
      end else
      begin
        Z[J4 - 1] := Z[J4 + 2] * (Z[J4] / Z[J4 - 3]);
        D := Z[J4 + 2] * (D / Z[J4 - 3]);
      end;
      DMIN := Min(DMIN, D);
      EMIN := Min(EMIN, Z[J4 - 1]);
      J4 := J4 + 4;
    end;
  end;
  { Unroll last two steps. }
  DNM2 := D;
  DMIN2 := DMIN;
  J4 := 4 * (N0 - 2) - PP;
  J4P2 := J4 + 2 * PP - 1;
  Z[J4 - 2] := DNM2 + Z[J4P2];
  if Z[J4 - 2] = 0 then
  begin
    Z[J4] := 0;
    DNM1 := Z[J4P2 + 2];
    DMIN := DNM1;
    EMIN := 0;
  end else if (SAFMIN * Z[J4P2 + 2] < Z[J4 - 2]) and
    (SAFMIN * Z[J4 - 2] < Z[J4P2 + 2]) then
  begin
    TEMP := Z[J4P2 + 2] / Z[J4 - 2];
    Z[J4] := Z[J4P2] * TEMP;
    DNM1 := DNM2 * TEMP;
  end else
  begin
    Z[J4] := Z[J4P2 + 2] * (Z[J4P2] / Z[J4 - 2]);
    DNM1 := Z[J4P2 + 2] * (DNM2 / Z[J4 - 2]);
  end;
  DMIN := Min(DMIN, DNM1);
  DMIN1 := DMIN;
  J4 := J4 + 4;
  J4P2 := J4 + 2 * PP - 1;
  Z[J4 - 2] := DNM1 + Z[J4P2];
  if Z[J4 - 2] = 0 then
  begin
    Z[J4] := 0;
    DN := Z[J4P2 + 2];
    DMIN := DN;
    EMIN := 0;
  end else if (SAFMIN * Z[J4P2 + 2] < Z[J4 - 2]) and
    (SAFMIN * Z[J4 - 2] < Z[J4P2 + 2]) then
  begin
    TEMP := Z[J4P2 + 2] / Z[J4 - 2];
    Z[J4] := Z[J4P2] * TEMP;
    DN := DNM1 * TEMP;
  end else
  begin
    Z[J4] := Z[J4P2 + 2] * (Z[J4P2] / Z[J4 - 2]);
    DN := Z[J4P2 + 2] * (DNM1 / Z[J4 - 2]);
  end;
  DMIN := Min(DMIN, DN);
  Z[J4 + 2] := DN;
  Z[4 * N0 - PP] := EMIN;
end;

{ DLASQ5 (IEEE branch): one dqds transform in ping-pong form with shift
  TAU. }
procedure DLASQ5(I0, N0: longint; var Z: array of TReal; PP: longint;
  var TAU: TReal; SIGMA: TReal; var DMIN, DMIN1, DMIN2, DN, DNM1,
  DNM2: TReal; EPS: TReal);
const
  HALF: TReal = 0.5;
var
  J4, J4P2: longint;
  D, EMIN, TEMP, DTHRESH: TReal;
  NONZERO: boolean;
begin
  if N0 - I0 - 1 <= 0 then Exit;
  DTHRESH := EPS * (SIGMA + TAU);
  if TAU < DTHRESH * HALF then TAU := 0;
  NONZERO := TAU <> 0;
  J4 := 4 * I0 + PP - 3;
  EMIN := Z[J4 + 4];
  D := Z[J4] - TAU;
  DMIN := D;
  DMIN1 := -Z[J4];
  { Code for IEEE arithmetic. }
  if PP = 0 then
  begin
    J4 := 4 * I0;
    while J4 <= 4 * (N0 - 3) do
    begin
      Z[J4 - 2] := D + Z[J4 - 1];
      TEMP := Z[J4 + 1] / Z[J4 - 2];
      D := D * TEMP - TAU;
      if not NONZERO and (D < DTHRESH) then D := 0;
      DMIN := Min(DMIN, D);
      Z[J4] := Z[J4 - 1] * TEMP;
      EMIN := Min(Z[J4], EMIN);
      J4 := J4 + 4;
    end;
  end else
  begin
    J4 := 4 * I0;
    while J4 <= 4 * (N0 - 3) do
    begin
      Z[J4 - 3] := D + Z[J4];
      TEMP := Z[J4 + 2] / Z[J4 - 3];
      D := D * TEMP - TAU;
      if not NONZERO and (D < DTHRESH) then D := 0;
      DMIN := Min(DMIN, D);
      Z[J4 - 1] := Z[J4] * TEMP;
      EMIN := Min(Z[J4 - 1], EMIN);
      J4 := J4 + 4;
    end;
  end;
  { Unroll last two steps. }
  DNM2 := D;
  DMIN2 := DMIN;
  J4 := 4 * (N0 - 2) - PP;
  J4P2 := J4 + 2 * PP - 1;
  Z[J4 - 2] := DNM2 + Z[J4P2];
  Z[J4] := Z[J4P2 + 2] * (Z[J4P2] / Z[J4 - 2]);
  DNM1 := Z[J4P2 + 2] * (DNM2 / Z[J4 - 2]) - TAU;
  DMIN := Min(DMIN, DNM1);
  DMIN1 := DMIN;
  J4 := J4 + 4;
  J4P2 := J4 + 2 * PP - 1;
  Z[J4 - 2] := DNM1 + Z[J4P2];
  Z[J4] := Z[J4P2 + 2] * (Z[J4P2] / Z[J4 - 2]);
  DN := Z[J4P2 + 2] * (DNM1 / Z[J4 - 2]) - TAU;
  DMIN := Min(DMIN, DN);
  Z[J4 + 2] := DN;
  Z[4 * N0 - PP] := EMIN;
end;

{ DLASQ4: the shift TAU for the next dqds step, from the history of the
  minimum pivots; TTYPE records the type of shift and G is kept between
  calls. TAU is unchanged on the early returns, as in LAPACK. }
procedure DLASQ4(I0, N0: longint; const Z: array of TReal; PP, N0IN: longint;
  DMIN, DMIN1, DMIN2, DN, DN1, DN2: TReal; var TAU: TReal;
  var TTYPE: longint; var G: TReal);
const
  CNST1: TReal = 0.5630;
  CNST2: TReal = 1.010;
  CNST3: TReal = 1.050;
  QURTR: TReal = 0.250;
  THIRD: TReal = 0.3330;
  HALF: TReal = 0.50;
  ONE: TReal = 1;
  TWO: TReal = 2;
  HUNDRD: TReal = 100;
var
  I4, NN, NP: longint;
  A2, B1, B2, GAM, GAP1, GAP2, S: TReal;
begin
  { A negative DMIN forces the shift to take that absolute value. TTYPE
    records the type of shift. }
  if DMIN <= 0 then
  begin
    TAU := -DMIN;
    TTYPE := -1;
    Exit;
  end;
  NN := 4 * N0 + PP;
  S := 0;
  if N0IN = N0 then
  begin
    { No eigenvalues deflated. }
    if (DMIN = DN) or (DMIN = DN1) then
    begin
      B1 := Sqrt(Z[NN - 3]) * Sqrt(Z[NN - 5]);
      B2 := Sqrt(Z[NN - 7]) * Sqrt(Z[NN - 9]);
      A2 := Z[NN - 7] + Z[NN - 5];
      { Cases 2 and 3. }
      if (DMIN = DN) and (DMIN1 = DN1) then
      begin
        GAP2 := DMIN2 - A2 - DMIN2 * QURTR;
        if (GAP2 > 0) and (GAP2 > B2) then
          GAP1 := A2 - DN - (B2 / GAP2) * B2
        else
          GAP1 := A2 - DN - (B1 + B2);
        if (GAP1 > 0) and (GAP1 > B1) then
        begin
          S := Max(DN - (B1 / GAP1) * B1, HALF * DMIN);
          TTYPE := -2;
        end else
        begin
          S := 0;
          if DN > B1 then S := DN - B1;
          if A2 > (B1 + B2) then S := Min(S, A2 - (B1 + B2));
          S := Max(S, THIRD * DMIN);
          TTYPE := -3;
        end;
      end else
      begin
        { Case 4. }
        TTYPE := -4;
        S := QURTR * DMIN;
        if DMIN = DN then
        begin
          GAM := DN;
          A2 := 0;
          if Z[NN - 5] > Z[NN - 7] then Exit;
          B2 := Z[NN - 5] / Z[NN - 7];
          NP := NN - 9;
        end else
        begin
          NP := NN - 2 * PP;
          GAM := DN1;
          if Z[NP - 4] > Z[NP - 2] then Exit;
          A2 := Z[NP - 4] / Z[NP - 2];
          if Z[NN - 9] > Z[NN - 11] then Exit;
          B2 := Z[NN - 9] / Z[NN - 11];
          NP := NN - 13;
        end;
        { Approximate contribution to norm squared from I < NN-1. }
        A2 := A2 + B2;
        I4 := NP;
        while I4 >= 4 * I0 - 1 + PP do
        begin
          if B2 = 0 then Break;
          B1 := B2;
          if Z[I4] > Z[I4 - 2] then Exit;
          B2 := B2 * (Z[I4] / Z[I4 - 2]);
          A2 := A2 + B2;
          if (HUNDRD * Max(B2, B1) < A2) or (CNST1 < A2) then Break;
          I4 := I4 - 4;
        end;
        A2 := CNST3 * A2;
        { Rayleigh quotient residual bound. }
        if A2 < CNST1 then S := GAM * (ONE - Sqrt(A2)) / (ONE + A2);
      end;
    end else if DMIN = DN2 then
    begin
      { Case 5. }
      TTYPE := -5;
      S := QURTR * DMIN;
      { Compute contribution to norm squared from I > NN-2. }
      NP := NN - 2 * PP;
      B1 := Z[NP - 2];
      B2 := Z[NP - 6];
      GAM := DN2;
      if (Z[NP - 8] > B2) or (Z[NP - 4] > B1) then Exit;
      A2 := (Z[NP - 8] / B2) * (ONE + Z[NP - 4] / B1);
      { Approximate contribution to norm squared from I < NN-2. }
      if N0 - I0 > 2 then
      begin
        B2 := Z[NN - 13] / Z[NN - 15];
        A2 := A2 + B2;
        I4 := NN - 17;
        while I4 >= 4 * I0 - 1 + PP do
        begin
          if B2 = 0 then Break;
          B1 := B2;
          if Z[I4] > Z[I4 - 2] then Exit;
          B2 := B2 * (Z[I4] / Z[I4 - 2]);
          A2 := A2 + B2;
          if (HUNDRD * Max(B2, B1) < A2) or (CNST1 < A2) then Break;
          I4 := I4 - 4;
        end;
        A2 := CNST3 * A2;
      end;
      if A2 < CNST1 then S := GAM * (ONE - Sqrt(A2)) / (ONE + A2);
    end else
    begin
      { Case 6, no information to guide us. }
      if TTYPE = -6 then
        G := G + THIRD * (ONE - G)
      else if TTYPE = -18 then
        G := QURTR * THIRD
      else
        G := QURTR;
      S := G * DMIN;
      TTYPE := -6;
    end;
  end else if N0IN = N0 + 1 then
  begin
    { One eigenvalue just deflated. Use DMIN1, DN1 for DMIN and DN. }
    if (DMIN1 = DN1) and (DMIN2 = DN2) then
    begin
      { Cases 7 and 8. }
      TTYPE := -7;
      S := THIRD * DMIN1;
      if Z[NN - 5] > Z[NN - 7] then Exit;
      B1 := Z[NN - 5] / Z[NN - 7];
      B2 := B1;
      if B2 <> 0 then
      begin
        I4 := 4 * N0 - 9 + PP;
        while I4 >= 4 * I0 - 1 + PP do
        begin
          A2 := B1;
          if Z[I4] > Z[I4 - 2] then Exit;
          B1 := B1 * (Z[I4] / Z[I4 - 2]);
          B2 := B2 + B1;
          if HUNDRD * Max(B1, A2) < B2 then Break;
          I4 := I4 - 4;
        end;
      end;
      B2 := Sqrt(CNST3 * B2);
      A2 := DMIN1 / (ONE + Sqr(B2));
      GAP2 := HALF * DMIN2 - A2;
      if (GAP2 > 0) and (GAP2 > B2 * A2) then
        S := Max(S, A2 * (ONE - CNST2 * A2 * (B2 / GAP2) * B2))
      else
      begin
        S := Max(S, A2 * (ONE - CNST2 * B2));
        TTYPE := -8;
      end;
    end else
    begin
      { Case 9. }
      S := QURTR * DMIN1;
      if DMIN1 = DN1 then S := HALF * DMIN1;
      TTYPE := -9;
    end;
  end else if N0IN = N0 + 2 then
  begin
    { Two eigenvalues deflated. Use DMIN2, DN2 for DMIN and DN. Cases 10
      and 11. }
    if (DMIN2 = DN2) and (TWO * Z[NN - 5] < Z[NN - 7]) then
    begin
      TTYPE := -10;
      S := THIRD * DMIN2;
      if Z[NN - 5] > Z[NN - 7] then Exit;
      B1 := Z[NN - 5] / Z[NN - 7];
      B2 := B1;
      if B2 <> 0 then
      begin
        I4 := 4 * N0 - 9 + PP;
        while I4 >= 4 * I0 - 1 + PP do
        begin
          if Z[I4] > Z[I4 - 2] then Exit;
          B1 := B1 * (Z[I4] / Z[I4 - 2]);
          B2 := B2 + B1;
          if HUNDRD * B1 < B2 then Break;
          I4 := I4 - 4;
        end;
      end;
      B2 := Sqrt(CNST3 * B2);
      A2 := DMIN2 / (ONE + Sqr(B2));
      GAP2 := Z[NN - 7] + Z[NN - 9] - Sqrt(Z[NN - 11]) * Sqrt(Z[NN - 9]) - A2;
      if (GAP2 > 0) and (GAP2 > B2 * A2) then
        S := Max(S, A2 * (ONE - CNST2 * A2 * (B2 / GAP2) * B2))
      else
        S := Max(S, A2 * (ONE - CNST2 * B2));
    end else
    begin
      S := QURTR * DMIN2;
      TTYPE := -11;
    end;
  end else if N0IN > N0 + 2 then
  begin
    { Case 12, more than two eigenvalues deflated. No information. }
    S := 0;
    TTYPE := -12;
  end;
  TAU := S;
end;

{ DLASQ3: checks for deflation, computes a shift (DLASQ4) and calls dqds
  (DLASQ5, DLASQ6); on exit the eigenvalues found are in place. }
procedure DLASQ3(I0: longint; var N0: longint; var Z: array of TReal;
  var PP: longint; var DMIN, SIGMA, DESIG, QMAX: TReal;
  var NFAIL, ITER, NDIV: longint; IEEE: boolean; var TTYPE: longint;
  var DMIN1, DMIN2, DN, DN1, DN2, G, TAU: TReal);
const
  CBIAS: TReal = 1.50;
  QURTR: TReal = 0.250;
  HALF: TReal = 0.5;
  ONE: TReal = 1;
  TWO: TReal = 2;
  HUNDRD: TReal = 100;
var
  IPN4, J4, N0IN, NN: longint;
  EPS, S, T, TEMP, TOL, TOL2: TReal;
  STEP: longint;
begin
  N0IN := N0;
  EPS := LapackPrecision;
  TOL := EPS * HUNDRD;
  TOL2 := Sqr(TOL);
  { Check for deflation. }
  repeat
    if N0 < I0 then Exit;
    if N0 = I0 then
      STEP := 20
    else
    begin
      NN := 4 * N0 + PP;
      if N0 = I0 + 1 then
        STEP := 40
      else if (Z[NN - 5] > TOL2 * (SIGMA + Z[NN - 3])) and
        (Z[NN - 2 * PP - 4] > TOL2 * Z[NN - 7]) then
      begin
        { Label 30: check whether E(N0-2) is negligible, 2 eigenvalues. }
        if (Z[NN - 9] > TOL2 * SIGMA) and
           (Z[NN - 2 * PP - 8] > TOL2 * Z[NN - 11]) then
          STEP := 50
        else
          STEP := 40;
      end else
        STEP := 20;
    end;
    if STEP = 20 then
    begin
      { Label 20: one eigenvalue. }
      Z[4 * N0 - 3] := Z[4 * N0 + PP - 3] + SIGMA;
      N0 := N0 - 1;
    end else if STEP = 40 then
    begin
      { Label 40: two eigenvalues. }
      NN := 4 * N0 + PP;
      if Z[NN - 3] > Z[NN - 7] then
      begin
        S := Z[NN - 3];
        Z[NN - 3] := Z[NN - 7];
        Z[NN - 7] := S;
      end;
      T := HALF * ((Z[NN - 7] - Z[NN - 3]) + Z[NN - 5]);
      if (Z[NN - 5] > Z[NN - 3] * TOL2) and (T <> 0) then
      begin
        S := Z[NN - 3] * (Z[NN - 5] / T);
        if S <= T then
          S := Z[NN - 3] * (Z[NN - 5] / (T * (ONE + Sqrt(ONE + S / T))))
        else
          S := Z[NN - 3] * (Z[NN - 5] / (T + Sqrt(T) * Sqrt(T + S)));
        T := Z[NN - 7] + (S + Z[NN - 5]);
        Z[NN - 3] := Z[NN - 3] * (Z[NN - 7] / T);
        Z[NN - 7] := T;
      end;
      Z[4 * N0 - 7] := Z[NN - 7] + SIGMA;
      Z[4 * N0 - 3] := Z[NN - 3] + SIGMA;
      N0 := N0 - 2;
    end;
  until STEP = 50;
  { Label 50. }
  if PP = 2 then PP := 0;
  { Reverse the qd-array, if warranted. }
  if (DMIN <= 0) or (N0 < N0IN) then
    if CBIAS * Z[4 * I0 + PP - 3] < Z[4 * N0 + PP - 3] then
    begin
      IPN4 := 4 * (I0 + N0);
      J4 := 4 * I0;
      while J4 <= 2 * (I0 + N0 - 1) do
      begin
        TEMP := Z[J4 - 3];
        Z[J4 - 3] := Z[IPN4 - J4 - 3];
        Z[IPN4 - J4 - 3] := TEMP;
        TEMP := Z[J4 - 2];
        Z[J4 - 2] := Z[IPN4 - J4 - 2];
        Z[IPN4 - J4 - 2] := TEMP;
        TEMP := Z[J4 - 1];
        Z[J4 - 1] := Z[IPN4 - J4 - 5];
        Z[IPN4 - J4 - 5] := TEMP;
        TEMP := Z[J4];
        Z[J4] := Z[IPN4 - J4 - 4];
        Z[IPN4 - J4 - 4] := TEMP;
        J4 := J4 + 4;
      end;
      if N0 - I0 <= 4 then
      begin
        Z[4 * N0 + PP - 1] := Z[4 * I0 + PP - 1];
        Z[4 * N0 - PP] := Z[4 * I0 - PP];
      end;
      DMIN2 := Min(DMIN2, Z[4 * N0 + PP - 1]);
      Z[4 * N0 + PP - 1] := Min(Min(Z[4 * N0 + PP - 1], Z[4 * I0 + PP - 1]),
        Z[4 * I0 + PP + 3]);
      Z[4 * N0 - PP] := Min(Min(Z[4 * N0 - PP], Z[4 * I0 - PP]),
        Z[4 * I0 - PP + 4]);
      QMAX := Max(Max(QMAX, Z[4 * I0 + PP - 3]), Z[4 * I0 + PP + 1]);
      DMIN := -FZERO;
    end;
  { Choose a shift. }
  DLASQ4(I0, N0, Z, PP, N0IN, DMIN, DMIN1, DMIN2, DN, DN1, DN2, TAU, TTYPE,
    G);
  { Call dqds until DMIN > 0. }
  repeat
    DLASQ5(I0, N0, Z, PP, TAU, SIGMA, DMIN, DMIN1, DMIN2, DN, DN1, DN2, EPS);
    NDIV := NDIV + (N0 - I0 + 2);
    ITER := ITER + 1;
    { Check status. }
    if (DMIN >= 0) and (DMIN1 >= 0) then
      { Success. }
      Break
    else if (DMIN < 0) and (DMIN1 > 0) and
      (Z[4 * (N0 - 1) - PP] < TOL * (SIGMA + DN1)) and
      (System.Abs(DN) < TOL * SIGMA) then
    begin
      { Convergence hidden by negative DN. }
      Z[4 * (N0 - 1) - PP + 2] := 0;
      DMIN := 0;
      Break;
    end else if DMIN < 0 then
    begin
      { TAU too big. Select new TAU and try again. }
      NFAIL := NFAIL + 1;
      if TTYPE < -22 then
        { Failed twice. Play it safe. }
        TAU := 0
      else if DMIN1 > 0 then
      begin
        { Late failure. Gives excellent shift. }
        TAU := (TAU + DMIN) * (ONE - TWO * EPS);
        TTYPE := TTYPE - 11;
      end else
      begin
        { Early failure. Divide by 4. }
        TAU := QURTR * TAU;
        TTYPE := TTYPE - 12;
      end;
      Continue;
    end else if IsNan(DMIN) then
    begin
      { NaN. }
      if TAU = 0 then
      begin
        STEP := 80;
        Break;
      end else
      begin
        TAU := 0;
        Continue;
      end;
    end else
    begin
      { Possible underflow. Play it safe. }
      STEP := 80;
      Break;
    end;
  until False;
  if STEP = 80 then
  begin
    { Risk of underflow. }
    DLASQ6(I0, N0, Z, PP, DMIN, DMIN1, DMIN2, DN, DN1, DN2);
    NDIV := NDIV + (N0 - I0 + 2);
    ITER := ITER + 1;
    TAU := 0;
  end;
  { Label 90. }
  if TAU < SIGMA then
  begin
    DESIG := DESIG + TAU;
    T := SIGMA + DESIG;
    DESIG := DESIG - (T - SIGMA);
  end else
  begin
    T := SIGMA + TAU;
    DESIG := SIGMA - (T - TAU) + DESIG;
  end;
  SIGMA := T;
end;

{ DLASQ2: all the eigenvalues of the symmetric positive definite
  tridiagonal matrix associated with the qd array Z (Z[1..4N], from 1),
  in decreasing order in Z[1..N], by the dqds algorithm. INFO = 2 when
  the algorithm did not converge (then Z holds the unconverged
  bidiagonal as in LAPACK), 1 on an internal error, 3 on a failure of
  the outer loop. }
procedure DLASQ2(N: longint; var Z: array of TReal; out INFO: longint);
const
  CBIAS: TReal = 1.50;
  HALF: TReal = 0.5;
  ONE: TReal = 1;
  TWO: TReal = 2;
  FOUR: TReal = 4;
  HUNDRD: TReal = 100;
var
  IEEE: boolean;
  I0, I1, I4, IPN4, ITER, IWHILA, IWHILB, K, KMIN, N0, N1, NBIG, NDIV,
    NFAIL, PP, SPLT, TTYPE: longint;
  D, DEE, DEEMIN, DESIG, DMIN, DMIN1, DMIN2, DN, DN1, DN2, E, EMAX, EMIN,
    EPS, G, OLDEMN, QMAX, QMIN, S, SAFMIN, SIGMA, T, TAU, TEMP, TOL, TOL2,
    TRACE, ZMAX, TEMPE, TEMPQ: TReal;
  DONE, SKIP: boolean;
begin
  { Test the input arguments. (in case DLASQ2 is not called by DLASQ1) }
  INFO := 0;
  EPS := LapackPrecision;
  SAFMIN := LapackSafeMinimum;
  TOL := EPS * HUNDRD;
  TOL2 := Sqr(TOL);
  if N < 0 then
  begin
    INFO := -1;
    Exit;
  end else if N = 0 then
    Exit
  else if N = 1 then
  begin
    { 1-by-1 case. }
    if Z[1] < 0 then INFO := -201;
    Exit;
  end else if N = 2 then
  begin
    { 2-by-2 case. }
    if Z[1] < 0 then
    begin
      INFO := -201;
      Exit;
    end else if Z[2] < 0 then
    begin
      INFO := -202;
      Exit;
    end else if Z[3] < 0 then
    begin
      INFO := -203;
      Exit;
    end else if Z[3] > Z[1] then
    begin
      D := Z[3];
      Z[3] := Z[1];
      Z[1] := D;
    end;
    Z[5] := Z[1] + Z[2] + Z[3];
    if Z[2] > Z[3] * TOL2 then
    begin
      T := HALF * ((Z[1] - Z[3]) + Z[2]);
      S := Z[3] * (Z[2] / T);
      if S <= T then
        S := Z[3] * (Z[2] / (T * (ONE + Sqrt(ONE + S / T))))
      else
        S := Z[3] * (Z[2] / (T + Sqrt(T) * Sqrt(T + S)));
      T := Z[1] + (S + Z[2]);
      Z[3] := Z[3] * (Z[1] / T);
      Z[1] := T;
    end;
    Z[2] := Z[3];
    Z[6] := Z[2] + Z[1];
    Exit;
  end;
  { Check for negative data and compute sums of q's and e's. }
  Z[2 * N] := 0;
  EMIN := Z[2];
  QMAX := 0;
  ZMAX := 0;
  D := 0;
  E := 0;
  K := 1;
  while K <= 2 * (N - 1) do
  begin
    if Z[K] < 0 then
    begin
      INFO := -(200 + K);
      Exit;
    end else if Z[K + 1] < 0 then
    begin
      INFO := -(200 + K + 1);
      Exit;
    end;
    D := D + Z[K];
    E := E + Z[K + 1];
    QMAX := Max(QMAX, Z[K]);
    EMIN := Min(EMIN, Z[K + 1]);
    ZMAX := Max(Max(QMAX, ZMAX), Z[K + 1]);
    K := K + 2;
  end;
  if Z[2 * N - 1] < 0 then
  begin
    INFO := -(200 + 2 * N - 1);
    Exit;
  end;
  D := D + Z[2 * N - 1];
  QMAX := Max(QMAX, Z[2 * N - 1]);
  ZMAX := Max(QMAX, ZMAX);
  { Check for diagonality. }
  if E = 0 then
  begin
    for K := 2 to N do Z[K] := Z[2 * K - 1];
    DLASRT('D', N, Z, 0);
    Z[2 * N - 1] := D;
    Exit;
  end;
  TRACE := D + E;
  { Check for zero data. }
  if TRACE = 0 then
  begin
    Z[2 * N - 1] := 0;
    Exit;
  end;
  { Check whether the machine is IEEE conformable. }
  IEEE := True;
  { Rearrange data for locality: Z=(q1,qq1,e1,ee1,q2,qq2,e2,ee2,...). }
  K := 2 * N;
  while K >= 2 do
  begin
    Z[2 * K] := 0;
    Z[2 * K - 1] := Z[K];
    Z[2 * K - 2] := 0;
    Z[2 * K - 3] := Z[K - 1];
    K := K - 2;
  end;
  I0 := 1;
  N0 := N;
  { Reverse the qd-array, if warranted. }
  if CBIAS * Z[4 * I0 - 3] < Z[4 * N0 - 3] then
  begin
    IPN4 := 4 * (I0 + N0);
    I4 := 4 * I0;
    while I4 <= 2 * (I0 + N0 - 1) do
    begin
      TEMP := Z[I4 - 3];
      Z[I4 - 3] := Z[IPN4 - I4 - 3];
      Z[IPN4 - I4 - 3] := TEMP;
      TEMP := Z[I4 - 1];
      Z[I4 - 1] := Z[IPN4 - I4 - 5];
      Z[IPN4 - I4 - 5] := TEMP;
      I4 := I4 + 4;
    end;
  end;
  { Initial split checking via dqd and Li's test. }
  PP := 0;
  for K := 1 to 2 do
  begin
    D := Z[4 * N0 + PP - 3];
    I4 := 4 * (N0 - 1) + PP;
    while I4 >= 4 * I0 + PP do
    begin
      if Z[I4 - 1] <= TOL2 * D then
      begin
        Z[I4 - 1] := -FZERO;
        D := Z[I4 - 3];
      end else
        D := Z[I4 - 3] * (D / (D + Z[I4 - 1]));
      I4 := I4 - 4;
    end;
    { dqd maps Z to ZZ plus Li's test. }
    EMIN := Z[4 * I0 + PP + 1];
    D := Z[4 * I0 + PP - 3];
    I4 := 4 * I0 + PP;
    while I4 <= 4 * (N0 - 1) + PP do
    begin
      Z[I4 - 2 * PP - 2] := D + Z[I4 - 1];
      if Z[I4 - 1] <= TOL2 * D then
      begin
        Z[I4 - 1] := -FZERO;
        Z[I4 - 2 * PP - 2] := D;
        Z[I4 - 2 * PP] := 0;
        D := Z[I4 + 1];
      end else if (SAFMIN * Z[I4 + 1] < Z[I4 - 2 * PP - 2]) and
        (SAFMIN * Z[I4 - 2 * PP - 2] < Z[I4 + 1]) then
      begin
        TEMP := Z[I4 + 1] / Z[I4 - 2 * PP - 2];
        Z[I4 - 2 * PP] := Z[I4 - 1] * TEMP;
        D := D * TEMP;
      end else
      begin
        Z[I4 - 2 * PP] := Z[I4 + 1] * (Z[I4 - 1] / Z[I4 - 2 * PP - 2]);
        D := Z[I4 + 1] * (D / Z[I4 - 2 * PP - 2]);
      end;
      EMIN := Min(EMIN, Z[I4 - 2 * PP]);
      I4 := I4 + 4;
    end;
    Z[4 * N0 - PP - 2] := D;
    { Now find qmax. }
    QMAX := Z[4 * I0 - PP - 2];
    I4 := 4 * I0 - PP + 2;
    while I4 <= 4 * N0 - PP - 2 do
    begin
      QMAX := Max(QMAX, Z[I4]);
      I4 := I4 + 4;
    end;
    { Prepare for the next iteration on K. }
    PP := 1 - PP;
  end;
  { Initialise variables to pass to DLASQ3. }
  TTYPE := 0;
  DMIN1 := 0;
  DMIN2 := 0;
  DN := 0;
  DN1 := 0;
  DN2 := 0;
  G := 0;
  TAU := 0;
  ITER := 2;
  NFAIL := 0;
  NDIV := 2 * (N0 - I0);
  DMIN := 0;
  SIGMA := 0;
  DESIG := 0;
  DONE := False;
  for IWHILA := 1 to N + 1 do
  begin
    if N0 < 1 then
    begin
      DONE := True;
      Break;
    end;
    { While array unfinished do. E(N0) holds the value of SIGMA when
      submatrix in I0:N0 splits from the rest of the array, but is
      negated. }
    DESIG := 0;
    if N0 = N then
      SIGMA := 0
    else
      SIGMA := -Z[4 * N0 - 1];
    if SIGMA < 0 then
    begin
      INFO := 1;
      Exit;
    end;
    { Find last unreduced submatrix's top index I0, find QMAX and EMIN.
      Find Gershgorin-type bound if Q's much greater than E's. }
    EMAX := 0;
    if N0 > I0 then
      EMIN := System.Abs(Z[4 * N0 - 5])
    else
      EMIN := 0;
    QMIN := Z[4 * N0 - 3];
    QMAX := QMIN;
    I4 := 4 * N0;
    SKIP := False;
    while I4 >= 8 do
    begin
      if Z[I4 - 5] <= 0 then
      begin
        SKIP := True;
        Break;
      end;
      if QMIN >= FOUR * EMAX then
      begin
        QMIN := Min(QMIN, Z[I4 - 3]);
        EMAX := Max(EMAX, Z[I4 - 5]);
      end;
      QMAX := Max(QMAX, Z[I4 - 7] + Z[I4 - 5]);
      EMIN := Min(EMIN, Z[I4 - 5]);
      I4 := I4 - 4;
    end;
    if not SKIP then I4 := 4;
    I0 := I4 div 4;
    PP := 0;
    if N0 - I0 > 1 then
    begin
      DEE := Z[4 * I0 - 3];
      DEEMIN := DEE;
      KMIN := I0;
      I4 := 4 * I0 + 1;
      while I4 <= 4 * N0 - 3 do
      begin
        DEE := Z[I4] * (DEE / (DEE + Z[I4 - 2]));
        if DEE <= DEEMIN then
        begin
          DEEMIN := DEE;
          KMIN := (I4 + 3) div 4;
        end;
        I4 := I4 + 4;
      end;
      if ((KMIN - I0) * 2 < N0 - KMIN) and (DEEMIN <= HALF * Z[4 * N0 - 3]) then
      begin
        IPN4 := 4 * (I0 + N0);
        PP := 2;
        I4 := 4 * I0;
        while I4 <= 2 * (I0 + N0 - 1) do
        begin
          TEMP := Z[I4 - 3];
          Z[I4 - 3] := Z[IPN4 - I4 - 3];
          Z[IPN4 - I4 - 3] := TEMP;
          TEMP := Z[I4 - 2];
          Z[I4 - 2] := Z[IPN4 - I4 - 2];
          Z[IPN4 - I4 - 2] := TEMP;
          TEMP := Z[I4 - 1];
          Z[I4 - 1] := Z[IPN4 - I4 - 5];
          Z[IPN4 - I4 - 5] := TEMP;
          TEMP := Z[I4];
          Z[I4] := Z[IPN4 - I4 - 4];
          Z[IPN4 - I4 - 4] := TEMP;
          I4 := I4 + 4;
        end;
      end;
    end;
    { Put -(initial shift) into DMIN. }
    DMIN := -Max(FZERO, QMIN - TWO * Sqrt(QMIN) * Sqrt(EMAX));
    { Now I0:N0 is unreduced. PP = 0 for ping, PP = 1 for pong. PP = 2
      indicates that flipping was applied to the Z array and that the
      tests for deflation upon entry in DLASQ3 should not be performed. }
    NBIG := 100 * (N0 - I0 + 1);
    SKIP := False;
    for IWHILB := 1 to NBIG do
    begin
      if I0 > N0 then
      begin
        SKIP := True;
        Break;
      end;
      { While submatrix unfinished take a good dqds step. }
      DLASQ3(I0, N0, Z, PP, DMIN, SIGMA, DESIG, QMAX, NFAIL, ITER, NDIV,
        IEEE, TTYPE, DMIN1, DMIN2, DN, DN1, DN2, G, TAU);
      PP := 1 - PP;
      { When EMIN is very small check for splits. }
      if (PP = 0) and (N0 - I0 >= 3) then
        if (Z[4 * N0] <= TOL2 * QMAX) or (Z[4 * N0 - 1] <= TOL2 * SIGMA) then
        begin
          SPLT := I0 - 1;
          QMAX := Z[4 * I0 - 3];
          EMIN := Z[4 * I0 - 1];
          OLDEMN := Z[4 * I0];
          I4 := 4 * I0;
          while I4 <= 4 * (N0 - 3) do
          begin
            if (Z[I4] <= TOL2 * Z[I4 - 3]) or (Z[I4 - 1] <= TOL2 * SIGMA) then
            begin
              Z[I4 - 1] := -SIGMA;
              SPLT := I4 div 4;
              QMAX := 0;
              EMIN := Z[I4 + 3];
              OLDEMN := Z[I4 + 4];
            end else
            begin
              QMAX := Max(QMAX, Z[I4 + 1]);
              EMIN := Min(EMIN, Z[I4 - 1]);
              OLDEMN := Min(OLDEMN, Z[I4]);
            end;
            I4 := I4 + 4;
          end;
          Z[4 * N0 - 1] := EMIN;
          Z[4 * N0] := OLDEMN;
          I0 := SPLT + 1;
        end;
    end;
    if not SKIP then
    begin
      INFO := 2;
      { Maximum number of iterations exceeded, restore the shift SIGMA
        and place the new d's and e's in a qd array. This might need to
        be done for several blocks. }
      I1 := I0;
      N1 := N0;
      repeat
        TEMPQ := Z[4 * I0 - 3];
        Z[4 * I0 - 3] := Z[4 * I0 - 3] + SIGMA;
        for K := I0 + 1 to N0 do
        begin
          TEMPE := Z[4 * K - 5];
          Z[4 * K - 5] := Z[4 * K - 5] * (TEMPQ / Z[4 * K - 7]);
          TEMPQ := Z[4 * K - 3];
          Z[4 * K - 3] := Z[4 * K - 3] + SIGMA + TEMPE - Z[4 * K - 5];
        end;
        { Prepare to do this on the previous block if there is one. }
        if I1 > 1 then
        begin
          N1 := I1 - 1;
          while (I1 >= 2) and (Z[4 * I1 - 5] >= 0) do I1 := I1 - 1;
          SIGMA := -Z[4 * N1 - 1];
        end else
          Break;
      until False;
      for K := 1 to N do
      begin
        Z[2 * K - 1] := Z[4 * K - 3];
        { Only the block 1..N0 is unfinished. The rest of the e's must be
          essentially zero, although sometimes other data has been stored
          in them. }
        if K < N0 then
          Z[2 * K] := Z[4 * K - 1]
        else
          Z[2 * K] := 0;
      end;
      Exit;
    end;
  end;
  if not DONE then
  begin
    INFO := 3;
    Exit;
  end;
  { Move q's to the front. }
  for K := 2 to N do Z[K] := Z[4 * K - 3];
  { Sort and compute sum of eigenvalues. }
  DLASRT('D', N, Z, 0);
  E := 0;
  for K := N downto 1 do E := E + Z[K];
  { Store trace, sum(eigenvalues) and information on performance. }
  Z[2 * N + 1] := TRACE;
  Z[2 * N + 2] := E;
  Z[2 * N + 3] := ITER;
  Z[2 * N + 4] := TReal(NDIV) / TReal(Sqr(N));
  Z[2 * N + 5] := HUNDRD * NFAIL / TReal(ITER);
end;

{ DLASQ1: the singular values of the N x N bidiagonal matrix with
  diagonal D and off-diagonal E, in decreasing order in D, by the dqds
  algorithm (DLASQ2). INFO = 2: not converged, D and E hold the
  unconverged bidiagonal. }
procedure DLASQ1(N: longint; var D, E: array of TReal; out INFO: longint);
var
  I: longint;
  EPS, SCALE, SAFMIN, SIGMN, SIGMX: TReal;
  WORK: array of TReal;
begin
  INFO := 0;
  if N <= 0 then Exit;
  if N = 1 then
  begin
    D[0] := System.Abs(D[0]);
    Exit;
  end else if N = 2 then
  begin
    DLAS2(D[0], E[0], D[1], SIGMN, SIGMX);
    D[0] := SIGMX;
    D[1] := SIGMN;
    Exit;
  end;
  { Estimate the largest singular value. }
  SIGMX := 0;
  for I := 0 to N - 2 do
  begin
    D[I] := System.Abs(D[I]);
    SIGMX := Max(SIGMX, System.Abs(E[I]));
  end;
  D[N - 1] := System.Abs(D[N - 1]);
  { Early return if SIGMX is zero (matrix is already diagonal). }
  if SIGMX = 0 then
  begin
    DLASRT('D', N, D, -1);
    Exit;
  end;
  for I := 0 to N - 1 do SIGMX := Max(SIGMX, D[I]);
  { Copy D and E into WORK (in the Z format) and scale (squaring the
    input data makes scaling by a power of the radix pointless). }
  EPS := LapackPrecision;
  SAFMIN := LapackSafeMinimum;
  SCALE := Sqrt(EPS / SAFMIN);
  WORK := nil;
  SetLength(WORK, 4 * N + 1);
  for I := 0 to N - 1 do WORK[1 + 2 * I] := D[I];
  for I := 0 to N - 2 do WORK[2 + 2 * I] := E[I];
  specialize LASCLT<TReal>('G', SIGMX, SCALE, 2 * N - 1, 1, WORK, 1, 1);
  { Compute the q's and e's. }
  for I := 1 to 2 * N - 1 do WORK[I] := Sqr(WORK[I]);
  WORK[2 * N] := 0;
  DLASQ2(N, WORK, INFO);
  if INFO = 0 then
  begin
    for I := 0 to N - 1 do D[I] := Sqrt(WORK[1 + I]);
    specialize LASCLT<TReal>('G', SCALE, SIGMX, N, 1, D, 0, 1);
  end else if INFO = 2 then
  begin
    for I := 0 to N - 1 do
    begin
      D[I] := Sqrt(WORK[2 * I + 1]);
      E[I] := Sqrt(WORK[2 * I + 2]);
    end;
    specialize LASCLT<TReal>('G', SCALE, SIGMX, N, 1, D, 0, 1);
    specialize LASCLT<TReal>('G', SCALE, SIGMX, N, 1, E, 0, 1);
  end;
end;

{ DBDSQR with NCVT = NRU = NCC = 0 (ZBDSQR is the same then): the
  singular values of the N x N bidiagonal matrix with diagonal D and
  upper (UPLO = 'U') or lower ('L') off-diagonal E, in decreasing order
  in D. DLASQ1 first; the implicit zero-shift QR is the fallback when
  dqds fails. E holds N entries (DLASQ1 writes E[N-1] on failure). INFO
  > 0: that many off-diagonal entries did not converge to zero. }
procedure DBDSQR(UPLO: char; N: longint; var D, E: array of TReal;
  out INFO: longint);
const
  ONE: TReal = 1;
  HNDRTH: TReal = 0.01;
  TEN: TReal = 10;
  HNDRD: TReal = 100;
  { EPS**(-1/8) with EPS = DLAMCH('Epsilon') = 2^-53, as libm pow
    computes it. }
  EPSM8: TReal = 98.70149282610821;
  MAXITR = 6;
var
  I, IDIR, ISUB, ITER, ITERDIVN, J, LL, LLL, M, MAXITDIVN, OLDLL,
    OLDM: longint;
  ABSE, ABSS, COSL, COSR, CS, EPS, F, G, H, MU, OLDCS, OLDSN, R, SHIFT,
    SIGMN, SIGMX, SINL, SINR, SLL, SMAX, SMIN, SMINOA, SN, THRESH, TOL,
    TOLMUL, UNFL: TReal;
  CONVERGED, SPLIT: boolean;
begin
  INFO := 0;
  if N = 0 then Exit;
  if N > 1 then
  begin
    { If no singular vectors desired, use qd algorithm. }
    DLASQ1(N, D, E, INFO);
    { If INFO equals 2, dqds didn't finish, try to finish. }
    if INFO <> 2 then Exit;
    INFO := 0;
    IDIR := 0;
    { Get machine constants. }
    EPS := LapackEpsilon;
    UNFL := LapackSafeMinimum;
    { If matrix lower bidiagonal, rotate to be upper bidiagonal by
      applying Givens rotations on the left. }
    if UPLO = 'L' then
      for I := 0 to N - 2 do
      begin
        DLARTG(D[I], E[I], CS, SN, R);
        D[I] := R;
        E[I] := SN * D[I + 1];
        D[I + 1] := CS * D[I + 1];
      end;
    { Compute singular values to relative accuracy TOL. }
    TOLMUL := Max(TEN, Min(HNDRD, EPSM8));
    TOL := TOLMUL * EPS;
    { Compute approximate maximum, minimum singular values. }
    SMAX := 0;
    for I := 0 to N - 1 do SMAX := Max(SMAX, System.Abs(D[I]));
    for I := 0 to N - 2 do SMAX := Max(SMAX, System.Abs(E[I]));
    SMIN := 0;
    { Relative accuracy desired (TOL >= 0). Compute lower bound on
      smallest singular value. }
    SMINOA := System.Abs(D[0]);
    if SMINOA <> 0 then
    begin
      MU := SMINOA;
      for I := 1 to N - 1 do
      begin
        MU := System.Abs(D[I]) * (MU / (MU + System.Abs(E[I - 1])));
        SMINOA := Min(SMINOA, MU);
        if SMINOA = 0 then Break;
      end;
    end;
    SMINOA := SMINOA / Sqrt(TReal(N));
    THRESH := Max(TOL * SMINOA, MAXITR * (N * (N * UNFL)));
    { Prepare for main iteration loop for the singular values (MAXIT is
      the maximum number of passes through the inner loop permitted
      before nonconvergence signalled.) }
    MAXITDIVN := MAXITR * N;
    ITERDIVN := 0;
    ITER := -1;
    OLDLL := -1;
    OLDM := -1;
    { M points to last element of unconverged part of matrix (from 1, as
      in LAPACK; D[M - 1] is D(M)). }
    M := N;
    CONVERGED := True;
    { Begin main iteration loop. }
    while M > 1 do
    begin
      { Check for convergence or exceeding iteration count. }
      if ITER >= N then
      begin
        ITER := ITER - N;
        ITERDIVN := ITERDIVN + 1;
        if ITERDIVN >= MAXITDIVN then
        begin
          CONVERGED := False;
          Break;
        end;
      end;
      { Find diagonal block of matrix to work on. }
      SMAX := System.Abs(D[M - 1]);
      SPLIT := False;
      LL := 0;
      for LLL := 1 to M - 1 do
      begin
        LL := M - LLL;
        ABSS := System.Abs(D[LL - 1]);
        ABSE := System.Abs(E[LL - 1]);
        if ABSE <= THRESH then
        begin
          SPLIT := True;
          Break;
        end;
        SMAX := Max(Max(SMAX, ABSS), ABSE);
      end;
      if SPLIT then
      begin
        E[LL - 1] := 0;
        { Matrix splits since E(LL) = 0. }
        if LL = M - 1 then
        begin
          { Convergence of bottom singular value, return to top of
            loop. }
          M := M - 1;
          Continue;
        end;
      end else
        LL := 0;
      LL := LL + 1;
      { E(LL) through E(M-1) are nonzero, E(LL-1) is zero. }
      if LL = M - 1 then
      begin
        { 2 by 2 block, handle separately. }
        DLASV2(D[M - 2], E[M - 2], D[M - 1], SIGMN, SIGMX, SINR, COSR, SINL,
          COSL);
        D[M - 2] := SIGMX;
        E[M - 2] := 0;
        D[M - 1] := SIGMN;
        M := M - 2;
        Continue;
      end;
      { If working on new submatrix, choose shift direction (from larger
        end diagonal element towards smaller). }
      if (LL > OLDM) or (M < OLDLL) then
      begin
        if System.Abs(D[LL - 1]) >= System.Abs(D[M - 1]) then
          { Chase bulge from top (big end) to bottom (small end). }
          IDIR := 1
        else
          { Chase bulge from bottom (big end) to top (small end). }
          IDIR := 2;
      end;
      { Apply convergence tests. }
      SPLIT := False;
      if IDIR = 1 then
      begin
        { Run convergence test in forward direction. First apply
          standard test to bottom of matrix. }
        if System.Abs(E[M - 2]) <= System.Abs(TOL) * System.Abs(D[M - 1]) then
        begin
          E[M - 2] := 0;
          Continue;
        end;
        { Apply convergence criterion forward. }
        MU := System.Abs(D[LL - 1]);
        SMIN := MU;
        for LLL := LL to M - 1 do
        begin
          if System.Abs(E[LLL - 1]) <= TOL * MU then
          begin
            E[LLL - 1] := 0;
            SPLIT := True;
            Break;
          end;
          MU := System.Abs(D[LLL]) * (MU / (MU + System.Abs(E[LLL - 1])));
          SMIN := Min(SMIN, MU);
        end;
      end else
      begin
        { Run convergence test in backward direction. First apply
          standard test to top of matrix. }
        if System.Abs(E[LL - 1]) <= System.Abs(TOL) * System.Abs(D[LL - 1]) then
        begin
          E[LL - 1] := 0;
          Continue;
        end;
        { Apply convergence criterion backward. }
        MU := System.Abs(D[M - 1]);
        SMIN := MU;
        for LLL := M - 1 downto LL do
        begin
          if System.Abs(E[LLL - 1]) <= TOL * MU then
          begin
            E[LLL - 1] := 0;
            SPLIT := True;
            Break;
          end;
          MU := System.Abs(D[LLL - 1]) * (MU / (MU + System.Abs(E[LLL - 1])));
          SMIN := Min(SMIN, MU);
        end;
      end;
      if SPLIT then Continue;
      OLDLL := LL;
      OLDM := M;
      { Compute shift. First, test if shifting would ruin relative
        accuracy, and if so set the shift to zero. }
      if N * TOL * (SMIN / SMAX) <= Max(EPS, HNDRTH * TOL) then
        { Use a zero shift to avoid loss of relative accuracy. }
        SHIFT := 0
      else
      begin
        { Compute the shift from 2-by-2 block at end of matrix. }
        if IDIR = 1 then
        begin
          SLL := System.Abs(D[LL - 1]);
          DLAS2(D[M - 2], E[M - 2], D[M - 1], SHIFT, R);
        end else
        begin
          SLL := System.Abs(D[M - 1]);
          DLAS2(D[LL - 1], E[LL - 1], D[LL], SHIFT, R);
        end;
        { Test if shift negligible, and if so set to zero. }
        if SLL > 0 then
          if Sqr(SHIFT / SLL) < EPS then SHIFT := 0;
      end;
      { Increment iteration count. }
      ITER := ITER + M - LL;
      { If SHIFT = 0, do simplified QR iteration. }
      if SHIFT = 0 then
      begin
        if IDIR = 1 then
        begin
          { Chase bulge from top to bottom. }
          CS := ONE;
          OLDCS := ONE;
          OLDSN := 0;
          for I := LL to M - 1 do
          begin
            DLARTG(D[I - 1] * CS, E[I - 1], CS, SN, R);
            if I > LL then E[I - 2] := OLDSN * R;
            DLARTG(OLDCS * R, D[I] * SN, OLDCS, OLDSN, D[I - 1]);
          end;
          H := D[M - 1] * CS;
          D[M - 1] := H * OLDCS;
          E[M - 2] := H * OLDSN;
          { Test convergence. }
          if System.Abs(E[M - 2]) <= THRESH then E[M - 2] := 0;
        end else
        begin
          { Chase bulge from bottom to top. }
          CS := ONE;
          OLDCS := ONE;
          OLDSN := 0;
          for I := M downto LL + 1 do
          begin
            DLARTG(D[I - 1] * CS, E[I - 2], CS, SN, R);
            if I < M then E[I - 1] := OLDSN * R;
            DLARTG(OLDCS * R, D[I - 2] * SN, OLDCS, OLDSN, D[I - 1]);
          end;
          H := D[LL - 1] * CS;
          D[LL - 1] := H * OLDCS;
          E[LL - 1] := H * OLDSN;
          { Test convergence. }
          if System.Abs(E[LL - 1]) <= THRESH then E[LL - 1] := 0;
        end;
      end else
      begin
        { Use nonzero shift. }
        if IDIR = 1 then
        begin
          { Chase bulge from top to bottom. }
          F := (System.Abs(D[LL - 1]) - SHIFT) *
            (SIGN(ONE, D[LL - 1]) + SHIFT / D[LL - 1]);
          G := E[LL - 1];
          for I := LL to M - 1 do
          begin
            DLARTG(F, G, COSR, SINR, R);
            if I > LL then E[I - 2] := R;
            F := COSR * D[I - 1] + SINR * E[I - 1];
            E[I - 1] := COSR * E[I - 1] - SINR * D[I - 1];
            G := SINR * D[I];
            D[I] := COSR * D[I];
            DLARTG(F, G, COSL, SINL, R);
            D[I - 1] := R;
            F := COSL * E[I - 1] + SINL * D[I];
            D[I] := COSL * D[I] - SINL * E[I - 1];
            if I < M - 1 then
            begin
              G := SINL * E[I];
              E[I] := COSL * E[I];
            end;
          end;
          E[M - 2] := F;
          { Test convergence. }
          if System.Abs(E[M - 2]) <= THRESH then E[M - 2] := 0;
        end else
        begin
          { Chase bulge from bottom to top. }
          F := (System.Abs(D[M - 1]) - SHIFT) *
            (SIGN(ONE, D[M - 1]) + SHIFT / D[M - 1]);
          G := E[M - 2];
          for I := M downto LL + 1 do
          begin
            DLARTG(F, G, COSR, SINR, R);
            if I < M then E[I - 1] := R;
            F := COSR * D[I - 1] + SINR * E[I - 2];
            E[I - 2] := COSR * E[I - 2] - SINR * D[I - 1];
            G := SINR * D[I - 2];
            D[I - 2] := COSR * D[I - 2];
            DLARTG(F, G, COSL, SINL, R);
            D[I - 1] := R;
            F := COSL * E[I - 2] + SINL * D[I - 2];
            D[I - 2] := COSL * D[I - 2] - SINL * E[I - 2];
            if I > LL + 1 then
            begin
              G := SINL * E[I - 3];
              E[I - 3] := COSL * E[I - 3];
            end;
          end;
          E[LL - 1] := F;
          { Test convergence. }
          if System.Abs(E[LL - 1]) <= THRESH then E[LL - 1] := 0;
        end;
      end;
      { QR iteration finished, go back and check convergence. }
    end;
    if not CONVERGED then
    begin
      { Maximum number of iterations exceeded, failure to converge. }
      for I := 0 to N - 2 do
        if E[I] <> 0 then INFO := INFO + 1;
      Exit;
    end;
  end;
  { All singular values converged, so make them positive. }
  for I := 0 to N - 1 do
  begin
    if D[I] = 0 then
      { Avoid -ZERO. }
      D[I] := 0;
    if D[I] < 0 then D[I] := -D[I];
  end;
  { Sort the singular values into decreasing order (insertion sort on
    singular values, but only one transposition per singular vector). }
  for I := 1 to N - 1 do
  begin
    { Scan for smallest D(I). }
    ISUB := 1;
    SMIN := D[0];
    for J := 2 to N + 1 - I do
      if D[J - 1] <= SMIN then
      begin
        ISUB := J;
        SMIN := D[J - 1];
      end;
    if ISUB <> N + 1 - I then
    begin
      { Swap singular values. }
      D[ISUB - 1] := D[N - I];
      D[N - I] := SMIN;
    end;
  end;
end;

{ xLABRD for M >= N: reduces the first NB rows and columns of the M x N
  matrix A to upper bidiagonal form by Q^H*A*P and returns the M x NB
  matrix X (row stride LDX) and the N x NB matrix Y (row stride LDY)
  needed to update the rest, A := A - V*Y^H - X*U^H. }
generic procedure LABRD<T>(M, N, NB: longint; var A: array of T;
  AO, LDA: longint; var D, E: array of TReal; DO_: longint;
  var TAUQ, TAUP: array of T; var X: array of T; XO, LDX: longint;
  var Y: array of T; YO, LDY: longint);
var
  I: longint;
  ALPHA, ONE, ZERO: T;
begin
  if (M <= 0) or (N <= 0) then Exit;
  ONE := 1;
  ZERO := 0;
  { Reduce to upper bidiagonal form. }
  for I := 0 to NB - 1 do
  begin
    { Update A(i:m-1, i). }
    LACGV(I, Y, YO + I * LDY, 1);
    specialize GEMV<T>('N', M - I, I, -ONE, A, AO + I * LDA, LDA, Y,
      YO + I * LDY, 1, ONE, A, AO + I * LDA + I, LDA);
    LACGV(I, Y, YO + I * LDY, 1);
    specialize GEMV<T>('N', M - I, I, -ONE, X, XO + I * LDX, LDX, A, AO + I,
      LDA, ONE, A, AO + I * LDA + I, LDA);
    { Generate reflection Q(i) to annihilate A(i+1:m-1, i). }
    ALPHA := A[AO + I * LDA + I];
    LARFG(M - I, ALPHA, A, AO + Min(I + 1, M - 1) * LDA + I, LDA, TAUQ[DO_ + I]);
    D[DO_ + I] := REALOF(ALPHA);
    { DLABRD stores beta in A(i, i); ZLABRD does not, but A(i, i) is
      overwritten below or restored from D by xGEBRD. }
    A[AO + I * LDA + I] := ALPHA;
    if I < N - 1 then
    begin
      A[AO + I * LDA + I] := ONE;
      { Compute Y(i+1:n-1, i). }
      specialize GEMV<T>('C', M - I, N - I - 1, ONE, A, AO + I * LDA + I + 1,
        LDA, A, AO + I * LDA + I, LDA, ZERO, Y, YO + (I + 1) * LDY + I, LDY);
      specialize GEMV<T>('C', M - I, I, ONE, A, AO + I * LDA, LDA, A,
        AO + I * LDA + I, LDA, ZERO, Y, YO + I, LDY);
      specialize GEMV<T>('N', N - I - 1, I, -ONE, Y, YO + (I + 1) * LDY, LDY,
        Y, YO + I, LDY, ONE, Y, YO + (I + 1) * LDY + I, LDY);
      specialize GEMV<T>('C', M - I, I, ONE, X, XO + I * LDX, LDX, A,
        AO + I * LDA + I, LDA, ZERO, Y, YO + I, LDY);
      specialize GEMV<T>('C', I, N - I - 1, -ONE, A, AO + I + 1, LDA, Y,
        YO + I, LDY, ONE, Y, YO + (I + 1) * LDY + I, LDY);
      specialize SCAL<T>(N - I - 1, TAUQ[DO_ + I], Y, YO + (I + 1) * LDY + I,
        LDY);
      { Update A(i, i+1:n-1). }
      LACGV(N - I - 1, A, AO + I * LDA + I + 1, 1);
      LACGV(I + 1, A, AO + I * LDA, 1);
      specialize GEMV<T>('N', N - I - 1, I + 1, -ONE, Y, YO + (I + 1) * LDY,
        LDY, A, AO + I * LDA, 1, ONE, A, AO + I * LDA + I + 1, 1);
      LACGV(I + 1, A, AO + I * LDA, 1);
      LACGV(I, X, XO + I * LDX, 1);
      specialize GEMV<T>('C', I, N - I - 1, -ONE, A, AO + I + 1, LDA, X,
        XO + I * LDX, 1, ONE, A, AO + I * LDA + I + 1, 1);
      LACGV(I, X, XO + I * LDX, 1);
      { Generate reflection P(i) to annihilate A(i, i+2:n-1). }
      ALPHA := A[AO + I * LDA + I + 1];
      LARFG(N - I - 1, ALPHA, A, AO + I * LDA + Min(I + 2, N - 1), 1,
        TAUP[DO_ + I]);
      E[DO_ + I] := REALOF(ALPHA);
      A[AO + I * LDA + I + 1] := ONE;
      { Compute X(i+1:m-1, i). }
      specialize GEMV<T>('N', M - I - 1, N - I - 1, ONE, A,
        AO + (I + 1) * LDA + I + 1, LDA, A, AO + I * LDA + I + 1, 1, ZERO, X,
        XO + (I + 1) * LDX + I, LDX);
      specialize GEMV<T>('C', N - I - 1, I + 1, ONE, Y, YO + (I + 1) * LDY,
        LDY, A, AO + I * LDA + I + 1, 1, ZERO, X, XO + I, LDX);
      specialize GEMV<T>('N', M - I - 1, I + 1, -ONE, A, AO + (I + 1) * LDA,
        LDA, X, XO + I, LDX, ONE, X, XO + (I + 1) * LDX + I, LDX);
      specialize GEMV<T>('N', I, N - I - 1, ONE, A, AO + I + 1, LDA, A,
        AO + I * LDA + I + 1, 1, ZERO, X, XO + I, LDX);
      specialize GEMV<T>('N', M - I - 1, I, -ONE, X, XO + (I + 1) * LDX, LDX,
        X, XO + I, LDX, ONE, X, XO + (I + 1) * LDX + I, LDX);
      specialize SCAL<T>(M - I - 1, TAUP[DO_ + I], X, XO + (I + 1) * LDX + I,
        LDX);
      LACGV(N - I - 1, A, AO + I * LDA + I + 1, 1);
    end;
  end;
end;

{ xGEBD2 for M >= N: unblocked reduction of the M x N matrix A to upper
  bidiagonal form Q^H*A*P = B; D, E (N, N-1 entries), TAUQ and TAUP from
  offset DO_. WORK holds at least 2*N entries (xLARF1F). }
generic procedure GEBD2<T>(M, N: longint; var A: array of T;
  AO, LDA: longint; var D, E: array of TReal; DO_: longint;
  var TAUQ, TAUP: array of T; var WORK: array of T);
var
  I: longint;
  ALPHA: T;
begin
  for I := 0 to N - 1 do
  begin
    { Generate elementary reflector H(i) to annihilate A(i+1:m-1, i). }
    ALPHA := A[AO + I * LDA + I];
    LARFG(M - I, ALPHA, A, AO + Min(I + 1, M - 1) * LDA + I, LDA,
      TAUQ[DO_ + I]);
    D[DO_ + I] := REALOF(ALPHA);
    { Apply H(i)^H to A(i:m-1, i+1:n-1) from the left. }
    if I < N - 1 then
      specialize LARF1F<T>(True, M - I, N - I - 1, A, AO + I * LDA + I, LDA,
        CONJ(TAUQ[DO_ + I]), A, AO + I * LDA + I + 1, LDA, WORK);
    A[AO + I * LDA + I] := D[DO_ + I];
    if I < N - 1 then
    begin
      { Generate elementary reflector G(i) to annihilate
        A(i, i+2:n-1). }
      LACGV(N - I - 1, A, AO + I * LDA + I + 1, 1);
      ALPHA := A[AO + I * LDA + I + 1];
      LARFG(N - I - 1, ALPHA, A, AO + I * LDA + Min(I + 2, N - 1), 1,
        TAUP[DO_ + I]);
      E[DO_ + I] := REALOF(ALPHA);
      { Apply G(i) to A(i+1:m-1, i+1:n-1) from the right. }
      specialize LARF1F<T>(False, M - I - 1, N - I - 1, A,
        AO + I * LDA + I + 1, 1, TAUP[DO_ + I], A,
        AO + (I + 1) * LDA + I + 1, LDA, WORK);
      LACGV(N - I - 1, A, AO + I * LDA + I + 1, 1);
      A[AO + I * LDA + I + 1] := E[DO_ + I];
    end else
      TAUP[DO_ + I] := 0;
  end;
end;

{ xGEBRD for M >= N: blocked reduction to upper bidiagonal form, with
  the block size (ILAENV 1, 32) and crossover (ILAENV 3, 128) of LAPACK
  and the optimal workspace (M+N)*NB. }
generic procedure GEBRD<T>(M, N: longint; var A: array of T;
  AO, LDA: longint; var D, E: array of TReal; var TAUQ, TAUP: array of T);
var
  I, J, NB, NX, LDWRKX, LDWRKY: longint;
  ONE: T;
  X, Y, WORK: array of T;
begin
  if N = 0 then Exit;
  ONE := 1;
  NB := Max(1, ILAENVNB(32));
  LDWRKX := NB;
  LDWRKY := NB;
  X := nil;
  Y := nil;
  if (NB > 1) and (NB < N) then
  begin
    { Set the crossover point NX. }
    NX := Max(NB, ILAENVNX(128));
    { The workspace is the optimal one, (M+N)*NB. }
  end else
    NX := N;
  if NX < N then
  begin
    SetLength(X, M * LDWRKX);
    SetLength(Y, N * LDWRKY);
  end;
  I := 0;
  while I < N - NX do
  begin
    { Reduce rows and columns i:i+nb-1 to bidiagonal form and return the
      matrices X and Y which are needed to update the unreduced part of
      the matrix. }
    specialize LABRD<T>(M - I, N - I, NB, A, AO + I * LDA + I, LDA, D, E, I,
      TAUQ, TAUP, X, 0, LDWRKX, Y, 0, LDWRKY);
    { Update the trailing submatrix A(i+nb:m-1, i+nb:n-1), using an update
      of the form A := A - V*Y^H - X*U^H. }
    specialize GEMM<T>('N', 'C', M - I - NB, N - I - NB, NB, -ONE, A,
      AO + (I + NB) * LDA + I, LDA, Y, NB * LDWRKY, LDWRKY, ONE, A,
      AO + (I + NB) * LDA + I + NB, LDA);
    specialize GEMM<T>('N', 'N', M - I - NB, N - I - NB, NB, -ONE, X,
      NB * LDWRKX, LDWRKX, A, AO + I * LDA + I + NB, LDA, ONE, A,
      AO + (I + NB) * LDA + I + NB, LDA);
    { Copy diagonal and off-diagonal elements of B back into A. }
    for J := I to I + NB - 1 do
    begin
      A[AO + J * LDA + J] := D[J];
      A[AO + J * LDA + J + 1] := E[J];
    end;
    I := I + NB;
  end;
  { Use unblocked code to reduce the remainder of the matrix. }
  WORK := nil;
  SetLength(WORK, 2 * Max(M, N));
  specialize GEBD2<T>(M - I, N - I, A, AO + I * LDA + I, LDA, D, E, I, TAUQ,
    TAUP, WORK);
end;

{ xGESVD with JOBU = JOBVT = 'N' for an N x N matrix: the singular
  values in decreasing order in S. LAPACK selects path 10 (xGEBRD on A,
  then xBDSQR) for N >= 2; for N = 1 it selects path 1, whose QR step
  leaves the 1 x 1 matrix as path 10 finds it. A is destroyed. INFO > 0:
  xBDSQR did not converge. }
generic procedure GESVDVALUES<T>(N: longint; var A: array of T;
  AO, LDA: longint; var S: array of TReal; out INFO: longint);
var
  ANRM, BIGNUM, EPS, SMLNUM: TReal;
  ISCL: boolean;
  E: array of TReal;
  TAUQ, TAUP: array of T;
begin
  INFO := 0;
  if N = 0 then Exit;
  { Get machine constants. }
  EPS := LapackPrecision;
  SMLNUM := Sqrt(LapackSafeMinimum) / EPS;
  BIGNUM := 1 / SMLNUM;
  { Scale A if max element outside range [SMLNUM, BIGNUM]. }
  ANRM := specialize LANGE<T>('M', N, N, A, AO, LDA);
  ISCL := False;
  if (ANRM > 0) and (ANRM < SMLNUM) then
  begin
    ISCL := True;
    specialize LASCLT<T>('G', ANRM, SMLNUM, N, N, A, AO, LDA);
  end else if ANRM > BIGNUM then
  begin
    ISCL := True;
    specialize LASCLT<T>('G', ANRM, BIGNUM, N, N, A, AO, LDA);
  end;
  { Bidiagonalize A. }
  E := nil;
  TAUQ := nil;
  TAUP := nil;
  SetLength(E, N);
  SetLength(TAUQ, N);
  SetLength(TAUP, N);
  specialize GEBRD<T>(N, N, A, AO, LDA, S, E, TAUQ, TAUP);
  { Perform bidiagonal QR iteration, computing singular values only. }
  DBDSQR('U', N, S, E, INFO);
  { Undo scaling if necessary. }
  if ISCL then
  begin
    if ANRM > BIGNUM then
      specialize LASCLT<TReal>('G', BIGNUM, ANRM, N, 1, S, 0, 1);
    if ANRM < SMLNUM then
      specialize LASCLT<TReal>('G', SMLNUM, ANRM, N, 1, S, 0, 1);
  end;
end;

procedure DGEBRD(M, N: longint; var A: array of TReal; AO, LDA: longint;
  var D, E: array of TReal; var TAUQ, TAUP: array of TReal);
begin
  specialize GEBRD<TReal>(M, N, A, AO, LDA, D, E, TAUQ, TAUP);
end;

procedure ZGEBRD(M, N: longint; var A: array of TComplex; AO, LDA: longint;
  var D, E: array of TReal; var TAUQ, TAUP: array of TComplex);
begin
  specialize GEBRD<TComplex>(M, N, A, AO, LDA, D, E, TAUQ, TAUP);
end;

procedure DGESVD(N: longint; var A: array of TReal; AO, LDA: longint;
  var S: array of TReal; out INFO: longint);
begin
  specialize GESVDVALUES<TReal>(N, A, AO, LDA, S, INFO);
end;

procedure ZGESVD(N: longint; var A: array of TComplex; AO, LDA: longint;
  var S: array of TReal; out INFO: longint);
begin
  specialize GESVDVALUES<TComplex>(N, A, AO, LDA, S, INFO);
end;

procedure XGESVD(N: longint; var A: array of TReal; var S: array of TReal;
  out INFO: longint);
begin
  DGESVD(N, A, 0, N, S, INFO);
end;

procedure XGESVD(N: longint; var A: array of TComplex; var S: array of TReal;
  out INFO: longint);
begin
  ZGESVD(N, A, 0, N, S, INFO);
end;

{ ---------------------------------------------------------------------
  General eigenproblem drivers (LAPACK 3.12.1): xGEEV with the blocked
  xGEHRD (xLAHR2), xORGHR (xORGQR), xTREVC3 (DLALN2, ZLATRS) and the
  blocked xORMQR used by xLAQR3. The work space of xGEEV is the optimal
  one returned by its workspace query; xGEHRD and xTREVC3 derive their
  block sizes from it as in LAPACK.
  --------------------------------------------------------------------- }

const
  { NBMAX, LDT and TSIZE of xGEHRD and xORMQR. }
  LapackNBMAX = 64;
  LapackTSIZE = (LapackNBMAX + 1) * LapackNBMAX;

{ xORMQR, xUNMQR with SIDE = 'R', TRANS = 'N': C := C*Q for the M x N
  matrix C and Q = H(0)*...*H(K-1) from xGEQRF (in A, TAU); blocked with
  block size 32 when K > 32 and LWORK (< 0: optimal) allows it, xORM2R
  otherwise. }
generic procedure ORMQRRN<T>(M, N, K: longint; const A: array of T;
  AO, LDA: longint; const TAU: array of T; var C: array of T;
  CO, LDC: longint; LWORK: longint);
var
  I, IB, NB, NBMIN, NQ, NW, LWKOPT, LDWORK: longint;
  TT, WORK: array of T;
begin
  NQ := N;
  NW := Max(1, M);
  NB := Min(LapackNBMAX, ILAENVNB(32));
  LWKOPT := NW * NB + LapackTSIZE;
  if (M = 0) or (N = 0) or (K = 0) then Exit;
  if LWORK < 0 then LWORK := LWKOPT;
  NBMIN := 2;
  LDWORK := NW;
  if (NB > 1) and (NB < K) and (LWORK < LWKOPT) then
    NB := (LWORK - LapackTSIZE) div LDWORK;
  if (NB < NBMIN) or (NB >= K) then
    { Use unblocked code. }
    specialize ORM2R<T>(M, N, K, A, AO, LDA, TAU, C, CO, LDC)
  else
  begin
    { Use blocked code; with SIDE = 'R' and TRANS = 'N' the blocks go
      forward. }
    TT := nil;
    WORK := nil;
    SetLength(TT, NB * NB);
    SetLength(WORK, M * NB);
    I := 0;
    while I < K do
    begin
      IB := Min(NB, K - I);
      { Form the triangular factor of the block reflector
        H = H(i) H(i+1) . . . H(i+ib-1). }
      specialize LARFT<T>('F', NQ - I, IB, A, AO + I * LDA + I, LDA, TAU, I,
        TT, 0, NB);
      { H is applied to C(0:m-1, i:n-1). }
      specialize LARFB<T>('R', 'N', 'F', M, N - I, IB, A, AO + I * LDA + I,
        LDA, TT, 0, NB, C, CO + I, LDC, WORK, NB);
      I := I + NB;
    end;
  end;
end;

{ The xORMQR of xLAQR3 (xORMHR with SIDE = 'R', TRANS = 'N'), declared
  forward before it. }
procedure ORMQRD(M, N, K: longint; const A: array of TReal; AO, LDA: longint;
  const TAU: array of TReal; var C: array of TReal; CO, LDC, LWORK: longint);
begin
  specialize ORMQRRN<TReal>(M, N, K, A, AO, LDA, TAU, C, CO, LDC, LWORK);
end;

procedure ORMQRZ(M, N, K: longint; const A: array of TComplex;
  AO, LDA: longint; const TAU: array of TComplex; var C: array of TComplex;
  CO, LDC, LWORK: longint);
begin
  specialize ORMQRRN<TComplex>(M, N, K, A, AO, LDA, TAU, C, CO, LDC, LWORK);
end;

{ xLAHR2: reduces the first NB columns of the N x (N-K+1) matrix A
  (columns from the K-th, rows counted from 1 here as in LAPACK) so that
  the elements below the K-th subdiagonal are zero, and returns the
  matrices T (NB x NB) and Y (N x NB) of the block reflector. }
generic procedure LAHR2<T>(N, K, NB: longint; var A: array of T;
  AO, LDA: longint; var TAU: array of T; TO_: longint; var TT: array of T;
  TTO, LDT: longint; var Y: array of T; YO, LDY: longint);
var
  I, R, C: longint;
  EI, ALPHA, ONE: T;
begin
  { Quick return if possible. }
  if N <= 1 then Exit;
  ONE := 1;
  EI := 0;
  for I := 1 to NB do
  begin
    if I > 1 then
    begin
      { Update A(K+1:N, I): A(K+1:N, I) := A(K+1:N, I) - Y(K+1:N, 1:I-1) *
        A(K+I-1, 1:I-1)^H. }
      LACGV(I - 1, A, AO + (K + I - 2) * LDA, 1);
      specialize GEMV<T>('N', N - K, I - 1, -ONE, Y, YO + K * LDY, LDY, A,
        AO + (K + I - 2) * LDA, 1, ONE, A, AO + K * LDA + I - 1, LDA);
      LACGV(I - 1, A, AO + (K + I - 2) * LDA, 1);
      { Apply I - V * T^H * V^H to this column (call it b) from the left,
        using the last column of T as workspace. }
      for R := 0 to I - 2 do
        TT[TTO + R * LDT + NB - 1] := A[AO + (K + R) * LDA + I - 1];
      { w := V1^H * b1 }
      specialize TRMV<T>('L', 'C', 'U', I - 1, A, AO + K * LDA, LDA, TT,
        TTO + NB - 1, LDT);
      { w := w + V2^H * b2 }
      specialize GEMV<T>('C', N - K - I + 1, I - 1, ONE, A,
        AO + (K + I - 1) * LDA, LDA, A, AO + (K + I - 1) * LDA + I - 1, LDA,
        ONE, TT, TTO + NB - 1, LDT);
      { w := T^H * w }
      specialize TRMV<T>('U', 'C', 'N', I - 1, TT, TTO, LDT, TT, TTO + NB - 1,
        LDT);
      { b2 := b2 - V2*w }
      specialize GEMV<T>('N', N - K - I + 1, I - 1, -ONE, A,
        AO + (K + I - 1) * LDA, LDA, TT, TTO + NB - 1, LDT, ONE, A,
        AO + (K + I - 1) * LDA + I - 1, LDA);
      { b1 := b1 - V1*w }
      specialize TRMV<T>('L', 'N', 'U', I - 1, A, AO + K * LDA, LDA, TT,
        TTO + NB - 1, LDT);
      specialize AXPY<T>(I - 1, -ONE, TT, TTO + NB - 1, LDT, A,
        AO + K * LDA + I - 1, LDA);
      A[AO + (K + I - 2) * LDA + I - 2] := EI;
    end;
    { Generate the elementary reflector H(I) to annihilate
      A(K+I+1:N, I). }
    ALPHA := A[AO + (K + I - 1) * LDA + I - 1];
    LARFG(N - K - I + 1, ALPHA, A, AO + (Min(K + I + 1, N) - 1) * LDA + I - 1,
      LDA, TAU[TO_ + I - 1]);
    A[AO + (K + I - 1) * LDA + I - 1] := ALPHA;
    EI := A[AO + (K + I - 1) * LDA + I - 1];
    A[AO + (K + I - 1) * LDA + I - 1] := ONE;
    { Compute Y(K+1:N, I). }
    specialize GEMV<T>('N', N - K, N - K - I + 1, ONE, A, AO + K * LDA + I,
      LDA, A, AO + (K + I - 1) * LDA + I - 1, LDA, 0, Y, YO + K * LDY + I - 1,
      LDY);
    specialize GEMV<T>('C', N - K - I + 1, I - 1, ONE, A,
      AO + (K + I - 1) * LDA, LDA, A, AO + (K + I - 1) * LDA + I - 1, LDA, 0,
      TT, TTO + I - 1, LDT);
    specialize GEMV<T>('N', N - K, I - 1, -ONE, Y, YO + K * LDY, LDY, TT,
      TTO + I - 1, LDT, ONE, Y, YO + K * LDY + I - 1, LDY);
    specialize SCAL<T>(N - K, TAU[TO_ + I - 1], Y, YO + K * LDY + I - 1, LDY);
    { Compute T(1:I, I). }
    specialize SCAL<T>(I - 1, -TAU[TO_ + I - 1], TT, TTO + I - 1, LDT);
    specialize TRMV<T>('U', 'N', 'N', I - 1, TT, TTO, LDT, TT, TTO + I - 1,
      LDT);
    TT[TTO + (I - 1) * LDT + I - 1] := TAU[TO_ + I - 1];
  end;
  A[AO + (K + NB - 1) * LDA + NB - 1] := EI;
  { Compute Y(1:K, 1:NB). }
  for R := 0 to K - 1 do
    for C := 0 to NB - 1 do
      Y[YO + R * LDY + C] := A[AO + R * LDA + C + 1];
  specialize TRMM<T>('R', 'L', 'N', 'U', K, NB, ONE, A, AO + K * LDA, LDA, Y,
    YO, LDY);
  if N > K + NB then
    specialize GEMM<T>('N', 'N', K, NB, N - K - NB, ONE, A, AO + 1 + NB, LDA,
      A, AO + (K + NB) * LDA, LDA, ONE, Y, YO, LDY);
  specialize TRMM<T>('R', 'U', 'N', 'N', K, NB, ONE, TT, TTO, LDT, Y, YO, LDY);
end;

{ xGEHRD: blocked reduction of the N x N matrix A (by rows) to upper
  Hessenberg form in rows and columns ILO..IHI (0-based), with block size
  32 and crossover 128 of ILAENV and the work space LWORK (< 0: optimal),
  then xGEHD2. TAU has N - 1 entries. }
generic procedure GEHRDB<T>(N, ILO, IHI: longint; var A: array of T;
  var TAU: array of T; LWORK: longint);
var
  I, IB, J, NB, NBMIN, NH, NX, LWKOPT, LDW: longint;
  EI, ONE: T;
  TT, W, W2: array of T;
begin
  ONE := 1;
  NH := IHI - ILO + 1;
  NB := Min(LapackNBMAX, ILAENVNB(32));
  LWKOPT := N * NB + LapackTSIZE;
  if LWORK < 0 then LWORK := LWKOPT;
  { Set elements 0:ilo-1 and ihi:n-2 of TAU to zero. }
  for I := 0 to ILO - 1 do TAU[I] := 0;
  for I := Max(0, IHI) to N - 2 do TAU[I] := 0;
  { Quick return if possible. }
  if NH <= 1 then Exit;
  { Determine the block size. }
  NBMIN := 2;
  NX := 0;
  if (NB > 1) and (NB < NH) then
  begin
    { Determine when to cross over from blocked to unblocked code (last
      block is always handled by unblocked code). }
    NX := Max(NB, ILAENVNX(128));
    if NX < NH then
      { Determine if workspace is large enough for blocked code. }
      if LWORK < LWKOPT then
      begin
        { Not enough workspace to use optimal NB: determine the minimum
          value of NB, and reduce NB or force use of unblocked code. }
        NBMIN := 2;
        if LWORK >= N * NBMIN + LapackTSIZE then
          NB := (LWORK - LapackTSIZE) div N
        else
          NB := 1;
      end;
  end;
  if (NB < NBMIN) or (NB >= NH) then
    { Use unblocked code below. }
    I := ILO
  else
  begin
    { Use blocked code. }
    LDW := NB;
    TT := nil;
    W := nil;
    W2 := nil;
    SetLength(TT, NB * NB);
    SetLength(W, N * NB);
    SetLength(W2, N * NB);
    I := ILO;
    while I <= IHI - 1 - NX do
    begin
      IB := Min(NB, IHI - I);
      { Reduce columns i:i+ib-1 to Hessenberg form, returning the
        matrices V and T of the block reflector H = I - V*T*V^H which
        performs the reduction, and also the matrix Y = A*V*T. }
      specialize LAHR2<T>(IHI + 1, I + 1, IB, A, I, N, TAU, I, TT, 0, NB, W,
        0, LDW);
      { Apply the block reflector H to A(0:ihi, i+ib:ihi) from the right,
        computing A := A - Y * V^H. V(i+ib, ib-1) must be set to 1. }
      EI := A[(I + IB) * N + I + IB - 1];
      A[(I + IB) * N + I + IB - 1] := ONE;
      specialize GEMM<T>('N', 'C', IHI + 1, IHI - I - IB + 1, IB, -ONE, W, 0,
        LDW, A, (I + IB) * N + I, N, ONE, A, I + IB, N);
      A[(I + IB) * N + I + IB - 1] := EI;
      { Apply the block reflector H to A(0:i, i+1:i+ib-1) from the
        right. }
      specialize TRMM<T>('R', 'L', 'C', 'U', I + 1, IB - 1, ONE, A,
        (I + 1) * N + I, N, W, 0, LDW);
      for J := 0 to IB - 2 do
        specialize AXPY<T>(I + 1, -ONE, W, J, LDW, A, I + J + 1, N);
      { Apply the block reflector H to A(i+1:ihi, i+ib:n-1) from the
        left. }
      specialize LARFB<T>('L', 'C', 'F', IHI - I, N - I - IB, IB, A,
        (I + 1) * N + I, N, TT, 0, NB, A, (I + 1) * N + I + IB, N, W2, NB);
      I := I + NB;
    end;
  end;
  { Use unblocked code to reduce the rest of the matrix. }
  specialize GEHD2<T>(N, I, IHI, A, TAU);
end;

{ xORGHR: the orthogonal (unitary) Q of xGEHRD, with xORGQR. }
generic procedure ORGHR<T>(N, ILO, IHI: longint; var A: array of T;
  const TAU: array of T);
var
  I, J, NH: longint;
begin
  { Quick return if possible. }
  if N = 0 then Exit;
  NH := IHI - ILO;
  { Shift the vectors which define the elementary reflectors one column
    to the right, and set the first ilo and the last n-ihi-1 rows and
    columns to those of the unit matrix. }
  for J := IHI downto ILO + 1 do
  begin
    for I := 0 to J - 1 do A[I * N + J] := 0;
    for I := J + 1 to IHI do A[I * N + J] := A[I * N + J - 1];
    for I := IHI + 1 to N - 1 do A[I * N + J] := 0;
  end;
  for J := 0 to ILO do
  begin
    for I := 0 to N - 1 do A[I * N + J] := 0;
    A[J * N + J] := 1;
  end;
  for J := IHI + 1 to N - 1 do
  begin
    for I := 0 to N - 1 do A[I * N + J] := 0;
    A[J * N + J] := 1;
  end;
  if NH > 0 then
    { Generate Q(ilo+1:ihi, ilo+1:ihi). }
    specialize ORGQR<T>(NH, NH, NH, A, (ILO + 1) * N + ILO + 1, N, TAU, ILO);
end;

procedure GEHRDD(N, ILO, IHI: longint; var A: array of TReal;
  var TAU: array of TReal; LWORK: longint);
begin
  specialize GEHRDB<TReal>(N, ILO, IHI, A, TAU, LWORK);
end;

procedure GEHRDZ(N, ILO, IHI: longint; var A: array of TComplex;
  var TAU: array of TComplex; LWORK: longint);
begin
  specialize GEHRDB<TComplex>(N, ILO, IHI, A, TAU, LWORK);
end;

procedure DGEHRD(N, ILO, IHI: longint; var A: TArrayOfReal;
  out TAU: TArrayOfReal);
begin
  TAU := nil;
  SetLength(TAU, Max(N - 1, 0));
  specialize GEHRDB<TReal>(N, ILO, IHI, A, TAU, -1);
end;

procedure ZGEHRD(N, ILO, IHI: longint; var A: TArrayOfComplex;
  out TAU: TArrayOfComplex);
begin
  TAU := nil;
  SetLength(TAU, Max(N - 1, 0));
  specialize GEHRDB<TComplex>(N, ILO, IHI, A, TAU, -1);
end;

procedure DORGHR(N, ILO, IHI: longint; var A: TArrayOfReal;
  const TAU: TArrayOfReal);
begin
  specialize ORGHR<TReal>(N, ILO, IHI, A, TAU);
end;

procedure ZUNGHR(N, ILO, IHI: longint; var A: TArrayOfComplex;
  const TAU: TArrayOfComplex);
begin
  specialize ORGHR<TComplex>(N, ILO, IHI, A, TAU);
end;

{ DLALN2 with LTRANS = false: solves (CA*A - W*D)*X = SCALE*B for the
  NA x NA matrix A (NA = 1 or 2), D = diag(D1, D2) and W = WR + i*WI
  (NW = 1: real, NW = 2: complex, X and B with real and imaginary parts
  in their two columns), with perturbation SMIN of small pivots. The 2x2
  arrays are given by their entries (A21 is the entry in row 2,
  column 1). INFO = 1 when a pivot was perturbed. }
procedure DLALN2(NA, NW: longint; SMIN, CA, A11, A21, A12, A22, D1, D2, B11,
  B21, B12, B22, WR, WI: TReal; out X11, X21, X12, X22, SCALE, XNORM: TReal;
  out INFO: longint);
const
  ONE: TReal = 1;
  TWO: TReal = 2;
  ZSWAP: array[1..4] of boolean = (False, False, True, True);
  RSWAP: array[1..4] of boolean = (False, True, False, True);
  IPIVOT: array[1..4, 1..4] of longint =
    ((1, 2, 3, 4), (2, 1, 4, 3), (3, 4, 1, 2), (4, 3, 2, 1));
var
  ICMAX, J: longint;
  BBND, BI1, BI2, BIGNUM, BNORM, BR1, BR2, CI21, CI22, CMAX, CNORM, CR21,
    CR22, CSI, CSR, LI21, LR21, SMINI, SMLNUM, TEMP, U22ABS, UI11, UI11R,
    UI12, UI12S, UI22, UR11, UR11R, UR12, UR12S, UR22, XI1, XI2, XR1,
    XR2: TReal;
  { CR, CI stored by columns as CRV, CIV of LAPACK; IPIVOT(i, icmax) is
    IPIVOT[icmax, i] here. }
  CRV, CIV: array[1..4] of TReal;
begin
  X11 := 0;
  X21 := 0;
  X12 := 0;
  X22 := 0;
  { Compute BIGNUM. }
  SMLNUM := TWO * LapackSafeMinimum;
  BIGNUM := ONE / SMLNUM;
  SMINI := Max(SMIN, SMLNUM);
  { Standard Initializations. }
  INFO := 0;
  SCALE := ONE;
  if NA = 1 then
  begin
    { 1 x 1 (i.e., scalar) system C X = B. }
    if NW = 1 then
    begin
      { Real 1x1 system. C = ca A - w D. }
      CSR := CA * A11 - WR * D1;
      CNORM := System.Abs(CSR);
      { If | C | < SMINI, use C = SMINI. }
      if CNORM < SMINI then
      begin
        CSR := SMINI;
        CNORM := SMINI;
        INFO := 1;
      end;
      { Check scaling for X = B / C. }
      BNORM := System.Abs(B11);
      if (CNORM < ONE) and (BNORM > ONE) then
        if BNORM > BIGNUM * CNORM then SCALE := ONE / BNORM;
      { Compute X. }
      X11 := (B11 * SCALE) / CSR;
      XNORM := System.Abs(X11);
    end else
    begin
      { Complex 1x1 system (w is complex). C = ca A - w D. }
      CSR := CA * A11 - WR * D1;
      CSI := -WI * D1;
      CNORM := System.Abs(CSR) + System.Abs(CSI);
      { If | C | < SMINI, use C = SMINI. }
      if CNORM < SMINI then
      begin
        CSR := SMINI;
        CSI := 0;
        CNORM := SMINI;
        INFO := 1;
      end;
      { Check scaling for X = B / C. }
      BNORM := System.Abs(B11) + System.Abs(B12);
      if (CNORM < ONE) and (BNORM > ONE) then
        if BNORM > BIGNUM * CNORM then SCALE := ONE / BNORM;
      { Compute X. }
      DLADIV(SCALE * B11, SCALE * B12, CSR, CSI, X11, X12);
      XNORM := System.Abs(X11) + System.Abs(X12);
    end;
  end else
  begin
    { 2x2 System. Compute the real part of C = ca A - w D (or ca A**T -
      w D). }
    CRV[1] := CA * A11 - WR * D1;
    CRV[4] := CA * A22 - WR * D2;
    CRV[2] := CA * A21;
    CRV[3] := CA * A12;
    if NW = 1 then
    begin
      { Real 2x2 system (w is real). Find the largest element in C. }
      CMAX := 0;
      ICMAX := 0;
      for J := 1 to 4 do
        if System.Abs(CRV[J]) > CMAX then
        begin
          CMAX := System.Abs(CRV[J]);
          ICMAX := J;
        end;
      { If norm(C) < SMINI, use SMINI*identity. }
      if CMAX < SMINI then
      begin
        BNORM := Max(System.Abs(B11), System.Abs(B21));
        if (SMINI < ONE) and (BNORM > ONE) then
          if BNORM > BIGNUM * SMINI then SCALE := ONE / BNORM;
        TEMP := SCALE / SMINI;
        X11 := TEMP * B11;
        X21 := TEMP * B21;
        XNORM := TEMP * BNORM;
        INFO := 1;
        Exit;
      end;
      { Gaussian elimination with complete pivoting. }
      UR11 := CRV[ICMAX];
      CR21 := CRV[IPIVOT[ICMAX, 2]];
      UR12 := CRV[IPIVOT[ICMAX, 3]];
      CR22 := CRV[IPIVOT[ICMAX, 4]];
      UR11R := ONE / UR11;
      LR21 := UR11R * CR21;
      UR22 := CR22 - UR12 * LR21;
      { If smaller pivot < SMINI, use SMINI. }
      if System.Abs(UR22) < SMINI then
      begin
        UR22 := SMINI;
        INFO := 1;
      end;
      if RSWAP[ICMAX] then
      begin
        BR1 := B21;
        BR2 := B11;
      end else
      begin
        BR1 := B11;
        BR2 := B21;
      end;
      BR2 := BR2 - LR21 * BR1;
      BBND := Max(System.Abs(BR1 * (UR22 * UR11R)), System.Abs(BR2));
      if (BBND > ONE) and (System.Abs(UR22) < ONE) then
        if BBND >= BIGNUM * System.Abs(UR22) then SCALE := ONE / BBND;
      XR2 := (BR2 * SCALE) / UR22;
      XR1 := (SCALE * BR1) * UR11R - XR2 * (UR11R * UR12);
      if ZSWAP[ICMAX] then
      begin
        X11 := XR2;
        X21 := XR1;
      end else
      begin
        X11 := XR1;
        X21 := XR2;
      end;
      XNORM := Max(System.Abs(XR1), System.Abs(XR2));
      { Further scaling if norm(A) norm(X) > overflow. }
      if (XNORM > ONE) and (CMAX > ONE) then
        if XNORM > BIGNUM / CMAX then
        begin
          TEMP := CMAX / BIGNUM;
          X11 := TEMP * X11;
          X21 := TEMP * X21;
          XNORM := TEMP * XNORM;
          SCALE := TEMP * SCALE;
        end;
    end else
    begin
      { Complex 2x2 system (w is complex). Find the largest element in
        C. }
      CIV[1] := -WI * D1;
      CIV[2] := 0;
      CIV[3] := 0;
      CIV[4] := -WI * D2;
      CMAX := 0;
      ICMAX := 0;
      for J := 1 to 4 do
        if System.Abs(CRV[J]) + System.Abs(CIV[J]) > CMAX then
        begin
          CMAX := System.Abs(CRV[J]) + System.Abs(CIV[J]);
          ICMAX := J;
        end;
      { If norm(C) < SMINI, use SMINI*identity. }
      if CMAX < SMINI then
      begin
        BNORM := Max(System.Abs(B11) + System.Abs(B12),
          System.Abs(B21) + System.Abs(B22));
        if (SMINI < ONE) and (BNORM > ONE) then
          if BNORM > BIGNUM * SMINI then SCALE := ONE / BNORM;
        TEMP := SCALE / SMINI;
        X11 := TEMP * B11;
        X21 := TEMP * B21;
        X12 := TEMP * B12;
        X22 := TEMP * B22;
        XNORM := TEMP * BNORM;
        INFO := 1;
        Exit;
      end;
      { Gaussian elimination with complete pivoting. }
      UR11 := CRV[ICMAX];
      UI11 := CIV[ICMAX];
      CR21 := CRV[IPIVOT[ICMAX, 2]];
      CI21 := CIV[IPIVOT[ICMAX, 2]];
      UR12 := CRV[IPIVOT[ICMAX, 3]];
      UI12 := CIV[IPIVOT[ICMAX, 3]];
      CR22 := CRV[IPIVOT[ICMAX, 4]];
      CI22 := CIV[IPIVOT[ICMAX, 4]];
      if (ICMAX = 1) or (ICMAX = 4) then
      begin
        { Code when off-diagonals of pivoted C are real. }
        if System.Abs(UR11) > System.Abs(UI11) then
        begin
          TEMP := UI11 / UR11;
          UR11R := ONE / (UR11 * (ONE + Sqr(TEMP)));
          UI11R := -TEMP * UR11R;
        end else
        begin
          TEMP := UR11 / UI11;
          UI11R := -ONE / (UI11 * (ONE + Sqr(TEMP)));
          UR11R := -TEMP * UI11R;
        end;
        LR21 := CR21 * UR11R;
        LI21 := CR21 * UI11R;
        UR12S := UR12 * UR11R;
        UI12S := UR12 * UI11R;
        UR22 := CR22 - UR12 * LR21;
        UI22 := CI22 - UR12 * LI21;
      end else
      begin
        { Code when diagonals of pivoted C are real. }
        UR11R := ONE / UR11;
        UI11R := 0;
        LR21 := CR21 * UR11R;
        LI21 := CI21 * UR11R;
        UR12S := UR12 * UR11R;
        UI12S := UI12 * UR11R;
        UR22 := CR22 - UR12 * LR21 + UI12 * LI21;
        UI22 := -UR12 * LI21 - UI12 * LR21;
      end;
      U22ABS := System.Abs(UR22) + System.Abs(UI22);
      { If smaller pivot < SMINI, use SMINI. }
      if U22ABS < SMINI then
      begin
        UR22 := SMINI;
        UI22 := 0;
        INFO := 1;
      end;
      if RSWAP[ICMAX] then
      begin
        BR2 := B11;
        BR1 := B21;
        BI2 := B12;
        BI1 := B22;
      end else
      begin
        BR1 := B11;
        BR2 := B21;
        BI1 := B12;
        BI2 := B22;
      end;
      BR2 := BR2 - LR21 * BR1 + LI21 * BI1;
      BI2 := BI2 - LI21 * BR1 - LR21 * BI1;
      BBND := Max((System.Abs(BR1) + System.Abs(BI1)) *
        (U22ABS * (System.Abs(UR11R) + System.Abs(UI11R))),
        System.Abs(BR2) + System.Abs(BI2));
      if (BBND > ONE) and (U22ABS < ONE) then
        if BBND >= BIGNUM * U22ABS then
        begin
          SCALE := ONE / BBND;
          BR1 := SCALE * BR1;
          BI1 := SCALE * BI1;
          BR2 := SCALE * BR2;
          BI2 := SCALE * BI2;
        end;
      DLADIV(BR2, BI2, UR22, UI22, XR2, XI2);
      XR1 := UR11R * BR1 - UI11R * BI1 - UR12S * XR2 + UI12S * XI2;
      XI1 := UI11R * BR1 + UR11R * BI1 - UI12S * XR2 - UR12S * XI2;
      if ZSWAP[ICMAX] then
      begin
        X11 := XR2;
        X21 := XR1;
        X12 := XI2;
        X22 := XI1;
      end else
      begin
        X11 := XR1;
        X21 := XR2;
        X12 := XI1;
        X22 := XI2;
      end;
      XNORM := Max(System.Abs(XR1) + System.Abs(XI1),
        System.Abs(XR2) + System.Abs(XI2));
      { Further scaling if norm(A) norm(X) > overflow. }
      if (XNORM > ONE) and (CMAX > ONE) then
        if XNORM > BIGNUM / CMAX then
        begin
          TEMP := CMAX / BIGNUM;
          X11 := TEMP * X11;
          X21 := TEMP * X21;
          X12 := TEMP * X12;
          X22 := TEMP * X22;
          XNORM := TEMP * XNORM;
          SCALE := TEMP * SCALE;
        end;
    end;
  end;
end;

{ DTREVC3 with SIDE = 'R', HOWMNY = 'B': right eigenvectors of the real
  upper quasi-triangular Schur form T (N x N at T[TO], row stride LDT),
  back-transformed by the Schur vectors in VR (at VR[VRO], row stride
  LDVR). A complex pair occupies two columns, real and imaginary part of
  the eigenvector of the eigenvalue with positive imaginary part; each
  vector is scaled so that its largest component has |Re| + |Im| = 1.
  The back-transformation is blocked (xGEMM) when the work space LWORK
  (< 0: optimal) allows a block size of at least 8, at most 128. }
procedure DTREVC3(N: longint; const T: array of TReal; TO_, LDT: longint;
  var VR: array of TReal; VRO, LDVR: longint; LWORK: longint);
const
  NBMIN = 8;
  NBMAX = 128;
  ONE: TReal = 1;
var
  NB, LDW, KI, IV, IP, ISV, J, J1, J2, JNXT, K, II, KI2, IERR, I: longint;
  UNFL, OVFL, ULP, SMLNUM, BIGNUM, WR, WI, SMIN, SCALE, XNORM, BETA, REC,
    REMAX, EMAX, X11, X21, X12, X22: TReal;
  WORK: array of TReal;
  ISCOMPLEX: array[1..NBMAX] of longint;
  SKIP: boolean;

  function TE(R, C: longint): TReal; inline;
  begin
    result := T[TO_ + (R - 1) * LDT + C - 1];
  end;

  { Index of WORK(R + C*N) of LAPACK: row R (from 1), column C. }
  function WI_(R, C: longint): longint; inline;
  begin
    result := (R - 1) * LDW + C;
  end;

begin
  if N = 0 then Exit;
  if LWORK < 0 then LWORK := N + 2 * N * ILAENVNB(64);
  { Use blocked version of back-transformation if sufficient workspace. }
  if LWORK >= N + 2 * N * NBMIN then
  begin
    NB := (LWORK - N) div (2 * N);
    NB := Min(NB, NBMAX);
  end else
    NB := 1;
  LDW := Max(1 + 2 * NB, 3);
  WORK := nil;
  SetLength(WORK, N * LDW);
  { Set the constants to control overflow. }
  UNFL := LapackSafeMinimum;
  OVFL := ONE / UNFL;
  ULP := LapackPrecision;
  SMLNUM := UNFL * (TReal(N) / ULP);
  BIGNUM := (ONE - ULP) / SMLNUM;
  { Compute 1-norm of each column of strictly upper triangular part of T
    to control overflow in triangular solver. }
  WORK[WI_(1, 0)] := 0;
  for J := 2 to N do
  begin
    WORK[WI_(J, 0)] := 0;
    for I := 1 to J - 1 do
      WORK[WI_(J, 0)] := WORK[WI_(J, 0)] + System.Abs(TE(I, J));
  end;
  { Compute right eigenvectors. IV is index of column in current block.
    For complex right vector, uses IV-1 for real part and IV for complex
    part. Non-blocked version always uses IV=2; blocked version starts
    with IV=NB, goes down to 1 or 2. (Note the "0-th" column is used for
    1-norms computed above.) }
  IV := 2;
  if NB > 2 then IV := NB;
  IP := 0;
  ISV := N;
  REMAX := 0;
  SCALE := ONE;
  for KI := N downto 1 do
  begin
    SKIP := False;
    if IP = -1 then
    begin
      { Previous iteration (ki+1) was second of conjugate pair, so this
        ki is first of conjugate pair; skip to end of loop. }
      IP := 1;
      SKIP := True;
    end else if KI = 1 then
      { Last column, so this ki must be real eigenvalue. }
      IP := 0
    else if TE(KI, KI - 1) = 0 then
      { Zero on sub-diagonal, so this ki is real eigenvalue. }
      IP := 0
    else
      { Non-zero on sub-diagonal, so this ki is second of conjugate
        pair. }
      IP := -1;
    if SKIP then Continue;
    { Compute the KI-th eigenvalue (WR,WI). }
    WR := TE(KI, KI);
    WI := 0;
    if IP <> 0 then
      WI := Sqrt(System.Abs(TE(KI, KI - 1))) * Sqrt(System.Abs(TE(KI - 1, KI)));
    SMIN := Max(ULP * (System.Abs(WR) + System.Abs(WI)), SMLNUM);
    if IP = 0 then
    begin
      { Real right eigenvector. }
      WORK[WI_(KI, IV)] := ONE;
      { Form right-hand side. }
      for K := 1 to KI - 1 do WORK[WI_(K, IV)] := -TE(K, KI);
      { Solve upper quasi-triangular system:
        [ T(1:KI-1,1:KI-1) - WR ]*X = SCALE*WORK. }
      JNXT := KI - 1;
      for J := KI - 1 downto 1 do
      begin
        if J > JNXT then Continue;
        J1 := J;
        J2 := J;
        JNXT := J - 1;
        if J > 1 then
          if TE(J, J - 1) <> 0 then
          begin
            J1 := J - 1;
            JNXT := J - 2;
          end;
        if J1 = J2 then
        begin
          { 1-by-1 diagonal block. }
          DLALN2(1, 1, SMIN, ONE, TE(J, J), 0, 0, 0, ONE, ONE,
            WORK[WI_(J, IV)], 0, 0, 0, WR, 0, X11, X21, X12, X22, SCALE,
            XNORM, IERR);
          { Scale X(1,1) to avoid overflow when updating the right-hand
            side. }
          if XNORM > ONE then
            if WORK[WI_(J, 0)] > BIGNUM / XNORM then
            begin
              X11 := X11 / XNORM;
              SCALE := SCALE / XNORM;
            end;
          { Scale if necessary. }
          if SCALE <> ONE then
            specialize SCAL<TReal>(KI, SCALE, WORK, WI_(1, IV), LDW);
          WORK[WI_(J, IV)] := X11;
          { Update right-hand side. }
          specialize AXPY<TReal>(J - 1, -X11, T, TO_ + J - 1, LDT, WORK,
            WI_(1, IV), LDW);
        end else
        begin
          { 2-by-2 diagonal block. }
          DLALN2(2, 1, SMIN, ONE, TE(J - 1, J - 1), TE(J, J - 1),
            TE(J - 1, J), TE(J, J), ONE, ONE, WORK[WI_(J - 1, IV)],
            WORK[WI_(J, IV)], 0, 0, WR, 0, X11, X21, X12, X22, SCALE, XNORM,
            IERR);
          { Scale X(1,1) and X(2,1) to avoid overflow when updating the
            right-hand side. }
          if XNORM > ONE then
          begin
            BETA := Max(WORK[WI_(J - 1, 0)], WORK[WI_(J, 0)]);
            if BETA > BIGNUM / XNORM then
            begin
              X11 := X11 / XNORM;
              X21 := X21 / XNORM;
              SCALE := SCALE / XNORM;
            end;
          end;
          { Scale if necessary. }
          if SCALE <> ONE then
            specialize SCAL<TReal>(KI, SCALE, WORK, WI_(1, IV), LDW);
          WORK[WI_(J - 1, IV)] := X11;
          WORK[WI_(J, IV)] := X21;
          { Update right-hand side. }
          specialize AXPY<TReal>(J - 2, -X11, T, TO_ + J - 2, LDT, WORK,
            WI_(1, IV), LDW);
          specialize AXPY<TReal>(J - 2, -X21, T, TO_ + J - 1, LDT, WORK,
            WI_(1, IV), LDW);
        end;
      end;
      { Copy the vector x or Q*x to VR and normalize. }
      if NB = 1 then
      begin
        { Version 1: back-transform each vector with GEMV, Q*x. }
        if KI > 1 then
          specialize GEMV<TReal>('N', N, KI - 1, ONE, VR, VRO, LDVR, WORK,
            WI_(1, IV), LDW, WORK[WI_(KI, IV)], VR, VRO + KI - 1, LDVR);
        II := specialize IAMAX<TReal>(N, VR, VRO + KI - 1, LDVR);
        REMAX := ONE / System.Abs(VR[VRO + II * LDVR + KI - 1]);
        specialize SCAL<TReal>(N, REMAX, VR, VRO + KI - 1, LDVR);
      end else
      begin
        { Version 2: back-transform block of vectors with GEMM. Zero out
          below vector. }
        for K := KI + 1 to N do WORK[WI_(K, IV)] := 0;
        ISCOMPLEX[IV] := IP;
        { Back-transform and normalization is done below. }
      end;
    end else
    begin
      { Complex right eigenvector. Initial solve
        [ ( T(KI-1,KI-1) T(KI-1,KI) ) - (WR + I*WI) ]*X = 0.
        [ ( T(KI,  KI-1) T(KI,  KI) )               ] }
      if System.Abs(TE(KI - 1, KI)) >= System.Abs(TE(KI, KI - 1)) then
      begin
        WORK[WI_(KI - 1, IV - 1)] := ONE;
        WORK[WI_(KI, IV)] := WI / TE(KI - 1, KI);
      end else
      begin
        WORK[WI_(KI - 1, IV - 1)] := -WI / TE(KI, KI - 1);
        WORK[WI_(KI, IV)] := ONE;
      end;
      WORK[WI_(KI, IV - 1)] := 0;
      WORK[WI_(KI - 1, IV)] := 0;
      { Form right-hand side. }
      for K := 1 to KI - 2 do
      begin
        WORK[WI_(K, IV - 1)] := -WORK[WI_(KI - 1, IV - 1)] * TE(K, KI - 1);
        WORK[WI_(K, IV)] := -WORK[WI_(KI, IV)] * TE(K, KI);
      end;
      { Solve upper quasi-triangular system:
        [ T(1:KI-2,1:KI-2) - (WR+i*WI) ]*X = SCALE*(WORK+i*WORK2) }
      JNXT := KI - 2;
      for J := KI - 2 downto 1 do
      begin
        if J > JNXT then Continue;
        J1 := J;
        J2 := J;
        JNXT := J - 1;
        if J > 1 then
          if TE(J, J - 1) <> 0 then
          begin
            J1 := J - 1;
            JNXT := J - 2;
          end;
        if J1 = J2 then
        begin
          { 1-by-1 diagonal block. }
          DLALN2(1, 2, SMIN, ONE, TE(J, J), 0, 0, 0, ONE, ONE,
            WORK[WI_(J, IV - 1)], 0, WORK[WI_(J, IV)], 0, WR, WI, X11, X21,
            X12, X22, SCALE, XNORM, IERR);
          { Scale X(1,1) and X(1,2) to avoid overflow when updating the
            right-hand side. }
          if XNORM > ONE then
            if WORK[WI_(J, 0)] > BIGNUM / XNORM then
            begin
              X11 := X11 / XNORM;
              X12 := X12 / XNORM;
              SCALE := SCALE / XNORM;
            end;
          { Scale if necessary. }
          if SCALE <> ONE then
          begin
            specialize SCAL<TReal>(KI, SCALE, WORK, WI_(1, IV - 1), LDW);
            specialize SCAL<TReal>(KI, SCALE, WORK, WI_(1, IV), LDW);
          end;
          WORK[WI_(J, IV - 1)] := X11;
          WORK[WI_(J, IV)] := X12;
          { Update the right-hand side. }
          specialize AXPY<TReal>(J - 1, -X11, T, TO_ + J - 1, LDT, WORK,
            WI_(1, IV - 1), LDW);
          specialize AXPY<TReal>(J - 1, -X12, T, TO_ + J - 1, LDT, WORK,
            WI_(1, IV), LDW);
        end else
        begin
          { 2-by-2 diagonal block. }
          DLALN2(2, 2, SMIN, ONE, TE(J - 1, J - 1), TE(J, J - 1),
            TE(J - 1, J), TE(J, J), ONE, ONE, WORK[WI_(J - 1, IV - 1)],
            WORK[WI_(J, IV - 1)], WORK[WI_(J - 1, IV)], WORK[WI_(J, IV)], WR,
            WI, X11, X21, X12, X22, SCALE, XNORM, IERR);
          { Scale X to avoid overflow when updating the right-hand side. }
          if XNORM > ONE then
          begin
            BETA := Max(WORK[WI_(J - 1, 0)], WORK[WI_(J, 0)]);
            if BETA > BIGNUM / XNORM then
            begin
              REC := ONE / XNORM;
              X11 := X11 * REC;
              X12 := X12 * REC;
              X21 := X21 * REC;
              X22 := X22 * REC;
              SCALE := SCALE * REC;
            end;
          end;
          { Scale if necessary. }
          if SCALE <> ONE then
          begin
            specialize SCAL<TReal>(KI, SCALE, WORK, WI_(1, IV - 1), LDW);
            specialize SCAL<TReal>(KI, SCALE, WORK, WI_(1, IV), LDW);
          end;
          WORK[WI_(J - 1, IV - 1)] := X11;
          WORK[WI_(J, IV - 1)] := X21;
          WORK[WI_(J - 1, IV)] := X12;
          WORK[WI_(J, IV)] := X22;
          { Update the right-hand side. }
          specialize AXPY<TReal>(J - 2, -X11, T, TO_ + J - 2, LDT, WORK,
            WI_(1, IV - 1), LDW);
          specialize AXPY<TReal>(J - 2, -X21, T, TO_ + J - 1, LDT, WORK,
            WI_(1, IV - 1), LDW);
          specialize AXPY<TReal>(J - 2, -X12, T, TO_ + J - 2, LDT, WORK,
            WI_(1, IV), LDW);
          specialize AXPY<TReal>(J - 2, -X22, T, TO_ + J - 1, LDT, WORK,
            WI_(1, IV), LDW);
        end;
      end;
      { Copy the vector x or Q*x to VR and normalize. }
      if NB = 1 then
      begin
        { Version 1: back-transform each vector with GEMV, Q*x. }
        if KI > 2 then
        begin
          specialize GEMV<TReal>('N', N, KI - 2, ONE, VR, VRO, LDVR, WORK,
            WI_(1, IV - 1), LDW, WORK[WI_(KI - 1, IV - 1)], VR, VRO + KI - 2,
            LDVR);
          specialize GEMV<TReal>('N', N, KI - 2, ONE, VR, VRO, LDVR, WORK,
            WI_(1, IV), LDW, WORK[WI_(KI, IV)], VR, VRO + KI - 1, LDVR);
        end else
        begin
          specialize SCAL<TReal>(N, WORK[WI_(KI - 1, IV - 1)], VR,
            VRO + KI - 2, LDVR);
          specialize SCAL<TReal>(N, WORK[WI_(KI, IV)], VR, VRO + KI - 1, LDVR);
        end;
        EMAX := 0;
        for K := 0 to N - 1 do
          EMAX := Max(EMAX, System.Abs(VR[VRO + K * LDVR + KI - 2]) +
            System.Abs(VR[VRO + K * LDVR + KI - 1]));
        REMAX := ONE / EMAX;
        specialize SCAL<TReal>(N, REMAX, VR, VRO + KI - 2, LDVR);
        specialize SCAL<TReal>(N, REMAX, VR, VRO + KI - 1, LDVR);
      end else
      begin
        { Version 2: back-transform block of vectors with GEMM. Zero out
          below vector. }
        for K := KI + 1 to N do
        begin
          WORK[WI_(K, IV - 1)] := 0;
          WORK[WI_(K, IV)] := 0;
        end;
        ISCOMPLEX[IV - 1] := -IP;
        ISCOMPLEX[IV] := IP;
        IV := IV - 1;
        { Back-transform and normalization is done below. }
      end;
    end;
    if NB > 1 then
    begin
      { Blocked version of back-transform. For complex case, KI2 includes
        both vectors (KI-1 and KI). }
      if IP = 0 then KI2 := KI else KI2 := KI - 1;
      { Columns IV:NB of work are valid vectors. When the number of
        vectors stored reaches NB-1 or NB, or if this was last vector, do
        the GEMM. }
      if (IV <= 2) or (KI2 = 1) then
      begin
        specialize GEMM<TReal>('N', 'N', N, NB - IV + 1, KI2 + NB - IV, ONE, VR,
          VRO, LDVR, WORK, WI_(1, IV), LDW, 0, WORK, WI_(1, NB + IV), LDW);
        { Normalize vectors. }
        for K := IV to NB do
        begin
          if ISCOMPLEX[K] = 0 then
          begin
            { Real eigenvector. }
            II := specialize IAMAX<TReal>(N, WORK, WI_(1, NB + K), LDW);
            REMAX := ONE / System.Abs(WORK[WI_(II + 1, NB + K)]);
          end else if ISCOMPLEX[K] = 1 then
          begin
            { First eigenvector of conjugate pair. }
            EMAX := 0;
            for II := 1 to N do
              EMAX := Max(EMAX, System.Abs(WORK[WI_(II, NB + K)]) +
                System.Abs(WORK[WI_(II, NB + K + 1)]));
            REMAX := ONE / EMAX;
            { else if ISCOMPLEX(K) = -1: second eigenvector of conjugate
              pair reuses REMAX from previous K. }
          end;
          specialize SCAL<TReal>(N, REMAX, WORK, WI_(1, NB + K), LDW);
        end;
        for I := 0 to N - 1 do
          for K := 0 to NB - IV do
            VR[VRO + I * LDVR + KI2 - 1 + K] := WORK[I * LDW + NB + IV + K];
        IV := NB;
      end else
        IV := IV - 1;
    end;
    ISV := ISV - 1;
    if IP <> 0 then ISV := ISV - 1;
  end;
end;

{ ZTREVC3 with SIDE = 'R', HOWMNY = 'B': right eigenvectors of the
  complex upper triangular T, back-transformed by the Schur vectors in
  VR, each scaled so that its largest component has |Re| + |Im| = 1. The
  diagonal of T is modified during the computation and restored. The
  back-transformation is blocked as in DTREVC3. }
procedure ZTREVC3(N: longint; var T: array of TComplex; TO_, LDT: longint;
  var VR: array of TComplex; VRO, LDVR: longint; LWORK: longint);
const
  NBMIN = 8;
  NBMAX = 128;
  ONE: TReal = 1;
var
  NB, LDW, KI, IV, ISV, K, II, INFO, I: longint;
  UNFL, OVFL, ULP, SMLNUM, SMIN, SCALE, REMAX: TReal;
  WORK, X: array of TComplex;
  RWORK: array of TReal;
  CONE: TComplex;
begin
  if N = 0 then Exit;
  CONE := 1;
  if LWORK < 0 then LWORK := N + 2 * N * ILAENVNB(64);
  { Use blocked version of back-transformation if sufficient workspace. }
  if LWORK >= N + 2 * N * NBMIN then
  begin
    NB := (LWORK - N) div (2 * N);
    NB := Min(NB, NBMAX);
  end else
    NB := 1;
  LDW := 1 + 2 * NB;
  WORK := nil;
  RWORK := nil;
  X := nil;
  SetLength(WORK, N * LDW);
  SetLength(RWORK, N);
  SetLength(X, N);
  { Set the constants to control overflow. }
  UNFL := LapackSafeMinimum;
  OVFL := ONE / UNFL;
  ULP := LapackPrecision;
  SMLNUM := UNFL * (TReal(N) / ULP);
  { Store the diagonal elements of T in working array WORK. }
  for I := 0 to N - 1 do WORK[I * LDW] := T[TO_ + I * LDT + I];
  { Compute 1-norm of each column of strictly upper triangular part of T
    to control overflow in triangular solver. }
  RWORK[0] := 0;
  for I := 1 to N - 1 do
    RWORK[I] := specialize ASUM<TComplex>(I, T, TO_ + I, LDT);
  { Compute right eigenvectors. IV is index of column in current block.
    Non-blocked version always uses IV=NB=1; blocked version starts with
    IV=NB, goes down to 1. (Note the "0-th" column is used to store the
    original diagonal elements of T.) }
  IV := NB;
  ISV := N;
  SCALE := ONE;
  for KI := N downto 1 do
  begin
    SMIN := Max(ULP * CABS1(T[TO_ + (KI - 1) * LDT + KI - 1]), SMLNUM);
    WORK[(KI - 1) * LDW + IV] := CONE;
    { Form right-hand side. }
    for K := 1 to KI - 1 do
      WORK[(K - 1) * LDW + IV] := -T[TO_ + (K - 1) * LDT + KI - 1];
    { Solve upper triangular system:
      [ T(1:KI-1,1:KI-1) - T(KI,KI) ]*X = SCALE*WORK. }
    for K := 1 to KI - 1 do
    begin
      T[TO_ + (K - 1) * LDT + K - 1] := T[TO_ + (K - 1) * LDT + K - 1] -
        T[TO_ + (KI - 1) * LDT + KI - 1];
      if CABS1(T[TO_ + (K - 1) * LDT + K - 1]) < SMIN then
        T[TO_ + (K - 1) * LDT + K - 1] := SMIN;
    end;
    if KI > 1 then
    begin
      for K := 0 to KI - 2 do X[K] := WORK[K * LDW + IV];
      ZLATRS('U', 'N', 'N', 'Y', KI - 1, T, TO_, LDT, X, SCALE, RWORK);
      for K := 0 to KI - 2 do WORK[K * LDW + IV] := X[K];
      WORK[(KI - 1) * LDW + IV] := SCALE;
    end;
    { Copy the vector x or Q*x to VR and normalize. }
    if NB = 1 then
    begin
      { Version 1: back-transform each vector with GEMV, Q*x. }
      if KI > 1 then
        specialize GEMV<TComplex>('N', N, KI - 1, CONE, VR, VRO, LDVR, WORK,
          IV, LDW, SCALE, VR, VRO + KI - 1, LDVR);
      II := specialize IAMAX<TComplex>(N, VR, VRO + KI - 1, LDVR);
      REMAX := ONE / CABS1(VR[VRO + II * LDVR + KI - 1]);
      ZDSCAL(N, REMAX, VR, VRO + KI - 1, LDVR);
    end else
    begin
      { Version 2: back-transform block of vectors with GEMM. Zero out
        below vector. }
      for K := KI + 1 to N do WORK[(K - 1) * LDW + IV] := 0;
      { Columns IV:NB of work are valid vectors. When the number of
        vectors stored reaches NB, or if this was last vector, do the
        GEMM. }
      if (IV = 1) or (KI = 1) then
      begin
        specialize GEMM<TComplex>('N', 'N', N, NB - IV + 1, KI + NB - IV, CONE,
          VR, VRO, LDVR, WORK, IV, LDW, 0, WORK, NB + IV, LDW);
        { Normalize vectors. }
        for K := IV to NB do
        begin
          II := specialize IAMAX<TComplex>(N, WORK, NB + K, LDW);
          REMAX := ONE / CABS1(WORK[II * LDW + NB + K]);
          ZDSCAL(N, REMAX, WORK, NB + K, LDW);
        end;
        for I := 0 to N - 1 do
          for K := 0 to NB - IV do
            VR[VRO + I * LDVR + KI - 1 + K] := WORK[I * LDW + NB + IV + K];
        IV := NB;
      end else
        IV := IV - 1;
    end;
    { Restore the original diagonal elements of T. }
    for K := 1 to KI - 1 do
      T[TO_ + (K - 1) * LDT + K - 1] := WORK[(K - 1) * LDW];
    ISV := ISV - 1;
  end;
end;

{ The optimal work space returned by the workspace query of xGEHRD
  (N x N, rows and columns ILO..IHI counted from 1). }
function GEHRDQUERY(N, ILO, IHI: longint): longint;
begin
  if IHI - ILO + 1 <= 1 then
    result := 1
  else
    result := N * Min(LapackNBMAX, ILAENVNB(32)) + LapackTSIZE;
end;

function LAQR04QUERY(N, ILO, IHI: longint; RECURSIVE: boolean): longint;
  forward;

{ The workspace query of xLAQR3 (RECURSIVE) or xLAQR2 for the active
  block KTOP..KBOT (from 1) and the deflation window NW. }
function LAQR23QUERY(N, KTOP, KBOT, NW: longint; RECURSIVE: boolean): longint;
var
  JW, LWK1, LWK2, LWK3: longint;
begin
  JW := Min(NW, KBOT - KTOP + 1);
  if JW <= 2 then
    Exit(1);
  LWK1 := GEHRDQUERY(JW, 1, JW - 1);
  { xORMHR with SIDE = 'R': NW*NB with NW = JW. }
  LWK2 := JW * ILAENVNB(32);
  if RECURSIVE then
  begin
    LWK3 := LAQR04QUERY(JW, 1, JW, False);
    result := Max(JW + Max(LWK1, LWK2), LWK3);
  end else
    result := JW + Max(LWK1, LWK2);
end;

{ The workspace query of xLAQR0 (RECURSIVE) or xLAQR4. }
function LAQR04QUERY(N, ILO, IHI: longint; RECURSIVE: boolean): longint;
const
  NTINY = 15;
var
  NWR, NSR: longint;
begin
  if N = 0 then Exit(1);
  if N <= NTINY then Exit(1);
  NWR := IPARMQ(13, ILO, IHI);
  NWR := Max(2, NWR);
  NWR := Min(Min(IHI - ILO + 1, (N - 1) div 3), NWR);
  NSR := IPARMQ(15, ILO, IHI);
  NSR := Min(Min(NSR, (N - 3) div 6), IHI - ILO);
  NSR := Max(2, NSR - NSR mod 2);
  result := Max(3 * NSR div 2, LAQR23QUERY(N, ILO, IHI, NWR + 1, RECURSIVE));
end;

{ The workspace query of xHSEQR for the whole matrix (ILO = 1, IHI = N),
  as xGEEV calls it. }
function HSEQRQUERY(N: longint): longint;
begin
  result := Max(Max(1, N), LAQR04QUERY(N, 1, N, True));
end;

procedure DGEEV(N: longint; var A: TArrayOfReal; out WR, WI: TArrayOfReal;
  out VR: TArrayOfReal);
var
  EPS, SMLNUM, BIGNUM, ANRM, CSCALE, SCL, CS, SN, R: TReal;
  SCALEA: boolean;
  ILO, IHI, I, K, INFO, MAXWRK, MINWRK, HSWORK, LWORK_TREVC: longint;
  SCALE, TAU, WORK: TArrayOfReal;
begin
  VR := nil;
  SetLength(VR, N * N);
  WR := nil;
  WI := nil;
  if N = 0 then Exit;
  { The optimal work space of the workspace query (JOBVL = 'N',
    JOBVR = 'V'). }
  MAXWRK := 2 * N + N * ILAENVNB(32);
  MINWRK := 4 * N;
  MAXWRK := Max(MAXWRK, 2 * N + (N - 1) * ILAENVNB(32));
  HSWORK := HSEQRQUERY(N);
  MAXWRK := Max(MAXWRK, Max(N + 1, N + HSWORK));
  LWORK_TREVC := Max(1, N + 2 * N * ILAENVNB(64));
  MAXWRK := Max(MAXWRK, N + LWORK_TREVC);
  MAXWRK := Max(MAXWRK, 4 * N);
  MAXWRK := Max(MAXWRK, MINWRK);
  { Get machine constants. }
  EPS := LapackPrecision;
  SMLNUM := LapackSafeMinimum;
  BIGNUM := 1 / SMLNUM;
  SMLNUM := Sqrt(SMLNUM) / EPS;
  BIGNUM := 1 / SMLNUM;
  { Scale A if max element outside range [SMLNUM,BIGNUM]. }
  ANRM := specialize LANGE<TReal>('M', N, N, A, 0, N);
  SCALEA := False;
  CSCALE := 0;
  if (ANRM > 0) and (ANRM < SMLNUM) then
  begin
    SCALEA := True;
    CSCALE := SMLNUM;
  end else if ANRM > BIGNUM then
  begin
    SCALEA := True;
    CSCALE := BIGNUM;
  end;
  if SCALEA then specialize LASCLT<TReal>('G', ANRM, CSCALE, N, N, A, 0, N);
  { Balance the matrix. }
  DGEBAL(N, A, ILO, IHI, SCALE);
  { Reduce to upper Hessenberg form. }
  TAU := nil;
  SetLength(TAU, Max(N - 1, 0));
  specialize GEHRDB<TReal>(N, ILO, IHI, A, TAU, MAXWRK - 2 * N);
  { Want right eigenvectors: copy Householder vectors to VR and generate
    orthogonal matrix in VR. }
  for I := 0 to N * N - 1 do VR[I] := A[I];
  DORGHR(N, ILO, IHI, VR, TAU);
  { Perform QR iteration, accumulating Schur vectors in VR. }
  SetLength(WR, N);
  SetLength(WI, N);
  HSEQRD('S', 'V', N, ILO, IHI, A, WR, WI, VR, MAXWRK - N, INFO);
  if INFO > 0 then
    raise EInvalidOp.Create('DGEEV: QR iteration did not converge.');
  { Compute right eigenvectors. }
  DTREVC3(N, A, 0, N, VR, 0, N, MAXWRK - N);
  { Undo balancing. }
  DGEBAK(N, ILO, IHI, SCALE, N, VR);
  { Normalize right eigenvectors and make largest component real. }
  WORK := nil;
  SetLength(WORK, N);
  for I := 0 to N - 1 do
    if WI[I] = 0 then
    begin
      SCL := 1 / specialize NRM2<TReal>(N, VR, I, N);
      specialize SCAL<TReal>(N, SCL, VR, I, N);
    end else if WI[I] > 0 then
    begin
      SCL := 1 / DLAPY2(specialize NRM2<TReal>(N, VR, I, N),
        specialize NRM2<TReal>(N, VR, I + 1, N));
      specialize SCAL<TReal>(N, SCL, VR, I, N);
      specialize SCAL<TReal>(N, SCL, VR, I + 1, N);
      for K := 0 to N - 1 do
        WORK[K] := Sqr(VR[K * N + I]) + Sqr(VR[K * N + I + 1]);
      K := specialize IAMAX<TReal>(N, WORK, 0, 1);
      DLARTG(VR[K * N + I], VR[K * N + I + 1], CS, SN, R);
      for INFO := 0 to N - 1 do
        DROT(VR[INFO * N + I], VR[INFO * N + I + 1], CS, SN);
      VR[K * N + I + 1] := 0;
    end;
  { Undo scaling if necessary. }
  if SCALEA then
  begin
    specialize LASCLT<TReal>('G', CSCALE, ANRM, N, 1, WR, 0, 1);
    specialize LASCLT<TReal>('G', CSCALE, ANRM, N, 1, WI, 0, 1);
  end;
end;

procedure ZGEEV(N: longint; var A: TArrayOfComplex; out W: TArrayOfComplex;
  out VR: TArrayOfComplex);
var
  EPS, SMLNUM, BIGNUM, ANRM, CSCALE, SCL: TReal;
  SCALEA: boolean;
  ILO, IHI, I, K, INFO, MAXWRK, MINWRK, HSWORK, LWORK_TREVC: longint;
  SCALE, RWORK: TArrayOfReal;
  TAU: TArrayOfComplex;
  TMP: TComplex;
begin
  VR := nil;
  SetLength(VR, N * N);
  W := nil;
  if N = 0 then Exit;
  { The optimal work space of the workspace query (JOBVL = 'N',
    JOBVR = 'V'). }
  MAXWRK := N + N * ILAENVNB(32);
  MINWRK := 2 * N;
  MAXWRK := Max(MAXWRK, N + (N - 1) * ILAENVNB(32));
  LWORK_TREVC := Max(1, N + 2 * N * ILAENVNB(64));
  MAXWRK := Max(MAXWRK, N + LWORK_TREVC);
  HSWORK := HSEQRQUERY(N);
  MAXWRK := Max(MAXWRK, Max(HSWORK, MINWRK));
  { Get machine constants. }
  EPS := LapackPrecision;
  SMLNUM := LapackSafeMinimum;
  BIGNUM := 1 / SMLNUM;
  SMLNUM := Sqrt(SMLNUM) / EPS;
  BIGNUM := 1 / SMLNUM;
  { Scale A if max element outside range [SMLNUM,BIGNUM]. }
  ANRM := specialize LANGE<TComplex>('M', N, N, A, 0, N);
  SCALEA := False;
  CSCALE := 0;
  if (ANRM > 0) and (ANRM < SMLNUM) then
  begin
    SCALEA := True;
    CSCALE := SMLNUM;
  end else if ANRM > BIGNUM then
  begin
    SCALEA := True;
    CSCALE := BIGNUM;
  end;
  if SCALEA then
    specialize LASCLT<TComplex>('G', ANRM, CSCALE, N, N, A, 0, N);
  { Balance the matrix. }
  ZGEBAL(N, A, ILO, IHI, SCALE);
  { Reduce to upper Hessenberg form. }
  TAU := nil;
  SetLength(TAU, Max(N - 1, 0));
  specialize GEHRDB<TComplex>(N, ILO, IHI, A, TAU, MAXWRK - N);
  { Want right eigenvectors: copy Householder vectors to VR and generate
    unitary matrix in VR. }
  for I := 0 to N * N - 1 do VR[I] := A[I];
  ZUNGHR(N, ILO, IHI, VR, TAU);
  { Perform QR iteration, accumulating Schur vectors in VR. }
  SetLength(W, N);
  HSEQRZ('S', 'V', N, ILO, IHI, A, W, VR, MAXWRK, INFO);
  if INFO > 0 then
    raise EInvalidOp.Create('ZGEEV: QR iteration did not converge.');
  { Compute right eigenvectors. }
  ZTREVC3(N, A, 0, N, VR, 0, N, MAXWRK);
  { Undo balancing. }
  ZGEBAK(N, ILO, IHI, SCALE, N, VR);
  { Normalize right eigenvectors and make largest component real. }
  RWORK := nil;
  SetLength(RWORK, N);
  for I := 0 to N - 1 do
  begin
    SCL := 1 / specialize NRM2<TComplex>(N, VR, I, N);
    ZDSCAL(N, SCL, VR, I, N);
    for K := 0 to N - 1 do
      RWORK[K] := Sqr(VR[K * N + I].Re) + Sqr(VR[K * N + I].Im);
    K := specialize IAMAX<TReal>(N, RWORK, 0, 1);
    TMP := FDIV(CONJ(VR[K * N + I]), Sqrt(RWORK[K]));
    specialize SCAL<TComplex>(N, TMP, VR, I, N);
    VR[K * N + I] := MAKEREAL(VR[K * N + I]);
  end;
  { Undo scaling if necessary. }
  if SCALEA then
    specialize LASCLT<TComplex>('G', CSCALE, ANRM, N, 1, W, 0, 1);
end;

function DDOT(N: longint; const X: array of TReal; XO, INCX: longint;
  const Y: array of TReal; YO, INCY: longint): TReal;
begin
  result := specialize DOT<TReal>(False, N, X, XO, INCX, Y, YO, INCY);
end;

function ZDOTU(N: longint; const X: array of TComplex; XO, INCX: longint;
  const Y: array of TComplex; YO, INCY: longint): TComplex;
begin
  result := specialize DOT<TComplex>(False, N, X, XO, INCX, Y, YO, INCY);
end;

function ZDOTC(N: longint; const X: array of TComplex; XO, INCX: longint;
  const Y: array of TComplex; YO, INCY: longint): TComplex;
begin
  result := specialize DOT<TComplex>(True, N, X, XO, INCX, Y, YO, INCY);
end;

function DNRM2(N: longint; const X: array of TReal; XO, INCX: longint): TReal;
begin
  result := specialize NRM2<TReal>(N, X, XO, INCX);
end;

function DZNRM2(N: longint; const X: array of TComplex;
  XO, INCX: longint): TReal;
begin
  result := specialize NRM2<TComplex>(N, X, XO, INCX);
end;

procedure DGEMV(TRANS: char; M, N: longint; ALPHA: TReal;
  const A: array of TReal; AO, LDA: longint; const X: array of TReal;
  XO, INCX: longint; BETA: TReal; var Y: array of TReal; YO, INCY: longint);
begin
  specialize GEMV<TReal>(TRANS, M, N, ALPHA, A, AO, LDA, X, XO, INCX, BETA,
    Y, YO, INCY);
end;

procedure ZGEMV(TRANS: char; M, N: longint; const ALPHA: TComplex;
  const A: array of TComplex; AO, LDA: longint; const X: array of TComplex;
  XO, INCX: longint; const BETA: TComplex; var Y: array of TComplex;
  YO, INCY: longint);
begin
  specialize GEMV<TComplex>(TRANS, M, N, ALPHA, A, AO, LDA, X, XO, INCX, BETA,
    Y, YO, INCY);
end;

procedure DGEMM(TRANSA, TRANSB: char; M, N, K: longint; ALPHA: TReal;
  const A: array of TReal; AO, LDA: longint; const B: array of TReal;
  BO, LDB: longint; BETA: TReal; var C: array of TReal; CO, LDC: longint);
begin
  specialize GEMM<TReal>(TRANSA, TRANSB, M, N, K, ALPHA, A, AO, LDA, B, BO,
    LDB, BETA, C, CO, LDC);
end;

procedure ZGEMM(TRANSA, TRANSB: char; M, N, K: longint;
  const ALPHA: TComplex; const A: array of TComplex; AO, LDA: longint;
  const B: array of TComplex; BO, LDB: longint; const BETA: TComplex;
  var C: array of TComplex; CO, LDC: longint);
begin
  specialize GEMM<TComplex>(TRANSA, TRANSB, M, N, K, ALPHA, A, AO, LDA, B, BO,
    LDB, BETA, C, CO, LDC);
end;

procedure DTRSM(SIDE, UPLO, TRANSA, DIAG: char; M, N: longint; ALPHA: TReal;
  const A: array of TReal; AO, LDA: longint; var B: array of TReal;
  BO, LDB: longint);
begin
  specialize TRSM<TReal>(SIDE, UPLO, TRANSA, DIAG, M, N, ALPHA, A, AO, LDA,
    B, BO, LDB);
end;

procedure ZTRSM(SIDE, UPLO, TRANSA, DIAG: char; M, N: longint;
  const ALPHA: TComplex; const A: array of TComplex; AO, LDA: longint;
  var B: array of TComplex; BO, LDB: longint);
begin
  specialize TRSM<TComplex>(SIDE, UPLO, TRANSA, DIAG, M, N, ALPHA, A, AO, LDA,
    B, BO, LDB);
end;

procedure DTRMM(SIDE, UPLO, TRANSA, DIAG: char; M, N: longint; ALPHA: TReal;
  const A: array of TReal; AO, LDA: longint; var B: array of TReal;
  BO, LDB: longint);
begin
  specialize TRMM<TReal>(SIDE, UPLO, TRANSA, DIAG, M, N, ALPHA, A, AO, LDA,
    B, BO, LDB);
end;

procedure ZTRMM(SIDE, UPLO, TRANSA, DIAG: char; M, N: longint;
  const ALPHA: TComplex; const A: array of TComplex; AO, LDA: longint;
  var B: array of TComplex; BO, LDB: longint);
begin
  specialize TRMM<TComplex>(SIDE, UPLO, TRANSA, DIAG, M, N, ALPHA, A, AO, LDA,
    B, BO, LDB);
end;

function DLANGE(NORM: char; M, N: longint; const A: array of TReal;
  AO, LDA: longint): TReal;
begin
  result := specialize LANGE<TReal>(NORM, M, N, A, AO, LDA);
end;

function ZLANGE(NORM: char; M, N: longint; const A: array of TComplex;
  AO, LDA: longint): TReal;
begin
  result := specialize LANGE<TComplex>(NORM, M, N, A, AO, LDA);
end;

procedure DGETRF(M, N: longint; var A: array of TReal; AO, LDA: longint;
  var IPIV: array of longint; out INFO: longint);
begin
  specialize GETRF<TReal>(M, N, A, AO, LDA, IPIV, INFO);
end;

procedure ZGETRF(M, N: longint; var A: array of TComplex; AO, LDA: longint;
  var IPIV: array of longint; out INFO: longint);
begin
  specialize GETRF<TComplex>(M, N, A, AO, LDA, IPIV, INFO);
end;

procedure DGETRS(TRANS: char; N, NRHS: longint; const A: array of TReal;
  AO, LDA: longint; const IPIV: array of longint; var B: array of TReal;
  BO, LDB: longint);
begin
  specialize GETRS<TReal>(TRANS, N, NRHS, A, AO, LDA, IPIV, B, BO, LDB);
end;

procedure ZGETRS(TRANS: char; N, NRHS: longint; const A: array of TComplex;
  AO, LDA: longint; const IPIV: array of longint; var B: array of TComplex;
  BO, LDB: longint);
begin
  specialize GETRS<TComplex>(TRANS, N, NRHS, A, AO, LDA, IPIV, B, BO, LDB);
end;

procedure DGETRI(N: longint; var A: array of TReal; AO, LDA: longint;
  const IPIV: array of longint; out INFO: longint);
begin
  specialize GETRI<TReal>(N, A, AO, LDA, IPIV, INFO);
end;

procedure ZGETRI(N: longint; var A: array of TComplex; AO, LDA: longint;
  const IPIV: array of longint; out INFO: longint);
begin
  specialize GETRI<TComplex>(N, A, AO, LDA, IPIV, INFO);
end;

procedure DGECON(NORM: char; N: longint; const A: array of TReal;
  AO, LDA: longint; ANORM: TReal; out RCOND: TReal; out INFO: longint);
begin
  specialize GECON<TReal>(NORM, N, A, AO, LDA, ANORM, RCOND, INFO);
end;

procedure ZGECON(NORM: char; N: longint; const A: array of TComplex;
  AO, LDA: longint; ANORM: TReal; out RCOND: TReal; out INFO: longint);
begin
  specialize GECON<TComplex>(NORM, N, A, AO, LDA, ANORM, RCOND, INFO);
end;

function XDOT(N: longint; const X: array of TReal; XO, INCX: longint;
  const Y: array of TReal; YO, INCY: longint): TReal;
begin
  result := DDOT(N, X, XO, INCX, Y, YO, INCY);
end;

function XDOT(N: longint; const X: array of TComplex; XO, INCX: longint;
  const Y: array of TComplex; YO, INCY: longint): TComplex;
begin
  result := ZDOTU(N, X, XO, INCX, Y, YO, INCY);
end;

function XNRM2(N: longint; const X: array of TReal; XO, INCX: longint): TReal;
begin
  result := DNRM2(N, X, XO, INCX);
end;

function XNRM2(N: longint; const X: array of TComplex;
  XO, INCX: longint): TReal;
begin
  result := DZNRM2(N, X, XO, INCX);
end;

procedure XGEMV(TRANS: char; M, N: longint; const A: array of TReal;
  AO, LDA: longint; const X: array of TReal; XO, INCX: longint;
  var Y: array of TReal; YO, INCY: longint);
begin
  DGEMV(TRANS, M, N, 1, A, AO, LDA, X, XO, INCX, 0, Y, YO, INCY);
end;

procedure XGEMV(TRANS: char; M, N: longint; const A: array of TComplex;
  AO, LDA: longint; const X: array of TComplex; XO, INCX: longint;
  var Y: array of TComplex; YO, INCY: longint);
begin
  ZGEMV(TRANS, M, N, 1, A, AO, LDA, X, XO, INCX, 0, Y, YO, INCY);
end;

procedure XGEMM(TRANSA, TRANSB: char; M, N, K: longint;
  const A: array of TReal; AO, LDA: longint; const B: array of TReal;
  BO, LDB: longint; var C: array of TReal; CO, LDC: longint);
begin
  DGEMM(TRANSA, TRANSB, M, N, K, 1, A, AO, LDA, B, BO, LDB, 0, C, CO, LDC);
end;

procedure XGEMM(TRANSA, TRANSB: char; M, N, K: longint;
  const A: array of TComplex; AO, LDA: longint; const B: array of TComplex;
  BO, LDB: longint; var C: array of TComplex; CO, LDC: longint);
begin
  ZGEMM(TRANSA, TRANSB, M, N, K, 1, A, AO, LDA, B, BO, LDB, 0, C, CO, LDC);
end;

function XLANGE(NORM: char; M, N: longint; const A: array of TReal;
  AO, LDA: longint): TReal;
begin
  result := DLANGE(NORM, M, N, A, AO, LDA);
end;

function XLANGE(NORM: char; M, N: longint; const A: array of TComplex;
  AO, LDA: longint): TReal;
begin
  result := ZLANGE(NORM, M, N, A, AO, LDA);
end;

procedure XGETRF(N: longint; var A: array of TReal; var IPIV: array of longint;
  out INFO: longint);
begin
  DGETRF(N, N, A, 0, N, IPIV, INFO);
end;

procedure XGETRF(N: longint; var A: array of TComplex;
  var IPIV: array of longint; out INFO: longint);
begin
  ZGETRF(N, N, A, 0, N, IPIV, INFO);
end;

procedure XGETRS(TRANS: char; N, NRHS: longint; const A: array of TReal;
  const IPIV: array of longint; var B: array of TReal);
begin
  DGETRS(TRANS, N, NRHS, A, 0, N, IPIV, B, 0, NRHS);
end;

procedure XGETRS(TRANS: char; N, NRHS: longint; const A: array of TComplex;
  const IPIV: array of longint; var B: array of TComplex);
begin
  ZGETRS(TRANS, N, NRHS, A, 0, N, IPIV, B, 0, NRHS);
end;

procedure XGETRI(N: longint; var A: array of TReal;
  const IPIV: array of longint; out INFO: longint);
begin
  DGETRI(N, A, 0, N, IPIV, INFO);
end;

procedure XGETRI(N: longint; var A: array of TComplex;
  const IPIV: array of longint; out INFO: longint);
begin
  ZGETRI(N, A, 0, N, IPIV, INFO);
end;

procedure DSYEV(UPLO: char; N: longint; var A: array of TReal;
  AO, LDA: longint; var W: array of TReal; out INFO: longint);
begin
  specialize SYEV<TReal>(UPLO, N, A, AO, LDA, W, INFO);
end;

procedure ZHEEV(UPLO: char; N: longint; var A: array of TComplex;
  AO, LDA: longint; var W: array of TReal; out INFO: longint);
begin
  specialize SYEV<TComplex>(UPLO, N, A, AO, LDA, W, INFO);
end;

procedure DSYTRD(UPLO: char; N: longint; var A: array of TReal;
  AO, LDA: longint; var D, E: array of TReal; var TAU: array of TReal);
begin
  specialize SYTRD<TReal>(UPLO, N, A, AO, LDA, D, E, TAU);
end;

procedure ZHETRD(UPLO: char; N: longint; var A: array of TComplex;
  AO, LDA: longint; var D, E: array of TReal; var TAU: array of TComplex);
begin
  specialize SYTRD<TComplex>(UPLO, N, A, AO, LDA, D, E, TAU);
end;

procedure DORGTR(UPLO: char; N: longint; var A: array of TReal;
  AO, LDA: longint; const TAU: array of TReal);
begin
  specialize ORGTR<TReal>(UPLO, N, A, AO, LDA, TAU);
end;

procedure ZUNGTR(UPLO: char; N: longint; var A: array of TComplex;
  AO, LDA: longint; const TAU: array of TComplex);
begin
  specialize ORGTR<TComplex>(UPLO, N, A, AO, LDA, TAU);
end;

procedure DSTEQR(COMPZ: char; N: longint; var D, E: array of TReal;
  var Z: array of TReal; ZO, LDZ: longint; out INFO: longint);
begin
  specialize STEQR<TReal>(COMPZ, N, D, E, Z, ZO, LDZ, INFO);
end;

procedure ZSTEQR(COMPZ: char; N: longint; var D, E: array of TReal;
  var Z: array of TComplex; ZO, LDZ: longint; out INFO: longint);
begin
  specialize STEQR<TComplex>(COMPZ, N, D, E, Z, ZO, LDZ, INFO);
end;

procedure XSYEV(UPLO: char; N: longint; var A: array of TReal;
  var W: array of TReal; out INFO: longint);
begin
  DSYEV(UPLO, N, A, 0, N, W, INFO);
end;

procedure XSYEV(UPLO: char; N: longint; var A: array of TComplex;
  var W: array of TReal; out INFO: longint);
begin
  ZHEEV(UPLO, N, A, 0, N, W, INFO);
end;

procedure XGECON(N: longint; const A: array of TReal; ANORM: TReal;
  out RCOND: TReal; out INFO: longint);
begin
  DGECON('1', N, A, 0, N, ANORM, RCOND, INFO);
end;

procedure XGECON(N: longint; const A: array of TComplex; ANORM: TReal;
  out RCOND: TReal; out INFO: longint);
begin
  ZGECON('1', N, A, 0, N, ANORM, RCOND, INFO);
end;


{ xHSEQR with the optimal work space of the workspace query. }
procedure DHSEQR(JOB, COMPZ: char; N, ILO, IHI: longint; var H: array of TReal;
  var WR, WI: array of TReal; var Z: array of TReal; out INFO: longint);
begin
  HSEQRD(JOB, COMPZ, N, ILO, IHI, H, WR, WI, Z,
    Max(Max(1, N), LAQR04QUERY(N, ILO, IHI, True)), INFO);
end;

procedure ZHSEQR(JOB, COMPZ: char; N, ILO, IHI: longint;
  var H: array of TComplex; var W: array of TComplex; var Z: array of TComplex;
  out INFO: longint);
begin
  HSEQRZ(JOB, COMPZ, N, ILO, IHI, H, W, Z,
    Max(Max(1, N), LAQR04QUERY(N, ILO, IHI, True)), INFO);
end;

procedure ZLAQR0(WANTT, WANTZ: boolean; N, ILO, IHI: longint;
  var H: array of TComplex; HO, LDH: longint; var W: array of TComplex;
  WO, ILOZ, IHIZ: longint; var Z: array of TComplex; ZO, LDZ: longint;
  out INFO: longint);
begin
  ZLAQR04(True, WANTT, WANTZ, N, ILO, IHI, H, HO, LDH, W, WO, ILOZ, IHIZ, Z,
    ZO, LDZ, LAQR04QUERY(N, ILO, IHI, True), INFO);
end;

procedure ZLAQR3(WANTT, WANTZ: boolean; N, KTOP, KBOT, NW: longint;
  var H: array of TComplex; HO, LDH, ILOZ, IHIZ: longint;
  var Z: array of TComplex; ZO, LDZ: longint; out NS, ND: longint;
  var SH: array of TComplex; SO: longint);
begin
  ZLAQR23(True, WANTT, WANTZ, N, KTOP, KBOT, NW, H, HO, LDH, ILOZ, IHIZ, Z,
    ZO, LDZ, NS, ND, SH, SO, LAQR23QUERY(N, KTOP, KBOT, NW, True));
end;

procedure DLAQR0(WANTT, WANTZ: boolean; N, ILO, IHI: longint;
  var H: array of TReal; HO, LDH: longint; var WR, WI: array of TReal;
  WO, ILOZ, IHIZ: longint; var Z: array of TReal; ZO, LDZ: longint;
  out INFO: longint);
begin
  DLAQR04(True, WANTT, WANTZ, N, ILO, IHI, H, HO, LDH, WR, WI, WO, ILOZ,
    IHIZ, Z, ZO, LDZ, LAQR04QUERY(N, ILO, IHI, True), INFO);
end;

procedure DLAQR3(WANTT, WANTZ: boolean; N, KTOP, KBOT, NW: longint;
  var H: array of TReal; HO, LDH, ILOZ, IHIZ: longint; var Z: array of TReal;
  ZO, LDZ: longint; out NS, ND: longint; var SR, SI: array of TReal;
  SO: longint);
begin
  DLAQR23(True, WANTT, WANTZ, N, KTOP, KBOT, NW, H, HO, LDH, ILOZ, IHIZ, Z,
    ZO, LDZ, NS, ND, SR, SI, SO, LAQR23QUERY(N, KTOP, KBOT, NW, True));
end;

end.
