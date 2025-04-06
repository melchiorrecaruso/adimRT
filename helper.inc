
type

  { TComplexQuantityHelper }

  {$IFNDEF ADIMOFF}
  TComplexQuantityHelper = record helper for TComplexQuantity
    function Dual: TComplexQuantity;
    function Reciprocal: TComplexQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;
  end;
  {$ENDIF}

  TC2ArrayOfQuantity = array[1..T2DSpace.N] of TComplexQuantity;
  TC3ArrayOfQuantity = array[1..T3DSpace.N] of TComplexQuantity;
  TC4ArrayOfQuantity = array[1..T4DSpace.N] of TComplexQuantity;

  TC2ArrayOfVecQuantity = array[1..T2DSpace.N] of TC2VecQuantity;
  TC3ArrayOfVecQuantity = array[1..T3DSpace.N] of TC3VecQuantity;
  TC4ArrayOfVecQuantity = array[1..T4DSpace.N] of TC4VecQuantity;

  { TC2MatrixQuantityHelper }

  {$IFNDEF ADIMOFF}
  TC2MatrixQuantityHelper = record helper for TC2MatrixQuantity
    function Diagonalize(const AEigenvalues: TC2ArrayOfQuantity): TC2MatrixQuantity;
    function Dual: TC2MatrixQuantity;
    function Determinant: TComplexQuantity;
    function Eigenvalues: TC2ArrayOfQuantity;
    function Eigenvectors(const AEigenValues: TC2ArrayOfQuantity): TC2ArrayOfVecQuantity;
    function Reciprocal(const ADeterminant: TComplexQuantity): TC2MatrixQuantity;
    function TransposeDual: TC2MatrixQuantity;
  end;
  {$ENDIF}

  { TC2VecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TC2VecQuantityHelper = record helper for TC2VecQuantity
    function Dot(const AVector: TC2VecQuantity): TComplexQuantity;
  end;
  {$ENDIF}

  { TC3VecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TC3VecQuantityHelper = record helper for TC3VecQuantity
    function Dot(const AVector: TC3VecQuantity): TComplexQuantity;
  end;
  {$ENDIF}

  { TC4VecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TC4VecQuantityHelper = record helper for TC4VecQuantity
    function Dot(const AVector: TC4VecQuantity): TComplexQuantity;
  end;
  {$ENDIF}

  { TR3VecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TR3VecQuantityHelper = record helper for TR3VecQuantity
    function Dot(const AVector: TR3VecQuantity): TQuantity;
    function Cross(const AVector: TR3VecQuantity): TR3VecQuantity;
    function Projection(const AVersor: TR3Vector): TR3VecQuantity;
    function Rejection(const AVersor: TR3Vector): TR3VecQuantity;
    function Reflection(const AVersor: TR3Vector): TR3VecQuantity;
  end;
  {$ENDIF}

  { TCL3MultivecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TCL3MultivecQuantityHelper = record helper for TCL3MultivecQuantity
    function Dual: TCL3MultivecQuantity;
    function Inverse: TCL3MultivecQuantity;
    function Reverse: TCL3MultivecQuantity;
    function Conjugate: TCL3MultivecQuantity;
    function Reciprocal: TCL3MultivecQuantity;
    function LeftReciprocal: TCL3MultivecQuantity;
    function Normalized: TCL3MultivecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;
    function Dot(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;
    function Dot(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity; overload;
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Wedge(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;
    function Wedge(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;
    function Wedge(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity; overload;
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Projection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;
    function Projection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;
    function Projection(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity; overload;
    function Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Rejection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;
    function Rejection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;
    function Rejection(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Reflection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;
    function Reflection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity; overload;
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3MultivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3MultivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3MultivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;overload;

    function SameValue(const AVector: TCL3MultivecQuantity): boolean;
    function SameValue(const AVector: TCL3TrivecQuantity): boolean;
    function SameValue(const AVector: TCL3BivecQuantity): boolean;
    function SameValue(const AVector: TCL3VecQuantity): boolean;
    function SameValue(const AVector: TQuantity): boolean;

    function ExtractMultivector(AComponents: TCL3MultivectorComponents): TCL3MultivecQuantity;
    function ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3BivecQuantity;
    function ExtractVector(AComponents: TCL3MultivectorComponents): TCL3VecQuantity;

    function ExtractTrivector: TCL3TrivecQuantity;
    function ExtractBivector: TCL3BivecQuantity;
    function ExtractVector: TCL3VecQuantity;
    function ExtractScalar: TQuantity;

    function IsNull: boolean;
    function IsScalar: boolean;
    function IsVector: boolean;
    function IsBiVector: boolean;
    function IsTrivector: boolean;
    function IsA: string;
  end;
  {$ENDIF}

  { TCL3TrivecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TCL3TrivecQuantityHelper = record helper for TCL3TrivecQuantity
    function Dual: TQuantity;
    function Inverse: TCL3TrivecQuantity;
    function Reverse: TCL3TrivecQuantity;
    function Conjugate: TCL3TrivecQuantity;
    function Reciprocal: TCL3TrivecQuantity;
    function Normalized: TCL3TrivecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;
    function Dot(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;
    function Dot(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Wedge(const AVector: TCL3VecQuantity): TQuantity; overload;
    function Wedge(const AVector: TCL3BivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity; overload;

    function Projection(const AVector: TCL3VecQuantity): TCL3TrivecQuantity; overload;
    function Projection(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity; overload;
    function Projection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity; overload;
    function Projection(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity; overload;

    function Rejection(const AVector: TCL3VecQuantity): TQuantity; overload;
    function Rejection(const AVector: TCL3BivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Reflection(const AVector: TCL3VecQuantity): TCL3TrivecQuantity; overload;
    function Reflection(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity; overload;
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity; overload;
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3TrivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3TrivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3TrivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3TrivecQuantity; overload;

    function SameValue(const AVector: TCL3MultivecQuantity): boolean;
    function SameValue(const AVector: TCL3TrivecQuantity): boolean;

    function ToMultivector: TCL3MultivecQuantity;
  end;
  {$ENDIF}

  { TCL3BivecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TCL3BivecQuantityHelper = record helper for TCL3BivecQuantity
    function Dual: TCL3VecQuantity;
    function Inverse: TCL3BivecQuantity;
    function Reverse: TCL3BivecQuantity;
    function Conjugate: TCL3BivecQuantity;
    function Reciprocal: TCL3BivecQuantity;
    function Normalized: TCL3BivecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TCL3VecQuantity): TCL3VecQuantity; overload;
    function Dot(const AVector: TCL3BivecQuantity): TQuantity; overload;
    function Dot(const AVector: TCL3TrivecQuantity): TCL3VecQuantity; overload;
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Wedge(const AVector: TCL3VecQuantity): TCL3TrivecQuantity; overload;
    function Wedge(const AVector: TCL3BivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Projection(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;
    function Projection(const AVector: TCL3BivecQuantity): TCL3BivecQuantity; overload;
    function Projection(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity; overload;
    function Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Rejection(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;
    function Rejection(const AVector: TCL3BivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Reflection(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;
    function Reflection(const AVector: TCL3BivecQuantity): TCL3BivecQuantity; overload;
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity; overload;
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3BivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3BivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3BivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function SameValue(const AVector: TCL3MultivecQuantity): boolean;
    function SameValue(const AVector: TCL3BivecQuantity): boolean;

    function ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3BivecQuantity;

    function ToMultivector: TCL3MultivecQuantity;
  end;
  {$ENDIF}

  { TCL3VecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TCL3VecQuantityHelper = record helper for TCL3VecQuantity
    function Dual: TCL3BivecQuantity;
    function Inverse: TCL3VecQuantity;
    function Reverse: TCL3VecQuantity;
    function Conjugate: TCL3VecQuantity;
    function Reciprocal: TCL3VecQuantity;
    function Normalized: TCL3VecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TCL3VecQuantity): TQuantity; overload;
    function Dot(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;
    function Dot(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity; overload;
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Wedge(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;
    function Wedge(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity; overload;
    function Wedge(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Cross(const AVector: TCL3VecQuantity): TCL3VecQuantity;

    function Projection(const AVector: TCL3VecQuantity): TCL3VecQuantity; overload;
    function Projection(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;
    function Projection(const AVector: TCL3TrivecQuantity): TCL3VecQuantity; overload;
    function Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Rejection(const AVector: TCL3VecQuantity): TCL3VecQuantity; overload;
    function Rejection(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;
    function Rejection(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Reflection(const AVector: TCL3VecQuantity): TCL3VecQuantity; overload;
    function Reflection(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3VecQuantity; overload;
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3VecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3VecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3VecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function SameValue(const AVector: TCL3MultivecQuantity): boolean;
    function SameValue(const AVector: TCL3VecQuantity): boolean;

    function ExtractVector(AComponents: TCL3MultivectorComponents): TCL3VecQuantity;

    function ToMultivector: TCL3MultivecQuantity;
  end;
  {$ENDIF}
