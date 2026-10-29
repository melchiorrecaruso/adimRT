{ SpecComplex - TComplex, TImaginaryUnit and the scalar helpers.

  Accuracy is measured against double-double references. Bounds:
    multiplication  |fl(x*y) - x*y| <= sqrt(5)*u*|x*y|   (proved for the
                    textbook formula: R. P. Brent, C. Percival,
                    P. Zimmermann, Math. Comp. 76 (2007));
    reciprocal,     robust Smith formula (M. Baudin, R. L. Smith 2012),
    division        first-order bound about 5u, over the whole range;
    modulus, Arg    a few ulps from the run-time library. }
unit SpecComplex;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}
{$modeswitch nestedprocvars}

interface

implementation

uses
  SysUtils, Math, ADimMath, TestRunner, TestDoubleDouble, TestGenerators,
  TestMeasures;

const
  Scales: array[0..8] of Double = (1E-300, 1E-150, 1E-50, 1E-8, 1,
    1E8, 1E50, 1E150, 1E300);

function NormwiseError(const AValue: TComplex; const AReference: TDDComplex): Double;
begin
  result := DDModulus(TDDComplex(AValue) - AReference).ToDouble /
    DDModulus(AReference).ToDouble;
end;

procedure ContractChecks;
var
  Z: TComplex;
  ZeroDivisor: TComplex;
  I: TImaginaryUnit;

  procedure ReciprocalOfZero;
  begin
    Z := ZeroDivisor.Reciprocal;
  end;

  procedure DivideByZero;
  begin
    Z := Complex(1, 1) / ZeroDivisor;
  end;

begin
  Group('Construction, components and equality', ckContract);
  Z := Complex(1.5, -2.5);
  CheckEqual('Re', Z.Re, 1.5);
  CheckEqual('Im', Z.Im, -2.5);
  Z := 3.25;
  CheckEqual('real assignment', Z, Complex(3.25, 0));
  Z.Zero;
  CheckEqual('Zero', Z, Complex(0, 0));
  Z.Re := 4;
  Z.Im := -1;
  CheckEqual('property write', Z, Complex(4, -1));
  Check('= is exact', Complex(1, 2) = Complex(1, 2));
  Check('= distinguishes one ulp', not (Complex(1, 2) = Complex(1 + Ulp, 2)));
  Check('<> is exact', Complex(1, 2) <> Complex(1, 2 + 2 * Ulp));
  CheckEqual('Conjugate', Complex(3, 4).Conjugate, Complex(3, -4));
  CheckEqual('unary minus', -Complex(3, -4), Complex(-3, 4));
  CheckEqual('unary plus', +Complex(3, -4), Complex(3, -4));
  CheckEqual('Abs = Norm', Abs(Complex(3, 4)), 5);
  CheckEqual('Norm function', Norm(Complex(-3, 4)), 5);
  CheckEqual('Norm real', Norm(-2.5), 2.5);
  CheckEqual('SquaredNorm', Complex(3, 4).SquaredNorm, 25);
  CheckEqual('SquareNorm complex', SquareNorm(Complex(3, 4)), 25);
  CheckEqual('SquareNorm real', SquareNorm(-3), 9);

  Group('Argument (quadrants and signed zeros, atan2 convention)', ckContract);
  CheckEqual('Arg(1)', Complex(1, 0).Arg, 0);
  CheckEqual('Arg(i)', Complex(0, 1).Arg, Pi / 2);
  CheckEqual('Arg(-1+0i)', Complex(-1, 0).Arg, Pi);
  CheckEqual('Arg(-1-0i)', Complex(-1, -0.0).Arg, -Pi);
  CheckEqual('Arg(-i)', Complex(0, -1).Arg, -Pi / 2);
  CheckEqual('Arg(1+i)', Complex(1, 1).Arg, Pi / 4);

  Group('Exceptions', ckContract);
  ZeroDivisor := Complex(0, 0);
  CheckRaises('Reciprocal(0) raises EZeroDivide', EZeroDivide, @ReciprocalOfZero);
  CheckRaises('z / 0 raises EZeroDivide', EZeroDivide, @DivideByZero);

  Group('Imaginary unit', ckContract);
  CheckEqual('i*i', I * I, -1);
  CheckEqual('i/i', I / I, 1);
  CheckEqual('3 + 2i', 3 + 2 * I, Complex(3, 2));
  CheckEqual('i - 1', I - 1, Complex(-1, 1));
  CheckEqual('-i', -I, Complex(0, -1));
  CheckEqual('(1+2i)*i', Complex(1, 2) * I, Complex(-2, 1));
  CheckEqual('(1+2i)/i', Complex(1, 2) / I, Complex(2, -1));
  CheckEqual('i/(1+i)', I / Complex(1, 1), Complex(0.5, 0.5));
  CheckEqual('2/i', 2 / I, Complex(0, -2));
  CheckEqual('img variable', TComplex(img), Complex(0, 1));

  { IsNull and SameValue are documented as absolute DefaultEpsilon tests;
    these checks pin that documented behaviour. }
  Group('IsNull/SameValue (absolute DefaultEpsilon tolerance)', ckContract);
  Check('IsNull(0)', Complex(0, 0).IsNull);
  Check('IsNull(1e-13)', Complex(1E-13, -1E-13).IsNull);
  Check('not IsNull(1e-11)', not Complex(1E-11, 0).IsNull);
  Check('IsNotNull(1)', Complex(1, 0).IsNotNull);
  Check('SameValue within 1e-13', Complex(1, 1).SameValue(Complex(1 + 1E-13, 1)));
  Check('SameValue is absolute (1e20 vs 1e20+1e5)',
    not Complex(1E20, 0).SameValue(Complex(1E20 + 1E5, 0)));
  Check('SameValueEx real', SameValueEx(1.0, 1.0 + 1E-13));
  Check('TReal.SameValue', TReal(2.0).SameValue(2.0 + 1E-13));
