# ADimMath validation suite

This document describes how `adimmath.pas` is validated: what is checked,
which measures and thresholds are used and where they come from, which
inputs are exercised, and how the suite itself was validated.

## Running the suite

From the repository root:

```sh
lazbuild tests/test.lpi    # range, overflow and stack checks, heaptrc
./build/test               # quick run (about 30 s)
```

or with Free Pascal alone (3.2.2 or later):

```sh
fpc -Mobjfpc -O2 -Fu. -Futests -FEbuild tests/test.lpr
```

Options:

| Option | Effect |
|---|---|
| `-v` | print every check |
| `--extended` | larger orders and stress inputs |
| `--perf` | timing-based performance checks (see below) |
| `--filter=TEXT` | run only the specs whose name contains `TEXT` |
| `--list` | list the specs |

The exit code is 0 when every check passes, 1 when any check fails.
GitHub Actions builds and runs the suite on every push to `main`
(`.github/workflows/linux.yml`).

## Structure

| File | Role |
|---|---|
| `tests/test.lpr`, `tests/test.lpi` | program and Lazarus project; the order of the `Spec*` units is the run order |
| `tests/testrunner.pas` | specs, groups, checks, report, exit code |
| `tests/testdoubledouble.pas` | double-double arithmetic (reference oracle) |
| `tests/testgenerators.pas` | deterministic input generators |
| `tests/testmeasures.pas` | norms and LAPACK-style ratios |
| `tests/spec*.pas` | one specification per area of the public API, and `speclapack*.pas` for the routines of the internal LAPACK layer, tested as the LAPACK test programs test them |

A *spec* covers one area of the API. Its checks are organised in *groups*,
and every group declares the kind of property it verifies:

| Kind | Meaning |
|---|---|
| CONTRACT | documented behaviour: sizes, ordering, exceptions, formatting |
| EXACT | results that must be bit-for-bit (or exactly) equal |
| ACCURACY | forward error against a reference, scaled by the condition |
| STABILITY | backward error (residual) ratios |
| PROPERTY | invariants: rank, orthogonality, idempotence |
| PERFORMANCE | complexity and relative cost (`--perf` only) |

Every numerical ratio passes when it is finite and below a threshold, and
each group states the source of its threshold:

| Source | Meaning |
|---|---|
| proved bound | a published error bound for the algorithm in use |
| LAPACK | the threshold of the corresponding LAPACK test program |
| project | defined here, with the rationale stated in the group |

A project threshold is never presented as a LAPACK or proved one.

### Reference values

Residuals and reference results are computed with independent loops in
double-double arithmetic (about 106 bits), never with the ADimMath
operators under test. `Extended` is not used: it is an alias of `Double`
on Win64 and other targets, so it is not a higher-precision oracle there.
On i386 the runner sets the x87 precision control to binary64, which the
double-double algorithms require.

### Generators

All random inputs come from SplitMix64 with an explicit seed per group, so
every case is reproducible on every platform. The matrix generators follow
LAPACK:

- `GenerateRealMatrix`, `GenerateComplexMatrix`, `RealMatrixWithSigma`
  (xLATMS): `U * diag(sigma) * V^H` with Haar-like random orthogonal or
  unitary `U`, `V` and singular-value modes "one large", "one small",
  geometric, arithmetic and random-log, with a prescribed condition number;
- `SymmetricWithSpectrum`, `HermitianWithSpectrum`: prescribed spectra;
- `GeneralWithSpectrum` (xLATME): `X * D * inv(X)` with `cond_2(X)`
  prescribed, also returning the eigenvalue condition numbers;
- classical matrices: Jordan, cyclic permutation, Grcar, Frank, Kahan,
  Hilbert, companion, Wilkinson and 1D Laplacian tridiagonals.

## Measures and thresholds

`eps = 2^-53` (LAPACK `DLAMCH('E')`), `ulp = 2^-52` (`DLAMCH('P')`),
`u = eps`, `gamma(n) = n*u/(1 - n*u)`.

