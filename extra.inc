{ Extra routines interface }

type
  // Versors
  TR2Versor1 = record class operator *(const AValue: double; const ASelf: TR2Versor1): TR2Vector; end;
  TR2Versor2 = record class operator *(const AValue: double; const ASelf: TR2Versor2): TR2Vector; end;

  TR3Versor1 = record class operator *(const AValue: double; const ASelf: TR3Versor1): TR3Vector; end;
  TR3Versor2 = record class operator *(const AValue: double; const ASelf: TR3Versor2): TR3Vector; end;
  TR3Versor3 = record class operator *(const AValue: double; const ASelf: TR3Versor3): TR3Vector; end;

  TR4Versor1 = record class operator *(const AValue: double; const ASelf: TR4Versor1): TR4Vector; end;
  TR4Versor2 = record class operator *(const AValue: double; const ASelf: TR4Versor2): TR4Vector; end;
  TR4Versor3 = record class operator *(const AValue: double; const ASelf: TR4Versor3): TR4Vector; end;
  TR4Versor4 = record class operator *(const AValue: double; const ASelf: TR4Versor4): TR4Vector; end;

// Power and root functions

function SquarePower(const AValue: TComplex): TComplex;
function CubicPower(const AValue: TComplex): TComplex;
function QuarticPower(const AValue: TComplex): TComplex;

function SquareRoot(const AValue: TComplex): TC2Array;
function CubicRoot(const AValue: TComplex): TC3Array;
function QuarticRoot(const AValue: TComplex): TC4Array;

// Usefull routines

function Abs(const AValue: double): double;
function Abs(const AValue: TComplex): double;

function Commutator(const ALeft, ARight: TC2Matrix): TC2Matrix;
function Commutator(const ALeft, ARight: TC3Matrix): TC3Matrix;
function Commutator(const ALeft, ARight: TC4Matrix): TC4Matrix;

function SameValue(const AValue1, AValue2: double): boolean;
function SameValue(const AValue1, AValue2: TComplex): boolean;
function SameValue(const AValue1, AValue2: TC2Vector): boolean;
function SameValue(const AValue1, AValue2: TC3Vector): boolean;
function SameValue(const AValue1, AValue2: TC4Vector): boolean;
function SameValue(const AValue1, AValue2: TC2TransposedVector): boolean;
function SameValue(const AValue1, AValue2: TC3TransposedVector): boolean;
function SameValue(const AValue1, AValue2: TC4TransposedVector): boolean;
function SameValue(const AValue1, AValue2: TC2Matrix): boolean;
function SameValue(const AValue1, AValue2: TC3Matrix): boolean;
function SameValue(const AValue1, AValue2: TC4Matrix): boolean;
{$IFNDEF ADIMOFF}
function SameValue(const ALeft, ARight: TQuantity): boolean;
{$ENDIF}

function C2NullVector: TC2Vector;
function C3NullVector: TC3Vector;
function C4NullVector: TC4Vector;

function C2NullTransposedVector: TC2TransposedVector;
function C3NullTransposedVector: TC3TransposedVector;
function C4NullTransposedVector: TC4TransposedVector;

function C2NullMatrix: TC2Matrix;
function C3NullMatrix: TC3Matrix;
function C4NullMatrix: TC4Matrix;

function C2IdMatrix: TC2Matrix;
function C3IdMatrix: TC3Matrix;
function C4IdMatrix: TC4Matrix;

// Solvers for linear, quadratic, cubic and quartic equation

function SolveEquation(const a: double): double;
function SolveEquation(const a: TComplex): TComplex;
function SolveEquation(const a, b: TComplex): TC2Array;
function SolveEquation(const a, b, c: TComplex): TC3Array;
function SolveEquation(const a, b, c, d: TComplex): TC4Array;

