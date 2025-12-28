{
  Description: ADim Run-time library.

  Copyright (C) 2024-2025 Melchiorre Caruso <melchiorrecaruso@gmail.com>

  This library is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program. If not, see <http://www.gnu.org/licenses/>.
}

unit ADim;

{$H+}{$J-}
{$modeswitch advancedrecords}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function's return value.
{$WARN 6058 OFF} // Suppress warning for function marked as inline that cannot be inlined.

{
  ADim Run-time library built on 26/12/2025.

  Number of base units: 687
  Number of factored units: 126
}

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

  {$I base.inc}
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
    FDim: TDimension;
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
    FDim: TDimension;
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
    FDim: TDimension;
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
    FDim: TDimension;
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
    function GetValue(const AQuantity: TR2Vector; const APrefixes: TPrefixes): TR2Vector;
    function GetValue(const AQuantity: TR3Vector; const APrefixes: TPrefixes): TR3Vector;
    function GetValue(const AQuantity: TR4Vector; const APrefixes: TPrefixes): TR4Vector;
    function GetValue(const AQuantity: TC2Vector; const APrefixes: TPrefixes): TC2Vector;
    function GetValue(const AQuantity: TC3Vector; const APrefixes: TPrefixes): TC3Vector;
    function GetValue(const AQuantity: TC4Vector; const APrefixes: TPrefixes): TC4Vector;
    function GetValue(const AQuantity: TR2Matrix; const APrefixes: TPrefixes): TR2Matrix;
    function GetValue(const AQuantity: TR3Matrix; const APrefixes: TPrefixes): TR3Matrix;
    function GetValue(const AQuantity: TR4Matrix; const APrefixes: TPrefixes): TR4Matrix;
    function GetValue(const AQuantity: TC2Matrix; const APrefixes: TPrefixes): TC2Matrix;
    function GetValue(const AQuantity: TC3Matrix; const APrefixes: TPrefixes): TC3Matrix;
    function GetValue(const AQuantity: TC4Matrix; const APrefixes: TPrefixes): TC4Matrix;
    function GetValue(const AQuantity: TCL3Vector; const APrefixes: TPrefixes): TCL3Vector;
    function GetValue(const AQuantity: TCL3Bivector; const APrefixes: TPrefixes): TCL3Bivector;
    function GetValue(const AQuantity: TCL3Trivector; const APrefixes: TPrefixes): TCL3Trivector;
    function GetValue(const AQuantity: TCL3Multivector; const APrefixes: TPrefixes): TCL3Multivector;
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
    // Real vector space
    function ToVector(const AQuantity: TR2VecQuantity): TR2Vector;
    function ToVector(const AQuantity: TR3VecQuantity): TR3Vector;
    function ToVector(const AQuantity: TR4VecQuantity): TR4Vector;
    function ToVector(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): TR2Vector;
    function ToVector(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): TR3Vector;
    function ToVector(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): TR4Vector;
    function ToString(const AQuantity: TR2VecQuantity): string;
    function ToString(const AQuantity: TR3VecQuantity): string;
    function ToString(const AQuantity: TR4VecQuantity): string;
    function ToString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TR2VecQuantity): string;
    function ToVerboseString(const AQuantity: TR3VecQuantity): string;
    function ToVerboseString(const AQuantity: TR4VecQuantity): string;
    function ToVerboseString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;
    // Complex vector space
    function ToVector(const AQuantity: TC2VecQuantity): TC2Vector;
    function ToVector(const AQuantity: TC3VecQuantity): TC3Vector;
    function ToVector(const AQuantity: TC4VecQuantity): TC4Vector;
    function ToVector(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): TC2Vector;
    function ToVector(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): TC3Vector;
    function ToVector(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): TC4Vector;
    function ToString(const AQuantity: TC2VecQuantity): string;
    function ToString(const AQuantity: TC3VecQuantity): string;
    function ToString(const AQuantity: TC4VecQuantity): string;
    function ToString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TC2VecQuantity): string;
    function ToVerboseString(const AQuantity: TC3VecQuantity): string;
    function ToVerboseString(const AQuantity: TC4VecQuantity): string;
    function ToVerboseString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;
    // Real matrixes
    function ToMatrix(const AQuantity: TR2MatrixQuantity): TR2Matrix;
    function ToMatrix(const AQuantity: TR3MatrixQuantity): TR3Matrix;
    function ToMatrix(const AQuantity: TR4MatrixQuantity): TR4Matrix;
    function ToMatrix(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): TR2Matrix;
    function ToMatrix(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): TR3Matrix;
    function ToMatrix(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): TR4Matrix;
    function ToString(const AQuantity: TR2MatrixQuantity): string;
    function ToString(const AQuantity: TR3MatrixQuantity): string;
    function ToString(const AQuantity: TR4MatrixQuantity): string;
    function ToString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TR2MatrixQuantity): string;
    function ToVerboseString(const AQuantity: TR3MatrixQuantity): string;
    function ToVerboseString(const AQuantity: TR4MatrixQuantity): string;
    function ToVerboseString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;
    // Complex matrixes
    function ToMatrix(const AQuantity: TC2MatrixQuantity): TC2Matrix;
    function ToMatrix(const AQuantity: TC3MatrixQuantity): TC3Matrix;
    function ToMatrix(const AQuantity: TC4MatrixQuantity): TC4Matrix;
    function ToMatrix(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): TC2Matrix;
    function ToMatrix(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): TC3Matrix;
    function ToMatrix(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): TC4Matrix;
    function ToString(const AQuantity: TC2MatrixQuantity): string;
    function ToString(const AQuantity: TC3MatrixQuantity): string;
    function ToString(const AQuantity: TC4MatrixQuantity): string;
    function ToString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TC2MatrixQuantity): string;
    function ToVerboseString(const AQuantity: TC3MatrixQuantity): string;
    function ToVerboseString(const AQuantity: TC4MatrixQuantity): string;
    function ToVerboseString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;
    // CL3 vector space, Clifford algebra
    function ToString(const AQuantity: TCL3VecQuantity): string;
    function ToString(const AQuantity: TCL3BivecQuantity): string;
    function ToString(const AQuantity: TCL3TrivecQuantity): string;
    function ToString(const AQuantity: TCL3MultivecQuantity): string;
    function ToString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TCL3VecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3BivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;
  end;

 { TFactoredUnitHelper }

  TFactoredUnitHelper = record helper for TFactoredUnit
  public
    function GetName(Prefixes: TPrefixes): string;
    function GetPluralName(Prefixes: TPrefixes): string;
    function GetSymbol(Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
    function GetValue(const AQuantity: TComplex; const APrefixes: TPrefixes): TComplex;
    function GetValue(const AQuantity: TR2Vector; const APrefixes: TPrefixes): TR2Vector;
    function GetValue(const AQuantity: TR3Vector; const APrefixes: TPrefixes): TR3Vector;
    function GetValue(const AQuantity: TR4Vector; const APrefixes: TPrefixes): TR4Vector;
    function GetValue(const AQuantity: TC2Vector; const APrefixes: TPrefixes): TC2Vector;
    function GetValue(const AQuantity: TC3Vector; const APrefixes: TPrefixes): TC3Vector;
    function GetValue(const AQuantity: TC4Vector; const APrefixes: TPrefixes): TC4Vector;
    function GetValue(const AQuantity: TR2Matrix; const APrefixes: TPrefixes): TR2Matrix;
    function GetValue(const AQuantity: TR3Matrix; const APrefixes: TPrefixes): TR3Matrix;
    function GetValue(const AQuantity: TR4Matrix; const APrefixes: TPrefixes): TR4Matrix;
    function GetValue(const AQuantity: TC2Matrix; const APrefixes: TPrefixes): TC2Matrix;
    function GetValue(const AQuantity: TC3Matrix; const APrefixes: TPrefixes): TC3Matrix;
    function GetValue(const AQuantity: TC4Matrix; const APrefixes: TPrefixes): TC4Matrix;
    function GetValue(const AQuantity: TCL3Vector; const APrefixes: TPrefixes): TCL3Vector;
    function GetValue(const AQuantity: TCL3Bivector; const APrefixes: TPrefixes): TCL3Bivector;
    function GetValue(const AQuantity: TCL3Trivector; const APrefixes: TPrefixes): TCL3Trivector;
    function GetValue(const AQuantity: TCL3Multivector; const APrefixes: TPrefixes): TCL3Multivector;
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
    // Real vector space
    function ToVector(const AQuantity: TR2VecQuantity): TR2Vector;
    function ToVector(const AQuantity: TR3VecQuantity): TR3Vector;
    function ToVector(const AQuantity: TR4VecQuantity): TR4Vector;
    function ToVector(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): TR2Vector;
    function ToVector(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): TR3Vector;
    function ToVector(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): TR4Vector;
    function ToString(const AQuantity: TR2VecQuantity): string;
    function ToString(const AQuantity: TR3VecQuantity): string;
    function ToString(const AQuantity: TR4VecQuantity): string;
    function ToString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TR2VecQuantity): string;
    function ToVerboseString(const AQuantity: TR3VecQuantity): string;
    function ToVerboseString(const AQuantity: TR4VecQuantity): string;
    function ToVerboseString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;
    // Complex vector space
    function ToVector(const AQuantity: TC2VecQuantity): TC2Vector;
    function ToVector(const AQuantity: TC3VecQuantity): TC3Vector;
    function ToVector(const AQuantity: TC4VecQuantity): TC4Vector;
    function ToVector(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): TC2Vector;
    function ToVector(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): TC3Vector;
    function ToVector(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): TC4Vector;
    function ToString(const AQuantity: TC2VecQuantity): string;
    function ToString(const AQuantity: TC3VecQuantity): string;
    function ToString(const AQuantity: TC4VecQuantity): string;
    function ToString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TC2VecQuantity): string;
    function ToVerboseString(const AQuantity: TC3VecQuantity): string;
    function ToVerboseString(const AQuantity: TC4VecQuantity): string;
    function ToVerboseString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;
    // Real matrixes
    function ToMatrix(const AQuantity: TR2MatrixQuantity): TR2Matrix;
    function ToMatrix(const AQuantity: TR3MatrixQuantity): TR3Matrix;
    function ToMatrix(const AQuantity: TR4MatrixQuantity): TR4Matrix;
    function ToMatrix(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): TR2Matrix;
    function ToMatrix(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): TR3Matrix;
    function ToMatrix(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): TR4Matrix;
    function ToString(const AQuantity: TR2MatrixQuantity): string;
    function ToString(const AQuantity: TR3MatrixQuantity): string;
    function ToString(const AQuantity: TR4MatrixQuantity): string;
    function ToString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TR2MatrixQuantity): string;
    function ToVerboseString(const AQuantity: TR3MatrixQuantity): string;
    function ToVerboseString(const AQuantity: TR4MatrixQuantity): string;
    function ToVerboseString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;
    // Complex matrixes
    function ToMatrix(const AQuantity: TC2MatrixQuantity): TC2Matrix;
    function ToMatrix(const AQuantity: TC3MatrixQuantity): TC3Matrix;
    function ToMatrix(const AQuantity: TC4MatrixQuantity): TC4Matrix;
    function ToMatrix(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): TC2Matrix;
    function ToMatrix(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): TC3Matrix;
    function ToMatrix(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): TC4Matrix;
    function ToString(const AQuantity: TC2MatrixQuantity): string;
    function ToString(const AQuantity: TC3MatrixQuantity): string;
    function ToString(const AQuantity: TC4MatrixQuantity): string;
    function ToString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TC2MatrixQuantity): string;
    function ToVerboseString(const AQuantity: TC3MatrixQuantity): string;
    function ToVerboseString(const AQuantity: TC4MatrixQuantity): string;
    function ToVerboseString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;
    // CL3 vector space, Clifford algebra
    function ToString(const AQuantity: TCL3VecQuantity): string;
    function ToString(const AQuantity: TCL3BivecQuantity): string;
    function ToString(const AQuantity: TCL3TrivecQuantity): string;
    function ToString(const AQuantity: TCL3MultivecQuantity): string;
    function ToString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TCL3VecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3BivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;
    function ToVerboseString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;
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

{ TScalar }

resourcestring
  rsScalarSymbol = '';
  rsScalarName = '';
  rsScalarPluralName = '';

const
  ScalarUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsScalarSymbol;
    FName       : rsScalarName;
    FPluralName : rsScalarPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TRadian }

resourcestring
  rsRadianSymbol = 'rad';
  rsRadianName = 'radian';
  rsRadianPluralName = 'radians';

const
  RadianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsRadianSymbol;
    FName       : rsRadianName;
    FPluralName : rsRadianPluralName;
    FPrefixes   : ();
    FExponents  : ());

var
  rad : TUnit absolute RadianUnit;

{ TDegree }

resourcestring
  rsDegreeSymbol = 'deg';
  rsDegreeName = 'degree';
  rsDegreePluralName = 'degrees';

const
  DegreeUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsDegreeSymbol;
    FName       : rsDegreeName;
    FPluralName : rsDegreePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (Pi/180));

var
  deg : TFactoredUnit absolute DegreeUnit;

{ TSteradian }

resourcestring
  rsSteradianSymbol = 'sr';
  rsSteradianName = 'steradian';
  rsSteradianPluralName = 'steradians';

const
  SteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSteradianSymbol;
    FName       : rsSteradianName;
    FPluralName : rsSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

var
  sr : TUnit absolute SteradianUnit;

{ TSquareDegree }

resourcestring
  rsSquareDegreeSymbol = 'deg²';
  rsSquareDegreeName = 'square degree';
  rsSquareDegreePluralName = 'square degrees';

const
  SquareDegreeUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSquareDegreeSymbol;
    FName       : rsSquareDegreeName;
    FPluralName : rsSquareDegreePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (Pi*Pi/32400));

var
  deg2 : TFactoredUnit absolute SquareDegreeUnit;

{ TSecond }

resourcestring
  rsSecondSymbol = '%ss';
  rsSecondName = '%ssecond';
  rsSecondPluralName = '%sseconds';

const
  SecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSecondSymbol;
    FName       : rsSecondName;
    FPluralName : rsSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  s : TUnit absolute SecondUnit;

const
  ds         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cs         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  ms         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  mis        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  ns         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  ps         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TDay }

resourcestring
  rsDaySymbol = 'd';
  rsDayName = 'day';
  rsDayPluralName = 'days';

const
  DayUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsDaySymbol;
    FName       : rsDayName;
    FPluralName : rsDayPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (86400));

var
  day : TFactoredUnit absolute DayUnit;

{ THour }

resourcestring
  rsHourSymbol = 'h';
  rsHourName = 'hour';
  rsHourPluralName = 'hours';

const
  HourUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsHourSymbol;
    FName       : rsHourName;
    FPluralName : rsHourPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (3600));

var
  hr : TFactoredUnit absolute HourUnit;

{ TMinute }

resourcestring
  rsMinuteSymbol = 'min';
  rsMinuteName = 'minute';
  rsMinutePluralName = 'minutes';

const
  MinuteUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMinuteSymbol;
    FName       : rsMinuteName;
    FPluralName : rsMinutePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (60));

var
  minute : TFactoredUnit absolute MinuteUnit;

{ TSquareSecond }

resourcestring
  rsSquareSecondSymbol = '%ss²';
  rsSquareSecondName = 'square %ssecond';
  rsSquareSecondPluralName = 'square %sseconds';

const
  SquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondSymbol;
    FName       : rsSquareSecondName;
    FPluralName : rsSquareSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  s2 : TUnit absolute SquareSecondUnit;

const
  ds2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cs2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  ms2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mis2       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  ns2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ps2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareDay }

resourcestring
  rsSquareDaySymbol = 'd²';
  rsSquareDayName = 'square day';
  rsSquareDayPluralName = 'square days';

const
  SquareDayUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareDaySymbol;
    FName       : rsSquareDayName;
    FPluralName : rsSquareDayPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (7464960000));

var
  day2 : TFactoredUnit absolute SquareDayUnit;

{ TSquareHour }

resourcestring
  rsSquareHourSymbol = 'h²';
  rsSquareHourName = 'square hour';
  rsSquareHourPluralName = 'square hours';

const
  SquareHourUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareHourSymbol;
    FName       : rsSquareHourName;
    FPluralName : rsSquareHourPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (12960000));

var
  hr2 : TFactoredUnit absolute SquareHourUnit;

{ TSquareMinute }

resourcestring
  rsSquareMinuteSymbol = 'min²';
  rsSquareMinuteName = 'square minute';
  rsSquareMinutePluralName = 'square minutes';

const
  SquareMinuteUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMinuteSymbol;
    FName       : rsSquareMinuteName;
    FPluralName : rsSquareMinutePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (3600));

var
  minute2 : TFactoredUnit absolute SquareMinuteUnit;

{ TCubicSecond }

resourcestring
  rsCubicSecondSymbol = '%ss³';
  rsCubicSecondName = 'cubic %ssecond';
  rsCubicSecondPluralName = 'cubic %sseconds';

const
  CubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondSymbol;
    FName       : rsCubicSecondName;
    FPluralName : rsCubicSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

var
  s3 : TUnit absolute CubicSecondUnit;

const
  ds3        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  cs3        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  ms3        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  mis3       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ns3        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-27); {$ELSE} (1E-27); {$ENDIF}
  ps3        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}

{ TQuarticSecond }

resourcestring
  rsQuarticSecondSymbol = '%ss⁴';
  rsQuarticSecondName = 'quartic %ssecond';
  rsQuarticSecondPluralName = 'quartic %sseconds';

const
  QuarticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondSymbol;
    FName       : rsQuarticSecondName;
    FPluralName : rsQuarticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (4));

var
  s4 : TUnit absolute QuarticSecondUnit;

const
  ds4        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cs4        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  ms4        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mis4       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  ns4        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  ps4        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-48); {$ELSE} (1E-48); {$ENDIF}

{ TQuinticSecond }

resourcestring
  rsQuinticSecondSymbol = '%ss⁵';
  rsQuinticSecondName = 'quintic %ssecond';
  rsQuinticSecondPluralName = 'quintic %sseconds';

const
  QuinticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 300; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuinticSecondSymbol;
    FName       : rsQuinticSecondName;
    FPluralName : rsQuinticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

var
  s5 : TUnit absolute QuinticSecondUnit;

const
  ds5        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 300; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  cs5        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 300; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  ms5        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 300; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}
  mis5       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 300; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}
  ns5        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 300; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-45); {$ELSE} (1E-45); {$ENDIF}
  ps5        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 300; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-60); {$ELSE} (1E-60); {$ENDIF}

{ TSexticSecond }

resourcestring
  rsSexticSecondSymbol = '%ss⁶';
  rsSexticSecondName = 'sextic %ssecond';
  rsSexticSecondPluralName = 'sextic %sseconds';

const
  SexticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticSecondSymbol;
    FName       : rsSexticSecondName;
    FPluralName : rsSexticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (6));

var
  s6 : TUnit absolute SexticSecondUnit;

const
  ds6        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  cs6        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  ms6        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  mis6       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  ns6        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-54); {$ELSE} (1E-54); {$ENDIF}
  ps6        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-72); {$ELSE} (1E-72); {$ENDIF}

{ TMeter }

resourcestring
  rsMeterSymbol = '%sm';
  rsMeterName = '%smeter';
  rsMeterPluralName = '%smeters';

const
  MeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterSymbol;
    FName       : rsMeterName;
    FPluralName : rsMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  m : TUnit absolute MeterUnit;

const
  km         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  dm         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cm         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mm         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  mim        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nm         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pm         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TAstronomical }

resourcestring
  rsAstronomicalSymbol = 'au';
  rsAstronomicalName = 'astronomical unit';
  rsAstronomicalPluralName = 'astronomical units';

const
  AstronomicalUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsAstronomicalSymbol;
    FName       : rsAstronomicalName;
    FPluralName : rsAstronomicalPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (149597870691));

var
  au : TFactoredUnit absolute AstronomicalUnit;

{ TInch }

resourcestring
  rsInchSymbol = 'in';
  rsInchName = 'inch';
  rsInchPluralName = 'inches';

const
  InchUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsInchSymbol;
    FName       : rsInchName;
    FPluralName : rsInchPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.0254));

var
  inch : TFactoredUnit absolute InchUnit;

{ TFoot }

resourcestring
  rsFootSymbol = 'ft';
  rsFootName = 'foot';
  rsFootPluralName = 'feet';

const
  FootUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsFootSymbol;
    FName       : rsFootName;
    FPluralName : rsFootPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.3048));

var
  ft : TFactoredUnit absolute FootUnit;

{ TYard }

resourcestring
  rsYardSymbol = 'yd';
  rsYardName = 'yard';
  rsYardPluralName = 'yards';

const
  YardUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsYardSymbol;
    FName       : rsYardName;
    FPluralName : rsYardPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.9144));

var
  yd : TFactoredUnit absolute YardUnit;

{ TMile }

resourcestring
  rsMileSymbol = 'mi';
  rsMileName = 'mile';
  rsMilePluralName = 'miles';

const
  MileUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMileSymbol;
    FName       : rsMileName;
    FPluralName : rsMilePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (1609.344));

var
  mi : TFactoredUnit absolute MileUnit;

{ TNauticalMile }

resourcestring
  rsNauticalMileSymbol = 'nmi';
  rsNauticalMileName = 'nautical mile';
  rsNauticalMilePluralName = 'nautical miles';

const
  NauticalMileUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNauticalMileSymbol;
    FName       : rsNauticalMileName;
    FPluralName : rsNauticalMilePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (1852));

var
  nmi : TFactoredUnit absolute NauticalMileUnit;

{ TAngstrom }

resourcestring
  rsAngstromSymbol = '%sÅ';
  rsAngstromName = '%sangstrom';
  rsAngstromPluralName = '%sangstroms';

const
  AngstromUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsAngstromSymbol;
    FName       : rsAngstromName;
    FPluralName : rsAngstromPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (1E-10));

var
  angstrom : TFactoredUnit absolute AngstromUnit;

{ TSquareRootMeter }

resourcestring
  rsSquareRootMeterSymbol = '√%sm';
  rsSquareRootMeterName = 'square root %smeter';
  rsSquareRootMeterPluralName = 'square root %smeters';

const
  SquareRootMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 30; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootMeterSymbol;
    FName       : rsSquareRootMeterName;
    FPluralName : rsSquareRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareMeter }

resourcestring
  rsSquareMeterSymbol = '%sm²';
  rsSquareMeterName = 'square %smeter';
  rsSquareMeterPluralName = 'square %smeters';

const
  SquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterSymbol;
    FName       : rsSquareMeterName;
    FPluralName : rsSquareMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  m2 : TUnit absolute SquareMeterUnit;

const
  km2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  dm2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cm2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mm2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mim2       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nm2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  pm2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareInch }

resourcestring
  rsSquareInchSymbol = 'in²';
  rsSquareInchName = 'square inch';
  rsSquareInchPluralName = 'square inches';

const
  SquareInchUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareInchSymbol;
    FName       : rsSquareInchName;
    FPluralName : rsSquareInchPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.00064516));

var
  inch2 : TFactoredUnit absolute SquareInchUnit;

{ TSquareFoot }

resourcestring
  rsSquareFootSymbol = 'ft²';
  rsSquareFootName = 'square foot';
  rsSquareFootPluralName = 'square feet';

const
  SquareFootUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareFootSymbol;
    FName       : rsSquareFootName;
    FPluralName : rsSquareFootPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.09290304));

var
  ft2 : TFactoredUnit absolute SquareFootUnit;

{ TSquareYard }

resourcestring
  rsSquareYardSymbol = 'yd²';
  rsSquareYardName = 'square yard';
  rsSquareYardPluralName = 'square yards';

const
  SquareYardUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareYardSymbol;
    FName       : rsSquareYardName;
    FPluralName : rsSquareYardPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.83612736));

var
  yd2 : TFactoredUnit absolute SquareYardUnit;

{ TSquareMile }

resourcestring
  rsSquareMileSymbol = 'mi²';
  rsSquareMileName = 'square mile';
  rsSquareMilePluralName = 'square miles';

const
  SquareMileUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMileSymbol;
    FName       : rsSquareMileName;
    FPluralName : rsSquareMilePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (2589988.110336));

var
  mi2 : TFactoredUnit absolute SquareMileUnit;

{ TCubicMeter }

resourcestring
  rsCubicMeterSymbol = '%sm³';
  rsCubicMeterName = 'cubic %smeter';
  rsCubicMeterPluralName = 'cubic %smeters';

const
  CubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterSymbol;
    FName       : rsCubicMeterName;
    FPluralName : rsCubicMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

var
  m3 : TUnit absolute CubicMeterUnit;

const
  km3        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  dm3        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  cm3        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mm3        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  mim3       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  nm3        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-27); {$ELSE} (1E-27); {$ENDIF}
  pm3        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}

{ TCubicInch }

resourcestring
  rsCubicInchSymbol = 'in³';
  rsCubicInchName = 'cubic inch';
  rsCubicInchPluralName = 'cubic inches';

const
  CubicInchUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicInchSymbol;
    FName       : rsCubicInchName;
    FPluralName : rsCubicInchPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.000016387064));

var
  inch3 : TFactoredUnit absolute CubicInchUnit;

{ TCubicFoot }

resourcestring
  rsCubicFootSymbol = 'ft³';
  rsCubicFootName = 'cubic foot';
  rsCubicFootPluralName = 'cubic feet';

const
  CubicFootUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicFootSymbol;
    FName       : rsCubicFootName;
    FPluralName : rsCubicFootPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.028316846592));

var
  ft3 : TFactoredUnit absolute CubicFootUnit;

{ TCubicYard }

resourcestring
  rsCubicYardSymbol = 'yd³';
  rsCubicYardName = 'cubic yard';
  rsCubicYardPluralName = 'cubic yards';

const
  CubicYardUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicYardSymbol;
    FName       : rsCubicYardName;
    FPluralName : rsCubicYardPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.764554857984));

var
  yd3 : TFactoredUnit absolute CubicYardUnit;

{ TLitre }

resourcestring
  rsLitreSymbol = '%sL';
  rsLitreName = '%slitre';
  rsLitrePluralName = '%slitres';

const
  LitreUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsLitreSymbol;
    FName       : rsLitreName;
    FPluralName : rsLitrePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (1E-03));

var
  L : TFactoredUnit absolute LitreUnit;

const
  dL         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03 * 1E-01); {$ELSE} (1E-03 * 1E-01); {$ENDIF}
  cL         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03 * 1E-02); {$ELSE} (1E-03 * 1E-02); {$ENDIF}
  mL         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03 * 1E-03); {$ELSE} (1E-03 * 1E-03); {$ENDIF}

{ TGallon }

resourcestring
  rsGallonSymbol = 'gal';
  rsGallonName = 'gallon';
  rsGallonPluralName = 'gallons';

const
  GallonUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsGallonSymbol;
    FName       : rsGallonName;
    FPluralName : rsGallonPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.0037854119678));

var
  gal : TFactoredUnit absolute GallonUnit;

{ TQuarticMeter }

resourcestring
  rsQuarticMeterSymbol = '%sm⁴';
  rsQuarticMeterName = 'quartic %smeter';
  rsQuarticMeterPluralName = 'quartic %smeters';

const
  QuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticMeterSymbol;
    FName       : rsQuarticMeterName;
    FPluralName : rsQuarticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (4));

var
  m4 : TUnit absolute QuarticMeterUnit;

const
  km4        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  dm4        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cm4        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  mm4        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mim4       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  nm4        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  pm4        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-48); {$ELSE} (1E-48); {$ENDIF}

{ TQuinticMeter }

resourcestring
  rsQuinticMeterSymbol = '%sm⁵';
  rsQuinticMeterName = 'quintic %smeter';
  rsQuinticMeterPluralName = 'quintic %smeters';

const
  QuinticMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 300; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuinticMeterSymbol;
    FName       : rsQuinticMeterName;
    FPluralName : rsQuinticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

var
  m5 : TUnit absolute QuinticMeterUnit;

const
  km5        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 300; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+15); {$ELSE} (1E+15); {$ENDIF}
  dm5        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 300; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  cm5        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 300; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  mm5        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 300; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}
  mim5       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 300; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}
  nm5        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 300; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-45); {$ELSE} (1E-45); {$ENDIF}
  pm5        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 300; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-60); {$ELSE} (1E-60); {$ENDIF}

{ TSexticMeter }

resourcestring
  rsSexticMeterSymbol = '%sm⁶';
  rsSexticMeterName = 'sextic %smeter';
  rsSexticMeterPluralName = 'sextic %smeters';

const
  SexticMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 360; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticMeterSymbol;
    FName       : rsSexticMeterName;
    FPluralName : rsSexticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (6));

var
  m6 : TUnit absolute SexticMeterUnit;

const
  km6        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 360; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  dm6        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 360; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  cm6        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 360; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mm6        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 360; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  mim6       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 360; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  nm6        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 360; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-54); {$ELSE} (1E-54); {$ENDIF}
  pm6        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 360; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-72); {$ELSE} (1E-72); {$ENDIF}

{ TKilogram }

resourcestring
  rsKilogramSymbol = '%sg';
  rsKilogramName = '%sgram';
  rsKilogramPluralName = '%sgrams';

const
  KilogramUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSymbol;
    FName       : rsKilogramName;
    FPluralName : rsKilogramPluralName;
    FPrefixes   : (pKilo);
    FExponents  : (1));

var
  kg : TUnit absolute KilogramUnit;

const
  hg         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  dag        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  g          : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  dg         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cg         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  mg         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mig        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  ng         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  pg         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}

{ TTonne }

resourcestring
  rsTonneSymbol = '%st';
  rsTonneName = '%stonne';
  rsTonnePluralName = '%stonnes';

const
  TonneUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsTonneSymbol;
    FName       : rsTonneName;
    FPluralName : rsTonnePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (1E+03));

var
  tonne : TFactoredUnit absolute TonneUnit;

const
  gigatonne  : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03 * 1E+09); {$ELSE} (1E+03 * 1E+09); {$ENDIF}
  megatonne  : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03 * 1E+06); {$ELSE} (1E+03 * 1E+06); {$ENDIF}
  kilotonne  : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03 * 1E+03); {$ELSE} (1E+03 * 1E+03); {$ENDIF}

{ TPound }

resourcestring
  rsPoundSymbol = 'lb';
  rsPoundName = 'pound';
  rsPoundPluralName = 'pounds';

const
  PoundUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsPoundSymbol;
    FName       : rsPoundName;
    FPluralName : rsPoundPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.45359237));

var
  lb : TFactoredUnit absolute PoundUnit;

{ TOunce }

resourcestring
  rsOunceSymbol = 'oz';
  rsOunceName = 'ounce';
  rsOuncePluralName = 'ounces';

const
  OunceUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsOunceSymbol;
    FName       : rsOunceName;
    FPluralName : rsOuncePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.028349523125));

var
  oz : TFactoredUnit absolute OunceUnit;

{ TStone }

resourcestring
  rsStoneSymbol = 'st';
  rsStoneName = 'stone';
  rsStonePluralName = 'stones';

const
  StoneUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsStoneSymbol;
    FName       : rsStoneName;
    FPluralName : rsStonePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (6.35029318));

var
  st : TFactoredUnit absolute StoneUnit;

{ TTon }

resourcestring
  rsTonSymbol = 'ton';
  rsTonName = 'ton';
  rsTonPluralName = 'tons';

const
  TonUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsTonSymbol;
    FName       : rsTonName;
    FPluralName : rsTonPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (907.18474));

var
  ton : TFactoredUnit absolute TonUnit;

{ TElectronvoltPerSquareSpeedOfLight }

resourcestring
  rsElectronvoltPerSquareSpeedOfLightSymbol = '%seV/c²';
  rsElectronvoltPerSquareSpeedOfLightName = '%selectronvolt per squared speed of light';
  rsElectronvoltPerSquareSpeedOfLightPluralName = '%selectronvolts per squared speed of light';

const
  ElectronvoltPerSquareSpeedOfLightUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsElectronvoltPerSquareSpeedOfLightSymbol;
    FName       : rsElectronvoltPerSquareSpeedOfLightName;
    FPluralName : rsElectronvoltPerSquareSpeedOfLightPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (1.7826619216279E-36));

{ TSquareKilogram }

resourcestring
  rsSquareKilogramSymbol = '%sg²';
  rsSquareKilogramName = 'square %sgram';
  rsSquareKilogramPluralName = 'square %sgrams';

const
  SquareKilogramUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramSymbol;
    FName       : rsSquareKilogramName;
    FPluralName : rsSquareKilogramPluralName;
    FPrefixes   : (pKilo);
    FExponents  : (2));

var
  kg2 : TUnit absolute SquareKilogramUnit;

const
  hg2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  dag2       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  g2         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  dg2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  cg2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  mg2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mig2       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ng2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  pg2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}

{ TAmpere }

resourcestring
  rsAmpereSymbol = '%sA';
  rsAmpereName = '%sampere';
  rsAmperePluralName = '%samperes';

const
  AmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsAmpereSymbol;
    FName       : rsAmpereName;
    FPluralName : rsAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  A : TUnit absolute AmpereUnit;

const
  kA         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hA         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daA        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}
  dA         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cA         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mA         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miA        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nA         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  picoA      : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TSquareAmpere }

resourcestring
  rsSquareAmpereSymbol = '%sA²';
  rsSquareAmpereName = 'square %sampere';
  rsSquareAmperePluralName = 'square %samperes';

const
  SquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareAmpereSymbol;
    FName       : rsSquareAmpereName;
    FPluralName : rsSquareAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  A2 : TUnit absolute SquareAmpereUnit;

const
  kA2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hA2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daA2       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  dA2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cA2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mA2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  miA2       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nA2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  picoA2     : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TKelvin }

resourcestring
  rsKelvinSymbol = '%sK';
  rsKelvinName = '%skelvin';
  rsKelvinPluralName = '%skelvins';

const
  KelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKelvinSymbol;
    FName       : rsKelvinName;
    FPluralName : rsKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  K : TUnit absolute KelvinUnit;

{ TDegreeCelsius }

resourcestring
  rsDegreeCelsiusSymbol = '°C';
  rsDegreeCelsiusName = 'degree Celsius';
  rsDegreeCelsiusPluralName = 'degrees Celsius';

const
  DegreeCelsiusUnit : TDegreeCelsiusUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsDegreeCelsiusSymbol;
    FName       : rsDegreeCelsiusName;
    FPluralName : rsDegreeCelsiusPluralName;
    FPrefixes   : ();
    FExponents  : ());

var
  degC : TDegreeCelsiusUnit absolute DegreeCelsiusUnit;

{ TDegreeFahrenheit }

resourcestring
  rsDegreeFahrenheitSymbol = '°F';
  rsDegreeFahrenheitName = 'degree Fahrenheit';
  rsDegreeFahrenheitPluralName = 'degrees Fahrenheit';

const
  DegreeFahrenheitUnit : TDegreeFahrenheitUnit = (
    FDim               : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol            : rsDegreeFahrenheitSymbol;
    FName              : rsDegreeFahrenheitName;
    FPluralName        : rsDegreeFahrenheitPluralName;
    FPrefixes          : ();
    FExponents         : ());

var
  degF : TDegreeFahrenheitUnit absolute DegreeFahrenheitUnit;

{ TSquareKelvin }

resourcestring
  rsSquareKelvinSymbol = '%sK²';
  rsSquareKelvinName = 'square %skelvin';
  rsSquareKelvinPluralName = 'square %skelvins';

const
  SquareKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 120; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKelvinSymbol;
    FName       : rsSquareKelvinName;
    FPluralName : rsSquareKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  K2 : TUnit absolute SquareKelvinUnit;

{ TCubicKelvin }

resourcestring
  rsCubicKelvinSymbol = '%sK³';
  rsCubicKelvinName = 'cubic %skelvin';
  rsCubicKelvinPluralName = 'cubic %skelvins';

const
  CubicKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 180; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicKelvinSymbol;
    FName       : rsCubicKelvinName;
    FPluralName : rsCubicKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

var
  K3 : TUnit absolute CubicKelvinUnit;

{ TQuarticKelvin }

resourcestring
  rsQuarticKelvinSymbol = '%sK⁴';
  rsQuarticKelvinName = 'quartic %skelvin';
  rsQuarticKelvinPluralName = 'quartic %skelvins';

const
  QuarticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticKelvinSymbol;
    FName       : rsQuarticKelvinName;
    FPluralName : rsQuarticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (4));

var
  K4 : TUnit absolute QuarticKelvinUnit;

{ TMole }

resourcestring
  rsMoleSymbol = '%smol';
  rsMoleName = '%smole';
  rsMolePluralName = '%smoles';

const
  MoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMoleSymbol;
    FName       : rsMoleName;
    FPluralName : rsMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  mol : TUnit absolute MoleUnit;

const
  kmol       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0); FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hmol       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0); FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  damol      : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0); FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}

{ TCandela }

resourcestring
  rsCandelaSymbol = '%scd';
  rsCandelaName = '%scandela';
  rsCandelaPluralName = '%scandelas';

const
  CandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 0);
    FSymbol     : rsCandelaSymbol;
    FName       : rsCandelaName;
    FPluralName : rsCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  cd : TUnit absolute CandelaUnit;

{ THertz }

resourcestring
  rsHertzSymbol = '%sHz';
  rsHertzName = '%shertz';
  rsHertzPluralName = '%shertz';

const
  HertzUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsHertzSymbol;
    FName       : rsHertzName;
    FPluralName : rsHertzPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  Hz : TUnit absolute HertzUnit;

const
  THz        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GHz        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MHz        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kHz        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TReciprocalSecond }

resourcestring
  rsReciprocalSecondSymbol = '1/%ss';
  rsReciprocalSecondName = 'reciprocal %ssecond';
  rsReciprocalSecondPluralName = 'reciprocal %sseconds';

const
  ReciprocalSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSecondSymbol;
    FName       : rsReciprocalSecondName;
    FPluralName : rsReciprocalSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TRadianPerSecond }

resourcestring
  rsRadianPerSecondSymbol = 'rad/%ss';
  rsRadianPerSecondName = 'radian per %ssecond';
  rsRadianPerSecondPluralName = 'radians per %ssecond';

const
  RadianPerSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsRadianPerSecondSymbol;
    FName       : rsRadianPerSecondName;
    FPluralName : rsRadianPerSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TSquareHertz }

resourcestring
  rsSquareHertzSymbol = '%sHz²';
  rsSquareHertzName = 'square %shertz';
  rsSquareHertzPluralName = 'square %shertz';

const
  SquareHertzUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareHertzSymbol;
    FName       : rsSquareHertzName;
    FPluralName : rsSquareHertzPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  Hz2 : TUnit absolute SquareHertzUnit;

const
  THz2       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+24); {$ELSE} (1E+24); {$ENDIF}
  GHz2       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MHz2       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kHz2       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}

{ TReciprocalSquareSecond }

resourcestring
  rsReciprocalSquareSecondSymbol = '1/%ss²';
  rsReciprocalSquareSecondName = 'reciprocal square %ssecond';
  rsReciprocalSquareSecondPluralName = 'reciprocal square %sseconds';

const
  ReciprocalSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareSecondSymbol;
    FName       : rsReciprocalSquareSecondName;
    FPluralName : rsReciprocalSquareSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TRadianPerSquareSecond }

resourcestring
  rsRadianPerSquareSecondSymbol = 'rad/%ss²';
  rsRadianPerSquareSecondName = 'radian per square %ssecond';
  rsRadianPerSquareSecondPluralName = 'radians per square %ssecond';

const
  RadianPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsRadianPerSquareSecondSymbol;
    FName       : rsRadianPerSquareSecondName;
    FPluralName : rsRadianPerSquareSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TSteradianPerSquareSecond }

resourcestring
  rsSteradianPerSquareSecondSymbol = 'sr/%ss²';
  rsSteradianPerSquareSecondName = 'steradian per square %ssecond';
  rsSteradianPerSquareSecondPluralName = 'steradians per square %ssecond';

const
  SteradianPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSteradianPerSquareSecondSymbol;
    FName       : rsSteradianPerSquareSecondName;
    FPluralName : rsSteradianPerSquareSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TMeterPerSecond, unit of measurement for speed. }

resourcestring
  rsMeterPerSecondSymbol = '%sm/%ss';
  rsMeterPerSecondName = '%smeter per %ssecond';
  rsMeterPerSecondPluralName = '%smeters per %ssecond';

const
  MeterPerSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerSecondSymbol;
    FName       : rsMeterPerSecondName;
    FPluralName : rsMeterPerSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TMeterPerHour }

resourcestring
  rsMeterPerHourSymbol = '%sm/h';
  rsMeterPerHourName = '%smeter per hour';
  rsMeterPerHourPluralName = '%smeters per hour';

const
  MeterPerHourUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerHourSymbol;
    FName       : rsMeterPerHourName;
    FPluralName : rsMeterPerHourPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (1/3600));

{ TMilePerHour }

resourcestring
  rsMilePerHourSymbol = 'mi/h';
  rsMilePerHourName = 'mile per hour';
  rsMilePerHourPluralName = 'miles per hour';

const
  MilePerHourUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMilePerHourSymbol;
    FName       : rsMilePerHourName;
    FPluralName : rsMilePerHourPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.44704));

{ TNauticalMilePerHour }

resourcestring
  rsNauticalMilePerHourSymbol = 'nmi/h';
  rsNauticalMilePerHourName = 'nautical mile per hour';
  rsNauticalMilePerHourPluralName = 'nautical miles per hour';

const
  NauticalMilePerHourUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNauticalMilePerHourSymbol;
    FName       : rsNauticalMilePerHourName;
    FPluralName : rsNauticalMilePerHourPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (463/900));

{ TMeterPerSquareSecond, unit of measurement for acceleration. }

resourcestring
  rsMeterPerSquareSecondSymbol = '%sm/%ss²';
  rsMeterPerSquareSecondName = '%smeter per %ssecond squared';
  rsMeterPerSquareSecondPluralName = '%smeters per %ssecond squared';

const
  MeterPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerSquareSecondSymbol;
    FName       : rsMeterPerSquareSecondName;
    FPluralName : rsMeterPerSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TMeterPerSecondPerSecond }

resourcestring
  rsMeterPerSecondPerSecondSymbol = '%sm/%ss/%ss';
  rsMeterPerSecondPerSecondName = '%smeter per %ssecond per %ssecond';
  rsMeterPerSecondPerSecondPluralName = '%smeters per %ssecond per %ssecond';

const
  MeterPerSecondPerSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerSecondPerSecondSymbol;
    FName       : rsMeterPerSecondPerSecondName;
    FPluralName : rsMeterPerSecondPerSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TMeterPerHourPerSecond }

resourcestring
  rsMeterPerHourPerSecondSymbol = '%sm/h/%ss';
  rsMeterPerHourPerSecondName = '%smeter per hour per %ssecond';
  rsMeterPerHourPerSecondPluralName = '%smeters per hour per %ssecond';

const
  MeterPerHourPerSecondUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerHourPerSecondSymbol;
    FName       : rsMeterPerHourPerSecondName;
    FPluralName : rsMeterPerHourPerSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1);
    FFactor     : (1/3600));

{ TMeterPerCubicSecond }

resourcestring
  rsMeterPerCubicSecondSymbol = '%sm/%ss³';
  rsMeterPerCubicSecondName = '%smeter per cubic %ssecond';
  rsMeterPerCubicSecondPluralName = '%smeters per cubic %ssecond';

const
  MeterPerCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerCubicSecondSymbol;
    FName       : rsMeterPerCubicSecondName;
    FPluralName : rsMeterPerCubicSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TMeterPerQuarticSecond }

resourcestring
  rsMeterPerQuarticSecondSymbol = '%sm/%ss⁴';
  rsMeterPerQuarticSecondName = '%smeter per quartic %ssecond';
  rsMeterPerQuarticSecondPluralName = '%smeters per quartic %ssecond';

const
  MeterPerQuarticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerQuarticSecondSymbol;
    FName       : rsMeterPerQuarticSecondName;
    FPluralName : rsMeterPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -4));

{ TMeterPerQuinticSecond }

resourcestring
  rsMeterPerQuinticSecondSymbol = '%sm/%ss⁵';
  rsMeterPerQuinticSecondName = '%smeter per quintic %ssecond';
  rsMeterPerQuinticSecondPluralName = '%smeters per quintic %ssecond';

const
  MeterPerQuinticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -300; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerQuinticSecondSymbol;
    FName       : rsMeterPerQuinticSecondName;
    FPluralName : rsMeterPerQuinticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -5));

{ TMeterPerSexticSecond }

resourcestring
  rsMeterPerSexticSecondSymbol = '%sm/%ss⁶';
  rsMeterPerSexticSecondName = '%smeter per sextic %ssecond';
  rsMeterPerSexticSecondPluralName = '%smeters per sextic %ssecond';

const
  MeterPerSexticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerSexticSecondSymbol;
    FName       : rsMeterPerSexticSecondName;
    FPluralName : rsMeterPerSexticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -6));

{ TSquareMeterPerSquareSecond }

resourcestring
  rsSquareMeterPerSquareSecondSymbol = '%sm²/%ss²';
  rsSquareMeterPerSquareSecondName = 'square %smeter per square %ssecond';
  rsSquareMeterPerSquareSecondPluralName = 'square %smeters per square %ssecond';

const
  SquareMeterPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerSquareSecondSymbol;
    FName       : rsSquareMeterPerSquareSecondName;
    FPluralName : rsSquareMeterPerSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TJoulePerKilogram }

resourcestring
  rsJoulePerKilogramSymbol = '%sJ/%sg';
  rsJoulePerKilogramName = '%sjoule per %sgram';
  rsJoulePerKilogramPluralName = '%sjoules per %sgram';

const
  JoulePerKilogramUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJoulePerKilogramSymbol;
    FName       : rsJoulePerKilogramName;
    FPluralName : rsJoulePerKilogramPluralName;
    FPrefixes   : (pNone, pKilo);
    FExponents  : (1, -1));

{ TGray }

resourcestring
  rsGraySymbol = '%sGy';
  rsGrayName = '%sgray';
  rsGrayPluralName = '%sgrays';

const
  GrayUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsGraySymbol;
    FName       : rsGrayName;
    FPluralName : rsGrayPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  Gy : TUnit absolute GrayUnit;

const
  kGy        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mGy        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miGy       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nGy        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TSievert }

resourcestring
  rsSievertSymbol = '%sSv';
  rsSievertName = '%ssievert';
  rsSievertPluralName = '%ssieverts';

const
  SievertUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSievertSymbol;
    FName       : rsSievertName;
    FPluralName : rsSievertPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  Sv : TUnit absolute SievertUnit;

const
  kSv        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mSv        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miSv       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nSv        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TMeterSecond }

resourcestring
  rsMeterSecondSymbol = '%sm∙%ss';
  rsMeterSecondName = '%smeter %ssecond';
  rsMeterSecondPluralName = '%smeter %sseconds';

const
  MeterSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterSecondSymbol;
    FName       : rsMeterSecondName;
    FPluralName : rsMeterSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TKilogramMeter }

resourcestring
  rsKilogramMeterSymbol = '%sg∙%sm';
  rsKilogramMeterName = '%sgram %smeter';
  rsKilogramMeterPluralName = '%sgram %smeters';

const
  KilogramMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramMeterSymbol;
    FName       : rsKilogramMeterName;
    FPluralName : rsKilogramMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, 1));

{ TKilogramPerSecond }

resourcestring
  rsKilogramPerSecondSymbol = '%sg/%ss';
  rsKilogramPerSecondName = '%sgram per %ssecond';
  rsKilogramPerSecondPluralName = '%sgrams per %ssecond';

const
  KilogramPerSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerSecondSymbol;
    FName       : rsKilogramPerSecondName;
    FPluralName : rsKilogramPerSecondPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, -1));

{ TJoulePerSquareMeterPerHertz }

resourcestring
  rsJoulePerSquareMeterPerHertzSymbol = '%sJ/%sm²/%sHz';
  rsJoulePerSquareMeterPerHertzName = '%sjoule per square %smeter per %shertz';
  rsJoulePerSquareMeterPerHertzPluralName = '%sjoules per square %smeter per %shertz';

const
  JoulePerSquareMeterPerHertzUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJoulePerSquareMeterPerHertzSymbol;
    FName       : rsJoulePerSquareMeterPerHertzName;
    FPluralName : rsJoulePerSquareMeterPerHertzPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -1));

{ TKilogramMeterPerSecond }

resourcestring
  rsKilogramMeterPerSecondSymbol = '%sg∙%sm/%ss';
  rsKilogramMeterPerSecondName = '%sgram %smeter per %ssecond';
  rsKilogramMeterPerSecondPluralName = '%sgram %smeters per %ssecond';

const
  KilogramMeterPerSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramMeterPerSecondSymbol;
    FName       : rsKilogramMeterPerSecondName;
    FPluralName : rsKilogramMeterPerSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TNewtonSecond }

resourcestring
  rsNewtonSecondSymbol = '%sN∙%ss';
  rsNewtonSecondName = '%snewton %ssecond';
  rsNewtonSecondPluralName = '%snewton %sseconds';

const
  NewtonSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonSecondSymbol;
    FName       : rsNewtonSecondName;
    FPluralName : rsNewtonSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TSquareKilogramSquareMeterPerSquareSecond }

resourcestring
  rsSquareKilogramSquareMeterPerSquareSecondSymbol = '%sg²∙%sm²/%ss²';
  rsSquareKilogramSquareMeterPerSquareSecondName = 'square%sgram square%smeter per square%ssecond';
  rsSquareKilogramSquareMeterPerSquareSecondPluralName = 'square%sgram square%smeters per square%ssecond';

const
  SquareKilogramSquareMeterPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramSquareMeterPerSquareSecondSymbol;
    FName       : rsSquareKilogramSquareMeterPerSquareSecondName;
    FPluralName : rsSquareKilogramSquareMeterPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (2, 2, -2));

{ TReciprocalSquareRootMeter }

resourcestring
  rsReciprocalSquareRootMeterSymbol = '1/√%sm';
  rsReciprocalSquareRootMeterName = 'reciprocal square root %smeter';
  rsReciprocalSquareRootMeterPluralName = 'reciprocal square root %smeters';

const
  ReciprocalSquareRootMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -30; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootMeterSymbol;
    FName       : rsReciprocalSquareRootMeterName;
    FPluralName : rsReciprocalSquareRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalMeter }

resourcestring
  rsReciprocalMeterSymbol = '1/%sm';
  rsReciprocalMeterName = 'reciprocal %smeter';
  rsReciprocalMeterPluralName = 'reciprocal %smeters';

const
  ReciprocalMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalMeterSymbol;
    FName       : rsReciprocalMeterName;
    FPluralName : rsReciprocalMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TDioptre }

resourcestring
  rsDioptreSymbol = 'dpt';
  rsDioptreName = '%sdioptre';
  rsDioptrePluralName = '%sdioptres';

const
  DioptreUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsDioptreSymbol;
    FName       : rsDioptreName;
    FPluralName : rsDioptrePluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalSquareRootCubicMeter }

resourcestring
  rsReciprocalSquareRootCubicMeterSymbol = '1/√%sm³';
  rsReciprocalSquareRootCubicMeterName = 'reciprocal square root cubic %smeter';
  rsReciprocalSquareRootCubicMeterPluralName = 'reciprocal square root cubic %smeters';

const
  ReciprocalSquareRootCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -90; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootCubicMeterSymbol;
    FName       : rsReciprocalSquareRootCubicMeterName;
    FPluralName : rsReciprocalSquareRootCubicMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareMeter }

resourcestring
  rsReciprocalSquareMeterSymbol = '1/%sm²';
  rsReciprocalSquareMeterName = 'reciprocal square %smeter';
  rsReciprocalSquareMeterPluralName = 'reciprocal square %smeters';

const
  ReciprocalSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareMeterSymbol;
    FName       : rsReciprocalSquareMeterName;
    FPluralName : rsReciprocalSquareMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TReciprocalCubicMeter }

resourcestring
  rsReciprocalCubicMeterSymbol = '1/%sm³';
  rsReciprocalCubicMeterName = 'reciprocal cubic %smeter';
  rsReciprocalCubicMeterPluralName = 'reciprocal cubic %smeters';

const
  ReciprocalCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicMeterSymbol;
    FName       : rsReciprocalCubicMeterName;
    FPluralName : rsReciprocalCubicMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalQuarticMeter }

resourcestring
  rsReciprocalQuarticMeterSymbol = '1/%sm⁴';
  rsReciprocalQuarticMeterName = 'reciprocal quartic %smeter';
  rsReciprocalQuarticMeterPluralName = 'reciprocal quartic %smeters';

const
  ReciprocalQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticMeterSymbol;
    FName       : rsReciprocalQuarticMeterName;
    FPluralName : rsReciprocalQuarticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-4));

{ TKilogramSquareMeter }

resourcestring
  rsKilogramSquareMeterSymbol = '%sg∙%sm²';
  rsKilogramSquareMeterName = '%sgram square %smeter';
  rsKilogramSquareMeterPluralName = '%sgram square %smeters';

const
  KilogramSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterSymbol;
    FName       : rsKilogramSquareMeterName;
    FPluralName : rsKilogramSquareMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, 2));

{ TKilogramSquareMeterPerSecond }

resourcestring
  rsKilogramSquareMeterPerSecondSymbol = '%sg∙%sm²/%ss';
  rsKilogramSquareMeterPerSecondName = '%sgram square %smeter per %ssecond';
  rsKilogramSquareMeterPerSecondPluralName = '%sgram square %smeters per %ssecond';

const
  KilogramSquareMeterPerSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerSecondSymbol;
    FName       : rsKilogramSquareMeterPerSecondName;
    FPluralName : rsKilogramSquareMeterPerSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TNewtonMeterSecond }

resourcestring
  rsNewtonMeterSecondSymbol = '%sN∙%sm∙%ss';
  rsNewtonMeterSecondName = '%snewton %smeter %ssecond';
  rsNewtonMeterSecondPluralName = '%snewton %smeter %sseconds';

const
  NewtonMeterSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonMeterSecondSymbol;
    FName       : rsNewtonMeterSecondName;
    FPluralName : rsNewtonMeterSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, 1));

{ TSecondPerMeter }

resourcestring
  rsSecondPerMeterSymbol = '%ss/%sm';
  rsSecondPerMeterName = '%ssecond per %smeter';
  rsSecondPerMeterPluralName = '%sseconds per %smeter';

const
  SecondPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSecondPerMeterSymbol;
    FName       : rsSecondPerMeterName;
    FPluralName : rsSecondPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TKilogramPerMeter }

resourcestring
  rsKilogramPerMeterSymbol = '%sg/%sm';
  rsKilogramPerMeterName = '%sgram per %smeter';
  rsKilogramPerMeterPluralName = '%sgrams per %smeter';

const
  KilogramPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerMeterSymbol;
    FName       : rsKilogramPerMeterName;
    FPluralName : rsKilogramPerMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, -1));

{ TKilogramPerSquareMeter }

resourcestring
  rsKilogramPerSquareMeterSymbol = '%sg/%sm²';
  rsKilogramPerSquareMeterName = '%sgram per square %smeter';
  rsKilogramPerSquareMeterPluralName = '%sgrams per square %smeter';

const
  KilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerSquareMeterSymbol;
    FName       : rsKilogramPerSquareMeterName;
    FPluralName : rsKilogramPerSquareMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, -2));

{ TKilogramPerCubicMeter }

resourcestring
  rsKilogramPerCubicMeterSymbol = '%sg/%sm³';
  rsKilogramPerCubicMeterName = '%sgram per cubic %smeter';
  rsKilogramPerCubicMeterPluralName = '%sgrams per cubic %smeter';

const
  KilogramPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerCubicMeterSymbol;
    FName       : rsKilogramPerCubicMeterName;
    FPluralName : rsKilogramPerCubicMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, -3));

{ TPoundPerCubicInch }

resourcestring
  rsPoundPerCubicInchSymbol = 'lb/in³';
  rsPoundPerCubicInchName = 'pound per cubic inch';
  rsPoundPerCubicInchPluralName = 'pounds per cubic inch';

const
  PoundPerCubicInchUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: -180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsPoundPerCubicInchSymbol;
    FName       : rsPoundPerCubicInchName;
    FPluralName : rsPoundPerCubicInchPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (27679.9047102031));

{ TNewton }

resourcestring
  rsNewtonSymbol = '%sN';
  rsNewtonName = '%snewton';
  rsNewtonPluralName = '%snewtons';

const
  NewtonUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonSymbol;
    FName       : rsNewtonName;
    FPluralName : rsNewtonPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  N : TUnit absolute NewtonUnit;

const
  GN         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MN         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kN         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hN         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daN        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}

{ TPoundForce }

resourcestring
  rsPoundForceSymbol = 'lbf';
  rsPoundForceName = 'pound-force';
  rsPoundForcePluralName = 'pounds-force';

const
  PoundForceUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsPoundForceSymbol;
    FName       : rsPoundForceName;
    FPluralName : rsPoundForcePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (4.4482216152605));

var
  lbf : TFactoredUnit absolute PoundForceUnit;

{ TKilogramMeterPerSquareSecond }

resourcestring
  rsKilogramMeterPerSquareSecondSymbol = '%sg∙%sm/%ss²';
  rsKilogramMeterPerSquareSecondName = '%sgram %smeter per square %ssecond';
  rsKilogramMeterPerSquareSecondPluralName = '%sgram %smeters per square %ssecond';

const
  KilogramMeterPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramMeterPerSquareSecondSymbol;
    FName       : rsKilogramMeterPerSquareSecondName;
    FPluralName : rsKilogramMeterPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 1, -2));

{ TNewtonRadian }

resourcestring
  rsNewtonRadianSymbol = '%sN∙%srad';
  rsNewtonRadianName = '%snewton %sradian';
  rsNewtonRadianPluralName = '%snewton %sradians';

const
  NewtonRadianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonRadianSymbol;
    FName       : rsNewtonRadianName;
    FPluralName : rsNewtonRadianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TSquareNewton }

resourcestring
  rsSquareNewtonSymbol = '%sN²';
  rsSquareNewtonName = 'square %snewton';
  rsSquareNewtonPluralName = 'square %snewtons';

const
  SquareNewtonUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 120; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareNewtonSymbol;
    FName       : rsSquareNewtonName;
    FPluralName : rsSquareNewtonPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  N2 : TUnit absolute SquareNewtonUnit;

const
  GN2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 120; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MN2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 120; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kN2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 120; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hN2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 120; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daN2       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 120; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}

{ TSquareKilogramSquareMeterPerQuarticSecond }

resourcestring
  rsSquareKilogramSquareMeterPerQuarticSecondSymbol = '%sg²∙%sm²/%ss⁴';
  rsSquareKilogramSquareMeterPerQuarticSecondName = 'square %sgram square %smeter per quartic %ssecond';
  rsSquareKilogramSquareMeterPerQuarticSecondPluralName = 'square %sgram square %smeters per quartic %ssecond';

const
  SquareKilogramSquareMeterPerQuarticSecondUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 120; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramSquareMeterPerQuarticSecondSymbol;
    FName       : rsSquareKilogramSquareMeterPerQuarticSecondName;
    FPluralName : rsSquareKilogramSquareMeterPerQuarticSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (2, 2, -4));

{ TPascal }

resourcestring
  rsPascalSymbol = '%sPa';
  rsPascalName = '%spascal';
  rsPascalPluralName = '%spascals';

const
  PascalUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsPascalSymbol;
    FName       : rsPascalName;
    FPluralName : rsPascalPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  Pa : TUnit absolute PascalUnit;

const
  TPa        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: -60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GPa        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: -60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MPa        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: -60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kPa        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: -60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TNewtonPerSquareMeter }

resourcestring
  rsNewtonPerSquareMeterSymbol = '%sN/%sm²';
  rsNewtonPerSquareMeterName = '%snewton per square %smeter';
  rsNewtonPerSquareMeterPluralName = '%snewtons per square %smeter';

const
  NewtonPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonPerSquareMeterSymbol;
    FName       : rsNewtonPerSquareMeterName;
    FPluralName : rsNewtonPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TBar }

resourcestring
  rsBarSymbol = '%sbar';
  rsBarName = '%sbar';
  rsBarPluralName = '%sbars';

const
  BarUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: -60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsBarSymbol;
    FName       : rsBarName;
    FPluralName : rsBarPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (1E+05));

var
  bar : TFactoredUnit absolute BarUnit;

const
  kbar       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: -60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+05 * 1E+03); {$ELSE} (1E+05 * 1E+03); {$ENDIF}
  mbar       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: -60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+05 * 1E-03); {$ELSE} (1E+05 * 1E-03); {$ENDIF}

{ TPoundPerSquareInch }

resourcestring
  rsPoundPerSquareInchSymbol = '%spsi';
  rsPoundPerSquareInchName = '%spound per square inch';
  rsPoundPerSquareInchPluralName = '%spounds per square inch';

const
  PoundPerSquareInchUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: -60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsPoundPerSquareInchSymbol;
    FName       : rsPoundPerSquareInchName;
    FPluralName : rsPoundPerSquareInchPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (6894.75729316836));

var
  psi : TFactoredUnit absolute PoundPerSquareInchUnit;

const
  kpsi       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: -60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 6894.75729316836 * 1E+03); {$ELSE} (6894.75729316836 * 1E+03); {$ENDIF}

{ TJoulePerCubicMeter }

resourcestring
  rsJoulePerCubicMeterSymbol = '%sJ/%sm³';
  rsJoulePerCubicMeterName = '%sjoule per cubic %smeter';
  rsJoulePerCubicMeterPluralName = '%sjoules per cubic %smeter';

const
  JoulePerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJoulePerCubicMeterSymbol;
    FName       : rsJoulePerCubicMeterName;
    FPluralName : rsJoulePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TKilogramPerMeterPerSquareSecond }

resourcestring
  rsKilogramPerMeterPerSquareSecondSymbol = '%sg/%sm/%ss²';
  rsKilogramPerMeterPerSquareSecondName = '%sgram per %smeter per square %ssecond';
  rsKilogramPerMeterPerSquareSecondPluralName = '%sgrams per %smeter per square %ssecond';

const
  KilogramPerMeterPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerMeterPerSquareSecondSymbol;
    FName       : rsKilogramPerMeterPerSquareSecondName;
    FPluralName : rsKilogramPerMeterPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TJoule }

resourcestring
  rsJouleSymbol = '%sJ';
  rsJouleName = '%sjoule';
  rsJoulePluralName = '%sjoules';

const
  JouleUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJouleSymbol;
    FName       : rsJouleName;
    FPluralName : rsJoulePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  J : TUnit absolute JouleUnit;

const
  TJ         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GJ         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MJ         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kJ         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TWattHour }

resourcestring
  rsWattHourSymbol = '%sW∙h';
  rsWattHourName = '%swatt hour';
  rsWattHourPluralName = '%swatt hours';

const
  WattHourUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWattHourSymbol;
    FName       : rsWattHourName;
    FPluralName : rsWattHourPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (3600));

{ TWattSecond }

resourcestring
  rsWattSecondSymbol = '%sW∙%ss';
  rsWattSecondName = '%swatt %ssecond';
  rsWattSecondPluralName = '%swatt %sseconds';

const
  WattSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWattSecondSymbol;
    FName       : rsWattSecondName;
    FPluralName : rsWattSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TWattPerHertz }

resourcestring
  rsWattPerHertzSymbol = '%sW/%shz';
  rsWattPerHertzName = '%swatt per %shertz';
  rsWattPerHertzPluralName = '%swatts per %shertz';

const
  WattPerHertzUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWattPerHertzSymbol;
    FName       : rsWattPerHertzName;
    FPluralName : rsWattPerHertzPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TElectronvolt }

resourcestring
  rsElectronvoltSymbol = '%seV';
  rsElectronvoltName = '%selectronvolt';
  rsElectronvoltPluralName = '%selectronvolts';

const
  ElectronvoltUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsElectronvoltSymbol;
    FName       : rsElectronvoltName;
    FPluralName : rsElectronvoltPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (1.602176634E-019));

var
  eV : TFactoredUnit absolute ElectronvoltUnit;

const
  TeV        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1.602176634E-019 * 1E+12); {$ELSE} (1.602176634E-019 * 1E+12); {$ENDIF}
  GeV        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1.602176634E-019 * 1E+09); {$ELSE} (1.602176634E-019 * 1E+09); {$ENDIF}
  MeV        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1.602176634E-019 * 1E+06); {$ELSE} (1.602176634E-019 * 1E+06); {$ENDIF}
  keV        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1.602176634E-019 * 1E+03); {$ELSE} (1.602176634E-019 * 1E+03); {$ENDIF}

{ TNewtonMeter }

resourcestring
  rsNewtonMeterSymbol = '%sN∙%sm';
  rsNewtonMeterName = '%snewton %smeter';
  rsNewtonMeterPluralName = '%snewton %smeters';

const
  NewtonMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonMeterSymbol;
    FName       : rsNewtonMeterName;
    FPluralName : rsNewtonMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TPoundForceInch }

resourcestring
  rsPoundForceInchSymbol = 'lbf∙in';
  rsPoundForceInchName = 'pound-force inch';
  rsPoundForceInchPluralName = 'pound-force inches';

const
  PoundForceInchUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsPoundForceInchSymbol;
    FName       : rsPoundForceInchName;
    FPluralName : rsPoundForceInchPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.112984829027617));

{ TRydberg }

resourcestring
  rsRydbergSymbol = '%sRy';
  rsRydbergName = '%srydberg';
  rsRydbergPluralName = '%srydbergs';

const
  RydbergUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsRydbergSymbol;
    FName       : rsRydbergName;
    FPluralName : rsRydbergPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (2.1798723611035E-18));

var
  Ry : TFactoredUnit absolute RydbergUnit;

{ TCalorie }

resourcestring
  rsCalorieSymbol = '%scal';
  rsCalorieName = '%scalorie';
  rsCaloriePluralName = '%scalories';

const
  CalorieUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCalorieSymbol;
    FName       : rsCalorieName;
    FPluralName : rsCaloriePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (4.184));

var
  cal : TFactoredUnit absolute CalorieUnit;

const
  Mcal       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 4.184 * 1E+06); {$ELSE} (4.184 * 1E+06); {$ENDIF}
  kcal       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 4.184 * 1E+03); {$ELSE} (4.184 * 1E+03); {$ENDIF}

{ TKilogramSquareMeterPerSquareSecond }

resourcestring
  rsKilogramSquareMeterPerSquareSecondSymbol = '%sg∙%sm²/%ss²';
  rsKilogramSquareMeterPerSquareSecondName = '%sgram square %smeter per square %ssecond';
  rsKilogramSquareMeterPerSquareSecondPluralName = '%sgram square %smeters per square %ssecond';

const
  KilogramSquareMeterPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerSquareSecondSymbol;
    FName       : rsKilogramSquareMeterPerSquareSecondName;
    FPluralName : rsKilogramSquareMeterPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 2, -2));

{ TJoulePerRadian }

resourcestring
  rsJoulePerRadianSymbol = '%sJ/rad';
  rsJoulePerRadianName = '%sjoule per radian';
  rsJoulePerRadianPluralName = '%sjoules per radian';

const
  JoulePerRadianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJoulePerRadianSymbol;
    FName       : rsJoulePerRadianName;
    FPluralName : rsJoulePerRadianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TJoulePerDegree }

resourcestring
  rsJoulePerDegreeSymbol = '%sJ/deg';
  rsJoulePerDegreeName = '%sjoule per degree';
  rsJoulePerDegreePluralName = '%sjoules per degree';

const
  JoulePerDegreeUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJoulePerDegreeSymbol;
    FName       : rsJoulePerDegreeName;
    FPluralName : rsJoulePerDegreePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (180/Pi));

{ TNewtonMeterPerRadian }

resourcestring
  rsNewtonMeterPerRadianSymbol = '%sN∙%sm/rad';
  rsNewtonMeterPerRadianName = '%snewton %smeter per radian';
  rsNewtonMeterPerRadianPluralName = '%snewton %smeters per radian';

const
  NewtonMeterPerRadianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonMeterPerRadianSymbol;
    FName       : rsNewtonMeterPerRadianName;
    FPluralName : rsNewtonMeterPerRadianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TNewtonMeterPerDegree }

resourcestring
  rsNewtonMeterPerDegreeSymbol = '%sN∙%sm/deg';
  rsNewtonMeterPerDegreeName = '%snewton %smeter per degree';
  rsNewtonMeterPerDegreePluralName = '%snewton %smeters per degree';

const
  NewtonMeterPerDegreeUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonMeterPerDegreeSymbol;
    FName       : rsNewtonMeterPerDegreeName;
    FPluralName : rsNewtonMeterPerDegreePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1);
    FFactor     : (180/Pi));

{ TPoundForceInchPerRadian }

resourcestring
  rsPoundForceInchPerRadianSymbol = 'lbf∙in/rad';
  rsPoundForceInchPerRadianName = 'pound-force inch per radian';
  rsPoundForceInchPerRadianPluralName = 'pound-force inches per radian';

const
  PoundForceInchPerRadianUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsPoundForceInchPerRadianSymbol;
    FName       : rsPoundForceInchPerRadianName;
    FPluralName : rsPoundForceInchPerRadianPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (0.112984829027617));

{ TPoundForceInchPerDegree }

resourcestring
  rsPoundForceInchPerDegreeSymbol = 'lbf∙in/deg';
  rsPoundForceInchPerDegreeName = 'pound-force inch per degree';
  rsPoundForceInchPerDegreePluralName = 'pound-force inches per degree';

const
  PoundForceInchPerDegreeUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsPoundForceInchPerDegreeSymbol;
    FName       : rsPoundForceInchPerDegreeName;
    FPluralName : rsPoundForceInchPerDegreePluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (6.47355385228963));

{ TKilogramSquareMeterPerSquareSecondPerRadian }

resourcestring
  rsKilogramSquareMeterPerSquareSecondPerRadianSymbol = '%sg∙%sm²/%ss²/rad';
  rsKilogramSquareMeterPerSquareSecondPerRadianName = '%sgram square %smeter per square %ssecond per radian';
  rsKilogramSquareMeterPerSquareSecondPerRadianPluralName = '%sgram square %smeters per square %ssecond per radian';

const
  KilogramSquareMeterPerSquareSecondPerRadianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerSquareSecondPerRadianSymbol;
    FName       : rsKilogramSquareMeterPerSquareSecondPerRadianName;
    FPluralName : rsKilogramSquareMeterPerSquareSecondPerRadianPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 2, -2));

{ TWatt }

resourcestring
  rsWattSymbol = '%sW';
  rsWattName = '%swatt';
  rsWattPluralName = '%swatts';

const
  WattUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWattSymbol;
    FName       : rsWattName;
    FPluralName : rsWattPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  W : TUnit absolute WattUnit;

const
  TW         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GW         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MW         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kW         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  milliW     : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

{ TKilogramSquareMeterPerCubicSecond }

resourcestring
  rsKilogramSquareMeterPerCubicSecondSymbol = '%sg∙%sm²/%ss³';
  rsKilogramSquareMeterPerCubicSecondName = '%sgram square %smeter per cubic %ssecond';
  rsKilogramSquareMeterPerCubicSecondPluralName = '%sgram square %smeters per cubic %ssecond';

const
  KilogramSquareMeterPerCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerCubicSecondSymbol;
    FName       : rsKilogramSquareMeterPerCubicSecondName;
    FPluralName : rsKilogramSquareMeterPerCubicSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 2, -3));

{ TCoulomb }

resourcestring
  rsCoulombSymbol = '%sC';
  rsCoulombName = '%scoulomb';
  rsCoulombPluralName = '%scoulombs';

const
  CoulombUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCoulombSymbol;
    FName       : rsCoulombName;
    FPluralName : rsCoulombPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  C : TUnit absolute CoulombUnit;

const
  kC         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hC         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daC        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}
  dC         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cC         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mC         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miC        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nC         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pC         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TAmpereHour }

resourcestring
  rsAmpereHourSymbol = '%sA∙h';
  rsAmpereHourName = '%sampere hour';
  rsAmpereHourPluralName = '%sampere hours';

const
  AmpereHourUnit : TFactoredUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsAmpereHourSymbol;
    FName       : rsAmpereHourName;
    FPluralName : rsAmpereHourPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1);
    FFactor     : (3600));

{ TAmpereSecond }

resourcestring
  rsAmpereSecondSymbol = '%sA∙%ss';
  rsAmpereSecondName = '%sampere %ssecond';
  rsAmpereSecondPluralName = '%sampere %sseconds';

const
  AmpereSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsAmpereSecondSymbol;
    FName       : rsAmpereSecondName;
    FPluralName : rsAmpereSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TSquareCoulomb }

resourcestring
  rsSquareCoulombSymbol = '%sC²';
  rsSquareCoulombName = 'square %scoulomb';
  rsSquareCoulombPluralName = 'square %scoulombs';

const
  SquareCoulombUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareCoulombSymbol;
    FName       : rsSquareCoulombName;
    FPluralName : rsSquareCoulombPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  C2 : TUnit absolute SquareCoulombUnit;

const
  kC2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hC2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daC2       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  dC2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cC2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mC2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  miC2       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nC2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  pC2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareAmpereSquareSecond }

resourcestring
  rsSquareAmpereSquareSecondSymbol = '%sA²∙%ss²';
  rsSquareAmpereSquareSecondName = 'square %sampere square %ssecond';
  rsSquareAmpereSquareSecondPluralName = 'square %sampere square %sseconds';

const
  SquareAmpereSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareAmpereSquareSecondSymbol;
    FName       : rsSquareAmpereSquareSecondName;
    FPluralName : rsSquareAmpereSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 2));

{ TCoulombMeter }

resourcestring
  rsCoulombMeterSymbol = '%sC∙%sm';
  rsCoulombMeterName = '%scoulomb %smeter';
  rsCoulombMeterPluralName = '%scoulomb %smeters';

const
  CoulombMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCoulombMeterSymbol;
    FName       : rsCoulombMeterName;
    FPluralName : rsCoulombMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TVolt }

resourcestring
  rsVoltSymbol = '%sV';
  rsVoltName = '%svolt';
  rsVoltPluralName = '%svolts';

const
  VoltUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsVoltSymbol;
    FName       : rsVoltName;
    FPluralName : rsVoltPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  V : TUnit absolute VoltUnit;

const
  kV         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mV         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

{ TJoulePerCoulomb }

resourcestring
  rsJoulePerCoulombSymbol = '%sJ/%sC';
  rsJoulePerCoulombName = '%sJoule per %scoulomb';
  rsJoulePerCoulombPluralName = '%sJoules per %scoulomb';

const
  JoulePerCoulombUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJoulePerCoulombSymbol;
    FName       : rsJoulePerCoulombName;
    FPluralName : rsJoulePerCoulombPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TKilogramSquareMeterPerAmperePerCubicSecond }

resourcestring
  rsKilogramSquareMeterPerAmperePerCubicSecondSymbol = '%sg∙%sm²/%sA/%ss³';
  rsKilogramSquareMeterPerAmperePerCubicSecondName = '%sgram square %smeter per %sampere per cubic %ssecond';
  rsKilogramSquareMeterPerAmperePerCubicSecondPluralName = '%sgram square %smeters per %sampere per cubic %ssecond';

const
  KilogramSquareMeterPerAmperePerCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerAmperePerCubicSecondSymbol;
    FName       : rsKilogramSquareMeterPerAmperePerCubicSecondName;
    FPluralName : rsKilogramSquareMeterPerAmperePerCubicSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (1, 2, -1, -3));

{ TSquareVolt }

resourcestring
  rsSquareVoltSymbol = '%sV²';
  rsSquareVoltName = 'square %svolt';
  rsSquareVoltPluralName = 'square %svolts';

const
  SquareVoltUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 240; FSecond: -360; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareVoltSymbol;
    FName       : rsSquareVoltName;
    FPluralName : rsSquareVoltPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  V2 : TUnit absolute SquareVoltUnit;

const
  kV2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 240; FSecond: -360; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  mV2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 240; FSecond: -360; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}

{ TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecond }

resourcestring
  rsSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondSymbol = '%sg²∙%sm³/%sA²/%ss⁶';
  rsSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondName = 'square %sgram quartic %smeter per square %sampere per sextic %ssecond';
  rsSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondPluralName = 'square %sgram quartic %smeters per square %sampere per sextic %ssecond';

const
  SquareKilogramQuarticMeterPerSquareAmperePerSexticSecondUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 240; FSecond: -360; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondSymbol;
    FName       : rsSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondName;
    FPluralName : rsSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (2, 3, -2, -6));

{ TFarad }

resourcestring
  rsFaradSymbol = '%sF';
  rsFaradName = '%sfarad';
  rsFaradPluralName = '%sfarads';

const
  FaradUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 240; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsFaradSymbol;
    FName       : rsFaradName;
    FPluralName : rsFaradPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  F : TUnit absolute FaradUnit;

const
  mF         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter: -120; FSecond: 240; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miF        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter: -120; FSecond: 240; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nF         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter: -120; FSecond: 240; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pF         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter: -120; FSecond: 240; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TCoulombPerVolt }

resourcestring
  rsCoulombPerVoltSymbol = '%sC/%sV';
  rsCoulombPerVoltName = '%scoulomb per %svolt';
  rsCoulombPerVoltPluralName = '%scoulombs per %svolt';

const
  CoulombPerVoltUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 240; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCoulombPerVoltSymbol;
    FName       : rsCoulombPerVoltName;
    FPluralName : rsCoulombPerVoltPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareAmpereQuarticSecondPerKilogramPerSquareMeter }

resourcestring
  rsSquareAmpereQuarticSecondPerKilogramPerSquareMeterSymbol = '%sA²∙%ss⁴/%sg/%sm²';
  rsSquareAmpereQuarticSecondPerKilogramPerSquareMeterName = 'square %sampere quartic %ssecond per %sgram per square %smeter';
  rsSquareAmpereQuarticSecondPerKilogramPerSquareMeterPluralName = 'square %sampere quartic %sseconds per %sgram per square %smeter';

const
  SquareAmpereQuarticSecondPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 240; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareAmpereQuarticSecondPerKilogramPerSquareMeterSymbol;
    FName       : rsSquareAmpereQuarticSecondPerKilogramPerSquareMeterName;
    FPluralName : rsSquareAmpereQuarticSecondPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pKilo, pNone);
    FExponents  : (2, 4, -1, -2));

{ TOhm }

resourcestring
  rsOhmSymbol = '%sΩ';
  rsOhmName = '%sohm';
  rsOhmPluralName = '%sohms';

const
  OhmUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsOhmSymbol;
    FName       : rsOhmName;
    FPluralName : rsOhmPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  ohm : TUnit absolute OhmUnit;

const
  Gohm       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  megaohm    : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kohm       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mohm       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miohm      : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nohm       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TKilogramSquareMeterPerSquareAmperePerCubicSecond }

resourcestring
  rsKilogramSquareMeterPerSquareAmperePerCubicSecondSymbol = '%sg∙%sm²/%sA/%ss³';
  rsKilogramSquareMeterPerSquareAmperePerCubicSecondName = '%sgram square %smeter per square %sampere per cubic %ssecond';
  rsKilogramSquareMeterPerSquareAmperePerCubicSecondPluralName = '%sgram square %smeters per square %sampere per cubic %ssecond';

const
  KilogramSquareMeterPerSquareAmperePerCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerSquareAmperePerCubicSecondSymbol;
    FName       : rsKilogramSquareMeterPerSquareAmperePerCubicSecondName;
    FPluralName : rsKilogramSquareMeterPerSquareAmperePerCubicSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (1, 2, -1, -3));

{ TSiemens }

resourcestring
  rsSiemensSymbol = '%sS';
  rsSiemensName = '%ssiemens';
  rsSiemensPluralName = '%ssiemens';

const
  SiemensUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 180; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSiemensSymbol;
    FName       : rsSiemensName;
    FPluralName : rsSiemensPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  siemens : TUnit absolute SiemensUnit;

const
  millisiemens : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter: -120; FSecond: 180; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  microsiemens : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter: -120; FSecond: 180; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
   nanosiemens : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter: -120; FSecond: 180; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TSquareAmpereCubicSecondPerKilogramPerSquareMeter }

resourcestring
  rsSquareAmpereCubicSecondPerKilogramPerSquareMeterSymbol = '%sA²∙%ss³/%sg/%sm²';
  rsSquareAmpereCubicSecondPerKilogramPerSquareMeterName = 'square %sampere cubic %ssecond per %sgram per square %smeter';
  rsSquareAmpereCubicSecondPerKilogramPerSquareMeterPluralName = 'square %sampere cubic %sseconds per %sgram per square %smeter';

const
  SquareAmpereCubicSecondPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 180; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareAmpereCubicSecondPerKilogramPerSquareMeterSymbol;
    FName       : rsSquareAmpereCubicSecondPerKilogramPerSquareMeterName;
    FPluralName : rsSquareAmpereCubicSecondPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pKilo, pNone);
    FExponents  : (2, 3, -1, -2));

{ TSiemensPerMeter }

resourcestring
  rsSiemensPerMeterSymbol = '%sS/%sm';
  rsSiemensPerMeterName = '%ssiemens per %smeter';
  rsSiemensPerMeterPluralName = '%ssiemens per %smeter';

const
  SiemensPerMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -180; FSecond: 180; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSiemensPerMeterSymbol;
    FName       : rsSiemensPerMeterName;
    FPluralName : rsSiemensPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TTesla }

resourcestring
  rsTeslaSymbol = '%sT';
  rsTeslaName = '%stesla';
  rsTeslaPluralName = '%steslas';

const
  TeslaUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsTeslaSymbol;
    FName       : rsTeslaName;
    FPluralName : rsTeslaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  T : TUnit absolute TeslaUnit;

const
  mT         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miT        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nT         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TWeberPerSquareMeter }

resourcestring
  rsWeberPerSquareMeterSymbol = '%sWb/%m²';
  rsWeberPerSquareMeterName = '%sweber per square %smeter';
  rsWeberPerSquareMeterPluralName = '%swebers per square %smeter';

const
  WeberPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWeberPerSquareMeterSymbol;
    FName       : rsWeberPerSquareMeterName;
    FPluralName : rsWeberPerSquareMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TKilogramPerAmperePerSquareSecond }

resourcestring
  rsKilogramPerAmperePerSquareSecondSymbol = '%sg/%sA/%ss²';
  rsKilogramPerAmperePerSquareSecondName = '%sgram per %sampere per square %ssecond';
  rsKilogramPerAmperePerSquareSecondPluralName = '%sgrams per %sampere per square %ssecond';

const
  KilogramPerAmperePerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerAmperePerSquareSecondSymbol;
    FName       : rsKilogramPerAmperePerSquareSecondName;
    FPluralName : rsKilogramPerAmperePerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TWeber }

resourcestring
  rsWeberSymbol = '%sWb';
  rsWeberName = '%sweber';
  rsWeberPluralName = '%swebers';

const
  WeberUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWeberSymbol;
    FName       : rsWeberName;
    FPluralName : rsWeberPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  Wb : TUnit absolute WeberUnit;

{ TKilogramSquareMeterPerAmperePerSquareSecond }

resourcestring
  rsKilogramSquareMeterPerAmperePerSquareSecondSymbol = '%sg∙%sm²/%sA/%ss²';
  rsKilogramSquareMeterPerAmperePerSquareSecondName = '%sgram square %smeter per %sampere per square %ssecond';
  rsKilogramSquareMeterPerAmperePerSquareSecondPluralName = '%sgram square %smeters per %sampere per square %ssecond';

const
  KilogramSquareMeterPerAmperePerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerAmperePerSquareSecondSymbol;
    FName       : rsKilogramSquareMeterPerAmperePerSquareSecondName;
    FPluralName : rsKilogramSquareMeterPerAmperePerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (1, 2, -1, -2));

{ THenry }

resourcestring
  rsHenrySymbol = '%sH';
  rsHenryName = '%shenry';
  rsHenryPluralName = '%shenries';

const
  HenryUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsHenrySymbol;
    FName       : rsHenryName;
    FPluralName : rsHenryPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  H : TUnit absolute HenryUnit;

const
  mH         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miH        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nH         : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TKilogramSquareMeterPerSquareAmperePerSquareSecond }

resourcestring
  rsKilogramSquareMeterPerSquareAmperePerSquareSecondSymbol = '%sg∙%sm²/%sA²/%ss²';
  rsKilogramSquareMeterPerSquareAmperePerSquareSecondName = '%sgram square %smeter per square %sampere per square %ssecond';
  rsKilogramSquareMeterPerSquareAmperePerSquareSecondPluralName = '%sgram square %smeters per square %sampere per square %ssecond';

const
  KilogramSquareMeterPerSquareAmperePerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerSquareAmperePerSquareSecondSymbol;
    FName       : rsKilogramSquareMeterPerSquareAmperePerSquareSecondName;
    FPluralName : rsKilogramSquareMeterPerSquareAmperePerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (1, 2, -2, -2));

{ TReciprocalHenry }

resourcestring
  rsReciprocalHenrySymbol = '1/%sH';
  rsReciprocalHenryName = 'reciprocal %shenry';
  rsReciprocalHenryPluralName = 'reciprocal %shenries';

const
  ReciprocalHenryUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalHenrySymbol;
    FName       : rsReciprocalHenryName;
    FPluralName : rsReciprocalHenryPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TLumen }

resourcestring
  rsLumenSymbol = '%slm';
  rsLumenName = '%slumen';
  rsLumenPluralName = '%slumens';

const
  LumenUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 60);
    FSymbol     : rsLumenSymbol;
    FName       : rsLumenName;
    FPluralName : rsLumenPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  lm : TUnit absolute LumenUnit;

{ TCandelaSteradian }

resourcestring
  rsCandelaSteradianSymbol = '%scd∙%ssr';
  rsCandelaSteradianName = '%scandela %ssteradian';
  rsCandelaSteradianPluralName = '%scandela %ssteradians';

const
  CandelaSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 60);
    FSymbol     : rsCandelaSteradianSymbol;
    FName       : rsCandelaSteradianName;
    FPluralName : rsCandelaSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TLumenSecond }

resourcestring
  rsLumenSecondSymbol = '%slm∙%ss';
  rsLumenSecondName = '%slumen %ssecond';
  rsLumenSecondPluralName = '%slumen %sseconds';

const
  LumenSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 60);
    FSymbol     : rsLumenSecondSymbol;
    FName       : rsLumenSecondName;
    FPluralName : rsLumenSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TLumenSecondPerCubicMeter }

resourcestring
  rsLumenSecondPerCubicMeterSymbol = '%slm∙%ss/%sm³';
  rsLumenSecondPerCubicMeterName = '%slumen %ssecond per cubic meter';
  rsLumenSecondPerCubicMeterPluralName = '%slumen %sseconds per cubic meter';

const
  LumenSecondPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 60);
    FSymbol     : rsLumenSecondPerCubicMeterSymbol;
    FName       : rsLumenSecondPerCubicMeterName;
    FPluralName : rsLumenSecondPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -3));

{ TLux }

resourcestring
  rsLuxSymbol = '%slx';
  rsLuxName = '%slux';
  rsLuxPluralName = '%slux';

const
  LuxUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 60);
    FSymbol     : rsLuxSymbol;
    FName       : rsLuxName;
    FPluralName : rsLuxPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  lx : TUnit absolute LuxUnit;

{ TCandelaSteradianPerSquareMeter }

resourcestring
  rsCandelaSteradianPerSquareMeterSymbol = '%scd∙%ssr/%sm²';
  rsCandelaSteradianPerSquareMeterName = '%scandela %ssteradian per square %smeter';
  rsCandelaSteradianPerSquareMeterPluralName = '%scandela %ssteradians per square %smeter';

const
  CandelaSteradianPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 60);
    FSymbol     : rsCandelaSteradianPerSquareMeterSymbol;
    FName       : rsCandelaSteradianPerSquareMeterName;
    FPluralName : rsCandelaSteradianPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -2));

{ TLuxSecond }

resourcestring
  rsLuxSecondSymbol = '%slx∙%ss';
  rsLuxSecondName = '%slux %ssecond';
  rsLuxSecondPluralName = '%slux %sseconds';

const
  LuxSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 60);
    FSymbol     : rsLuxSecondSymbol;
    FName       : rsLuxSecondName;
    FPluralName : rsLuxSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TBequerel }

resourcestring
  rsBequerelSymbol = '%sBq';
  rsBequerelName = '%sbequerel';
  rsBequerelPluralName = '%sbequerels';

const
  BequerelUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsBequerelSymbol;
    FName       : rsBequerelName;
    FPluralName : rsBequerelPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  Bq : TUnit absolute BequerelUnit;

const
  kBq        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mBq        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miBq       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nBq        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pBq        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TKatal }

resourcestring
  rsKatalSymbol = '%skat';
  rsKatalName = '%skatal';
  rsKatalPluralName = '%skatals';

const
  KatalUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKatalSymbol;
    FName       : rsKatalName;
    FPluralName : rsKatalPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  kat : TUnit absolute KatalUnit;

{ TMolePerSecond }

resourcestring
  rsMolePerSecondSymbol = '%smol/%ss';
  rsMolePerSecondName = '%smole per %ssecond';
  rsMolePerSecondPluralName = '%smoles per %ssecond';

const
  MolePerSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMolePerSecondSymbol;
    FName       : rsMolePerSecondName;
    FPluralName : rsMolePerSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TNewtonPerCubicMeter }

resourcestring
  rsNewtonPerCubicMeterSymbol = '%sN/%sm³';
  rsNewtonPerCubicMeterName = '%snewton per cubic %smeter';
  rsNewtonPerCubicMeterPluralName = '%snewtons per cubic %smeter';

const
  NewtonPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonPerCubicMeterSymbol;
    FName       : rsNewtonPerCubicMeterName;
    FPluralName : rsNewtonPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TPascalPerMeter }

resourcestring
  rsPascalPerMeterSymbol = '%sPa/%sm';
  rsPascalPerMeterName = '%spascal per %smeter';
  rsPascalPerMeterPluralName = '%spascals per %smeter';

const
  PascalPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsPascalPerMeterSymbol;
    FName       : rsPascalPerMeterName;
    FPluralName : rsPascalPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TKilogramPerSquareMeterPerSquareSecond }

resourcestring
  rsKilogramPerSquareMeterPerSquareSecondSymbol = '%sg/%sm²/%ss²';
  rsKilogramPerSquareMeterPerSquareSecondName = '%sgram per square %smeter per square %ssecond';
  rsKilogramPerSquareMeterPerSquareSecondPluralName = '%sgrams per square %smeter per square %ssecond';

const
  KilogramPerSquareMeterPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerSquareMeterPerSquareSecondSymbol;
    FName       : rsKilogramPerSquareMeterPerSquareSecondName;
    FPluralName : rsKilogramPerSquareMeterPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, -2, -2));

{ TNewtonPerMeter }

resourcestring
  rsNewtonPerMeterSymbol = '%sN/%sm';
  rsNewtonPerMeterName = '%snewton per %smeter';
  rsNewtonPerMeterPluralName = '%snewtons per %smeter';

const
  NewtonPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonPerMeterSymbol;
    FName       : rsNewtonPerMeterName;
    FPluralName : rsNewtonPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TJoulePerSquareMeter }

resourcestring
  rsJoulePerSquareMeterSymbol = '%sJ/%sm²';
  rsJoulePerSquareMeterName = '%sjoule per square %smeter';
  rsJoulePerSquareMeterPluralName = '%sjoules per square %smeter';

const
  JoulePerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJoulePerSquareMeterSymbol;
    FName       : rsJoulePerSquareMeterName;
    FPluralName : rsJoulePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TWattPerSquareMeterPerHertz }

resourcestring
  rsWattPerSquareMeterPerHertzSymbol = '%sW/%sm²/%sHz';
  rsWattPerSquareMeterPerHertzName = '%swatt per square %smeter per %shertz';
  rsWattPerSquareMeterPerHertzPluralName = '%swatts per square %smeter per %shertz';

const
  WattPerSquareMeterPerHertzUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWattPerSquareMeterPerHertzSymbol;
    FName       : rsWattPerSquareMeterPerHertzName;
    FPluralName : rsWattPerSquareMeterPerHertzPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -1));

{ TPoundForcePerInch }

resourcestring
  rsPoundForcePerInchSymbol = 'lbf/in';
  rsPoundForcePerInchName = 'pound-force per inch';
  rsPoundForcePerInchPluralName = 'pounds-force per inch';

const
  PoundForcePerInchUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsPoundForcePerInchSymbol;
    FName       : rsPoundForcePerInchName;
    FPluralName : rsPoundForcePerInchPluralName;
    FPrefixes   : ();
    FExponents  : ();
    FFactor     : (175.126835246476));

{ TKilogramPerSquareSecond }

resourcestring
  rsKilogramPerSquareSecondSymbol = '%sg/%ss²';
  rsKilogramPerSquareSecondName = '%sgram per square %ssecond';
  rsKilogramPerSquareSecondPluralName = '%sgrams per square %ssecond';

const
  KilogramPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerSquareSecondSymbol;
    FName       : rsKilogramPerSquareSecondName;
    FPluralName : rsKilogramPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, -2));

{ TCubicMeterPerSecond }

resourcestring
  rsCubicMeterPerSecondSymbol = '%sm³/%ss';
  rsCubicMeterPerSecondName = 'cubic %smeter per %ssecond';
  rsCubicMeterPerSecondPluralName = 'cubic %smeters per %ssecond';

const
  CubicMeterPerSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterPerSecondSymbol;
    FName       : rsCubicMeterPerSecondName;
    FPluralName : rsCubicMeterPerSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TPoiseuille }

resourcestring
  rsPoiseuilleSymbol = '%sPl';
  rsPoiseuilleName = '%spoiseuille';
  rsPoiseuillePluralName = '%spoiseuilles';

const
  PoiseuilleUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -60; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsPoiseuilleSymbol;
    FName       : rsPoiseuilleName;
    FPluralName : rsPoiseuillePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

var
  Pl : TUnit absolute PoiseuilleUnit;

const
  cPl        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: -60; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mPl        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: -60; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miPl       : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 60; FMeter: -60; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}

{ TPascalSecond }

resourcestring
  rsPascalSecondSymbol = '%sPa∙%ss';
  rsPascalSecondName = '%spascal %ssecond';
  rsPascalSecondPluralName = '%spascal %sseconds';

const
  PascalSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -60; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsPascalSecondSymbol;
    FName       : rsPascalSecondName;
    FPluralName : rsPascalSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TKilogramPerMeterPerSecond }

resourcestring
  rsKilogramPerMeterPerSecondSymbol = '%sg/%sm/%ss';
  rsKilogramPerMeterPerSecondName = '%sgram per %smeter per %ssecond';
  rsKilogramPerMeterPerSecondPluralName = '%sgrams per %smeter per %ssecond';

const
  KilogramPerMeterPerSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -60; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerMeterPerSecondSymbol;
    FName       : rsKilogramPerMeterPerSecondName;
    FPluralName : rsKilogramPerMeterPerSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TSquareMeterPerSecond }

resourcestring
  rsSquareMeterPerSecondSymbol = '%sm²/%ss';
  rsSquareMeterPerSecondName = 'square %smeter per %ssecond';
  rsSquareMeterPerSecondPluralName = 'square %smeters per %ssecond';

const
  SquareMeterPerSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerSecondSymbol;
    FName       : rsSquareMeterPerSecondName;
    FPluralName : rsSquareMeterPerSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TKilogramPerQuarticMeter }

resourcestring
  rsKilogramPerQuarticMeterSymbol = '%sg/%sm⁴';
  rsKilogramPerQuarticMeterName = '%sgram per quartic %smeter';
  rsKilogramPerQuarticMeterPluralName = '%sgrams per quartic %smeter';

const
  KilogramPerQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerQuarticMeterSymbol;
    FName       : rsKilogramPerQuarticMeterName;
    FPluralName : rsKilogramPerQuarticMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, -4));

{ TQuarticMeterSecond }

resourcestring
  rsQuarticMeterSecondSymbol = '%sm⁴∙%ss';
  rsQuarticMeterSecondName = 'quartic %smeter %ssecond';
  rsQuarticMeterSecondPluralName = 'quartic %smeter %sseconds';

const
  QuarticMeterSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 240; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticMeterSecondSymbol;
    FName       : rsQuarticMeterSecondName;
    FPluralName : rsQuarticMeterSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, 1));

{ TKilogramPerQuarticMeterPerSecond }

resourcestring
  rsKilogramPerQuarticMeterPerSecondSymbol = '%sg/%sm⁴/%ss';
  rsKilogramPerQuarticMeterPerSecondName = '%sgram per quartic %smeter per %ssecond';
  rsKilogramPerQuarticMeterPerSecondPluralName = '%sgrams per quartic %smeter per %ssecond';

const
  KilogramPerQuarticMeterPerSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -240; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerQuarticMeterPerSecondSymbol;
    FName       : rsKilogramPerQuarticMeterPerSecondName;
    FPluralName : rsKilogramPerQuarticMeterPerSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, -4, -1));

{ TCubicMeterPerKilogram }

resourcestring
  rsCubicMeterPerKilogramSymbol = '%sm³/%sg';
  rsCubicMeterPerKilogramName = 'cubic %smeter per %sgram';
  rsCubicMeterPerKilogramPluralName = 'cubic %smeters per %sgram';

const
  CubicMeterPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterPerKilogramSymbol;
    FName       : rsCubicMeterPerKilogramName;
    FPluralName : rsCubicMeterPerKilogramPluralName;
    FPrefixes   : (pNone, pKilo);
    FExponents  : (3, -1));

{ TKilogramSquareSecond }

resourcestring
  rsKilogramSquareSecondSymbol = '%sg∙%ss²';
  rsKilogramSquareSecondName = '%sgram square %ssecond';
  rsKilogramSquareSecondPluralName = '%sgram square %sseconds';

const
  KilogramSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareSecondSymbol;
    FName       : rsKilogramSquareSecondName;
    FPluralName : rsKilogramSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, 2));

{ TCubicMeterPerSquareSecond }

resourcestring
  rsCubicMeterPerSquareSecondSymbol = '%sm³/%ss²';
  rsCubicMeterPerSquareSecondName = 'cubic %smeter per square %ssecond';
  rsCubicMeterPerSquareSecondPluralName = 'cubic %smeters per square %ssecond';

const
  CubicMeterPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterPerSquareSecondSymbol;
    FName       : rsCubicMeterPerSquareSecondName;
    FPluralName : rsCubicMeterPerSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -2));

{ TNewtonSquareMeter }

resourcestring
  rsNewtonSquareMeterSymbol = '%sN∙%sm²';
  rsNewtonSquareMeterName = '%snewton square %smeter';
  rsNewtonSquareMeterPluralName = '%snewton square %smeters';

const
  NewtonSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 180; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonSquareMeterSymbol;
    FName       : rsNewtonSquareMeterName;
    FPluralName : rsNewtonSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 2));

{ TKilogramCubicMeterPerSquareSecond }

resourcestring
  rsKilogramCubicMeterPerSquareSecondSymbol = '%sg∙%sm³/%ss²';
  rsKilogramCubicMeterPerSquareSecondName = '%sgram cubic %smeter per square %ssecond';
  rsKilogramCubicMeterPerSquareSecondPluralName = '%sgram cubic %smeters per square %ssecond';

const
  KilogramCubicMeterPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 180; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramCubicMeterPerSquareSecondSymbol;
    FName       : rsKilogramCubicMeterPerSquareSecondName;
    FPluralName : rsKilogramCubicMeterPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 3, -2));

{ TNewtonCubicMeter }

resourcestring
  rsNewtonCubicMeterSymbol = '%sN∙%sm³';
  rsNewtonCubicMeterName = '%snewton cubic %smeter';
  rsNewtonCubicMeterPluralName = '%snewton cubic %smeters';

const
  NewtonCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 240; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonCubicMeterSymbol;
    FName       : rsNewtonCubicMeterName;
    FPluralName : rsNewtonCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 3));

{ TKilogramQuarticMeterPerSquareSecond }

resourcestring
  rsKilogramQuarticMeterPerSquareSecondSymbol = '%sg∙%sm⁴/%ss²';
  rsKilogramQuarticMeterPerSquareSecondName = '%sgram quartic %smeter per square %ssecond';
  rsKilogramQuarticMeterPerSquareSecondPluralName = '%sgram quartic %smeters per square %ssecond';

const
  KilogramQuarticMeterPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 240; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramQuarticMeterPerSquareSecondSymbol;
    FName       : rsKilogramQuarticMeterPerSquareSecondName;
    FPluralName : rsKilogramQuarticMeterPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 4, -2));

{ TNewtonPerSquareKilogram }

resourcestring
  rsNewtonPerSquareKilogramSymbol = '%sN/%sg²';
  rsNewtonPerSquareKilogramName = '%snewton per square %sgram';
  rsNewtonPerSquareKilogramPluralName = '%snewtons per square %sgram';

const
  NewtonPerSquareKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonPerSquareKilogramSymbol;
    FName       : rsNewtonPerSquareKilogramName;
    FPluralName : rsNewtonPerSquareKilogramPluralName;
    FPrefixes   : (pNone, pKilo);
    FExponents  : (1, -2));

{ TMeterPerKilogramPerSquareSecond }

resourcestring
  rsMeterPerKilogramPerSquareSecondSymbol = '%sm/%sg/%ss²';
  rsMeterPerKilogramPerSquareSecondName = '%smeter per %sgram per square %ssecond';
  rsMeterPerKilogramPerSquareSecondPluralName = '%smeters per %sgram per square %ssecond';

const
  MeterPerKilogramPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerKilogramPerSquareSecondSymbol;
    FName       : rsMeterPerKilogramPerSquareSecondName;
    FPluralName : rsMeterPerKilogramPerSquareSecondPluralName;
    FPrefixes   : (pNone, pKilo, pNone);
    FExponents  : (1, -1, -2));

{ TSquareKilogramPerMeter }

resourcestring
  rsSquareKilogramPerMeterSymbol = '%sg²/%sm';
  rsSquareKilogramPerMeterName = 'square %sgram per %smeter';
  rsSquareKilogramPerMeterPluralName = 'square %sgrams per %smeter';

const
  SquareKilogramPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: -60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramPerMeterSymbol;
    FName       : rsSquareKilogramPerMeterName;
    FPluralName : rsSquareKilogramPerMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (2, -1));

{ TSquareKilogramPerSquareMeter }

resourcestring
  rsSquareKilogramPerSquareMeterSymbol = '%sg²/%sm²';
  rsSquareKilogramPerSquareMeterName = 'square %sgram per square %smeter';
  rsSquareKilogramPerSquareMeterPluralName = 'square %sgrams per square %smeter';

const
  SquareKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramPerSquareMeterSymbol;
    FName       : rsSquareKilogramPerSquareMeterName;
    FPluralName : rsSquareKilogramPerSquareMeterPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (2, -2));

{ TSquareMeterPerSquareKilogram }

resourcestring
  rsSquareMeterPerSquareKilogramSymbol = '%sm²/%sg²';
  rsSquareMeterPerSquareKilogramName = 'square %smeter per square %sgram';
  rsSquareMeterPerSquareKilogramPluralName = 'square %smeters per square %sgram';

const
  SquareMeterPerSquareKilogramUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerSquareKilogramSymbol;
    FName       : rsSquareMeterPerSquareKilogramName;
    FPluralName : rsSquareMeterPerSquareKilogramPluralName;
    FPrefixes   : (pNone, pKilo);
    FExponents  : (2, -2));

{ TNewtonSquareMeterPerSquareKilogram }

resourcestring
  rsNewtonSquareMeterPerSquareKilogramSymbol = '%sN∙%sm²/%sg²';
  rsNewtonSquareMeterPerSquareKilogramName = '%snewton square %smeter per square %sgram';
  rsNewtonSquareMeterPerSquareKilogramPluralName = '%snewton square %smeters per square %sgram';

const
  NewtonSquareMeterPerSquareKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 180; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonSquareMeterPerSquareKilogramSymbol;
    FName       : rsNewtonSquareMeterPerSquareKilogramName;
    FPluralName : rsNewtonSquareMeterPerSquareKilogramPluralName;
    FPrefixes   : (pNone, pNone, pKilo);
    FExponents  : (1, 2, -2));

{ TCubicMeterPerKilogramPerSquareSecond }

resourcestring
  rsCubicMeterPerKilogramPerSquareSecondSymbol = '%sm³/%sg/%ss²';
  rsCubicMeterPerKilogramPerSquareSecondName = 'cubic %smeter per %sgram per square %ssecond';
  rsCubicMeterPerKilogramPerSquareSecondPluralName = 'cubic %smeters per %sgram per square %ssecond';

const
  CubicMeterPerKilogramPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 180; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterPerKilogramPerSquareSecondSymbol;
    FName       : rsCubicMeterPerKilogramPerSquareSecondName;
    FPluralName : rsCubicMeterPerKilogramPerSquareSecondPluralName;
    FPrefixes   : (pNone, pKilo, pNone);
    FExponents  : (3, -1, -2));

{ TReciprocalKelvin }

resourcestring
  rsReciprocalKelvinSymbol = '1/%sK';
  rsReciprocalKelvinName = 'reciprocal %skelvin';
  rsReciprocalKelvinPluralName = 'reciprocal %skelvin';

const
  ReciprocalKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalKelvinSymbol;
    FName       : rsReciprocalKelvinName;
    FPluralName : rsReciprocalKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TKilogramKelvin }

resourcestring
  rsKilogramKelvinSymbol = '%sg∙%sK';
  rsKilogramKelvinName = '%sgram %skelvin';
  rsKilogramKelvinPluralName = '%sgram %skelvins';

const
  KilogramKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramKelvinSymbol;
    FName       : rsKilogramKelvinName;
    FPluralName : rsKilogramKelvinPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, 1));

{ TJoulePerKelvin }

resourcestring
  rsJoulePerKelvinSymbol = '%sJ/%sK';
  rsJoulePerKelvinName = '%sjoule per %skelvin';
  rsJoulePerKelvinPluralName = '%sjoules per %skelvin';

const
  JoulePerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJoulePerKelvinSymbol;
    FName       : rsJoulePerKelvinName;
    FPluralName : rsJoulePerKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TKilogramSquareMeterPerSquareSecondPerKelvin }

resourcestring
  rsKilogramSquareMeterPerSquareSecondPerKelvinSymbol = '%sg∙%sm²/%ss²/%sK';
  rsKilogramSquareMeterPerSquareSecondPerKelvinName = '%sgram square %smeter per square %ssecond per %skelvin';
  rsKilogramSquareMeterPerSquareSecondPerKelvinPluralName = '%sgram square %smeters per square %ssecond per %skelvin';

const
  KilogramSquareMeterPerSquareSecondPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerSquareSecondPerKelvinSymbol;
    FName       : rsKilogramSquareMeterPerSquareSecondPerKelvinName;
    FPluralName : rsKilogramSquareMeterPerSquareSecondPerKelvinPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (1, 2, -2, -1));

{ TJoulePerKilogramPerKelvin }

resourcestring
  rsJoulePerKilogramPerKelvinSymbol = '%sJ/%sg/%sK';
  rsJoulePerKilogramPerKelvinName = '%sjoule per %sgram per %skelvin';
  rsJoulePerKilogramPerKelvinPluralName = '%sjoules per %sgram per %skelvin';

const
  JoulePerKilogramPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJoulePerKilogramPerKelvinSymbol;
    FName       : rsJoulePerKilogramPerKelvinName;
    FPluralName : rsJoulePerKilogramPerKelvinPluralName;
    FPrefixes   : (pNone, pKilo, pNone);
    FExponents  : (1, -1, -1));

{ TSquareMeterPerSquareSecondPerKelvin }

resourcestring
  rsSquareMeterPerSquareSecondPerKelvinSymbol = '%sm²/%ss²/%sK';
  rsSquareMeterPerSquareSecondPerKelvinName = 'square %smeter per square %ssecond per %skelvin';
  rsSquareMeterPerSquareSecondPerKelvinPluralName = 'square %smeters per square %ssecond per %skelvin';

const
  SquareMeterPerSquareSecondPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerSquareSecondPerKelvinSymbol;
    FName       : rsSquareMeterPerSquareSecondPerKelvinName;
    FPluralName : rsSquareMeterPerSquareSecondPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -2, -1));

{ TMeterKelvin }

resourcestring
  rsMeterKelvinSymbol = '%sm∙%sK';
  rsMeterKelvinName = '%smeter %skelvin';
  rsMeterKelvinPluralName = '%smeter %skelvins';

const
  MeterKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterKelvinSymbol;
    FName       : rsMeterKelvinName;
    FPluralName : rsMeterKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TKelvinPerMeter }

resourcestring
  rsKelvinPerMeterSymbol = '%sK/%sm';
  rsKelvinPerMeterName = '%skelvin per %smeter';
  rsKelvinPerMeterPluralName = '%skelvins per %smeter';

const
  KelvinPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKelvinPerMeterSymbol;
    FName       : rsKelvinPerMeterName;
    FPluralName : rsKelvinPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TWattPerMeter }

resourcestring
  rsWattPerMeterSymbol = '%sW/%sm';
  rsWattPerMeterName = '%swatt per %smeter';
  rsWattPerMeterPluralName = '%swatts per %smeter';

const
  WattPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWattPerMeterSymbol;
    FName       : rsWattPerMeterName;
    FPluralName : rsWattPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TKilogramMeterPerCubicSecond }

resourcestring
  rsKilogramMeterPerCubicSecondSymbol = '%sg∙%sm/%ss³';
  rsKilogramMeterPerCubicSecondName = '%sgram %smeter per cubic %ssecond';
  rsKilogramMeterPerCubicSecondPluralName = '%sgram %smeters per cubic %ssecond';

const
  KilogramMeterPerCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramMeterPerCubicSecondSymbol;
    FName       : rsKilogramMeterPerCubicSecondName;
    FPluralName : rsKilogramMeterPerCubicSecondPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, 1, -3));

{ TWattPerSquareMeter }

resourcestring
  rsWattPerSquareMeterSymbol = '%sW/%sm²';
  rsWattPerSquareMeterName = '%swatt per square %smeter';
  rsWattPerSquareMeterPluralName = '%swatts per square %smeter';

const
  WattPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWattPerSquareMeterSymbol;
    FName       : rsWattPerSquareMeterName;
    FPluralName : rsWattPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TKilogramPerCubicSecond }

resourcestring
  rsKilogramPerCubicSecondSymbol = '%sg/%ss³';
  rsKilogramPerCubicSecondName = '%sgram per cubic %ssecond';
  rsKilogramPerCubicSecondPluralName = '%sgrams per cubic %ssecond';

const
  KilogramPerCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerCubicSecondSymbol;
    FName       : rsKilogramPerCubicSecondName;
    FPluralName : rsKilogramPerCubicSecondPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (1, -3));

{ TWattPerCubicMeter }

resourcestring
  rsWattPerCubicMeterSymbol = '%sW/%sm³';
  rsWattPerCubicMeterName = '%swatt per cubic %smeter';
  rsWattPerCubicMeterPluralName = '%swatts per cubic %smeter';

const
  WattPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -60; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWattPerCubicMeterSymbol;
    FName       : rsWattPerCubicMeterName;
    FPluralName : rsWattPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TWattPerKelvin }

resourcestring
  rsWattPerKelvinSymbol = '%sW/%sK';
  rsWattPerKelvinName = '%swatt per %skelvin';
  rsWattPerKelvinPluralName = '%swatts per %skelvin';

const
  WattPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWattPerKelvinSymbol;
    FName       : rsWattPerKelvinName;
    FPluralName : rsWattPerKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TKilogramSquareMeterPerCubicSecondPerKelvin }

resourcestring
  rsKilogramSquareMeterPerCubicSecondPerKelvinSymbol = '%sg∙%sm²/%ss³/%sK';
  rsKilogramSquareMeterPerCubicSecondPerKelvinName = '%sgram square %smeter per cubic %ssecond per %skelvin';
  rsKilogramSquareMeterPerCubicSecondPerKelvinPluralName = '%sgram square %smeters per cubic %ssecond per %skelvin';

const
  KilogramSquareMeterPerCubicSecondPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerCubicSecondPerKelvinSymbol;
    FName       : rsKilogramSquareMeterPerCubicSecondPerKelvinName;
    FPluralName : rsKilogramSquareMeterPerCubicSecondPerKelvinPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (1, 2, -3, -1));

{ TWattPerMeterPerKelvin }

resourcestring
  rsWattPerMeterPerKelvinSymbol = '%sW/%sm/%sK';
  rsWattPerMeterPerKelvinName = '%swatt per %smeter per %skelvin';
  rsWattPerMeterPerKelvinPluralName = '%swatts per %smeter per %skelvin';

const
  WattPerMeterPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -180; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWattPerMeterPerKelvinSymbol;
    FName       : rsWattPerMeterPerKelvinName;
    FPluralName : rsWattPerMeterPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TKilogramMeterPerCubicSecondPerKelvin }

resourcestring
  rsKilogramMeterPerCubicSecondPerKelvinSymbol = '%sg∙%sm/%ss³/%sK';
  rsKilogramMeterPerCubicSecondPerKelvinName = '%sgram %smeter per cubic %ssecond per %skelvin';
  rsKilogramMeterPerCubicSecondPerKelvinPluralName = '%sgram %smeters per cubic %ssecond per %skelvin';

const
  KilogramMeterPerCubicSecondPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -180; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramMeterPerCubicSecondPerKelvinSymbol;
    FName       : rsKilogramMeterPerCubicSecondPerKelvinName;
    FPluralName : rsKilogramMeterPerCubicSecondPerKelvinPluralName;
    FPrefixes   : (pKilo, pNone, pNone, pNone);
    FExponents  : (1, 1, -3, -1));

{ TKelvinPerWatt }

resourcestring
  rsKelvinPerWattSymbol = '%sK/%sW';
  rsKelvinPerWattName = '%skelvin per %swatt';
  rsKelvinPerWattPluralName = '%skelvins per %swatt';

const
  KelvinPerWattUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 180; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKelvinPerWattSymbol;
    FName       : rsKelvinPerWattName;
    FPluralName : rsKelvinPerWattPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TMeterPerWatt }

resourcestring
  rsMeterPerWattSymbol = '%sm/%sW';
  rsMeterPerWattName = '%smeter per %swatt';
  rsMeterPerWattPluralName = '%smeters per %swatts';

const
  MeterPerWattUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerWattSymbol;
    FName       : rsMeterPerWattName;
    FPluralName : rsMeterPerWattPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TMeterKelvinPerWatt }

resourcestring
  rsMeterKelvinPerWattSymbol = '%sK∙%sm/%sW';
  rsMeterKelvinPerWattName = '%skelvin %smeter per %swatt';
  rsMeterKelvinPerWattPluralName = '%skelvin %smeters per %swatt';

const
  MeterKelvinPerWattUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 180; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterKelvinPerWattSymbol;
    FName       : rsMeterKelvinPerWattName;
    FPluralName : rsMeterKelvinPerWattPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TSquareMeterKelvin }

resourcestring
  rsSquareMeterKelvinSymbol = '%sm²∙%sK';
  rsSquareMeterKelvinName = 'square %smeter %skelvin';
  rsSquareMeterKelvinPluralName = 'square %smeter %skelvins';

const
  SquareMeterKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterKelvinSymbol;
    FName       : rsSquareMeterKelvinName;
    FPluralName : rsSquareMeterKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 1));

{ TWattPerSquareMeterPerKelvin }

resourcestring
  rsWattPerSquareMeterPerKelvinSymbol = '%sW/%sm²/%sK';
  rsWattPerSquareMeterPerKelvinName = '%swatt per square %smeter per %skelvin';
  rsWattPerSquareMeterPerKelvinPluralName = '%swatts per square %smeter per %skelvin';

const
  WattPerSquareMeterPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -180; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWattPerSquareMeterPerKelvinSymbol;
    FName       : rsWattPerSquareMeterPerKelvinName;
    FPluralName : rsWattPerSquareMeterPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -1));

{ TKilogramPerCubicSecondPerKelvin }

resourcestring
  rsKilogramPerCubicSecondPerKelvinSymbol = '%sg/%ss³/%sK';
  rsKilogramPerCubicSecondPerKelvinName = '%sgram per cubic %ssecond per %skelvin';
  rsKilogramPerCubicSecondPerKelvinPluralName = '%sgrams per cubic %ssecond per %skelvin';

const
  KilogramPerCubicSecondPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -180; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerCubicSecondPerKelvinSymbol;
    FName       : rsKilogramPerCubicSecondPerKelvinName;
    FPluralName : rsKilogramPerCubicSecondPerKelvinPluralName;
    FPrefixes   : (pKilo, pNone, pNone);
    FExponents  : (1, -3, -1));

{ TSquareMeterQuarticKelvin }

resourcestring
  rsSquareMeterQuarticKelvinSymbol = '%sm²∙%sK⁴';
  rsSquareMeterQuarticKelvinName = 'square %smeter quartic %skelvin';
  rsSquareMeterQuarticKelvinPluralName = 'square %smeter quartic %skelvins';

const
  SquareMeterQuarticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterQuarticKelvinSymbol;
    FName       : rsSquareMeterQuarticKelvinName;
    FPluralName : rsSquareMeterQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 4));

{ TWattPerQuarticKelvin }

resourcestring
  rsWattPerQuarticKelvinSymbol = '%sW/%sK⁴';
  rsWattPerQuarticKelvinName = '%swatt per quartic %skelvin';
  rsWattPerQuarticKelvinPluralName = '%swatts per quartic %skelvin';

const
  WattPerQuarticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: -240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWattPerQuarticKelvinSymbol;
    FName       : rsWattPerQuarticKelvinName;
    FPluralName : rsWattPerQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -4));

{ TWattPerSquareMeterPerQuarticKelvin }

resourcestring
  rsWattPerSquareMeterPerQuarticKelvinSymbol = '%sW/%sm²/%sK⁴';
  rsWattPerSquareMeterPerQuarticKelvinName = '%swatt per square %smeter per quartic %skelvin';
  rsWattPerSquareMeterPerQuarticKelvinPluralName = '%swatts per square %smeter per quartic %skelvin';

const
  WattPerSquareMeterPerQuarticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -180; FAmpere: 0; FKelvin: -240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsWattPerSquareMeterPerQuarticKelvinSymbol;
    FName       : rsWattPerSquareMeterPerQuarticKelvinName;
    FPluralName : rsWattPerSquareMeterPerQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -4));

{ TJoulePerMole }

resourcestring
  rsJoulePerMoleSymbol = '%sJ/%smol';
  rsJoulePerMoleName = '%sjoule per %smole';
  rsJoulePerMolePluralName = '%sjoules per %smole';

const
  JoulePerMoleUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJoulePerMoleSymbol;
    FName       : rsJoulePerMoleName;
    FPluralName : rsJoulePerMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TMoleKelvin }

resourcestring
  rsMoleKelvinSymbol = '%smol∙%sK';
  rsMoleKelvinName = '%smole %skelvin';
  rsMoleKelvinPluralName = '%smole %skelvins';

const
  MoleKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMoleKelvinSymbol;
    FName       : rsMoleKelvinName;
    FPluralName : rsMoleKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TJoulePerMolePerKelvin }

resourcestring
  rsJoulePerMolePerKelvinSymbol = '%sJ/%smol/%sK';
  rsJoulePerMolePerKelvinName = '%sjoule per %smole per %skelvin';
  rsJoulePerMolePerKelvinPluralName = '%sjoules per %smole per %skelvin';

const
  JoulePerMolePerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: -60; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJoulePerMolePerKelvinSymbol;
    FName       : rsJoulePerMolePerKelvinName;
    FPluralName : rsJoulePerMolePerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TOhmMeter }

resourcestring
  rsOhmMeterSymbol = '%sΩ∙%sm';
  rsOhmMeterName = '%sohm %smeter';
  rsOhmMeterPluralName = '%sohm %smeters';

const
  OhmMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 180; FSecond: -180; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsOhmMeterSymbol;
    FName       : rsOhmMeterName;
    FPluralName : rsOhmMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TVoltPerMeter }

resourcestring
  rsVoltPerMeterSymbol = '%sV/%sm';
  rsVoltPerMeterName = '%svolt per %smeter';
  rsVoltPerMeterPluralName = '%svolts per %smeter';

const
  VoltPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -180; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsVoltPerMeterSymbol;
    FName       : rsVoltPerMeterName;
    FPluralName : rsVoltPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TNewtonPerCoulomb }

resourcestring
  rsNewtonPerCoulombSymbol = '%sN/%sC';
  rsNewtonPerCoulombName = '%snewton per %scoulomb';
  rsNewtonPerCoulombPluralName = '%snewtons per %scoulomb';

const
  NewtonPerCoulombUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -180; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonPerCoulombSymbol;
    FName       : rsNewtonPerCoulombName;
    FPluralName : rsNewtonPerCoulombPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TCoulombPerMeter }

resourcestring
  rsCoulombPerMeterSymbol = '%sC/%sm';
  rsCoulombPerMeterName = '%scoulomb per %smeter';
  rsCoulombPerMeterPluralName = '%scoulombs per %smeter';

const
  CoulombPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCoulombPerMeterSymbol;
    FName       : rsCoulombPerMeterName;
    FPluralName : rsCoulombPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareCoulombPerMeter }

resourcestring
  rsSquareCoulombPerMeterSymbol = '%sC²/%sm';
  rsSquareCoulombPerMeterName = 'square %scoulomb per %smeter';
  rsSquareCoulombPerMeterPluralName = 'square %scoulombs per %smeter';

const
  SquareCoulombPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareCoulombPerMeterSymbol;
    FName       : rsSquareCoulombPerMeterName;
    FPluralName : rsSquareCoulombPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TCoulombPerSquareMeter }

resourcestring
  rsCoulombPerSquareMeterSymbol = '%sC/%sm²';
  rsCoulombPerSquareMeterName = '%scoulomb per square %smeter';
  rsCoulombPerSquareMeterPluralName = '%scoulombs per square %smeter';

const
  CoulombPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCoulombPerSquareMeterSymbol;
    FName       : rsCoulombPerSquareMeterName;
    FPluralName : rsCoulombPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TSquareMeterPerSquareCoulomb }

resourcestring
  rsSquareMeterPerSquareCoulombSymbol = '%sm²/%sC²';
  rsSquareMeterPerSquareCoulombName = 'square %smeter per square %scoulomb';
  rsSquareMeterPerSquareCoulombPluralName = 'square %smeters per square %scoulomb';

const
  SquareMeterPerSquareCoulombUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerSquareCoulombSymbol;
    FName       : rsSquareMeterPerSquareCoulombName;
    FPluralName : rsSquareMeterPerSquareCoulombPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TNewtonPerSquareCoulomb }

resourcestring
  rsNewtonPerSquareCoulombSymbol = '%sN/%sC²';
  rsNewtonPerSquareCoulombName = '%snewton per square %scoulomb';
  rsNewtonPerSquareCoulombPluralName = '%snewtons per square %scoulomb';

const
  NewtonPerSquareCoulombUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -240; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonPerSquareCoulombSymbol;
    FName       : rsNewtonPerSquareCoulombName;
    FPluralName : rsNewtonPerSquareCoulombPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TNewtonSquareMeterPerSquareCoulomb }

resourcestring
  rsNewtonSquareMeterPerSquareCoulombSymbol = '%sN∙%sm²/%sC²';
  rsNewtonSquareMeterPerSquareCoulombName = '%snewton square %smeter per square %scoulomb';
  rsNewtonSquareMeterPerSquareCoulombPluralName = '%snewton square %smeters per square %scoulomb';

const
  NewtonSquareMeterPerSquareCoulombUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 180; FSecond: -240; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonSquareMeterPerSquareCoulombSymbol;
    FName       : rsNewtonSquareMeterPerSquareCoulombName;
    FPluralName : rsNewtonSquareMeterPerSquareCoulombPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -2));

{ TVoltMeter }

resourcestring
  rsVoltMeterSymbol = '%sV∙%sm';
  rsVoltMeterName = '%svolt %smeter';
  rsVoltMeterPluralName = '%svolt %smeters';

const
  VoltMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 180; FSecond: -180; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsVoltMeterSymbol;
    FName       : rsVoltMeterName;
    FPluralName : rsVoltMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TNewtonSquareMeterPerCoulomb }

resourcestring
  rsNewtonSquareMeterPerCoulombSymbol = '%sN∙%sm²/%sC';
  rsNewtonSquareMeterPerCoulombName = '%snewton square %smeter per %scoulomb';
  rsNewtonSquareMeterPerCoulombPluralName = '%snewton square %smeters per %scoulomb';

const
  NewtonSquareMeterPerCoulombUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 180; FSecond: -180; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonSquareMeterPerCoulombSymbol;
    FName       : rsNewtonSquareMeterPerCoulombName;
    FPluralName : rsNewtonSquareMeterPerCoulombPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TVoltMeterPerSecond }

resourcestring
  rsVoltMeterPerSecondSymbol = '%sV∙%sm/%ss';
  rsVoltMeterPerSecondName = '%svolt %smeter per %ssecond';
  rsVoltMeterPerSecondPluralName = '%svolt %smeters per %ssecond';

const
  VoltMeterPerSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 180; FSecond: -240; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsVoltMeterPerSecondSymbol;
    FName       : rsVoltMeterPerSecondName;
    FPluralName : rsVoltMeterPerSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TFaradPerMeter }

resourcestring
  rsFaradPerMeterSymbol = '%sF/%sm';
  rsFaradPerMeterName = '%sfarad per %smeter';
  rsFaradPerMeterPluralName = '%sfarads per %smeter';

const
  FaradPerMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -180; FSecond: 240; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsFaradPerMeterSymbol;
    FName       : rsFaradPerMeterName;
    FPluralName : rsFaradPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TAmperePerMeter }

resourcestring
  rsAmperePerMeterSymbol = '%sA/%sm';
  rsAmperePerMeterName = '%sampere per %smeter';
  rsAmperePerMeterPluralName = '%samperes per %smeter';

const
  AmperePerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsAmperePerMeterSymbol;
    FName       : rsAmperePerMeterName;
    FPluralName : rsAmperePerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TMeterPerAmpere }

resourcestring
  rsMeterPerAmpereSymbol = '%sm/%sA';
  rsMeterPerAmpereName = '%smeter per %sampere';
  rsMeterPerAmperePluralName = '%smeters per %sampere';

const
  MeterPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerAmpereSymbol;
    FName       : rsMeterPerAmpereName;
    FPluralName : rsMeterPerAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TTeslaMeter }

resourcestring
  rsTeslaMeterSymbol = '%sT∙%sm';
  rsTeslaMeterName = '%stesla %smeter';
  rsTeslaMeterPluralName = '%stesla %smeters';

const
  TeslaMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -120; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsTeslaMeterSymbol;
    FName       : rsTeslaMeterName;
    FPluralName : rsTeslaMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TNewtonPerAmpere }

resourcestring
  rsNewtonPerAmpereSymbol = '%sN/%sA';
  rsNewtonPerAmpereName = '%snewton per %sampere';
  rsNewtonPerAmperePluralName = '%snewtons per %sampere';

const
  NewtonPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -120; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonPerAmpereSymbol;
    FName       : rsNewtonPerAmpereName;
    FPluralName : rsNewtonPerAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TTeslaPerAmpere }

resourcestring
  rsTeslaPerAmpereSymbol = '%sT/%sA';
  rsTeslaPerAmpereName = '%stesla per %sampere';
  rsTeslaPerAmperePluralName = '%steslas per %sampere';

const
  TeslaPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsTeslaPerAmpereSymbol;
    FName       : rsTeslaPerAmpereName;
    FPluralName : rsTeslaPerAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ THenryPerMeter }

resourcestring
  rsHenryPerMeterSymbol = '%sH/%sm';
  rsHenryPerMeterName = '%shenry per %smeter';
  rsHenryPerMeterPluralName = '%shenries per %smeter';

const
  HenryPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -120; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsHenryPerMeterSymbol;
    FName       : rsHenryPerMeterName;
    FPluralName : rsHenryPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TTeslaMeterPerAmpere }

resourcestring
  rsTeslaMeterPerAmpereSymbol = '%sT∙%sm/%sA';
  rsTeslaMeterPerAmpereName = '%stesla %smeter per %sampere';
  rsTeslaMeterPerAmperePluralName = '%stesla %smeters per %sampere';

const
  TeslaMeterPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -120; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsTeslaMeterPerAmpereSymbol;
    FName       : rsTeslaMeterPerAmpereName;
    FPluralName : rsTeslaMeterPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TNewtonPerSquareAmpere }

resourcestring
  rsNewtonPerSquareAmpereSymbol = '%sN/%sA²';
  rsNewtonPerSquareAmpereName = '%snewton per square %sampere';
  rsNewtonPerSquareAmperePluralName = '%snewtons per square %sampere';

const
  NewtonPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -120; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsNewtonPerSquareAmpereSymbol;
    FName       : rsNewtonPerSquareAmpereName;
    FPluralName : rsNewtonPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TRadianPerMeter }

resourcestring
  rsRadianPerMeterSymbol = 'rad/%sm';
  rsRadianPerMeterName = 'radian per %smeter';
  rsRadianPerMeterPluralName = 'radians per %smeter';

const
  RadianPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsRadianPerMeterSymbol;
    FName       : rsRadianPerMeterName;
    FPluralName : rsRadianPerMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TSquareKilogramPerSquareSecond }

resourcestring
  rsSquareKilogramPerSquareSecondSymbol = '%sg²/%ss²';
  rsSquareKilogramPerSquareSecondName = 'square %sgram per square %ssecond';
  rsSquareKilogramPerSquareSecondPluralName = 'square %sgrams per square %ssecond';

const
  SquareKilogramPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramPerSquareSecondSymbol;
    FName       : rsSquareKilogramPerSquareSecondName;
    FPluralName : rsSquareKilogramPerSquareSecondPluralName;
    FPrefixes   : (pKilo, pNone);
    FExponents  : (2, -2));

{ TSquareSecondPerSquareMeter }

resourcestring
  rsSquareSecondPerSquareMeterSymbol = '%ss²/%sm²';
  rsSquareSecondPerSquareMeterName = 'square %ssecond per square %smeter';
  rsSquareSecondPerSquareMeterPluralName = 'square %sseconds per square %smeter';

const
  SquareSecondPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondPerSquareMeterSymbol;
    FName       : rsSquareSecondPerSquareMeterName;
    FPluralName : rsSquareSecondPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TSquareJoule }

resourcestring
  rsSquareJouleSymbol = '%sJ²';
  rsSquareJouleName = 'square %sjoule';
  rsSquareJoulePluralName = 'square %sjoules';

const
  SquareJouleUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 240; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareJouleSymbol;
    FName       : rsSquareJouleName;
    FPluralName : rsSquareJoulePluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

var
  J2 : TUnit absolute SquareJouleUnit;

const
  TJ2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 240; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+24); {$ELSE} (1E+24); {$ENDIF}
  GJ2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 240; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MJ2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 240; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kJ2        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: 120; FMeter: 240; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0); FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}

{ TJouleSecond }

resourcestring
  rsJouleSecondSymbol = '%sJ∙%ss';
  rsJouleSecondName = '%sjoule %ssecond';
  rsJouleSecondPluralName = '%sjoule %sseconds';

const
  JouleSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJouleSecondSymbol;
    FName       : rsJouleSecondName;
    FPluralName : rsJouleSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TJoulePerHertz }

resourcestring
  rsJoulePerHertzSymbol = '%sJ/%sHz';
  rsJoulePerHertzName = '%sjoule per %shertz';
  rsJoulePerHertzPluralName = '%sjoules per %shertz';

const
  JoulePerHertzUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJoulePerHertzSymbol;
    FName       : rsJoulePerHertzName;
    FPluralName : rsJoulePerHertzPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TElectronvoltSecond }

resourcestring
  rsElectronvoltSecondSymbol = '%seV∙%ss';
  rsElectronvoltSecondName = '%selectronvolt %ssecond';
  rsElectronvoltSecondPluralName = '%selectronvolt %sseconds';

const
  ElectronvoltSecondUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsElectronvoltSecondSymbol;
    FName       : rsElectronvoltSecondName;
    FPluralName : rsElectronvoltSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1);
    FFactor     : (1.60217742320523E-019));

{ TElectronvoltMeterPerSpeedOfLight }

resourcestring
  rsElectronvoltMeterPerSpeedOfLightSymbol = '%seV∙%sm/c';
  rsElectronvoltMeterPerSpeedOfLightName = '%selectronvolt %smeter per speed of  light';
  rsElectronvoltMeterPerSpeedOfLightPluralName = '%selectronvolt %smeters per speed of  light';

const
  ElectronvoltMeterPerSpeedOfLightUnit : TFactoredUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsElectronvoltMeterPerSpeedOfLightSymbol;
    FName       : rsElectronvoltMeterPerSpeedOfLightName;
    FPluralName : rsElectronvoltMeterPerSpeedOfLightPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1);
    FFactor     : (1.7826619216279E-36));

{ TSquareJouleSquareSecond }

resourcestring
  rsSquareJouleSquareSecondSymbol = '%sJ²∙%ss²';
  rsSquareJouleSquareSecondName = 'square %sjoule square %ssecond';
  rsSquareJouleSquareSecondPluralName = 'square %sjoule square %sseconds';

const
  SquareJouleSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 240; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareJouleSquareSecondSymbol;
    FName       : rsSquareJouleSquareSecondName;
    FPluralName : rsSquareJouleSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 2));

{ TCoulombPerKilogram }

resourcestring
  rsCoulombPerKilogramSymbol = '%sC/%sg';
  rsCoulombPerKilogramName = '%scoulomb per %sgram';
  rsCoulombPerKilogramPluralName = '%scoulombs per %sgram';

const
  CoulombPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCoulombPerKilogramSymbol;
    FName       : rsCoulombPerKilogramName;
    FPluralName : rsCoulombPerKilogramPluralName;
    FPrefixes   : (pNone, pKilo);
    FExponents  : (1, -1));

{ TSquareMeterAmpere }

resourcestring
  rsSquareMeterAmpereSymbol = '%sm²∙%sA';
  rsSquareMeterAmpereName = 'square %smeter %sampere';
  rsSquareMeterAmperePluralName = 'square %smeter %samperes';

const
  SquareMeterAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterAmpereSymbol;
    FName       : rsSquareMeterAmpereName;
    FPluralName : rsSquareMeterAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 1));

{ TJoulePerTesla }

resourcestring
  rsJoulePerTeslaSymbol = '%sJ/%sT';
  rsJoulePerTeslaName = '%sjoule per %stesla';
  rsJoulePerTeslaPluralName = '%sjoules per %stesla';

const
  JoulePerTeslaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsJoulePerTeslaSymbol;
    FName       : rsJoulePerTeslaName;
    FPluralName : rsJoulePerTeslaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TLumenPerWatt }

resourcestring
  rsLumenPerWattSymbol = '%slm/%sW';
  rsLumenPerWattName = '%slumen per %swatt';
  rsLumenPerWattPluralName = '%slumens per %swatt';

const
  LumenPerWattUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 60);
    FSymbol     : rsLumenPerWattSymbol;
    FName       : rsLumenPerWattName;
    FPluralName : rsLumenPerWattPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TReciprocalMole }

resourcestring
  rsReciprocalMoleSymbol = '1/%smol';
  rsReciprocalMoleName = 'reciprocal %smole';
  rsReciprocalMolePluralName = 'reciprocal %smoles';

const
  ReciprocalMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalMoleSymbol;
    FName       : rsReciprocalMoleName;
    FPluralName : rsReciprocalMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TAmperePerSquareMeter }

resourcestring
  rsAmperePerSquareMeterSymbol = '%sA/%sm²';
  rsAmperePerSquareMeterName = '%sampere per square %smeter';
  rsAmperePerSquareMeterPluralName = '%samperes per square %smeter';

const
  AmperePerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsAmperePerSquareMeterSymbol;
    FName       : rsAmperePerSquareMeterName;
    FPluralName : rsAmperePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TMolePerCubicMeter }

resourcestring
  rsMolePerCubicMeterSymbol = '%smol/%sm³';
  rsMolePerCubicMeterName = '%smole per cubic %smeter';
  rsMolePerCubicMeterPluralName = '%smoles per cubic %smeter';

const
  MolePerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMolePerCubicMeterSymbol;
    FName       : rsMolePerCubicMeterName;
    FPluralName : rsMolePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TCandelaPerSquareMeter }

resourcestring
  rsCandelaPerSquareMeterSymbol = '%scd/%sm²';
  rsCandelaPerSquareMeterName = '%scandela per square %smeter';
  rsCandelaPerSquareMeterPluralName = '%scandelas per square %smeter';

const
  CandelaPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 0);
    FSymbol     : rsCandelaPerSquareMeterSymbol;
    FName       : rsCandelaPerSquareMeterName;
    FPluralName : rsCandelaPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TCoulombPerCubicMeter }

resourcestring
  rsCoulombPerCubicMeterSymbol = '%sC/%sm³';
  rsCoulombPerCubicMeterName = '%scoulomb per cubic %smeter';
  rsCoulombPerCubicMeterPluralName = '%scoulombs per cubic %smeter';

const
  CoulombPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCoulombPerCubicMeterSymbol;
    FName       : rsCoulombPerCubicMeterName;
    FPluralName : rsCoulombPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TGrayPerSecond }

resourcestring
  rsGrayPerSecondSymbol = '%sGy/%ss';
  rsGrayPerSecondName = '%sgray per %ssecond';
  rsGrayPerSecondPluralName = '%sgrays per %ssecond';

const
  GrayPerSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsGrayPerSecondSymbol;
    FName       : rsGrayPerSecondName;
    FPluralName : rsGrayPerSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSteradianHertz }

resourcestring
  rsSteradianHertzSymbol = 'sr∙%sHz';
  rsSteradianHertzName = 'steradian %shertz';
  rsSteradianHertzPluralName = 'steradian %shertz';

const
  SteradianHertzUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSteradianHertzSymbol;
    FName       : rsSteradianHertzName;
    FPluralName : rsSteradianHertzPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TMeterSteradian }

resourcestring
  rsMeterSteradianSymbol = '%sm∙sr';
  rsMeterSteradianName = '%smeter steradian';
  rsMeterSteradianPluralName = '%smeter steradians';

const
  MeterSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsMeterSteradianSymbol;
    FName       : rsMeterSteradianName;
    FPluralName : rsMeterSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareMeterSteradian }

resourcestring
  rsSquareMeterSteradianSymbol = '%sm²∙sr';
  rsSquareMeterSteradianName = 'square %smeter steradian';
  rsSquareMeterSteradianPluralName = 'square %smeter steradians';

const
  SquareMeterSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSquareMeterSteradianSymbol;
    FName       : rsSquareMeterSteradianName;
    FPluralName : rsSquareMeterSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

{ TCubicMeterSteradian }

resourcestring
  rsCubicMeterSteradianSymbol = '%sm³∙sr';
  rsCubicMeterSteradianName = 'cubic %smeter steradian';
  rsCubicMeterSteradianPluralName = 'cubic %smeter steradians';

const
  CubicMeterSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsCubicMeterSteradianSymbol;
    FName       : rsCubicMeterSteradianName;
    FPluralName : rsCubicMeterSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareMeterSteradianHertz }

resourcestring
  rsSquareMeterSteradianHertzSymbol = '%sm²∙sr∙%shertz';
  rsSquareMeterSteradianHertzName = 'square %smeter steradian %shertz';
  rsSquareMeterSteradianHertzPluralName = 'square %smeter steradian %shertz';

const
  SquareMeterSteradianHertzUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSquareMeterSteradianHertzSymbol;
    FName       : rsSquareMeterSteradianHertzName;
    FPluralName : rsSquareMeterSteradianHertzPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 1));

{ TWattPerSteradian }

resourcestring
  rsWattPerSteradianSymbol = '%sW/sr';
  rsWattPerSteradianName = '%swatt per steradian';
  rsWattPerSteradianPluralName = '%swatts per steradian';

const
  WattPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsWattPerSteradianSymbol;
    FName       : rsWattPerSteradianName;
    FPluralName : rsWattPerSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TWattPerSteradianPerHertz }

resourcestring
  rsWattPerSteradianPerHertzSymbol = '%sW/sr/%sHz';
  rsWattPerSteradianPerHertzName = '%swatt per steradian per %shertz';
  rsWattPerSteradianPerHertzPluralName = '%swatts per steradian per %shertz';

const
  WattPerSteradianPerHertzUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsWattPerSteradianPerHertzSymbol;
    FName       : rsWattPerSteradianPerHertzName;
    FPluralName : rsWattPerSteradianPerHertzPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TWattPerMeterPerSteradian }

resourcestring
  rsWattPerMeterPerSteradianSymbol = '%sW/sr/%sm';
  rsWattPerMeterPerSteradianName = '%swatt per steradian per %smeter';
  rsWattPerMeterPerSteradianPluralName = '%swatts per steradian per %smeter';

const
  WattPerMeterPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsWattPerMeterPerSteradianSymbol;
    FName       : rsWattPerMeterPerSteradianName;
    FPluralName : rsWattPerMeterPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TWattPerSquareMeterPerSteradian }

resourcestring
  rsWattPerSquareMeterPerSteradianSymbol = '%sW/%sm²/sr';
  rsWattPerSquareMeterPerSteradianName = '%swatt per square %smeter per steradian';
  rsWattPerSquareMeterPerSteradianPluralName = '%swatts per square %smeter per steradian';

const
  WattPerSquareMeterPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsWattPerSquareMeterPerSteradianSymbol;
    FName       : rsWattPerSquareMeterPerSteradianName;
    FPluralName : rsWattPerSquareMeterPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TWattPerCubicMeterPerSteradian }

resourcestring
  rsWattPerCubicMeterPerSteradianSymbol = '%sW/%sm³/sr';
  rsWattPerCubicMeterPerSteradianName = '%swatt per cubic %smeter per steradian';
  rsWattPerCubicMeterPerSteradianPluralName = '%swatts per cubic %smeter per steradian';

const
  WattPerCubicMeterPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -60; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsWattPerCubicMeterPerSteradianSymbol;
    FName       : rsWattPerCubicMeterPerSteradianName;
    FPluralName : rsWattPerCubicMeterPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TWattPerSquareMeterPerSteradianPerHertz }

resourcestring
  rsWattPerSquareMeterPerSteradianPerHertzSymbol = '%sW/%sm²/sr/%sHz';
  rsWattPerSquareMeterPerSteradianPerHertzName = '%swatt per square %smeter per steradian per %shertz';
  rsWattPerSquareMeterPerSteradianPerHertzPluralName = '%swatts per square %smeter per steradian per %shertz';

const
  WattPerSquareMeterPerSteradianPerHertzUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsWattPerSquareMeterPerSteradianPerHertzSymbol;
    FName       : rsWattPerSquareMeterPerSteradianPerHertzName;
    FPluralName : rsWattPerSquareMeterPerSteradianPerHertzPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -1));

{ TKatalPerCubicMeter }

resourcestring
  rsKatalPerCubicMeterSymbol = '%skat/%sm³';
  rsKatalPerCubicMeterName = '%skatal per cubic %smeter';
  rsKatalPerCubicMeterPluralName = '%skatals per cubic %smeter';

const
  KatalPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKatalPerCubicMeterSymbol;
    FName       : rsKatalPerCubicMeterName;
    FPluralName : rsKatalPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TCoulombPerMole }

resourcestring
  rsCoulombPerMoleSymbol = '%sC/%smol';
  rsCoulombPerMoleName = '%scoulomb per %smole';
  rsCoulombPerMolePluralName = '%scoulombs per %smole';

const
  CoulombPerMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 60; FKelvin: 0; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCoulombPerMoleSymbol;
    FName       : rsCoulombPerMoleName;
    FPluralName : rsCoulombPerMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TReciprocalNewton }

resourcestring
  rsReciprocalNewtonSymbol = '1/%sN';
  rsReciprocalNewtonName = 'reciprocal %snewton';
  rsReciprocalNewtonPluralName = 'reciprocal %snewtons';

const
  ReciprocalNewtonUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalNewtonSymbol;
    FName       : rsReciprocalNewtonName;
    FPluralName : rsReciprocalNewtonPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalTesla }

resourcestring
  rsReciprocalTeslaSymbol = '1/%sT';
  rsReciprocalTeslaName = 'reciprocal %stesla';
  rsReciprocalTeslaPluralName = 'reciprocal %steslas';

const
  ReciprocalTeslaUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 120; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalTeslaSymbol;
    FName       : rsReciprocalTeslaName;
    FPluralName : rsReciprocalTeslaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalPascal }

resourcestring
  rsReciprocalPascalSymbol = '1/%sPa';
  rsReciprocalPascalName = 'reciprocal %spascal';
  rsReciprocalPascalPluralName = 'reciprocal %spascals';

const
  ReciprocalPascalUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 60; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalPascalSymbol;
    FName       : rsReciprocalPascalName;
    FPluralName : rsReciprocalPascalPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalWeber }

resourcestring
  rsReciprocalWeberSymbol = '1/%sWb';
  rsReciprocalWeberName = 'reciprocal %sweber';
  rsReciprocalWeberPluralName = 'reciprocal %swebers';

const
  ReciprocalWeberUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 120; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalWeberSymbol;
    FName       : rsReciprocalWeberName;
    FPluralName : rsReciprocalWeberPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalWatt }

resourcestring
  rsReciprocalWattSymbol = '1/%sW';
  rsReciprocalWattName = 'reciprocal %swatt';
  rsReciprocalWattPluralName = 'reciprocal %swatts';

const
  ReciprocalWattUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalWattSymbol;
    FName       : rsReciprocalWattName;
    FPluralName : rsReciprocalWattPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalRadian }

resourcestring
  rsReciprocalRadianSymbol = '1/%srad';
  rsReciprocalRadianName = 'reciprocal %sradian';
  rsReciprocalRadianPluralName = 'reciprocal %sradians';

const
  ReciprocalRadianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalRadianSymbol;
    FName       : rsReciprocalRadianName;
    FPluralName : rsReciprocalRadianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TMeterPerVolt }

resourcestring
  rsMeterPerVoltSymbol = '%sm/%sV';
  rsMeterPerVoltName = '%smeter per %svolt';
  rsMeterPerVoltPluralName = '%smeters per %svolt';

const
  MeterPerVoltUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 180; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerVoltSymbol;
    FName       : rsMeterPerVoltName;
    FPluralName : rsMeterPerVoltPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSecondPerRadian }

resourcestring
  rsSecondPerRadianSymbol = '%ss/rad';
  rsSecondPerRadianName = '%ssecond per radian';
  rsSecondPerRadianPluralName = '%sseconds per radian';

const
  SecondPerRadianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSecondPerRadianSymbol;
    FName       : rsSecondPerRadianName;
    FPluralName : rsSecondPerRadianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSexticRootKilogram }

resourcestring
  rsSexticRootKilogramSymbol = '⁶√%skg';
  rsSexticRootKilogramName = 'sextic root %skilogram';
  rsSexticRootKilogramPluralName = 'sextic root %skilograms';

const
  SexticRootKilogramUnit : TUnit = (
    FDim        : (FKilogram: 10; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticRootKilogramSymbol;
    FName       : rsSexticRootKilogramName;
    FPluralName : rsSexticRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuinticRootKilogram }

resourcestring
  rsQuinticRootKilogramSymbol = '⁵√%skg';
  rsQuinticRootKilogramName = 'quintic root %skilogram';
  rsQuinticRootKilogramPluralName = 'quintic root %skilograms';

const
  QuinticRootKilogramUnit : TUnit = (
    FDim        : (FKilogram: 12; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuinticRootKilogramSymbol;
    FName       : rsQuinticRootKilogramName;
    FPluralName : rsQuinticRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootKilogram }

resourcestring
  rsQuarticRootKilogramSymbol = '∜%skg';
  rsQuarticRootKilogramName = 'quartic root %skilogram';
  rsQuarticRootKilogramPluralName = 'quartic root %skilograms';

const
  QuarticRootKilogramUnit : TUnit = (
    FDim        : (FKilogram: 15; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticRootKilogramSymbol;
    FName       : rsQuarticRootKilogramName;
    FPluralName : rsQuarticRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TCubicRootKilogram }

resourcestring
  rsCubicRootKilogramSymbol = '∛%skg';
  rsCubicRootKilogramName = 'cubic root %skilogram';
  rsCubicRootKilogramPluralName = 'cubic root %skilograms';

const
  CubicRootKilogramUnit : TUnit = (
    FDim        : (FKilogram: 20; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicRootKilogramSymbol;
    FName       : rsCubicRootKilogramName;
    FPluralName : rsCubicRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootKilogram }

resourcestring
  rsSquareRootKilogramSymbol = '√%skg';
  rsSquareRootKilogramName = 'square root %skilogram';
  rsSquareRootKilogramPluralName = 'square root %skilograms';

const
  SquareRootKilogramUnit : TUnit = (
    FDim        : (FKilogram: 30; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootKilogramSymbol;
    FName       : rsSquareRootKilogramName;
    FPluralName : rsSquareRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootCubicKilogram }

resourcestring
  rsQuarticRootCubicKilogramSymbol = '∜%skg³';
  rsQuarticRootCubicKilogramName = 'quartic root cubic %skilogram';
  rsQuarticRootCubicKilogramPluralName = 'quartic root cubic %skilograms';

const
  QuarticRootCubicKilogramUnit : TUnit = (
    FDim        : (FKilogram: 45; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticRootCubicKilogramSymbol;
    FName       : rsQuarticRootCubicKilogramName;
    FPluralName : rsQuarticRootCubicKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootCubicKilogram }

resourcestring
  rsSquareRootCubicKilogramSymbol = '√%skg³';
  rsSquareRootCubicKilogramName = 'square root cubic %skilogram';
  rsSquareRootCubicKilogramPluralName = 'square root cubic %skilograms';

const
  SquareRootCubicKilogramUnit : TUnit = (
    FDim        : (FKilogram: 90; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootCubicKilogramSymbol;
    FName       : rsSquareRootCubicKilogramName;
    FPluralName : rsSquareRootCubicKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootQuinticKilogram }

resourcestring
  rsSquareRootQuinticKilogramSymbol = '√%skg⁵';
  rsSquareRootQuinticKilogramName = 'square root quintic %skilogram';
  rsSquareRootQuinticKilogramPluralName = 'square root quintic %skilograms';

const
  SquareRootQuinticKilogramUnit : TUnit = (
    FDim        : (FKilogram: 150; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootQuinticKilogramSymbol;
    FName       : rsSquareRootQuinticKilogramName;
    FPluralName : rsSquareRootQuinticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TCubicKilogram }

resourcestring
  rsCubicKilogramSymbol = '%skg³';
  rsCubicKilogramName = 'cubic %skilogram';
  rsCubicKilogramPluralName = 'cubic %skilograms';

const
  CubicKilogramUnit : TUnit = (
    FDim        : (FKilogram: 180; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicKilogramSymbol;
    FName       : rsCubicKilogramName;
    FPluralName : rsCubicKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TQuarticKilogram }

resourcestring
  rsQuarticKilogramSymbol = '%skg⁴';
  rsQuarticKilogramName = 'quartic %skilogram';
  rsQuarticKilogramPluralName = 'quartic %skilograms';

const
  QuarticKilogramUnit : TUnit = (
    FDim        : (FKilogram: 240; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticKilogramSymbol;
    FName       : rsQuarticKilogramName;
    FPluralName : rsQuarticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (4));

{ TQuinticKilogram }

resourcestring
  rsQuinticKilogramSymbol = '%skg⁵';
  rsQuinticKilogramName = 'quintic %skilogram';
  rsQuinticKilogramPluralName = 'quintic %skilograms';

const
  QuinticKilogramUnit : TUnit = (
    FDim        : (FKilogram: 300; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuinticKilogramSymbol;
    FName       : rsQuinticKilogramName;
    FPluralName : rsQuinticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TSexticKilogram }

resourcestring
  rsSexticKilogramSymbol = '%skg⁶';
  rsSexticKilogramName = 'sextic %skilogram';
  rsSexticKilogramPluralName = 'sextic %skilograms';

const
  SexticKilogramUnit : TUnit = (
    FDim        : (FKilogram: 360; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticKilogramSymbol;
    FName       : rsSexticKilogramName;
    FPluralName : rsSexticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (6));

{ TSexticRootMeter }

resourcestring
  rsSexticRootMeterSymbol = '⁶√%sm';
  rsSexticRootMeterName = 'sextic root %smeter';
  rsSexticRootMeterPluralName = 'sextic root %smeters';

const
  SexticRootMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 10; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticRootMeterSymbol;
    FName       : rsSexticRootMeterName;
    FPluralName : rsSexticRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuinticRootMeter }

resourcestring
  rsQuinticRootMeterSymbol = '⁵√%sm';
  rsQuinticRootMeterName = 'quintic root %smeter';
  rsQuinticRootMeterPluralName = 'quintic root %smeters';

const
  QuinticRootMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 12; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuinticRootMeterSymbol;
    FName       : rsQuinticRootMeterName;
    FPluralName : rsQuinticRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootMeter }

resourcestring
  rsQuarticRootMeterSymbol = '∜%sm';
  rsQuarticRootMeterName = 'quartic root %smeter';
  rsQuarticRootMeterPluralName = 'quartic root %smeters';

const
  QuarticRootMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 15; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticRootMeterSymbol;
    FName       : rsQuarticRootMeterName;
    FPluralName : rsQuarticRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TCubicRootMeter }

resourcestring
  rsCubicRootMeterSymbol = '∛%sm';
  rsCubicRootMeterName = 'cubic root %smeter';
  rsCubicRootMeterPluralName = 'cubic root %smeters';

const
  CubicRootMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 20; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicRootMeterSymbol;
    FName       : rsCubicRootMeterName;
    FPluralName : rsCubicRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootCubicMeter }

resourcestring
  rsQuarticRootCubicMeterSymbol = '∜%sm³';
  rsQuarticRootCubicMeterName = 'quartic root cubic %smeter';
  rsQuarticRootCubicMeterPluralName = 'quartic root cubic %smeters';

const
  QuarticRootCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 45; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticRootCubicMeterSymbol;
    FName       : rsQuarticRootCubicMeterName;
    FPluralName : rsQuarticRootCubicMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootCubicMeter }

resourcestring
  rsSquareRootCubicMeterSymbol = '√%sm³';
  rsSquareRootCubicMeterName = 'square root cubic %smeter';
  rsSquareRootCubicMeterPluralName = 'square root cubic %smeters';

const
  SquareRootCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 90; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootCubicMeterSymbol;
    FName       : rsSquareRootCubicMeterName;
    FPluralName : rsSquareRootCubicMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootQuinticMeter }

resourcestring
  rsSquareRootQuinticMeterSymbol = '√%sm⁵';
  rsSquareRootQuinticMeterName = 'square root quintic %smeter';
  rsSquareRootQuinticMeterPluralName = 'square root quintic %smeters';

const
  SquareRootQuinticMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 150; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootQuinticMeterSymbol;
    FName       : rsSquareRootQuinticMeterName;
    FPluralName : rsSquareRootQuinticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TSexticRootSecond }

resourcestring
  rsSexticRootSecondSymbol = '⁶√%ss';
  rsSexticRootSecondName = 'sextic root %ssecond';
  rsSexticRootSecondPluralName = 'sextic root %sseconds';

const
  SexticRootSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 10; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticRootSecondSymbol;
    FName       : rsSexticRootSecondName;
    FPluralName : rsSexticRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuinticRootSecond }

resourcestring
  rsQuinticRootSecondSymbol = '⁵√%ss';
  rsQuinticRootSecondName = 'quintic root %ssecond';
  rsQuinticRootSecondPluralName = 'quintic root %sseconds';

const
  QuinticRootSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 12; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuinticRootSecondSymbol;
    FName       : rsQuinticRootSecondName;
    FPluralName : rsQuinticRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootSecond }

resourcestring
  rsQuarticRootSecondSymbol = '∜%ss';
  rsQuarticRootSecondName = 'quartic root %ssecond';
  rsQuarticRootSecondPluralName = 'quartic root %sseconds';

const
  QuarticRootSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 15; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticRootSecondSymbol;
    FName       : rsQuarticRootSecondName;
    FPluralName : rsQuarticRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TCubicRootSecond }

resourcestring
  rsCubicRootSecondSymbol = '∛%ss';
  rsCubicRootSecondName = 'cubic root %ssecond';
  rsCubicRootSecondPluralName = 'cubic root %sseconds';

const
  CubicRootSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 20; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicRootSecondSymbol;
    FName       : rsCubicRootSecondName;
    FPluralName : rsCubicRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootSecond }

resourcestring
  rsSquareRootSecondSymbol = '√%ss';
  rsSquareRootSecondName = 'square root %ssecond';
  rsSquareRootSecondPluralName = 'square root %sseconds';

const
  SquareRootSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 30; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootSecondSymbol;
    FName       : rsSquareRootSecondName;
    FPluralName : rsSquareRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootCubicSecond }

resourcestring
  rsQuarticRootCubicSecondSymbol = '∜%ss³';
  rsQuarticRootCubicSecondName = 'quartic root cubic %ssecond';
  rsQuarticRootCubicSecondPluralName = 'quartic root cubic %sseconds';

const
  QuarticRootCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 45; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticRootCubicSecondSymbol;
    FName       : rsQuarticRootCubicSecondName;
    FPluralName : rsQuarticRootCubicSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootCubicSecond }

resourcestring
  rsSquareRootCubicSecondSymbol = '√%ss³';
  rsSquareRootCubicSecondName = 'square root cubic %ssecond';
  rsSquareRootCubicSecondPluralName = 'square root cubic %sseconds';

const
  SquareRootCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 90; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootCubicSecondSymbol;
    FName       : rsSquareRootCubicSecondName;
    FPluralName : rsSquareRootCubicSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootQuinticSecond }

resourcestring
  rsSquareRootQuinticSecondSymbol = '√%ss⁵';
  rsSquareRootQuinticSecondName = 'square root quintic %ssecond';
  rsSquareRootQuinticSecondPluralName = 'square root quintic %sseconds';

const
  SquareRootQuinticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 150; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootQuinticSecondSymbol;
    FName       : rsSquareRootQuinticSecondName;
    FPluralName : rsSquareRootQuinticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TSexticRootAmpere }

resourcestring
  rsSexticRootAmpereSymbol = '⁶√%sA';
  rsSexticRootAmpereName = 'sextic root %sampere';
  rsSexticRootAmperePluralName = 'sextic root %samperes';

const
  SexticRootAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 10; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticRootAmpereSymbol;
    FName       : rsSexticRootAmpereName;
    FPluralName : rsSexticRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuinticRootAmpere }

resourcestring
  rsQuinticRootAmpereSymbol = '⁵√%sA';
  rsQuinticRootAmpereName = 'quintic root %sampere';
  rsQuinticRootAmperePluralName = 'quintic root %samperes';

const
  QuinticRootAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 12; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuinticRootAmpereSymbol;
    FName       : rsQuinticRootAmpereName;
    FPluralName : rsQuinticRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootAmpere }

resourcestring
  rsQuarticRootAmpereSymbol = '∜%sA';
  rsQuarticRootAmpereName = 'quartic root %sampere';
  rsQuarticRootAmperePluralName = 'quartic root %samperes';

const
  QuarticRootAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 15; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticRootAmpereSymbol;
    FName       : rsQuarticRootAmpereName;
    FPluralName : rsQuarticRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TCubicRootAmpere }

resourcestring
  rsCubicRootAmpereSymbol = '∛%sA';
  rsCubicRootAmpereName = 'cubic root %sampere';
  rsCubicRootAmperePluralName = 'cubic root %samperes';

const
  CubicRootAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 20; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicRootAmpereSymbol;
    FName       : rsCubicRootAmpereName;
    FPluralName : rsCubicRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootAmpere }

resourcestring
  rsSquareRootAmpereSymbol = '√%sA';
  rsSquareRootAmpereName = 'square root %sampere';
  rsSquareRootAmperePluralName = 'square root %samperes';

const
  SquareRootAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 30; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootAmpereSymbol;
    FName       : rsSquareRootAmpereName;
    FPluralName : rsSquareRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootCubicAmpere }

resourcestring
  rsQuarticRootCubicAmpereSymbol = '∜%sA³';
  rsQuarticRootCubicAmpereName = 'quartic root cubic %sampere';
  rsQuarticRootCubicAmperePluralName = 'quartic root cubic %samperes';

const
  QuarticRootCubicAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 45; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticRootCubicAmpereSymbol;
    FName       : rsQuarticRootCubicAmpereName;
    FPluralName : rsQuarticRootCubicAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootCubicAmpere }

resourcestring
  rsSquareRootCubicAmpereSymbol = '√%sA³';
  rsSquareRootCubicAmpereName = 'square root cubic %sampere';
  rsSquareRootCubicAmperePluralName = 'square root cubic %samperes';

const
  SquareRootCubicAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 90; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootCubicAmpereSymbol;
    FName       : rsSquareRootCubicAmpereName;
    FPluralName : rsSquareRootCubicAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootQuinticAmpere }

resourcestring
  rsSquareRootQuinticAmpereSymbol = '√%sA⁵';
  rsSquareRootQuinticAmpereName = 'square root quintic %sampere';
  rsSquareRootQuinticAmperePluralName = 'square root quintic %samperes';

const
  SquareRootQuinticAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 150; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootQuinticAmpereSymbol;
    FName       : rsSquareRootQuinticAmpereName;
    FPluralName : rsSquareRootQuinticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TCubicAmpere }

resourcestring
  rsCubicAmpereSymbol = '%sA³';
  rsCubicAmpereName = 'cubic %sampere';
  rsCubicAmperePluralName = 'cubic %samperes';

const
  CubicAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 180; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicAmpereSymbol;
    FName       : rsCubicAmpereName;
    FPluralName : rsCubicAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TQuarticAmpere }

resourcestring
  rsQuarticAmpereSymbol = '%sA⁴';
  rsQuarticAmpereName = 'quartic %sampere';
  rsQuarticAmperePluralName = 'quartic %samperes';

const
  QuarticAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 240; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticAmpereSymbol;
    FName       : rsQuarticAmpereName;
    FPluralName : rsQuarticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (4));

{ TQuinticAmpere }

resourcestring
  rsQuinticAmpereSymbol = '%sA⁵';
  rsQuinticAmpereName = 'quintic %sampere';
  rsQuinticAmperePluralName = 'quintic %samperes';

const
  QuinticAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 300; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuinticAmpereSymbol;
    FName       : rsQuinticAmpereName;
    FPluralName : rsQuinticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TSexticAmpere }

resourcestring
  rsSexticAmpereSymbol = '%sA⁶';
  rsSexticAmpereName = 'sextic %sampere';
  rsSexticAmperePluralName = 'sextic %samperes';

const
  SexticAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 360; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticAmpereSymbol;
    FName       : rsSexticAmpereName;
    FPluralName : rsSexticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (6));

{ TSexticRootKelvin }

resourcestring
  rsSexticRootKelvinSymbol = '⁶√%sK';
  rsSexticRootKelvinName = 'sextic root %skelvin';
  rsSexticRootKelvinPluralName = 'sextic root %skelvins';

const
  SexticRootKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 10; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticRootKelvinSymbol;
    FName       : rsSexticRootKelvinName;
    FPluralName : rsSexticRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuinticRootKelvin }

resourcestring
  rsQuinticRootKelvinSymbol = '⁵√%sK';
  rsQuinticRootKelvinName = 'quintic root %skelvin';
  rsQuinticRootKelvinPluralName = 'quintic root %skelvins';

const
  QuinticRootKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 12; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuinticRootKelvinSymbol;
    FName       : rsQuinticRootKelvinName;
    FPluralName : rsQuinticRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootKelvin }

resourcestring
  rsQuarticRootKelvinSymbol = '∜%sK';
  rsQuarticRootKelvinName = 'quartic root %skelvin';
  rsQuarticRootKelvinPluralName = 'quartic root %skelvins';

const
  QuarticRootKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 15; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticRootKelvinSymbol;
    FName       : rsQuarticRootKelvinName;
    FPluralName : rsQuarticRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TCubicRootKelvin }

resourcestring
  rsCubicRootKelvinSymbol = '∛%sK';
  rsCubicRootKelvinName = 'cubic root %skelvin';
  rsCubicRootKelvinPluralName = 'cubic root %skelvins';

const
  CubicRootKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 20; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicRootKelvinSymbol;
    FName       : rsCubicRootKelvinName;
    FPluralName : rsCubicRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootKelvin }

resourcestring
  rsSquareRootKelvinSymbol = '√%sK';
  rsSquareRootKelvinName = 'square root %skelvin';
  rsSquareRootKelvinPluralName = 'square root %skelvins';

const
  SquareRootKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 30; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootKelvinSymbol;
    FName       : rsSquareRootKelvinName;
    FPluralName : rsSquareRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootCubicKelvin }

resourcestring
  rsQuarticRootCubicKelvinSymbol = '∜%sK³';
  rsQuarticRootCubicKelvinName = 'quartic root cubic %skelvin';
  rsQuarticRootCubicKelvinPluralName = 'quartic root cubic %skelvins';

const
  QuarticRootCubicKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 45; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticRootCubicKelvinSymbol;
    FName       : rsQuarticRootCubicKelvinName;
    FPluralName : rsQuarticRootCubicKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootCubicKelvin }

resourcestring
  rsSquareRootCubicKelvinSymbol = '√%sK³';
  rsSquareRootCubicKelvinName = 'square root cubic %skelvin';
  rsSquareRootCubicKelvinPluralName = 'square root cubic %skelvins';

const
  SquareRootCubicKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 90; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootCubicKelvinSymbol;
    FName       : rsSquareRootCubicKelvinName;
    FPluralName : rsSquareRootCubicKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootQuinticKelvin }

resourcestring
  rsSquareRootQuinticKelvinSymbol = '√%sK⁵';
  rsSquareRootQuinticKelvinName = 'square root quintic %skelvin';
  rsSquareRootQuinticKelvinPluralName = 'square root quintic %skelvins';

const
  SquareRootQuinticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 150; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootQuinticKelvinSymbol;
    FName       : rsSquareRootQuinticKelvinName;
    FPluralName : rsSquareRootQuinticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TQuinticKelvin }

resourcestring
  rsQuinticKelvinSymbol = '%sK⁵';
  rsQuinticKelvinName = 'quintic %skelvin';
  rsQuinticKelvinPluralName = 'quintic %skelvins';

const
  QuinticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 300; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuinticKelvinSymbol;
    FName       : rsQuinticKelvinName;
    FPluralName : rsQuinticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TSexticKelvin }

resourcestring
  rsSexticKelvinSymbol = '%sK⁶';
  rsSexticKelvinName = 'sextic %skelvin';
  rsSexticKelvinPluralName = 'sextic %skelvins';

const
  SexticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 360; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticKelvinSymbol;
    FName       : rsSexticKelvinName;
    FPluralName : rsSexticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (6));

{ TSexticRootMole }

resourcestring
  rsSexticRootMoleSymbol = '⁶√%smol';
  rsSexticRootMoleName = 'sextic root %smole';
  rsSexticRootMolePluralName = 'sextic root %smoles';

const
  SexticRootMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 10; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticRootMoleSymbol;
    FName       : rsSexticRootMoleName;
    FPluralName : rsSexticRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuinticRootMole }

resourcestring
  rsQuinticRootMoleSymbol = '⁵√%smol';
  rsQuinticRootMoleName = 'quintic root %smole';
  rsQuinticRootMolePluralName = 'quintic root %smoles';

const
  QuinticRootMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 12; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuinticRootMoleSymbol;
    FName       : rsQuinticRootMoleName;
    FPluralName : rsQuinticRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootMole }

resourcestring
  rsQuarticRootMoleSymbol = '∜%smol';
  rsQuarticRootMoleName = 'quartic root %smole';
  rsQuarticRootMolePluralName = 'quartic root %smoles';

const
  QuarticRootMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 15; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticRootMoleSymbol;
    FName       : rsQuarticRootMoleName;
    FPluralName : rsQuarticRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TCubicRootMole }

resourcestring
  rsCubicRootMoleSymbol = '∛%smol';
  rsCubicRootMoleName = 'cubic root %smole';
  rsCubicRootMolePluralName = 'cubic root %smoles';

const
  CubicRootMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 20; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicRootMoleSymbol;
    FName       : rsCubicRootMoleName;
    FPluralName : rsCubicRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootMole }

resourcestring
  rsSquareRootMoleSymbol = '√%smol';
  rsSquareRootMoleName = 'square root %smole';
  rsSquareRootMolePluralName = 'square root %smoles';

const
  SquareRootMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 30; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootMoleSymbol;
    FName       : rsSquareRootMoleName;
    FPluralName : rsSquareRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootCubicMole }

resourcestring
  rsQuarticRootCubicMoleSymbol = '∜%smol³';
  rsQuarticRootCubicMoleName = 'quartic root cubic %smole';
  rsQuarticRootCubicMolePluralName = 'quartic root cubic %smoles';

const
  QuarticRootCubicMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 45; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticRootCubicMoleSymbol;
    FName       : rsQuarticRootCubicMoleName;
    FPluralName : rsQuarticRootCubicMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootCubicMole }

resourcestring
  rsSquareRootCubicMoleSymbol = '√%smol³';
  rsSquareRootCubicMoleName = 'square root cubic %smole';
  rsSquareRootCubicMolePluralName = 'square root cubic %smoles';

const
  SquareRootCubicMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 90; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootCubicMoleSymbol;
    FName       : rsSquareRootCubicMoleName;
    FPluralName : rsSquareRootCubicMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareMole }

resourcestring
  rsSquareMoleSymbol = '%smol²';
  rsSquareMoleName = 'square %smole';
  rsSquareMolePluralName = 'square %smoles';

const
  SquareMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 120; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMoleSymbol;
    FName       : rsSquareMoleName;
    FPluralName : rsSquareMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

{ TSquareRootQuinticMole }

resourcestring
  rsSquareRootQuinticMoleSymbol = '√%smol⁵';
  rsSquareRootQuinticMoleName = 'square root quintic %smole';
  rsSquareRootQuinticMolePluralName = 'square root quintic %smoles';

const
  SquareRootQuinticMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 150; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareRootQuinticMoleSymbol;
    FName       : rsSquareRootQuinticMoleName;
    FPluralName : rsSquareRootQuinticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TCubicMole }

resourcestring
  rsCubicMoleSymbol = '%smol³';
  rsCubicMoleName = 'cubic %smole';
  rsCubicMolePluralName = 'cubic %smoles';

const
  CubicMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 180; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMoleSymbol;
    FName       : rsCubicMoleName;
    FPluralName : rsCubicMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TQuarticMole }

resourcestring
  rsQuarticMoleSymbol = '%smol⁴';
  rsQuarticMoleName = 'quartic %smole';
  rsQuarticMolePluralName = 'quartic %smoles';

const
  QuarticMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 240; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticMoleSymbol;
    FName       : rsQuarticMoleName;
    FPluralName : rsQuarticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (4));

{ TQuinticMole }

resourcestring
  rsQuinticMoleSymbol = '%smol⁵';
  rsQuinticMoleName = 'quintic %smole';
  rsQuinticMolePluralName = 'quintic %smoles';

const
  QuinticMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 300; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuinticMoleSymbol;
    FName       : rsQuinticMoleName;
    FPluralName : rsQuinticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TSexticMole }

resourcestring
  rsSexticMoleSymbol = '%smol⁶';
  rsSexticMoleName = 'sextic %smole';
  rsSexticMolePluralName = 'sextic %smoles';

const
  SexticMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 360; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticMoleSymbol;
    FName       : rsSexticMoleName;
    FPluralName : rsSexticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (6));

{ TSexticRootCandela }

resourcestring
  rsSexticRootCandelaSymbol = '⁶√%scd';
  rsSexticRootCandelaName = 'sextic root %scandela';
  rsSexticRootCandelaPluralName = 'sextic root %scandelas';

const
  SexticRootCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 10; FSteradian: 0);
    FSymbol     : rsSexticRootCandelaSymbol;
    FName       : rsSexticRootCandelaName;
    FPluralName : rsSexticRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuinticRootCandela }

resourcestring
  rsQuinticRootCandelaSymbol = '⁵√%scd';
  rsQuinticRootCandelaName = 'quintic root %scandela';
  rsQuinticRootCandelaPluralName = 'quintic root %scandelas';

const
  QuinticRootCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 12; FSteradian: 0);
    FSymbol     : rsQuinticRootCandelaSymbol;
    FName       : rsQuinticRootCandelaName;
    FPluralName : rsQuinticRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootCandela }

resourcestring
  rsQuarticRootCandelaSymbol = '∜%scd';
  rsQuarticRootCandelaName = 'quartic root %scandela';
  rsQuarticRootCandelaPluralName = 'quartic root %scandelas';

const
  QuarticRootCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 15; FSteradian: 0);
    FSymbol     : rsQuarticRootCandelaSymbol;
    FName       : rsQuarticRootCandelaName;
    FPluralName : rsQuarticRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TCubicRootCandela }

resourcestring
  rsCubicRootCandelaSymbol = '∛%scd';
  rsCubicRootCandelaName = 'cubic root %scandela';
  rsCubicRootCandelaPluralName = 'cubic root %scandelas';

const
  CubicRootCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 20; FSteradian: 0);
    FSymbol     : rsCubicRootCandelaSymbol;
    FName       : rsCubicRootCandelaName;
    FPluralName : rsCubicRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSquareRootCandela }

resourcestring
  rsSquareRootCandelaSymbol = '√%scd';
  rsSquareRootCandelaName = 'square root %scandela';
  rsSquareRootCandelaPluralName = 'square root %scandelas';

const
  SquareRootCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 30; FSteradian: 0);
    FSymbol     : rsSquareRootCandelaSymbol;
    FName       : rsSquareRootCandelaName;
    FPluralName : rsSquareRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TQuarticRootCubicCandela }

resourcestring
  rsQuarticRootCubicCandelaSymbol = '∜%scd³';
  rsQuarticRootCubicCandelaName = 'quartic root cubic %scandela';
  rsQuarticRootCubicCandelaPluralName = 'quartic root cubic %scandelas';

const
  QuarticRootCubicCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 45; FSteradian: 0);
    FSymbol     : rsQuarticRootCubicCandelaSymbol;
    FName       : rsQuarticRootCubicCandelaName;
    FPluralName : rsQuarticRootCubicCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareRootCubicCandela }

resourcestring
  rsSquareRootCubicCandelaSymbol = '√%scd³';
  rsSquareRootCubicCandelaName = 'square root cubic %scandela';
  rsSquareRootCubicCandelaPluralName = 'square root cubic %scandelas';

const
  SquareRootCubicCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 90; FSteradian: 0);
    FSymbol     : rsSquareRootCubicCandelaSymbol;
    FName       : rsSquareRootCubicCandelaName;
    FPluralName : rsSquareRootCubicCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TSquareCandela }

resourcestring
  rsSquareCandelaSymbol = '%scd²';
  rsSquareCandelaName = 'square %scandela';
  rsSquareCandelaPluralName = 'square %scandelas';

const
  SquareCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 120; FSteradian: 0);
    FSymbol     : rsSquareCandelaSymbol;
    FName       : rsSquareCandelaName;
    FPluralName : rsSquareCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

{ TSquareRootQuinticCandela }

resourcestring
  rsSquareRootQuinticCandelaSymbol = '√%scd⁵';
  rsSquareRootQuinticCandelaName = 'square root quintic %scandela';
  rsSquareRootQuinticCandelaPluralName = 'square root quintic %scandelas';

const
  SquareRootQuinticCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 150; FSteradian: 0);
    FSymbol     : rsSquareRootQuinticCandelaSymbol;
    FName       : rsSquareRootQuinticCandelaName;
    FPluralName : rsSquareRootQuinticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TCubicCandela }

resourcestring
  rsCubicCandelaSymbol = '%scd³';
  rsCubicCandelaName = 'cubic %scandela';
  rsCubicCandelaPluralName = 'cubic %scandelas';

const
  CubicCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 180; FSteradian: 0);
    FSymbol     : rsCubicCandelaSymbol;
    FName       : rsCubicCandelaName;
    FPluralName : rsCubicCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TQuarticCandela }

resourcestring
  rsQuarticCandelaSymbol = '%scd⁴';
  rsQuarticCandelaName = 'quartic %scandela';
  rsQuarticCandelaPluralName = 'quartic %scandelas';

const
  QuarticCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 240; FSteradian: 0);
    FSymbol     : rsQuarticCandelaSymbol;
    FName       : rsQuarticCandelaName;
    FPluralName : rsQuarticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (4));

{ TQuinticCandela }

resourcestring
  rsQuinticCandelaSymbol = '%scd⁵';
  rsQuinticCandelaName = 'quintic %scandela';
  rsQuinticCandelaPluralName = 'quintic %scandelas';

const
  QuinticCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 300; FSteradian: 0);
    FSymbol     : rsQuinticCandelaSymbol;
    FName       : rsQuinticCandelaName;
    FPluralName : rsQuinticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (5));

{ TSexticCandela }

resourcestring
  rsSexticCandelaSymbol = '%scd⁶';
  rsSexticCandelaName = 'sextic %scandela';
  rsSexticCandelaPluralName = 'sextic %scandelas';

const
  SexticCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 360; FSteradian: 0);
    FSymbol     : rsSexticCandelaSymbol;
    FName       : rsSexticCandelaName;
    FPluralName : rsSexticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (6));

{ TSexticRootSteradian }

resourcestring
  rsSexticRootSteradianSymbol = '⁶√sr';
  rsSexticRootSteradianName = 'sextic root steradian';
  rsSexticRootSteradianPluralName = 'sextic root steradians';

const
  SexticRootSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 10);
    FSymbol     : rsSexticRootSteradianSymbol;
    FName       : rsSexticRootSteradianName;
    FPluralName : rsSexticRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TQuinticRootSteradian }

resourcestring
  rsQuinticRootSteradianSymbol = '⁵√sr';
  rsQuinticRootSteradianName = 'quintic root steradian';
  rsQuinticRootSteradianPluralName = 'quintic root steradians';

const
  QuinticRootSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 12);
    FSymbol     : rsQuinticRootSteradianSymbol;
    FName       : rsQuinticRootSteradianName;
    FPluralName : rsQuinticRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TQuarticRootSteradian }

resourcestring
  rsQuarticRootSteradianSymbol = '∜sr';
  rsQuarticRootSteradianName = 'quartic root steradian';
  rsQuarticRootSteradianPluralName = 'quartic root steradians';

const
  QuarticRootSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 15);
    FSymbol     : rsQuarticRootSteradianSymbol;
    FName       : rsQuarticRootSteradianName;
    FPluralName : rsQuarticRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TCubicRootSteradian }

resourcestring
  rsCubicRootSteradianSymbol = '∛sr';
  rsCubicRootSteradianName = 'cubic root steradian';
  rsCubicRootSteradianPluralName = 'cubic root steradians';

const
  CubicRootSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 20);
    FSymbol     : rsCubicRootSteradianSymbol;
    FName       : rsCubicRootSteradianName;
    FPluralName : rsCubicRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TSquareRootSteradian }

resourcestring
  rsSquareRootSteradianSymbol = '√sr';
  rsSquareRootSteradianName = 'square root steradian';
  rsSquareRootSteradianPluralName = 'square root steradians';

const
  SquareRootSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 30);
    FSymbol     : rsSquareRootSteradianSymbol;
    FName       : rsSquareRootSteradianName;
    FPluralName : rsSquareRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TQuarticRootCubicSteradian }

resourcestring
  rsQuarticRootCubicSteradianSymbol = '∜sr³';
  rsQuarticRootCubicSteradianName = 'quartic root cubic steradian';
  rsQuarticRootCubicSteradianPluralName = 'quartic root cubic steradians';

const
  QuarticRootCubicSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 45);
    FSymbol     : rsQuarticRootCubicSteradianSymbol;
    FName       : rsQuarticRootCubicSteradianName;
    FPluralName : rsQuarticRootCubicSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TSquareRootCubicSteradian }

resourcestring
  rsSquareRootCubicSteradianSymbol = '√sr³';
  rsSquareRootCubicSteradianName = 'square root cubic steradian';
  rsSquareRootCubicSteradianPluralName = 'square root cubic steradians';

const
  SquareRootCubicSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 90);
    FSymbol     : rsSquareRootCubicSteradianSymbol;
    FName       : rsSquareRootCubicSteradianName;
    FPluralName : rsSquareRootCubicSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TSquareSteradian }

resourcestring
  rsSquareSteradianSymbol = 'sr²';
  rsSquareSteradianName = 'square steradian';
  rsSquareSteradianPluralName = 'square steradians';

const
  SquareSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 120);
    FSymbol     : rsSquareSteradianSymbol;
    FName       : rsSquareSteradianName;
    FPluralName : rsSquareSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TSquareRootQuinticSteradian }

resourcestring
  rsSquareRootQuinticSteradianSymbol = '√sr⁵';
  rsSquareRootQuinticSteradianName = 'square root quintic steradian';
  rsSquareRootQuinticSteradianPluralName = 'square root quintic steradians';

const
  SquareRootQuinticSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 150);
    FSymbol     : rsSquareRootQuinticSteradianSymbol;
    FName       : rsSquareRootQuinticSteradianName;
    FPluralName : rsSquareRootQuinticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TCubicSteradian }

resourcestring
  rsCubicSteradianSymbol = 'sr³';
  rsCubicSteradianName = 'cubic steradian';
  rsCubicSteradianPluralName = 'cubic steradians';

const
  CubicSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 180);
    FSymbol     : rsCubicSteradianSymbol;
    FName       : rsCubicSteradianName;
    FPluralName : rsCubicSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TQuarticSteradian }

resourcestring
  rsQuarticSteradianSymbol = 'sr⁴';
  rsQuarticSteradianName = 'quartic steradian';
  rsQuarticSteradianPluralName = 'quartic steradians';

const
  QuarticSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 240);
    FSymbol     : rsQuarticSteradianSymbol;
    FName       : rsQuarticSteradianName;
    FPluralName : rsQuarticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TQuinticSteradian }

resourcestring
  rsQuinticSteradianSymbol = 'sr⁵';
  rsQuinticSteradianName = 'quintic steradian';
  rsQuinticSteradianPluralName = 'quintic steradians';

const
  QuinticSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 300);
    FSymbol     : rsQuinticSteradianSymbol;
    FName       : rsQuinticSteradianName;
    FPluralName : rsQuinticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TSexticSteradian }

resourcestring
  rsSexticSteradianSymbol = 'sr⁶';
  rsSexticSteradianName = 'sextic steradian';
  rsSexticSteradianPluralName = 'sextic steradians';

const
  SexticSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 360);
    FSymbol     : rsSexticSteradianSymbol;
    FName       : rsSexticSteradianName;
    FPluralName : rsSexticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalCubicSecond }

resourcestring
  rsReciprocalCubicSecondSymbol = '1/%ss³';
  rsReciprocalCubicSecondName = 'reciprocal cubic %ssecond';
  rsReciprocalCubicSecondPluralName = 'reciprocal cubic %ssecond';

const
  ReciprocalCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicSecondSymbol;
    FName       : rsReciprocalCubicSecondName;
    FPluralName : rsReciprocalCubicSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalQuarticSecond }

resourcestring
  rsReciprocalQuarticSecondSymbol = '1/%ss⁴';
  rsReciprocalQuarticSecondName = 'reciprocal quartic %ssecond';
  rsReciprocalQuarticSecondPluralName = 'reciprocal quartic %ssecond';

const
  ReciprocalQuarticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticSecondSymbol;
    FName       : rsReciprocalQuarticSecondName;
    FPluralName : rsReciprocalQuarticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-4));

{ TReciprocalQuinticSecond }

resourcestring
  rsReciprocalQuinticSecondSymbol = '1/%ss⁵';
  rsReciprocalQuinticSecondName = 'reciprocal quintic %ssecond';
  rsReciprocalQuinticSecondPluralName = 'reciprocal quintic %ssecond';

const
  ReciprocalQuinticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -300; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuinticSecondSymbol;
    FName       : rsReciprocalQuinticSecondName;
    FPluralName : rsReciprocalQuinticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticSecond }

resourcestring
  rsReciprocalSexticSecondSymbol = '1/%ss⁶';
  rsReciprocalSexticSecondName = 'reciprocal sextic %ssecond';
  rsReciprocalSexticSecondPluralName = 'reciprocal sextic %ssecond';

const
  ReciprocalSexticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSexticSecondSymbol;
    FName       : rsReciprocalSexticSecondName;
    FPluralName : rsReciprocalSexticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-6));

{ TSquareKilogramSquareMeter }

resourcestring
  rsSquareKilogramSquareMeterSymbol = '%skg²∙%sm²';
  rsSquareKilogramSquareMeterName = 'square %skilogram square %smeter';
  rsSquareKilogramSquareMeterPluralName = 'square %skilograms square %smeters';

const
  SquareKilogramSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramSquareMeterSymbol;
    FName       : rsSquareKilogramSquareMeterName;
    FPluralName : rsSquareKilogramSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 2));

{ TSquareMeterPerQuarticSecond }

resourcestring
  rsSquareMeterPerQuarticSecondSymbol = '%sm²/%ss⁴';
  rsSquareMeterPerQuarticSecondName = 'square %smeter per quartic %ssecond';
  rsSquareMeterPerQuarticSecondPluralName = 'square %smeters per quartic %ssecond';

const
  SquareMeterPerQuarticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerQuarticSecondSymbol;
    FName       : rsSquareMeterPerQuarticSecondName;
    FPluralName : rsSquareMeterPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -4));

{ TSquareKilogramPerQuarticSecond }

resourcestring
  rsSquareKilogramPerQuarticSecondSymbol = '%skg²/%ss⁴';
  rsSquareKilogramPerQuarticSecondName = 'square %skilogram per quartic %ssecond';
  rsSquareKilogramPerQuarticSecondPluralName = 'square %skilograms per quartic %ssecond';

const
  SquareKilogramPerQuarticSecondUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 0; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramPerQuarticSecondSymbol;
    FName       : rsSquareKilogramPerQuarticSecondName;
    FPluralName : rsSquareKilogramPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -4));

{ TReciprocalMeterSquareSecond }

resourcestring
  rsReciprocalMeterSquareSecondSymbol = '1/%sm/%ss²';
  rsReciprocalMeterSquareSecondName = 'reciprocal %smeter square %ssecond';
  rsReciprocalMeterSquareSecondPluralName = 'reciprocal %smeter square %ssecond';

const
  ReciprocalMeterSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalMeterSquareSecondSymbol;
    FName       : rsReciprocalMeterSquareSecondName;
    FPluralName : rsReciprocalMeterSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -2));

{ TMeterAmpere }

resourcestring
  rsMeterAmpereSymbol = '%sm∙%sA';
  rsMeterAmpereName = '%smeter %sampere';
  rsMeterAmperePluralName = '%smeters %samperes';

const
  MeterAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterAmpereSymbol;
    FName       : rsMeterAmpereName;
    FPluralName : rsMeterAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TSquareMeterPerCubicSecondPerAmpere }

resourcestring
  rsSquareMeterPerCubicSecondPerAmpereSymbol = '%sm²/%ss³/%sA';
  rsSquareMeterPerCubicSecondPerAmpereName = 'square %smeter per cubic %ssecond per %sampere';
  rsSquareMeterPerCubicSecondPerAmperePluralName = 'square %smeters per cubic %ssecond per %sampere';

const
  SquareMeterPerCubicSecondPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -180; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerCubicSecondPerAmpereSymbol;
    FName       : rsSquareMeterPerCubicSecondPerAmpereName;
    FPluralName : rsSquareMeterPerCubicSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -3, -1));

{ TKilogramPerCubicSecondPerAmpere }

resourcestring
  rsKilogramPerCubicSecondPerAmpereSymbol = '%skg/%ss³/%sA';
  rsKilogramPerCubicSecondPerAmpereName = '%skilogram per cubic %ssecond per %sampere';
  rsKilogramPerCubicSecondPerAmperePluralName = '%skilograms per cubic %ssecond per %sampere';

const
  KilogramPerCubicSecondPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -180; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerCubicSecondPerAmpereSymbol;
    FName       : rsKilogramPerCubicSecondPerAmpereName;
    FPluralName : rsKilogramPerCubicSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -3, -1));

{ TKilogramSquareMeterPerAmpere }

resourcestring
  rsKilogramSquareMeterPerAmpereSymbol = '%skg∙%sm²/%sA';
  rsKilogramSquareMeterPerAmpereName = '%skilogram square %smeter per %sampere';
  rsKilogramSquareMeterPerAmperePluralName = '%skilograms square %smeters per %sampere';

const
  KilogramSquareMeterPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: 0; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerAmpereSymbol;
    FName       : rsKilogramSquareMeterPerAmpereName;
    FPluralName : rsKilogramSquareMeterPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TQuarticMeterPerSexticSecondPerSquareAmpere }

resourcestring
  rsQuarticMeterPerSexticSecondPerSquareAmpereSymbol = '%sm⁴/%ss⁶/%sA²';
  rsQuarticMeterPerSexticSecondPerSquareAmpereName = 'quartic %smeter per sextic %ssecond per square %sampere';
  rsQuarticMeterPerSexticSecondPerSquareAmperePluralName = 'quartic %smeters per sextic %ssecond per square %sampere';

const
  QuarticMeterPerSexticSecondPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 240; FSecond: -360; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticMeterPerSexticSecondPerSquareAmpereSymbol;
    FName       : rsQuarticMeterPerSexticSecondPerSquareAmpereName;
    FPluralName : rsQuarticMeterPerSexticSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, -6, -2));

{ TSquareKilogramPerSexticSecondPerSquareAmpere }

resourcestring
  rsSquareKilogramPerSexticSecondPerSquareAmpereSymbol = '%skg²/%ss⁶/%sA²';
  rsSquareKilogramPerSexticSecondPerSquareAmpereName = 'square %skilogram per sextic %ssecond per square %sampere';
  rsSquareKilogramPerSexticSecondPerSquareAmperePluralName = 'square %skilograms per sextic %ssecond per square %sampere';

const
  SquareKilogramPerSexticSecondPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 0; FSecond: -360; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramPerSexticSecondPerSquareAmpereSymbol;
    FName       : rsSquareKilogramPerSexticSecondPerSquareAmpereName;
    FPluralName : rsSquareKilogramPerSexticSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -6, -2));

{ TSquareKilogramQuarticMeterPerSquareAmpere }

resourcestring
  rsSquareKilogramQuarticMeterPerSquareAmpereSymbol = '%skg²∙%sm⁴/%sA²';
  rsSquareKilogramQuarticMeterPerSquareAmpereName = 'square %skilogram quartic %smeter per square %sampere';
  rsSquareKilogramQuarticMeterPerSquareAmperePluralName = 'square %skilograms quartic %smeters per square %sampere';

const
  SquareKilogramQuarticMeterPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 240; FSecond: 0; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramQuarticMeterPerSquareAmpereSymbol;
    FName       : rsSquareKilogramQuarticMeterPerSquareAmpereName;
    FPluralName : rsSquareKilogramQuarticMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 4, -2));

{ TSquareKilogramQuarticMeterPerSexticSecond }

resourcestring
  rsSquareKilogramQuarticMeterPerSexticSecondSymbol = '%skg²∙%sm⁴/%ss⁶';
  rsSquareKilogramQuarticMeterPerSexticSecondName = 'square %skilogram quartic %smeter per sextic %ssecond';
  rsSquareKilogramQuarticMeterPerSexticSecondPluralName = 'square %skilograms quartic %smeters per sextic %ssecond';

const
  SquareKilogramQuarticMeterPerSexticSecondUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 240; FSecond: -360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramQuarticMeterPerSexticSecondSymbol;
    FName       : rsSquareKilogramQuarticMeterPerSexticSecondName;
    FPluralName : rsSquareKilogramQuarticMeterPerSexticSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 4, -6));

{ TQuarticSecondSquareAmperePerSquareMeter }

resourcestring
  rsQuarticSecondSquareAmperePerSquareMeterSymbol = '%ss⁴∙%sA²/%sm²';
  rsQuarticSecondSquareAmperePerSquareMeterName = 'quartic %ssecond square %sampere per square %smeter';
  rsQuarticSecondSquareAmperePerSquareMeterPluralName = 'quartic %sseconds square %samperes per square %smeter';

const
  QuarticSecondSquareAmperePerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 240; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondSquareAmperePerSquareMeterSymbol;
    FName       : rsQuarticSecondSquareAmperePerSquareMeterName;
    FPluralName : rsQuarticSecondSquareAmperePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, 2, -2));

{ TQuarticSecondSquareAmperePerKilogram }

resourcestring
  rsQuarticSecondSquareAmperePerKilogramSymbol = '%ss⁴∙%sA²/%skg';
  rsQuarticSecondSquareAmperePerKilogramName = 'quartic %ssecond square %sampere per %skilogram';
  rsQuarticSecondSquareAmperePerKilogramPluralName = 'quartic %sseconds square %samperes per %skilogram';

const
  QuarticSecondSquareAmperePerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 240; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondSquareAmperePerKilogramSymbol;
    FName       : rsQuarticSecondSquareAmperePerKilogramName;
    FPluralName : rsQuarticSecondSquareAmperePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, 2, -1));

{ TSquareAmperePerKilogramPerSquareMeter }

resourcestring
  rsSquareAmperePerKilogramPerSquareMeterSymbol = '%sA²/%skg/%sm²';
  rsSquareAmperePerKilogramPerSquareMeterName = 'square %sampere per %skilogram per square %smeter';
  rsSquareAmperePerKilogramPerSquareMeterPluralName = 'square %samperes per %skilogram per square %smeter';

const
  SquareAmperePerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareAmperePerKilogramPerSquareMeterSymbol;
    FName       : rsSquareAmperePerKilogramPerSquareMeterName;
    FPluralName : rsSquareAmperePerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -2));

{ TQuarticSecondPerKilogramPerSquareMeter }

resourcestring
  rsQuarticSecondPerKilogramPerSquareMeterSymbol = '%ss⁴/%skg/%sm²';
  rsQuarticSecondPerKilogramPerSquareMeterName = 'quartic %ssecond per %skilogram per square %smeter';
  rsQuarticSecondPerKilogramPerSquareMeterPluralName = 'quartic %sseconds per %skilogram per square %smeter';

const
  QuarticSecondPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondPerKilogramPerSquareMeterSymbol;
    FName       : rsQuarticSecondPerKilogramPerSquareMeterName;
    FPluralName : rsQuarticSecondPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, -1, -2));

{ TSquareMeterPerCubicSecondPerSquareAmpere }

resourcestring
  rsSquareMeterPerCubicSecondPerSquareAmpereSymbol = '%sm²/%ss³/%sA²';
  rsSquareMeterPerCubicSecondPerSquareAmpereName = 'square %smeter per cubic %ssecond per square %sampere';
  rsSquareMeterPerCubicSecondPerSquareAmperePluralName = 'square %smeters per cubic %ssecond per square %sampere';

const
  SquareMeterPerCubicSecondPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -180; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerCubicSecondPerSquareAmpereSymbol;
    FName       : rsSquareMeterPerCubicSecondPerSquareAmpereName;
    FPluralName : rsSquareMeterPerCubicSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -3, -2));

{ TKilogramPerCubicSecondPerSquareAmpere }

resourcestring
  rsKilogramPerCubicSecondPerSquareAmpereSymbol = '%skg/%ss³/%sA²';
  rsKilogramPerCubicSecondPerSquareAmpereName = '%skilogram per cubic %ssecond per square %sampere';
  rsKilogramPerCubicSecondPerSquareAmperePluralName = '%skilograms per cubic %ssecond per square %sampere';

const
  KilogramPerCubicSecondPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -180; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerCubicSecondPerSquareAmpereSymbol;
    FName       : rsKilogramPerCubicSecondPerSquareAmpereName;
    FPluralName : rsKilogramPerCubicSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -3, -2));

{ TKilogramSquareMeterPerSquareAmpere }

resourcestring
  rsKilogramSquareMeterPerSquareAmpereSymbol = '%skg∙%sm²/%sA²';
  rsKilogramSquareMeterPerSquareAmpereName = '%skilogram square %smeter per square %sampere';
  rsKilogramSquareMeterPerSquareAmperePluralName = '%skilograms square %smeters per square %sampere';

const
  KilogramSquareMeterPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: 0; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerSquareAmpereSymbol;
    FName       : rsKilogramSquareMeterPerSquareAmpereName;
    FPluralName : rsKilogramSquareMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -2));

{ TCubicSecondSquareAmperePerSquareMeter }

resourcestring
  rsCubicSecondSquareAmperePerSquareMeterSymbol = '%ss³∙%sA²/%sm²';
  rsCubicSecondSquareAmperePerSquareMeterName = 'cubic %ssecond square %sampere per square %smeter';
  rsCubicSecondSquareAmperePerSquareMeterPluralName = 'cubic %sseconds square %samperes per square %smeter';

const
  CubicSecondSquareAmperePerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 180; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondSquareAmperePerSquareMeterSymbol;
    FName       : rsCubicSecondSquareAmperePerSquareMeterName;
    FPluralName : rsCubicSecondSquareAmperePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 2, -2));

{ TCubicSecondSquareAmperePerKilogram }

resourcestring
  rsCubicSecondSquareAmperePerKilogramSymbol = '%ss³∙%sA²/%skg';
  rsCubicSecondSquareAmperePerKilogramName = 'cubic %ssecond square %sampere per %skilogram';
  rsCubicSecondSquareAmperePerKilogramPluralName = 'cubic %sseconds square %samperes per %skilogram';

const
  CubicSecondSquareAmperePerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 180; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondSquareAmperePerKilogramSymbol;
    FName       : rsCubicSecondSquareAmperePerKilogramName;
    FPluralName : rsCubicSecondSquareAmperePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 2, -1));

{ TCubicSecondSquareAmperePerCubicMeter }

resourcestring
  rsCubicSecondSquareAmperePerCubicMeterSymbol = '%ss³∙%sA²/%sm³';
  rsCubicSecondSquareAmperePerCubicMeterName = 'cubic %ssecond square %sampere per cubic %smeter';
  rsCubicSecondSquareAmperePerCubicMeterPluralName = 'cubic %sseconds square %samperes per cubic %smeter';

const
  CubicSecondSquareAmperePerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 180; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondSquareAmperePerCubicMeterSymbol;
    FName       : rsCubicSecondSquareAmperePerCubicMeterName;
    FPluralName : rsCubicSecondSquareAmperePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 2, -3));

{ TSquareAmperePerKilogramPerCubicMeter }

resourcestring
  rsSquareAmperePerKilogramPerCubicMeterSymbol = '%sA²/%skg/%sm³';
  rsSquareAmperePerKilogramPerCubicMeterName = 'square %sampere per %skilogram per cubic %smeter';
  rsSquareAmperePerKilogramPerCubicMeterPluralName = 'square %samperes per %skilogram per cubic %smeter';

const
  SquareAmperePerKilogramPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -180; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareAmperePerKilogramPerCubicMeterSymbol;
    FName       : rsSquareAmperePerKilogramPerCubicMeterName;
    FPluralName : rsSquareAmperePerKilogramPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -3));

{ TCubicSecondPerKilogramPerCubicMeter }

resourcestring
  rsCubicSecondPerKilogramPerCubicMeterSymbol = '%ss³/%skg/%sm³';
  rsCubicSecondPerKilogramPerCubicMeterName = 'cubic %ssecond per %skilogram per cubic %smeter';
  rsCubicSecondPerKilogramPerCubicMeterPluralName = 'cubic %sseconds per %skilogram per cubic %smeter';

const
  CubicSecondPerKilogramPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -180; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondPerKilogramPerCubicMeterSymbol;
    FName       : rsCubicSecondPerKilogramPerCubicMeterName;
    FPluralName : rsCubicSecondPerKilogramPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -1, -3));

{ TReciprocalSquareSecondAmpere }

resourcestring
  rsReciprocalSquareSecondAmpereSymbol = '1/%ss²/%sA';
  rsReciprocalSquareSecondAmpereName = 'reciprocal square %ssecond %sampere';
  rsReciprocalSquareSecondAmperePluralName = 'reciprocal square %ssecond %sampere';

const
  ReciprocalSquareSecondAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -120; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareSecondAmpereSymbol;
    FName       : rsReciprocalSquareSecondAmpereName;
    FPluralName : rsReciprocalSquareSecondAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -1));

{ TKilogramPerAmpere }

resourcestring
  rsKilogramPerAmpereSymbol = '%skg/%sA';
  rsKilogramPerAmpereName = '%skilogram per %sampere';
  rsKilogramPerAmperePluralName = '%skilograms per %sampere';

const
  KilogramPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerAmpereSymbol;
    FName       : rsKilogramPerAmpereName;
    FPluralName : rsKilogramPerAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareMeterPerSquareSecondPerAmpere }

resourcestring
  rsSquareMeterPerSquareSecondPerAmpereSymbol = '%sm²/%ss²/%sA';
  rsSquareMeterPerSquareSecondPerAmpereName = 'square %smeter per square %ssecond per %sampere';
  rsSquareMeterPerSquareSecondPerAmperePluralName = 'square %smeters per square %ssecond per %sampere';

const
  SquareMeterPerSquareSecondPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerSquareSecondPerAmpereSymbol;
    FName       : rsSquareMeterPerSquareSecondPerAmpereName;
    FPluralName : rsSquareMeterPerSquareSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -2, -1));

{ TSquareSecondSquareAmperePerSquareMeter }

resourcestring
  rsSquareSecondSquareAmperePerSquareMeterSymbol = '%ss²∙%sA²/%sm²';
  rsSquareSecondSquareAmperePerSquareMeterName = 'square %ssecond square %sampere per square %smeter';
  rsSquareSecondSquareAmperePerSquareMeterPluralName = 'square %sseconds square %samperes per square %smeter';

const
  SquareSecondSquareAmperePerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondSquareAmperePerSquareMeterSymbol;
    FName       : rsSquareSecondSquareAmperePerSquareMeterName;
    FPluralName : rsSquareSecondSquareAmperePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 2, -2));

{ TSquareSecondSquareAmperePerKilogram }

resourcestring
  rsSquareSecondSquareAmperePerKilogramSymbol = '%ss²∙%sA²/%skg';
  rsSquareSecondSquareAmperePerKilogramName = 'square %ssecond square %sampere per %skilogram';
  rsSquareSecondSquareAmperePerKilogramPluralName = 'square %sseconds square %samperes per %skilogram';

const
  SquareSecondSquareAmperePerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondSquareAmperePerKilogramSymbol;
    FName       : rsSquareSecondSquareAmperePerKilogramName;
    FPluralName : rsSquareSecondSquareAmperePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 2, -1));

{ TSquareSecondPerKilogramPerSquareMeter }

resourcestring
  rsSquareSecondPerKilogramPerSquareMeterSymbol = '%ss²/%skg/%sm²';
  rsSquareSecondPerKilogramPerSquareMeterName = 'square %ssecond per %skilogram per square %smeter';
  rsSquareSecondPerKilogramPerSquareMeterPluralName = 'square %sseconds per %skilogram per square %smeter';

const
  SquareSecondPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondPerKilogramPerSquareMeterSymbol;
    FName       : rsSquareSecondPerKilogramPerSquareMeterName;
    FPluralName : rsSquareSecondPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -2));

{ TSecondSteradian }

resourcestring
  rsSecondSteradianSymbol = '%ss∙sr';
  rsSecondSteradianName = '%ssecond steradian';
  rsSecondSteradianPluralName = '%sseconds steradians';

const
  SecondSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSecondSteradianSymbol;
    FName       : rsSecondSteradianName;
    FPluralName : rsSecondSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TSecondCandela }

resourcestring
  rsSecondCandelaSymbol = '%ss∙%scd';
  rsSecondCandelaName = '%ssecond %scandela';
  rsSecondCandelaPluralName = '%sseconds %scandelas';

const
  SecondCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 0);
    FSymbol     : rsSecondCandelaSymbol;
    FName       : rsSecondCandelaName;
    FPluralName : rsSecondCandelaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TCandelaSteradianPerCubicMeter }

resourcestring
  rsCandelaSteradianPerCubicMeterSymbol = '%scd∙sr/%sm³';
  rsCandelaSteradianPerCubicMeterName = '%scandela steradian per cubic %smeter';
  rsCandelaSteradianPerCubicMeterPluralName = '%scandelas steradians per cubic %smeter';

const
  CandelaSteradianPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 60);
    FSymbol     : rsCandelaSteradianPerCubicMeterSymbol;
    FName       : rsCandelaSteradianPerCubicMeterName;
    FPluralName : rsCandelaSteradianPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TSecondSteradianPerCubicMeter }

resourcestring
  rsSecondSteradianPerCubicMeterSymbol = '%ss∙sr/%sm³';
  rsSecondSteradianPerCubicMeterName = '%ssecond steradian per cubic %smeter';
  rsSecondSteradianPerCubicMeterPluralName = '%sseconds steradians per cubic %smeter';

const
  SecondSteradianPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSecondSteradianPerCubicMeterSymbol;
    FName       : rsSecondSteradianPerCubicMeterName;
    FPluralName : rsSecondSteradianPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TSecondCandelaPerCubicMeter }

resourcestring
  rsSecondCandelaPerCubicMeterSymbol = '%ss∙%scd/%sm³';
  rsSecondCandelaPerCubicMeterName = '%ssecond %scandela per cubic %smeter';
  rsSecondCandelaPerCubicMeterPluralName = '%sseconds %scandelas per cubic %smeter';

const
  SecondCandelaPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 0);
    FSymbol     : rsSecondCandelaPerCubicMeterSymbol;
    FName       : rsSecondCandelaPerCubicMeterName;
    FPluralName : rsSecondCandelaPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -3));

{ TSteradianPerSquareMeter }

resourcestring
  rsSteradianPerSquareMeterSymbol = 'sr/%sm²';
  rsSteradianPerSquareMeterName = 'steradian per square %smeter';
  rsSteradianPerSquareMeterPluralName = 'steradians per square %smeter';

const
  SteradianPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSteradianPerSquareMeterSymbol;
    FName       : rsSteradianPerSquareMeterName;
    FPluralName : rsSteradianPerSquareMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TSecondSteradianPerSquareMeter }

resourcestring
  rsSecondSteradianPerSquareMeterSymbol = '%ss∙sr/%sm²';
  rsSecondSteradianPerSquareMeterName = '%ssecond steradian per square %smeter';
  rsSecondSteradianPerSquareMeterPluralName = '%sseconds steradians per square %smeter';

const
  SecondSteradianPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSecondSteradianPerSquareMeterSymbol;
    FName       : rsSecondSteradianPerSquareMeterName;
    FPluralName : rsSecondSteradianPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TSecondCandelaPerSquareMeter }

resourcestring
  rsSecondCandelaPerSquareMeterSymbol = '%ss∙%scd/%sm²';
  rsSecondCandelaPerSquareMeterName = '%ssecond %scandela per square %smeter';
  rsSecondCandelaPerSquareMeterPluralName = '%sseconds %scandelas per square %smeter';

const
  SecondCandelaPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 0);
    FSymbol     : rsSecondCandelaPerSquareMeterSymbol;
    FName       : rsSecondCandelaPerSquareMeterName;
    FPluralName : rsSecondCandelaPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -2));

{ TReciprocalSquareMeterSquareSecond }

resourcestring
  rsReciprocalSquareMeterSquareSecondSymbol = '1/%sm²/%ss²';
  rsReciprocalSquareMeterSquareSecondName = 'reciprocal square %smeter square %ssecond';
  rsReciprocalSquareMeterSquareSecondPluralName = 'reciprocal square %smeter square %ssecond';

const
  ReciprocalSquareMeterSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareMeterSquareSecondSymbol;
    FName       : rsReciprocalSquareMeterSquareSecondName;
    FPluralName : rsReciprocalSquareMeterSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -2));

{ TReciprocalMeterSecond }

resourcestring
  rsReciprocalMeterSecondSymbol = '1/%sm/%ss';
  rsReciprocalMeterSecondName = 'reciprocal %smeter %ssecond';
  rsReciprocalMeterSecondPluralName = 'reciprocal %smeter %ssecond';

const
  ReciprocalMeterSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalMeterSecondSymbol;
    FName       : rsReciprocalMeterSecondName;
    FPluralName : rsReciprocalMeterSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TReciprocalQuarticMeterSecond }

resourcestring
  rsReciprocalQuarticMeterSecondSymbol = '1/%sm⁴/%ss';
  rsReciprocalQuarticMeterSecondName = 'reciprocal quartic %smeter %ssecond';
  rsReciprocalQuarticMeterSecondPluralName = 'reciprocal quartic %smeter %ssecond';

const
  ReciprocalQuarticMeterSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -240; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticMeterSecondSymbol;
    FName       : rsReciprocalQuarticMeterSecondName;
    FPluralName : rsReciprocalQuarticMeterSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-4, -1));

{ TReciprocalKilogram }

resourcestring
  rsReciprocalKilogramSymbol = '1/%skg';
  rsReciprocalKilogramName = 'reciprocal %skilogram';
  rsReciprocalKilogramPluralName = 'reciprocal %skilogram';

const
  ReciprocalKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalKilogramSymbol;
    FName       : rsReciprocalKilogramName;
    FPluralName : rsReciprocalKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TKilogramCubicMeter }

resourcestring
  rsKilogramCubicMeterSymbol = '%skg∙%sm³';
  rsKilogramCubicMeterName = '%skilogram cubic %smeter';
  rsKilogramCubicMeterPluralName = '%skilograms cubic %smeters';

const
  KilogramCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramCubicMeterSymbol;
    FName       : rsKilogramCubicMeterName;
    FPluralName : rsKilogramCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 3));

{ TQuarticMeterPerSquareSecond }

resourcestring
  rsQuarticMeterPerSquareSecondSymbol = '%sm⁴/%ss²';
  rsQuarticMeterPerSquareSecondName = 'quartic %smeter per square %ssecond';
  rsQuarticMeterPerSquareSecondPluralName = 'quartic %smeters per square %ssecond';

const
  QuarticMeterPerSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 240; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticMeterPerSquareSecondSymbol;
    FName       : rsQuarticMeterPerSquareSecondName;
    FPluralName : rsQuarticMeterPerSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -2));

{ TKilogramQuarticMeter }

resourcestring
  rsKilogramQuarticMeterSymbol = '%skg∙%sm⁴';
  rsKilogramQuarticMeterName = '%skilogram quartic %smeter';
  rsKilogramQuarticMeterPluralName = '%skilograms quartic %smeters';

const
  KilogramQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramQuarticMeterSymbol;
    FName       : rsKilogramQuarticMeterName;
    FPluralName : rsKilogramQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 4));

{ TReciprocalKilogramSquareSecond }

resourcestring
  rsReciprocalKilogramSquareSecondSymbol = '1/%skg/%ss²';
  rsReciprocalKilogramSquareSecondName = 'reciprocal %skilogram square %ssecond';
  rsReciprocalKilogramSquareSecondPluralName = 'reciprocal %skilogram square %ssecond';

const
  ReciprocalKilogramSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalKilogramSquareSecondSymbol;
    FName       : rsReciprocalKilogramSquareSecondName;
    FPluralName : rsReciprocalKilogramSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -2));

{ TMeterPerKilogram }

resourcestring
  rsMeterPerKilogramSymbol = '%sm/%skg';
  rsMeterPerKilogramName = '%smeter per %skilogram';
  rsMeterPerKilogramPluralName = '%smeters per %skilogram';

const
  MeterPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerKilogramSymbol;
    FName       : rsMeterPerKilogramName;
    FPluralName : rsMeterPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TReciprocalSquareKilogram }

resourcestring
  rsReciprocalSquareKilogramSymbol = '1/%skg²';
  rsReciprocalSquareKilogramName = 'reciprocal square %skilogram';
  rsReciprocalSquareKilogramPluralName = 'reciprocal square %skilogram';

const
  ReciprocalSquareKilogramUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareKilogramSymbol;
    FName       : rsReciprocalSquareKilogramName;
    FPluralName : rsReciprocalSquareKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TKilogramPerSquareSecondPerKelvin }

resourcestring
  rsKilogramPerSquareSecondPerKelvinSymbol = '%skg/%ss²/%sK';
  rsKilogramPerSquareSecondPerKelvinName = '%skilogram per square %ssecond per %skelvin';
  rsKilogramPerSquareSecondPerKelvinPluralName = '%skilograms per square %ssecond per %skelvin';

const
  KilogramPerSquareSecondPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerSquareSecondPerKelvinSymbol;
    FName       : rsKilogramPerSquareSecondPerKelvinName;
    FPluralName : rsKilogramPerSquareSecondPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -1));

{ TKilogramSquareMeterPerKelvin }

resourcestring
  rsKilogramSquareMeterPerKelvinSymbol = '%skg∙%sm²/%sK';
  rsKilogramSquareMeterPerKelvinName = '%skilogram square %smeter per %skelvin';
  rsKilogramSquareMeterPerKelvinPluralName = '%skilograms square %smeters per %skelvin';

const
  KilogramSquareMeterPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerKelvinSymbol;
    FName       : rsKilogramSquareMeterPerKelvinName;
    FPluralName : rsKilogramSquareMeterPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TReciprocalSquareSecondKelvin }

resourcestring
  rsReciprocalSquareSecondKelvinSymbol = '1/%ss²/%sK';
  rsReciprocalSquareSecondKelvinName = 'reciprocal square %ssecond %skelvin';
  rsReciprocalSquareSecondKelvinPluralName = 'reciprocal square %ssecond %skelvin';

const
  ReciprocalSquareSecondKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareSecondKelvinSymbol;
    FName       : rsReciprocalSquareSecondKelvinName;
    FPluralName : rsReciprocalSquareSecondKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -1));

{ TSquareMeterPerKelvin }

resourcestring
  rsSquareMeterPerKelvinSymbol = '%sm²/%sK';
  rsSquareMeterPerKelvinName = 'square %smeter per %skelvin';
  rsSquareMeterPerKelvinPluralName = 'square %smeters per %skelvin';

const
  SquareMeterPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerKelvinSymbol;
    FName       : rsSquareMeterPerKelvinName;
    FPluralName : rsSquareMeterPerKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TReciprocalMeterCubicSecond }

resourcestring
  rsReciprocalMeterCubicSecondSymbol = '1/%sm/%ss³';
  rsReciprocalMeterCubicSecondName = 'reciprocal %smeter cubic %ssecond';
  rsReciprocalMeterCubicSecondPluralName = 'reciprocal %smeter cubic %ssecond';

const
  ReciprocalMeterCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalMeterCubicSecondSymbol;
    FName       : rsReciprocalMeterCubicSecondName;
    FPluralName : rsReciprocalMeterCubicSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -3));

{ TSquareMeterPerCubicSecondPerKelvin }

resourcestring
  rsSquareMeterPerCubicSecondPerKelvinSymbol = '%sm²/%ss³/%sK';
  rsSquareMeterPerCubicSecondPerKelvinName = 'square %smeter per cubic %ssecond per %skelvin';
  rsSquareMeterPerCubicSecondPerKelvinPluralName = 'square %smeters per cubic %ssecond per %skelvin';

const
  SquareMeterPerCubicSecondPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerCubicSecondPerKelvinSymbol;
    FName       : rsSquareMeterPerCubicSecondPerKelvinName;
    FPluralName : rsSquareMeterPerCubicSecondPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -3, -1));

{ TMeterPerCubicSecondPerKelvin }

resourcestring
  rsMeterPerCubicSecondPerKelvinSymbol = '%sm/%ss³/%sK';
  rsMeterPerCubicSecondPerKelvinName = '%smeter per cubic %ssecond per %skelvin';
  rsMeterPerCubicSecondPerKelvinPluralName = '%smeters per cubic %ssecond per %skelvin';

const
  MeterPerCubicSecondPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -180; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerCubicSecondPerKelvinSymbol;
    FName       : rsMeterPerCubicSecondPerKelvinName;
    FPluralName : rsMeterPerCubicSecondPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -3, -1));

{ TKilogramMeterPerKelvin }

resourcestring
  rsKilogramMeterPerKelvinSymbol = '%skg∙%sm/%sK';
  rsKilogramMeterPerKelvinName = '%skilogram %smeter per %skelvin';
  rsKilogramMeterPerKelvinPluralName = '%skilograms %smeters per %skelvin';

const
  KilogramMeterPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramMeterPerKelvinSymbol;
    FName       : rsKilogramMeterPerKelvinName;
    FPluralName : rsKilogramMeterPerKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TCubicSecondKelvinPerSquareMeter }

resourcestring
  rsCubicSecondKelvinPerSquareMeterSymbol = '%ss³∙%sK/%sm²';
  rsCubicSecondKelvinPerSquareMeterName = 'cubic %ssecond %skelvin per square %smeter';
  rsCubicSecondKelvinPerSquareMeterPluralName = 'cubic %sseconds %skelvins per square %smeter';

const
  CubicSecondKelvinPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 180; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondKelvinPerSquareMeterSymbol;
    FName       : rsCubicSecondKelvinPerSquareMeterName;
    FPluralName : rsCubicSecondKelvinPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -2));

{ TCubicSecondKelvinPerKilogram }

resourcestring
  rsCubicSecondKelvinPerKilogramSymbol = '%ss³∙%sK/%skg';
  rsCubicSecondKelvinPerKilogramName = 'cubic %ssecond %skelvin per %skilogram';
  rsCubicSecondKelvinPerKilogramPluralName = 'cubic %sseconds %skelvins per %skilogram';

const
  CubicSecondKelvinPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondKelvinPerKilogramSymbol;
    FName       : rsCubicSecondKelvinPerKilogramName;
    FPluralName : rsCubicSecondKelvinPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -1));

{ TKelvinPerKilogramPerSquareMeter }

resourcestring
  rsKelvinPerKilogramPerSquareMeterSymbol = '%sK/%skg/%sm²';
  rsKelvinPerKilogramPerSquareMeterName = '%skelvin per %skilogram per square %smeter';
  rsKelvinPerKilogramPerSquareMeterPluralName = '%skelvins per %skilogram per square %smeter';

const
  KelvinPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKelvinPerKilogramPerSquareMeterSymbol;
    FName       : rsKelvinPerKilogramPerSquareMeterName;
    FPluralName : rsKelvinPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TCubicSecondPerMeter }

resourcestring
  rsCubicSecondPerMeterSymbol = '%ss³/%sm';
  rsCubicSecondPerMeterName = 'cubic %ssecond per %smeter';
  rsCubicSecondPerMeterPluralName = 'cubic %sseconds per %smeter';

const
  CubicSecondPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondPerMeterSymbol;
    FName       : rsCubicSecondPerMeterName;
    FPluralName : rsCubicSecondPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TCubicSecondPerKilogram }

resourcestring
  rsCubicSecondPerKilogramSymbol = '%ss³/%skg';
  rsCubicSecondPerKilogramName = 'cubic %ssecond per %skilogram';
  rsCubicSecondPerKilogramPluralName = 'cubic %sseconds per %skilogram';

const
  CubicSecondPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondPerKilogramSymbol;
    FName       : rsCubicSecondPerKilogramName;
    FPluralName : rsCubicSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TReciprocalKilogramMeter }

resourcestring
  rsReciprocalKilogramMeterSymbol = '1/%skg/%sm';
  rsReciprocalKilogramMeterName = 'reciprocal %skilogram %smeter';
  rsReciprocalKilogramMeterPluralName = 'reciprocal %skilogram %smeter';

const
  ReciprocalKilogramMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalKilogramMeterSymbol;
    FName       : rsReciprocalKilogramMeterName;
    FPluralName : rsReciprocalKilogramMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TCubicSecondKelvinPerMeter }

resourcestring
  rsCubicSecondKelvinPerMeterSymbol = '%ss³∙%sK/%sm';
  rsCubicSecondKelvinPerMeterName = 'cubic %ssecond %skelvin per %smeter';
  rsCubicSecondKelvinPerMeterPluralName = 'cubic %sseconds %skelvins per %smeter';

const
  CubicSecondKelvinPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 180; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondKelvinPerMeterSymbol;
    FName       : rsCubicSecondKelvinPerMeterName;
    FPluralName : rsCubicSecondKelvinPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -1));

{ TKelvinPerKilogramPerMeter }

resourcestring
  rsKelvinPerKilogramPerMeterSymbol = '%sK/%skg/%sm';
  rsKelvinPerKilogramPerMeterName = '%skelvin per %skilogram per %smeter';
  rsKelvinPerKilogramPerMeterPluralName = '%skelvins per %skilogram per %smeter';

const
  KelvinPerKilogramPerMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKelvinPerKilogramPerMeterSymbol;
    FName       : rsKelvinPerKilogramPerMeterName;
    FPluralName : rsKelvinPerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TReciprocalCubicSecondKelvin }

resourcestring
  rsReciprocalCubicSecondKelvinSymbol = '1/%ss³/%sK';
  rsReciprocalCubicSecondKelvinName = 'reciprocal cubic %ssecond %skelvin';
  rsReciprocalCubicSecondKelvinPluralName = 'reciprocal cubic %ssecond %skelvin';

const
  ReciprocalCubicSecondKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -180; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicSecondKelvinSymbol;
    FName       : rsReciprocalCubicSecondKelvinName;
    FPluralName : rsReciprocalCubicSecondKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-3, -1));

{ TKilogramPerKelvin }

resourcestring
  rsKilogramPerKelvinSymbol = '%skg/%sK';
  rsKilogramPerKelvinName = '%skilogram per %skelvin';
  rsKilogramPerKelvinPluralName = '%skilograms per %skelvin';

const
  KilogramPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerKelvinSymbol;
    FName       : rsKilogramPerKelvinName;
    FPluralName : rsKilogramPerKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareMeterPerCubicSecondPerQuarticKelvin }

resourcestring
  rsSquareMeterPerCubicSecondPerQuarticKelvinSymbol = '%sm²/%ss³/%sK⁴';
  rsSquareMeterPerCubicSecondPerQuarticKelvinName = 'square %smeter per cubic %ssecond per quartic %skelvin';
  rsSquareMeterPerCubicSecondPerQuarticKelvinPluralName = 'square %smeters per cubic %ssecond per quartic %skelvin';

const
  SquareMeterPerCubicSecondPerQuarticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: -240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerCubicSecondPerQuarticKelvinSymbol;
    FName       : rsSquareMeterPerCubicSecondPerQuarticKelvinName;
    FPluralName : rsSquareMeterPerCubicSecondPerQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -3, -4));

{ TKilogramSquareMeterPerQuarticKelvin }

resourcestring
  rsKilogramSquareMeterPerQuarticKelvinSymbol = '%skg∙%sm²/%sK⁴';
  rsKilogramSquareMeterPerQuarticKelvinName = '%skilogram square %smeter per quartic %skelvin';
  rsKilogramSquareMeterPerQuarticKelvinPluralName = '%skilograms square %smeters per quartic %skelvin';

const
  KilogramSquareMeterPerQuarticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: -240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerQuarticKelvinSymbol;
    FName       : rsKilogramSquareMeterPerQuarticKelvinName;
    FPluralName : rsKilogramSquareMeterPerQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -4));

{ TReciprocalCubicSecondQuarticKelvin }

resourcestring
  rsReciprocalCubicSecondQuarticKelvinSymbol = '1/%ss³/%sK⁴';
  rsReciprocalCubicSecondQuarticKelvinName = 'reciprocal cubic %ssecond quartic %skelvin';
  rsReciprocalCubicSecondQuarticKelvinPluralName = 'reciprocal cubic %ssecond quartic %skelvin';

const
  ReciprocalCubicSecondQuarticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -180; FAmpere: 0; FKelvin: -240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicSecondQuarticKelvinSymbol;
    FName       : rsReciprocalCubicSecondQuarticKelvinName;
    FPluralName : rsReciprocalCubicSecondQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-3, -4));

{ TKilogramPerQuarticKelvin }

resourcestring
  rsKilogramPerQuarticKelvinSymbol = '%skg/%sK⁴';
  rsKilogramPerQuarticKelvinName = '%skilogram per quartic %skelvin';
  rsKilogramPerQuarticKelvinPluralName = '%skilograms per quartic %skelvin';

const
  KilogramPerQuarticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerQuarticKelvinSymbol;
    FName       : rsKilogramPerQuarticKelvinName;
    FPluralName : rsKilogramPerQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -4));

{ TSquareMeterPerSquareSecondPerMole }

resourcestring
  rsSquareMeterPerSquareSecondPerMoleSymbol = '%sm²/%ss²/%smol';
  rsSquareMeterPerSquareSecondPerMoleName = 'square %smeter per square %ssecond per %smole';
  rsSquareMeterPerSquareSecondPerMolePluralName = 'square %smeters per square %ssecond per %smole';

const
  SquareMeterPerSquareSecondPerMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerSquareSecondPerMoleSymbol;
    FName       : rsSquareMeterPerSquareSecondPerMoleName;
    FPluralName : rsSquareMeterPerSquareSecondPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -2, -1));

{ TKilogramPerSquareSecondPerMole }

resourcestring
  rsKilogramPerSquareSecondPerMoleSymbol = '%skg/%ss²/%smol';
  rsKilogramPerSquareSecondPerMoleName = '%skilogram per square %ssecond per %smole';
  rsKilogramPerSquareSecondPerMolePluralName = '%skilograms per square %ssecond per %smole';

const
  KilogramPerSquareSecondPerMoleUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerSquareSecondPerMoleSymbol;
    FName       : rsKilogramPerSquareSecondPerMoleName;
    FPluralName : rsKilogramPerSquareSecondPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -1));

{ TKilogramSquareMeterPerMole }

resourcestring
  rsKilogramSquareMeterPerMoleSymbol = '%skg∙%sm²/%smol';
  rsKilogramSquareMeterPerMoleName = '%skilogram square %smeter per %smole';
  rsKilogramSquareMeterPerMolePluralName = '%skilograms square %smeters per %smole';

const
  KilogramSquareMeterPerMoleUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerMoleSymbol;
    FName       : rsKilogramSquareMeterPerMoleName;
    FPluralName : rsKilogramSquareMeterPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TSquareMeterPerSquareSecondPerKelvinPerMole }

resourcestring
  rsSquareMeterPerSquareSecondPerKelvinPerMoleSymbol = '%sm²/%ss²/%sK/%smol';
  rsSquareMeterPerSquareSecondPerKelvinPerMoleName = 'square %smeter per square %ssecond per %skelvin per %smole';
  rsSquareMeterPerSquareSecondPerKelvinPerMolePluralName = 'square %smeters per square %ssecond per %skelvin per %smole';

const
  SquareMeterPerSquareSecondPerKelvinPerMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: -60; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerSquareSecondPerKelvinPerMoleSymbol;
    FName       : rsSquareMeterPerSquareSecondPerKelvinPerMoleName;
    FPluralName : rsSquareMeterPerSquareSecondPerKelvinPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (2, -2, -1, -1));

{ TKilogramPerSquareSecondPerKelvinPerMole }

resourcestring
  rsKilogramPerSquareSecondPerKelvinPerMoleSymbol = '%skg/%ss²/%sK/%smol';
  rsKilogramPerSquareSecondPerKelvinPerMoleName = '%skilogram per square %ssecond per %skelvin per %smole';
  rsKilogramPerSquareSecondPerKelvinPerMolePluralName = '%skilograms per square %ssecond per %skelvin per %smole';

const
  KilogramPerSquareSecondPerKelvinPerMoleUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: -60; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerSquareSecondPerKelvinPerMoleSymbol;
    FName       : rsKilogramPerSquareSecondPerKelvinPerMoleName;
    FPluralName : rsKilogramPerSquareSecondPerKelvinPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (1, -2, -1, -1));

{ TKilogramSquareMeterPerKelvinPerMole }

resourcestring
  rsKilogramSquareMeterPerKelvinPerMoleSymbol = '%skg∙%sm²/%sK/%smol';
  rsKilogramSquareMeterPerKelvinPerMoleName = '%skilogram square %smeter per %skelvin per %smole';
  rsKilogramSquareMeterPerKelvinPerMolePluralName = '%skilograms square %smeters per %skelvin per %smole';

const
  KilogramSquareMeterPerKelvinPerMoleUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: -60; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerKelvinPerMoleSymbol;
    FName       : rsKilogramSquareMeterPerKelvinPerMoleName;
    FPluralName : rsKilogramSquareMeterPerKelvinPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (1, 2, -1, -1));

{ TCubicMeterPerCubicSecondPerSquareAmpere }

resourcestring
  rsCubicMeterPerCubicSecondPerSquareAmpereSymbol = '%sm³/%ss³/%sA²';
  rsCubicMeterPerCubicSecondPerSquareAmpereName = 'cubic %smeter per cubic %ssecond per square %sampere';
  rsCubicMeterPerCubicSecondPerSquareAmperePluralName = 'cubic %smeters per cubic %ssecond per square %sampere';

const
  CubicMeterPerCubicSecondPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: -180; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterPerCubicSecondPerSquareAmpereSymbol;
    FName       : rsCubicMeterPerCubicSecondPerSquareAmpereName;
    FPluralName : rsCubicMeterPerCubicSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -3, -2));

{ TKilogramCubicMeterPerSquareAmpere }

resourcestring
  rsKilogramCubicMeterPerSquareAmpereSymbol = '%skg∙%sm³/%sA²';
  rsKilogramCubicMeterPerSquareAmpereName = '%skilogram cubic %smeter per square %sampere';
  rsKilogramCubicMeterPerSquareAmperePluralName = '%skilograms cubic %smeters per square %sampere';

const
  KilogramCubicMeterPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 180; FSecond: 0; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramCubicMeterPerSquareAmpereSymbol;
    FName       : rsKilogramCubicMeterPerSquareAmpereName;
    FPluralName : rsKilogramCubicMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 3, -2));

{ TKilogramCubicMeterPerCubicSecond }

resourcestring
  rsKilogramCubicMeterPerCubicSecondSymbol = '%skg∙%sm³/%ss³';
  rsKilogramCubicMeterPerCubicSecondName = '%skilogram cubic %smeter per cubic %ssecond';
  rsKilogramCubicMeterPerCubicSecondPluralName = '%skilograms cubic %smeters per cubic %ssecond';

const
  KilogramCubicMeterPerCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 180; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramCubicMeterPerCubicSecondSymbol;
    FName       : rsKilogramCubicMeterPerCubicSecondName;
    FPluralName : rsKilogramCubicMeterPerCubicSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 3, -3));

{ TMeterPerCubicSecondPerAmpere }

resourcestring
  rsMeterPerCubicSecondPerAmpereSymbol = '%sm/%ss³/%sA';
  rsMeterPerCubicSecondPerAmpereName = '%smeter per cubic %ssecond per %sampere';
  rsMeterPerCubicSecondPerAmperePluralName = '%smeters per cubic %ssecond per %sampere';

const
  MeterPerCubicSecondPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -180; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerCubicSecondPerAmpereSymbol;
    FName       : rsMeterPerCubicSecondPerAmpereName;
    FPluralName : rsMeterPerCubicSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -3, -1));

{ TKilogramMeterPerAmpere }

resourcestring
  rsKilogramMeterPerAmpereSymbol = '%skg∙%sm/%sA';
  rsKilogramMeterPerAmpereName = '%skilogram %smeter per %sampere';
  rsKilogramMeterPerAmperePluralName = '%skilograms %smeters per %sampere';

const
  KilogramMeterPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: 0; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramMeterPerAmpereSymbol;
    FName       : rsKilogramMeterPerAmpereName;
    FPluralName : rsKilogramMeterPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TSquareAmperePerMeter }

resourcestring
  rsSquareAmperePerMeterSymbol = '%sA²/%sm';
  rsSquareAmperePerMeterName = 'square %sampere per %smeter';
  rsSquareAmperePerMeterPluralName = 'square %samperes per %smeter';

const
  SquareAmperePerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareAmperePerMeterSymbol;
    FName       : rsSquareAmperePerMeterName;
    FPluralName : rsSquareAmperePerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TSquareSecondPerMeter }

resourcestring
  rsSquareSecondPerMeterSymbol = '%ss²/%sm';
  rsSquareSecondPerMeterName = 'square %ssecond per %smeter';
  rsSquareSecondPerMeterPluralName = 'square %sseconds per %smeter';

const
  SquareSecondPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondPerMeterSymbol;
    FName       : rsSquareSecondPerMeterName;
    FPluralName : rsSquareSecondPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TSecondPerSquareMeter }

resourcestring
  rsSecondPerSquareMeterSymbol = '%ss/%sm²';
  rsSecondPerSquareMeterName = '%ssecond per square %smeter';
  rsSecondPerSquareMeterPluralName = '%sseconds per square %smeter';

const
  SecondPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSecondPerSquareMeterSymbol;
    FName       : rsSecondPerSquareMeterName;
    FPluralName : rsSecondPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TReciprocalSquareSecondSquareAmpere }

resourcestring
  rsReciprocalSquareSecondSquareAmpereSymbol = '1/%ss²/%sA²';
  rsReciprocalSquareSecondSquareAmpereName = 'reciprocal square %ssecond square %sampere';
  rsReciprocalSquareSecondSquareAmperePluralName = 'reciprocal square %ssecond square %sampere';

const
  ReciprocalSquareSecondSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -120; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareSecondSquareAmpereSymbol;
    FName       : rsReciprocalSquareSecondSquareAmpereName;
    FPluralName : rsReciprocalSquareSecondSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -2));

{ TSquareMeterPerSquareAmpere }

resourcestring
  rsSquareMeterPerSquareAmpereSymbol = '%sm²/%sA²';
  rsSquareMeterPerSquareAmpereName = 'square %smeter per square %sampere';
  rsSquareMeterPerSquareAmperePluralName = 'square %smeters per square %sampere';

const
  SquareMeterPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerSquareAmpereSymbol;
    FName       : rsSquareMeterPerSquareAmpereName;
    FPluralName : rsSquareMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TMeterPerQuarticSecondPerSquareAmpere }

resourcestring
  rsMeterPerQuarticSecondPerSquareAmpereSymbol = '%sm/%ss⁴/%sA²';
  rsMeterPerQuarticSecondPerSquareAmpereName = '%smeter per quartic %ssecond per square %sampere';
  rsMeterPerQuarticSecondPerSquareAmperePluralName = '%smeters per quartic %ssecond per square %sampere';

const
  MeterPerQuarticSecondPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -240; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerQuarticSecondPerSquareAmpereSymbol;
    FName       : rsMeterPerQuarticSecondPerSquareAmpereName;
    FPluralName : rsMeterPerQuarticSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -4, -2));

{ TKilogramPerQuarticSecondPerSquareAmpere }

resourcestring
  rsKilogramPerQuarticSecondPerSquareAmpereSymbol = '%skg/%ss⁴/%sA²';
  rsKilogramPerQuarticSecondPerSquareAmpereName = '%skilogram per quartic %ssecond per square %sampere';
  rsKilogramPerQuarticSecondPerSquareAmperePluralName = '%skilograms per quartic %ssecond per square %sampere';

const
  KilogramPerQuarticSecondPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -240; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerQuarticSecondPerSquareAmpereSymbol;
    FName       : rsKilogramPerQuarticSecondPerSquareAmpereName;
    FPluralName : rsKilogramPerQuarticSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -4, -2));

{ TKilogramMeterPerSquareAmpere }

resourcestring
  rsKilogramMeterPerSquareAmpereSymbol = '%skg∙%sm/%sA²';
  rsKilogramMeterPerSquareAmpereName = '%skilogram %smeter per square %sampere';
  rsKilogramMeterPerSquareAmperePluralName = '%skilograms %smeters per square %sampere';

const
  KilogramMeterPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: 0; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramMeterPerSquareAmpereSymbol;
    FName       : rsKilogramMeterPerSquareAmpereName;
    FPluralName : rsKilogramMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -2));

{ TKilogramMeterPerQuarticSecond }

resourcestring
  rsKilogramMeterPerQuarticSecondSymbol = '%skg∙%sm/%ss⁴';
  rsKilogramMeterPerQuarticSecondName = '%skilogram %smeter per quartic %ssecond';
  rsKilogramMeterPerQuarticSecondPluralName = '%skilograms %smeters per quartic %ssecond';

const
  KilogramMeterPerQuarticSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramMeterPerQuarticSecondSymbol;
    FName       : rsKilogramMeterPerQuarticSecondName;
    FPluralName : rsKilogramMeterPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -4));

{ TCubicMeterPerQuarticSecondPerSquareAmpere }

resourcestring
  rsCubicMeterPerQuarticSecondPerSquareAmpereSymbol = '%sm³/%ss⁴/%sA²';
  rsCubicMeterPerQuarticSecondPerSquareAmpereName = 'cubic %smeter per quartic %ssecond per square %sampere';
  rsCubicMeterPerQuarticSecondPerSquareAmperePluralName = 'cubic %smeters per quartic %ssecond per square %sampere';

const
  CubicMeterPerQuarticSecondPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: -240; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterPerQuarticSecondPerSquareAmpereSymbol;
    FName       : rsCubicMeterPerQuarticSecondPerSquareAmpereName;
    FPluralName : rsCubicMeterPerQuarticSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -4, -2));

{ TKilogramCubicMeterPerQuarticSecond }

resourcestring
  rsKilogramCubicMeterPerQuarticSecondSymbol = '%skg∙%sm³/%ss⁴';
  rsKilogramCubicMeterPerQuarticSecondName = '%skilogram cubic %smeter per quartic %ssecond';
  rsKilogramCubicMeterPerQuarticSecondPluralName = '%skilograms cubic %smeters per quartic %ssecond';

const
  KilogramCubicMeterPerQuarticSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 180; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramCubicMeterPerQuarticSecondSymbol;
    FName       : rsKilogramCubicMeterPerQuarticSecondName;
    FPluralName : rsKilogramCubicMeterPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 3, -4));

{ TCubicMeterPerCubicSecondPerAmpere }

resourcestring
  rsCubicMeterPerCubicSecondPerAmpereSymbol = '%sm³/%ss³/%sA';
  rsCubicMeterPerCubicSecondPerAmpereName = 'cubic %smeter per cubic %ssecond per %sampere';
  rsCubicMeterPerCubicSecondPerAmperePluralName = 'cubic %smeters per cubic %ssecond per %sampere';

const
  CubicMeterPerCubicSecondPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: -180; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterPerCubicSecondPerAmpereSymbol;
    FName       : rsCubicMeterPerCubicSecondPerAmpereName;
    FPluralName : rsCubicMeterPerCubicSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -3, -1));

{ TKilogramCubicMeterPerAmpere }

resourcestring
  rsKilogramCubicMeterPerAmpereSymbol = '%skg∙%sm³/%sA';
  rsKilogramCubicMeterPerAmpereName = '%skilogram cubic %smeter per %sampere';
  rsKilogramCubicMeterPerAmperePluralName = '%skilograms cubic %smeters per %sampere';

const
  KilogramCubicMeterPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 180; FSecond: 0; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramCubicMeterPerAmpereSymbol;
    FName       : rsKilogramCubicMeterPerAmpereName;
    FPluralName : rsKilogramCubicMeterPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 3, -1));

{ TCubicMeterPerQuarticSecondPerAmpere }

resourcestring
  rsCubicMeterPerQuarticSecondPerAmpereSymbol = '%sm³/%ss⁴/%sA';
  rsCubicMeterPerQuarticSecondPerAmpereName = 'cubic %smeter per quartic %ssecond per %sampere';
  rsCubicMeterPerQuarticSecondPerAmperePluralName = 'cubic %smeters per quartic %ssecond per %sampere';

const
  CubicMeterPerQuarticSecondPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: -240; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterPerQuarticSecondPerAmpereSymbol;
    FName       : rsCubicMeterPerQuarticSecondPerAmpereName;
    FPluralName : rsCubicMeterPerQuarticSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -4, -1));

{ TKilogramPerQuarticSecondPerAmpere }

resourcestring
  rsKilogramPerQuarticSecondPerAmpereSymbol = '%skg/%ss⁴/%sA';
  rsKilogramPerQuarticSecondPerAmpereName = '%skilogram per quartic %ssecond per %sampere';
  rsKilogramPerQuarticSecondPerAmperePluralName = '%skilograms per quartic %ssecond per %sampere';

const
  KilogramPerQuarticSecondPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -240; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerQuarticSecondPerAmpereSymbol;
    FName       : rsKilogramPerQuarticSecondPerAmpereName;
    FPluralName : rsKilogramPerQuarticSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -4, -1));

{ TQuarticSecondSquareAmperePerCubicMeter }

resourcestring
  rsQuarticSecondSquareAmperePerCubicMeterSymbol = '%ss⁴∙%sA²/%sm³';
  rsQuarticSecondSquareAmperePerCubicMeterName = 'quartic %ssecond square %sampere per cubic %smeter';
  rsQuarticSecondSquareAmperePerCubicMeterPluralName = 'quartic %sseconds square %samperes per cubic %smeter';

const
  QuarticSecondSquareAmperePerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 240; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondSquareAmperePerCubicMeterSymbol;
    FName       : rsQuarticSecondSquareAmperePerCubicMeterName;
    FPluralName : rsQuarticSecondSquareAmperePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, 2, -3));

{ TQuarticSecondPerKilogramPerCubicMeter }

resourcestring
  rsQuarticSecondPerKilogramPerCubicMeterSymbol = '%ss⁴/%skg/%sm³';
  rsQuarticSecondPerKilogramPerCubicMeterName = 'quartic %ssecond per %skilogram per cubic %smeter';
  rsQuarticSecondPerKilogramPerCubicMeterPluralName = 'quartic %sseconds per %skilogram per cubic %smeter';

const
  QuarticSecondPerKilogramPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -180; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondPerKilogramPerCubicMeterSymbol;
    FName       : rsQuarticSecondPerKilogramPerCubicMeterName;
    FPluralName : rsQuarticSecondPerKilogramPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, -1, -3));

{ TReciprocalAmpere }

resourcestring
  rsReciprocalAmpereSymbol = '1/%sA';
  rsReciprocalAmpereName = 'reciprocal %sampere';
  rsReciprocalAmperePluralName = 'reciprocal %sampere';

const
  ReciprocalAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalAmpereSymbol;
    FName       : rsReciprocalAmpereName;
    FPluralName : rsReciprocalAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TMeterPerSquareSecondPerAmpere }

resourcestring
  rsMeterPerSquareSecondPerAmpereSymbol = '%sm/%ss²/%sA';
  rsMeterPerSquareSecondPerAmpereName = '%smeter per square %ssecond per %sampere';
  rsMeterPerSquareSecondPerAmperePluralName = '%smeters per square %ssecond per %sampere';

const
  MeterPerSquareSecondPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -120; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerSquareSecondPerAmpereSymbol;
    FName       : rsMeterPerSquareSecondPerAmpereName;
    FPluralName : rsMeterPerSquareSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -1));

{ TKilogramPerSquareAmpere }

resourcestring
  rsKilogramPerSquareAmpereSymbol = '%skg/%sA²';
  rsKilogramPerSquareAmpereName = '%skilogram per square %sampere';
  rsKilogramPerSquareAmperePluralName = '%skilograms per square %sampere';

const
  KilogramPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerSquareAmpereSymbol;
    FName       : rsKilogramPerSquareAmpereName;
    FPluralName : rsKilogramPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TMeterPerSquareSecondPerSquareAmpere }

resourcestring
  rsMeterPerSquareSecondPerSquareAmpereSymbol = '%sm/%ss²/%sA²';
  rsMeterPerSquareSecondPerSquareAmpereName = '%smeter per square %ssecond per square %sampere';
  rsMeterPerSquareSecondPerSquareAmperePluralName = '%smeters per square %ssecond per square %sampere';

const
  MeterPerSquareSecondPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -120; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerSquareSecondPerSquareAmpereSymbol;
    FName       : rsMeterPerSquareSecondPerSquareAmpereName;
    FPluralName : rsMeterPerSquareSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -2, -2));

{ TQuarticMeterPerQuarticSecond }

resourcestring
  rsQuarticMeterPerQuarticSecondSymbol = '%sm⁴/%ss⁴';
  rsQuarticMeterPerQuarticSecondName = 'quartic %smeter per quartic %ssecond';
  rsQuarticMeterPerQuarticSecondPluralName = 'quartic %smeters per quartic %ssecond';

const
  QuarticMeterPerQuarticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 240; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticMeterPerQuarticSecondSymbol;
    FName       : rsQuarticMeterPerQuarticSecondName;
    FPluralName : rsQuarticMeterPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -4));

{ TSquareKilogramQuarticMeter }

resourcestring
  rsSquareKilogramQuarticMeterSymbol = '%skg²∙%sm⁴';
  rsSquareKilogramQuarticMeterName = 'square %skilogram quartic %smeter';
  rsSquareKilogramQuarticMeterPluralName = 'square %skilograms quartic %smeters';

const
  SquareKilogramQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramQuarticMeterSymbol;
    FName       : rsSquareKilogramQuarticMeterName;
    FPluralName : rsSquareKilogramQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 4));

{ TAmperePerKilogram }

resourcestring
  rsAmperePerKilogramSymbol = '%sA/%skg';
  rsAmperePerKilogramName = '%sampere per %skilogram';
  rsAmperePerKilogramPluralName = '%samperes per %skilogram';

const
  AmperePerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsAmperePerKilogramSymbol;
    FName       : rsAmperePerKilogramName;
    FPluralName : rsAmperePerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSecondPerKilogram }

resourcestring
  rsSecondPerKilogramSymbol = '%ss/%skg';
  rsSecondPerKilogramName = '%ssecond per %skilogram';
  rsSecondPerKilogramPluralName = '%sseconds per %skilogram';

const
  SecondPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSecondPerKilogramSymbol;
    FName       : rsSecondPerKilogramName;
    FPluralName : rsSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TCubicSecondCandelaSteradianPerSquareMeter }

resourcestring
  rsCubicSecondCandelaSteradianPerSquareMeterSymbol = '%ss³∙%scd∙sr/%sm²';
  rsCubicSecondCandelaSteradianPerSquareMeterName = 'cubic %ssecond %scandela steradian per square %smeter';
  rsCubicSecondCandelaSteradianPerSquareMeterPluralName = 'cubic %sseconds %scandelas steradians per square %smeter';

const
  CubicSecondCandelaSteradianPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 60);
    FSymbol     : rsCubicSecondCandelaSteradianPerSquareMeterSymbol;
    FName       : rsCubicSecondCandelaSteradianPerSquareMeterName;
    FPluralName : rsCubicSecondCandelaSteradianPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -2));

{ TCubicSecondCandelaSteradianPerKilogram }

resourcestring
  rsCubicSecondCandelaSteradianPerKilogramSymbol = '%ss³∙%scd∙sr/%skg';
  rsCubicSecondCandelaSteradianPerKilogramName = 'cubic %ssecond %scandela steradian per %skilogram';
  rsCubicSecondCandelaSteradianPerKilogramPluralName = 'cubic %sseconds %scandelas steradians per %skilogram';

const
  CubicSecondCandelaSteradianPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 60);
    FSymbol     : rsCubicSecondCandelaSteradianPerKilogramSymbol;
    FName       : rsCubicSecondCandelaSteradianPerKilogramName;
    FPluralName : rsCubicSecondCandelaSteradianPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -1));

{ TCandelaSteradianPerKilogramPerSquareMeter }

resourcestring
  rsCandelaSteradianPerKilogramPerSquareMeterSymbol = '%scd∙sr/%skg/%sm²';
  rsCandelaSteradianPerKilogramPerSquareMeterName = '%scandela steradian per %skilogram per square %smeter';
  rsCandelaSteradianPerKilogramPerSquareMeterPluralName = '%scandelas steradians per %skilogram per square %smeter';

const
  CandelaSteradianPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 60);
    FSymbol     : rsCandelaSteradianPerKilogramPerSquareMeterSymbol;
    FName       : rsCandelaSteradianPerKilogramPerSquareMeterName;
    FPluralName : rsCandelaSteradianPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TCubicSecondSteradianPerKilogramPerSquareMeter }

resourcestring
  rsCubicSecondSteradianPerKilogramPerSquareMeterSymbol = '%ss³∙sr/%skg/%sm²';
  rsCubicSecondSteradianPerKilogramPerSquareMeterName = 'cubic %ssecond steradian per %skilogram per square %smeter';
  rsCubicSecondSteradianPerKilogramPerSquareMeterPluralName = 'cubic %sseconds steradians per %skilogram per square %smeter';

const
  CubicSecondSteradianPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsCubicSecondSteradianPerKilogramPerSquareMeterSymbol;
    FName       : rsCubicSecondSteradianPerKilogramPerSquareMeterName;
    FPluralName : rsCubicSecondSteradianPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -1, -2));

{ TCubicSecondCandelaPerKilogramPerSquareMeter }

resourcestring
  rsCubicSecondCandelaPerKilogramPerSquareMeterSymbol = '%ss³∙%scd/%skg/%sm²';
  rsCubicSecondCandelaPerKilogramPerSquareMeterName = 'cubic %ssecond %scandela per %skilogram per square %smeter';
  rsCubicSecondCandelaPerKilogramPerSquareMeterPluralName = 'cubic %sseconds %scandelas per %skilogram per square %smeter';

const
  CubicSecondCandelaPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 0);
    FSymbol     : rsCubicSecondCandelaPerKilogramPerSquareMeterSymbol;
    FName       : rsCubicSecondCandelaPerKilogramPerSquareMeterName;
    FPluralName : rsCubicSecondCandelaPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (3, 1, -1, -2));

{ TAmperePerCubicMeter }

resourcestring
  rsAmperePerCubicMeterSymbol = '%sA/%sm³';
  rsAmperePerCubicMeterName = '%sampere per cubic %smeter';
  rsAmperePerCubicMeterPluralName = '%samperes per cubic %smeter';

const
  AmperePerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsAmperePerCubicMeterSymbol;
    FName       : rsAmperePerCubicMeterName;
    FPluralName : rsAmperePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TSecondPerCubicMeter }

resourcestring
  rsSecondPerCubicMeterSymbol = '%ss/%sm³';
  rsSecondPerCubicMeterName = '%ssecond per cubic %smeter';
  rsSecondPerCubicMeterPluralName = '%sseconds per cubic %smeter';

const
  SecondPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSecondPerCubicMeterSymbol;
    FName       : rsSecondPerCubicMeterName;
    FPluralName : rsSecondPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TSquareMeterPerCubicSecondPerSteradian }

resourcestring
  rsSquareMeterPerCubicSecondPerSteradianSymbol = '%sm²/%ss³/sr';
  rsSquareMeterPerCubicSecondPerSteradianName = 'square %smeter per cubic %ssecond per steradian';
  rsSquareMeterPerCubicSecondPerSteradianPluralName = 'square %smeters per cubic %ssecond per steradian';

const
  SquareMeterPerCubicSecondPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsSquareMeterPerCubicSecondPerSteradianSymbol;
    FName       : rsSquareMeterPerCubicSecondPerSteradianName;
    FPluralName : rsSquareMeterPerCubicSecondPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -3));

{ TKilogramSquareMeterPerSteradian }

resourcestring
  rsKilogramSquareMeterPerSteradianSymbol = '%skg∙%sm²/sr';
  rsKilogramSquareMeterPerSteradianName = '%skilogram square %smeter per steradian';
  rsKilogramSquareMeterPerSteradianPluralName = '%skilograms square %smeters per steradian';

const
  KilogramSquareMeterPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsKilogramSquareMeterPerSteradianSymbol;
    FName       : rsKilogramSquareMeterPerSteradianName;
    FPluralName : rsKilogramSquareMeterPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 2));

{ TSquareMeterPerSquareSecondPerSteradian }

resourcestring
  rsSquareMeterPerSquareSecondPerSteradianSymbol = '%sm²/%ss²/sr';
  rsSquareMeterPerSquareSecondPerSteradianName = 'square %smeter per square %ssecond per steradian';
  rsSquareMeterPerSquareSecondPerSteradianPluralName = 'square %smeters per square %ssecond per steradian';

const
  SquareMeterPerSquareSecondPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsSquareMeterPerSquareSecondPerSteradianSymbol;
    FName       : rsSquareMeterPerSquareSecondPerSteradianName;
    FPluralName : rsSquareMeterPerSquareSecondPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TMeterPerCubicSecondPerSteradian }

resourcestring
  rsMeterPerCubicSecondPerSteradianSymbol = '%sm/%ss³/sr';
  rsMeterPerCubicSecondPerSteradianName = '%smeter per cubic %ssecond per steradian';
  rsMeterPerCubicSecondPerSteradianPluralName = '%smeters per cubic %ssecond per steradian';

const
  MeterPerCubicSecondPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsMeterPerCubicSecondPerSteradianSymbol;
    FName       : rsMeterPerCubicSecondPerSteradianName;
    FPluralName : rsMeterPerCubicSecondPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TKilogramMeterPerSteradian }

resourcestring
  rsKilogramMeterPerSteradianSymbol = '%skg∙%sm/sr';
  rsKilogramMeterPerSteradianName = '%skilogram %smeter per steradian';
  rsKilogramMeterPerSteradianPluralName = '%skilograms %smeters per steradian';

const
  KilogramMeterPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsKilogramMeterPerSteradianSymbol;
    FName       : rsKilogramMeterPerSteradianName;
    FPluralName : rsKilogramMeterPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 1));

{ TReciprocalCubicSecondSteradian }

resourcestring
  rsReciprocalCubicSecondSteradianSymbol = '1/%ss³/sr';
  rsReciprocalCubicSecondSteradianName = 'reciprocal cubic %ssecond steradian';
  rsReciprocalCubicSecondSteradianPluralName = 'reciprocal cubic %ssecond steradian';

const
  ReciprocalCubicSecondSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsReciprocalCubicSecondSteradianSymbol;
    FName       : rsReciprocalCubicSecondSteradianName;
    FPluralName : rsReciprocalCubicSecondSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TKilogramPerSteradian }

resourcestring
  rsKilogramPerSteradianSymbol = '%skg/sr';
  rsKilogramPerSteradianName = '%skilogram per steradian';
  rsKilogramPerSteradianPluralName = '%skilograms per steradian';

const
  KilogramPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsKilogramPerSteradianSymbol;
    FName       : rsKilogramPerSteradianName;
    FPluralName : rsKilogramPerSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TReciprocalMeterCubicSecondSteradian }

resourcestring
  rsReciprocalMeterCubicSecondSteradianSymbol = '1/%sm/%ss³/sr';
  rsReciprocalMeterCubicSecondSteradianName = 'reciprocal %smeter cubic %ssecond steradian';
  rsReciprocalMeterCubicSecondSteradianPluralName = 'reciprocal %smeter cubic %ssecond steradian';

const
  ReciprocalMeterCubicSecondSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsReciprocalMeterCubicSecondSteradianSymbol;
    FName       : rsReciprocalMeterCubicSecondSteradianName;
    FPluralName : rsReciprocalMeterCubicSecondSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -3));

{ TKilogramPerMeterPerSteradian }

resourcestring
  rsKilogramPerMeterPerSteradianSymbol = '%skg/%sm/sr';
  rsKilogramPerMeterPerSteradianName = '%skilogram per %smeter per steradian';
  rsKilogramPerMeterPerSteradianPluralName = '%skilograms per %smeter per steradian';

const
  KilogramPerMeterPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsKilogramPerMeterPerSteradianSymbol;
    FName       : rsKilogramPerMeterPerSteradianName;
    FPluralName : rsKilogramPerMeterPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TReciprocalSquareSecondSteradian }

resourcestring
  rsReciprocalSquareSecondSteradianSymbol = '1/%ss²/sr';
  rsReciprocalSquareSecondSteradianName = 'reciprocal square %ssecond steradian';
  rsReciprocalSquareSecondSteradianPluralName = 'reciprocal square %ssecond steradian';

const
  ReciprocalSquareSecondSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsReciprocalSquareSecondSteradianSymbol;
    FName       : rsReciprocalSquareSecondSteradianName;
    FPluralName : rsReciprocalSquareSecondSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TReciprocalCubicMeterSecond }

resourcestring
  rsReciprocalCubicMeterSecondSymbol = '1/%sm³/%ss';
  rsReciprocalCubicMeterSecondName = 'reciprocal cubic %smeter %ssecond';
  rsReciprocalCubicMeterSecondPluralName = 'reciprocal cubic %smeter %ssecond';

const
  ReciprocalCubicMeterSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicMeterSecondSymbol;
    FName       : rsReciprocalCubicMeterSecondName;
    FPluralName : rsReciprocalCubicMeterSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-3, -1));

{ TAmperePerMole }

resourcestring
  rsAmperePerMoleSymbol = '%sA/%smol';
  rsAmperePerMoleName = '%sampere per %smole';
  rsAmperePerMolePluralName = '%samperes per %smole';

const
  AmperePerMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsAmperePerMoleSymbol;
    FName       : rsAmperePerMoleName;
    FPluralName : rsAmperePerMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSecondPerMole }

resourcestring
  rsSecondPerMoleSymbol = '%ss/%smol';
  rsSecondPerMoleName = '%ssecond per %smole';
  rsSecondPerMolePluralName = '%sseconds per %smole';

const
  SecondPerMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSecondPerMoleSymbol;
    FName       : rsSecondPerMoleName;
    FPluralName : rsSecondPerMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareSecondPerKilogram }

resourcestring
  rsSquareSecondPerKilogramSymbol = '%ss²/%skg';
  rsSquareSecondPerKilogramName = 'square %ssecond per %skilogram';
  rsSquareSecondPerKilogramPluralName = 'square %sseconds per %skilogram';

const
  SquareSecondPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondPerKilogramSymbol;
    FName       : rsSquareSecondPerKilogramName;
    FPluralName : rsSquareSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TSquareSecondAmpere }

resourcestring
  rsSquareSecondAmpereSymbol = '%ss²∙%sA';
  rsSquareSecondAmpereName = 'square %ssecond %sampere';
  rsSquareSecondAmperePluralName = 'square %sseconds %samperes';

const
  SquareSecondAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondAmpereSymbol;
    FName       : rsSquareSecondAmpereName;
    FPluralName : rsSquareSecondAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 1));

{ TMeterSquareSecond }

resourcestring
  rsMeterSquareSecondSymbol = '%sm∙%ss²';
  rsMeterSquareSecondName = '%smeter square %ssecond';
  rsMeterSquareSecondPluralName = '%smeters square %sseconds';

const
  MeterSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterSquareSecondSymbol;
    FName       : rsMeterSquareSecondName;
    FPluralName : rsMeterSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 2));

{ TSquareSecondAmperePerSquareMeter }

resourcestring
  rsSquareSecondAmperePerSquareMeterSymbol = '%ss²∙%sA/%sm²';
  rsSquareSecondAmperePerSquareMeterName = 'square %ssecond %sampere per square %smeter';
  rsSquareSecondAmperePerSquareMeterPluralName = 'square %sseconds %samperes per square %smeter';

const
  SquareSecondAmperePerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 120; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondAmperePerSquareMeterSymbol;
    FName       : rsSquareSecondAmperePerSquareMeterName;
    FPluralName : rsSquareSecondAmperePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 1, -2));

{ TAmperePerKilogramPerSquareMeter }

resourcestring
  rsAmperePerKilogramPerSquareMeterSymbol = '%sA/%skg/%sm²';
  rsAmperePerKilogramPerSquareMeterName = '%sampere per %skilogram per square %smeter';
  rsAmperePerKilogramPerSquareMeterPluralName = '%samperes per %skilogram per square %smeter';

const
  AmperePerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsAmperePerKilogramPerSquareMeterSymbol;
    FName       : rsAmperePerKilogramPerSquareMeterName;
    FPluralName : rsAmperePerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TCubicSecondPerSquareMeter }

resourcestring
  rsCubicSecondPerSquareMeterSymbol = '%ss³/%sm²';
  rsCubicSecondPerSquareMeterName = 'cubic %ssecond per square %smeter';
  rsCubicSecondPerSquareMeterPluralName = 'cubic %sseconds per square %smeter';

const
  CubicSecondPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondPerSquareMeterSymbol;
    FName       : rsCubicSecondPerSquareMeterName;
    FPluralName : rsCubicSecondPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -2));

{ TReciprocalKilogramSquareMeter }

resourcestring
  rsReciprocalKilogramSquareMeterSymbol = '1/%skg/%sm²';
  rsReciprocalKilogramSquareMeterName = 'reciprocal %skilogram square %smeter';
  rsReciprocalKilogramSquareMeterPluralName = 'reciprocal %skilogram square %smeter';

const
  ReciprocalKilogramSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalKilogramSquareMeterSymbol;
    FName       : rsReciprocalKilogramSquareMeterName;
    FPluralName : rsReciprocalKilogramSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -2));

{ TCubicSecondAmperePerMeter }

resourcestring
  rsCubicSecondAmperePerMeterSymbol = '%ss³∙%sA/%sm';
  rsCubicSecondAmperePerMeterName = 'cubic %ssecond %sampere per %smeter';
  rsCubicSecondAmperePerMeterPluralName = 'cubic %sseconds %samperes per %smeter';

const
  CubicSecondAmperePerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 180; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondAmperePerMeterSymbol;
    FName       : rsCubicSecondAmperePerMeterName;
    FPluralName : rsCubicSecondAmperePerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -1));

{ TCubicSecondAmperePerKilogram }

resourcestring
  rsCubicSecondAmperePerKilogramSymbol = '%ss³∙%sA/%skg';
  rsCubicSecondAmperePerKilogramName = 'cubic %ssecond %sampere per %skilogram';
  rsCubicSecondAmperePerKilogramPluralName = 'cubic %sseconds %samperes per %skilogram';

const
  CubicSecondAmperePerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 180; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondAmperePerKilogramSymbol;
    FName       : rsCubicSecondAmperePerKilogramName;
    FPluralName : rsCubicSecondAmperePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -1));

{ TAmperePerKilogramPerMeter }

resourcestring
  rsAmperePerKilogramPerMeterSymbol = '%sA/%skg/%sm';
  rsAmperePerKilogramPerMeterName = '%sampere per %skilogram per %smeter';
  rsAmperePerKilogramPerMeterPluralName = '%samperes per %skilogram per %smeter';

const
  AmperePerKilogramPerMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsAmperePerKilogramPerMeterSymbol;
    FName       : rsAmperePerKilogramPerMeterName;
    FPluralName : rsAmperePerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TReciprocalCubicSecondAmpere }

resourcestring
  rsReciprocalCubicSecondAmpereSymbol = '1/%ss³/%sA';
  rsReciprocalCubicSecondAmpereName = 'reciprocal cubic %ssecond %sampere';
  rsReciprocalCubicSecondAmperePluralName = 'reciprocal cubic %ssecond %sampere';

const
  ReciprocalCubicSecondAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -180; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicSecondAmpereSymbol;
    FName       : rsReciprocalCubicSecondAmpereName;
    FPluralName : rsReciprocalCubicSecondAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-3, -1));

{ TSquareMeterPerAmpere }

resourcestring
  rsSquareMeterPerAmpereSymbol = '%sm²/%sA';
  rsSquareMeterPerAmpereName = 'square %smeter per %sampere';
  rsSquareMeterPerAmperePluralName = 'square %smeters per %sampere';

const
  SquareMeterPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerAmpereSymbol;
    FName       : rsSquareMeterPerAmpereName;
    FPluralName : rsSquareMeterPerAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TReciprocalSexticSecondSquareAmpere }

resourcestring
  rsReciprocalSexticSecondSquareAmpereSymbol = '1/%ss⁶/%sA²';
  rsReciprocalSexticSecondSquareAmpereName = 'reciprocal sextic %ssecond square %sampere';
  rsReciprocalSexticSecondSquareAmperePluralName = 'reciprocal sextic %ssecond square %sampere';

const
  ReciprocalSexticSecondSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -360; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSexticSecondSquareAmpereSymbol;
    FName       : rsReciprocalSexticSecondSquareAmpereName;
    FPluralName : rsReciprocalSexticSecondSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-6, -2));

{ TQuarticMeterPerSquareAmpere }

resourcestring
  rsQuarticMeterPerSquareAmpereSymbol = '%sm⁴/%sA²';
  rsQuarticMeterPerSquareAmpereName = 'quartic %smeter per square %sampere';
  rsQuarticMeterPerSquareAmperePluralName = 'quartic %smeters per square %sampere';

const
  QuarticMeterPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 240; FSecond: 0; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticMeterPerSquareAmpereSymbol;
    FName       : rsQuarticMeterPerSquareAmpereName;
    FPluralName : rsQuarticMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -2));

{ TQuarticMeterPerSexticSecond }

resourcestring
  rsQuarticMeterPerSexticSecondSymbol = '%sm⁴/%ss⁶';
  rsQuarticMeterPerSexticSecondName = 'quartic %smeter per sextic %ssecond';
  rsQuarticMeterPerSexticSecondPluralName = 'quartic %smeters per sextic %ssecond';

const
  QuarticMeterPerSexticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 240; FSecond: -360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticMeterPerSexticSecondSymbol;
    FName       : rsQuarticMeterPerSexticSecondName;
    FPluralName : rsQuarticMeterPerSexticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -6));

{ TSquareKilogramPerSquareAmpere }

resourcestring
  rsSquareKilogramPerSquareAmpereSymbol = '%skg²/%sA²';
  rsSquareKilogramPerSquareAmpereName = 'square %skilogram per square %sampere';
  rsSquareKilogramPerSquareAmperePluralName = 'square %skilograms per square %sampere';

const
  SquareKilogramPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 0; FSecond: 0; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramPerSquareAmpereSymbol;
    FName       : rsSquareKilogramPerSquareAmpereName;
    FPluralName : rsSquareKilogramPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TSquareKilogramPerSexticSecond }

resourcestring
  rsSquareKilogramPerSexticSecondSymbol = '%skg²/%ss⁶';
  rsSquareKilogramPerSexticSecondName = 'square %skilogram per sextic %ssecond';
  rsSquareKilogramPerSexticSecondPluralName = 'square %skilograms per sextic %ssecond';

const
  SquareKilogramPerSexticSecondUnit : TUnit = (
    FDim        : (FKilogram: 120; FMeter: 0; FSecond: -360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareKilogramPerSexticSecondSymbol;
    FName       : rsSquareKilogramPerSexticSecondName;
    FPluralName : rsSquareKilogramPerSexticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -6));

{ TQuarticSecondSquareAmpere }

resourcestring
  rsQuarticSecondSquareAmpereSymbol = '%ss⁴∙%sA²';
  rsQuarticSecondSquareAmpereName = 'quartic %ssecond square %sampere';
  rsQuarticSecondSquareAmperePluralName = 'quartic %sseconds square %samperes';

const
  QuarticSecondSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 240; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondSquareAmpereSymbol;
    FName       : rsQuarticSecondSquareAmpereName;
    FPluralName : rsQuarticSecondSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, 2));

{ TSquareAmperePerSquareMeter }

resourcestring
  rsSquareAmperePerSquareMeterSymbol = '%sA²/%sm²';
  rsSquareAmperePerSquareMeterName = 'square %sampere per square %smeter';
  rsSquareAmperePerSquareMeterPluralName = 'square %samperes per square %smeter';

const
  SquareAmperePerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareAmperePerSquareMeterSymbol;
    FName       : rsSquareAmperePerSquareMeterName;
    FPluralName : rsSquareAmperePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TQuarticSecondPerSquareMeter }

resourcestring
  rsQuarticSecondPerSquareMeterSymbol = '%ss⁴/%sm²';
  rsQuarticSecondPerSquareMeterName = 'quartic %ssecond per square %smeter';
  rsQuarticSecondPerSquareMeterPluralName = 'quartic %sseconds per square %smeter';

const
  QuarticSecondPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondPerSquareMeterSymbol;
    FName       : rsQuarticSecondPerSquareMeterName;
    FPluralName : rsQuarticSecondPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -2));

{ TSquareAmperePerKilogram }

resourcestring
  rsSquareAmperePerKilogramSymbol = '%sA²/%skg';
  rsSquareAmperePerKilogramName = 'square %sampere per %skilogram';
  rsSquareAmperePerKilogramPluralName = 'square %samperes per %skilogram';

const
  SquareAmperePerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareAmperePerKilogramSymbol;
    FName       : rsSquareAmperePerKilogramName;
    FPluralName : rsSquareAmperePerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TQuarticSecondPerKilogram }

resourcestring
  rsQuarticSecondPerKilogramSymbol = '%ss⁴/%skg';
  rsQuarticSecondPerKilogramName = 'quartic %ssecond per %skilogram';
  rsQuarticSecondPerKilogramPluralName = 'quartic %sseconds per %skilogram';

const
  QuarticSecondPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondPerKilogramSymbol;
    FName       : rsQuarticSecondPerKilogramName;
    FPluralName : rsQuarticSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -1));

{ TReciprocalCubicSecondSquareAmpere }

resourcestring
  rsReciprocalCubicSecondSquareAmpereSymbol = '1/%ss³/%sA²';
  rsReciprocalCubicSecondSquareAmpereName = 'reciprocal cubic %ssecond square %sampere';
  rsReciprocalCubicSecondSquareAmperePluralName = 'reciprocal cubic %ssecond square %sampere';

const
  ReciprocalCubicSecondSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -180; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicSecondSquareAmpereSymbol;
    FName       : rsReciprocalCubicSecondSquareAmpereName;
    FPluralName : rsReciprocalCubicSecondSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-3, -2));

{ TCubicSecondSquareAmpere }

resourcestring
  rsCubicSecondSquareAmpereSymbol = '%ss³∙%sA²';
  rsCubicSecondSquareAmpereName = 'cubic %ssecond square %sampere';
  rsCubicSecondSquareAmperePluralName = 'cubic %sseconds square %samperes';

const
  CubicSecondSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 180; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondSquareAmpereSymbol;
    FName       : rsCubicSecondSquareAmpereName;
    FPluralName : rsCubicSecondSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, 2));

{ TSquareAmperePerCubicMeter }

resourcestring
  rsSquareAmperePerCubicMeterSymbol = '%sA²/%sm³';
  rsSquareAmperePerCubicMeterName = 'square %sampere per cubic %smeter';
  rsSquareAmperePerCubicMeterPluralName = 'square %samperes per cubic %smeter';

const
  SquareAmperePerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareAmperePerCubicMeterSymbol;
    FName       : rsSquareAmperePerCubicMeterName;
    FPluralName : rsSquareAmperePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -3));

{ TCubicSecondPerCubicMeter }

resourcestring
  rsCubicSecondPerCubicMeterSymbol = '%ss³/%sm³';
  rsCubicSecondPerCubicMeterName = 'cubic %ssecond per cubic %smeter';
  rsCubicSecondPerCubicMeterPluralName = 'cubic %sseconds per cubic %smeter';

const
  CubicSecondPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondPerCubicMeterSymbol;
    FName       : rsCubicSecondPerCubicMeterName;
    FPluralName : rsCubicSecondPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -3));

{ TReciprocalKilogramCubicMeter }

resourcestring
  rsReciprocalKilogramCubicMeterSymbol = '1/%skg/%sm³';
  rsReciprocalKilogramCubicMeterName = 'reciprocal %skilogram cubic %smeter';
  rsReciprocalKilogramCubicMeterPluralName = 'reciprocal %skilogram cubic %smeter';

const
  ReciprocalKilogramCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalKilogramCubicMeterSymbol;
    FName       : rsReciprocalKilogramCubicMeterName;
    FPluralName : rsReciprocalKilogramCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -3));

{ TSteradianPerCubicMeter }

resourcestring
  rsSteradianPerCubicMeterSymbol = 'sr/%sm³';
  rsSteradianPerCubicMeterName = 'steradian per cubic %smeter';
  rsSteradianPerCubicMeterPluralName = 'steradians per cubic %smeter';

const
  SteradianPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSteradianPerCubicMeterSymbol;
    FName       : rsSteradianPerCubicMeterName;
    FPluralName : rsSteradianPerCubicMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TCandelaPerCubicMeter }

resourcestring
  rsCandelaPerCubicMeterSymbol = '%scd/%sm³';
  rsCandelaPerCubicMeterName = '%scandela per cubic %smeter';
  rsCandelaPerCubicMeterPluralName = '%scandelas per cubic %smeter';

const
  CandelaPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 0);
    FSymbol     : rsCandelaPerCubicMeterSymbol;
    FName       : rsCandelaPerCubicMeterName;
    FPluralName : rsCandelaPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -3));

{ TMeterPerKelvin }

resourcestring
  rsMeterPerKelvinSymbol = '%sm/%sK';
  rsMeterPerKelvinName = '%smeter per %skelvin';
  rsMeterPerKelvinPluralName = '%smeters per %skelvin';

const
  MeterPerKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerKelvinSymbol;
    FName       : rsMeterPerKelvinName;
    FPluralName : rsMeterPerKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TCubicSecondKelvin }

resourcestring
  rsCubicSecondKelvinSymbol = '%ss³∙%sK';
  rsCubicSecondKelvinName = 'cubic %ssecond %skelvin';
  rsCubicSecondKelvinPluralName = 'cubic %sseconds %skelvins';

const
  CubicSecondKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondKelvinSymbol;
    FName       : rsCubicSecondKelvinName;
    FPluralName : rsCubicSecondKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, 1));

{ TKelvinPerSquareMeter }

resourcestring
  rsKelvinPerSquareMeterSymbol = '%sK/%sm²';
  rsKelvinPerSquareMeterName = '%skelvin per square %smeter';
  rsKelvinPerSquareMeterPluralName = '%skelvins per square %smeter';

const
  KelvinPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKelvinPerSquareMeterSymbol;
    FName       : rsKelvinPerSquareMeterName;
    FPluralName : rsKelvinPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TKelvinPerKilogram }

resourcestring
  rsKelvinPerKilogramSymbol = '%sK/%skg';
  rsKelvinPerKilogramName = '%skelvin per %skilogram';
  rsKelvinPerKilogramPluralName = '%skelvins per %skilogram';

const
  KelvinPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKelvinPerKilogramSymbol;
    FName       : rsKelvinPerKilogramName;
    FPluralName : rsKelvinPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareMeterPerQuarticKelvin }

resourcestring
  rsSquareMeterPerQuarticKelvinSymbol = '%sm²/%sK⁴';
  rsSquareMeterPerQuarticKelvinName = 'square %smeter per quartic %skelvin';
  rsSquareMeterPerQuarticKelvinPluralName = 'square %smeters per quartic %skelvin';

const
  SquareMeterPerQuarticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: -240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerQuarticKelvinSymbol;
    FName       : rsSquareMeterPerQuarticKelvinName;
    FPluralName : rsSquareMeterPerQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -4));

{ TReciprocalQuarticKelvin }

resourcestring
  rsReciprocalQuarticKelvinSymbol = '1/%sK⁴';
  rsReciprocalQuarticKelvinName = 'reciprocal quartic %skelvin';
  rsReciprocalQuarticKelvinPluralName = 'reciprocal quartic %skelvin';

const
  ReciprocalQuarticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticKelvinSymbol;
    FName       : rsReciprocalQuarticKelvinName;
    FPluralName : rsReciprocalQuarticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-4));

{ TReciprocalSquareSecondMole }

resourcestring
  rsReciprocalSquareSecondMoleSymbol = '1/%ss²/%smol';
  rsReciprocalSquareSecondMoleName = 'reciprocal square %ssecond %smole';
  rsReciprocalSquareSecondMolePluralName = 'reciprocal square %ssecond %smole';

const
  ReciprocalSquareSecondMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: 0; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareSecondMoleSymbol;
    FName       : rsReciprocalSquareSecondMoleName;
    FPluralName : rsReciprocalSquareSecondMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -1));

{ TSquareMeterPerMole }

resourcestring
  rsSquareMeterPerMoleSymbol = '%sm²/%smol';
  rsSquareMeterPerMoleName = 'square %smeter per %smole';
  rsSquareMeterPerMolePluralName = 'square %smeters per %smole';

const
  SquareMeterPerMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerMoleSymbol;
    FName       : rsSquareMeterPerMoleName;
    FPluralName : rsSquareMeterPerMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TKilogramPerMole }

resourcestring
  rsKilogramPerMoleSymbol = '%skg/%smol';
  rsKilogramPerMoleName = '%skilogram per %smole';
  rsKilogramPerMolePluralName = '%skilograms per %smole';

const
  KilogramPerMoleUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerMoleSymbol;
    FName       : rsKilogramPerMoleName;
    FPluralName : rsKilogramPerMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TReciprocalSquareSecondKelvinMole }

resourcestring
  rsReciprocalSquareSecondKelvinMoleSymbol = '1/%ss²/%sK/%smol';
  rsReciprocalSquareSecondKelvinMoleName = 'reciprocal square %ssecond %skelvin %smole';
  rsReciprocalSquareSecondKelvinMolePluralName = 'reciprocal square %ssecond %skelvin %smole';

const
  ReciprocalSquareSecondKelvinMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -120; FAmpere: 0; FKelvin: -60; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareSecondKelvinMoleSymbol;
    FName       : rsReciprocalSquareSecondKelvinMoleName;
    FPluralName : rsReciprocalSquareSecondKelvinMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (-2, -1, -1));

{ TSquareMeterPerKelvinPerMole }

resourcestring
  rsSquareMeterPerKelvinPerMoleSymbol = '%sm²/%sK/%smol';
  rsSquareMeterPerKelvinPerMoleName = 'square %smeter per %skelvin per %smole';
  rsSquareMeterPerKelvinPerMolePluralName = 'square %smeters per %skelvin per %smole';

const
  SquareMeterPerKelvinPerMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: -60; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerKelvinPerMoleSymbol;
    FName       : rsSquareMeterPerKelvinPerMoleName;
    FPluralName : rsSquareMeterPerKelvinPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -1));

{ TKilogramPerKelvinPerMole }

resourcestring
  rsKilogramPerKelvinPerMoleSymbol = '%skg/%sK/%smol';
  rsKilogramPerKelvinPerMoleName = '%skilogram per %skelvin per %smole';
  rsKilogramPerKelvinPerMolePluralName = '%skilograms per %skelvin per %smole';

const
  KilogramPerKelvinPerMoleUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -60; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerKelvinPerMoleSymbol;
    FName       : rsKilogramPerKelvinPerMoleName;
    FPluralName : rsKilogramPerKelvinPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TCubicMeterPerSquareAmpere }

resourcestring
  rsCubicMeterPerSquareAmpereSymbol = '%sm³/%sA²';
  rsCubicMeterPerSquareAmpereName = 'cubic %smeter per square %sampere';
  rsCubicMeterPerSquareAmperePluralName = 'cubic %smeters per square %sampere';

const
  CubicMeterPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterPerSquareAmpereSymbol;
    FName       : rsCubicMeterPerSquareAmpereName;
    FPluralName : rsCubicMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -2));

{ TCubicMeterPerCubicSecond }

resourcestring
  rsCubicMeterPerCubicSecondSymbol = '%sm³/%ss³';
  rsCubicMeterPerCubicSecondName = 'cubic %smeter per cubic %ssecond';
  rsCubicMeterPerCubicSecondPluralName = 'cubic %smeters per cubic %ssecond';

const
  CubicMeterPerCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterPerCubicSecondSymbol;
    FName       : rsCubicMeterPerCubicSecondName;
    FPluralName : rsCubicMeterPerCubicSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -3));

{ TReciprocalSquareAmpere }

resourcestring
  rsReciprocalSquareAmpereSymbol = '1/%sA²';
  rsReciprocalSquareAmpereName = 'reciprocal square %sampere';
  rsReciprocalSquareAmperePluralName = 'reciprocal square %sampere';

const
  ReciprocalSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareAmpereSymbol;
    FName       : rsReciprocalSquareAmpereName;
    FPluralName : rsReciprocalSquareAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TReciprocalQuarticSecondSquareAmpere }

resourcestring
  rsReciprocalQuarticSecondSquareAmpereSymbol = '1/%ss⁴/%sA²';
  rsReciprocalQuarticSecondSquareAmpereName = 'reciprocal quartic %ssecond square %sampere';
  rsReciprocalQuarticSecondSquareAmperePluralName = 'reciprocal quartic %ssecond square %sampere';

const
  ReciprocalQuarticSecondSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -240; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticSecondSquareAmpereSymbol;
    FName       : rsReciprocalQuarticSecondSquareAmpereName;
    FPluralName : rsReciprocalQuarticSecondSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-4, -2));

{ TMeterPerSquareAmpere }

resourcestring
  rsMeterPerSquareAmpereSymbol = '%sm/%sA²';
  rsMeterPerSquareAmpereName = '%smeter per square %sampere';
  rsMeterPerSquareAmperePluralName = '%smeters per square %sampere';

const
  MeterPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerSquareAmpereSymbol;
    FName       : rsMeterPerSquareAmpereName;
    FPluralName : rsMeterPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TKilogramPerQuarticSecond }

resourcestring
  rsKilogramPerQuarticSecondSymbol = '%skg/%ss⁴';
  rsKilogramPerQuarticSecondName = '%skilogram per quartic %ssecond';
  rsKilogramPerQuarticSecondPluralName = '%skilograms per quartic %ssecond';

const
  KilogramPerQuarticSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerQuarticSecondSymbol;
    FName       : rsKilogramPerQuarticSecondName;
    FPluralName : rsKilogramPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -4));

{ TCubicMeterPerQuarticSecond }

resourcestring
  rsCubicMeterPerQuarticSecondSymbol = '%sm³/%ss⁴';
  rsCubicMeterPerQuarticSecondName = 'cubic %smeter per quartic %ssecond';
  rsCubicMeterPerQuarticSecondPluralName = 'cubic %smeters per quartic %ssecond';

const
  CubicMeterPerQuarticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterPerQuarticSecondSymbol;
    FName       : rsCubicMeterPerQuarticSecondName;
    FPluralName : rsCubicMeterPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -4));

{ TCubicMeterPerAmpere }

resourcestring
  rsCubicMeterPerAmpereSymbol = '%sm³/%sA';
  rsCubicMeterPerAmpereName = 'cubic %smeter per %sampere';
  rsCubicMeterPerAmperePluralName = 'cubic %smeters per %sampere';

const
  CubicMeterPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterPerAmpereSymbol;
    FName       : rsCubicMeterPerAmpereName;
    FPluralName : rsCubicMeterPerAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TReciprocalQuarticSecondAmpere }

resourcestring
  rsReciprocalQuarticSecondAmpereSymbol = '1/%ss⁴/%sA';
  rsReciprocalQuarticSecondAmpereName = 'reciprocal quartic %ssecond %sampere';
  rsReciprocalQuarticSecondAmperePluralName = 'reciprocal quartic %ssecond %sampere';

const
  ReciprocalQuarticSecondAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -240; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticSecondAmpereSymbol;
    FName       : rsReciprocalQuarticSecondAmpereName;
    FPluralName : rsReciprocalQuarticSecondAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-4, -1));

{ TQuarticSecondPerCubicMeter }

resourcestring
  rsQuarticSecondPerCubicMeterSymbol = '%ss⁴/%sm³';
  rsQuarticSecondPerCubicMeterName = 'quartic %ssecond per cubic %smeter';
  rsQuarticSecondPerCubicMeterPluralName = 'quartic %sseconds per cubic %smeter';

const
  QuarticSecondPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondPerCubicMeterSymbol;
    FName       : rsQuarticSecondPerCubicMeterName;
    FPluralName : rsQuarticSecondPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -3));

{ TCubicSecondCandelaSteradian }

resourcestring
  rsCubicSecondCandelaSteradianSymbol = '%ss³∙%scd∙sr';
  rsCubicSecondCandelaSteradianName = 'cubic %ssecond %scandela steradian';
  rsCubicSecondCandelaSteradianPluralName = 'cubic %sseconds %scandelas steradians';

const
  CubicSecondCandelaSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 60);
    FSymbol     : rsCubicSecondCandelaSteradianSymbol;
    FName       : rsCubicSecondCandelaSteradianName;
    FPluralName : rsCubicSecondCandelaSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, 1));

{ TCubicSecondSteradianPerSquareMeter }

resourcestring
  rsCubicSecondSteradianPerSquareMeterSymbol = '%ss³∙sr/%sm²';
  rsCubicSecondSteradianPerSquareMeterName = 'cubic %ssecond steradian per square %smeter';
  rsCubicSecondSteradianPerSquareMeterPluralName = 'cubic %sseconds steradians per square %smeter';

const
  CubicSecondSteradianPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsCubicSecondSteradianPerSquareMeterSymbol;
    FName       : rsCubicSecondSteradianPerSquareMeterName;
    FPluralName : rsCubicSecondSteradianPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -2));

{ TCubicSecondCandelaPerSquareMeter }

resourcestring
  rsCubicSecondCandelaPerSquareMeterSymbol = '%ss³∙%scd/%sm²';
  rsCubicSecondCandelaPerSquareMeterName = 'cubic %ssecond %scandela per square %smeter';
  rsCubicSecondCandelaPerSquareMeterPluralName = 'cubic %sseconds %scandelas per square %smeter';

const
  CubicSecondCandelaPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 0);
    FSymbol     : rsCubicSecondCandelaPerSquareMeterSymbol;
    FName       : rsCubicSecondCandelaPerSquareMeterName;
    FPluralName : rsCubicSecondCandelaPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -2));

{ TCandelaSteradianPerKilogram }

resourcestring
  rsCandelaSteradianPerKilogramSymbol = '%scd∙sr/%skg';
  rsCandelaSteradianPerKilogramName = '%scandela steradian per %skilogram';
  rsCandelaSteradianPerKilogramPluralName = '%scandelas steradians per %skilogram';

const
  CandelaSteradianPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 60);
    FSymbol     : rsCandelaSteradianPerKilogramSymbol;
    FName       : rsCandelaSteradianPerKilogramName;
    FPluralName : rsCandelaSteradianPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TCubicSecondSteradianPerKilogram }

resourcestring
  rsCubicSecondSteradianPerKilogramSymbol = '%ss³∙sr/%skg';
  rsCubicSecondSteradianPerKilogramName = 'cubic %ssecond steradian per %skilogram';
  rsCubicSecondSteradianPerKilogramPluralName = 'cubic %sseconds steradians per %skilogram';

const
  CubicSecondSteradianPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsCubicSecondSteradianPerKilogramSymbol;
    FName       : rsCubicSecondSteradianPerKilogramName;
    FPluralName : rsCubicSecondSteradianPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TCubicSecondCandelaPerKilogram }

resourcestring
  rsCubicSecondCandelaPerKilogramSymbol = '%ss³∙%scd/%skg';
  rsCubicSecondCandelaPerKilogramName = 'cubic %ssecond %scandela per %skilogram';
  rsCubicSecondCandelaPerKilogramPluralName = 'cubic %sseconds %scandelas per %skilogram';

const
  CubicSecondCandelaPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 0);
    FSymbol     : rsCubicSecondCandelaPerKilogramSymbol;
    FName       : rsCubicSecondCandelaPerKilogramName;
    FPluralName : rsCubicSecondCandelaPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -1));

{ TSteradianPerKilogramPerSquareMeter }

resourcestring
  rsSteradianPerKilogramPerSquareMeterSymbol = 'sr/%skg/%sm²';
  rsSteradianPerKilogramPerSquareMeterName = 'steradian per %skilogram per square %smeter';
  rsSteradianPerKilogramPerSquareMeterPluralName = 'steradians per %skilogram per square %smeter';

const
  SteradianPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSteradianPerKilogramPerSquareMeterSymbol;
    FName       : rsSteradianPerKilogramPerSquareMeterName;
    FPluralName : rsSteradianPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -2));

{ TCandelaPerKilogramPerSquareMeter }

resourcestring
  rsCandelaPerKilogramPerSquareMeterSymbol = '%scd/%skg/%sm²';
  rsCandelaPerKilogramPerSquareMeterName = '%scandela per %skilogram per square %smeter';
  rsCandelaPerKilogramPerSquareMeterPluralName = '%scandelas per %skilogram per square %smeter';

const
  CandelaPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 0);
    FSymbol     : rsCandelaPerKilogramPerSquareMeterSymbol;
    FName       : rsCandelaPerKilogramPerSquareMeterName;
    FPluralName : rsCandelaPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TSquareMeterPerSteradian }

resourcestring
  rsSquareMeterPerSteradianSymbol = '%sm²/sr';
  rsSquareMeterPerSteradianName = 'square %smeter per steradian';
  rsSquareMeterPerSteradianPluralName = 'square %smeters per steradian';

const
  SquareMeterPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsSquareMeterPerSteradianSymbol;
    FName       : rsSquareMeterPerSteradianName;
    FPluralName : rsSquareMeterPerSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

{ TMeterPerSteradian }

resourcestring
  rsMeterPerSteradianSymbol = '%sm/sr';
  rsMeterPerSteradianName = '%smeter per steradian';
  rsMeterPerSteradianPluralName = '%smeters per steradian';

const
  MeterPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsMeterPerSteradianSymbol;
    FName       : rsMeterPerSteradianName;
    FPluralName : rsMeterPerSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TReciprocalSteradian }

resourcestring
  rsReciprocalSteradianSymbol = '1/sr';
  rsReciprocalSteradianName = 'reciprocal steradian';
  rsReciprocalSteradianPluralName = 'reciprocal steradian';

const
  ReciprocalSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsReciprocalSteradianSymbol;
    FName       : rsReciprocalSteradianName;
    FPluralName : rsReciprocalSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalMeterSteradian }

resourcestring
  rsReciprocalMeterSteradianSymbol = '1/%sm/sr';
  rsReciprocalMeterSteradianName = 'reciprocal %smeter steradian';
  rsReciprocalMeterSteradianPluralName = 'reciprocal %smeter steradian';

const
  ReciprocalMeterSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsReciprocalMeterSteradianSymbol;
    FName       : rsReciprocalMeterSteradianName;
    FPluralName : rsReciprocalMeterSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TCubicSecondAmpere }

resourcestring
  rsCubicSecondAmpereSymbol = '%ss³∙%sA';
  rsCubicSecondAmpereName = 'cubic %ssecond %sampere';
  rsCubicSecondAmperePluralName = 'cubic %sseconds %samperes';

const
  CubicSecondAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 180; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondAmpereSymbol;
    FName       : rsCubicSecondAmpereName;
    FPluralName : rsCubicSecondAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, 1));

{ TReciprocalKelvinMole }

resourcestring
  rsReciprocalKelvinMoleSymbol = '1/%sK/%smol';
  rsReciprocalKelvinMoleName = 'reciprocal %skelvin %smole';
  rsReciprocalKelvinMolePluralName = 'reciprocal %skelvin %smole';

const
  ReciprocalKelvinMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -60; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalKelvinMoleSymbol;
    FName       : rsReciprocalKelvinMoleName;
    FPluralName : rsReciprocalKelvinMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TCubicSecondSteradian }

resourcestring
  rsCubicSecondSteradianSymbol = '%ss³∙sr';
  rsCubicSecondSteradianName = 'cubic %ssecond steradian';
  rsCubicSecondSteradianPluralName = 'cubic %sseconds steradians';

const
  CubicSecondSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsCubicSecondSteradianSymbol;
    FName       : rsCubicSecondSteradianName;
    FPluralName : rsCubicSecondSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TCubicSecondCandela }

resourcestring
  rsCubicSecondCandelaSymbol = '%ss³∙%scd';
  rsCubicSecondCandelaName = 'cubic %ssecond %scandela';
  rsCubicSecondCandelaPluralName = 'cubic %sseconds %scandelas';

const
  CubicSecondCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 0);
    FSymbol     : rsCubicSecondCandelaSymbol;
    FName       : rsCubicSecondCandelaName;
    FPluralName : rsCubicSecondCandelaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, 1));

{ TSteradianPerKilogram }

resourcestring
  rsSteradianPerKilogramSymbol = 'sr/%skg';
  rsSteradianPerKilogramName = 'steradian per %skilogram';
  rsSteradianPerKilogramPluralName = 'steradians per %skilogram';

const
  SteradianPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSteradianPerKilogramSymbol;
    FName       : rsSteradianPerKilogramName;
    FPluralName : rsSteradianPerKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TCandelaPerKilogram }

resourcestring
  rsCandelaPerKilogramSymbol = '%scd/%skg';
  rsCandelaPerKilogramName = '%scandela per %skilogram';
  rsCandelaPerKilogramPluralName = '%scandelas per %skilogram';

const
  CandelaPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 60; FSteradian: 0);
    FSymbol     : rsCandelaPerKilogramSymbol;
    FName       : rsCandelaPerKilogramName;
    FPluralName : rsCandelaPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TReciprocalQuinticMeter }

resourcestring
  rsReciprocalQuinticMeterSymbol = '1/%sm⁵';
  rsReciprocalQuinticMeterName = 'reciprocal quintic %smeter';
  rsReciprocalQuinticMeterPluralName = 'reciprocal quintic %smeter';

const
  ReciprocalQuinticMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -300; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuinticMeterSymbol;
    FName       : rsReciprocalQuinticMeterName;
    FPluralName : rsReciprocalQuinticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticMeter }

resourcestring
  rsReciprocalSexticMeterSymbol = '1/%sm⁶';
  rsReciprocalSexticMeterName = 'reciprocal sextic %smeter';
  rsReciprocalSexticMeterPluralName = 'reciprocal sextic %smeter';

const
  ReciprocalSexticMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -360; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSexticMeterSymbol;
    FName       : rsReciprocalSexticMeterName;
    FPluralName : rsReciprocalSexticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-6));

{ TReciprocalSquareKelvin }

resourcestring
  rsReciprocalSquareKelvinSymbol = '1/%sK²';
  rsReciprocalSquareKelvinName = 'reciprocal square %skelvin';
  rsReciprocalSquareKelvinPluralName = 'reciprocal square %skelvin';

const
  ReciprocalSquareKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -120; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareKelvinSymbol;
    FName       : rsReciprocalSquareKelvinName;
    FPluralName : rsReciprocalSquareKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TReciprocalCubicKelvin }

resourcestring
  rsReciprocalCubicKelvinSymbol = '1/%sK³';
  rsReciprocalCubicKelvinName = 'reciprocal cubic %skelvin';
  rsReciprocalCubicKelvinPluralName = 'reciprocal cubic %skelvin';

const
  ReciprocalCubicKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -180; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicKelvinSymbol;
    FName       : rsReciprocalCubicKelvinName;
    FPluralName : rsReciprocalCubicKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalCandela }

resourcestring
  rsReciprocalCandelaSymbol = '1/%scd';
  rsReciprocalCandelaName = 'reciprocal %scandela';
  rsReciprocalCandelaPluralName = 'reciprocal %scandela';

const
  ReciprocalCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: 0);
    FSymbol     : rsReciprocalCandelaSymbol;
    FName       : rsReciprocalCandelaName;
    FPluralName : rsReciprocalCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TSquareSecondPerSteradian }

resourcestring
  rsSquareSecondPerSteradianSymbol = '%ss²/sr';
  rsSquareSecondPerSteradianName = 'square %ssecond per steradian';
  rsSquareSecondPerSteradianPluralName = 'square %sseconds per steradian';

const
  SquareSecondPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsSquareSecondPerSteradianSymbol;
    FName       : rsSquareSecondPerSteradianName;
    FPluralName : rsSquareSecondPerSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

{ TQuarticSecondPerMeter }

resourcestring
  rsQuarticSecondPerMeterSymbol = '%ss⁴/%sm';
  rsQuarticSecondPerMeterName = 'quartic %ssecond per %smeter';
  rsQuarticSecondPerMeterPluralName = 'quartic %sseconds per %smeter';

const
  QuarticSecondPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondPerMeterSymbol;
    FName       : rsQuarticSecondPerMeterName;
    FPluralName : rsQuarticSecondPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -1));

{ TQuinticSecondPerMeter }

resourcestring
  rsQuinticSecondPerMeterSymbol = '%ss⁵/%sm';
  rsQuinticSecondPerMeterName = 'quintic %ssecond per %smeter';
  rsQuinticSecondPerMeterPluralName = 'quintic %sseconds per %smeter';

const
  QuinticSecondPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 300; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuinticSecondPerMeterSymbol;
    FName       : rsQuinticSecondPerMeterName;
    FPluralName : rsQuinticSecondPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (5, -1));

{ TSexticSecondPerMeter }

resourcestring
  rsSexticSecondPerMeterSymbol = '%ss⁶/%sm';
  rsSexticSecondPerMeterName = 'sextic %ssecond per %smeter';
  rsSexticSecondPerMeterPluralName = 'sextic %sseconds per %smeter';

const
  SexticSecondPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticSecondPerMeterSymbol;
    FName       : rsSexticSecondPerMeterName;
    FPluralName : rsSexticSecondPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (6, -1));

{ TSecondPerKilogramPerMeter }

resourcestring
  rsSecondPerKilogramPerMeterSymbol = '%ss/%skg/%sm';
  rsSecondPerKilogramPerMeterName = '%ssecond per %skilogram per %smeter';
  rsSecondPerKilogramPerMeterPluralName = '%sseconds per %skilogram per %smeter';

const
  SecondPerKilogramPerMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSecondPerKilogramPerMeterSymbol;
    FName       : rsSecondPerKilogramPerMeterName;
    FPluralName : rsSecondPerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TSquareSecondPerSquareKilogramPerSquareMeter }

resourcestring
  rsSquareSecondPerSquareKilogramPerSquareMeterSymbol = '%ss²/%skg²/%sm²';
  rsSquareSecondPerSquareKilogramPerSquareMeterName = 'square %ssecond per square %skilogram per square %smeter';
  rsSquareSecondPerSquareKilogramPerSquareMeterPluralName = 'square %sseconds per square %skilogram per square %smeter';

const
  SquareSecondPerSquareKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: -120; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondPerSquareKilogramPerSquareMeterSymbol;
    FName       : rsSquareSecondPerSquareKilogramPerSquareMeterName;
    FPluralName : rsSquareSecondPerSquareKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -2, -2));

{ TSecondPerKilogramPerSquareMeter }

resourcestring
  rsSecondPerKilogramPerSquareMeterSymbol = '%ss/%skg/%sm²';
  rsSecondPerKilogramPerSquareMeterName = '%ssecond per %skilogram per square %smeter';
  rsSecondPerKilogramPerSquareMeterPluralName = '%sseconds per %skilogram per square %smeter';

const
  SecondPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSecondPerKilogramPerSquareMeterSymbol;
    FName       : rsSecondPerKilogramPerSquareMeterName;
    FPluralName : rsSecondPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TSquareMeterPerKilogram }

resourcestring
  rsSquareMeterPerKilogramSymbol = '%sm²/%skg';
  rsSquareMeterPerKilogramName = 'square %smeter per %skilogram';
  rsSquareMeterPerKilogramPluralName = 'square %smeters per %skilogram';

const
  SquareMeterPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerKilogramSymbol;
    FName       : rsSquareMeterPerKilogramName;
    FPluralName : rsSquareMeterPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TQuarticSecondPerSquareKilogramPerSquareMeter }

resourcestring
  rsQuarticSecondPerSquareKilogramPerSquareMeterSymbol = '%ss⁴/%skg²/%sm²';
  rsQuarticSecondPerSquareKilogramPerSquareMeterName = 'quartic %ssecond per square %skilogram per square %smeter';
  rsQuarticSecondPerSquareKilogramPerSquareMeterPluralName = 'quartic %sseconds per square %skilogram per square %smeter';

const
  QuarticSecondPerSquareKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: -120; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondPerSquareKilogramPerSquareMeterSymbol;
    FName       : rsQuarticSecondPerSquareKilogramPerSquareMeterName;
    FPluralName : rsQuarticSecondPerSquareKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, -2, -2));

{ TReciprocalSecondAmpere }

resourcestring
  rsReciprocalSecondAmpereSymbol = '1/%ss/%sA';
  rsReciprocalSecondAmpereName = 'reciprocal %ssecond %sampere';
  rsReciprocalSecondAmperePluralName = 'reciprocal %ssecond %sampere';

const
  ReciprocalSecondAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSecondAmpereSymbol;
    FName       : rsReciprocalSecondAmpereName;
    FPluralName : rsReciprocalSecondAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TReciprocalMeterSecondAmpere }

resourcestring
  rsReciprocalMeterSecondAmpereSymbol = '1/%sm/%ss/%sA';
  rsReciprocalMeterSecondAmpereName = 'reciprocal %smeter %ssecond %sampere';
  rsReciprocalMeterSecondAmperePluralName = 'reciprocal %smeter %ssecond %sampere';

const
  ReciprocalMeterSecondAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: -60; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalMeterSecondAmpereSymbol;
    FName       : rsReciprocalMeterSecondAmpereName;
    FPluralName : rsReciprocalMeterSecondAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (-1, -1, -1));

{ TCubicSecondAmperePerKilogramPerSquareMeter }

resourcestring
  rsCubicSecondAmperePerKilogramPerSquareMeterSymbol = '%ss³∙%sA/%skg/%sm²';
  rsCubicSecondAmperePerKilogramPerSquareMeterName = 'cubic %ssecond %sampere per %skilogram per square %smeter';
  rsCubicSecondAmperePerKilogramPerSquareMeterPluralName = 'cubic %sseconds %samperes per %skilogram per square %smeter';

const
  CubicSecondAmperePerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 180; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondAmperePerKilogramPerSquareMeterSymbol;
    FName       : rsCubicSecondAmperePerKilogramPerSquareMeterName;
    FPluralName : rsCubicSecondAmperePerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (3, 1, -1, -2));

{ TSexticSecondSquareAmperePerSquareKilogramPerQuarticMeter }

resourcestring
  rsSexticSecondSquareAmperePerSquareKilogramPerQuarticMeterSymbol = '%ss⁶∙%sA²/%skg²/%sm⁴';
  rsSexticSecondSquareAmperePerSquareKilogramPerQuarticMeterName = 'sextic %ssecond square %sampere per square %skilogram per quartic %smeter';
  rsSexticSecondSquareAmperePerSquareKilogramPerQuarticMeterPluralName = 'sextic %sseconds square %samperes per square %skilogram per quartic %smeter';

const
  SexticSecondSquareAmperePerSquareKilogramPerQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: -240; FSecond: 360; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticSecondSquareAmperePerSquareKilogramPerQuarticMeterSymbol;
    FName       : rsSexticSecondSquareAmperePerSquareKilogramPerQuarticMeterName;
    FPluralName : rsSexticSecondSquareAmperePerSquareKilogramPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (6, 2, -2, -4));

{ TKilogramSquareMeterPerQuarticSecondPerSquareAmpere }

resourcestring
  rsKilogramSquareMeterPerQuarticSecondPerSquareAmpereSymbol = '%skg∙%sm²/%ss⁴/%sA²';
  rsKilogramSquareMeterPerQuarticSecondPerSquareAmpereName = '%skilogram square %smeter per quartic %ssecond per square %sampere';
  rsKilogramSquareMeterPerQuarticSecondPerSquareAmperePluralName = '%skilograms square %smeters per quartic %ssecond per square %sampere';

const
  KilogramSquareMeterPerQuarticSecondPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -240; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerQuarticSecondPerSquareAmpereSymbol;
    FName       : rsKilogramSquareMeterPerQuarticSecondPerSquareAmpereName;
    FPluralName : rsKilogramSquareMeterPerQuarticSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (1, 2, -4, -2));

{ TReciprocalCandelaSteradian }

resourcestring
  rsReciprocalCandelaSteradianSymbol = '1/%scd/sr';
  rsReciprocalCandelaSteradianName = 'reciprocal %scandela steradian';
  rsReciprocalCandelaSteradianPluralName = 'reciprocal %scandela steradian';

const
  ReciprocalCandelaSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: -60);
    FSymbol     : rsReciprocalCandelaSteradianSymbol;
    FName       : rsReciprocalCandelaSteradianName;
    FPluralName : rsReciprocalCandelaSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSecondCandelaSteradian }

resourcestring
  rsReciprocalSecondCandelaSteradianSymbol = '1/%ss/%scd/sr';
  rsReciprocalSecondCandelaSteradianName = 'reciprocal %ssecond %scandela steradian';
  rsReciprocalSecondCandelaSteradianPluralName = 'reciprocal %ssecond %scandela steradian';

const
  ReciprocalSecondCandelaSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: -60);
    FSymbol     : rsReciprocalSecondCandelaSteradianSymbol;
    FName       : rsReciprocalSecondCandelaSteradianName;
    FPluralName : rsReciprocalSecondCandelaSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TCubicMeterPerSecondPerCandelaPerSteradian }

resourcestring
  rsCubicMeterPerSecondPerCandelaPerSteradianSymbol = '%sm³/%ss/%scd/sr';
  rsCubicMeterPerSecondPerCandelaPerSteradianName = 'cubic %smeter per %ssecond per %scandela per steradian';
  rsCubicMeterPerSecondPerCandelaPerSteradianPluralName = 'cubic %smeters per %ssecond per %scandela per steradian';

const
  CubicMeterPerSecondPerCandelaPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: -60);
    FSymbol     : rsCubicMeterPerSecondPerCandelaPerSteradianSymbol;
    FName       : rsCubicMeterPerSecondPerCandelaPerSteradianName;
    FPluralName : rsCubicMeterPerSecondPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -1, -1));

{ TSquareMeterPerCandelaPerSteradian }

resourcestring
  rsSquareMeterPerCandelaPerSteradianSymbol = '%sm²/%scd/sr';
  rsSquareMeterPerCandelaPerSteradianName = 'square %smeter per %scandela per steradian';
  rsSquareMeterPerCandelaPerSteradianPluralName = 'square %smeters per %scandela per steradian';

const
  SquareMeterPerCandelaPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: -60);
    FSymbol     : rsSquareMeterPerCandelaPerSteradianSymbol;
    FName       : rsSquareMeterPerCandelaPerSteradianName;
    FPluralName : rsSquareMeterPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TSquareMeterPerSecondPerCandelaPerSteradian }

resourcestring
  rsSquareMeterPerSecondPerCandelaPerSteradianSymbol = '%sm²/%ss/%scd/sr';
  rsSquareMeterPerSecondPerCandelaPerSteradianName = 'square %smeter per %ssecond per %scandela per steradian';
  rsSquareMeterPerSecondPerCandelaPerSteradianPluralName = 'square %smeters per %ssecond per %scandela per steradian';

const
  SquareMeterPerSecondPerCandelaPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: -60);
    FSymbol     : rsSquareMeterPerSecondPerCandelaPerSteradianSymbol;
    FName       : rsSquareMeterPerSecondPerCandelaPerSteradianName;
    FPluralName : rsSquareMeterPerSecondPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -1));

{ TSquareMeterSquareSecondPerKilogram }

resourcestring
  rsSquareMeterSquareSecondPerKilogramSymbol = '%sm²∙%ss²/%skg';
  rsSquareMeterSquareSecondPerKilogramName = 'square %smeter square %ssecond per %skilogram';
  rsSquareMeterSquareSecondPerKilogramPluralName = 'square %smeters square %sseconds per %skilogram';

const
  SquareMeterSquareSecondPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 120; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterSquareSecondPerKilogramSymbol;
    FName       : rsSquareMeterSquareSecondPerKilogramName;
    FPluralName : rsSquareMeterSquareSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 2, -1));

{ TMeterSecondPerKilogram }

resourcestring
  rsMeterSecondPerKilogramSymbol = '%sm∙%ss/%skg';
  rsMeterSecondPerKilogramName = '%smeter %ssecond per %skilogram';
  rsMeterSecondPerKilogramPluralName = '%smeters %sseconds per %skilogram';

const
  MeterSecondPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 60; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterSecondPerKilogramSymbol;
    FName       : rsMeterSecondPerKilogramName;
    FPluralName : rsMeterSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TQuarticMeterPerKilogram }

resourcestring
  rsQuarticMeterPerKilogramSymbol = '%sm⁴/%skg';
  rsQuarticMeterPerKilogramName = 'quartic %smeter per %skilogram';
  rsQuarticMeterPerKilogramPluralName = 'quartic %smeters per %skilogram';

const
  QuarticMeterPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticMeterPerKilogramSymbol;
    FName       : rsQuarticMeterPerKilogramName;
    FPluralName : rsQuarticMeterPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -1));

{ TQuarticMeterSecondPerKilogram }

resourcestring
  rsQuarticMeterSecondPerKilogramSymbol = '%sm⁴∙%ss/%skg';
  rsQuarticMeterSecondPerKilogramName = 'quartic %smeter %ssecond per %skilogram';
  rsQuarticMeterSecondPerKilogramPluralName = 'quartic %smeters %sseconds per %skilogram';

const
  QuarticMeterSecondPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 240; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticMeterSecondPerKilogramSymbol;
    FName       : rsQuarticMeterSecondPerKilogramName;
    FPluralName : rsQuarticMeterSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, 1, -1));

{ TSquareSecondPerCubicMeter }

resourcestring
  rsSquareSecondPerCubicMeterSymbol = '%ss²/%sm³';
  rsSquareSecondPerCubicMeterName = 'square %ssecond per cubic %smeter';
  rsSquareSecondPerCubicMeterPluralName = 'square %sseconds per cubic %smeter';

const
  SquareSecondPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondPerCubicMeterSymbol;
    FName       : rsSquareSecondPerCubicMeterName;
    FPluralName : rsSquareSecondPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -3));

{ TSquareSecondPerKilogramPerCubicMeter }

resourcestring
  rsSquareSecondPerKilogramPerCubicMeterSymbol = '%ss²/%skg/%sm³';
  rsSquareSecondPerKilogramPerCubicMeterName = 'square %ssecond per %skilogram per cubic %smeter';
  rsSquareSecondPerKilogramPerCubicMeterPluralName = 'square %sseconds per %skilogram per cubic %smeter';

const
  SquareSecondPerKilogramPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -180; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondPerKilogramPerCubicMeterSymbol;
    FName       : rsSquareSecondPerKilogramPerCubicMeterName;
    FPluralName : rsSquareSecondPerKilogramPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -3));

{ TSquareSecondPerKilogramPerQuarticMeter }

resourcestring
  rsSquareSecondPerKilogramPerQuarticMeterSymbol = '%ss²/%skg/%sm⁴';
  rsSquareSecondPerKilogramPerQuarticMeterName = 'square %ssecond per %skilogram per quartic %smeter';
  rsSquareSecondPerKilogramPerQuarticMeterPluralName = 'square %sseconds per %skilogram per quartic %smeter';

const
  SquareSecondPerKilogramPerQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -240; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondPerKilogramPerQuarticMeterSymbol;
    FName       : rsSquareSecondPerKilogramPerQuarticMeterName;
    FPluralName : rsSquareSecondPerKilogramPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -4));

{ TKilogramSquareSecondPerMeter }

resourcestring
  rsKilogramSquareSecondPerMeterSymbol = '%skg∙%ss²/%sm';
  rsKilogramSquareSecondPerMeterName = '%skilogram square %ssecond per %smeter';
  rsKilogramSquareSecondPerMeterPluralName = '%skilograms square %sseconds per %smeter';

const
  KilogramSquareSecondPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -60; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareSecondPerMeterSymbol;
    FName       : rsKilogramSquareSecondPerMeterName;
    FPluralName : rsKilogramSquareSecondPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TMeterPerSquareKilogram }

resourcestring
  rsMeterPerSquareKilogramSymbol = '%sm/%skg²';
  rsMeterPerSquareKilogramName = '%smeter per square %skilogram';
  rsMeterPerSquareKilogramPluralName = '%smeters per square %skilogram';

const
  MeterPerSquareKilogramUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerSquareKilogramSymbol;
    FName       : rsMeterPerSquareKilogramName;
    FPluralName : rsMeterPerSquareKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TKilogramSquareSecondPerCubicMeter }

resourcestring
  rsKilogramSquareSecondPerCubicMeterSymbol = '%skg∙%ss²/%sm³';
  rsKilogramSquareSecondPerCubicMeterName = '%skilogram square %ssecond per cubic %smeter';
  rsKilogramSquareSecondPerCubicMeterPluralName = '%skilograms square %sseconds per cubic %smeter';

const
  KilogramSquareSecondPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: -180; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareSecondPerCubicMeterSymbol;
    FName       : rsKilogramSquareSecondPerCubicMeterName;
    FPluralName : rsKilogramSquareSecondPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -3));

{ TReciprocalKilogramKelvin }

resourcestring
  rsReciprocalKilogramKelvinSymbol = '1/%skg/%sK';
  rsReciprocalKilogramKelvinName = 'reciprocal %skilogram %skelvin';
  rsReciprocalKilogramKelvinPluralName = 'reciprocal %skilogram %skelvin';

const
  ReciprocalKilogramKelvinUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalKilogramKelvinSymbol;
    FName       : rsReciprocalKilogramKelvinName;
    FPluralName : rsReciprocalKilogramKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TSquareSecondKelvinPerKilogramPerSquareMeter }

resourcestring
  rsSquareSecondKelvinPerKilogramPerSquareMeterSymbol = '%ss²∙%sK/%skg/%sm²';
  rsSquareSecondKelvinPerKilogramPerSquareMeterName = 'square %ssecond %skelvin per %skilogram per square %smeter';
  rsSquareSecondKelvinPerKilogramPerSquareMeterPluralName = 'square %sseconds %skelvins per %skilogram per square %smeter';

const
  SquareSecondKelvinPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 120; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondKelvinPerKilogramPerSquareMeterSymbol;
    FName       : rsSquareSecondKelvinPerKilogramPerSquareMeterName;
    FPluralName : rsSquareSecondKelvinPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (2, 1, -1, -2));

{ TSquareSecondKelvinPerSquareMeter }

resourcestring
  rsSquareSecondKelvinPerSquareMeterSymbol = '%ss²∙%sK/%sm²';
  rsSquareSecondKelvinPerSquareMeterName = 'square %ssecond %skelvin per square %smeter';
  rsSquareSecondKelvinPerSquareMeterPluralName = 'square %sseconds %skelvins per square %smeter';

const
  SquareSecondKelvinPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 120; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondKelvinPerSquareMeterSymbol;
    FName       : rsSquareSecondKelvinPerSquareMeterName;
    FPluralName : rsSquareSecondKelvinPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 1, -2));

{ TReciprocalMeterKelvin }

resourcestring
  rsReciprocalMeterKelvinSymbol = '1/%sm/%sK';
  rsReciprocalMeterKelvinName = 'reciprocal %smeter %skelvin';
  rsReciprocalMeterKelvinPluralName = 'reciprocal %smeter %skelvin';

const
  ReciprocalMeterKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 0; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalMeterKelvinSymbol;
    FName       : rsReciprocalMeterKelvinName;
    FPluralName : rsReciprocalMeterKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TMeterCubicSecondPerKilogram }

resourcestring
  rsMeterCubicSecondPerKilogramSymbol = '%sm∙%ss³/%skg';
  rsMeterCubicSecondPerKilogramName = '%smeter cubic %ssecond per %skilogram';
  rsMeterCubicSecondPerKilogramPluralName = '%smeters cubic %sseconds per %skilogram';

const
  MeterCubicSecondPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 60; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterCubicSecondPerKilogramSymbol;
    FName       : rsMeterCubicSecondPerKilogramName;
    FPluralName : rsMeterCubicSecondPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 3, -1));

{ TReciprocalSquareMeterKelvin }

resourcestring
  rsReciprocalSquareMeterKelvinSymbol = '1/%sm²/%sK';
  rsReciprocalSquareMeterKelvinName = 'reciprocal square %smeter %skelvin';
  rsReciprocalSquareMeterKelvinPluralName = 'reciprocal square %smeter %skelvin';

const
  ReciprocalSquareMeterKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: -60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareMeterKelvinSymbol;
    FName       : rsReciprocalSquareMeterKelvinName;
    FPluralName : rsReciprocalSquareMeterKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -1));

{ TReciprocalSquareMeterQuarticKelvin }

resourcestring
  rsReciprocalSquareMeterQuarticKelvinSymbol = '1/%sm²/%sK⁴';
  rsReciprocalSquareMeterQuarticKelvinName = 'reciprocal square %smeter quartic %skelvin';
  rsReciprocalSquareMeterQuarticKelvinPluralName = 'reciprocal square %smeter quartic %skelvin';

const
  ReciprocalSquareMeterQuarticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: -240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareMeterQuarticKelvinSymbol;
    FName       : rsReciprocalSquareMeterQuarticKelvinName;
    FPluralName : rsReciprocalSquareMeterQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -4));

{ TCubicSecondQuarticKelvinPerKilogramPerSquareMeter }

resourcestring
  rsCubicSecondQuarticKelvinPerKilogramPerSquareMeterSymbol = '%ss³∙%sK⁴/%skg/%sm²';
  rsCubicSecondQuarticKelvinPerKilogramPerSquareMeterName = 'cubic %ssecond quartic %skelvin per %skilogram per square %smeter';
  rsCubicSecondQuarticKelvinPerKilogramPerSquareMeterPluralName = 'cubic %sseconds quartic %skelvins per %skilogram per square %smeter';

const
  CubicSecondQuarticKelvinPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 180; FAmpere: 0; FKelvin: 240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondQuarticKelvinPerKilogramPerSquareMeterSymbol;
    FName       : rsCubicSecondQuarticKelvinPerKilogramPerSquareMeterName;
    FPluralName : rsCubicSecondQuarticKelvinPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (3, 4, -1, -2));

{ TCubicSecondQuarticKelvinPerKilogram }

resourcestring
  rsCubicSecondQuarticKelvinPerKilogramSymbol = '%ss³∙%sK⁴/%skg';
  rsCubicSecondQuarticKelvinPerKilogramName = 'cubic %ssecond quartic %skelvin per %skilogram';
  rsCubicSecondQuarticKelvinPerKilogramPluralName = 'cubic %sseconds quartic %skelvins per %skilogram';

const
  CubicSecondQuarticKelvinPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondQuarticKelvinPerKilogramSymbol;
    FName       : rsCubicSecondQuarticKelvinPerKilogramName;
    FPluralName : rsCubicSecondQuarticKelvinPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 4, -1));

{ TSquareSecondMolePerKilogramPerSquareMeter }

resourcestring
  rsSquareSecondMolePerKilogramPerSquareMeterSymbol = '%ss²∙%smol/%skg/%sm²';
  rsSquareSecondMolePerKilogramPerSquareMeterName = 'square %ssecond %smole per %skilogram per square %smeter';
  rsSquareSecondMolePerKilogramPerSquareMeterPluralName = 'square %sseconds %smoles per %skilogram per square %smeter';

const
  SquareSecondMolePerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondMolePerKilogramPerSquareMeterSymbol;
    FName       : rsSquareSecondMolePerKilogramPerSquareMeterName;
    FPluralName : rsSquareSecondMolePerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (2, 1, -1, -2));

{ TSquareSecondKelvinMolePerKilogramPerSquareMeter }

resourcestring
  rsSquareSecondKelvinMolePerKilogramPerSquareMeterSymbol = '%ss²∙%sK∙%smol/%skg/%sm²';
  rsSquareSecondKelvinMolePerKilogramPerSquareMeterName = 'square %ssecond %skelvin %smole per %skilogram per square %smeter';
  rsSquareSecondKelvinMolePerKilogramPerSquareMeterPluralName = 'square %sseconds %skelvins %smoles per %skilogram per square %smeter';

const
  SquareSecondKelvinMolePerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 120; FAmpere: 0; FKelvin: 60; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondKelvinMolePerKilogramPerSquareMeterSymbol;
    FName       : rsSquareSecondKelvinMolePerKilogramPerSquareMeterName;
    FPluralName : rsSquareSecondKelvinMolePerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone, pNone);
    FExponents  : (2, 1, 1, -1, -2));

{ TMeterPerSecondPerAmpere }

resourcestring
  rsMeterPerSecondPerAmpereSymbol = '%sm/%ss/%sA';
  rsMeterPerSecondPerAmpereName = '%smeter per %ssecond per %sampere';
  rsMeterPerSecondPerAmperePluralName = '%smeters per %ssecond per %sampere';

const
  MeterPerSecondPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: -60; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterPerSecondPerAmpereSymbol;
    FName       : rsMeterPerSecondPerAmpereName;
    FPluralName : rsMeterPerSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TSquareMeterPerSecondPerAmpere }

resourcestring
  rsSquareMeterPerSecondPerAmpereSymbol = '%sm²/%ss/%sA';
  rsSquareMeterPerSecondPerAmpereName = 'square %smeter per %ssecond per %sampere';
  rsSquareMeterPerSecondPerAmperePluralName = 'square %smeters per %ssecond per %sampere';

const
  SquareMeterPerSecondPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -60; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerSecondPerAmpereSymbol;
    FName       : rsSquareMeterPerSecondPerAmpereName;
    FPluralName : rsSquareMeterPerSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -1));

{ TQuarticSecondSquareAmperePerKilogramPerMeter }

resourcestring
  rsQuarticSecondSquareAmperePerKilogramPerMeterSymbol = '%ss⁴∙%sA²/%skg/%sm';
  rsQuarticSecondSquareAmperePerKilogramPerMeterName = 'quartic %ssecond square %sampere per %skilogram per %smeter';
  rsQuarticSecondSquareAmperePerKilogramPerMeterPluralName = 'quartic %sseconds square %samperes per %skilogram per %smeter';

const
  QuarticSecondSquareAmperePerKilogramPerMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 240; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondSquareAmperePerKilogramPerMeterSymbol;
    FName       : rsQuarticSecondSquareAmperePerKilogramPerMeterName;
    FPluralName : rsQuarticSecondSquareAmperePerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (4, 2, -1, -1));

{ TCubicSecondAmperePerKilogramPerCubicMeter }

resourcestring
  rsCubicSecondAmperePerKilogramPerCubicMeterSymbol = '%ss³∙%sA/%skg/%sm³';
  rsCubicSecondAmperePerKilogramPerCubicMeterName = 'cubic %ssecond %sampere per %skilogram per cubic %smeter';
  rsCubicSecondAmperePerKilogramPerCubicMeterPluralName = 'cubic %sseconds %samperes per %skilogram per cubic %smeter';

const
  CubicSecondAmperePerKilogramPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -180; FSecond: 180; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondAmperePerKilogramPerCubicMeterSymbol;
    FName       : rsCubicSecondAmperePerKilogramPerCubicMeterName;
    FPluralName : rsCubicSecondAmperePerKilogramPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (3, 1, -1, -3));

{ TQuarticSecondAmperePerKilogramPerCubicMeter }

resourcestring
  rsQuarticSecondAmperePerKilogramPerCubicMeterSymbol = '%ss⁴∙%sA/%skg/%sm³';
  rsQuarticSecondAmperePerKilogramPerCubicMeterName = 'quartic %ssecond %sampere per %skilogram per cubic %smeter';
  rsQuarticSecondAmperePerKilogramPerCubicMeterPluralName = 'quartic %sseconds %samperes per %skilogram per cubic %smeter';

const
  QuarticSecondAmperePerKilogramPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -180; FSecond: 240; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondAmperePerKilogramPerCubicMeterSymbol;
    FName       : rsQuarticSecondAmperePerKilogramPerCubicMeterName;
    FPluralName : rsQuarticSecondAmperePerKilogramPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (4, 1, -1, -3));

{ TSquareSecondAmperePerKilogramPerMeter }

resourcestring
  rsSquareSecondAmperePerKilogramPerMeterSymbol = '%ss²∙%sA/%skg/%sm';
  rsSquareSecondAmperePerKilogramPerMeterName = 'square %ssecond %sampere per %skilogram per %smeter';
  rsSquareSecondAmperePerKilogramPerMeterPluralName = 'square %sseconds %samperes per %skilogram per %smeter';

const
  SquareSecondAmperePerKilogramPerMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 120; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondAmperePerKilogramPerMeterSymbol;
    FName       : rsSquareSecondAmperePerKilogramPerMeterName;
    FPluralName : rsSquareSecondAmperePerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (2, 1, -1, -1));

{ TSquareSecondSquareAmperePerKilogramPerMeter }

resourcestring
  rsSquareSecondSquareAmperePerKilogramPerMeterSymbol = '%ss²∙%sA²/%skg/%sm';
  rsSquareSecondSquareAmperePerKilogramPerMeterName = 'square %ssecond square %sampere per %skilogram per %smeter';
  rsSquareSecondSquareAmperePerKilogramPerMeterPluralName = 'square %sseconds square %samperes per %skilogram per %smeter';

const
  SquareSecondSquareAmperePerKilogramPerMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 120; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondSquareAmperePerKilogramPerMeterSymbol;
    FName       : rsSquareSecondSquareAmperePerKilogramPerMeterName;
    FPluralName : rsSquareSecondSquareAmperePerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (2, 2, -1, -1));

{ TSquareSecondPerSquareKilogram }

resourcestring
  rsSquareSecondPerSquareKilogramSymbol = '%ss²/%skg²';
  rsSquareSecondPerSquareKilogramName = 'square %ssecond per square %skilogram';
  rsSquareSecondPerSquareKilogramPluralName = 'square %sseconds per square %skilogram';

const
  SquareSecondPerSquareKilogramUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondPerSquareKilogramSymbol;
    FName       : rsSquareSecondPerSquareKilogramName;
    FPluralName : rsSquareSecondPerSquareKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TQuarticSecondPerSquareKilogramPerQuarticMeter }

resourcestring
  rsQuarticSecondPerSquareKilogramPerQuarticMeterSymbol = '%ss⁴/%skg²/%sm⁴';
  rsQuarticSecondPerSquareKilogramPerQuarticMeterName = 'quartic %ssecond per square %skilogram per quartic %smeter';
  rsQuarticSecondPerSquareKilogramPerQuarticMeterPluralName = 'quartic %sseconds per square %skilogram per quartic %smeter';

const
  QuarticSecondPerSquareKilogramPerQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: -240; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondPerSquareKilogramPerQuarticMeterSymbol;
    FName       : rsQuarticSecondPerSquareKilogramPerQuarticMeterName;
    FPluralName : rsQuarticSecondPerSquareKilogramPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, -2, -4));

{ TSquareSecondPerSquareKilogramPerQuarticMeter }

resourcestring
  rsSquareSecondPerSquareKilogramPerQuarticMeterSymbol = '%ss²/%skg²/%sm⁴';
  rsSquareSecondPerSquareKilogramPerQuarticMeterName = 'square %ssecond per square %skilogram per quartic %smeter';
  rsSquareSecondPerSquareKilogramPerQuarticMeterPluralName = 'square %sseconds per square %skilogram per quartic %smeter';

const
  SquareSecondPerSquareKilogramPerQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: -240; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondPerSquareKilogramPerQuarticMeterSymbol;
    FName       : rsSquareSecondPerSquareKilogramPerQuarticMeterName;
    FPluralName : rsSquareSecondPerSquareKilogramPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -2, -4));

{ TKilogramPerSecondPerAmpere }

resourcestring
  rsKilogramPerSecondPerAmpereSymbol = '%skg/%ss/%sA';
  rsKilogramPerSecondPerAmpereName = '%skilogram per %ssecond per %sampere';
  rsKilogramPerSecondPerAmperePluralName = '%skilograms per %ssecond per %sampere';

const
  KilogramPerSecondPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -60; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramPerSecondPerAmpereSymbol;
    FName       : rsKilogramPerSecondPerAmpereName;
    FPluralName : rsKilogramPerSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TReciprocalSquareMeterAmpere }

resourcestring
  rsReciprocalSquareMeterAmpereSymbol = '1/%sm²/%sA';
  rsReciprocalSquareMeterAmpereName = 'reciprocal square %smeter %sampere';
  rsReciprocalSquareMeterAmperePluralName = 'reciprocal square %smeter %sampere';

const
  ReciprocalSquareMeterAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareMeterAmpereSymbol;
    FName       : rsReciprocalSquareMeterAmpereName;
    FPluralName : rsReciprocalSquareMeterAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -1));

{ TKilogramSquareMeterPerCubicSecondPerCandelaPerSteradian }

resourcestring
  rsKilogramSquareMeterPerCubicSecondPerCandelaPerSteradianSymbol = '%skg∙%sm²/%ss³/%scd/sr';
  rsKilogramSquareMeterPerCubicSecondPerCandelaPerSteradianName = '%skilogram square %smeter per cubic %ssecond per %scandela per steradian';
  rsKilogramSquareMeterPerCubicSecondPerCandelaPerSteradianPluralName = '%skilograms square %smeters per cubic %ssecond per %scandela per steradian';

const
  KilogramSquareMeterPerCubicSecondPerCandelaPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: -60);
    FSymbol     : rsKilogramSquareMeterPerCubicSecondPerCandelaPerSteradianSymbol;
    FName       : rsKilogramSquareMeterPerCubicSecondPerCandelaPerSteradianName;
    FPluralName : rsKilogramSquareMeterPerCubicSecondPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (1, 2, -3, -1));

{ TCubicMeterPerMole }

resourcestring
  rsCubicMeterPerMoleSymbol = '%sm³/%smol';
  rsCubicMeterPerMoleName = 'cubic %smeter per %smole';
  rsCubicMeterPerMolePluralName = 'cubic %smeters per %smole';

const
  CubicMeterPerMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterPerMoleSymbol;
    FName       : rsCubicMeterPerMoleName;
    FPluralName : rsCubicMeterPerMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TSquareMeterPerCandela }

resourcestring
  rsSquareMeterPerCandelaSymbol = '%sm²/%scd';
  rsSquareMeterPerCandelaName = 'square %smeter per %scandela';
  rsSquareMeterPerCandelaPluralName = 'square %smeters per %scandela';

const
  SquareMeterPerCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: 0);
    FSymbol     : rsSquareMeterPerCandelaSymbol;
    FName       : rsSquareMeterPerCandelaName;
    FPluralName : rsSquareMeterPerCandelaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TCubicMeterPerSecondPerAmpere }

resourcestring
  rsCubicMeterPerSecondPerAmpereSymbol = '%sm³/%ss/%sA';
  rsCubicMeterPerSecondPerAmpereName = 'cubic %smeter per %ssecond per %sampere';
  rsCubicMeterPerSecondPerAmperePluralName = 'cubic %smeters per %ssecond per %sampere';

const
  CubicMeterPerSecondPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: -60; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterPerSecondPerAmpereSymbol;
    FName       : rsCubicMeterPerSecondPerAmpereName;
    FPluralName : rsCubicMeterPerSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -1, -1));

{ TSecondPerSteradian }

resourcestring
  rsSecondPerSteradianSymbol = '%ss/sr';
  rsSecondPerSteradianName = '%ssecond per steradian';
  rsSecondPerSteradianPluralName = '%sseconds per steradian';

const
  SecondPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsSecondPerSteradianSymbol;
    FName       : rsSecondPerSteradianName;
    FPluralName : rsSecondPerSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (1));

{ TReciprocalSquareMeterSteradian }

resourcestring
  rsReciprocalSquareMeterSteradianSymbol = '1/%sm²/sr';
  rsReciprocalSquareMeterSteradianName = 'reciprocal square %smeter steradian';
  rsReciprocalSquareMeterSteradianPluralName = 'reciprocal square %smeter steradian';

const
  ReciprocalSquareMeterSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsReciprocalSquareMeterSteradianSymbol;
    FName       : rsReciprocalSquareMeterSteradianName;
    FPluralName : rsReciprocalSquareMeterSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TReciprocalCubicMeterSteradian }

resourcestring
  rsReciprocalCubicMeterSteradianSymbol = '1/%sm³/sr';
  rsReciprocalCubicMeterSteradianName = 'reciprocal cubic %smeter steradian';
  rsReciprocalCubicMeterSteradianPluralName = 'reciprocal cubic %smeter steradian';

const
  ReciprocalCubicMeterSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsReciprocalCubicMeterSteradianSymbol;
    FName       : rsReciprocalCubicMeterSteradianName;
    FPluralName : rsReciprocalCubicMeterSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TSecondPerSquareMeterPerSteradian }

resourcestring
  rsSecondPerSquareMeterPerSteradianSymbol = '%ss/%sm²/sr';
  rsSecondPerSquareMeterPerSteradianName = '%ssecond per square %smeter per steradian';
  rsSecondPerSquareMeterPerSteradianPluralName = '%sseconds per square %smeter per steradian';

const
  SecondPerSquareMeterPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsSecondPerSquareMeterPerSteradianSymbol;
    FName       : rsSecondPerSquareMeterPerSteradianName;
    FPluralName : rsSecondPerSquareMeterPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TSquareSecondSteradianPerKilogramPerSquareMeter }

resourcestring
  rsSquareSecondSteradianPerKilogramPerSquareMeterSymbol = '%ss²∙sr/%skg/%sm²';
  rsSquareSecondSteradianPerKilogramPerSquareMeterName = 'square %ssecond steradian per %skilogram per square %smeter';
  rsSquareSecondSteradianPerKilogramPerSquareMeterPluralName = 'square %sseconds steradians per %skilogram per square %smeter';

const
  SquareSecondSteradianPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSquareSecondSteradianPerKilogramPerSquareMeterSymbol;
    FName       : rsSquareSecondSteradianPerKilogramPerSquareMeterName;
    FPluralName : rsSquareSecondSteradianPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -2));

{ TCubicSecondSteradianPerKilogramPerMeter }

resourcestring
  rsCubicSecondSteradianPerKilogramPerMeterSymbol = '%ss³∙sr/%skg/%sm';
  rsCubicSecondSteradianPerKilogramPerMeterName = 'cubic %ssecond steradian per %skilogram per %smeter';
  rsCubicSecondSteradianPerKilogramPerMeterPluralName = 'cubic %sseconds steradians per %skilogram per %smeter';

const
  CubicSecondSteradianPerKilogramPerMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsCubicSecondSteradianPerKilogramPerMeterSymbol;
    FName       : rsCubicSecondSteradianPerKilogramPerMeterName;
    FPluralName : rsCubicSecondSteradianPerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -1, -1));

{ TMeterCubicSecondSteradianPerKilogram }

resourcestring
  rsMeterCubicSecondSteradianPerKilogramSymbol = '%sm∙%ss³∙sr/%skg';
  rsMeterCubicSecondSteradianPerKilogramName = '%smeter cubic %ssecond steradian per %skilogram';
  rsMeterCubicSecondSteradianPerKilogramPluralName = '%smeters cubic %sseconds steradians per %skilogram';

const
  MeterCubicSecondSteradianPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 60; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsMeterCubicSecondSteradianPerKilogramSymbol;
    FName       : rsMeterCubicSecondSteradianPerKilogramName;
    FPluralName : rsMeterCubicSecondSteradianPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 3, -1));

{ TSquareSecondSteradianPerKilogram }

resourcestring
  rsSquareSecondSteradianPerKilogramSymbol = '%ss²∙sr/%skg';
  rsSquareSecondSteradianPerKilogramName = 'square %ssecond steradian per %skilogram';
  rsSquareSecondSteradianPerKilogramPluralName = 'square %sseconds steradians per %skilogram';

const
  SquareSecondSteradianPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSquareSecondSteradianPerKilogramSymbol;
    FName       : rsSquareSecondSteradianPerKilogramName;
    FPluralName : rsSquareSecondSteradianPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TCubicMeterSecondPerMole }

resourcestring
  rsCubicMeterSecondPerMoleSymbol = '%sm³∙%ss/%smol';
  rsCubicMeterSecondPerMoleName = 'cubic %smeter %ssecond per %smole';
  rsCubicMeterSecondPerMolePluralName = 'cubic %smeters %sseconds per %smole';

const
  CubicMeterSecondPerMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: -60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterSecondPerMoleSymbol;
    FName       : rsCubicMeterSecondPerMoleName;
    FPluralName : rsCubicMeterSecondPerMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -1));

{ TMolePerSecondPerAmpere }

resourcestring
  rsMolePerSecondPerAmpereSymbol = '%smol/%ss/%sA';
  rsMolePerSecondPerAmpereName = '%smole per %ssecond per %sampere';
  rsMolePerSecondPerAmperePluralName = '%smoles per %ssecond per %sampere';

const
  MolePerSecondPerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: -60; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMolePerSecondPerAmpereSymbol;
    FName       : rsMolePerSecondPerAmpereName;
    FPluralName : rsMolePerSecondPerAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -1));

{ TReciprocalSexticRootKilogram }

resourcestring
  rsReciprocalSexticRootKilogramSymbol = '1/⁶√%skg';
  rsReciprocalSexticRootKilogramName = 'reciprocal sextic root %skilogram';
  rsReciprocalSexticRootKilogramPluralName = 'reciprocal sextic root %skilogram';

const
  ReciprocalSexticRootKilogramUnit : TUnit = (
    FDim        : (FKilogram: -10; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSexticRootKilogramSymbol;
    FName       : rsReciprocalSexticRootKilogramName;
    FPluralName : rsReciprocalSexticRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuinticRootKilogram }

resourcestring
  rsReciprocalQuinticRootKilogramSymbol = '1/⁵√%skg';
  rsReciprocalQuinticRootKilogramName = 'reciprocal quintic root %skilogram';
  rsReciprocalQuinticRootKilogramPluralName = 'reciprocal quintic root %skilogram';

const
  ReciprocalQuinticRootKilogramUnit : TUnit = (
    FDim        : (FKilogram: -12; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuinticRootKilogramSymbol;
    FName       : rsReciprocalQuinticRootKilogramName;
    FPluralName : rsReciprocalQuinticRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuarticRootKilogram }

resourcestring
  rsReciprocalQuarticRootKilogramSymbol = '1/∜%skg';
  rsReciprocalQuarticRootKilogramName = 'reciprocal quartic root %skilogram';
  rsReciprocalQuarticRootKilogramPluralName = 'reciprocal quartic root %skilogram';

const
  ReciprocalQuarticRootKilogramUnit : TUnit = (
    FDim        : (FKilogram: -15; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticRootKilogramSymbol;
    FName       : rsReciprocalQuarticRootKilogramName;
    FPluralName : rsReciprocalQuarticRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicRootKilogram }

resourcestring
  rsReciprocalCubicRootKilogramSymbol = '1/∛%skg';
  rsReciprocalCubicRootKilogramName = 'reciprocal cubic root %skilogram';
  rsReciprocalCubicRootKilogramPluralName = 'reciprocal cubic root %skilogram';

const
  ReciprocalCubicRootKilogramUnit : TUnit = (
    FDim        : (FKilogram: -20; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicRootKilogramSymbol;
    FName       : rsReciprocalCubicRootKilogramName;
    FPluralName : rsReciprocalCubicRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootKilogram }

resourcestring
  rsReciprocalSquareRootKilogramSymbol = '1/√%skg';
  rsReciprocalSquareRootKilogramName = 'reciprocal square root %skilogram';
  rsReciprocalSquareRootKilogramPluralName = 'reciprocal square root %skilogram';

const
  ReciprocalSquareRootKilogramUnit : TUnit = (
    FDim        : (FKilogram: -30; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootKilogramSymbol;
    FName       : rsReciprocalSquareRootKilogramName;
    FPluralName : rsReciprocalSquareRootKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuarticRootCubicKilogram }

resourcestring
  rsReciprocalQuarticRootCubicKilogramSymbol = '1/∜%skg³';
  rsReciprocalQuarticRootCubicKilogramName = 'reciprocal quartic root cubic %skilogram';
  rsReciprocalQuarticRootCubicKilogramPluralName = 'reciprocal quartic root cubic %skilogram';

const
  ReciprocalQuarticRootCubicKilogramUnit : TUnit = (
    FDim        : (FKilogram: -45; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticRootCubicKilogramSymbol;
    FName       : rsReciprocalQuarticRootCubicKilogramName;
    FPluralName : rsReciprocalQuarticRootCubicKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootCubicKilogram }

resourcestring
  rsReciprocalSquareRootCubicKilogramSymbol = '1/√%skg³';
  rsReciprocalSquareRootCubicKilogramName = 'reciprocal square root cubic %skilogram';
  rsReciprocalSquareRootCubicKilogramPluralName = 'reciprocal square root cubic %skilogram';

const
  ReciprocalSquareRootCubicKilogramUnit : TUnit = (
    FDim        : (FKilogram: -90; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootCubicKilogramSymbol;
    FName       : rsReciprocalSquareRootCubicKilogramName;
    FPluralName : rsReciprocalSquareRootCubicKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootQuinticKilogram }

resourcestring
  rsReciprocalSquareRootQuinticKilogramSymbol = '1/√%skg⁵';
  rsReciprocalSquareRootQuinticKilogramName = 'reciprocal square root quintic %skilogram';
  rsReciprocalSquareRootQuinticKilogramPluralName = 'reciprocal square root quintic %skilogram';

const
  ReciprocalSquareRootQuinticKilogramUnit : TUnit = (
    FDim        : (FKilogram: -150; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootQuinticKilogramSymbol;
    FName       : rsReciprocalSquareRootQuinticKilogramName;
    FPluralName : rsReciprocalSquareRootQuinticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalCubicKilogram }

resourcestring
  rsReciprocalCubicKilogramSymbol = '1/%skg³';
  rsReciprocalCubicKilogramName = 'reciprocal cubic %skilogram';
  rsReciprocalCubicKilogramPluralName = 'reciprocal cubic %skilogram';

const
  ReciprocalCubicKilogramUnit : TUnit = (
    FDim        : (FKilogram: -180; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicKilogramSymbol;
    FName       : rsReciprocalCubicKilogramName;
    FPluralName : rsReciprocalCubicKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalQuarticKilogram }

resourcestring
  rsReciprocalQuarticKilogramSymbol = '1/%skg⁴';
  rsReciprocalQuarticKilogramName = 'reciprocal quartic %skilogram';
  rsReciprocalQuarticKilogramPluralName = 'reciprocal quartic %skilogram';

const
  ReciprocalQuarticKilogramUnit : TUnit = (
    FDim        : (FKilogram: -240; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticKilogramSymbol;
    FName       : rsReciprocalQuarticKilogramName;
    FPluralName : rsReciprocalQuarticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-4));

{ TReciprocalQuinticKilogram }

resourcestring
  rsReciprocalQuinticKilogramSymbol = '1/%skg⁵';
  rsReciprocalQuinticKilogramName = 'reciprocal quintic %skilogram';
  rsReciprocalQuinticKilogramPluralName = 'reciprocal quintic %skilogram';

const
  ReciprocalQuinticKilogramUnit : TUnit = (
    FDim        : (FKilogram: -300; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuinticKilogramSymbol;
    FName       : rsReciprocalQuinticKilogramName;
    FPluralName : rsReciprocalQuinticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticKilogram }

resourcestring
  rsReciprocalSexticKilogramSymbol = '1/%skg⁶';
  rsReciprocalSexticKilogramName = 'reciprocal sextic %skilogram';
  rsReciprocalSexticKilogramPluralName = 'reciprocal sextic %skilogram';

const
  ReciprocalSexticKilogramUnit : TUnit = (
    FDim        : (FKilogram: -360; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSexticKilogramSymbol;
    FName       : rsReciprocalSexticKilogramName;
    FPluralName : rsReciprocalSexticKilogramPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-6));

{ TReciprocalSexticRootMeter }

resourcestring
  rsReciprocalSexticRootMeterSymbol = '1/⁶√%sm';
  rsReciprocalSexticRootMeterName = 'reciprocal sextic root %smeter';
  rsReciprocalSexticRootMeterPluralName = 'reciprocal sextic root %smeter';

const
  ReciprocalSexticRootMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -10; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSexticRootMeterSymbol;
    FName       : rsReciprocalSexticRootMeterName;
    FPluralName : rsReciprocalSexticRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuinticRootMeter }

resourcestring
  rsReciprocalQuinticRootMeterSymbol = '1/⁵√%sm';
  rsReciprocalQuinticRootMeterName = 'reciprocal quintic root %smeter';
  rsReciprocalQuinticRootMeterPluralName = 'reciprocal quintic root %smeter';

const
  ReciprocalQuinticRootMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -12; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuinticRootMeterSymbol;
    FName       : rsReciprocalQuinticRootMeterName;
    FPluralName : rsReciprocalQuinticRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuarticRootMeter }

resourcestring
  rsReciprocalQuarticRootMeterSymbol = '1/∜%sm';
  rsReciprocalQuarticRootMeterName = 'reciprocal quartic root %smeter';
  rsReciprocalQuarticRootMeterPluralName = 'reciprocal quartic root %smeter';

const
  ReciprocalQuarticRootMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -15; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticRootMeterSymbol;
    FName       : rsReciprocalQuarticRootMeterName;
    FPluralName : rsReciprocalQuarticRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicRootMeter }

resourcestring
  rsReciprocalCubicRootMeterSymbol = '1/∛%sm';
  rsReciprocalCubicRootMeterName = 'reciprocal cubic root %smeter';
  rsReciprocalCubicRootMeterPluralName = 'reciprocal cubic root %smeter';

const
  ReciprocalCubicRootMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -20; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicRootMeterSymbol;
    FName       : rsReciprocalCubicRootMeterName;
    FPluralName : rsReciprocalCubicRootMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuarticRootCubicMeter }

resourcestring
  rsReciprocalQuarticRootCubicMeterSymbol = '1/∜%sm³';
  rsReciprocalQuarticRootCubicMeterName = 'reciprocal quartic root cubic %smeter';
  rsReciprocalQuarticRootCubicMeterPluralName = 'reciprocal quartic root cubic %smeter';

const
  ReciprocalQuarticRootCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -45; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticRootCubicMeterSymbol;
    FName       : rsReciprocalQuarticRootCubicMeterName;
    FPluralName : rsReciprocalQuarticRootCubicMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootQuinticMeter }

resourcestring
  rsReciprocalSquareRootQuinticMeterSymbol = '1/√%sm⁵';
  rsReciprocalSquareRootQuinticMeterName = 'reciprocal square root quintic %smeter';
  rsReciprocalSquareRootQuinticMeterPluralName = 'reciprocal square root quintic %smeter';

const
  ReciprocalSquareRootQuinticMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -150; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootQuinticMeterSymbol;
    FName       : rsReciprocalSquareRootQuinticMeterName;
    FPluralName : rsReciprocalSquareRootQuinticMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticRootSecond }

resourcestring
  rsReciprocalSexticRootSecondSymbol = '1/⁶√%ss';
  rsReciprocalSexticRootSecondName = 'reciprocal sextic root %ssecond';
  rsReciprocalSexticRootSecondPluralName = 'reciprocal sextic root %ssecond';

const
  ReciprocalSexticRootSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -10; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSexticRootSecondSymbol;
    FName       : rsReciprocalSexticRootSecondName;
    FPluralName : rsReciprocalSexticRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuinticRootSecond }

resourcestring
  rsReciprocalQuinticRootSecondSymbol = '1/⁵√%ss';
  rsReciprocalQuinticRootSecondName = 'reciprocal quintic root %ssecond';
  rsReciprocalQuinticRootSecondPluralName = 'reciprocal quintic root %ssecond';

const
  ReciprocalQuinticRootSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -12; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuinticRootSecondSymbol;
    FName       : rsReciprocalQuinticRootSecondName;
    FPluralName : rsReciprocalQuinticRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuarticRootSecond }

resourcestring
  rsReciprocalQuarticRootSecondSymbol = '1/∜%ss';
  rsReciprocalQuarticRootSecondName = 'reciprocal quartic root %ssecond';
  rsReciprocalQuarticRootSecondPluralName = 'reciprocal quartic root %ssecond';

const
  ReciprocalQuarticRootSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -15; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticRootSecondSymbol;
    FName       : rsReciprocalQuarticRootSecondName;
    FPluralName : rsReciprocalQuarticRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicRootSecond }

resourcestring
  rsReciprocalCubicRootSecondSymbol = '1/∛%ss';
  rsReciprocalCubicRootSecondName = 'reciprocal cubic root %ssecond';
  rsReciprocalCubicRootSecondPluralName = 'reciprocal cubic root %ssecond';

const
  ReciprocalCubicRootSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -20; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicRootSecondSymbol;
    FName       : rsReciprocalCubicRootSecondName;
    FPluralName : rsReciprocalCubicRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootSecond }

resourcestring
  rsReciprocalSquareRootSecondSymbol = '1/√%ss';
  rsReciprocalSquareRootSecondName = 'reciprocal square root %ssecond';
  rsReciprocalSquareRootSecondPluralName = 'reciprocal square root %ssecond';

const
  ReciprocalSquareRootSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -30; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootSecondSymbol;
    FName       : rsReciprocalSquareRootSecondName;
    FPluralName : rsReciprocalSquareRootSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuarticRootCubicSecond }

resourcestring
  rsReciprocalQuarticRootCubicSecondSymbol = '1/∜%ss³';
  rsReciprocalQuarticRootCubicSecondName = 'reciprocal quartic root cubic %ssecond';
  rsReciprocalQuarticRootCubicSecondPluralName = 'reciprocal quartic root cubic %ssecond';

const
  ReciprocalQuarticRootCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -45; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticRootCubicSecondSymbol;
    FName       : rsReciprocalQuarticRootCubicSecondName;
    FPluralName : rsReciprocalQuarticRootCubicSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootCubicSecond }

resourcestring
  rsReciprocalSquareRootCubicSecondSymbol = '1/√%ss³';
  rsReciprocalSquareRootCubicSecondName = 'reciprocal square root cubic %ssecond';
  rsReciprocalSquareRootCubicSecondPluralName = 'reciprocal square root cubic %ssecond';

const
  ReciprocalSquareRootCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -90; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootCubicSecondSymbol;
    FName       : rsReciprocalSquareRootCubicSecondName;
    FPluralName : rsReciprocalSquareRootCubicSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootQuinticSecond }

resourcestring
  rsReciprocalSquareRootQuinticSecondSymbol = '1/√%ss⁵';
  rsReciprocalSquareRootQuinticSecondName = 'reciprocal square root quintic %ssecond';
  rsReciprocalSquareRootQuinticSecondPluralName = 'reciprocal square root quintic %ssecond';

const
  ReciprocalSquareRootQuinticSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -150; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootQuinticSecondSymbol;
    FName       : rsReciprocalSquareRootQuinticSecondName;
    FPluralName : rsReciprocalSquareRootQuinticSecondPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticRootAmpere }

resourcestring
  rsReciprocalSexticRootAmpereSymbol = '1/⁶√%sA';
  rsReciprocalSexticRootAmpereName = 'reciprocal sextic root %sampere';
  rsReciprocalSexticRootAmperePluralName = 'reciprocal sextic root %sampere';

const
  ReciprocalSexticRootAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -10; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSexticRootAmpereSymbol;
    FName       : rsReciprocalSexticRootAmpereName;
    FPluralName : rsReciprocalSexticRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuinticRootAmpere }

resourcestring
  rsReciprocalQuinticRootAmpereSymbol = '1/⁵√%sA';
  rsReciprocalQuinticRootAmpereName = 'reciprocal quintic root %sampere';
  rsReciprocalQuinticRootAmperePluralName = 'reciprocal quintic root %sampere';

const
  ReciprocalQuinticRootAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -12; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuinticRootAmpereSymbol;
    FName       : rsReciprocalQuinticRootAmpereName;
    FPluralName : rsReciprocalQuinticRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuarticRootAmpere }

resourcestring
  rsReciprocalQuarticRootAmpereSymbol = '1/∜%sA';
  rsReciprocalQuarticRootAmpereName = 'reciprocal quartic root %sampere';
  rsReciprocalQuarticRootAmperePluralName = 'reciprocal quartic root %sampere';

const
  ReciprocalQuarticRootAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -15; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticRootAmpereSymbol;
    FName       : rsReciprocalQuarticRootAmpereName;
    FPluralName : rsReciprocalQuarticRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicRootAmpere }

resourcestring
  rsReciprocalCubicRootAmpereSymbol = '1/∛%sA';
  rsReciprocalCubicRootAmpereName = 'reciprocal cubic root %sampere';
  rsReciprocalCubicRootAmperePluralName = 'reciprocal cubic root %sampere';

const
  ReciprocalCubicRootAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -20; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicRootAmpereSymbol;
    FName       : rsReciprocalCubicRootAmpereName;
    FPluralName : rsReciprocalCubicRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootAmpere }

resourcestring
  rsReciprocalSquareRootAmpereSymbol = '1/√%sA';
  rsReciprocalSquareRootAmpereName = 'reciprocal square root %sampere';
  rsReciprocalSquareRootAmperePluralName = 'reciprocal square root %sampere';

const
  ReciprocalSquareRootAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -30; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootAmpereSymbol;
    FName       : rsReciprocalSquareRootAmpereName;
    FPluralName : rsReciprocalSquareRootAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuarticRootCubicAmpere }

resourcestring
  rsReciprocalQuarticRootCubicAmpereSymbol = '1/∜%sA³';
  rsReciprocalQuarticRootCubicAmpereName = 'reciprocal quartic root cubic %sampere';
  rsReciprocalQuarticRootCubicAmperePluralName = 'reciprocal quartic root cubic %sampere';

const
  ReciprocalQuarticRootCubicAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -45; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticRootCubicAmpereSymbol;
    FName       : rsReciprocalQuarticRootCubicAmpereName;
    FPluralName : rsReciprocalQuarticRootCubicAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootCubicAmpere }

resourcestring
  rsReciprocalSquareRootCubicAmpereSymbol = '1/√%sA³';
  rsReciprocalSquareRootCubicAmpereName = 'reciprocal square root cubic %sampere';
  rsReciprocalSquareRootCubicAmperePluralName = 'reciprocal square root cubic %sampere';

const
  ReciprocalSquareRootCubicAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -90; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootCubicAmpereSymbol;
    FName       : rsReciprocalSquareRootCubicAmpereName;
    FPluralName : rsReciprocalSquareRootCubicAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootQuinticAmpere }

resourcestring
  rsReciprocalSquareRootQuinticAmpereSymbol = '1/√%sA⁵';
  rsReciprocalSquareRootQuinticAmpereName = 'reciprocal square root quintic %sampere';
  rsReciprocalSquareRootQuinticAmperePluralName = 'reciprocal square root quintic %sampere';

const
  ReciprocalSquareRootQuinticAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -150; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootQuinticAmpereSymbol;
    FName       : rsReciprocalSquareRootQuinticAmpereName;
    FPluralName : rsReciprocalSquareRootQuinticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalCubicAmpere }

resourcestring
  rsReciprocalCubicAmpereSymbol = '1/%sA³';
  rsReciprocalCubicAmpereName = 'reciprocal cubic %sampere';
  rsReciprocalCubicAmperePluralName = 'reciprocal cubic %sampere';

const
  ReciprocalCubicAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -180; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicAmpereSymbol;
    FName       : rsReciprocalCubicAmpereName;
    FPluralName : rsReciprocalCubicAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalQuarticAmpere }

resourcestring
  rsReciprocalQuarticAmpereSymbol = '1/%sA⁴';
  rsReciprocalQuarticAmpereName = 'reciprocal quartic %sampere';
  rsReciprocalQuarticAmperePluralName = 'reciprocal quartic %sampere';

const
  ReciprocalQuarticAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -240; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticAmpereSymbol;
    FName       : rsReciprocalQuarticAmpereName;
    FPluralName : rsReciprocalQuarticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-4));

{ TReciprocalQuinticAmpere }

resourcestring
  rsReciprocalQuinticAmpereSymbol = '1/%sA⁵';
  rsReciprocalQuinticAmpereName = 'reciprocal quintic %sampere';
  rsReciprocalQuinticAmperePluralName = 'reciprocal quintic %sampere';

const
  ReciprocalQuinticAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -300; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuinticAmpereSymbol;
    FName       : rsReciprocalQuinticAmpereName;
    FPluralName : rsReciprocalQuinticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticAmpere }

resourcestring
  rsReciprocalSexticAmpereSymbol = '1/%sA⁶';
  rsReciprocalSexticAmpereName = 'reciprocal sextic %sampere';
  rsReciprocalSexticAmperePluralName = 'reciprocal sextic %sampere';

const
  ReciprocalSexticAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -360; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSexticAmpereSymbol;
    FName       : rsReciprocalSexticAmpereName;
    FPluralName : rsReciprocalSexticAmperePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-6));

{ TReciprocalSexticRootKelvin }

resourcestring
  rsReciprocalSexticRootKelvinSymbol = '1/⁶√%sK';
  rsReciprocalSexticRootKelvinName = 'reciprocal sextic root %skelvin';
  rsReciprocalSexticRootKelvinPluralName = 'reciprocal sextic root %skelvin';

const
  ReciprocalSexticRootKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -10; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSexticRootKelvinSymbol;
    FName       : rsReciprocalSexticRootKelvinName;
    FPluralName : rsReciprocalSexticRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuinticRootKelvin }

resourcestring
  rsReciprocalQuinticRootKelvinSymbol = '1/⁵√%sK';
  rsReciprocalQuinticRootKelvinName = 'reciprocal quintic root %skelvin';
  rsReciprocalQuinticRootKelvinPluralName = 'reciprocal quintic root %skelvin';

const
  ReciprocalQuinticRootKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -12; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuinticRootKelvinSymbol;
    FName       : rsReciprocalQuinticRootKelvinName;
    FPluralName : rsReciprocalQuinticRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuarticRootKelvin }

resourcestring
  rsReciprocalQuarticRootKelvinSymbol = '1/∜%sK';
  rsReciprocalQuarticRootKelvinName = 'reciprocal quartic root %skelvin';
  rsReciprocalQuarticRootKelvinPluralName = 'reciprocal quartic root %skelvin';

const
  ReciprocalQuarticRootKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -15; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticRootKelvinSymbol;
    FName       : rsReciprocalQuarticRootKelvinName;
    FPluralName : rsReciprocalQuarticRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicRootKelvin }

resourcestring
  rsReciprocalCubicRootKelvinSymbol = '1/∛%sK';
  rsReciprocalCubicRootKelvinName = 'reciprocal cubic root %skelvin';
  rsReciprocalCubicRootKelvinPluralName = 'reciprocal cubic root %skelvin';

const
  ReciprocalCubicRootKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -20; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicRootKelvinSymbol;
    FName       : rsReciprocalCubicRootKelvinName;
    FPluralName : rsReciprocalCubicRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootKelvin }

resourcestring
  rsReciprocalSquareRootKelvinSymbol = '1/√%sK';
  rsReciprocalSquareRootKelvinName = 'reciprocal square root %skelvin';
  rsReciprocalSquareRootKelvinPluralName = 'reciprocal square root %skelvin';

const
  ReciprocalSquareRootKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -30; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootKelvinSymbol;
    FName       : rsReciprocalSquareRootKelvinName;
    FPluralName : rsReciprocalSquareRootKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuarticRootCubicKelvin }

resourcestring
  rsReciprocalQuarticRootCubicKelvinSymbol = '1/∜%sK³';
  rsReciprocalQuarticRootCubicKelvinName = 'reciprocal quartic root cubic %skelvin';
  rsReciprocalQuarticRootCubicKelvinPluralName = 'reciprocal quartic root cubic %skelvin';

const
  ReciprocalQuarticRootCubicKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -45; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticRootCubicKelvinSymbol;
    FName       : rsReciprocalQuarticRootCubicKelvinName;
    FPluralName : rsReciprocalQuarticRootCubicKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootCubicKelvin }

resourcestring
  rsReciprocalSquareRootCubicKelvinSymbol = '1/√%sK³';
  rsReciprocalSquareRootCubicKelvinName = 'reciprocal square root cubic %skelvin';
  rsReciprocalSquareRootCubicKelvinPluralName = 'reciprocal square root cubic %skelvin';

const
  ReciprocalSquareRootCubicKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -90; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootCubicKelvinSymbol;
    FName       : rsReciprocalSquareRootCubicKelvinName;
    FPluralName : rsReciprocalSquareRootCubicKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootQuinticKelvin }

resourcestring
  rsReciprocalSquareRootQuinticKelvinSymbol = '1/√%sK⁵';
  rsReciprocalSquareRootQuinticKelvinName = 'reciprocal square root quintic %skelvin';
  rsReciprocalSquareRootQuinticKelvinPluralName = 'reciprocal square root quintic %skelvin';

const
  ReciprocalSquareRootQuinticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -150; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootQuinticKelvinSymbol;
    FName       : rsReciprocalSquareRootQuinticKelvinName;
    FPluralName : rsReciprocalSquareRootQuinticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalQuinticKelvin }

resourcestring
  rsReciprocalQuinticKelvinSymbol = '1/%sK⁵';
  rsReciprocalQuinticKelvinName = 'reciprocal quintic %skelvin';
  rsReciprocalQuinticKelvinPluralName = 'reciprocal quintic %skelvin';

const
  ReciprocalQuinticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -300; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuinticKelvinSymbol;
    FName       : rsReciprocalQuinticKelvinName;
    FPluralName : rsReciprocalQuinticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticKelvin }

resourcestring
  rsReciprocalSexticKelvinSymbol = '1/%sK⁶';
  rsReciprocalSexticKelvinName = 'reciprocal sextic %skelvin';
  rsReciprocalSexticKelvinPluralName = 'reciprocal sextic %skelvin';

const
  ReciprocalSexticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: -360; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSexticKelvinSymbol;
    FName       : rsReciprocalSexticKelvinName;
    FPluralName : rsReciprocalSexticKelvinPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-6));

{ TReciprocalSexticRootMole }

resourcestring
  rsReciprocalSexticRootMoleSymbol = '1/⁶√%smol';
  rsReciprocalSexticRootMoleName = 'reciprocal sextic root %smole';
  rsReciprocalSexticRootMolePluralName = 'reciprocal sextic root %smole';

const
  ReciprocalSexticRootMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -10; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSexticRootMoleSymbol;
    FName       : rsReciprocalSexticRootMoleName;
    FPluralName : rsReciprocalSexticRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuinticRootMole }

resourcestring
  rsReciprocalQuinticRootMoleSymbol = '1/⁵√%smol';
  rsReciprocalQuinticRootMoleName = 'reciprocal quintic root %smole';
  rsReciprocalQuinticRootMolePluralName = 'reciprocal quintic root %smole';

const
  ReciprocalQuinticRootMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -12; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuinticRootMoleSymbol;
    FName       : rsReciprocalQuinticRootMoleName;
    FPluralName : rsReciprocalQuinticRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuarticRootMole }

resourcestring
  rsReciprocalQuarticRootMoleSymbol = '1/∜%smol';
  rsReciprocalQuarticRootMoleName = 'reciprocal quartic root %smole';
  rsReciprocalQuarticRootMolePluralName = 'reciprocal quartic root %smole';

const
  ReciprocalQuarticRootMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -15; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticRootMoleSymbol;
    FName       : rsReciprocalQuarticRootMoleName;
    FPluralName : rsReciprocalQuarticRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicRootMole }

resourcestring
  rsReciprocalCubicRootMoleSymbol = '1/∛%smol';
  rsReciprocalCubicRootMoleName = 'reciprocal cubic root %smole';
  rsReciprocalCubicRootMolePluralName = 'reciprocal cubic root %smole';

const
  ReciprocalCubicRootMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -20; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicRootMoleSymbol;
    FName       : rsReciprocalCubicRootMoleName;
    FPluralName : rsReciprocalCubicRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootMole }

resourcestring
  rsReciprocalSquareRootMoleSymbol = '1/√%smol';
  rsReciprocalSquareRootMoleName = 'reciprocal square root %smole';
  rsReciprocalSquareRootMolePluralName = 'reciprocal square root %smole';

const
  ReciprocalSquareRootMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -30; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootMoleSymbol;
    FName       : rsReciprocalSquareRootMoleName;
    FPluralName : rsReciprocalSquareRootMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuarticRootCubicMole }

resourcestring
  rsReciprocalQuarticRootCubicMoleSymbol = '1/∜%smol³';
  rsReciprocalQuarticRootCubicMoleName = 'reciprocal quartic root cubic %smole';
  rsReciprocalQuarticRootCubicMolePluralName = 'reciprocal quartic root cubic %smole';

const
  ReciprocalQuarticRootCubicMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -45; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticRootCubicMoleSymbol;
    FName       : rsReciprocalQuarticRootCubicMoleName;
    FPluralName : rsReciprocalQuarticRootCubicMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootCubicMole }

resourcestring
  rsReciprocalSquareRootCubicMoleSymbol = '1/√%smol³';
  rsReciprocalSquareRootCubicMoleName = 'reciprocal square root cubic %smole';
  rsReciprocalSquareRootCubicMolePluralName = 'reciprocal square root cubic %smole';

const
  ReciprocalSquareRootCubicMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -90; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootCubicMoleSymbol;
    FName       : rsReciprocalSquareRootCubicMoleName;
    FPluralName : rsReciprocalSquareRootCubicMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareMole }

resourcestring
  rsReciprocalSquareMoleSymbol = '1/%smol²';
  rsReciprocalSquareMoleName = 'reciprocal square %smole';
  rsReciprocalSquareMolePluralName = 'reciprocal square %smole';

const
  ReciprocalSquareMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -120; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareMoleSymbol;
    FName       : rsReciprocalSquareMoleName;
    FPluralName : rsReciprocalSquareMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TReciprocalSquareRootQuinticMole }

resourcestring
  rsReciprocalSquareRootQuinticMoleSymbol = '1/√%smol⁵';
  rsReciprocalSquareRootQuinticMoleName = 'reciprocal square root quintic %smole';
  rsReciprocalSquareRootQuinticMolePluralName = 'reciprocal square root quintic %smole';

const
  ReciprocalSquareRootQuinticMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -150; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootQuinticMoleSymbol;
    FName       : rsReciprocalSquareRootQuinticMoleName;
    FPluralName : rsReciprocalSquareRootQuinticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalCubicMole }

resourcestring
  rsReciprocalCubicMoleSymbol = '1/%smol³';
  rsReciprocalCubicMoleName = 'reciprocal cubic %smole';
  rsReciprocalCubicMolePluralName = 'reciprocal cubic %smole';

const
  ReciprocalCubicMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -180; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalCubicMoleSymbol;
    FName       : rsReciprocalCubicMoleName;
    FPluralName : rsReciprocalCubicMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalQuarticMole }

resourcestring
  rsReciprocalQuarticMoleSymbol = '1/%smol⁴';
  rsReciprocalQuarticMoleName = 'reciprocal quartic %smole';
  rsReciprocalQuarticMolePluralName = 'reciprocal quartic %smole';

const
  ReciprocalQuarticMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -240; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticMoleSymbol;
    FName       : rsReciprocalQuarticMoleName;
    FPluralName : rsReciprocalQuarticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-4));

{ TReciprocalQuinticMole }

resourcestring
  rsReciprocalQuinticMoleSymbol = '1/%smol⁵';
  rsReciprocalQuinticMoleName = 'reciprocal quintic %smole';
  rsReciprocalQuinticMolePluralName = 'reciprocal quintic %smole';

const
  ReciprocalQuinticMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -300; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalQuinticMoleSymbol;
    FName       : rsReciprocalQuinticMoleName;
    FPluralName : rsReciprocalQuinticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticMole }

resourcestring
  rsReciprocalSexticMoleSymbol = '1/%smol⁶';
  rsReciprocalSexticMoleName = 'reciprocal sextic %smole';
  rsReciprocalSexticMolePluralName = 'reciprocal sextic %smole';

const
  ReciprocalSexticMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: -360; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSexticMoleSymbol;
    FName       : rsReciprocalSexticMoleName;
    FPluralName : rsReciprocalSexticMolePluralName;
    FPrefixes   : (pNone);
    FExponents  : (-6));

{ TReciprocalSexticRootCandela }

resourcestring
  rsReciprocalSexticRootCandelaSymbol = '1/⁶√%scd';
  rsReciprocalSexticRootCandelaName = 'reciprocal sextic root %scandela';
  rsReciprocalSexticRootCandelaPluralName = 'reciprocal sextic root %scandela';

const
  ReciprocalSexticRootCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -10; FSteradian: 0);
    FSymbol     : rsReciprocalSexticRootCandelaSymbol;
    FName       : rsReciprocalSexticRootCandelaName;
    FPluralName : rsReciprocalSexticRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuinticRootCandela }

resourcestring
  rsReciprocalQuinticRootCandelaSymbol = '1/⁵√%scd';
  rsReciprocalQuinticRootCandelaName = 'reciprocal quintic root %scandela';
  rsReciprocalQuinticRootCandelaPluralName = 'reciprocal quintic root %scandela';

const
  ReciprocalQuinticRootCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -12; FSteradian: 0);
    FSymbol     : rsReciprocalQuinticRootCandelaSymbol;
    FName       : rsReciprocalQuinticRootCandelaName;
    FPluralName : rsReciprocalQuinticRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuarticRootCandela }

resourcestring
  rsReciprocalQuarticRootCandelaSymbol = '1/∜%scd';
  rsReciprocalQuarticRootCandelaName = 'reciprocal quartic root %scandela';
  rsReciprocalQuarticRootCandelaPluralName = 'reciprocal quartic root %scandela';

const
  ReciprocalQuarticRootCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -15; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticRootCandelaSymbol;
    FName       : rsReciprocalQuarticRootCandelaName;
    FPluralName : rsReciprocalQuarticRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicRootCandela }

resourcestring
  rsReciprocalCubicRootCandelaSymbol = '1/∛%scd';
  rsReciprocalCubicRootCandelaName = 'reciprocal cubic root %scandela';
  rsReciprocalCubicRootCandelaPluralName = 'reciprocal cubic root %scandela';

const
  ReciprocalCubicRootCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -20; FSteradian: 0);
    FSymbol     : rsReciprocalCubicRootCandelaSymbol;
    FName       : rsReciprocalCubicRootCandelaName;
    FPluralName : rsReciprocalCubicRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSquareRootCandela }

resourcestring
  rsReciprocalSquareRootCandelaSymbol = '1/√%scd';
  rsReciprocalSquareRootCandelaName = 'reciprocal square root %scandela';
  rsReciprocalSquareRootCandelaPluralName = 'reciprocal square root %scandela';

const
  ReciprocalSquareRootCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -30; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootCandelaSymbol;
    FName       : rsReciprocalSquareRootCandelaName;
    FPluralName : rsReciprocalSquareRootCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalQuarticRootCubicCandela }

resourcestring
  rsReciprocalQuarticRootCubicCandelaSymbol = '1/∜%scd³';
  rsReciprocalQuarticRootCubicCandelaName = 'reciprocal quartic root cubic %scandela';
  rsReciprocalQuarticRootCubicCandelaPluralName = 'reciprocal quartic root cubic %scandela';

const
  ReciprocalQuarticRootCubicCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -45; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticRootCubicCandelaSymbol;
    FName       : rsReciprocalQuarticRootCubicCandelaName;
    FPluralName : rsReciprocalQuarticRootCubicCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareRootCubicCandela }

resourcestring
  rsReciprocalSquareRootCubicCandelaSymbol = '1/√%scd³';
  rsReciprocalSquareRootCubicCandelaName = 'reciprocal square root cubic %scandela';
  rsReciprocalSquareRootCubicCandelaPluralName = 'reciprocal square root cubic %scandela';

const
  ReciprocalSquareRootCubicCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -90; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootCubicCandelaSymbol;
    FName       : rsReciprocalSquareRootCubicCandelaName;
    FPluralName : rsReciprocalSquareRootCubicCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalSquareCandela }

resourcestring
  rsReciprocalSquareCandelaSymbol = '1/%scd²';
  rsReciprocalSquareCandelaName = 'reciprocal square %scandela';
  rsReciprocalSquareCandelaPluralName = 'reciprocal square %scandela';

const
  ReciprocalSquareCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -120; FSteradian: 0);
    FSymbol     : rsReciprocalSquareCandelaSymbol;
    FName       : rsReciprocalSquareCandelaName;
    FPluralName : rsReciprocalSquareCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-2));

{ TReciprocalSquareRootQuinticCandela }

resourcestring
  rsReciprocalSquareRootQuinticCandelaSymbol = '1/√%scd⁵';
  rsReciprocalSquareRootQuinticCandelaName = 'reciprocal square root quintic %scandela';
  rsReciprocalSquareRootQuinticCandelaPluralName = 'reciprocal square root quintic %scandela';

const
  ReciprocalSquareRootQuinticCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -150; FSteradian: 0);
    FSymbol     : rsReciprocalSquareRootQuinticCandelaSymbol;
    FName       : rsReciprocalSquareRootQuinticCandelaName;
    FPluralName : rsReciprocalSquareRootQuinticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalCubicCandela }

resourcestring
  rsReciprocalCubicCandelaSymbol = '1/%scd³';
  rsReciprocalCubicCandelaName = 'reciprocal cubic %scandela';
  rsReciprocalCubicCandelaPluralName = 'reciprocal cubic %scandela';

const
  ReciprocalCubicCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -180; FSteradian: 0);
    FSymbol     : rsReciprocalCubicCandelaSymbol;
    FName       : rsReciprocalCubicCandelaName;
    FPluralName : rsReciprocalCubicCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-3));

{ TReciprocalQuarticCandela }

resourcestring
  rsReciprocalQuarticCandelaSymbol = '1/%scd⁴';
  rsReciprocalQuarticCandelaName = 'reciprocal quartic %scandela';
  rsReciprocalQuarticCandelaPluralName = 'reciprocal quartic %scandela';

const
  ReciprocalQuarticCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -240; FSteradian: 0);
    FSymbol     : rsReciprocalQuarticCandelaSymbol;
    FName       : rsReciprocalQuarticCandelaName;
    FPluralName : rsReciprocalQuarticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-4));

{ TReciprocalQuinticCandela }

resourcestring
  rsReciprocalQuinticCandelaSymbol = '1/%scd⁵';
  rsReciprocalQuinticCandelaName = 'reciprocal quintic %scandela';
  rsReciprocalQuinticCandelaPluralName = 'reciprocal quintic %scandela';

const
  ReciprocalQuinticCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -300; FSteradian: 0);
    FSymbol     : rsReciprocalQuinticCandelaSymbol;
    FName       : rsReciprocalQuinticCandelaName;
    FPluralName : rsReciprocalQuinticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-5));

{ TReciprocalSexticCandela }

resourcestring
  rsReciprocalSexticCandelaSymbol = '1/%scd⁶';
  rsReciprocalSexticCandelaName = 'reciprocal sextic %scandela';
  rsReciprocalSexticCandelaPluralName = 'reciprocal sextic %scandela';

const
  ReciprocalSexticCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -360; FSteradian: 0);
    FSymbol     : rsReciprocalSexticCandelaSymbol;
    FName       : rsReciprocalSexticCandelaName;
    FPluralName : rsReciprocalSexticCandelaPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-6));

{ TReciprocalSexticRootSteradian }

resourcestring
  rsReciprocalSexticRootSteradianSymbol = '1/⁶√sr';
  rsReciprocalSexticRootSteradianName = 'reciprocal sextic root steradian';
  rsReciprocalSexticRootSteradianPluralName = 'reciprocal sextic root steradian';

const
  ReciprocalSexticRootSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -10);
    FSymbol     : rsReciprocalSexticRootSteradianSymbol;
    FName       : rsReciprocalSexticRootSteradianName;
    FPluralName : rsReciprocalSexticRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalQuinticRootSteradian }

resourcestring
  rsReciprocalQuinticRootSteradianSymbol = '1/⁵√sr';
  rsReciprocalQuinticRootSteradianName = 'reciprocal quintic root steradian';
  rsReciprocalQuinticRootSteradianPluralName = 'reciprocal quintic root steradian';

const
  ReciprocalQuinticRootSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -12);
    FSymbol     : rsReciprocalQuinticRootSteradianSymbol;
    FName       : rsReciprocalQuinticRootSteradianName;
    FPluralName : rsReciprocalQuinticRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalQuarticRootSteradian }

resourcestring
  rsReciprocalQuarticRootSteradianSymbol = '1/∜sr';
  rsReciprocalQuarticRootSteradianName = 'reciprocal quartic root steradian';
  rsReciprocalQuarticRootSteradianPluralName = 'reciprocal quartic root steradian';

const
  ReciprocalQuarticRootSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -15);
    FSymbol     : rsReciprocalQuarticRootSteradianSymbol;
    FName       : rsReciprocalQuarticRootSteradianName;
    FPluralName : rsReciprocalQuarticRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalCubicRootSteradian }

resourcestring
  rsReciprocalCubicRootSteradianSymbol = '1/∛sr';
  rsReciprocalCubicRootSteradianName = 'reciprocal cubic root steradian';
  rsReciprocalCubicRootSteradianPluralName = 'reciprocal cubic root steradian';

const
  ReciprocalCubicRootSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -20);
    FSymbol     : rsReciprocalCubicRootSteradianSymbol;
    FName       : rsReciprocalCubicRootSteradianName;
    FPluralName : rsReciprocalCubicRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalSquareRootSteradian }

resourcestring
  rsReciprocalSquareRootSteradianSymbol = '1/√sr';
  rsReciprocalSquareRootSteradianName = 'reciprocal square root steradian';
  rsReciprocalSquareRootSteradianPluralName = 'reciprocal square root steradian';

const
  ReciprocalSquareRootSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -30);
    FSymbol     : rsReciprocalSquareRootSteradianSymbol;
    FName       : rsReciprocalSquareRootSteradianName;
    FPluralName : rsReciprocalSquareRootSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalQuarticRootCubicSteradian }

resourcestring
  rsReciprocalQuarticRootCubicSteradianSymbol = '1/∜sr³';
  rsReciprocalQuarticRootCubicSteradianName = 'reciprocal quartic root cubic steradian';
  rsReciprocalQuarticRootCubicSteradianPluralName = 'reciprocal quartic root cubic steradian';

const
  ReciprocalQuarticRootCubicSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -45);
    FSymbol     : rsReciprocalQuarticRootCubicSteradianSymbol;
    FName       : rsReciprocalQuarticRootCubicSteradianName;
    FPluralName : rsReciprocalQuarticRootCubicSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalSquareRootCubicSteradian }

resourcestring
  rsReciprocalSquareRootCubicSteradianSymbol = '1/√sr³';
  rsReciprocalSquareRootCubicSteradianName = 'reciprocal square root cubic steradian';
  rsReciprocalSquareRootCubicSteradianPluralName = 'reciprocal square root cubic steradian';

const
  ReciprocalSquareRootCubicSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -90);
    FSymbol     : rsReciprocalSquareRootCubicSteradianSymbol;
    FName       : rsReciprocalSquareRootCubicSteradianName;
    FPluralName : rsReciprocalSquareRootCubicSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalSquareSteradian }

resourcestring
  rsReciprocalSquareSteradianSymbol = '1/sr²';
  rsReciprocalSquareSteradianName = 'reciprocal square steradian';
  rsReciprocalSquareSteradianPluralName = 'reciprocal square steradian';

const
  ReciprocalSquareSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -120);
    FSymbol     : rsReciprocalSquareSteradianSymbol;
    FName       : rsReciprocalSquareSteradianName;
    FPluralName : rsReciprocalSquareSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalSquareRootQuinticSteradian }

resourcestring
  rsReciprocalSquareRootQuinticSteradianSymbol = '1/√sr⁵';
  rsReciprocalSquareRootQuinticSteradianName = 'reciprocal square root quintic steradian';
  rsReciprocalSquareRootQuinticSteradianPluralName = 'reciprocal square root quintic steradian';

const
  ReciprocalSquareRootQuinticSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -150);
    FSymbol     : rsReciprocalSquareRootQuinticSteradianSymbol;
    FName       : rsReciprocalSquareRootQuinticSteradianName;
    FPluralName : rsReciprocalSquareRootQuinticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalCubicSteradian }

resourcestring
  rsReciprocalCubicSteradianSymbol = '1/sr³';
  rsReciprocalCubicSteradianName = 'reciprocal cubic steradian';
  rsReciprocalCubicSteradianPluralName = 'reciprocal cubic steradian';

const
  ReciprocalCubicSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -180);
    FSymbol     : rsReciprocalCubicSteradianSymbol;
    FName       : rsReciprocalCubicSteradianName;
    FPluralName : rsReciprocalCubicSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalQuarticSteradian }

resourcestring
  rsReciprocalQuarticSteradianSymbol = '1/sr⁴';
  rsReciprocalQuarticSteradianName = 'reciprocal quartic steradian';
  rsReciprocalQuarticSteradianPluralName = 'reciprocal quartic steradian';

const
  ReciprocalQuarticSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -240);
    FSymbol     : rsReciprocalQuarticSteradianSymbol;
    FName       : rsReciprocalQuarticSteradianName;
    FPluralName : rsReciprocalQuarticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalQuinticSteradian }

resourcestring
  rsReciprocalQuinticSteradianSymbol = '1/sr⁵';
  rsReciprocalQuinticSteradianName = 'reciprocal quintic steradian';
  rsReciprocalQuinticSteradianPluralName = 'reciprocal quintic steradian';

const
  ReciprocalQuinticSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -300);
    FSymbol     : rsReciprocalQuinticSteradianSymbol;
    FName       : rsReciprocalQuinticSteradianName;
    FPluralName : rsReciprocalQuinticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalSexticSteradian }

resourcestring
  rsReciprocalSexticSteradianSymbol = '1/sr⁶';
  rsReciprocalSexticSteradianName = 'reciprocal sextic steradian';
  rsReciprocalSexticSteradianPluralName = 'reciprocal sextic steradian';

const
  ReciprocalSexticSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -360);
    FSymbol     : rsReciprocalSexticSteradianSymbol;
    FName       : rsReciprocalSexticSteradianName;
    FPluralName : rsReciprocalSexticSteradianPluralName;
    FPrefixes   : ();
    FExponents  : ());

{ TReciprocalSquareKilogramSquareMeter }

resourcestring
  rsReciprocalSquareKilogramSquareMeterSymbol = '1/%skg²/%sm²';
  rsReciprocalSquareKilogramSquareMeterName = 'reciprocal square %skilogram square %smeter';
  rsReciprocalSquareKilogramSquareMeterPluralName = 'reciprocal square %skilogram square %smeter';

const
  ReciprocalSquareKilogramSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareKilogramSquareMeterSymbol;
    FName       : rsReciprocalSquareKilogramSquareMeterName;
    FPluralName : rsReciprocalSquareKilogramSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -2));

{ TQuarticSecondPerSquareKilogram }

resourcestring
  rsQuarticSecondPerSquareKilogramSymbol = '%ss⁴/%skg²';
  rsQuarticSecondPerSquareKilogramName = 'quartic %ssecond per square %skilogram';
  rsQuarticSecondPerSquareKilogramPluralName = 'quartic %sseconds per square %skilogram';

const
  QuarticSecondPerSquareKilogramUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: 0; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondPerSquareKilogramSymbol;
    FName       : rsQuarticSecondPerSquareKilogramName;
    FPluralName : rsQuarticSecondPerSquareKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -2));

{ TReciprocalMeterAmpere }

resourcestring
  rsReciprocalMeterAmpereSymbol = '1/%sm/%sA';
  rsReciprocalMeterAmpereName = 'reciprocal %smeter %sampere';
  rsReciprocalMeterAmperePluralName = 'reciprocal %smeter %sampere';

const
  ReciprocalMeterAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 0; FAmpere: -60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalMeterAmpereSymbol;
    FName       : rsReciprocalMeterAmpereName;
    FPluralName : rsReciprocalMeterAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TCubicSecondAmperePerSquareMeter }

resourcestring
  rsCubicSecondAmperePerSquareMeterSymbol = '%ss³∙%sA/%sm²';
  rsCubicSecondAmperePerSquareMeterName = 'cubic %ssecond %sampere per square %smeter';
  rsCubicSecondAmperePerSquareMeterPluralName = 'cubic %sseconds %samperes per square %smeter';

const
  CubicSecondAmperePerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 180; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondAmperePerSquareMeterSymbol;
    FName       : rsCubicSecondAmperePerSquareMeterName;
    FPluralName : rsCubicSecondAmperePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -2));

{ TSexticSecondSquareAmperePerQuarticMeter }

resourcestring
  rsSexticSecondSquareAmperePerQuarticMeterSymbol = '%ss⁶∙%sA²/%sm⁴';
  rsSexticSecondSquareAmperePerQuarticMeterName = 'sextic %ssecond square %sampere per quartic %smeter';
  rsSexticSecondSquareAmperePerQuarticMeterPluralName = 'sextic %sseconds square %samperes per quartic %smeter';

const
  SexticSecondSquareAmperePerQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -240; FSecond: 360; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticSecondSquareAmperePerQuarticMeterSymbol;
    FName       : rsSexticSecondSquareAmperePerQuarticMeterName;
    FPluralName : rsSexticSecondSquareAmperePerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (6, 2, -4));

{ TSexticSecondSquareAmperePerSquareKilogram }

resourcestring
  rsSexticSecondSquareAmperePerSquareKilogramSymbol = '%ss⁶∙%sA²/%skg²';
  rsSexticSecondSquareAmperePerSquareKilogramName = 'sextic %ssecond square %sampere per square %skilogram';
  rsSexticSecondSquareAmperePerSquareKilogramPluralName = 'sextic %sseconds square %samperes per square %skilogram';

const
  SexticSecondSquareAmperePerSquareKilogramUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: 0; FSecond: 360; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticSecondSquareAmperePerSquareKilogramSymbol;
    FName       : rsSexticSecondSquareAmperePerSquareKilogramName;
    FPluralName : rsSexticSecondSquareAmperePerSquareKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (6, 2, -2));

{ TSquareAmperePerSquareKilogramPerQuarticMeter }

resourcestring
  rsSquareAmperePerSquareKilogramPerQuarticMeterSymbol = '%sA²/%skg²/%sm⁴';
  rsSquareAmperePerSquareKilogramPerQuarticMeterName = 'square %sampere per square %skilogram per quartic %smeter';
  rsSquareAmperePerSquareKilogramPerQuarticMeterPluralName = 'square %samperes per square %skilogram per quartic %smeter';

const
  SquareAmperePerSquareKilogramPerQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: -240; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareAmperePerSquareKilogramPerQuarticMeterSymbol;
    FName       : rsSquareAmperePerSquareKilogramPerQuarticMeterName;
    FPluralName : rsSquareAmperePerSquareKilogramPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -2, -4));

{ TSexticSecondPerSquareKilogramPerQuarticMeter }

resourcestring
  rsSexticSecondPerSquareKilogramPerQuarticMeterSymbol = '%ss⁶/%skg²/%sm⁴';
  rsSexticSecondPerSquareKilogramPerQuarticMeterName = 'sextic %ssecond per square %skilogram per quartic %smeter';
  rsSexticSecondPerSquareKilogramPerQuarticMeterPluralName = 'sextic %sseconds per square %skilogram per quartic %smeter';

const
  SexticSecondPerSquareKilogramPerQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: -240; FSecond: 360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticSecondPerSquareKilogramPerQuarticMeterSymbol;
    FName       : rsSexticSecondPerSquareKilogramPerQuarticMeterName;
    FPluralName : rsSexticSecondPerSquareKilogramPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (6, -2, -4));

{ TSquareMeterPerQuarticSecondPerSquareAmpere }

resourcestring
  rsSquareMeterPerQuarticSecondPerSquareAmpereSymbol = '%sm²/%ss⁴/%sA²';
  rsSquareMeterPerQuarticSecondPerSquareAmpereName = 'square %smeter per quartic %ssecond per square %sampere';
  rsSquareMeterPerQuarticSecondPerSquareAmperePluralName = 'square %smeters per quartic %ssecond per square %sampere';

const
  SquareMeterPerQuarticSecondPerSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -240; FAmpere: -120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterPerQuarticSecondPerSquareAmpereSymbol;
    FName       : rsSquareMeterPerQuarticSecondPerSquareAmpereName;
    FPluralName : rsSquareMeterPerQuarticSecondPerSquareAmperePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -4, -2));

{ TKilogramSquareMeterPerQuarticSecond }

resourcestring
  rsKilogramSquareMeterPerQuarticSecondSymbol = '%skg∙%sm²/%ss⁴';
  rsKilogramSquareMeterPerQuarticSecondName = '%skilogram square %smeter per quartic %ssecond';
  rsKilogramSquareMeterPerQuarticSecondPluralName = '%skilograms square %smeters per quartic %ssecond';

const
  KilogramSquareMeterPerQuarticSecondUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerQuarticSecondSymbol;
    FName       : rsKilogramSquareMeterPerQuarticSecondName;
    FPluralName : rsKilogramSquareMeterPerQuarticSecondPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -4));

{ TReciprocalSecondSteradian }

resourcestring
  rsReciprocalSecondSteradianSymbol = '1/%ss/sr';
  rsReciprocalSecondSteradianName = 'reciprocal %ssecond steradian';
  rsReciprocalSecondSteradianPluralName = 'reciprocal %ssecond steradian';

const
  ReciprocalSecondSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsReciprocalSecondSteradianSymbol;
    FName       : rsReciprocalSecondSteradianName;
    FPluralName : rsReciprocalSecondSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalSecondCandela }

resourcestring
  rsReciprocalSecondCandelaSymbol = '1/%ss/%scd';
  rsReciprocalSecondCandelaName = 'reciprocal %ssecond %scandela';
  rsReciprocalSecondCandelaPluralName = 'reciprocal %ssecond %scandela';

const
  ReciprocalSecondCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: 0);
    FSymbol     : rsReciprocalSecondCandelaSymbol;
    FName       : rsReciprocalSecondCandelaName;
    FPluralName : rsReciprocalSecondCandelaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TCubicMeterPerCandelaPerSteradian }

resourcestring
  rsCubicMeterPerCandelaPerSteradianSymbol = '%sm³/%scd/sr';
  rsCubicMeterPerCandelaPerSteradianName = 'cubic %smeter per %scandela per steradian';
  rsCubicMeterPerCandelaPerSteradianPluralName = 'cubic %smeters per %scandela per steradian';

const
  CubicMeterPerCandelaPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: -60);
    FSymbol     : rsCubicMeterPerCandelaPerSteradianSymbol;
    FName       : rsCubicMeterPerCandelaPerSteradianName;
    FPluralName : rsCubicMeterPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TCubicMeterPerSecondPerSteradian }

resourcestring
  rsCubicMeterPerSecondPerSteradianSymbol = '%sm³/%ss/sr';
  rsCubicMeterPerSecondPerSteradianName = 'cubic %smeter per %ssecond per steradian';
  rsCubicMeterPerSecondPerSteradianPluralName = 'cubic %smeters per %ssecond per steradian';

const
  CubicMeterPerSecondPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsCubicMeterPerSecondPerSteradianSymbol;
    FName       : rsCubicMeterPerSecondPerSteradianName;
    FPluralName : rsCubicMeterPerSecondPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TCubicMeterPerSecondPerCandela }

resourcestring
  rsCubicMeterPerSecondPerCandelaSymbol = '%sm³/%ss/%scd';
  rsCubicMeterPerSecondPerCandelaName = 'cubic %smeter per %ssecond per %scandela';
  rsCubicMeterPerSecondPerCandelaPluralName = 'cubic %smeters per %ssecond per %scandela';

const
  CubicMeterPerSecondPerCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: 0);
    FSymbol     : rsCubicMeterPerSecondPerCandelaSymbol;
    FName       : rsCubicMeterPerSecondPerCandelaName;
    FPluralName : rsCubicMeterPerSecondPerCandelaPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, -1, -1));

{ TSquareMeterPerSecondPerSteradian }

resourcestring
  rsSquareMeterPerSecondPerSteradianSymbol = '%sm²/%ss/sr';
  rsSquareMeterPerSecondPerSteradianName = 'square %smeter per %ssecond per steradian';
  rsSquareMeterPerSecondPerSteradianPluralName = 'square %smeters per %ssecond per steradian';

const
  SquareMeterPerSecondPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsSquareMeterPerSecondPerSteradianSymbol;
    FName       : rsSquareMeterPerSecondPerSteradianName;
    FPluralName : rsSquareMeterPerSecondPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -1));

{ TSquareMeterPerSecondPerCandela }

resourcestring
  rsSquareMeterPerSecondPerCandelaSymbol = '%sm²/%ss/%scd';
  rsSquareMeterPerSecondPerCandelaName = 'square %smeter per %ssecond per %scandela';
  rsSquareMeterPerSecondPerCandelaPluralName = 'square %smeters per %ssecond per %scandela';

const
  SquareMeterPerSecondPerCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: 0);
    FSymbol     : rsSquareMeterPerSecondPerCandelaSymbol;
    FName       : rsSquareMeterPerSecondPerCandelaName;
    FPluralName : rsSquareMeterPerSecondPerCandelaPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -1));

{ TSquareMeterSquareSecond }

resourcestring
  rsSquareMeterSquareSecondSymbol = '%sm²∙%ss²';
  rsSquareMeterSquareSecondName = 'square %smeter square %ssecond';
  rsSquareMeterSquareSecondPluralName = 'square %smeters square %sseconds';

const
  SquareMeterSquareSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareMeterSquareSecondSymbol;
    FName       : rsSquareMeterSquareSecondName;
    FPluralName : rsSquareMeterSquareSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 2));

{ TSquareSecondPerQuarticMeter }

resourcestring
  rsSquareSecondPerQuarticMeterSymbol = '%ss²/%sm⁴';
  rsSquareSecondPerQuarticMeterName = 'square %ssecond per quartic %smeter';
  rsSquareSecondPerQuarticMeterPluralName = 'square %sseconds per quartic %smeter';

const
  SquareSecondPerQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -240; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondPerQuarticMeterSymbol;
    FName       : rsSquareSecondPerQuarticMeterName;
    FPluralName : rsSquareSecondPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -4));

{ TReciprocalKilogramQuarticMeter }

resourcestring
  rsReciprocalKilogramQuarticMeterSymbol = '1/%skg/%sm⁴';
  rsReciprocalKilogramQuarticMeterName = 'reciprocal %skilogram quartic %smeter';
  rsReciprocalKilogramQuarticMeterPluralName = 'reciprocal %skilogram quartic %smeter';

const
  ReciprocalKilogramQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalKilogramQuarticMeterSymbol;
    FName       : rsReciprocalKilogramQuarticMeterName;
    FPluralName : rsReciprocalKilogramQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -4));

{ TSquareSecondKelvinPerKilogram }

resourcestring
  rsSquareSecondKelvinPerKilogramSymbol = '%ss²∙%sK/%skg';
  rsSquareSecondKelvinPerKilogramName = 'square %ssecond %skelvin per %skilogram';
  rsSquareSecondKelvinPerKilogramPluralName = 'square %sseconds %skelvins per %skilogram';

const
  SquareSecondKelvinPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondKelvinPerKilogramSymbol;
    FName       : rsSquareSecondKelvinPerKilogramName;
    FPluralName : rsSquareSecondKelvinPerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 1, -1));

{ TSquareSecondKelvin }

resourcestring
  rsSquareSecondKelvinSymbol = '%ss²∙%sK';
  rsSquareSecondKelvinName = 'square %ssecond %skelvin';
  rsSquareSecondKelvinPluralName = 'square %sseconds %skelvins';

const
  SquareSecondKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 60; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondKelvinSymbol;
    FName       : rsSquareSecondKelvinName;
    FPluralName : rsSquareSecondKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 1));

{ TMeterCubicSecond }

resourcestring
  rsMeterCubicSecondSymbol = '%sm∙%ss³';
  rsMeterCubicSecondName = '%smeter cubic %ssecond';
  rsMeterCubicSecondPluralName = '%smeters cubic %sseconds';

const
  MeterCubicSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMeterCubicSecondSymbol;
    FName       : rsMeterCubicSecondName;
    FPluralName : rsMeterCubicSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 3));

{ TCubicSecondQuarticKelvinPerSquareMeter }

resourcestring
  rsCubicSecondQuarticKelvinPerSquareMeterSymbol = '%ss³∙%sK⁴/%sm²';
  rsCubicSecondQuarticKelvinPerSquareMeterName = 'cubic %ssecond quartic %skelvin per square %smeter';
  rsCubicSecondQuarticKelvinPerSquareMeterPluralName = 'cubic %sseconds quartic %skelvins per square %smeter';

const
  CubicSecondQuarticKelvinPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 180; FAmpere: 0; FKelvin: 240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondQuarticKelvinPerSquareMeterSymbol;
    FName       : rsCubicSecondQuarticKelvinPerSquareMeterName;
    FPluralName : rsCubicSecondQuarticKelvinPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 4, -2));

{ TQuarticKelvinPerKilogramPerSquareMeter }

resourcestring
  rsQuarticKelvinPerKilogramPerSquareMeterSymbol = '%sK⁴/%skg/%sm²';
  rsQuarticKelvinPerKilogramPerSquareMeterName = 'quartic %skelvin per %skilogram per square %smeter';
  rsQuarticKelvinPerKilogramPerSquareMeterPluralName = 'quartic %skelvins per %skilogram per square %smeter';

const
  QuarticKelvinPerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticKelvinPerKilogramPerSquareMeterSymbol;
    FName       : rsQuarticKelvinPerKilogramPerSquareMeterName;
    FPluralName : rsQuarticKelvinPerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, -1, -2));

{ TCubicSecondQuarticKelvin }

resourcestring
  rsCubicSecondQuarticKelvinSymbol = '%ss³∙%sK⁴';
  rsCubicSecondQuarticKelvinName = 'cubic %ssecond quartic %skelvin';
  rsCubicSecondQuarticKelvinPluralName = 'cubic %sseconds quartic %skelvins';

const
  CubicSecondQuarticKelvinUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 180; FAmpere: 0; FKelvin: 240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondQuarticKelvinSymbol;
    FName       : rsCubicSecondQuarticKelvinName;
    FPluralName : rsCubicSecondQuarticKelvinPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, 4));

{ TQuarticKelvinPerKilogram }

resourcestring
  rsQuarticKelvinPerKilogramSymbol = '%sK⁴/%skg';
  rsQuarticKelvinPerKilogramName = 'quartic %skelvin per %skilogram';
  rsQuarticKelvinPerKilogramPluralName = 'quartic %skelvins per %skilogram';

const
  QuarticKelvinPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticKelvinPerKilogramSymbol;
    FName       : rsQuarticKelvinPerKilogramName;
    FPluralName : rsQuarticKelvinPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -1));

{ TSquareSecondMolePerSquareMeter }

resourcestring
  rsSquareSecondMolePerSquareMeterSymbol = '%ss²∙%smol/%sm²';
  rsSquareSecondMolePerSquareMeterName = 'square %ssecond %smole per square %smeter';
  rsSquareSecondMolePerSquareMeterPluralName = 'square %sseconds %smoles per square %smeter';

const
  SquareSecondMolePerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondMolePerSquareMeterSymbol;
    FName       : rsSquareSecondMolePerSquareMeterName;
    FPluralName : rsSquareSecondMolePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 1, -2));

{ TSquareSecondMolePerKilogram }

resourcestring
  rsSquareSecondMolePerKilogramSymbol = '%ss²∙%smol/%skg';
  rsSquareSecondMolePerKilogramName = 'square %ssecond %smole per %skilogram';
  rsSquareSecondMolePerKilogramPluralName = 'square %sseconds %smoles per %skilogram';

const
  SquareSecondMolePerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondMolePerKilogramSymbol;
    FName       : rsSquareSecondMolePerKilogramName;
    FPluralName : rsSquareSecondMolePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 1, -1));

{ TMolePerKilogramPerSquareMeter }

resourcestring
  rsMolePerKilogramPerSquareMeterSymbol = '%smol/%skg/%sm²';
  rsMolePerKilogramPerSquareMeterName = '%smole per %skilogram per square %smeter';
  rsMolePerKilogramPerSquareMeterPluralName = '%smoles per %skilogram per square %smeter';

const
  MolePerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMolePerKilogramPerSquareMeterSymbol;
    FName       : rsMolePerKilogramPerSquareMeterName;
    FPluralName : rsMolePerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -2));

{ TSquareSecondKelvinMolePerSquareMeter }

resourcestring
  rsSquareSecondKelvinMolePerSquareMeterSymbol = '%ss²∙%sK∙%smol/%sm²';
  rsSquareSecondKelvinMolePerSquareMeterName = 'square %ssecond %skelvin %smole per square %smeter';
  rsSquareSecondKelvinMolePerSquareMeterPluralName = 'square %sseconds %skelvins %smoles per square %smeter';

const
  SquareSecondKelvinMolePerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 120; FAmpere: 0; FKelvin: 60; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondKelvinMolePerSquareMeterSymbol;
    FName       : rsSquareSecondKelvinMolePerSquareMeterName;
    FPluralName : rsSquareSecondKelvinMolePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (2, 1, 1, -2));

{ TSquareSecondKelvinMolePerKilogram }

resourcestring
  rsSquareSecondKelvinMolePerKilogramSymbol = '%ss²∙%sK∙%smol/%skg';
  rsSquareSecondKelvinMolePerKilogramName = 'square %ssecond %skelvin %smole per %skilogram';
  rsSquareSecondKelvinMolePerKilogramPluralName = 'square %sseconds %skelvins %smoles per %skilogram';

const
  SquareSecondKelvinMolePerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 60; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondKelvinMolePerKilogramSymbol;
    FName       : rsSquareSecondKelvinMolePerKilogramName;
    FPluralName : rsSquareSecondKelvinMolePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (2, 1, 1, -1));

{ TKelvinMolePerKilogramPerSquareMeter }

resourcestring
  rsKelvinMolePerKilogramPerSquareMeterSymbol = '%sK∙%smol/%skg/%sm²';
  rsKelvinMolePerKilogramPerSquareMeterName = '%skelvin %smole per %skilogram per square %smeter';
  rsKelvinMolePerKilogramPerSquareMeterPluralName = '%skelvins %smoles per %skilogram per square %smeter';

const
  KelvinMolePerKilogramPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKelvinMolePerKilogramPerSquareMeterSymbol;
    FName       : rsKelvinMolePerKilogramPerSquareMeterName;
    FPluralName : rsKelvinMolePerKilogramPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (1, 1, -1, -2));

{ TQuarticSecondSquareAmperePerMeter }

resourcestring
  rsQuarticSecondSquareAmperePerMeterSymbol = '%ss⁴∙%sA²/%sm';
  rsQuarticSecondSquareAmperePerMeterName = 'quartic %ssecond square %sampere per %smeter';
  rsQuarticSecondSquareAmperePerMeterPluralName = 'quartic %sseconds square %samperes per %smeter';

const
  QuarticSecondSquareAmperePerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 240; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondSquareAmperePerMeterSymbol;
    FName       : rsQuarticSecondSquareAmperePerMeterName;
    FPluralName : rsQuarticSecondSquareAmperePerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, 2, -1));

{ TSquareAmperePerKilogramPerMeter }

resourcestring
  rsSquareAmperePerKilogramPerMeterSymbol = '%sA²/%skg/%sm';
  rsSquareAmperePerKilogramPerMeterName = 'square %sampere per %skilogram per %smeter';
  rsSquareAmperePerKilogramPerMeterPluralName = 'square %samperes per %skilogram per %smeter';

const
  SquareAmperePerKilogramPerMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareAmperePerKilogramPerMeterSymbol;
    FName       : rsSquareAmperePerKilogramPerMeterName;
    FPluralName : rsSquareAmperePerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -1, -1));

{ TQuarticSecondPerKilogramPerMeter }

resourcestring
  rsQuarticSecondPerKilogramPerMeterSymbol = '%ss⁴/%skg/%sm';
  rsQuarticSecondPerKilogramPerMeterName = 'quartic %ssecond per %skilogram per %smeter';
  rsQuarticSecondPerKilogramPerMeterPluralName = 'quartic %sseconds per %skilogram per %smeter';

const
  QuarticSecondPerKilogramPerMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondPerKilogramPerMeterSymbol;
    FName       : rsQuarticSecondPerKilogramPerMeterName;
    FPluralName : rsQuarticSecondPerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, -1, -1));

{ TCubicSecondAmperePerCubicMeter }

resourcestring
  rsCubicSecondAmperePerCubicMeterSymbol = '%ss³∙%sA/%sm³';
  rsCubicSecondAmperePerCubicMeterName = 'cubic %ssecond %sampere per cubic %smeter';
  rsCubicSecondAmperePerCubicMeterPluralName = 'cubic %sseconds %samperes per cubic %smeter';

const
  CubicSecondAmperePerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 180; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicSecondAmperePerCubicMeterSymbol;
    FName       : rsCubicSecondAmperePerCubicMeterName;
    FPluralName : rsCubicSecondAmperePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (3, 1, -3));

{ TAmperePerKilogramPerCubicMeter }

resourcestring
  rsAmperePerKilogramPerCubicMeterSymbol = '%sA/%skg/%sm³';
  rsAmperePerKilogramPerCubicMeterName = '%sampere per %skilogram per cubic %smeter';
  rsAmperePerKilogramPerCubicMeterPluralName = '%samperes per %skilogram per cubic %smeter';

const
  AmperePerKilogramPerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -180; FSecond: 0; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsAmperePerKilogramPerCubicMeterSymbol;
    FName       : rsAmperePerKilogramPerCubicMeterName;
    FPluralName : rsAmperePerKilogramPerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -1, -3));

{ TQuarticSecondAmperePerCubicMeter }

resourcestring
  rsQuarticSecondAmperePerCubicMeterSymbol = '%ss⁴∙%sA/%sm³';
  rsQuarticSecondAmperePerCubicMeterName = 'quartic %ssecond %sampere per cubic %smeter';
  rsQuarticSecondAmperePerCubicMeterPluralName = 'quartic %sseconds %samperes per cubic %smeter';

const
  QuarticSecondAmperePerCubicMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -180; FSecond: 240; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondAmperePerCubicMeterSymbol;
    FName       : rsQuarticSecondAmperePerCubicMeterName;
    FPluralName : rsQuarticSecondAmperePerCubicMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, 1, -3));

{ TQuarticSecondAmperePerKilogram }

resourcestring
  rsQuarticSecondAmperePerKilogramSymbol = '%ss⁴∙%sA/%skg';
  rsQuarticSecondAmperePerKilogramName = 'quartic %ssecond %sampere per %skilogram';
  rsQuarticSecondAmperePerKilogramPluralName = 'quartic %sseconds %samperes per %skilogram';

const
  QuarticSecondAmperePerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 240; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondAmperePerKilogramSymbol;
    FName       : rsQuarticSecondAmperePerKilogramName;
    FPluralName : rsQuarticSecondAmperePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (4, 1, -1));

{ TSquareSecondAmperePerMeter }

resourcestring
  rsSquareSecondAmperePerMeterSymbol = '%ss²∙%sA/%sm';
  rsSquareSecondAmperePerMeterName = 'square %ssecond %sampere per %smeter';
  rsSquareSecondAmperePerMeterPluralName = 'square %sseconds %samperes per %smeter';

const
  SquareSecondAmperePerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 120; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondAmperePerMeterSymbol;
    FName       : rsSquareSecondAmperePerMeterName;
    FPluralName : rsSquareSecondAmperePerMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 1, -1));

{ TQuarticSecondPerQuarticMeter }

resourcestring
  rsQuarticSecondPerQuarticMeterSymbol = '%ss⁴/%sm⁴';
  rsQuarticSecondPerQuarticMeterName = 'quartic %ssecond per quartic %smeter';
  rsQuarticSecondPerQuarticMeterPluralName = 'quartic %sseconds per quartic %smeter';

const
  QuarticSecondPerQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -240; FSecond: 240; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondPerQuarticMeterSymbol;
    FName       : rsQuarticSecondPerQuarticMeterName;
    FPluralName : rsQuarticSecondPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -4));

{ TReciprocalSquareKilogramQuarticMeter }

resourcestring
  rsReciprocalSquareKilogramQuarticMeterSymbol = '1/%skg²/%sm⁴';
  rsReciprocalSquareKilogramQuarticMeterName = 'reciprocal square %skilogram quartic %smeter';
  rsReciprocalSquareKilogramQuarticMeterPluralName = 'reciprocal square %skilogram quartic %smeter';

const
  ReciprocalSquareKilogramQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: -240; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsReciprocalSquareKilogramQuarticMeterSymbol;
    FName       : rsReciprocalSquareKilogramQuarticMeterName;
    FPluralName : rsReciprocalSquareKilogramQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-2, -4));

{ TSquareMeterPerCubicSecondPerCandelaPerSteradian }

resourcestring
  rsSquareMeterPerCubicSecondPerCandelaPerSteradianSymbol = '%sm²/%ss³/%scd/sr';
  rsSquareMeterPerCubicSecondPerCandelaPerSteradianName = 'square %smeter per cubic %ssecond per %scandela per steradian';
  rsSquareMeterPerCubicSecondPerCandelaPerSteradianPluralName = 'square %smeters per cubic %ssecond per %scandela per steradian';

const
  SquareMeterPerCubicSecondPerCandelaPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: -60);
    FSymbol     : rsSquareMeterPerCubicSecondPerCandelaPerSteradianSymbol;
    FName       : rsSquareMeterPerCubicSecondPerCandelaPerSteradianName;
    FPluralName : rsSquareMeterPerCubicSecondPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -3, -1));

{ TKilogramPerCubicSecondPerCandelaPerSteradian }

resourcestring
  rsKilogramPerCubicSecondPerCandelaPerSteradianSymbol = '%skg/%ss³/%scd/sr';
  rsKilogramPerCubicSecondPerCandelaPerSteradianName = '%skilogram per cubic %ssecond per %scandela per steradian';
  rsKilogramPerCubicSecondPerCandelaPerSteradianPluralName = '%skilograms per cubic %ssecond per %scandela per steradian';

const
  KilogramPerCubicSecondPerCandelaPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: -60);
    FSymbol     : rsKilogramPerCubicSecondPerCandelaPerSteradianSymbol;
    FName       : rsKilogramPerCubicSecondPerCandelaPerSteradianName;
    FPluralName : rsKilogramPerCubicSecondPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -3, -1));

{ TKilogramSquareMeterPerCandelaPerSteradian }

resourcestring
  rsKilogramSquareMeterPerCandelaPerSteradianSymbol = '%skg∙%sm²/%scd/sr';
  rsKilogramSquareMeterPerCandelaPerSteradianName = '%skilogram square %smeter per %scandela per steradian';
  rsKilogramSquareMeterPerCandelaPerSteradianPluralName = '%skilograms square %smeters per %scandela per steradian';

const
  KilogramSquareMeterPerCandelaPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: -60);
    FSymbol     : rsKilogramSquareMeterPerCandelaPerSteradianSymbol;
    FName       : rsKilogramSquareMeterPerCandelaPerSteradianName;
    FPluralName : rsKilogramSquareMeterPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TKilogramSquareMeterPerCubicSecondPerCandela }

resourcestring
  rsKilogramSquareMeterPerCubicSecondPerCandelaSymbol = '%skg∙%sm²/%ss³/%scd';
  rsKilogramSquareMeterPerCubicSecondPerCandelaName = '%skilogram square %smeter per cubic %ssecond per %scandela';
  rsKilogramSquareMeterPerCubicSecondPerCandelaPluralName = '%skilograms square %smeters per cubic %ssecond per %scandela';

const
  KilogramSquareMeterPerCubicSecondPerCandelaUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerCubicSecondPerCandelaSymbol;
    FName       : rsKilogramSquareMeterPerCubicSecondPerCandelaName;
    FPluralName : rsKilogramSquareMeterPerCubicSecondPerCandelaPluralName;
    FPrefixes   : (pNone, pNone, pNone, pNone);
    FExponents  : (1, 2, -3, -1));

{ TSquareSecondSteradianPerSquareMeter }

resourcestring
  rsSquareSecondSteradianPerSquareMeterSymbol = '%ss²∙sr/%sm²';
  rsSquareSecondSteradianPerSquareMeterName = 'square %ssecond steradian per square %smeter';
  rsSquareSecondSteradianPerSquareMeterPluralName = 'square %sseconds steradians per square %smeter';

const
  SquareSecondSteradianPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSquareSecondSteradianPerSquareMeterSymbol;
    FName       : rsSquareSecondSteradianPerSquareMeterName;
    FPluralName : rsSquareSecondSteradianPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TCubicSecondSteradianPerMeter }

resourcestring
  rsCubicSecondSteradianPerMeterSymbol = '%ss³∙sr/%sm';
  rsCubicSecondSteradianPerMeterName = 'cubic %ssecond steradian per %smeter';
  rsCubicSecondSteradianPerMeterPluralName = 'cubic %sseconds steradians per %smeter';

const
  CubicSecondSteradianPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsCubicSecondSteradianPerMeterSymbol;
    FName       : rsCubicSecondSteradianPerMeterName;
    FPluralName : rsCubicSecondSteradianPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TSteradianPerKilogramPerMeter }

resourcestring
  rsSteradianPerKilogramPerMeterSymbol = 'sr/%skg/%sm';
  rsSteradianPerKilogramPerMeterName = 'steradian per %skilogram per %smeter';
  rsSteradianPerKilogramPerMeterPluralName = 'steradians per %skilogram per %smeter';

const
  SteradianPerKilogramPerMeterUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: -60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSteradianPerKilogramPerMeterSymbol;
    FName       : rsSteradianPerKilogramPerMeterName;
    FPluralName : rsSteradianPerKilogramPerMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-1, -1));

{ TMeterCubicSecondSteradian }

resourcestring
  rsMeterCubicSecondSteradianSymbol = '%sm∙%ss³∙sr';
  rsMeterCubicSecondSteradianName = '%smeter cubic %ssecond steradian';
  rsMeterCubicSecondSteradianPluralName = '%smeters cubic %sseconds steradians';

const
  MeterCubicSecondSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 60; FSecond: 180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsMeterCubicSecondSteradianSymbol;
    FName       : rsMeterCubicSecondSteradianName;
    FPluralName : rsMeterCubicSecondSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, 3));

{ TMeterSteradianPerKilogram }

resourcestring
  rsMeterSteradianPerKilogramSymbol = '%sm∙sr/%skg';
  rsMeterSteradianPerKilogramName = '%smeter steradian per %skilogram';
  rsMeterSteradianPerKilogramPluralName = '%smeters steradians per %skilogram';

const
  MeterSteradianPerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsMeterSteradianPerKilogramSymbol;
    FName       : rsMeterSteradianPerKilogramName;
    FPluralName : rsMeterSteradianPerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareSecondSteradian }

resourcestring
  rsSquareSecondSteradianSymbol = '%ss²∙sr';
  rsSquareSecondSteradianName = 'square %ssecond steradian';
  rsSquareSecondSteradianPluralName = 'square %sseconds steradians';

const
  SquareSecondSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSquareSecondSteradianSymbol;
    FName       : rsSquareSecondSteradianName;
    FPluralName : rsSquareSecondSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (2));

{ TCubicMeterSecond }

resourcestring
  rsCubicMeterSecondSymbol = '%sm³∙%ss';
  rsCubicMeterSecondName = 'cubic %smeter %ssecond';
  rsCubicMeterSecondPluralName = 'cubic %smeters %sseconds';

const
  CubicMeterSecondUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 60; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsCubicMeterSecondSymbol;
    FName       : rsCubicMeterSecondName;
    FPluralName : rsCubicMeterSecondPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, 1));

{ TMolePerAmpere }

resourcestring
  rsMolePerAmpereSymbol = '%smol/%sA';
  rsMolePerAmpereName = '%smole per %sampere';
  rsMolePerAmperePluralName = '%smoles per %sampere';

const
  MolePerAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: -60; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMolePerAmpereSymbol;
    FName       : rsMolePerAmpereName;
    FPluralName : rsMolePerAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSexticSecondSquareAmpere }

resourcestring
  rsSexticSecondSquareAmpereSymbol = '%ss⁶∙%sA²';
  rsSexticSecondSquareAmpereName = 'sextic %ssecond square %sampere';
  rsSexticSecondSquareAmperePluralName = 'sextic %sseconds square %samperes';

const
  SexticSecondSquareAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 360; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticSecondSquareAmpereSymbol;
    FName       : rsSexticSecondSquareAmpereName;
    FPluralName : rsSexticSecondSquareAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (6, 2));

{ TSquareAmperePerQuarticMeter }

resourcestring
  rsSquareAmperePerQuarticMeterSymbol = '%sA²/%sm⁴';
  rsSquareAmperePerQuarticMeterName = 'square %sampere per quartic %smeter';
  rsSquareAmperePerQuarticMeterPluralName = 'square %samperes per quartic %smeter';

const
  SquareAmperePerQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -240; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareAmperePerQuarticMeterSymbol;
    FName       : rsSquareAmperePerQuarticMeterName;
    FPluralName : rsSquareAmperePerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -4));

{ TSexticSecondPerQuarticMeter }

resourcestring
  rsSexticSecondPerQuarticMeterSymbol = '%ss⁶/%sm⁴';
  rsSexticSecondPerQuarticMeterName = 'sextic %ssecond per quartic %smeter';
  rsSexticSecondPerQuarticMeterPluralName = 'sextic %sseconds per quartic %smeter';

const
  SexticSecondPerQuarticMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -240; FSecond: 360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticSecondPerQuarticMeterSymbol;
    FName       : rsSexticSecondPerQuarticMeterName;
    FPluralName : rsSexticSecondPerQuarticMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (6, -4));

{ TSquareAmperePerSquareKilogram }

resourcestring
  rsSquareAmperePerSquareKilogramSymbol = '%sA²/%skg²';
  rsSquareAmperePerSquareKilogramName = 'square %sampere per square %skilogram';
  rsSquareAmperePerSquareKilogramPluralName = 'square %samperes per square %skilogram';

const
  SquareAmperePerSquareKilogramUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: 0; FSecond: 0; FAmpere: 120; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareAmperePerSquareKilogramSymbol;
    FName       : rsSquareAmperePerSquareKilogramName;
    FPluralName : rsSquareAmperePerSquareKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, -2));

{ TSexticSecondPerSquareKilogram }

resourcestring
  rsSexticSecondPerSquareKilogramSymbol = '%ss⁶/%skg²';
  rsSexticSecondPerSquareKilogramName = 'sextic %ssecond per square %skilogram';
  rsSexticSecondPerSquareKilogramPluralName = 'sextic %sseconds per square %skilogram';

const
  SexticSecondPerSquareKilogramUnit : TUnit = (
    FDim        : (FKilogram: -120; FMeter: 0; FSecond: 360; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSexticSecondPerSquareKilogramSymbol;
    FName       : rsSexticSecondPerSquareKilogramName;
    FPluralName : rsSexticSecondPerSquareKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (6, -2));

{ TCubicMeterPerSteradian }

resourcestring
  rsCubicMeterPerSteradianSymbol = '%sm³/sr';
  rsCubicMeterPerSteradianName = 'cubic %smeter per steradian';
  rsCubicMeterPerSteradianPluralName = 'cubic %smeters per steradian';

const
  CubicMeterPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: -60);
    FSymbol     : rsCubicMeterPerSteradianSymbol;
    FName       : rsCubicMeterPerSteradianName;
    FPluralName : rsCubicMeterPerSteradianPluralName;
    FPrefixes   : (pNone);
    FExponents  : (3));

{ TCubicMeterPerCandela }

resourcestring
  rsCubicMeterPerCandelaSymbol = '%sm³/%scd';
  rsCubicMeterPerCandelaName = 'cubic %smeter per %scandela';
  rsCubicMeterPerCandelaPluralName = 'cubic %smeters per %scandela';

const
  CubicMeterPerCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 180; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: 0);
    FSymbol     : rsCubicMeterPerCandelaSymbol;
    FName       : rsCubicMeterPerCandelaName;
    FPluralName : rsCubicMeterPerCandelaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (3, -1));

{ TQuarticKelvinPerSquareMeter }

resourcestring
  rsQuarticKelvinPerSquareMeterSymbol = '%sK⁴/%sm²';
  rsQuarticKelvinPerSquareMeterName = 'quartic %skelvin per square %smeter';
  rsQuarticKelvinPerSquareMeterPluralName = 'quartic %skelvins per square %smeter';

const
  QuarticKelvinPerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 240; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticKelvinPerSquareMeterSymbol;
    FName       : rsQuarticKelvinPerSquareMeterName;
    FPluralName : rsQuarticKelvinPerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, -2));

{ TSquareSecondMole }

resourcestring
  rsSquareSecondMoleSymbol = '%ss²∙%smol';
  rsSquareSecondMoleName = 'square %ssecond %smole';
  rsSquareSecondMolePluralName = 'square %sseconds %smoles';

const
  SquareSecondMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondMoleSymbol;
    FName       : rsSquareSecondMoleName;
    FPluralName : rsSquareSecondMolePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (2, 1));

{ TMolePerSquareMeter }

resourcestring
  rsMolePerSquareMeterSymbol = '%smol/%sm²';
  rsMolePerSquareMeterName = '%smole per square %smeter';
  rsMolePerSquareMeterPluralName = '%smoles per square %smeter';

const
  MolePerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMolePerSquareMeterSymbol;
    FName       : rsMolePerSquareMeterName;
    FPluralName : rsMolePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -2));

{ TMolePerKilogram }

resourcestring
  rsMolePerKilogramSymbol = '%smol/%skg';
  rsMolePerKilogramName = '%smole per %skilogram';
  rsMolePerKilogramPluralName = '%smoles per %skilogram';

const
  MolePerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsMolePerKilogramSymbol;
    FName       : rsMolePerKilogramName;
    FPluralName : rsMolePerKilogramPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TSquareSecondKelvinMole }

resourcestring
  rsSquareSecondKelvinMoleSymbol = '%ss²∙%sK∙%smol';
  rsSquareSecondKelvinMoleName = 'square %ssecond %skelvin %smole';
  rsSquareSecondKelvinMolePluralName = 'square %sseconds %skelvins %smoles';

const
  SquareSecondKelvinMoleUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 120; FAmpere: 0; FKelvin: 60; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsSquareSecondKelvinMoleSymbol;
    FName       : rsSquareSecondKelvinMoleName;
    FPluralName : rsSquareSecondKelvinMolePluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, 1, 1));

{ TKelvinMolePerSquareMeter }

resourcestring
  rsKelvinMolePerSquareMeterSymbol = '%sK∙%smol/%sm²';
  rsKelvinMolePerSquareMeterName = '%skelvin %smole per square %smeter';
  rsKelvinMolePerSquareMeterPluralName = '%skelvins %smoles per square %smeter';

const
  KelvinMolePerSquareMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -120; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKelvinMolePerSquareMeterSymbol;
    FName       : rsKelvinMolePerSquareMeterName;
    FPluralName : rsKelvinMolePerSquareMeterPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -2));

{ TKelvinMolePerKilogram }

resourcestring
  rsKelvinMolePerKilogramSymbol = '%sK∙%smol/%skg';
  rsKelvinMolePerKilogramName = '%skelvin %smole per %skilogram';
  rsKelvinMolePerKilogramPluralName = '%skelvins %smoles per %skilogram';

const
  KelvinMolePerKilogramUnit : TUnit = (
    FDim        : (FKilogram: -60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 60; FMole: 60; FCandela: 0; FSteradian: 0);
    FSymbol     : rsKelvinMolePerKilogramSymbol;
    FName       : rsKelvinMolePerKilogramName;
    FPluralName : rsKelvinMolePerKilogramPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 1, -1));

{ TQuarticSecondAmpere }

resourcestring
  rsQuarticSecondAmpereSymbol = '%ss⁴∙%sA';
  rsQuarticSecondAmpereName = 'quartic %ssecond %sampere';
  rsQuarticSecondAmperePluralName = 'quartic %sseconds %samperes';

const
  QuarticSecondAmpereUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 240; FAmpere: 60; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsQuarticSecondAmpereSymbol;
    FName       : rsQuarticSecondAmpereName;
    FPluralName : rsQuarticSecondAmperePluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (4, 1));

{ TReciprocalCubicSecondCandelaSteradian }

resourcestring
  rsReciprocalCubicSecondCandelaSteradianSymbol = '1/%ss³/%scd/sr';
  rsReciprocalCubicSecondCandelaSteradianName = 'reciprocal cubic %ssecond %scandela steradian';
  rsReciprocalCubicSecondCandelaSteradianPluralName = 'reciprocal cubic %ssecond %scandela steradian';

const
  ReciprocalCubicSecondCandelaSteradianUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: -60);
    FSymbol     : rsReciprocalCubicSecondCandelaSteradianSymbol;
    FName       : rsReciprocalCubicSecondCandelaSteradianName;
    FPluralName : rsReciprocalCubicSecondCandelaSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-3, -1));

{ TSquareMeterPerCubicSecondPerCandela }

resourcestring
  rsSquareMeterPerCubicSecondPerCandelaSymbol = '%sm²/%ss³/%scd';
  rsSquareMeterPerCubicSecondPerCandelaName = 'square %smeter per cubic %ssecond per %scandela';
  rsSquareMeterPerCubicSecondPerCandelaPluralName = 'square %smeters per cubic %ssecond per %scandela';

const
  SquareMeterPerCubicSecondPerCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 120; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: 0);
    FSymbol     : rsSquareMeterPerCubicSecondPerCandelaSymbol;
    FName       : rsSquareMeterPerCubicSecondPerCandelaName;
    FPluralName : rsSquareMeterPerCubicSecondPerCandelaPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (2, -3, -1));

{ TKilogramPerCandelaPerSteradian }

resourcestring
  rsKilogramPerCandelaPerSteradianSymbol = '%skg/%scd/sr';
  rsKilogramPerCandelaPerSteradianName = '%skilogram per %scandela per steradian';
  rsKilogramPerCandelaPerSteradianPluralName = '%skilograms per %scandela per steradian';

const
  KilogramPerCandelaPerSteradianUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: -60);
    FSymbol     : rsKilogramPerCandelaPerSteradianSymbol;
    FName       : rsKilogramPerCandelaPerSteradianName;
    FPluralName : rsKilogramPerCandelaPerSteradianPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ TKilogramPerCubicSecondPerCandela }

resourcestring
  rsKilogramPerCubicSecondPerCandelaSymbol = '%skg/%ss³/%scd';
  rsKilogramPerCubicSecondPerCandelaName = '%skilogram per cubic %ssecond per %scandela';
  rsKilogramPerCubicSecondPerCandelaPluralName = '%skilograms per cubic %ssecond per %scandela';

const
  KilogramPerCubicSecondPerCandelaUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: 0);
    FSymbol     : rsKilogramPerCubicSecondPerCandelaSymbol;
    FName       : rsKilogramPerCubicSecondPerCandelaName;
    FPluralName : rsKilogramPerCubicSecondPerCandelaPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, -3, -1));

{ TKilogramSquareMeterPerCandela }

resourcestring
  rsKilogramSquareMeterPerCandelaSymbol = '%skg∙%sm²/%scd';
  rsKilogramSquareMeterPerCandelaName = '%skilogram square %smeter per %scandela';
  rsKilogramSquareMeterPerCandelaPluralName = '%skilograms square %smeters per %scandela';

const
  KilogramSquareMeterPerCandelaUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 120; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: 0);
    FSymbol     : rsKilogramSquareMeterPerCandelaSymbol;
    FName       : rsKilogramSquareMeterPerCandelaName;
    FPluralName : rsKilogramSquareMeterPerCandelaPluralName;
    FPrefixes   : (pNone, pNone, pNone);
    FExponents  : (1, 2, -1));

{ TSteradianPerMeter }

resourcestring
  rsSteradianPerMeterSymbol = 'sr/%sm';
  rsSteradianPerMeterName = 'steradian per %smeter';
  rsSteradianPerMeterPluralName = 'steradians per %smeter';

const
  SteradianPerMeterUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: -60; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 60);
    FSymbol     : rsSteradianPerMeterSymbol;
    FName       : rsSteradianPerMeterName;
    FPluralName : rsSteradianPerMeterPluralName;
    FPrefixes   : (pNone);
    FExponents  : (-1));

{ TReciprocalCubicSecondCandela }

resourcestring
  rsReciprocalCubicSecondCandelaSymbol = '1/%ss³/%scd';
  rsReciprocalCubicSecondCandelaName = 'reciprocal cubic %ssecond %scandela';
  rsReciprocalCubicSecondCandelaPluralName = 'reciprocal cubic %ssecond %scandela';

const
  ReciprocalCubicSecondCandelaUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: -180; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: 0);
    FSymbol     : rsReciprocalCubicSecondCandelaSymbol;
    FName       : rsReciprocalCubicSecondCandelaName;
    FPluralName : rsReciprocalCubicSecondCandelaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (-3, -1));

{ TKilogramPerCandela }

resourcestring
  rsKilogramPerCandelaSymbol = '%skg/%scd';
  rsKilogramPerCandelaName = '%skilogram per %scandela';
  rsKilogramPerCandelaPluralName = '%skilograms per %scandela';

const
  KilogramPerCandelaUnit : TUnit = (
    FDim        : (FKilogram: 60; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: -60; FSteradian: 0);
    FSymbol     : rsKilogramPerCandelaSymbol;
    FName       : rsKilogramPerCandelaName;
    FPluralName : rsKilogramPerCandelaPluralName;
    FPrefixes   : (pNone, pNone);
    FExponents  : (1, -1));

{ Power functions }

function SquarePower(const AQuantity: TQuantity): TQuantity;
function CubicPower(const AQuantity: TQuantity): TQuantity;
function QuarticPower(const AQuantity: TQuantity): TQuantity;
function QuinticPower(const AQuantity: TQuantity): TQuantity;
function SexticPower(const AQuantity: TQuantity): TQuantity;
function SquareRoot(const AQuantity: TQuantity): TQuantity;
function CubicRoot(const AQuantity: TQuantity): TQuantity;
function QuarticRoot(const AQuantity: TQuantity): TQuantity;
function QuinticRoot(const AQuantity: TQuantity): TQuantity;
function SexticRoot(const AQuantity: TQuantity): TQuantity;

{ Trigonometric functions }

function Cos(const AQuantity: TQuantity): double;
function Sin(const AQuantity: TQuantity): double;
function Tan(const AQuantity: TQuantity): double;
function Cotan(const AQuantity: TQuantity): double;
function Secant(const AQuantity: TQuantity): double;
function Cosecant(const AQuantity: TQuantity): double;

function ArcCos(const AValue: double): TQuantity;
function ArcSin(const AValue: double): TQuantity;
function ArcTan(const AValue: double): TQuantity;
function ArcTan2(const x, y: double): TQuantity;

{ Math functions }

function Min(const ALeft, ARight: TQuantity): TQuantity;
function Max(const ALeft, ARight: TQuantity): TQuantity;
function Exp(const AQuantity: TQuantity): TQuantity;

function Log10(const AQuantity : TQuantity) : double;
function Log2(const AQuantity : TQuantity) : double;
function LogN(ABase: longint; const AQuantity: TQuantity): double;
function LogN(const ABase, AQuantity: TQuantity): double;

function Power(const ABase: TQuantity; AExponent: double): double;

{ Helper functions }

function LessThanOrEqualToZero(const AQuantity: TQuantity): boolean;
function LessThanZero(const AQuantity: TQuantity): boolean;
function EqualToZero(const AQuantity: TQuantity): boolean;
function NotEqualToZero(const AQuantity: TQuantity): boolean;
function GreaterThanOrEqualToZero(const AQuantity: TQuantity): boolean;
function GreaterThanZero(const AQuantity: TQuantity): boolean;

{ Constants }

const
  AvogadroConstant               : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole: -60; FCandela: 0; FSteradian: 0); FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}
  BohrMagneton                   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:  120; FSecond:    0; FAmpere:   60; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}
  BohrRadius                     : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}
  BoltzmannConstant              : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond: -120; FAmpere:    0; FKelvin: -60; FMole:   0; FCandela: 0; FSteradian: 0); FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}
  ComptonWaveLength              : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}
  CoulombConstant                : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  180; FSecond: -240; FAmpere: -120; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}
  DeuteronMass                   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}
  ElectricPermittivity           : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter: -180; FSecond:  240; FAmpere:  120; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     8.8541878188E-12); {$ELSE} (    8.8541878188E-12); {$ENDIF}
  ElectronMass                   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}
  ElectronCharge                 : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:   60; FAmpere:   60; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}
  FineStructureConstant          : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      7.2973525643E-3); {$ELSE} (     7.2973525643E-3); {$ENDIF}
  InverseFineStructureConstant   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:        137.035999177); {$ELSE} (       137.035999177); {$ENDIF}
  MagneticPermeability           : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:   60; FSecond: -120; FAmpere: -120; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}
  MolarGasConstant               : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond:  120; FAmpere:    0; FKelvin: -60; FMole: -60; FCandela: 0; FSteradian: 0); FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}
  NeutronMass                    : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}
  NewtonianConstantOfGravitation : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter:  180; FSecond: -120; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}
  PlanckConstant                 : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond:  -60; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}
  ProtonMass                     : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}
  RydbergConstant                : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:  -60; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}
  SpeedOfLight                   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond:  -60; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}
  SquaredSpeedOfLight            : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:  120; FSecond: -120; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}
  StandardAccelerationOfGravity  : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond: -120; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}
  ReducedPlanckConstant          : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond:  -60; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}
  UnifiedAtomicMassUnit          : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}

{ Prefix Table }

const
  PrefixTable: array[pQuetta..pQuecto] of
    record  Symbol, Name: string; Exponent: longint end = (
    (Symbol: 'Q';   Name: 'quetta';  Exponent: +30),
    (Symbol: 'R';   Name: 'ronna';   Exponent: +27),
    (Symbol: 'Y';   Name: 'yotta';   Exponent: +24),
    (Symbol: 'Z';   Name: 'zetta';   Exponent: +21),
    (Symbol: 'E';   Name: 'exa';     Exponent: +18),
    (Symbol: 'P';   Name: 'peta';    Exponent: +15),
    (Symbol: 'T';   Name: 'tera';    Exponent: +12),
    (Symbol: 'G';   Name: 'giga';    Exponent: +09),
    (Symbol: 'M';   Name: 'mega';    Exponent: +06),
    (Symbol: 'k';   Name: 'kilo';    Exponent: +03),
    (Symbol: 'h';   Name: 'hecto';   Exponent: +02),
    (Symbol: 'da';  Name: 'deca';    Exponent: +01),
    (Symbol: '';    Name: '';        Exponent:  00),
    (Symbol: 'd';   Name: 'deci';    Exponent: -01),
    (Symbol: 'c';   Name: 'centi';   Exponent: -02),
    (Symbol: 'm';   Name: 'milli';   Exponent: -03),
    (Symbol: 'μ';   Name: 'micro';   Exponent: -06),
    (Symbol: 'n';   Name: 'nano';    Exponent: -09),
    (Symbol: 'p';   Name: 'pico';    Exponent: -12),
    (Symbol: 'f';   Name: 'femto';   Exponent: -15),
    (Symbol: 'a';   Name: 'atto';    Exponent: -18),
    (Symbol: 'z';   Name: 'zepto';   Exponent: -21),
    (Symbol: 'y';   Name: 'yocto';   Exponent: -24),
    (Symbol: 'r';   Name: 'ronto';   Exponent: -27),
    (Symbol: 'q';   Name: 'quecto';  Exponent: -30)
  );

{ Default Epsilon }

var

  DefaultEpsilon : double = 1E-12;

{ Internal routines }

procedure Check(ALeft, ARight: TDimension); inline;
function CheckEqual(ALeft, ARight: TDimension): TDimension; inline;
function CheckSum(ALeft, ARight: TDimension): TDimension; inline;
function CheckSub(ALeft, ARight: TDimension): TDimension; inline;
function CheckMul(ALeft, ARight: TDimension): TDimension; inline;
function CheckDiv(ALeft, ARight: TDimension): TDimension; inline;

implementation

uses Math;

// Format routines

function Fmt(const AValue: double): string;
begin
  if AValue < 0.0 then
    result := FloatToStr(AValue)
  else
    result := '+' + FloatToStr(AValue);
end;

function Fmt(const AValue: double; APrecision, ADigits: longint): string;
begin
  if AValue < 0.0 then
    result := FloatToStrF(AValue, ffGeneral, APrecision, ADigits)
  else
    result := '+' + FloatToStrF(AValue, ffGeneral, APrecision, ADigits);
end;

// Check routines

{$IFNDEF ADIMOFF}
  {$ASSERTIONS ON}
{$ENDIF}

function DimToShortString(AValue: smallint; const ASymbol: string): string;
begin
  AValue := System.Abs(AValue);
  if (AValue = 10 ) then result := '⁶√' + Format('%s',  [ASymbol]) else
  if (AValue = 12 ) then result := '⁵√' + Format('%s',  [ASymbol]) else
  if (AValue = 15 ) then result :=  '∜' + Format('%s' , [ASymbol]) else
  if (AValue = 20 ) then result :=  '∛' + Format('%s' , [ASymbol]) else
  if (AValue = 30 ) then result :=  '√' + Format('%s' , [ASymbol]) else
  if (AValue = 45 ) then result :=  '∜' + Format('%s3', [ASymbol]) else
  if (AValue = 60 ) then result :=        Format('%s' , [ASymbol]) else
  if (AValue = 90 ) then result :=  '√' + Format('%s3', [ASymbol]) else
  if (AValue = 120) then result :=        Format('%s2', [ASymbol]) else
  if (AValue = 150) then result :=  '√' + Format('%s5', [ASymbol]) else
  if (AValue = 180) then result :=        Format('%s3', [ASymbol]) else
  if (AValue = 240) then result :=        Format('%s4', [ASymbol]) else
  if (AValue = 300) then result :=        Format('%s5', [ASymbol]) else
  if (AValue = 360) then result :=        Format('%s6', [ASymbol]) else
    raise Exception.CreateFmt('ERROR: DimToShortString (%s)', [AValue.ToString]);
end;

function DimToShortString(const AValue: TDimension): string;
var
  Num, Denom: string;
begin
  Num := '';
  if AValue.FKilogram  > 0 then Num := Num + '.' + DimToShortString(AValue.FKilogram, '%skg');
  if AValue.FMeter     > 0 then Num := Num + '.' + DimToShortString(AValue.FMeter,     '%sm');
  if AValue.FSecond    > 0 then Num := Num + '.' + DimToShortString(AValue.FSecond,    '%ss');
  if AValue.FAmpere    > 0 then Num := Num + '.' + DimToShortString(AValue.FAmpere,    '%sA');
  if AValue.FKelvin    > 0 then Num := Num + '.' + DimToShortString(AValue.FKelvin,    '%sK');
  if AValue.FMole      > 0 then Num := Num + '.' + DimToShortString(AValue.FMole,    '%smol');
  if AValue.FCandela   > 0 then Num := Num + '.' + DimToShortString(AValue.FCandela,  '%scd');
  if AValue.FSteradian > 0 then Num := Num + '.' + DimToShortString(AValue.FSteradian,  'sr');

  if (Length(Num) > 0) then Delete(Num, 1, 1);

  Denom := '';
  if AValue.FKilogram  < 0 then Denom := Denom + '/' + DimToShortString(AValue.FKilogram, '%skg');
  if AValue.FMeter     < 0 then Denom := Denom + '/' + DimToShortString(AValue.FMeter,     '%sm');
  if AValue.FSecond    < 0 then Denom := Denom + '/' + DimToShortString(AValue.FSecond,    '%ss');
  if AValue.FAmpere    < 0 then Denom := Denom + '/' + DimToShortString(AValue.FAmpere,    '%sA');
  if AValue.FKelvin    < 0 then Denom := Denom + '/' + DimToShortString(AValue.FKelvin,    '%sK');
  if AValue.FMole      < 0 then Denom := Denom + '/' + DimToShortString(AValue.FMole,    '%smol');
  if AValue.FCandela   < 0 then Denom := Denom + '/' + DimToShortString(AValue.FCandela,  '%scd');
  if AValue.FSteradian < 0 then Denom := Denom + '/' + DimToShortString(AValue.FSteradian,  'sr');

  if Num = '' then
  begin
    if Denom = '' then
      result := ''
    else
      result := '1' + Denom;
  end else
  begin
    if Denom = '' then
      result := Num
    else
      result := Num + Denom
  end;

  while (Length(result) > 0) and (result[Low (result)] = ' ') do Delete(result, Low (result), 1);
  while (Length(result) > 0) and (result[High(result)] = ' ') do Delete(result, High(result), 1);
  result := StringReplace(result, '//', '/', [rfReplaceAll]);
  result := StringReplace(result, '  ', ' ', [rfReplaceAll]);
end;

procedure Check(ALeft, ARight: TDimension); inline;
begin
  if ALeft <> ARight then
  begin
    Assert(FALSE, Format('Wrong units of measurement detected, %s expected but %s found',
      [DimToShortString(ALeft), DimToShortString(ARight)]));
  end;
end;

function CheckEqual(ALeft, ARight: TDimension): TDimension; inline;
begin
  if ALeft <> ARight then
  begin
    Assert(FALSE, Format('Wrong units of measurement detected, %s expected but %s found',
      [DimToShortString(ALeft), DimToShortString(ARight)]));
  end;
  result := ALeft;
end;

function CheckSum(ALeft, ARight: TDimension): TDimension; inline;
begin
  if ALeft <> ARight then
  begin
    Assert(FALSE, Format('Wrong units of measurement detected, %s expected but %s found',
      [DimToShortString(ALeft), DimToShortString(ARight)]));
  end;
  result := ALeft;
end;

function CheckSub(ALeft, ARight: TDimension): TDimension; inline;
begin
  if ALeft <> ARight then
  begin
    Assert(FALSE, Format('Wrong units of measurement detected, "%s" expected but "%s" found',
      [DimToShortString(ALeft), DimToShortString(ARight)]));
  end;
  result := ALeft;
end;

function CheckMul(ALeft, ARight: TDimension): TDimension; inline;
begin
  result := ALeft + ARight;
end;

function CheckDiv(ALeft, ARight: TDimension): TDimension; inline;
begin
  result := ALeft - ARight;
end;

{$I baseprocs.inc}
{$I scalarprocs.inc}
{$I complexprocs.inc}
{$I matrixprocs.inc}
{$I vectorprocs.inc}
{$I cl3procs.inc}
{$I helperprocs.inc}
{$I extraprocs.inc}

{ TUnit }

// Real numbers

class operator TUnit.*(const AValue: double; const ASelf: TUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: double; const ASelf: TUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

// Complex numbers

class operator TUnit.*(const AValue: TComplex; const ASelf: TUnit): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckMul(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TComplex; const ASelf: TUnit): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

// Real vector space

class operator TUnit.*(const AVector: TR2Vector; const ASelf: TUnit): TR2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit.*(const AVector: TR3Vector; const ASelf: TUnit): TR3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit.*(const AVector: TR4Vector; const ASelf: TUnit): TR4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TR2Vector; const ASelf: TUnit): TR2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TR3Vector; const ASelf: TUnit): TR3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TR4Vector; const ASelf: TUnit): TR4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

// Complex vector space

class operator TUnit.*(const AVector: TC2Vector; const ASelf: TUnit): TC2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit.*(const AVector: TC3Vector; const ASelf: TUnit): TC3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit.*(const AVector: TC4Vector; const ASelf: TUnit): TC4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TC2Vector; const ASelf: TUnit): TC2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TC3Vector; const ASelf: TUnit): TC3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TC4Vector; const ASelf: TUnit): TC4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

// Real matrixes

class operator TUnit.*(const AMatrix: TR2Matrix; const ASelf: TUnit): TR2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit.*(const AMatrix: TR3Matrix; const ASelf: TUnit): TR3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit.*(const AMatrix: TR4Matrix; const ASelf: TUnit): TR4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit./(const AMatrix: TR2Matrix; const ASelf: TUnit): TR2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit./(const AMatrix: TR3Matrix; const ASelf: TUnit): TR3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit./(const AMatrix: TR4Matrix; const ASelf: TUnit): TR4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

// Complex matrixes

class operator TUnit.*(const AMatrix: TC2Matrix; const ASelf: TUnit): TC2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit.*(const AMatrix: TC3Matrix; const ASelf: TUnit): TC3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit.*(const AMatrix: TC4Matrix; const ASelf: TUnit): TC4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit./(const AMatrix: TC2Matrix; const ASelf: TUnit): TC2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit./(const AMatrix: TC3Matrix; const ASelf: TUnit): TC3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit./(const AMatrix: TC4Matrix; const ASelf: TUnit): TC4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

// CL3 vector space, Clifford algebra

class operator TUnit.*(const AVector: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit.*(const ABivector: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := ABivector;
{$ELSE}
  result := ABivector;
{$ENDIF}
end;

class operator TUnit./(const ABivector: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := ABivector;
{$ELSE}
  result := ABivector;
{$ENDIF}
end;

class operator TUnit.*(const ATrivector: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := ATrivector;
{$ELSE}
  result := ATrivector;
{$ENDIF}
end;

class operator TUnit./(const ATrivector: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := ATrivector;
{$ELSE}
  result := ATrivector;
{$ENDIF}
end;

class operator TUnit.*(const AMultivector: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMultivector;
{$ELSE}
  result := AMultivector;
{$ENDIF}
end;

class operator TUnit./(const AMultivector: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMultivector;
{$ELSE}
  result := AMultivector;
{$ENDIF}
end;

{$IFNDEF ADIMOFF}

// Real numbers

class operator TUnit.*(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

// Complex numbers

class operator TUnit.*(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckMul(ASelf.FDim, AQuantity.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckDiv(ASelf.FDim, AQuantity.FDim);
  result.FValue := AQuantity.FValue.Reciprocal;
end;

// Real space vector

class operator TUnit.*(const AQuantity: TR2VecQuantity; const ASelf: TUnit): TR2VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TR3VecQuantity; const ASelf: TUnit): TR3VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TR4VecQuantity; const ASelf: TUnit): TR4VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TR2VecQuantity; const ASelf: TUnit): TR2VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TR3VecQuantity; const ASelf: TUnit): TR3VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TR4VecQuantity; const ASelf: TUnit): TR4VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

// Complex space vector

class operator TUnit.*(const AQuantity: TC2VecQuantity; const ASelf: TUnit): TC2VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TC3VecQuantity; const ASelf: TUnit): TC3VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TC4VecQuantity; const ASelf: TUnit): TC4VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TC2VecQuantity; const ASelf: TUnit): TC2VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TC3VecQuantity; const ASelf: TUnit): TC3VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TC4VecQuantity; const ASelf: TUnit): TC4VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

// Real matrixes

class operator TUnit.*(const AQuantity: TR2MatrixQuantity; const ASelf: TUnit): TR2MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TR3MatrixQuantity; const ASelf: TUnit): TR3MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TR4MatrixQuantity; const ASelf: TUnit): TR4MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TR2MatrixQuantity; const ASelf: TUnit): TR2MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TR3MatrixQuantity; const ASelf: TUnit): TR3MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TR4MatrixQuantity; const ASelf: TUnit): TR4MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

// Complex matrixes

class operator TUnit.*(const AQuantity: TC2MatrixQuantity; const ASelf: TUnit): TC2MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TC3MatrixQuantity; const ASelf: TUnit): TC3MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TC4MatrixQuantity; const ASelf: TUnit): TC4MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TC2MatrixQuantity; const ASelf: TUnit): TC2MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TC3MatrixQuantity; const ASelf: TUnit): TC3MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TC4MatrixQuantity; const ASelf: TUnit): TC4MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

// CL3 vector space, Clifford algebra

class operator TUnit.*(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;
{$ENDIF}

{ TFactoredUnit }

// Real numbers

class operator TFactoredUnit.*(const AValue: double; const ASelf: TFactoredUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue * ASelf.FFactor;
{$ELSE}
  result := AValue * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AValue: double; const ASelf: TFactoredUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue / ASelf.FFactor;
{$ELSE}
  result := AValue / ASelf.FFactor;
{$ENDIF}
end;

// Complex numbers

class operator TFactoredUnit.*(const AValue: TComplex; const ASelf: TFactoredUnit): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckMul(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue * ASelf.FFactor;
{$ELSE}
  result := AValue * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AValue: TComplex; const ASelf: TFactoredUnit): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue / ASelf.FFactor;
{$ELSE}
  result := AValue / ASelf.FFactor;
{$ENDIF}
end;

// Real vector space

class operator TFactoredUnit.*(const AVector: TR2Vector; const ASelf: TFactoredUnit): TR2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector * ASelf.FFactor;
{$ELSE}
  result := AVector * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AVector: TR3Vector; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector * ASelf.FFactor;
{$ELSE}
  result := AVector * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AVector: TR4Vector; const ASelf: TFactoredUnit): TR4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector * ASelf.FFactor;
{$ELSE}
  result := AVector * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AVector: TR2Vector; const ASelf: TFactoredUnit): TR2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector / ASelf.FFactor;
{$ELSE}
  result := AVector / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AVector: TR3Vector; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector / ASelf.FFactor;
{$ELSE}
  result := AVector / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AVector: TR4Vector; const ASelf: TFactoredUnit): TR4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector / ASelf.FFactor;
{$ELSE}
  result := AVector / ASelf.FFactor;
{$ENDIF}
end;

// Complex vector space

class operator TFactoredUnit.*(const AVector: TC2Vector; const ASelf: TFactoredUnit): TC2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector * ASelf.FFactor;
{$ELSE}
  result := AVector * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AVector: TC3Vector; const ASelf: TFactoredUnit): TC3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector * ASelf.FFactor;
{$ELSE}
  result := AVector * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AVector: TC4Vector; const ASelf: TFactoredUnit): TC4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector * ASelf.FFactor;
{$ELSE}
  result := AVector * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AVector: TC2Vector; const ASelf: TFactoredUnit): TC2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector / ASelf.FFactor;
{$ELSE}
  result := AVector / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AVector: TC3Vector; const ASelf: TFactoredUnit): TC3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector / ASelf.FFactor;
{$ELSE}
  result := AVector / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AVector: TC4Vector; const ASelf: TFactoredUnit): TC4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector / ASelf.FFactor;
{$ELSE}
  result := AVector / ASelf.FFactor;
{$ENDIF}
end;

// Real matrixes

class operator TFactoredUnit.*(const AMatrix: TR2Matrix; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix * ASelf.FFactor;
{$ELSE}
  result := AMatrix * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AMatrix: TR3Matrix; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix * ASelf.FFactor;
{$ELSE}
  result := AMatrix * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AMatrix: TR4Matrix; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix * ASelf.FFactor;
{$ELSE}
  result := AMatrix * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AMatrix: TR2Matrix; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix / ASelf.FFactor;
{$ELSE}
  result := AMatrix / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AMatrix: TR3Matrix; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix / ASelf.FFactor;
{$ELSE}
  result := AMatrix / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AMatrix: TR4Matrix; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix / ASelf.FFactor;
{$ELSE}
  result := AMatrix / ASelf.FFactor;
{$ENDIF}
end;

// Complex matrixes

class operator TFactoredUnit.*(const AMatrix: TC2Matrix; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix * ASelf.FFactor;
{$ELSE}
  result := AMatrix * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AMatrix: TC3Matrix; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix * ASelf.FFactor;
{$ELSE}
  result := AMatrix * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AMatrix: TC4Matrix; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix * ASelf.FFactor;
{$ELSE}
  result := AMatrix * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AMatrix: TC2Matrix; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix / ASelf.FFactor;
{$ELSE}
  result := AMatrix / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AMatrix: TC3Matrix; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix / ASelf.FFactor;
{$ELSE}
  result := AMatrix / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AMatrix: TC4Matrix; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix / ASelf.FFactor;
{$ELSE}
  result := AMatrix / ASelf.FFactor;
{$ENDIF}
end;

// CL3 vector space, Clifford algebra

class operator TFactoredUnit.*(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

{$IFNDEF ADIMOFF}

// Real numbers

class operator TFactoredUnit.*(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

// Complex numbers

class operator TFactoredUnit.*(const AQuantity: TComplexQuantity; const ASelf: TFactoredUnit): TComplexQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TComplexQuantity; const ASelf: TFactoredUnit): TComplexQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

// Real vector space

class operator TFactoredUnit.*(const AQuantity: TR2VecQuantity; const ASelf: TFactoredUnit): TR2VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TR2VecQuantity; const ASelf: TFactoredUnit): TR2VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TR3VecQuantity; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TR3VecQuantity; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TR4VecQuantity; const ASelf: TFactoredUnit): TR4VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TR4VecQuantity; const ASelf: TFactoredUnit): TR4VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

// Complex vector space

class operator TFactoredUnit.*(const AQuantity: TC2VecQuantity; const ASelf: TFactoredUnit): TC2VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TC2VecQuantity; const ASelf: TFactoredUnit): TC2VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TC3VecQuantity; const ASelf: TFactoredUnit): TC3VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TC3VecQuantity; const ASelf: TFactoredUnit): TC3VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TC4VecQuantity; const ASelf: TFactoredUnit): TC4VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TC4VecQuantity; const ASelf: TFactoredUnit): TC4VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

// Real matrixes

class operator TFactoredUnit.*(const AQuantity: TR2MatrixQuantity; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TR2MatrixQuantity; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TR3MatrixQuantity; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TR3MatrixQuantity; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TR4MatrixQuantity; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TR4MatrixQuantity; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

// Complex matrixes

class operator TFactoredUnit.*(const AQuantity: TC2MatrixQuantity; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TC2MatrixQuantity; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TC3MatrixQuantity; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TC3MatrixQuantity; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TC4MatrixQuantity; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TC4MatrixQuantity; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

// CL3 vector space, Clifford algebra

class operator TFactoredUnit.*(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

{$ENDIF}

{ TDegreeCelsiusUnit }

class operator TDegreeCelsiusUnit.*(const AValue: double; const ASelf: TDegreeCelsiusUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue + 273.15;
{$ELSE}
  result := AValue + 273.15;
{$ENDIF}
end;

{ TDegreeFahrenheitUnit }

class operator TDegreeFahrenheitUnit.*(const AValue: double; const ASelf: TDegreeFahrenheitUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := 5/9 * (AValue - 32) + 273.15;
{$ELSE}
  result := 5/9 * (AValue - 32) + 273.15;
{$ENDIF}
end;

{ TUnitHelper }

function TUnitHelper.GetName(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(FPrefixes) of
    0: result := FName;
    1: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name]);
    2: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name]);
    3: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TUnitHelper.GetPluralName(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0: result := FPluralName;
    1: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name]);
    2: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name]);
    3: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TUnitHelper.GetSymbol(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0:  result := FSymbol;
    1:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol]);
    2:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol]);
    3:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol,
          PrefixTable[Prefixes[2]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TUnitHelper.GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
var
  I: longint;
  Exponent: longint;
  PrefixCount: longint;
begin
  PrefixCount := Length(APrefixes);
  if PrefixCount = Length(FPrefixes) then
  begin
    Exponent := 0;
    for I := 0 to PrefixCount -1 do
      Inc(Exponent, PrefixTable[FPrefixes[I]].Exponent * FExponents[I]);

    for I := 0 to PrefixCount -1 do
      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * FExponents[I]);

    if Exponent <> 0 then
      result := AQuantity * IntPower(10, Exponent)
    else
      result := AQuantity;

  end else
    if PrefixCount = 0 then
      result := AQuantity
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

function TUnitHelper.GetValue(const AQuantity: TComplex; const APrefixes: TPrefixes): TComplex;
begin
  result.fRe := GetValue(AQuantity.fRe, APrefixes);
  result.fIm := GetValue(AQuantity.fIm, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TR2Vector; const APrefixes: TPrefixes): TR2Vector;
begin
  result[1] := GetValue(AQuantity[1], APrefixes);
  result[2] := GetValue(AQuantity[2], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TR3Vector; const APrefixes: TPrefixes): TR3Vector;
begin
  result[1] := GetValue(AQuantity[1], APrefixes);
  result[2] := GetValue(AQuantity[2], APrefixes);
  result[3] := GetValue(AQuantity[3], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TR4Vector; const APrefixes: TPrefixes): TR4Vector;
begin
  result[1] := GetValue(AQuantity[1], APrefixes);
  result[2] := GetValue(AQuantity[2], APrefixes);
  result[3] := GetValue(AQuantity[3], APrefixes);
  result[4] := GetValue(AQuantity[4], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TC2Vector; const APrefixes: TPrefixes): TC2Vector;
begin
  result[1] := GetValue(AQuantity[1], APrefixes);
  result[2] := GetValue(AQuantity[2], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TC3Vector; const APrefixes: TPrefixes): TC3Vector;
begin
  result[1] := GetValue(AQuantity[1], APrefixes);
  result[2] := GetValue(AQuantity[2], APrefixes);
  result[3] := GetValue(AQuantity[3], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TC4Vector; const APrefixes: TPrefixes): TC4Vector;
begin
  result[1] := GetValue(AQuantity[1], APrefixes);
  result[2] := GetValue(AQuantity[2], APrefixes);
  result[3] := GetValue(AQuantity[3], APrefixes);
  result[4] := GetValue(AQuantity[4], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TR2Matrix; const APrefixes: TPrefixes): TR2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TR3Matrix; const APrefixes: TPrefixes): TR3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TR4Matrix; const APrefixes: TPrefixes): TR4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TC2Matrix; const APrefixes: TPrefixes): TC2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TC3Matrix; const APrefixes: TPrefixes): TC3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TC4Matrix; const APrefixes: TPrefixes): TC4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL3Vector; const APrefixes: TPrefixes): TCL3Vector;
begin
  result.fm1 := GetValue(AQuantity.fm1, APrefixes);
  result.fm2 := GetValue(AQuantity.fm2, APrefixes);
  result.fm3 := GetValue(AQuantity.fm3, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL3Bivector; const APrefixes: TPrefixes): TCL3Bivector;
begin
  result.fm12 := GetValue(AQuantity.fm12, APrefixes);
  result.fm13 := GetValue(AQuantity.fm13, APrefixes);
  result.fm23 := GetValue(AQuantity.fm23, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL3Trivector; const APrefixes: TPrefixes): TCL3Trivector;
begin
  result.fm123 := GetValue(AQuantity.fm123, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL3Multivector; const APrefixes: TPrefixes): TCL3Multivector;
begin
  result.fm0 := GetValue(AQuantity.fm0, APrefixes);
  result.fm1 := GetValue(AQuantity.fm1, APrefixes);
  result.fm2 := GetValue(AQuantity.fm2, APrefixes);
  result.fm3 := GetValue(AQuantity.fm3, APrefixes);
  result.fm12 := GetValue(AQuantity.fm12, APrefixes);
  result.fm13 := GetValue(AQuantity.fm13, APrefixes);
  result.fm23 := GetValue(AQuantity.fm23, APrefixes);
  result.fm123 := GetValue(AQuantity.fm123, APrefixes);
end;

// Real numbers

function TUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := FloatToStr(AQuantity.FValue) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;

function TUnitHelper.ToVerboseString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  if (AQuantity.FValue > -1) and (AQuantity.FValue < 1) then
    result := FloatToStr(AQuantity.FValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(AQuantity.FValue) + ' ' + GetPluralName(FPrefixes);
{$ELSE}
  if (AQuantity > -1) and (AQuantity < 1) then
    result := FloatToStr(AQuantity) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(AQuantity) + ' ' + GetPluralName(FPrefixes);
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(FPRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPRefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(APRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TUnitHelper.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(FPRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(FPRefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(APRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TUnitHelper.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

// Complex numbers

function TUnitHelper.ToComplex(const AQuantity: TComplexQuantity): TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToComplex(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TComplexQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TComplexQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TComplexQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetPluralName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPRefixes)
  else
    result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TComplexQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(FPrefixes)
  else
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

// Real vector space

function TUnitHelper.ToVector(const AQuantity: TR2VecQuantity): TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TR3VecQuantity): TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TR4VecQuantity): TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR2VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR4VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR2VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR4VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

// Complex vector space

function TUnitHelper.ToVector(const AQuantity: TC2VecQuantity): TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TC3VecQuantity): TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TC4VecQuantity): TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC2VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC4VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC2VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC4VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

// Real matrixes

function TUnitHelper.ToMatrix(const AQuantity: TR2MatrixQuantity): TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TR3MatrixQuantity): TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TR4MatrixQuantity): TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR2MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR3MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR4MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue : TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue : TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue : TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR2MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR3MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR4MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

// Complex matrixes

function TUnitHelper.ToMatrix(const AQuantity: TC2MatrixQuantity): TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TC3MatrixQuantity): TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TC4MatrixQuantity): TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC2MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC3MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC4MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue : TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue : TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue : TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC2MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC3MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC4MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

// CL3 vector space, Clifford algebra

function TUnitHelper.ToString(const AQuantity: TCL3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3BivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3TrivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3MultivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TUnitHelper.ToString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TUnitHelper.ToString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TUnitHelper.ToString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetPluralName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3BivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetPluralName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetPluralName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetPluralName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

{ TFactoredUnitHelper }

function TFactoredUnitHelper.GetName(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0:  result := FName;
    1:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TFactoredUnitHelper.GetPluralName(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0:  result := FPluralName;
    1:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TFactoredUnitHelper.GetSymbol(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0:  result := FSymbol;
    1:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol]);
    2:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol]);
    3:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol,
          PrefixTable[Prefixes[2]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TFactoredUnitHelper.GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
var
  I: longint;
  Exponent: longint;
  PrefixCount: longint;
begin
  PrefixCount := Length(APrefixes);
  if PrefixCount = Length(FPrefixes) then
  begin
    Exponent := 0;
    for I := 0 to PrefixCount -1 do
      Inc(Exponent, PrefixTable[FPrefixes[I]].Exponent * FExponents[I]);

    for I := 0 to PrefixCount -1 do
      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * FExponents[I]);

    if Exponent <> 0 then
      result := AQuantity * IntPower(10, Exponent)
    else
      result := AQuantity;

  end else
    if PrefixCount = 0 then
      result := AQuantity
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TComplex; const APrefixes: TPrefixes): TComplex;
begin
  result.FRe := GetValue(AQuantity.FRe, APrefixes);
  result.FIm := GetValue(AQuantity.FIm, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TR2Vector; const APrefixes: TPrefixes): TR2Vector;
var
  i: longint;
begin
  for i := 1 to 2 do
    result[i] := GetValue(AQuantity[i], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TR3Vector; const APrefixes: TPrefixes): TR3Vector;
var
  i: longint;
begin
  for i := 1 to 3 do
    result[i] := GetValue(AQuantity[i], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TR4Vector; const APrefixes: TPrefixes): TR4Vector;
var
  i: longint;
begin
  for i := 1 to 4 do
    result[i] := GetValue(AQuantity[i], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TC2Vector; const APrefixes: TPrefixes): TC2Vector;
var
  i: longint;
begin
  for i := 1 to 2 do
    result[i] := GetValue(AQuantity[i], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TC3Vector; const APrefixes: TPrefixes): TC3Vector;
var
  i: longint;
begin
  for i := 1 to 3 do
    result[i] := GetValue(AQuantity[i], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TC4Vector; const APrefixes: TPrefixes): TC4Vector;
var
  i: longint;
begin
  for i := 1 to 4 do
    result[i] := GetValue(AQuantity[i], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TR2Matrix; const APrefixes: TPrefixes): TR2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TR3Matrix; const APrefixes: TPrefixes): TR3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TR4Matrix; const APrefixes: TPrefixes): TR4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TC2Matrix; const APrefixes: TPrefixes): TC2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TC3Matrix; const APrefixes: TPrefixes): TC3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TC4Matrix; const APrefixes: TPrefixes): TC4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL3Vector; const APrefixes: TPrefixes): TCL3Vector;
begin
  result.fm1 := GetValue(AQuantity.fm1, APrefixes);
  result.fm2 := GetValue(AQuantity.fm2, APrefixes);
  result.fm3 := GetValue(AQuantity.fm3, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL3Bivector; const APrefixes: TPrefixes): TCL3Bivector;
begin
  result.fm12 := GetValue(AQuantity.fm12, APrefixes);
  result.fm13 := GetValue(AQuantity.fm13, APrefixes);
  result.fm23 := GetValue(AQuantity.fm23, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL3Trivector; const APrefixes: TPrefixes): TCL3Trivector;
begin
  result.fm123 := GetValue(AQuantity.fm123, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL3Multivector; const APrefixes: TPrefixes): TCL3Multivector;
begin
  result.fm0 := GetValue(AQuantity.fm0, APrefixes);
  result.fm1 := GetValue(AQuantity.fm1, APrefixes);
  result.fm2 := GetValue(AQuantity.fm2, APrefixes);
  result.fm3 := GetValue(AQuantity.fm3, APrefixes);
  result.fm12 := GetValue(AQuantity.fm12, APrefixes);
  result.fm13 := GetValue(AQuantity.fm13, APrefixes);
  result.fm23 := GetValue(AQuantity.fm23, APrefixes);
  result.fm123 := GetValue(AQuantity.fm123, APrefixes);
end;

// Real numbers

function TFactoredUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := FloatToStr(AQuantity.FValue / FFactor) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity / FFactor) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
   Check(FDim, AQuantity.FDim);
   FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
   FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TQuantity): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(APRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(APRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

// Complex numbers

function TFactoredUnitHelper.ToComplex(const AQuantity: TComplexQuantity): TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToComplex(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TComplexQuantity): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
  else
    result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TComplexQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(FPrefixes)
  else
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TComplexQuantity): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
  else
    result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TComplexQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(FPrefixes)
  else
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

// Real vector space

function TFactoredUnitHelper.ToVector(const AQuantity: TR2VecQuantity): TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TR3VecQuantity): TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TR4VecQuantity): TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR2VecQuantity): string;
var
  FactoredValue: TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR3VecQuantity): string;
var
  FactoredValue: TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR4VecQuantity): string;
var
  FactoredValue: TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR2VecQuantity): string;
var
  FactoredValue: TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR3VecQuantity): string;
var
  FactoredValue: TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR4VecQuantity): string;
var
  FactoredValue: TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

// Complex vector space

function TFactoredUnitHelper.ToVector(const AQuantity: TC2VecQuantity): TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TC3VecQuantity): TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TC4VecQuantity): TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC2VecQuantity): string;
var
  FactoredValue: TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC3VecQuantity): string;
var
  FactoredValue: TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC4VecQuantity): string;
var
  FactoredValue: TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC2VecQuantity): string;
var
  FactoredValue: TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC3VecQuantity): string;
var
  FactoredValue: TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC4VecQuantity): string;
var
  FactoredValue: TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

// Real matrixes

function TFactoredUnitHelper.ToMatrix(const AQuantity: TR2MatrixQuantity): TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TR3MatrixQuantity): TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TR4MatrixQuantity): TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR2MatrixQuantity): string;
var
  FactoredValue: TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR3MatrixQuantity): string;
var
  FactoredValue: TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR4MatrixQuantity): string;
var
  FactoredValue: TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR2MatrixQuantity): string;
var
  FactoredValue: TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR3MatrixQuantity): string;
var
  FactoredValue: TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR4MatrixQuantity): string;
var
  FactoredValue: TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

// Complex matrixes

function TFactoredUnitHelper.ToMatrix(const AQuantity: TC2MatrixQuantity): TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TC3MatrixQuantity): TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TC4MatrixQuantity): TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC2MatrixQuantity): string;
var
  FactoredValue: TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC3MatrixQuantity): string;
var
  FactoredValue: TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC4MatrixQuantity): string;
var
  FactoredValue: TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC2MatrixQuantity): string;
var
  FactoredValue: TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC3MatrixQuantity): string;
var
  FactoredValue: TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC4MatrixQuantity): string;
var
  FactoredValue: TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

// CL3 vector space, Cliffor algebra

function TFactoredUnitHelper.ToString(const AQuantity: TCL3VecQuantity): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3BivecQuantity): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3TrivecQuantity): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3MultivecQuantity): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3VecQuantity): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3BivecQuantity): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

{ TDegreeCelsiusUnitHelper }

function TDegreeCelsiusUnitHelper.GetName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FName;
    1:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TDegreeCelsiusUnitHelper.GetPluralName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FPluralName;
    1:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TDegreeCelsiusUnitHelper.GetSymbol(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FSymbol;
    1:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol]);
    2:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol]);
    3:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol,
          PrefixTable[Prefixes[2]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TDegreeCelsiusUnitHelper.GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
var
  I: longint;
  Exponent: longint;
  PrefixCount: longint;
begin
  PrefixCount := Length(APrefixes);
  if PrefixCount = Length(FPrefixes) then
  begin
    Exponent := 0;
    for I := 0 to PrefixCount -1 do
      Inc(Exponent, PrefixTable[FPrefixes[I]].Exponent * FExponents[I]);

    for I := 0 to PrefixCount -1 do
      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * FExponents[I]);

    if Exponent <> 0 then
      result := AQuantity * IntPower(10, Exponent)
    else
      result := AQuantity;

  end else
    if PrefixCount = 0 then
      result := AQuantity
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

function TDegreeCelsiusUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue - 273.15;
{$ELSE}
  result := AQuantity - 273.15;
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  result := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := FloatToStr(AQuantity.FValue - 273.15) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity - 273.15) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TQuantity): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue - 273.15;
{$ELSE}
  FactoredValue := AQuantity - 273.15;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(APRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(APRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

{ TDegreeFahrenheitUnitHelper }

function TDegreeFahrenheitUnitHelper.GetName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FName;
    1:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TDegreeFahrenheitUnitHelper.GetPluralName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FPluralName;
    1:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TDegreeFahrenheitUnitHelper.GetSymbol(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FSymbol;
    1:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol]);
    2:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol]);
    3:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol,
          PrefixTable[Prefixes[2]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TDegreeFahrenheitUnitHelper.GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
var
  I: longint;
  Exponent: longint;
  PrefixCount: longint;
begin
  PrefixCount := Length(APrefixes);
  if PrefixCount = Length(FPrefixes) then
  begin
    Exponent := 0;
    for I := 0 to PrefixCount -1 do
      Inc(Exponent, PrefixTable[FPrefixes[I]].Exponent * FExponents[I]);

    for I := 0 to PrefixCount -1 do
      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * FExponents[I]);

    if Exponent <> 0 then
      result := AQuantity * IntPower(10, Exponent)
    else
      result := AQuantity;

  end else
    if PrefixCount = 0 then
      result := AQuantity
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

function TDegreeFahrenheitUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := 9/5 * AQuantity.FValue - 459.67;
{$ELSE}
  result := 9/5 * AQuantity - 459.67;
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  result := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := FloatToStr(9/5 * AQuantity.FValue - 459.67) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(9/5 * AQuantity - 459.67) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
  FactoredTol   := GetValue(9/5 * ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
  FactoredTol   := GetValue(9/5 * ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TQuantity): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := 9/5 * AQuantity.FValue - 459.67;
{$ELSE}
  FactoredValue := 9/5 * AQuantity - 459.67;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(APRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(APRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
  FactoredTol   := GetValue(9/5 * ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
  FactoredTol   := GetValue(9/5 * ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

{ Power functions }

function SquarePower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 2;
  result.FValue := IntPower(AQuantity.FValue, 2);
{$ELSE}
  result := IntPower(AQuantity, 2);
{$ENDIF}
end;

function CubicPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 3;
  result.FValue := IntPower(AQuantity.FValue, 3);
{$ELSE}
  result := IntPower(AQuantity, 3);
{$ENDIF}
end;

function QuarticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 4;
  result.FValue := IntPower(AQuantity.FValue, 4);
{$ELSE}
  result := IntPower(AQuantity, 4);
{$ENDIF}
end;

function QuinticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 5;
  result.FValue := IntPower(AQuantity.FValue, 5);
{$ELSE}
  result := IntPower(AQuantity, 5);
{$ENDIF}
end;

function SexticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 6;
  result.FValue := IntPower(AQuantity.FValue, 6);
{$ELSE}
  result := IntPower(AQuantity, 6);
{$ENDIF}
end;

function SquareRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 2;
  result.FValue := Power(AQuantity.FValue, 1/2);
{$ELSE};
  result := Power(AQuantity, 1/2);
{$ENDIF}
end;

function CubicRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 3;
  result.FValue := Power(AQuantity.FValue, 1/3);
{$ELSE}
  result := Power(AQuantity, 1/3);
{$ENDIF}
end;

function QuarticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 4;
  result.FValue := Power(AQuantity.FValue, 1/4);
{$ELSE}
  result := Power(AQuantity, 1/4);
{$ENDIF}
end;

function QuinticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 5;
  result.FValue := Power(AQuantity.FValue, 1/5);
{$ELSE}
  result := Power(AQuantity, 1/5);
{$ENDIF}
end;

function SexticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 6;
  result.FValue := Power(AQuantity.FValue, 1/6);
{$ELSE}
  result := Power(AQuantity, 1/6);
{$ENDIF}
end;

{ Trigonometric functions }

function Cos(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := System.Cos(AQuantity.FValue);
{$ELSE}
  result := System.Cos(AQuantity);
{$ENDIF}
end;

function Sin(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := System.Sin(AQuantity.FValue);
{$ELSE}
  result := System.Sin(AQuantity);
{$ENDIF}
end;

function Tan(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Tan(AQuantity.FValue);
{$ELSE}
  result := Math.Tan(AQuantity);
{$ENDIF}
end;

function Cotan(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Cotan(AQuantity.FValue);
{$ELSE}
  result := Math.Cotan(AQuantity);
{$ENDIF}
end;

function Secant(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Secant(AQuantity.FValue);
{$ELSE}
  result := Math.Secant(AQuantity);
{$ENDIF}
end;

function Cosecant(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Cosecant(AQuantity.FValue);
{$ELSE}
  result := Math.Cosecant(AQuantity);
{$ENDIF}
end;

function ArcCos(const AValue: double): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ScalarUnit.FDim;
  result.FValue := Math.ArcCos(AValue);
{$ELSE}
  result := Math.ArcCos(AValue);
{$ENDIF}
end;

function ArcSin(const AValue: double): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ScalarUnit.FDim;
  result.FValue := Math.ArcSin(AValue);
{$ELSE}
  result := Math.ArcSin(AValue);
{$ENDIF}
end;

function ArcTan(const AValue: double): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ScalarUnit.FDim;
  result.FValue := System.ArcTan(AValue);
{$ELSE}
  result := System.ArcTan(AValue);
{$ENDIF}
end;

function ArcTan2(const x, y: double): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ScalarUnit.FDim;
  result.FValue := Math.ArcTan2(x, y);
{$ELSE}
  result := Math.ArcTan2(x, y);
{$ENDIF}
end;

{ Math functions }

function Min(const ALeft, ARight: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := Math.Min(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.Min(ALeft, ARight);
{$ENDIF}
end;

function Max(const ALeft, ARight: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := Math.Max(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.Max(ALeft, ARight);
{$ENDIF}
end;

function Exp(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckSum(ScalarUnit.FDim, AQuantity.FDim);
  result.FValue := System.Exp(AQuantity.FValue);
{$ELSE}
  result := System.Exp(AQuantity);
{$ENDIF}
end;

function Log10(const AQuantity : TQuantity) : double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Log10(AQuantity.FValue);
{$ELSE}
  result := Math.Log10(AQuantity);
{$ENDIF}
end;

function Log2(const AQuantity : TQuantity) : double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Log2(AQuantity.FValue);
{$ELSE}
  result := Math.Log2(AQuantity);
{$ENDIF}
end;

function LogN(ABase: longint; const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.LogN(ABase, AQuantity.FValue);
{$ELSE}
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function LogN(const ABase, AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, ABase.FDim);
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.LogN(ABase.FValue, AQuantity.FValue);
{$ELSE}
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function Power(const ABase: TQuantity; AExponent: double): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, ABase.FDim);
  result := Math.Power(ABase.FValue, AExponent);
{$ELSE}
  result := Math.Power(ABase, AExponent);
{$ENDIF}
end;

{ Helper functions }

function LessThanOrEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue <= 0;
{$ELSE}
  result := AQuantity <= 0;
{$ENDIF}
end;

function LessThanZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue < 0;
{$ELSE}
  result := AQuantity < 0;
{$ENDIF}
end;

function EqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue = 0;
{$ELSE}
  result := AQuantity = 0;
{$ENDIF}
end;

function NotEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue <> 0;
{$ELSE}
  result := AQuantity <> 0;
{$ENDIF}
end;

function GreaterThanOrEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue >= 0;
{$ELSE}
  result := AQuantity >= 0;
{$ENDIF}
end;

function GreaterThanZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue > 0;
{$ELSE}
  result := AQuantity > 0;
{$ENDIF}
end;

end.