| Area | Measure | Threshold | Source |
|---|---|---|---|
| complex `*` | `|fl(x*y) - x*y| / (u |x*y|)` | sqrt(5) | proved (Brent, Percival, Zimmermann 2007) |
| complex `1/z`, `/` | normwise relative error / u | 8, 10 | project (first-order bound about 5u for the robust Smith formula, Baudin and Smith 2012) |
| `SquareRoot` | relative error of **each component** / u | 8 | project (first-order estimate 5.5u; Kahan 1987) |
| `CubicRoot`, `QuarticRoot` | `|r^k - z| / (k |z| u)` | 8 | project |
| powers | normwise error / ((k-1) sqrt(5) u) | 1 | proved (composition of the product bound) |
| `Dot`, matrix products | `|computed - s| / (ulp sum|x_k||y_k|)` per entry (`|re|+|im|` for complex), as xMVCH and xMMCH | 16 | reference BLAS tests (`dblat2.in`, `dblat3.in`) |
| `Norm` | relative error / gamma(n+2) | 1 | project (summation bound) |
| `SolveLinear` | DGET02 / ZGET02 | 30 | LAPACK `dtest.in`, `ztest.in` |
| `SolveLinear` | DGET04 (2-norm, exact `cond_2` from the generator) | 30 | LAPACK |
| `Inverse` | DGET03 / ZGET03 | 30 | LAPACK |
| `Determinant` | `|ln|det| - ln prod sigma| / (n cond_2 eps)` | 20 | project |
| symmetric / Hermitian | ZHET21, ZUNT01 | 50 | LAPACK `sep.in` |
| symmetric / Hermitian | `|lambda_i - lambda_i(true)| / (n ||A||_2 ulp)` | 20 | project (Weyl) |
| general `Eigenpairs` | ZGET22 | 20 | LAPACK `nep.in` |
| LAPACK layer xGETRF, xGETRS, xGETRI, xGECON | xCHKGE tests (1)-(4), (8): xGET01, xGET03, xGET02, xGET04, xGET06 | 30 | LAPACK `dtest.in`, `ztest.in` |
| LAPACK layer xGEHRD, xORGHR, xHSEQR, xTREVC3, xGEEV | xCHKHS tests (1)-(9): xHST01, xORT01, xGET10, eigenvalue difference, ZGET22; xDRVEV tests (1), (3) | 20 | LAPACK `nep.in` |
| LAPACK layer xSYTRD, xORGTR, xSTEQR, xSYEV, DSTEBZ, DSTEIN, DSTEVX | xCHKST tests (1)-(4), (9), (10), (18)-(21): xSYT21, xSTT21, DSXT1; xDRVST: xSYT21, DSTT21, DSTT22 | 50 | LAPACK `sep.in` |
| LAPACK layer xGEBRD, DBDSQR, xGESVD | xCHKBD tests (1)-(3), (8), (10): xBDT01, xORT01, DSVDCH; xDRVBD test (4) | 50 | LAPACK `svd.in` |
| general `Eigenpairs` | `|lambda_i - lambda_i(true)| / (n kappa_i ||A||_F ulp)` | 20 | project (first-order perturbation) |
| tridiagonal partial | ZSTT22, ZUNT01 | 50 | LAPACK `sep.in` |

### Singular to working precision

`SolveLinear` and `Inverse` estimate the reciprocal condition number in
the 1-norm from the LU factors (Hager-Higham estimator, LAPACK xGECON) and
raise `EZeroDivide` when it is below `u`, as LAPACK xGESVX reports
`INFO = N+1`. The estimate of `||inv(A)||_1` never exceeds the true value,
so:

- a matrix with `n cond_2(A) u < 1`, hence `cond_1(A) < 1/u`, never
  raises; the checks require this;
- for the xCHKGE class `cond = 0.1/eps` at larger orders, where
  `cond_1(A)` may exceed `1/u`, the exception is accepted in place of the
  residual, forward-error and inverse checks (in the current run only at
  n = 32);
- matrices with `cond_2 = 1e20` and exactly singular integer matrices,
  where rounding leaves a tiny nonzero pivot, must raise.

Against SciPy (`scipy.linalg.solve`, which warns when the `dgecon`
estimate is below eps) on 200 systems of order 10, `SolveLinear` raised on
exactly the 100 systems where SciPy warned or failed, and on no other.

### Products