end;

procedure ToStringChecks;
begin
  Group('ToString formatting', ckContract);
  CheckEqual('zero', Complex(0, 0).ToString, '0');
  CheckEqual('real', Complex(2.5, 0).ToString, '2.5');
  CheckEqual('imaginary', Complex(0, 2).ToString, '2∙i');
  CheckEqual('i', Complex(0, 1).ToString, 'i');
  CheckEqual('-i', Complex(0, -1).ToString, '-i');
  CheckEqual('a+bi', Complex(1, 2).ToString, '1 +2∙i');
  CheckEqual('a-bi', Complex(1, -2).ToString, '1 -2∙i');
  CheckEqual('a+i', Complex(1, 1).ToString, '1 +i');
  CheckEqual('a-i', Complex(1, -1).ToString, '1 -i');
  CheckEqual('small value is printed', Complex(1E-13, 0).ToString, '1E-13');
  CheckEqual('small imaginary value is printed', Complex(0, 1E-20).ToString, '1E-20∙i');
  CheckEqual('scale invariant (1e-20)', Complex(1E-20, 2E-20).ToString,
    '1E-20 +2E-20∙i');
  CheckEqual('negligible part hidden', Complex(1, 1E-17).ToString, '1');
  CheckEqual('ToString(precision)', Complex(1 / 3, 0).ToString(4, 0), '0.3333');
  CheckEqual('FloatToStrF complex', FloatToStrF(Complex(0.5, 0)), '0.5');
  CheckEqual('FloatToStrF real', FloatToStrF(0.5), '0.5');
  CheckEqual('Fmt sign', Fmt(0.5), '+0.5');
  CheckEqual('Fmt negative', Fmt(-0.5), '-0.5');
end;

procedure ExactChecks;
var
  K, J: Integer;
  X, Y: TComplex;
