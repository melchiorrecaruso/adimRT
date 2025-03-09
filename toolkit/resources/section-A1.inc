
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

  {$I complex.inc}
  {$I scalarquantity.inc}
  {$I complexquantity.inc}
  {$I cl3.inc}
  {$I cl3quantity.inc}
  {$I vector.inc}
  {$I vectorquantity.inc}

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
    class operator *(const AQuantity: double; const ASelf: TUnit): TQuantity; inline;
    class operator /(const AQuantity: double; const ASelf: TUnit): TQuantity; inline;
    // Complex numbers
    class operator *(const AQuantity: TComplex; const ASelf: TUnit): TComplexQuantity; inline;
    class operator /(const AQuantity: TComplex; const ASelf: TUnit): TComplexQuantity; inline;
    class operator *(const ASelf: TUnit; const AQuantity: TComplex): TComplexQuantity; inline;
    class operator /(const ASelf: TUnit; const AQuantity: TComplex): TComplexQuantity; inline;
    // R3 vector space
    class operator *(const AQuantity: TR3Vector; const ASelf: TUnit): TR3VecQuantity; inline;
    class operator /(const AQuantity: TR3Vector; const ASelf: TUnit): TR3VecQuantity; inline;
    // CL3 vector space, Clifford algebra
    class operator *(const AQuantity: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;
    class operator /(const AQuantity: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;
    class operator *(const AQuantity: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;
    class operator /(const AQuantity: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;
    class operator *(const AQuantity: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;
    class operator /(const AQuantity: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;
    class operator *(const AQuantity: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;
    class operator /(const AQuantity: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;
  {$IFNDEF ADIMOFF}
    // Real numbers
    class operator *(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
    class operator /(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
    // Complex numbers
    class operator *(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;
    class operator /(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;
    class operator *(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
    // R3 vector space
    class operator *(const AQuantity: TR3VecQuantity; const ASelf: TUnit): TR3VecQuantity; inline;
    class operator /(const AQuantity: TR3VecQuantity; const ASelf: TUnit): TR3VecQuantity; inline;
    // CL3 vector space, Clifford algebra
    class operator *(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;
    class operator /(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;
    class operator *(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;
    class operator /(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;
    class operator *(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;
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
    class operator *(const AQuantity: double; const ASelf: TFactoredUnit): TQuantity; inline;
    class operator /(const AQuantity: double; const ASelf: TFactoredUnit): TQuantity; inline;
    // R3 vector space
    class operator *(const AQuantity: TR3Vector; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
    class operator /(const AQuantity: TR3Vector; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
    // CL3 vector space, Clifford algebra
    class operator *(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
    class operator /(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
    class operator *(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
    class operator /(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
    class operator *(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
    class operator /(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
  {$IFNDEF ADIMOFF}
    // Real numbers
    class operator *(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
    class operator /(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
    // R3 vector space
    class operator *(const AQuantity: TR3VecQuantity; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
    class operator /(const AQuantity: TR3VecQuantity; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
    // CL3 vector space, Clifford algebra
    class operator *(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
    class operator /(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
    class operator *(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
    class operator /(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
    class operator *(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
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
    class operator *(const AQuantity: double; const ASelf: TDegreeCelsiusUnit): TQuantity; inline;
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
    class operator *(const AQuantity: double; const ASelf: TDegreeFahrenheitUnit): TQuantity; inline;
  end;   

 { TUnitHelper }

  TUnitHelper = record helper for TUnit
  public
    function GetName(Prefixes: TPrefixes): string;
    function GetPluralName(Prefixes: TPrefixes): string;
    function GetSymbol(Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
  public
    function ToFloat(const AQuantity: TQuantity): double;
    function ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;

    function ToComplex(const AQuantity: TComplexQuantity): TComplex;
    function ToVector(const AQuantity: TVecQuantity): TR3Vector;

    function ToString(const AQuantity: TQuantity): string;
    function ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TQuantity): string;
    function ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    function ToString(const AQuantity: TVecQuantity): string;
    function ToVerboseString(const AQuantity: TVecQuantity): string;
  {$IFDEF CLIFFORD}
    function ToString(const AQuantity: TBivecQuantity): string;
    function ToString(const AQuantity: TTrivecQuantity): string;
    function ToString(const AQuantity: TMultivecQuantity): string;
  {$ENDIF}

  {$IFDEF CLIFFORD}
    function ToVerboseString(const AQuantity: TBivecQuantity): string;
    function ToVerboseString(const AQuantity: TTrivecQuantity): string;
    function ToVerboseString(const AQuantity: TMultivecQuantity): string;
  {$ENDIF}
    function ToString(const AQuantity: TComplexQuantity): string;
    function ToVerboseString(const AQuantity: TComplexQuantity): string;
  end;

 { TFactoredUnitHelper }

  TFactoredUnitHelper = record helper for TFactoredUnit
  public
    function GetName(Prefixes: TPrefixes): string;
    function GetPluralName(Prefixes: TPrefixes): string;
    function GetSymbol(Prefixes: TPrefixes): string;
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
  
    function ToString(const AQuantity: TVecQuantity): string;
  {$IFDEF CLIFFORD}
    function ToString(const AQuantity: TBivecQuantity): string;
    function ToString(const AQuantity: TTrivecQuantity): string;
    function ToString(const AQuantity: TMultivecQuantity): string;
  {$ENDIF}
    function ToVerboseString(const AQuantity: TVecQuantity): string;
  {$IFDEF CLIFFORD}
    function ToVerboseString(const AQuantity: TBivecQuantity): string;
    function ToVerboseString(const AQuantity: TTrivecQuantity): string;
    function ToVerboseString(const AQuantity: TMultivecQuantity): string;
  {$ENDIF}

    function ToString(const AQuantity: TComplexQuantity): string;
    function ToVerboseString(const AQuantity: TComplexQuantity): string;
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