`Dot`, the matrix products and the matrix-vector products are DDOT,
ZDOTU, xGEMM and xGEMV of the reference BLAS, which add the products in
order. They are checked as the test programs of the reference BLAS
check every computed entry (xMVCH, xMMCH): the error divided by
`ulp sum |x_k| |y_k|` must stay below 16. The exact sum is formed in
double-double.

## Coverage

| Spec | Functions | Input classes |
|---|---|---|
| Complex scalars | `TComplex` operators, `Reciprocal`, `Arg`, `Norm`, `ToString`, `TImaginaryUnit`, `IsNull`, `SameValue` | scales 1e-300..1e300, operands near overflow and subnormal, cancellation, signed zeros |
| Scalar roots and powers | `SquareRoot`, `CubicRoot`, `QuarticRoot`, `SquarePower`..`QuarticPower` | every quadrant, unbalanced components, near overflow/underflow, subnormals |
| Vectors | construction, elementwise operations, `Dot`, `Norm`, `Normalize`, `Reciprocal`, `Cross`, `Conjugate` | lengths 1..1000, cancellation, components dominated by different elements, non-finite inputs |
| Matrices | construction, elementwise operations, transposes, products, `Norm`, `Trace`, predicates | orders 1..40, scales 1e-100..1e100, cancelling rows |
| Linear systems | `SolveLinear`, `Inverse`, `Determinant`, `Rank` | xCHKGE classes: diagonal, triangular, cond 2, sqrt(1/eps), 0.1/eps, scaled 1e-290 and 1e290, zero columns; singular to working precision (cond 1e20, exactly singular integer matrices) and well conditioned (cond 1e12); prescribed rank at scales 1e-200..1e200 |
| Symmetric and Hermitian eigenpairs | `SymmetricEigenpairs`, `HermitianEigenpairs` | zero, identity, arithmetic, geometric cond 1/eps and sqrt(1/eps), one large/small, mixed signs, repeated, scaled 1e-290 and 1e290, Wilkinson, Hilbert, Laplacian |
| General eigenpairs | `Eigenpairs` (real and complex) | prescribed spectra with cond(X) 1, 1e3, 1e6; graded similarities D*A*D^-1 with D = diag(g^i), g up to 1e8 (balancing); permuted triangular; random; scaled; cyclic permutations; Jordan; Grcar; Frank; Kahan; companion; graded; triangular; Hermitian path; real input (real Schur solver): prescribed spectra with real eigenvalues and conjugate pairs, graded similarities, permuted triangular, eigenpairs exactly real or in exactly conjugate pairs |
| LAPACK layer: LU factorization | xGETRF (xGETRF2), xGETRS, xGETRI (xTRTRI), xGECON (xLACN2, xLATRS), real and complex | the 11 matrix types of xCHKGE (diagonal, triangular, cond 2, zero first/last/trailing columns, cond sqrt(0.1/eps) and 0.1/eps, scaled near underflow and overflow); dtest.in orders 0-50, also rectangular, 1, 2 and 15 right-hand sides, TRANS N/T/C, block sizes 1, 3 and 20 (64, 65 and 100 with the default block size with `--extended`) |
| LAPACK layer: Hessenberg QR | xGEHRD, xORGHR, xHSEQR (xLAHQR, xLAQR0..5, xTREXC), xTREVC3, xGEEV (tests (1) and (3) of xDRVEV), real and complex | the 21 matrix types of xCHKHS (zero, identity, Jordan, diagonal with modes 4/3/1, scaled near overflow and underflow, U^T T U and X^-1 T X with cond(X) = 1/sqrt(ulp), real and complex-pair spectra, random); nep.in orders 0-16 with its five tuning sets (NMIN, NWIN, NIBBLE, NSHFTS, KACC22), orders 20 and 80 with the default tuning (40, 80 and 150 with `--extended`) |
| LAPACK layer: symmetric eigenproblem | xSYTRD/xHETRD (xLATRD, xSYTD2), xORGTR/xUNGTR (xORGQR, xORGQL), xSTEQR, xSYEV/xHEEV, DSTEBZ, DSTEIN, DSTEVX | the matrix types 1-8 and 10-21 of xCHKST (zero, identity, diagonal and U^T D U with modes 4/3/1, scaled near overflow and underflow, random, positive definite, diagonally dominant tridiagonal); sep.in orders 0-20 with its five block sizes and crossover points, order 40 with the default ones (100 and 140 with `--extended`); UPLO U and L; DSTEBZ with RANGE A, I, V; DSTEVX with RANGE A, I, V |
| LAPACK layer: singular values | xGEBRD (xLABRD, xGEBD2), DBDSQR without vectors (DLASQ1..DLASQ6, DLASV2, DLAS2, DLASRT), xGESVD with JOBU = JOBVT = 'N', real and complex | the 16 matrix types of xCHKBD (zero, identity, diagonal and U D V^T with modes 4/3/1, scaled near overflow and underflow, random, random bidiagonal with entries 1e-32..1e32); the (M, N) pairs of svd.in with M >= N (and M < N for the lower bidiagonal) with its five block sizes and crossover points, 40 x 40 with the default ones (140 x 140 and 200 x 160 with `--extended`) |
| Tridiagonal lowest eigenpairs | `TridiagonalLowestEigenpairs`, `HermitianTridiagonalLowestEigenpairs` | Laplacian (analytic), Wilkinson, random, graded, disconnected, zero; complex phases |
| Performance | products, `SolveLinear`, `Inverse`, all eigen solvers | complexity T(128)/T(64); cost relative to a plain triple loop |