begin
  Group('Componentwise operations are exact per component', ckExact);
  SetSeed(101);
  for K := 1 to 200 do
  begin
    X := RandomComplex * Scales[K mod 9];
    Y := RandomComplex * Scales[(K * 7) mod 9];
    CheckEqual(Format('x+y #%d', [K]), X + Y, Complex(X.Re + Y.Re, X.Im + Y.Im));
    CheckEqual(Format('x-y #%d', [K]), X - Y, Complex(X.Re - Y.Re, X.Im - Y.Im));
    CheckEqual(Format('2.5*x #%d', [K]), 2.5 * X, Complex(2.5 * X.Re, 2.5 * X.Im));
    CheckEqual(Format('x/4 #%d', [K]), X / 4.0, Complex(X.Re / 4, X.Im / 4));
    CheckEqual(Format('x+0.5 #%d', [K]), X + 0.5, Complex(X.Re + 0.5, X.Im));
    CheckEqual(Format('0.5-x #%d', [K]), 0.5 - X, Complex(0.5 - X.Re, -X.Im));
  end;

  Group('Algebraic identities that hold exactly in floating point', ckExact);
  SetSeed(102);
  for K := 1 to 200 do
  begin
    J := K mod 5 + 2;
    X := RandomComplex * Scales[J];
    Y := RandomComplex * Scales[8 - J];
    CheckEqual(Format('x*y = y*x #%d', [K]), X * Y, Y * X);
    CheckEqual(Format('conj(x*y) = conj(x)*conj(y) #%d', [K]),
      (X * Y).Conjugate, X.Conjugate * Y.Conjugate);
    CheckEqual(Format('conj(conj(x)) = x #%d', [K]), X.Conjugate.Conjugate, X);
  end;
end;

procedure AccuracyChecks;
var
  K, S, T: Integer;
  X, Y: TComplex;
  LReference: TDDComplex;
  LScaleX, LScaleY: Double;
