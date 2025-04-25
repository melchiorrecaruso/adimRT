
interface

uses
  SysUtils;

type
  { Prefix }
  TPrefix = (pQuetta, pRonna, pYotta, pZetta, pExa, pPeta, pTera, pGiga, pMega, pKilo, pHecto, pDeca, 
    pNone, pDeci, pCenti, pMilli, pMicro, pNano, pPico, pFemto, pAtto, pZepto, pYocto, pRonto, pQuecto);

  { Prefixes } 
  TPrefixes = array of TPrefix; 

  { Exponents } 
  TExponents = array of longint;

  { TQuantities } 

  {$I scalar.inc}
  {$I complex.inc}
  {$I matrix.inc}
  {$I vector.inc}
  {$I cl3.inc}
  {$I helper.inc}
  {$I extra.inc} 

type

  { TUnit }

  TUnit = record
  private
    FID: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    // Real numbers
    class operator *(const AValue: double; const ASelf: TUnit): TQuantity; inline;
    class operator /(const AValue: double; const ASelf: TUnit): TQuantity; inline;
    // Complex numbers
    class operator *(const AValue: TComplex; const ASelf: TUnit): TComplexQuantity; inline;
    class operator /(const AValue: TComplex; const ASelf: TUnit): TComplexQuantity; inline;
    // Real vector space
    class operator *(const AVector: TR2Vector; const ASelf: TUnit): TR2VecQuantity; inline;
    class operator *(const AVector: TR3Vector; const ASelf: TUnit): TR3VecQuantity; inline;
    class operator *(const AVector: TR4Vector; const ASelf: TUnit): TR4vecQuantity; inline;
    class operator /(const AVector: TR2Vector; const ASelf: TUnit): TR2VecQuantity; inline;
    class operator /(const AVector: TR3Vector; const ASelf: TUnit): TR3VecQuantity; inline;
    class operator /(const AVector: TR4Vector; const ASelf: TUnit): TR4vecQuantity; inline;
    // Complex vector space
    class operator *(const AVector: TC2Vector; const ASelf: TUnit): TC2VecQuantity; inline;
    class operator *(const AVector: TC3Vector; const ASelf: TUnit): TC3VecQuantity; inline;
    class operator *(const AVector: TC4Vector; const ASelf: TUnit): TC4vecQuantity; inline;
    class operator /(const AVector: TC2Vector; const ASelf: TUnit): TC2VecQuantity; inline;
    class operator /(const AVector: TC3Vector; const ASelf: TUnit): TC3VecQuantity; inline;
    class operator /(const AVector: TC4Vector; const ASelf: TUnit): TC4vecQuantity; inline;
    // Real matrixes
    class operator *(const AMatrix: TR2Matrix; const ASelf: TUnit): TR2MatrixQuantity; inline;
    class operator *(const AMatrix: TR3Matrix; const ASelf: TUnit): TR3MatrixQuantity; inline;
    class operator *(const AMatrix: TR4Matrix; const ASelf: TUnit): TR4MatrixQuantity; inline;
    class operator /(const AMatrix: TR2Matrix; const ASelf: TUnit): TR2MatrixQuantity; inline;
    class operator /(const AMatrix: TR3Matrix; const ASelf: TUnit): TR3MatrixQuantity; inline;
    class operator /(const AMatrix: TR4Matrix; const ASelf: TUnit): TR4MatrixQuantity; inline;
    // Complex matrixes
    class operator *(const AMatrix: TC2Matrix; const ASelf: TUnit): TC2MatrixQuantity; inline;
    class operator *(const AMatrix: TC3Matrix; const ASelf: TUnit): TC3MatrixQuantity; inline;
    class operator *(const AMatrix: TC4Matrix; const ASelf: TUnit): TC4MatrixQuantity; inline;
    class operator /(const AMatrix: TC2Matrix; const ASelf: TUnit): TC2MatrixQuantity; inline;
    class operator /(const AMatrix: TC3Matrix; const ASelf: TUnit): TC3MatrixQuantity; inline;
    class operator /(const AMatrix: TC4Matrix; const ASelf: TUnit): TC4MatrixQuantity; inline;
    // CL3 vector space, Clifford algebra
    class operator *(const AVector: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;
    class operator *(const ABivector: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;
    class operator *(const ATrivector: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;
    class operator *(const AMultivector: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;
    class operator /(const AVector: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;
    class operator /(const ABivector: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;
    class operator /(const ATrivector: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;
    class operator /(const AMultivector: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;
  {$IFNDEF ADIMOFF}
    // Real numbers
    class operator *(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
    class operator /(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
    // Complex numbers
    class operator *(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;
    class operator *(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;
    class operator /(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
    // Real vector space
    class operator *(const AQuantity: TR2VecQuantity; const ASelf: TUnit): TR2VecQuantity; inline;
    class operator *(const AQuantity: TR3VecQuantity; const ASelf: TUnit): TR3VecQuantity; inline;
    class operator *(const AQuantity: TR4VecQuantity; const ASelf: TUnit): TR4VecQuantity; inline;
    class operator /(const AQuantity: TR2VecQuantity; const ASelf: TUnit): TR2VecQuantity; inline;
    class operator /(const AQuantity: TR3VecQuantity; const ASelf: TUnit): TR3VecQuantity; inline;
    class operator /(const AQuantity: TR4VecQuantity; const ASelf: TUnit): TR4VecQuantity; inline;
    // Complex vector space
    class operator *(const AQuantity: TC2VecQuantity; const ASelf: TUnit): TC2VecQuantity; inline;
    class operator *(const AQuantity: TC3VecQuantity; const ASelf: TUnit): TC3VecQuantity; inline;
    class operator *(const AQuantity: TC4VecQuantity; const ASelf: TUnit): TC4VecQuantity; inline;
    class operator /(const AQuantity: TC2VecQuantity; const ASelf: TUnit): TC2VecQuantity; inline;
    class operator /(const AQuantity: TC3VecQuantity; const ASelf: TUnit): TC3VecQuantity; inline;
    class operator /(const AQuantity: TC4VecQuantity; const ASelf: TUnit): TC4VecQuantity; inline;
    // Real matrixes
    class operator *(const AQuantity: TR2MatrixQuantity; const ASelf: TUnit): TR2MatrixQuantity; inline;
    class operator *(const AQuantity: TR3MatrixQuantity; const ASelf: TUnit): TR3MatrixQuantity; inline;
    class operator *(const AQuantity: TR4MatrixQuantity; const ASelf: TUnit): TR4MatrixQuantity; inline;
    class operator /(const AQuantity: TR2MatrixQuantity; const ASelf: TUnit): TR2MatrixQuantity; inline;
    class operator /(const AQuantity: TR3MatrixQuantity; const ASelf: TUnit): TR3MatrixQuantity; inline;
    class operator /(const AQuantity: TR4MatrixQuantity; const ASelf: TUnit): TR4MatrixQuantity; inline;
    // Complex matrixes
    class operator *(const AQuantity: TC2MatrixQuantity; const ASelf: TUnit): TC2MatrixQuantity; inline;
    class operator *(const AQuantity: TC3MatrixQuantity; const ASelf: TUnit): TC3MatrixQuantity; inline;
    class operator *(const AQuantity: TC4MatrixQuantity; const ASelf: TUnit): TC4MatrixQuantity; inline;
    class operator /(const AQuantity: TC2MatrixQuantity; const ASelf: TUnit): TC2MatrixQuantity; inline;
    class operator /(const AQuantity: TC3MatrixQuantity; const ASelf: TUnit): TC3MatrixQuantity; inline;
    class operator /(const AQuantity: TC4MatrixQuantity; const ASelf: TUnit): TC4MatrixQuantity; inline;
    // CL3 vector space, Clifford algebra
    class operator *(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;
    class operator *(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;
    class operator *(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;
    class operator *(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;
    class operator /(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;
    class operator /(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;
    class operator /(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;
    class operator /(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;
  {$ENDIF}
  end;

  { TFactoredUnit }

  TFactoredUnit = record
  private
    FID: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
    FFactor: double; 
  public
    // Real numbers
    class operator *(const AValue: double; const ASelf: TFactoredUnit): TQuantity; inline;
    class operator /(const AValue: double; const ASelf: TFactoredUnit): TQuantity; inline;
    // Complex numbers
    class operator *(const AValue: TComplex; const ASelf: TFactoredUnit): TComplexQuantity; inline;
    class operator /(const AValue: TComplex; const ASelf: TFactoredUnit): TComplexQuantity; inline;
    // Real vector space
    class operator *(const AVector: TR2Vector; const ASelf: TFactoredUnit): TR2VecQuantity; inline;
    class operator *(const AVector: TR3Vector; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
    class operator *(const AVector: TR4Vector; const ASelf: TFactoredUnit): TR4vecQuantity; inline;
    class operator /(const AVector: TR2Vector; const ASelf: TFactoredUnit): TR2VecQuantity; inline;
    class operator /(const AVector: TR3Vector; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
    class operator /(const AVector: TR4Vector; const ASelf: TFactoredUnit): TR4vecQuantity; inline;
    // Complex vector space
    class operator *(const AVector: TC2Vector; const ASelf: TFactoredUnit): TC2VecQuantity; inline;
    class operator *(const AVector: TC3Vector; const ASelf: TFactoredUnit): TC3VecQuantity; inline;
    class operator *(const AVector: TC4Vector; const ASelf: TFactoredUnit): TC4vecQuantity; inline;
    class operator /(const AVector: TC2Vector; const ASelf: TFactoredUnit): TC2VecQuantity; inline;
    class operator /(const AVector: TC3Vector; const ASelf: TFactoredUnit): TC3VecQuantity; inline;
    class operator /(const AVector: TC4Vector; const ASelf: TFactoredUnit): TC4vecQuantity; inline;
    // Real matrixes
    class operator *(const AMatrix: TR2Matrix; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;
    class operator *(const AMatrix: TR3Matrix; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;
    class operator *(const AMatrix: TR4Matrix; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;
    class operator /(const AMatrix: TR2Matrix; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;
    class operator /(const AMatrix: TR3Matrix; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;
    class operator /(const AMatrix: TR4Matrix; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;
    // Complex matrixes
    class operator *(const AMatrix: TC2Matrix; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;
    class operator *(const AMatrix: TC3Matrix; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;
    class operator *(const AMatrix: TC4Matrix; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;
    class operator /(const AMatrix: TC2Matrix; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;
    class operator /(const AMatrix: TC3Matrix; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;
    class operator /(const AMatrix: TC4Matrix; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;
    // CL3 vector space, Clifford algebra
    class operator *(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
    class operator *(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
    class operator *(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
    class operator *(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
    class operator /(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
    class operator /(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
    class operator /(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
    class operator /(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
  {$IFNDEF ADIMOFF}
    // Real numbers
    class operator *(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
    class operator /(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
    // Complex numbers
    class operator *(const AQuantity: TComplexQuantity; const ASelf: TFactoredUnit): TComplexQuantity; inline;
    class operator /(const AQuantity: TComplexQuantity; const ASelf: TFactoredUnit): TComplexQuantity; inline;
    // Real vector space
    class operator *(const AQuantity: TR2VecQuantity; const ASelf: TFactoredUnit): TR2VecQuantity; inline;
    class operator *(const AQuantity: TR3VecQuantity; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
    class operator *(const AQuantity: TR4VecQuantity; const ASelf: TFactoredUnit): TR4VecQuantity; inline;
    class operator /(const AQuantity: TR2VecQuantity; const ASelf: TFactoredUnit): TR2VecQuantity; inline;
    class operator /(const AQuantity: TR3VecQuantity; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
    class operator /(const AQuantity: TR4VecQuantity; const ASelf: TFactoredUnit): TR4VecQuantity; inline;
    // Complex vector space
    class operator *(const AQuantity: TC2VecQuantity; const ASelf: TFactoredUnit): TC2VecQuantity; inline;
    class operator *(const AQuantity: TC3VecQuantity; const ASelf: TFactoredUnit): TC3VecQuantity; inline;
    class operator *(const AQuantity: TC4VecQuantity; const ASelf: TFactoredUnit): TC4VecQuantity; inline;
    class operator /(const AQuantity: TC2VecQuantity; const ASelf: TFactoredUnit): TC2VecQuantity; inline;
    class operator /(const AQuantity: TC3VecQuantity; const ASelf: TFactoredUnit): TC3VecQuantity; inline;
    class operator /(const AQuantity: TC4VecQuantity; const ASelf: TFactoredUnit): TC4VecQuantity; inline;
    // Real matrixes
    class operator *(const AQuantity: TR2MatrixQuantity; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;
    class operator *(const AQuantity: TR3MatrixQuantity; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;
    class operator *(const AQuantity: TR4MatrixQuantity; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;
    class operator /(const AQuantity: TR2MatrixQuantity; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;
    class operator /(const AQuantity: TR3MatrixQuantity; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;
    class operator /(const AQuantity: TR4MatrixQuantity; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;
    // Complex matrixes
    class operator *(const AQuantity: TC2MatrixQuantity; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;
    class operator *(const AQuantity: TC3MatrixQuantity; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;
    class operator *(const AQuantity: TC4MatrixQuantity; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;
    class operator /(const AQuantity: TC2MatrixQuantity; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;
    class operator /(const AQuantity: TC3MatrixQuantity; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;
    class operator /(const AQuantity: TC4MatrixQuantity; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;
    // CL3 vector space, Clifford algebra
    class operator *(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
    class operator *(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
    class operator *(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
    class operator *(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
    class operator /(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
    class operator /(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
    class operator /(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
    class operator /(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
  {$ENDIF}
  end;

  { TDegreeCelsiusUnit }

  TDegreeCelsiusUnit = record
  private
    FID: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    class operator *(const AValue: double; const ASelf: TDegreeCelsiusUnit): TQuantity; inline;
  end;

  { TDegreeFahrenheitUnit }

  TDegreeFahrenheitUnit = record
  private
    FID: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    class operator *(const AValue: double; const ASelf: TDegreeFahrenheitUnit): TQuantity; inline;
  end;   

 { TUnitHelper }

  TUnitHelper = record helper for TUnit
  public
    function GetName(Prefixes: TPrefixes): string;
    function GetPluralName(Prefixes: TPrefixes): string;
    function GetSymbol(Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
    function GetValue(const AQuantity: TComplex; const APrefixes: TPrefixes): TComplex;
  public
    // Real numbers
    function ToFloat(const AQuantity: TQuantity): double;
    function ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
    function ToString(const AQuantity: TQuantity): string;
    function ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TQuantity): string;
    function ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    // Complex numbers
    function ToComplex(const AQuantity: TComplexQuantity): TComplex;
    function ToComplex(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): TComplex;
    function ToString(const AQuantity: TComplexQuantity): string;
    function ToString(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TComplexQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TComplexQuantity): string;
    function ToVerboseString(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TComplexQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    // Complex matrixes
    function ToString(const AQuantity: TC2MatrixQuantity): string;
    function ToVerboseString(const AQuantity: TC2MatrixQuantity): string;
    // Vector space
    function ToString(const AQuantity: TC2VecQuantity): string;
    function ToVerboseString(const AQuantity: TC2VecQuantity): string;


    function ToVector(const AQuantity: TR3VecQuantity): TR3Vector;
    function ToString(const AQuantity: TR3VecQuantity): string;
    function ToVerboseString(const AQuantity: TR3VecQuantity): string;
    // CL3 vector space, Clifford algebra
    function ToString(const AQuantity: TCL3VecQuantity): string;
    function ToString(const AQuantity: TCL3BivecQuantity): string;
    function ToString(const AQuantity: TCL3TrivecQuantity): string;
    function ToString(const AQuantity: TCL3MultivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3VecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3BivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;
  end;

 { TFactoredUnitHelper }

  TFactoredUnitHelper = record helper for TFactoredUnit
  public
    function GetName(Prefixes: TPrefixes): string;
    function GetPluralName(Prefixes: TPrefixes): string;
    function GetSymbol(Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;  
  public
    // Real numbers
    function ToFloat(const AQuantity: TQuantity): double;
    function ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
    function ToString(const AQuantity: TQuantity): string;
    function ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TQuantity): string;
    function ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    // Complex numbers
    function ToString(const AQuantity: TComplexQuantity): string;
    function ToVerboseString(const AQuantity: TComplexQuantity): string;
    // R3 vector space
    function ToString(const AQuantity: TR3VecQuantity): string;
    function ToVerboseString(const AQuantity: TR3VecQuantity): string;
    // CL3 vector space, Clifford algebra
    function ToString(const AQuantity: TCL3VecQuantity): string;
    function ToString(const AQuantity: TCL3BivecQuantity): string;
    function ToString(const AQuantity: TCL3TrivecQuantity): string;
    function ToString(const AQuantity: TCL3MultivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3VecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3BivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;
  end;

 { TDegreeCelsiusUnitHelper }

  TDegreeCelsiusUnitHelper = record helper for TDegreeCelsiusUnit
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;  
  public
    function ToFloat(const AQuantity: TQuantity): double;
    function ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
    function ToString(const AQuantity: TQuantity): string;
    function ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TQuantity): string;
    function ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
  end;

 { TDegreeFahrenheitUnitHelper }

  TDegreeFahrenheitUnitHelper = record helper for TDegreeFahrenheitUnit
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;  
  public
    function ToFloat(const AQuantity: TQuantity): double;
    function ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
    function ToString(const AQuantity: TQuantity): string;
    function ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TQuantity): string;
    function ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
  end;