### Performance checks

Wall-clock times depend on the machine, so `--perf` checks two
machine-independent quantities. **Complexity** is `T(2n)/T(n)`, about 8
for an O(n^3) algorithm; the limit 12 rejects O(n^4) behaviour (16). The
orders are 64 and 128: smaller operands fit in the L1 cache and make the
ratio overstate the growth. **Relative cost** is the time of an operation
divided by the time of a plain triple-loop product of the same order,
measured in the same run; the budgets are about three times the ratios of
the current implementation. Each time is the median of three runs lasting
at least 40 ms. These checks are not part of the default run because
shared CI machines make timings noisy.

## The internal LAPACK layer

The products, the norms, the linear system solvers and the eigenvalue
solvers are built on an internal LAPACK layer, the unit
`adimlapack.pas`: translations of the reference BLAS and of LAPACK 3.12.1
with the names, arguments and results of the originals, 0-based indices
and matrices stored by rows. It contains:

- BLAS: xDOT, xNRM2, xASUM, xAXPY, xSCAL, xSWAP, IxAMAX, xGEMV, xGER,
  xSYMV/xHEMV, xSYR2/xHER2, xTRMV, xTRSV, xGEMM, xSYR2K/xHER2K, xTRMM,
  xTRSM;
- linear systems: xGETRF (blocked, with the recursive xGETRF2), xGETRS,
  xGETRI (with xTRTRI, xTRTI2), xGECON (with xLACN2, xLATRS, xRSCL),
  xLANGE (with xLASSQ);
- symmetric and Hermitian eigenproblem: xSYEV/xHEEV with xSYTRD/xHETRD
  (blocked, xLATRD, xSYTD2), xORGTR/xUNGTR (xORGQR, xORGQL, blocked with
  xLARFT and xLARFB), xSTEQR; DSTEVX with DSTEBZ (DLAEBZ) and DSTEIN
  (DLAGTF, DLAGTS, DLARNV);
- general eigenproblem: xGEEV with xGEBAL, xGEHRD (blocked, xLAHR2),
  xORGHR, xHSEQR with xLAHQR and the multishift QR xLAQR0..xLAQR5 (with
  the blocked xORMQR), xTREXC, DLANV2, xTREVC3 (DLALN2, ZLATRS),
  xGEBAK;
- singular values: xGESVD with JOBU = JOBVT = 'N' for square matrices,
  with xGEBRD (blocked, xLABRD, xGEBD2) and DBDSQR without singular
  vectors (the dqds algorithm DLASQ1..DLASQ6 with DLASRT, and the
  implicit QR with DLASV2 and DLAS2 when dqds fails).

