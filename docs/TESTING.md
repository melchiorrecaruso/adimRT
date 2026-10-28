# ADimMath validation suite

This document describes how `adimmath.pas` is validated: what is checked,
which measures and thresholds are used and where they come from, which
inputs are exercised, and how the suite itself was validated.

## Running the suite

From the repository root:

```sh
lazbuild test.lpi          # range, overflow and stack checks, heaptrc
./build/test               # quick run (about 5 s)
```

or with Free Pascal alone (3.2.2 or later):

```sh
fpc -Mobjfpc -O2 -Fu. -Futests -FEbuild test.lpr
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
| `test.lpr` | program; the order of the `Spec*` units is the run order |
| `tests/testrunner.pas` | specs, groups, checks, report, exit code |
| `tests/testdoubledouble.pas` | double-double arithmetic (reference oracle) |
| `tests/testgenerators.pas` | deterministic input generators |
| `tests/testmeasures.pas` | norms and LAPACK-style ratios |
| `tests/spec*.pas` | one specification per area of the public API |

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
  Hilbert, companion, Wilkinson and 1D Laplacian tridiagonals;
- `CoefficientsFromRoots`: monic coefficients from a root multiset,
  formed in double-double and rounded once.

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
| `SolveEquation` | `|r_computed - r| / delta`, see below | 20 | project |
| `Dot`, matrix products | `|computed - s| / (u|s| + gamma(n-1)^2 sum|p_i|)`, per component | 1 | proved (Ogita, Rump, Oishi 2005, Prop. 4.5) |
| `Norm` | relative error / gamma(n+2) | 1 | project (summation bound) |
| `SolveLinear` | DGET02 / ZGET02 | 30 | LAPACK `dtest.in`, `ztest.in` |
| `SolveLinear` | DGET04 (2-norm, exact `cond_2` from the generator) | 30 | LAPACK |
| `Inverse` | DGET03 / ZGET03 | 30 | LAPACK |
| `Determinant` | `|ln|det| - ln prod sigma| / (n cond_2 eps)` | 20 | project |
| symmetric / Hermitian | ZHET21, ZUNT01 | 50 | LAPACK `sep.in` |
| symmetric / Hermitian | `|lambda_i - lambda_i(true)| / (n ||A||_2 ulp)` | 20 | project (Weyl) |
| general `Eigenpairs` | ZGET22 | 20 | LAPACK `nep.in` |
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

### Polynomial roots

Each case starts from a known multiset of roots. The computed roots are
matched to the true ones as a multiset, taking the best of all
permutations, so returning one root several times cannot pass. With
`p(x) = sum c_k x^(n-k)`, `S(r) = sum |c_k| |r|^(n-k)` and `t_m` the m-th
Taylor coefficient of `p` at a root of multiplicity `m`, a relative
perturbation `e` of the coefficients moves the root by about

```text
delta = (e * S(r) / |t_m|)^(1/m),   e = 2 n u
```

(Wilkinson 1963; Gautschi 1973). For an exact zero root `S(r) = 0`, and the
error is measured relative to the largest root modulus. Cases whose
coefficients would leave the normal floating-point range are skipped,
because the rounded polynomial no longer has the prescribed roots.

### Why the sum-of-products bound matters

`Dot` and the matrix products add the rounded products with Neumaier's
compensated summation (algorithm Sum2). Its proved bound is
`u|s| + gamma(n-1)^2 sum|p_i|`. The naive-summation bound
`gamma(n) sum|p_i|` is far wider and is met even by a broken compensation:
for `[1e16+i, 1+1e16i, -1e16-1e16i] . [1, 1, 1]` the previous
implementation returned `1+0i` instead of `1+1i`, which is within
`gamma(n) sum|p_i|` but exceeds the Sum2 bound by a factor of about 10^15.

## Coverage

| Spec | Functions | Input classes |
|---|---|---|
| Complex scalars | `TComplex` operators, `Reciprocal`, `Arg`, `Norm`, `ToString`, `TImaginaryUnit`, `IsNull`, `SameValue` | scales 1e-300..1e300, operands near overflow and subnormal, cancellation, signed zeros |
| Scalar roots and powers | `SquareRoot`, `CubicRoot`, `QuarticRoot`, `SquarePower`..`QuarticPower`, linear `SolveEquation` | every quadrant, unbalanced components, near overflow/underflow, subnormals |
| Polynomial equations | `SolveEquation` degrees 2-4 | random roots at all scales, conjugate pairs, magnitudes 1e-60..1e60 in one polynomial, exact zero, multiple and clustered roots, power-of-two equivariance |
| Vectors | construction, elementwise operations, `Dot`, `Norm`, `Normalize`, `Reciprocal`, `Cross`, `Conjugate` | lengths 1..1000, cancellation, components dominated by different elements, non-finite inputs |
| Matrices | construction, elementwise operations, transposes, products, `Norm`, `Trace`, predicates | orders 1..40, scales 1e-100..1e100, cancelling rows |
| Linear systems | `SolveLinear`, `Inverse`, `Determinant`, `Rank`, `RowReduction` | xCHKGE classes: diagonal, triangular, cond 2, sqrt(1/eps), 0.1/eps, scaled 1e-290 and 1e290, zero columns; singular to working precision (cond 1e20, exactly singular integer matrices) and well conditioned (cond 1e12); prescribed rank at scales 1e-200..1e200 |
| Symmetric and Hermitian eigenpairs | `SymmetricEigenpairs`, `HermitianEigenpairs` | zero, identity, arithmetic, geometric cond 1/eps and sqrt(1/eps), one large/small, mixed signs, repeated, scaled 1e-290 and 1e290, Wilkinson, Hilbert, Laplacian |
| General eigenpairs | `Eigenpairs` (real and complex) | prescribed spectra with cond(X) 1, 1e3, 1e6; graded similarities D*A*D^-1 with D = diag(g^i), g up to 1e8 (balancing); permuted triangular; random; scaled; cyclic permutations; Jordan; Grcar; Frank; Kahan; companion; graded; triangular; Hermitian path |
| Tridiagonal lowest eigenpairs | `TridiagonalLowestEigenpairs`, `HermitianTridiagonalLowestEigenpairs` | Laplacian (analytic), Wilkinson, random, graded, disconnected, zero; partial and fall-back paths; complex phases |
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

## Validation of the suite

A suite that passes on the code it was written for proves little. This
suite was also run against the implementation it replaced (commit
`f75c37b`), and every defect known in that implementation is detected:

| Defect in `f75c37b` | Detected by | Evidence |
|---|---|---|
| `SquareRoot` loses the smaller component | roots: componentwise accuracy | 124 failures, worst ratio 9e15 |
| `SquareRoot` overflows when \|z\| exceeds MaxDouble | roots: componentwise accuracy | section aborted (EOverflow) |
| `CubicRoot` loses accuracy at large and small moduli (`Power(x, 1/3)`) | roots: backward error | 240 failures, worst 59 |
| quadratic formula cancellation | polynomials: widely different magnitudes | `x^2+1e8x+1` and others |
| absolute `IsNull` tests in the cubic and quartic | polynomials: random roots at all scales; equivariance | 705 and 9 failures |
| Neumaier branch chosen by complex modulus | vectors: Dot; matrices: products | worst ratios 9e14 and 1e4 |
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

To repeat the validation against another `adimmath.pas`, compile the suite
from a directory that does not contain the current source, because Free
Pascal searches the current directory before `-Fu`:

```sh
REPO=$(pwd)
WORK=$(mktemp -d)
git show f75c37b:adimmath.pas > "$WORK/adimmath.pas"
cd "$WORK" && fpc -Mobjfpc -O2 -Fu. -Fu"$REPO/tests" -FE. "$REPO/test.lpr"
./test            # add --perf for the performance checks
```

## Lessons from the previous suite

The previous suite used LAPACK's residual formulas but not LAPACK's testing
method, and several defects passed because of that:

1. **Residuals on benign inputs only.** Square roots were tested only at
   `(0.75, -1.25) * scale`, with both components of the same size, and
   polynomials only with roots 1 to 4 at scale one. Here every function is
   tested on generated input classes, including unbalanced components,
   cancellation, mixed magnitudes and the extremes of the range.
2. **Per-root residuals cannot see repeated roots.** Returning one exact
   root three times gives a zero residual. Roots are now matched as a
   multiset against the true ones, with condition-based tolerances.
3. **Bounds wider than the algorithm's guarantee.** The naive summation
   bound accepted a broken compensated sum. Each check now uses the
   strongest bound that the algorithm actually guarantees.
4. **A reference that was not more precise.** `Extended` is `Double` on
   Win64. The oracle is now double-double on every target.
5. **No forward error relative to the condition.** Solvers are checked
   against generated problems with known condition and known solutions
   (DGET04, eigenvalue condition numbers, Weyl), not only residuals.
6. **Tolerances not derived from the measure.** One check required an
   absolute error of 2.2e-16 on an eigenvalue of modulus 2.2, which is
   below one ulp of the value. Thresholds are now stated with their source.
7. **No performance checks.** An O(n^4) eigensolver passed every test.

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
- J. H. Wilkinson, *Rounding Errors in Algebraic Processes*, 1963;
  W. Gautschi, "On the condition of algebraic equations", *Numer. Math.*
  20 (1973).
- G. Peters, J. H. Wilkinson, "Practical problems arising in the solution
  of polynomial equations", *J. Inst. Maths Applics* 8 (1971).
- T. J. Dekker, "A floating-point technique for extending the available
  precision", *Numer. Math.* 18 (1971).