begin
  Group('Multiplication, normwise relative error', ckAccuracy,
    Sqrt(5) * 1.000001, tsProved, 'Brent-Percival-Zimmermann 2007, sqrt(5)u');
  SetSeed(201);
  for S := 2 to 6 do
    for T := 2 to 6 do
      for K := 1 to 20 do
      begin
        X := RandomComplex * Scales[S];
        Y := RandomComplex * Scales[T];
        LReference := TDDComplex(X) * TDDComplex(Y);
        CheckRatio(Format('x*y scales %d,%d #%d', [S, T, K]),
          NormwiseError(X * Y, LReference) / UnitRoundoff);
      end;
  { Inputs where the real part of the product cancels. }
  for K := 1 to 200 do
  begin
    X := RandomComplex;
    Y := Complex(X.Im, X.Re) * (1 + RandomUniform * 1E-8);
    LReference := TDDComplex(X) * TDDComplex(Y);
    CheckRatio(Format('cancelling x*y #%d', [K]),
      NormwiseError(X * Y, LReference) / UnitRoundoff);
  end;

  Group('Reciprocal, normwise relative error', ckAccuracy, 8, tsProject,
    'first-order bound 5u for the robust Smith formula');
  SetSeed(202);
  for S := 0 to 8 do
    for K := 1 to 40 do
    begin
      X := RandomComplex * Scales[S];
      if X.Norm = 0 then Continue;
      LReference := DDComplex(1, 0) / TDDComplex(X);
      CheckRatio(Format('1/x scale %g #%d', [Scales[S], K]),
        NormwiseError(X.Reciprocal, LReference) / UnitRoundoff);
    end;
  { |c + d*d/c| overflows although 1/x is representable. }
  X := Complex(1E308, 1E308);
  CheckRatio('1/x near overflow',
    NormwiseError(X.Reciprocal, DDComplex(1, 0) / TDDComplex(X)) / UnitRoundoff);
  X := Complex(-1.5E308, 1E300);
  CheckRatio('1/x near overflow, unbalanced',
    NormwiseError(X.Reciprocal, DDComplex(1, 0) / TDDComplex(X)) / UnitRoundoff);

  Group('Division, normwise relative error', ckAccuracy, 10, tsProject,
    'first-order bound about 5u for the robust Smith formula');
  SetSeed(203);
  for S := 0 to 8 do
    for T := 0 to 8 do
      for K := 1 to 10 do
      begin
        LScaleX := Scales[S];
        LScaleY := Scales[T];
        X := RandomComplex * LScaleX;
        Y := RandomComplex * LScaleY;
        { Skip quotients outside the normal range (their ratio would
          itself underflow or overflow). }
        if System.Abs(Log10(LScaleX) - Log10(LScaleY)) > 290 then Continue;
        LReference := TDDComplex(X) / TDDComplex(Y);
        CheckRatio(Format('x/y scales %d,%d #%d', [S, T, K]),
          NormwiseError(X / Y, LReference) / UnitRoundoff);
        CheckRatio(Format('r/y scales %d,%d #%d', [S, T, K]),
          NormwiseError(X.Re / Y, DDComplex(X.Re, 0) / TDDComplex(Y)) /
            UnitRoundoff);
      end;
  for S := 0 to 8 do
  begin
    X := Complex(0.75, -1.25) * Scales[S];
    CheckRatio(Format('z/z scale %g', [Scales[S]]),
      (X / X - 1).Norm / UnitRoundoff);
  end;
  { Operands near the ends of the range, where forming 1/y or |y|^2
    overflows or underflows although the quotient is representable. }
  X := Complex(0.75, -1.25) * 1.2E308;
  CheckRatio('z/z near overflow', (X / X - 1).Norm / UnitRoundoff);
  X := Complex(1E308, 0);
  Y := Complex(1E308, 1E308);
  CheckRatio('1e308/(1e308+1e308i)',
    NormwiseError(X / Y, TDDComplex(X) / TDDComplex(Y)) / UnitRoundoff);
  X := Complex(Math.LdExp(3, -1070), Math.LdExp(4, -1070));
  Y := Complex(Math.LdExp(1, -1070), 0);
  CheckRatio('subnormal/subnormal', (X / Y - Complex(3, 4)).Norm / UnitRoundoff);
  Y := Complex(0, Math.LdExp(1, -1072));
  CheckRatio('subnormal/subnormal imaginary',
    (X / Y - Complex(16, -12)).Norm / UnitRoundoff);

  Group('Modulus and SquaredNorm, relative error', ckAccuracy, 4, tsProject,
    'a few ulps for hypot and two products');
  SetSeed(204);
  for S := 0 to 8 do
    for K := 1 to 40 do
    begin
      X := RandomComplex * Scales[S];
      LReference := TDDComplex(X);
      CheckRatio(Format('|x| scale %g #%d', [Scales[S], K]),
        System.Abs(X.Norm - DDModulus(LReference).ToDouble) /
        (X.Norm * UnitRoundoff));
      if (S >= 2) and (S <= 6) then
        CheckRatio(Format('|x|^2 scale %g #%d', [Scales[S], K]),
          System.Abs(X.SquaredNorm -
            (LReference.Re * LReference.Re + LReference.Im * LReference.Im).ToDouble) /
          (X.SquaredNorm * UnitRoundoff));
    end;
  X := Complex(3E307, 4E307);
  CheckRatio('|x| near overflow', System.Abs(X.Norm - 5E307) / (5E307 * UnitRoundoff));
  X := Complex(3E-310, 4E-310);
  Check('|x| of subnormal parts is positive', X.Norm > 0);
end;

procedure Run;
begin
  Guard(@ContractChecks);
  Guard(@ToStringChecks);
  Guard(@ExactChecks);
  Guard(@AccuracyChecks);
end;

initialization
  RegisterSpec('Complex scalars (TComplex, TImaginaryUnit)', @Run);
end.