`Dot`, `Norm` and the products call xDOT, xNRM2, xLANGE, xGEMV and
xGEMM; `SolveLinear` calls xGETRF, xGECON (raising when the reciprocal
condition number is below 2^-53, as INFO = N+1 in xGESVX) and xGETRS;
`Inverse` calls xGETRF, xGECON and xGETRI; `Determinant` calls xGETRF;
`SymmetricEigenpairs` and `HermitianEigenpairs` call xSYEV and xHEEV on
the lower triangle; `TridiagonalLowestEigenpairs` calls DSTEVX for the
lowest eigenvalues with the absolute tolerance 2*safe minimum;
`Eigenpairs` calls xGEEV; `Rank` counts the singular values of xGESVD
above S_max*n*2^-52, the default tolerance of `numpy.linalg.matrix_rank`.

The routines of the layer are tested as LAPACK tests them, by the specs
`LAPACK layer: LU factorization (xCHKGE)` (`tests/speclapackge.pas`),
`LAPACK layer: Hessenberg QR (xCHKHS)` (`tests/speclapackhseqr.pas`,
with the tests of xDRVEV for xGEEV) and `LAPACK layer: symmetric
eigenproblem (xCHKST, xDRVST)` (`tests/speclapacksyev.pas`) and
`LAPACK layer: singular values (xCHKBD, xDRVBD)`
(`tests/speclapacksvd.pas`): the matrix types, the test ratios and
thresholds and the input files (`dtest.in`, `nep.in`, `sep.in`, `svd.in`)
of the LAPACK test programs. Like XLAENV and the
ILAENV of those programs, `LapackBlockSize` and `LapackCrossover` set the
block sizes and crossover points and `LapackTuning` the parameters of
xHSEQR, so that the blocked code and xLAQR0 run on small matrices. The
tests that need routines the layer does not provide (the iterative
refinement xGERFS, the eigenvalues without eigenvectors of xSTERF and
xSTEQR with COMPZ = 'N', the left eigenvectors of xGEEV, the singular
vectors of xBDSQR and xGESVD) are not run. Test (10) of xCHKBD, the
check of the singular values of DBDSQR against Sturm counts with DSVDCH,
is run as xCHKBD documents it; the code of xCHKBD 3.12.1 no longer calls
DSVDCH.

The translations reproduce the reference LAPACK 3.12.1 and BLAS, as
compiled by gfortran, bit for bit; this was verified on random and
difficult inputs (scaled near underflow and overflow, graded, singular,
clustered, with signed zeros), with the default block sizes and with
small ones, at `-O1` with range checks and at `-O2`. gfortran takes
|z|, the complex square root and log from the C library; the layer
contains translations of the functions of glibc 2.43 (`hypot`, `csqrt`
and the `log` that glibc selects on processors with FMA, whose FMAs are
emulated exactly), identical to them on every argument tried, so that
the complex routines are bit-identical to the reference on Linux without
calling the C library. The work
spaces are those of the LAPACK workspace queries: xGEEV passes on its
optimal work space as LAPACK does, and the block sizes of xGEHRD,
xTREVC3 and of the xGEHRD and xORMQR called by xLAQR3 are derived from
it in the same way.

A literal translation was not enough for bit identity:

- the order of the operations of the reference BLAS, including the quick
  returns of xSCAL (factor one) and xAXPY (factor zero) and the tests for
  zero entries in xTRSM, xTRMM, xTRMV, xTRSV and xGER, which keep the
  signs of zeros;
- gfortran's mixed real-complex arithmetic (a real operand becomes
  (r, +0) and the full complex operation is performed) and Smith's
  complex division as GCC expands it;
- typed real constants: Free Pascal evaluates expressions with untyped
  real constants, and divisions of two integers, in the 80-bit Extended
  type on x86_64;
- typed arguments of `Math.Min` and `Math.Max`: with an integer literal
  and a Double argument Free Pascal 3.2.3 selects the Single overload
  (`Max(x, 1)` overflows for x = 1e300).
- unsigned wrap-around in the bit manipulations of glibc: Free Pascal
  evaluates `longword - constant` in Int64, so `TOP - $10 >= $7FE0` is
  false for TOP = 0 unless the difference is cast back to `longword`;
  hexadecimal literals above 2^63 are Int64 constants, so the tables of
  bit patterns are declared `Int64`.

`adimlapack.pas` is compiled with `{$OPTIMIZATION NOREGVAR}`: with
register variables (-O2) Free Pascal 3.2.3 loads the index and the
address of an open array element into the same register and the access
fails. With the operation order of the reference BLAS every entry of the
LU factors receives the same sequence of operations whatever the
blocking, so xGETRF gives the same bits for every block size.

## Validation of the suite

A suite that passes on the code it was written for proves little. This
suite was also run against the implementation it replaced (commit
`f75c37b`), and every defect known in that implementation is detected:

| Defect in `f75c37b` | Detected by | Evidence |
|---|---|---|
| `SquareRoot` loses the smaller component | roots: componentwise accuracy | 124 failures, worst ratio 9e15 |
| `SquareRoot` overflows when \|z\| exceeds MaxDouble | roots: componentwise accuracy | section aborted (EOverflow) |
| `CubicRoot` loses accuracy at large and small moduli (`Power(x, 1/3)`) | roots: backward error | 240 failures, worst 59 |
| Neumaier branch chosen by complex modulus | vectors: Dot; matrices: products (then the Sum2 bound of Ogita, Rump and Oishi) | worst ratios 9e14 and 1e4 |
| `ToString` prints small values as 0 | complex scalars: ToString | 3 failures |
| `Rank` misjudged by partial pivoting | linear systems: prescribed rank | 3 failures (about 0.7% of random rank-deficient matrices) |
| general `Eigenpairs` silent non-convergence | general eigenpairs: classical matrices | cyclic permutation, ratio 4.5e15 |
| general `Eigenpairs` inaccurate for non-normal matrices | general eigenpairs: prescribed spectra | 25 failures, worst 1.8e5 |
| eigenvector normalization leaves a rounding imaginary part | general eigenpairs: contract | 13 failures |
| general `Eigenpairs` O(n^4) cost | performance: relative cost and complexity | relative cost 10450 at n = 64 (budget 225); T(2n)/T(n) 14-16 measured over n = 50, 100, 200 |
| complex products about 10 times slower than real ones | performance: relative cost | 86 at n = 128 (budget 30) |
| Hermitian eigenpairs: final dense product, strided rotations | performance: relative cost | 105 at n = 128 (budget 60) |
| tridiagonal partial solver with one fixed shift | performance: relative cost | 122 s for order 3200 (current: 12 ms); slow convergence falls back to the dense O(N^3) solver |

Not detected: the symmetric real solver's constant-factor slowdown
(relative cost 14.5 against 8.5 at n = 128) is below the three-times budget
margin; a tighter budget would make the check depend on the machine.

With the original implementation `--perf` does not finish in reasonable
time: the tridiagonal case of order 6400 alone would take well over a
quarter of an hour. The figures above were measured with single timed
calls.

Defects found later, in the implementation validated above (commit
`e17c34e`), and the checks added for them:

| Defect in `e17c34e` | Detected by | Evidence |
|---|---|---|
| complex `/` computed as `x * (1/y)`: spurious overflow and underflow | complex scalars: reciprocal and division near the ends of the range | `1e308/(1e308+1e308i)` gave 0; section aborted (EUnderflow) |
| general `Eigenpairs` without balancing | general eigenpairs: graded similarity, permuted triangular | 25 failures, worst ratio 3.5e46; 11 failures |
| `SolveLinear` and `Inverse` return results without correct digits, silently, for matrices singular to working precision | linear systems: singular to working precision | 27 failures |
| real `Eigenpairs` leaves rounding residues in the real structure (imaginary parts of real eigenvalues, pairs not exactly conjugate) | general eigenpairs: real input structure | 33 failures out of 45 |

The specs of the LAPACK layer were checked against defects introduced on
purpose. In xLAQR5, an off-by-one in the rows of the accumulated
reflections (`I2 := Max(I2, KMS + 2 - (KRCOL - INCOL))`, an error made
and found during the port) makes tests (3) to (6) of xCHKHS fail for 42
real and 42 complex matrices, with ratios up to 6e15. In xGETRS, solving
with U^T instead of U^H makes tests (3) and (4) of ZCHKGE fail for 144
cases (ratios up to 2e16); in the blocked xGETRI, an offset of one row in
the block of L makes test (2) fail for 24 real and 24 complex matrices
(ratios up to 9e14). In DLASQ3, a perturbed deflation of a 2 x 2 block
makes test (10) of xCHKBD fail for 192 real and 208 complex cases; in
ZLABRD, a missing conjugation of the current row makes test (1) of
ZCHKBD fail for 168 cases (ratios up to 6e14).

To repeat the validation against another `adimmath.pas`, compile the suite
from a directory that does not contain the current source, because Free
Pascal searches the current directory before `-Fu`:

```sh
REPO=$(pwd)
WORK=$(mktemp -d)
git show f75c37b:adimmath.pas > "$WORK/adimmath.pas"
cd "$WORK" && fpc -Mobjfpc -O2 -Fu. -Fu"$REPO/tests" -FE. "$REPO/tests/test.lpr"
./test            # add --perf for the performance checks
```

## Lessons from the previous suite

The previous suite used LAPACK's residual formulas but not LAPACK's testing
method, and several defects passed because of that:

1. **Residuals on benign inputs only.** Square roots were tested only at
   `(0.75, -1.25) * scale`, with both components of the same size. Here
   every function is
   tested on generated input classes, including unbalanced components,
   cancellation, mixed magnitudes and the extremes of the range.
2. **Bounds wider than the algorithm's guarantee.** The naive summation
   bound accepted a broken compensated sum. Each check now uses the
   strongest bound that the algorithm actually guarantees.
3. **A reference that was not more precise.** `Extended` is `Double` on
   Win64. The oracle is now double-double on every target.
4. **No forward error relative to the condition.** Solvers are checked
   against generated problems with known condition and known solutions
   (DGET04, eigenvalue condition numbers, Weyl), not only residuals.
5. **Tolerances not derived from the measure.** One check required an
   absolute error of 2.2e-16 on an eigenvalue of modulus 2.2, which is
   below one ulp of the value. Thresholds are now stated with their source.
6. **No performance checks.** An O(n^4) eigensolver passed every test.

## Writing new checks

- Choose the kind of property first, then a measure from
  `tests/testmeasures.pas` or a new one with its reference.
- State the threshold source in the `Group` call; prefer a proved bound or
  the LAPACK threshold of the matching test.
- Use the generators with an explicit seed; never build references with
  the operators under test.
- Make sure the check fails on a known-bad implementation (for example
  the commit above) before relying on it.
- In generator code, copy array parameters into local dynamic arrays
  before filling a matrix in a loop: with FPC 3.2.3 at `-O2`, reading an
  open-array parameter in such a loop raised access violations.

## References

- E. Anderson et al., *LAPACK Users' Guide*, 3rd ed., SIAM, 1999, and the
  LAPACK test programs: [DGET02](https://www.netlib.org/lapack/explore-html/d0/d5c/_e_i_g_2dget02_8f_source.html),
  [ZGET22](https://www.netlib.org/lapack/explore-html/da/d62/zget22_8f_source.html),
  [ZHET21](https://www.netlib.org/lapack/explore-html/d8/ddb/zhet21_8f_source.html),
  [ZSTT22](https://www.netlib.org/lapack/explore-html/d7/dd3/zstt22_8f_a323b347b0b568a958ad2e4acdf1.html),
  [dtest.in](https://www.netlib.org/lapack/testing/dtest.in),
  [ztest.in](https://www.netlib.org/lapack/testing/ztest.in),
  [sep.in](https://www.netlib.org/lapack/testing/sep.in),
  [nep.in](https://www.netlib.org/lapack/testing/nep.in).
- N. J. Higham, *Accuracy and Stability of Numerical Algorithms*, 2nd ed.,
  SIAM, 2002.
- R. P. Brent, C. Percival, P. Zimmermann, "Error bounds on complex
  floating-point multiplication", *Math. Comp.* 76 (2007).
- T. Ogita, S. M. Rump, S. Oishi, "Accurate sum and dot product", *SIAM J.
  Sci. Comput.* 26 (2005).
- W. Kahan, "Branch cuts for complex elementary functions", in *The State
  of the Art in Numerical Analysis*, 1987.
- T. J. Dekker, "A floating-point technique for extending the available
  precision", *Numer. Math.* 18 (1971).
