{
  Description: ADim (CL3) Run-time library.

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
{$modeswitch typehelpers}
{$modeswitch advancedrecords}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function's return value.

{
  ADim Run-time library built on 8-1-25.

  Number of base units: 207
  Number of factored units: 123
}

interface

uses CL3, SysUtils;

type
  { Prefix }
  TPrefix = (pQuetta, pRonna, pYotta, pZetta, pExa, pPeta, pTera, pGiga, pMega, pKilo, pHecto, pDeca,
    pNone, pDeci, pCenti, pMilli, pMicro, pNano, pPico, pFemto, pAtto, pZepto, pYocto, pRonto, pQuecto);

  { Prefixes }
  TPrefixes = array of TPrefix;

  { Exponents }
  TExponents = array of longint;

  { TQuantity }

  {$IFDEF ADIMDEBUG}
  TQuantity = record
  private
    FUnitOfMeasurement: longint;
    FValue: double;
  public
    class operator + (const ASelf: TQuantity): TQuantity;
    class operator - (const ASelf: TQuantity): TQuantity;
    class operator + (const ALeft, ARight: TQuantity): TQuantity;
    class operator - (const ALeft, ARight: TQuantity): TQuantity;
    class operator * (const ALeft, ARight: TQuantity): TQuantity;
    class operator / (const ALeft, ARight: TQuantity): TQuantity;
    class operator * (const ALeft: double; const ARight: TQuantity): TQuantity;
    class operator / (const ALeft: double; const ARight: TQuantity): TQuantity;
    class operator * (const ALeft: TQuantity; const ARight: double): TQuantity;
    class operator / (const ALeft: TQuantity; const ARight: double): TQuantity;

    class operator = (const ALeft, ARight: TQuantity): boolean;
    class operator < (const ALeft, ARight: TQuantity): boolean;
    class operator > (const ALeft, ARight: TQuantity): boolean;
    class operator <=(const ALeft, ARight: TQuantity): boolean;
    class operator >=(const ALeft, ARight: TQuantity): boolean;
    class operator <>(const ALeft, ARight: TQuantity): boolean;
    class operator :=(const AValue: double): TQuantity;
  end;
  {$ELSE}
  TQuantity = double;
  {$ENDIF}

  { TMultivecQuantity }

  {$IFDEF ADIMDEBUG}
  TMultivecQuantity = record
  private
    FUnitOfMeasurement: longint;
    FValue: TMultivector;
  public
    class operator :=(const AValue: TQuantity): TMultivecQuantity;
    class operator <>(const ALeft, ARight: TMultivecQuantity): boolean;
    class operator <>(const ALeft: TMultivecQuantity; const ARight: TQuantity): boolean;
    class operator <>(const ALeft: TQuantity; const ARight: TMultivecQuantity): boolean;

    class operator = (const ALeft, ARight: TMultivecQuantity): boolean;
    class operator = (const ALeft: TMultivecQuantity; const ARight: TQuantity): boolean;
    class operator = (const ALeft: TQuantity; const ARight: TMultivecQuantity): boolean;

    class operator + (const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;

    class operator - (const ASelf: TMultivecQuantity): TMultivecQuantity;
    class operator - (const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;

    class operator * (const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;

    class operator / (const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
  end;
  {$ELSE}
  TMultivecQuantity = TMultivector;
  {$ENDIF}

  { TTrivecQuantity }

  {$IFDEF ADIMDEBUG}
  TTrivecQuantity = record
  private
    FUnitOfMeasurement: longint;
    FValue: TTrivector;
  public
    class operator :=(const AValue: TTrivecQuantity): TMultivecQuantity;
    class operator <>(const ALeft, ARight: TTrivecQuantity): boolean;
    class operator <>(const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): boolean;
    class operator <>(const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): boolean;

    class operator = (const ALeft, ARight: TTrivecQuantity): boolean;
    class operator = (const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): boolean;
    class operator = (const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): boolean;

    class operator + (const ALeft, ARight: TTrivecQuantity): TTrivecQuantity;
    class operator + (const ALeft: TTrivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;

    class operator - (const ASelf: TTrivecQuantity): TTrivecQuantity;
    class operator - (const ALeft, ARight: TTrivecQuantity): TTrivecQuantity;
    class operator - (const ALeft: TTrivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;

    class operator * (const ALeft, ARight: TTrivecQuantity): TQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TTrivecQuantity): TTrivecQuantity;
    class operator * (const ALeft: TTrivecQuantity; const ARight: TQuantity): TTrivecQuantity;
    class operator * (const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;

    class operator / (const ALeft, ARight: TTrivecQuantity): TQuantity;
    class operator / (const ALeft: TTrivecQuantity; const ARight: TQuantity): TTrivecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TTrivecQuantity): TTrivecQuantity;
    class operator / (const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
  end;
  {$ELSE}
  TTrivecQuantity = TTrivector;
  {$ENDIF}

  { TBivecQuantity }

  {$IFDEF ADIMDEBUG}
  TBivecQuantity = record
  private
    FUnitOfMeasurement: longint;
    FValue: TBivector;
  public
    class operator :=(const AValue: TBivecQuantity): TMultivecQuantity;
    class operator <>(const ALeft, ARight: TBivecQuantity): boolean;
    class operator <>(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): boolean;
    class operator <>(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): boolean;

    class operator = (const ALeft, ARight: TBivecQuantity): boolean;
    class operator = (const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): boolean;
    class operator = (const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): boolean;

    class operator + (const ALeft, ARight: TBivecQuantity): TBivecQuantity;
    class operator + (const ALeft: TBivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;

    class operator - (const ASelf: TBivecQuantity): TBivecQuantity;
    class operator - (const ALeft, ARight: TBivecQuantity): TBivecQuantity;
    class operator - (const ALeft: TBivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;

    class operator * (const ALeft, ARight: TBivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TBivecQuantity): TBivecQuantity;
    class operator * (const ALeft: TBivecQuantity; const ARight: TQuantity): TBivecQuantity;
    class operator * (const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;

    class operator / (const ALeft, ARight: TBivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TBivecQuantity; const ARight: TQuantity): TBivecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TBivecQuantity): TBivecQuantity;
    class operator / (const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
  end;
  {$ELSE}
  TBivecQuantity = TBivector;
  {$ENDIF}

  { TVecQuantity }

  {$IFDEF ADIMDEBUG}
  TVecQuantity = record
  private
    FUnitOfMeasurement: longint;
    FValue: TVector;
  public
    class operator :=(const AValue: TVecQuantity): TMultivecQuantity;
    class operator <>(const ALeft, ARight: TVecQuantity): boolean;
    class operator <>(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): boolean;
    class operator <>(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): boolean;

    class operator = (const ALeft, ARight: TVecQuantity): boolean;
    class operator = (const ALeft: TVecQuantity; const ARight: TMultivecQuantity): boolean;
    class operator = (const ALeft: TMultivecQuantity; const ARight: TVecQuantity): boolean;

    class operator + (const ALeft, ARight: TVecQuantity): TVecQuantity;
    class operator + (const ALeft: TVecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;

    class operator - (const ASelf: TVecQuantity): TVecQuantity;
    class operator - (const ALeft, ARight: TVecQuantity): TVecQuantity;
    class operator - (const ALeft: TVecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;

    class operator * (const ALeft, ARight: TVecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TVecQuantity): TVecQuantity;
    class operator * (const ALeft: TVecQuantity; const ARight: TQuantity): TVecQuantity;
    class operator * (const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TBivecQuantity;
    class operator * (const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TBivecQuantity;
    class operator * (const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;

    class operator / (const ALeft: TQuantity; const ARight: TVecQuantity): TVecQuantity;
    class operator / (const ALeft: TVecQuantity; const ARight: TQuantity): TVecQuantity;
    class operator / (const ALeft, ARight: TVecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TBivecQuantity;
    class operator / (const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TBivecQuantity;
    class operator / (const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
  end;
  {$ELSE}
  TVecQuantity = TVector;
  {$ENDIF}

  { TMultivecQuantityHelper }

  {$IFDEF ADIMDEBUG}
  TMultivecQuantityHelper = record helper for TMultivecQuantity
    function Dual: TMultivecQuantity;
    function Inverse: TMultivecQuantity;
    function Reverse: TMultivecQuantity;
    function Conjugate: TMultivecQuantity;
    function Reciprocal: TMultivecQuantity;
    function LeftReciprocal: TMultivecQuantity;
    function Normalized: TMultivecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TVecQuantity): TMultivecQuantity; overload;
    function Dot(const AVector: TBivecQuantity): TMultivecQuantity; overload;
    function Dot(const AVector: TTrivecQuantity): TMultivecQuantity; overload;
    function Dot(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Wedge(const AVector: TVecQuantity): TMultivecQuantity; overload;
    function Wedge(const AVector: TBivecQuantity): TMultivecQuantity; overload;
    function Wedge(const AVector: TTrivecQuantity): TTrivecQuantity; overload;
    function Wedge(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Projection(const AVector: TVecQuantity): TMultivecQuantity; overload;
    function Projection(const AVector: TBivecQuantity): TMultivecQuantity; overload;
    function Projection(const AVector: TTrivecQuantity): TMultivecQuantity; overload;
    function Projection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Rejection(const AVector: TVecQuantity): TMultivecQuantity; overload;
    function Rejection(const AVector: TBivecQuantity): TMultivecQuantity; overload;
    function Rejection(const AVector: TTrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Reflection(const AVector: TVecQuantity): TMultivecQuantity; overload;
    function Reflection(const AVector: TBivecQuantity): TMultivecQuantity; overload;
    function Reflection(const AVector: TTrivecQuantity): TMultivecQuantity; overload;
    function Reflection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TVecQuantity): TMultivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TBivecQuantity): TMultivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TTrivecQuantity): TMultivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TMultivecQuantity): TMultivecQuantity;overload;

    function SameValue(const AVector: TMultivecQuantity): boolean;
    function SameValue(const AVector: TTrivecQuantity): boolean;
    function SameValue(const AVector: TBivecQuantity): boolean;
    function SameValue(const AVector: TVecQuantity): boolean;
    function SameValue(const AVector: TQuantity): boolean;

    function ExtractMultivector(AComponents: TMultivectorComponents): TMultivecQuantity;
    function ExtractBivector(AComponents: TMultivectorComponents): TBivecQuantity;
    function ExtractVector(AComponents: TMultivectorComponents): TVecQuantity;

    function ExtractTrivector: TTrivecQuantity;
    function ExtractBivector: TBivecQuantity;
    function ExtractVector: TVecQuantity;
    function ExtractScalar: TQuantity;

    function IsNull: boolean;
    function IsScalar: boolean;
    function IsVector: boolean;
    function IsBiVector: boolean;
    function IsTrivector: boolean;
    function IsA: string;
  end;
  {$ENDIF}

  { TTrivecQuantityHelper }

  {$IFDEF ADIMDEBUG}
  TTrivecQuantityHelper = record helper for TTrivecQuantity
    function Dual: TQuantity;
    function Inverse: TTrivecQuantity;
    function Reverse: TTrivecQuantity;
    function Conjugate: TTrivecQuantity;
    function Reciprocal: TTrivecQuantity;
    function Normalized: TTrivecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TVecQuantity): TBivecQuantity; overload;
    function Dot(const AVector: TBivecQuantity): TVecQuantity; overload;
    function Dot(const AVector: TTrivecQuantity): TQuantity; overload;
    function Dot(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Wedge(const AVector: TVecQuantity): TQuantity; overload;
    function Wedge(const AVector: TBivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TTrivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TMultivecQuantity): TTrivecQuantity; overload;

    function Projection(const AVector: TVecQuantity): TTrivecQuantity; overload;
    function Projection(const AVector: TBivecQuantity): TTrivecQuantity; overload;
    function Projection(const AVector: TTrivecQuantity): TTrivecQuantity; overload;
    function Projection(const AVector: TMultivecQuantity): TTrivecQuantity; overload;

    function Rejection(const AVector: TVecQuantity): TQuantity; overload;
    function Rejection(const AVector: TBivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TTrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Reflection(const AVector: TVecQuantity): TTrivecQuantity; overload;
    function Reflection(const AVector: TBivecQuantity): TTrivecQuantity; overload;
    function Reflection(const AVector: TTrivecQuantity): TTrivecQuantity; overload;
    function Reflection(const AVector: TMultivecQuantity): TTrivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TVecQuantity): TTrivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TBivecQuantity): TTrivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TTrivecQuantity): TTrivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TMultivecQuantity): TTrivecQuantity; overload;

    function SameValue(const AVector: TMultivecQuantity): boolean;
    function SameValue(const AVector: TTrivecQuantity): boolean;

    function ToMultivector: TMultivecQuantity;
  end;
  {$ENDIF}

  { TBivecQuantityHelper }

  {$IFDEF ADIMDEBUG}
  TBivecQuantityHelper = record helper for TBivecQuantity
    function Dual: TVecQuantity;
    function Inverse: TBivecQuantity;
    function Reverse: TBivecQuantity;
    function Conjugate: TBivecQuantity;
    function Reciprocal: TBivecQuantity;
    function Normalized: TBivecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TVecQuantity): TVecQuantity; overload;
    function Dot(const AVector: TBivecQuantity): TQuantity; overload;
    function Dot(const AVector: TTrivecQuantity): TVecQuantity; overload;
    function Dot(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Wedge(const AVector: TVecQuantity): TTrivecQuantity; overload;
    function Wedge(const AVector: TBivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TTrivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Projection(const AVector: TVecQuantity): TBivecQuantity; overload;
    function Projection(const AVector: TBivecQuantity): TBivecQuantity; overload;
    function Projection(const AVector: TTrivecQuantity): TBivecQuantity; overload;
    function Projection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Rejection(const AVector: TVecQuantity): TBivecQuantity; overload;
    function Rejection(const AVector: TBivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TTrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Reflection(const AVector: TVecQuantity): TBivecQuantity; overload;
    function Reflection(const AVector: TBivecQuantity): TBivecQuantity; overload;
    function Reflection(const AVector: TTrivecQuantity): TBivecQuantity; overload;
    function Reflection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TVecQuantity): TBivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TBivecQuantity): TBivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TTrivecQuantity): TBivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TMultivecQuantity): TMultivecQuantity; overload;

    function SameValue(const AVector: TMultivecQuantity): boolean;
    function SameValue(const AVector: TBivecQuantity): boolean;

    function ExtractBivector(AComponents: TMultivectorComponents): TBivecQuantity;

    function ToMultivector: TMultivecQuantity;
  end;
  {$ENDIF}

  { TVecQuantityHelper }

  {$IFDEF ADIMDEBUG}
  TVecQuantityHelper = record helper for TVecQuantity
    function Dual: TBivecQuantity;
    function Inverse: TVecQuantity;
    function Reverse: TVecQuantity;
    function Conjugate: TVecQuantity;
    function Reciprocal: TVecQuantity;
    function Normalized: TVecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TVecQuantity): TQuantity; overload;
    function Dot(const AVector: TBivecQuantity): TVecQuantity; overload;
    function Dot(const AVector: TTrivecQuantity): TBivecQuantity; overload;
    function Dot(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Wedge(const AVector: TVecQuantity): TBivecQuantity; overload;
    function Wedge(const AVector: TBivecQuantity): TTrivecQuantity; overload;
    function Wedge(const AVector: TTrivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Cross(const AVector: TVecQuantity): TVecQuantity;

    function Projection(const AVector: TVecQuantity): TVecQuantity; overload;
    function Projection(const AVector: TBivecQuantity): TVecQuantity; overload;
    function Projection(const AVector: TTrivecQuantity): TVecQuantity; overload;
    function Projection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Rejection(const AVector: TVecQuantity): TVecQuantity; overload;
    function Rejection(const AVector: TBivecQuantity): TVecQuantity; overload;
    function Rejection(const AVector: TTrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Reflection(const AVector: TVecQuantity): TVecQuantity; overload;
    function Reflection(const AVector: TBivecQuantity): TVecQuantity; overload;
    function Reflection(const AVector: TTrivecQuantity): TVecQuantity; overload;
    function Reflection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TVecQuantity): TVecQuantity; overload;
    function Rotation(const AVector1, AVector2: TBivecQuantity): TVecQuantity; overload;
    function Rotation(const AVector1, AVector2: TTrivecQuantity): TVecQuantity; overload;
    function Rotation(const AVector1, AVector2: TMultivecQuantity): TMultivecQuantity; overload;

    function SameValue(const AVector: TMultivecQuantity): boolean;
    function SameValue(const AVector: TVecQuantity): boolean;

    function ExtractVector(AComponents: TMultivectorComponents): TVecQuantity;

    function ToMultivector: TMultivecQuantity;
  end;
  {$ENDIF}

  { TUnit }

  TUnit = record
  private
    FUnitOfMeasurement: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    class operator *(const AQuantity: double; const ASelf: TUnit): TQuantity; inline;
    class operator /(const AQuantity: double; const ASelf: TUnit): TQuantity; inline;
    class operator *(const AQuantity: TVector; const ASelf: TUnit): TVecQuantity; inline;
    class operator /(const AQuantity: TVector; const ASelf: TUnit): TVecQuantity; inline;
    class operator *(const AQuantity: TBivector; const ASelf: TUnit): TBivecQuantity; inline;
    class operator /(const AQuantity: TBivector; const ASelf: TUnit): TBivecQuantity; inline;
    class operator *(const AQuantity: TTrivector; const ASelf: TUnit): TTrivecQuantity; inline;
    class operator /(const AQuantity: TTrivector; const ASelf: TUnit): TTrivecQuantity; inline;
    class operator *(const AQuantity: TMultivector; const ASelf: TUnit): TMultivecQuantity; inline;
    class operator /(const AQuantity: TMultivector; const ASelf: TUnit): TMultivecQuantity; inline;
  {$IFDEF ADIMDEBUG}
    class operator *(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
    class operator /(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
    class operator *(const AQuantity: TVecQuantity; const ASelf: TUnit): TVecQuantity; inline;
    class operator /(const AQuantity: TVecQuantity; const ASelf: TUnit): TVecQuantity; inline;
    class operator *(const AQuantity: TBivecQuantity; const ASelf: TUnit): TBivecQuantity; inline;
    class operator /(const AQuantity: TBivecQuantity; const ASelf: TUnit): TBivecQuantity; inline;
    class operator *(const AQuantity: TTrivecQuantity; const ASelf: TUnit): TTrivecQuantity; inline;
    class operator /(const AQuantity: TTrivecQuantity; const ASelf: TUnit): TTrivecQuantity; inline;
    class operator *(const AQuantity: TMultivecQuantity; const ASelf: TUnit): TMultivecQuantity; inline;
    class operator /(const AQuantity: TMultivecQuantity; const ASelf: TUnit): TMultivecQuantity; inline;
  {$ENDIF}
  end;

  { TFactoredUnit }

  TFactoredUnit = record
  private
    FUnitOfMeasurement: longint;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
    FFactor: double;
  public
    class operator *(const AQuantity: double; const ASelf: TFactoredUnit): TQuantity; inline;
    class operator /(const AQuantity: double; const ASelf: TFactoredUnit): TQuantity; inline;
    class operator *(const AQuantity: TVector; const ASelf: TFactoredUnit): TVecQuantity; inline;
    class operator /(const AQuantity: TVector; const ASelf: TFactoredUnit): TVecQuantity; inline;
    class operator *(const AQuantity: TBivector; const ASelf: TFactoredUnit): TBivecQuantity; inline;
    class operator /(const AQuantity: TBivector; const ASelf: TFactoredUnit): TBivecQuantity; inline;
    class operator *(const AQuantity: TTrivector; const ASelf: TFactoredUnit): TTrivecQuantity; inline;
    class operator /(const AQuantity: TTrivector; const ASelf: TFactoredUnit): TTrivecQuantity; inline;
    class operator *(const AQuantity: TMultivector; const ASelf: TFactoredUnit): TMultivecQuantity; inline;
    class operator /(const AQuantity: TMultivector; const ASelf: TFactoredUnit): TMultivecQuantity; inline;
  {$IFDEF ADIMDEBUG}
    class operator *(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
    class operator /(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
    class operator *(const AQuantity: TVecQuantity; const ASelf: TFactoredUnit): TVecQuantity; inline;
    class operator /(const AQuantity: TVecQuantity; const ASelf: TFactoredUnit): TVecQuantity; inline;
    class operator *(const AQuantity: TBivecQuantity; const ASelf: TFactoredUnit): TBivecQuantity; inline;
    class operator /(const AQuantity: TBivecQuantity; const ASelf: TFactoredUnit): TBivecQuantity; inline;
    class operator *(const AQuantity: TTrivecQuantity; const ASelf: TFactoredUnit): TTrivecQuantity; inline;
    class operator /(const AQuantity: TTrivecQuantity; const ASelf: TFactoredUnit): TTrivecQuantity; inline;
    class operator *(const AQuantity: TMultivecQuantity; const ASelf: TFactoredUnit): TMultivecQuantity; inline;
    class operator /(const AQuantity: TMultivecQuantity; const ASelf: TFactoredUnit): TMultivecQuantity; inline;
  {$ENDIF}
  end;

  { TDegreeCelsiusUnit }

  TDegreeCelsiusUnit = record
  private
    FUnitOfMeasurement: longint;
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
    FUnitOfMeasurement: longint;
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
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
  public
    procedure Check(var AQuantity: TQuantity);
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
    function ToString(const AQuantity: TBivecQuantity): string;
    function ToString(const AQuantity: TTrivecQuantity): string;
    function ToString(const AQuantity: TMultivecQuantity): string;

    function ToVerboseString(const AQuantity: TVecQuantity): string;
    function ToVerboseString(const AQuantity: TBivecQuantity): string;
    function ToVerboseString(const AQuantity: TTrivecQuantity): string;
    function ToVerboseString(const AQuantity: TMultivecQuantity): string;
  end;

 { TFactoredUnitHelper }

  TFactoredUnitHelper = record helper for TFactoredUnit
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
  public
    procedure Check(var AQuantity: TQuantity);
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
    function ToString(const AQuantity: TBivecQuantity): string;
    function ToString(const AQuantity: TTrivecQuantity): string;
    function ToString(const AQuantity: TMultivecQuantity): string;

    function ToVerboseString(const AQuantity: TVecQuantity): string;
    function ToVerboseString(const AQuantity: TBivecQuantity): string;
    function ToVerboseString(const AQuantity: TTrivecQuantity): string;
    function ToVerboseString(const AQuantity: TMultivecQuantity): string;
  end;

 { TDegreeCelsiusUnitHelper }

  TDegreeCelsiusUnitHelper = record helper for TDegreeCelsiusUnit
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
  public
    procedure Check(var AQuantity: TQuantity);
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
    procedure Check(var AQuantity: TQuantity);
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

const
  ScalarId = 0;
  ScalarUnit : TUnit = (
    FUnitOfMeasurement : ScalarId;
    FSymbol            : '';
    FName              : '';
    FPluralName        : '';
    FPrefixes          : ();
    FExponents         : ());

{ TRadian }

const
  RadianUnit : TUnit = (
    FUnitOfMeasurement : ScalarId;
    FSymbol            : 'rad';
    FName              : 'radian';
    FPluralName        : 'radians';
    FPrefixes          : ();
    FExponents         : ());

var
  rad : TUnit absolute RadianUnit;

{ TDegree }

const
  DegreeUnit : TFactoredUnit = (
    FUnitOfMeasurement : ScalarId;
    FSymbol            : 'deg';
    FName              : 'degree';
    FPluralName        : 'degrees';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (Pi/180));

var
  deg : TFactoredUnit absolute DegreeUnit;

{ TSteradian }

const
  SteradianId = 1;
  SteradianUnit : TUnit = (
    FUnitOfMeasurement : SteradianId;
    FSymbol            : 'sr';
    FName              : 'steradian';
    FPluralName        : 'steradians';
    FPrefixes          : ();
    FExponents         : ());

var
  sr : TUnit absolute SteradianUnit;

{ TSquareDegree }

const
  SquareDegreeUnit : TFactoredUnit = (
    FUnitOfMeasurement : SteradianId;
    FSymbol            : 'deg2';
    FName              : 'square degree';
    FPluralName        : 'square degrees';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (Pi*Pi/32400));

var
  deg2 : TFactoredUnit absolute SquareDegreeUnit;

{ TSecond }

const
  SecondId = 2;
  SecondUnit : TUnit = (
    FUnitOfMeasurement : SecondId;
    FSymbol            : '%ss';
    FName              : '%ssecond';
    FPluralName        : '%sseconds';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  s : TUnit absolute SecondUnit;

const
  ds         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 2; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cs         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 2; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  ms         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 2; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  mis        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 2; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  ns         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 2; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  ps         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 2; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TDay }

const
  DayUnit : TFactoredUnit = (
    FUnitOfMeasurement : SecondId;
    FSymbol            : 'd';
    FName              : 'day';
    FPluralName        : 'days';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (86400));

var
  day : TFactoredUnit absolute DayUnit;

{ THour }

const
  HourUnit : TFactoredUnit = (
    FUnitOfMeasurement : SecondId;
    FSymbol            : 'h';
    FName              : 'hour';
    FPluralName        : 'hours';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (3600));

var
  hr : TFactoredUnit absolute HourUnit;

{ TMinute }

const
  MinuteUnit : TFactoredUnit = (
    FUnitOfMeasurement : SecondId;
    FSymbol            : 'min';
    FName              : 'minute';
    FPluralName        : 'minutes';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (60));

var
  minute : TFactoredUnit absolute MinuteUnit;

{ TSquareSecond }

const
  SquareSecondId = 3;
  SquareSecondUnit : TUnit = (
    FUnitOfMeasurement : SquareSecondId;
    FSymbol            : '%ss2';
    FName              : 'square %ssecond';
    FPluralName        : 'square %sseconds';
    FPrefixes          : (pNone);
    FExponents         : (2));

var
  s2 : TUnit absolute SquareSecondUnit;

const
  ds2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 3; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cs2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 3; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  ms2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 3; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mis2       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 3; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  ns2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 3; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ps2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 3; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareDay }

const
  SquareDayUnit : TFactoredUnit = (
    FUnitOfMeasurement : SquareSecondId;
    FSymbol            : 'd2';
    FName              : 'square day';
    FPluralName        : 'square days';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (7464960000));

var
  day2 : TFactoredUnit absolute SquareDayUnit;

{ TSquareHour }

const
  SquareHourUnit : TFactoredUnit = (
    FUnitOfMeasurement : SquareSecondId;
    FSymbol            : 'h2';
    FName              : 'square hour';
    FPluralName        : 'square hours';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (12960000));

var
  hr2 : TFactoredUnit absolute SquareHourUnit;

{ TSquareMinute }

const
  SquareMinuteUnit : TFactoredUnit = (
    FUnitOfMeasurement : SquareSecondId;
    FSymbol            : 'min2';
    FName              : 'square minute';
    FPluralName        : 'square minutes';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (3600));

var
  minute2 : TFactoredUnit absolute SquareMinuteUnit;

{ TCubicSecond }

const
  CubicSecondId = 4;
  CubicSecondUnit : TUnit = (
    FUnitOfMeasurement : CubicSecondId;
    FSymbol            : '%ss3';
    FName              : 'cubic %ssecond';
    FPluralName        : 'cubic %sseconds';
    FPrefixes          : (pNone);
    FExponents         : (3));

var
  s3 : TUnit absolute CubicSecondUnit;

const
  ds3        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 4; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  cs3        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 4; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  ms3        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 4; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  mis3       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 4; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ns3        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 4; FValue: 1E-27); {$ELSE} (1E-27); {$ENDIF}
  ps3        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 4; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}

{ TQuarticSecond }

const
  QuarticSecondId = 5;
  QuarticSecondUnit : TUnit = (
    FUnitOfMeasurement : QuarticSecondId;
    FSymbol            : '%ss4';
    FName              : 'quartic %ssecond';
    FPluralName        : 'quartic %sseconds';
    FPrefixes          : (pNone);
    FExponents         : (4));

var
  s4 : TUnit absolute QuarticSecondUnit;

const
  ds4        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 5; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cs4        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 5; FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  ms4        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 5; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mis4       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 5; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  ns4        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 5; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  ps4        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 5; FValue: 1E-48); {$ELSE} (1E-48); {$ENDIF}

{ TQuinticSecond }

const
  QuinticSecondId = 6;
  QuinticSecondUnit : TUnit = (
    FUnitOfMeasurement : QuinticSecondId;
    FSymbol            : '%ss5';
    FName              : 'quintic %ssecond';
    FPluralName        : 'quintic %sseconds';
    FPrefixes          : (pNone);
    FExponents         : (5));

var
  s5 : TUnit absolute QuinticSecondUnit;

const
  ds5        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 6; FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  cs5        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 6; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  ms5        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 6; FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}
  mis5       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 6; FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}
  ns5        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 6; FValue: 1E-45); {$ELSE} (1E-45); {$ENDIF}
  ps5        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 6; FValue: 1E-60); {$ELSE} (1E-60); {$ENDIF}

{ TSexticSecond }

const
  SexticSecondId = 7;
  SexticSecondUnit : TUnit = (
    FUnitOfMeasurement : SexticSecondId;
    FSymbol            : '%ss6';
    FName              : 'sextic %ssecond';
    FPluralName        : 'sextic %sseconds';
    FPrefixes          : (pNone);
    FExponents         : (6));

var
  s6 : TUnit absolute SexticSecondUnit;

const
  ds6        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 7; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  cs6        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 7; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  ms6        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 7; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  mis6       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 7; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  ns6        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 7; FValue: 1E-54); {$ELSE} (1E-54); {$ENDIF}
  ps6        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 7; FValue: 1E-72); {$ELSE} (1E-72); {$ENDIF}

{ TMeter }

const
  MeterId = 8;
  MeterUnit : TUnit = (
    FUnitOfMeasurement : MeterId;
    FSymbol            : '%sm';
    FName              : '%smeter';
    FPluralName        : '%smeters';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  m : TUnit absolute MeterUnit;

const
  km         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 8; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  dm         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 8; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cm         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 8; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mm         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 8; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  mim        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 8; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nm         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 8; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pm         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 8; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TAstronomical }

const
  AstronomicalUnit : TFactoredUnit = (
    FUnitOfMeasurement : MeterId;
    FSymbol            : 'au';
    FName              : 'astronomical unit';
    FPluralName        : 'astronomical units';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (149597870691));

var
  au : TFactoredUnit absolute AstronomicalUnit;

{ TInch }

const
  InchUnit : TFactoredUnit = (
    FUnitOfMeasurement : MeterId;
    FSymbol            : 'in';
    FName              : 'inch';
    FPluralName        : 'inches';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (0.0254));

var
  inch : TFactoredUnit absolute InchUnit;

{ TFoot }

const
  FootUnit : TFactoredUnit = (
    FUnitOfMeasurement : MeterId;
    FSymbol            : 'ft';
    FName              : 'foot';
    FPluralName        : 'feet';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (0.3048));

var
  ft : TFactoredUnit absolute FootUnit;

{ TYard }

const
  YardUnit : TFactoredUnit = (
    FUnitOfMeasurement : MeterId;
    FSymbol            : 'yd';
    FName              : 'yard';
    FPluralName        : 'yards';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (0.9144));

var
  yd : TFactoredUnit absolute YardUnit;

{ TMile }

const
  MileUnit : TFactoredUnit = (
    FUnitOfMeasurement : MeterId;
    FSymbol            : 'mi';
    FName              : 'mile';
    FPluralName        : 'miles';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (1609.344));

var
  mi : TFactoredUnit absolute MileUnit;

{ TNauticalMile }

const
  NauticalMileUnit : TFactoredUnit = (
    FUnitOfMeasurement : MeterId;
    FSymbol            : 'nmi';
    FName              : 'nautical mile';
    FPluralName        : 'nautical miles';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (1852));

var
  nmi : TFactoredUnit absolute NauticalMileUnit;

{ TAngstrom }

const
  AngstromUnit : TFactoredUnit = (
    FUnitOfMeasurement : MeterId;
    FSymbol            : '%sÅ';
    FName              : '%sangstrom';
    FPluralName        : '%sangstroms';
    FPrefixes          : (pNone);
    FExponents         : (1);
    FFactor            : (1E-10));

var
  angstrom : TFactoredUnit absolute AngstromUnit;

{ TSquareRootMeter }

const
  SquareRootMeterId = 9;
  SquareRootMeterUnit : TUnit = (
    FUnitOfMeasurement : SquareRootMeterId;
    FSymbol            : '√%sm';
    FName              : 'square root %smeter';
    FPluralName        : 'square root %smeters';
    FPrefixes          : (pNone);
    FExponents         : (1));

{ TSquareMeter }

const
  SquareMeterId = 10;
  SquareMeterUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterId;
    FSymbol            : '%sm2';
    FName              : 'square %smeter';
    FPluralName        : 'square %smeters';
    FPrefixes          : (pNone);
    FExponents         : (2));

var
  m2 : TUnit absolute SquareMeterUnit;

const
  km2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 10; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  dm2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 10; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cm2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 10; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mm2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 10; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mim2       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 10; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nm2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 10; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  pm2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 10; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareInch }

const
  SquareInchUnit : TFactoredUnit = (
    FUnitOfMeasurement : SquareMeterId;
    FSymbol            : 'in2';
    FName              : 'square inch';
    FPluralName        : 'square inches';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (0.00064516));

var
  inch2 : TFactoredUnit absolute SquareInchUnit;

{ TSquareFoot }

const
  SquareFootUnit : TFactoredUnit = (
    FUnitOfMeasurement : SquareMeterId;
    FSymbol            : 'ft2';
    FName              : 'square foot';
    FPluralName        : 'square feet';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (0.09290304));

var
  ft2 : TFactoredUnit absolute SquareFootUnit;

{ TSquareYard }

const
  SquareYardUnit : TFactoredUnit = (
    FUnitOfMeasurement : SquareMeterId;
    FSymbol            : 'yd2';
    FName              : 'square yard';
    FPluralName        : 'square yards';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (0.83612736));

var
  yd2 : TFactoredUnit absolute SquareYardUnit;

{ TSquareMile }

const
  SquareMileUnit : TFactoredUnit = (
    FUnitOfMeasurement : SquareMeterId;
    FSymbol            : 'mi2';
    FName              : 'square mile';
    FPluralName        : 'square miles';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (2589988.110336));

var
  mi2 : TFactoredUnit absolute SquareMileUnit;

{ TCubicMeter }

const
  CubicMeterId = 11;
  CubicMeterUnit : TUnit = (
    FUnitOfMeasurement : CubicMeterId;
    FSymbol            : '%sm3';
    FName              : 'cubic %smeter';
    FPluralName        : 'cubic %smeters';
    FPrefixes          : (pNone);
    FExponents         : (3));

var
  m3 : TUnit absolute CubicMeterUnit;

const
  km3        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 11; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  dm3        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 11; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  cm3        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 11; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mm3        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 11; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  mim3       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 11; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  nm3        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 11; FValue: 1E-27); {$ELSE} (1E-27); {$ENDIF}
  pm3        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 11; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}

{ TCubicInch }

const
  CubicInchUnit : TFactoredUnit = (
    FUnitOfMeasurement : CubicMeterId;
    FSymbol            : 'in3';
    FName              : 'cubic inch';
    FPluralName        : 'cubic inches';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (0.000016387064));

var
  inch3 : TFactoredUnit absolute CubicInchUnit;

{ TCubicFoot }

const
  CubicFootUnit : TFactoredUnit = (
    FUnitOfMeasurement : CubicMeterId;
    FSymbol            : 'ft3';
    FName              : 'cubic foot';
    FPluralName        : 'cubic feet';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (0.028316846592));

var
  ft3 : TFactoredUnit absolute CubicFootUnit;

{ TCubicYard }

const
  CubicYardUnit : TFactoredUnit = (
    FUnitOfMeasurement : CubicMeterId;
    FSymbol            : 'yd3';
    FName              : 'cubic yard';
    FPluralName        : 'cubic yards';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (0.764554857984));

var
  yd3 : TFactoredUnit absolute CubicYardUnit;

{ TLitre }

const
  LitreUnit : TFactoredUnit = (
    FUnitOfMeasurement : CubicMeterId;
    FSymbol            : '%sL';
    FName              : '%slitre';
    FPluralName        : '%slitres';
    FPrefixes          : (pNone);
    FExponents         : (1);
    FFactor            : (1E-03));

var
  L : TFactoredUnit absolute LitreUnit;

const
  dL         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 11; FValue: 1E-03 * 1E-01); {$ELSE} (1E-03 * 1E-01); {$ENDIF}
  cL         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 11; FValue: 1E-03 * 1E-02); {$ELSE} (1E-03 * 1E-02); {$ENDIF}
  mL         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 11; FValue: 1E-03 * 1E-03); {$ELSE} (1E-03 * 1E-03); {$ENDIF}

{ TGallon }

const
  GallonUnit : TFactoredUnit = (
    FUnitOfMeasurement : CubicMeterId;
    FSymbol            : 'gal';
    FName              : 'gallon';
    FPluralName        : 'gallons';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (0.0037854119678));

var
  gal : TFactoredUnit absolute GallonUnit;

{ TQuarticMeter }

const
  QuarticMeterId = 12;
  QuarticMeterUnit : TUnit = (
    FUnitOfMeasurement : QuarticMeterId;
    FSymbol            : '%sm4';
    FName              : 'quartic %smeter';
    FPluralName        : 'quartic %smeters';
    FPrefixes          : (pNone);
    FExponents         : (4));

var
  m4 : TUnit absolute QuarticMeterUnit;

const
  km4        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 12; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  dm4        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 12; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cm4        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 12; FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  mm4        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 12; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mim4       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 12; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  nm4        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 12; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  pm4        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 12; FValue: 1E-48); {$ELSE} (1E-48); {$ENDIF}

{ TQuinticMeter }

const
  QuinticMeterId = 13;
  QuinticMeterUnit : TUnit = (
    FUnitOfMeasurement : QuinticMeterId;
    FSymbol            : '%sm5';
    FName              : 'quintic %smeter';
    FPluralName        : 'quintic %smeters';
    FPrefixes          : (pNone);
    FExponents         : (5));

var
  m5 : TUnit absolute QuinticMeterUnit;

const
  km5        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 13; FValue: 1E+15); {$ELSE} (1E+15); {$ENDIF}
  dm5        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 13; FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  cm5        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 13; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  mm5        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 13; FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}
  mim5       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 13; FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}
  nm5        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 13; FValue: 1E-45); {$ELSE} (1E-45); {$ENDIF}
  pm5        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 13; FValue: 1E-60); {$ELSE} (1E-60); {$ENDIF}

{ TSexticMeter }

const
  SexticMeterId = 14;
  SexticMeterUnit : TUnit = (
    FUnitOfMeasurement : SexticMeterId;
    FSymbol            : '%sm6';
    FName              : 'sextic %smeter';
    FPluralName        : 'sextic %smeters';
    FPrefixes          : (pNone);
    FExponents         : (6));

var
  m6 : TUnit absolute SexticMeterUnit;

const
  km6        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 14; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  dm6        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 14; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  cm6        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 14; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mm6        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 14; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  mim6       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 14; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  nm6        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 14; FValue: 1E-54); {$ELSE} (1E-54); {$ENDIF}
  pm6        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 14; FValue: 1E-72); {$ELSE} (1E-72); {$ENDIF}

{ TKilogram }

const
  KilogramId = 15;
  KilogramUnit : TUnit = (
    FUnitOfMeasurement : KilogramId;
    FSymbol            : '%sg';
    FName              : '%sgram';
    FPluralName        : '%sgrams';
    FPrefixes          : (pKilo);
    FExponents         : (1));

var
  kg : TUnit absolute KilogramUnit;

const
  hg         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 15; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  dag        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 15; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  g          : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 15; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  dg         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 15; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cg         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 15; FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  mg         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 15; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mig        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 15; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  ng         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 15; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  pg         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 15; FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}

{ TTonne }

const
  TonneUnit : TFactoredUnit = (
    FUnitOfMeasurement : KilogramId;
    FSymbol            : '%st';
    FName              : '%stonne';
    FPluralName        : '%stonnes';
    FPrefixes          : (pNone);
    FExponents         : (1);
    FFactor            : (1E+03));

var
  tonne : TFactoredUnit absolute TonneUnit;

const
  gigatonne  : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 15; FValue: 1E+03 * 1E+09); {$ELSE} (1E+03 * 1E+09); {$ENDIF}
  megatonne  : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 15; FValue: 1E+03 * 1E+06); {$ELSE} (1E+03 * 1E+06); {$ENDIF}
  kilotonne  : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 15; FValue: 1E+03 * 1E+03); {$ELSE} (1E+03 * 1E+03); {$ENDIF}

{ TPound }

const
  PoundUnit : TFactoredUnit = (
    FUnitOfMeasurement : KilogramId;
    FSymbol            : 'lb';
    FName              : 'pound';
    FPluralName        : 'pounds';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (0.45359237));

var
  lb : TFactoredUnit absolute PoundUnit;

{ TOunce }

const
  OunceUnit : TFactoredUnit = (
    FUnitOfMeasurement : KilogramId;
    FSymbol            : 'oz';
    FName              : 'ounce';
    FPluralName        : 'ounces';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (0.028349523125));

var
  oz : TFactoredUnit absolute OunceUnit;

{ TStone }

const
  StoneUnit : TFactoredUnit = (
    FUnitOfMeasurement : KilogramId;
    FSymbol            : 'st';
    FName              : 'stone';
    FPluralName        : 'stones';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (6.35029318));

var
  st : TFactoredUnit absolute StoneUnit;

{ TTon }

const
  TonUnit : TFactoredUnit = (
    FUnitOfMeasurement : KilogramId;
    FSymbol            : 'ton';
    FName              : 'ton';
    FPluralName        : 'tons';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (907.18474));

var
  ton : TFactoredUnit absolute TonUnit;

{ TElectronvoltPerSquareSpeedOfLight }

const
  ElectronvoltPerSquareSpeedOfLightUnit : TFactoredUnit = (
    FUnitOfMeasurement : KilogramId;
    FSymbol            : '%seV/c2';
    FName              : '%selectronvolt per squared speed of light';
    FPluralName        : '%selectronvolts per squared speed of light';
    FPrefixes          : (pNone);
    FExponents         : (1);
    FFactor            : (1.7826619216279E-36));

{ TSquareKilogram }

const
  SquareKilogramId = 16;
  SquareKilogramUnit : TUnit = (
    FUnitOfMeasurement : SquareKilogramId;
    FSymbol            : '%sg2';
    FName              : 'square %sgram';
    FPluralName        : 'square %sgrams';
    FPrefixes          : (pKilo);
    FExponents         : (2));

var
  kg2 : TUnit absolute SquareKilogramUnit;

const
  hg2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 16; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  dag2       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 16; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  g2         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 16; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  dg2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 16; FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  cg2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 16; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  mg2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 16; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mig2       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 16; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ng2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 16; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  pg2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 16; FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}

{ TAmpere }

const
  AmpereId = 17;
  AmpereUnit : TUnit = (
    FUnitOfMeasurement : AmpereId;
    FSymbol            : '%sA';
    FName              : '%sampere';
    FPluralName        : '%samperes';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  A : TUnit absolute AmpereUnit;

const
  kA         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 17; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hA         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 17; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daA        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 17; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}
  dA         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 17; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cA         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 17; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mA         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 17; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miA        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 17; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nA         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 17; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  picoA      : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 17; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TSquareAmpere }

const
  SquareAmpereId = 18;
  SquareAmpereUnit : TUnit = (
    FUnitOfMeasurement : SquareAmpereId;
    FSymbol            : '%sA2';
    FName              : 'square %sampere';
    FPluralName        : 'square %samperes';
    FPrefixes          : (pNone);
    FExponents         : (2));

var
  A2 : TUnit absolute SquareAmpereUnit;

const
  kA2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 18; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hA2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 18; FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daA2       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 18; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  dA2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 18; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cA2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 18; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mA2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 18; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  miA2       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 18; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nA2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 18; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  picoA2     : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 18; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TKelvin }

const
  KelvinId = 19;
  KelvinUnit : TUnit = (
    FUnitOfMeasurement : KelvinId;
    FSymbol            : '%sK';
    FName              : '%skelvin';
    FPluralName        : '%skelvins';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  K : TUnit absolute KelvinUnit;

{ TDegreeCelsius }

const
  DegreeCelsiusUnit : TDegreeCelsiusUnit = (
    FUnitOfMeasurement : KelvinId;
    FSymbol            : '°C';
    FName              : 'degree Celsius';
    FPluralName        : 'degrees Celsius';
    FPrefixes          : ();
    FExponents         : ());

var
  degC : TDegreeCelsiusUnit absolute DegreeCelsiusUnit;

{ TDegreeFahrenheit }

const
  DegreeFahrenheitUnit : TDegreeFahrenheitUnit = (
    FUnitOfMeasurement : KelvinId;
    FSymbol            : '°F';
    FName              : 'degree Fahrenheit';
    FPluralName        : 'degrees Fahrenheit';
    FPrefixes          : ();
    FExponents         : ());

var
  degF : TDegreeFahrenheitUnit absolute DegreeFahrenheitUnit;

{ TSquareKelvin }

const
  SquareKelvinId = 20;
  SquareKelvinUnit : TUnit = (
    FUnitOfMeasurement : SquareKelvinId;
    FSymbol            : '%sK2';
    FName              : 'square %skelvin';
    FPluralName        : 'square %skelvins';
    FPrefixes          : (pNone);
    FExponents         : (2));

var
  K2 : TUnit absolute SquareKelvinUnit;

{ TCubicKelvin }

const
  CubicKelvinId = 21;
  CubicKelvinUnit : TUnit = (
    FUnitOfMeasurement : CubicKelvinId;
    FSymbol            : '%sK3';
    FName              : 'cubic %skelvin';
    FPluralName        : 'cubic %skelvins';
    FPrefixes          : (pNone);
    FExponents         : (3));

var
  K3 : TUnit absolute CubicKelvinUnit;

{ TQuarticKelvin }

const
  QuarticKelvinId = 22;
  QuarticKelvinUnit : TUnit = (
    FUnitOfMeasurement : QuarticKelvinId;
    FSymbol            : '%sK4';
    FName              : 'quartic %skelvin';
    FPluralName        : 'quartic %skelvins';
    FPrefixes          : (pNone);
    FExponents         : (4));

var
  K4 : TUnit absolute QuarticKelvinUnit;

{ TMole }

const
  MoleId = 23;
  MoleUnit : TUnit = (
    FUnitOfMeasurement : MoleId;
    FSymbol            : '%smol';
    FName              : '%smole';
    FPluralName        : '%smoles';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  mol : TUnit absolute MoleUnit;

const
  kmol       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 23; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hmol       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 23; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  damol      : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 23; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}

{ TCandela }

const
  CandelaId = 24;
  CandelaUnit : TUnit = (
    FUnitOfMeasurement : CandelaId;
    FSymbol            : '%scd';
    FName              : '%scandela';
    FPluralName        : '%scandelas';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  cd : TUnit absolute CandelaUnit;

{ THertz }

const
  HertzId = 25;
  HertzUnit : TUnit = (
    FUnitOfMeasurement : HertzId;
    FSymbol            : '%sHz';
    FName              : '%shertz';
    FPluralName        : '%shertz';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  Hz : TUnit absolute HertzUnit;

const
  THz        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 25; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GHz        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 25; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MHz        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 25; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kHz        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 25; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TReciprocalSecond }

const
  ReciprocalSecondUnit : TUnit = (
    FUnitOfMeasurement : HertzId;
    FSymbol            : '1/%ss';
    FName              : 'reciprocal %ssecond';
    FPluralName        : 'reciprocal %sseconds';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TRadianPerSecond }

const
  RadianPerSecondUnit : TUnit = (
    FUnitOfMeasurement : HertzId;
    FSymbol            : 'rad/%ss';
    FName              : 'radian per %ssecond';
    FPluralName        : 'radians per %ssecond';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TSquareHertz }

const
  SquareHertzId = 26;
  SquareHertzUnit : TUnit = (
    FUnitOfMeasurement : SquareHertzId;
    FSymbol            : '%sHz2';
    FName              : 'square %shertz';
    FPluralName        : 'square %shertz';
    FPrefixes          : (pNone);
    FExponents         : (2));

var
  Hz2 : TUnit absolute SquareHertzUnit;

const
  THz2       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 26; FValue: 1E+24); {$ELSE} (1E+24); {$ENDIF}
  GHz2       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 26; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MHz2       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 26; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kHz2       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 26; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}

{ TReciprocalSquareSecond }

const
  ReciprocalSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : SquareHertzId;
    FSymbol            : '1/%ss2';
    FName              : 'reciprocal square %ssecond';
    FPluralName        : 'reciprocal square %sseconds';
    FPrefixes          : (pNone);
    FExponents         : (-2));

{ TRadianPerSquareSecond }

const
  RadianPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : SquareHertzId;
    FSymbol            : 'rad/%ss2';
    FName              : 'radian per square %ssecond';
    FPluralName        : 'radians per square %ssecond';
    FPrefixes          : (pNone);
    FExponents         : (-2));

{ TSteradianPerSquareSecond }

const
  SteradianPerSquareSecondId = 27;
  SteradianPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : SteradianPerSquareSecondId;
    FSymbol            : 'sr/%ss2';
    FName              : 'steradian per square %ssecond';
    FPluralName        : 'steradians per square %ssecond';
    FPrefixes          : (pNone);
    FExponents         : (-2));

{ TMeterPerSecond }

const
  MeterPerSecondId = 28;
  MeterPerSecondUnit : TUnit = (
    FUnitOfMeasurement : MeterPerSecondId;
    FSymbol            : '%sm/%ss';
    FName              : '%smeter per %ssecond';
    FPluralName        : '%smeters per %ssecond';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TMeterPerHour }

const
  MeterPerHourUnit : TFactoredUnit = (
    FUnitOfMeasurement : MeterPerSecondId;
    FSymbol            : '%sm/h';
    FName              : '%smeter per hour';
    FPluralName        : '%smeters per hour';
    FPrefixes          : (pNone);
    FExponents         : (1);
    FFactor            : (1/3600));

{ TMilePerHour }

const
  MilePerHourUnit : TFactoredUnit = (
    FUnitOfMeasurement : MeterPerSecondId;
    FSymbol            : 'mi/h';
    FName              : 'mile per hour';
    FPluralName        : 'miles per hour';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (0.44704));

{ TNauticalMilePerHour }

const
  NauticalMilePerHourUnit : TFactoredUnit = (
    FUnitOfMeasurement : MeterPerSecondId;
    FSymbol            : 'nmi/h';
    FName              : 'nautical mile per hour';
    FPluralName        : 'nautical miles per hour';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (463/900));

{ TMeterPerSquareSecond }

const
  MeterPerSquareSecondId = 29;
  MeterPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : MeterPerSquareSecondId;
    FSymbol            : '%sm/%ss2';
    FName              : '%smeter per %ssecond squared';
    FPluralName        : '%smeters per %ssecond squared';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -2));

{ TMeterPerSecondPerSecond }

const
  MeterPerSecondPerSecondUnit : TUnit = (
    FUnitOfMeasurement : MeterPerSquareSecondId;
    FSymbol            : '%sm/%ss/%ss';
    FName              : '%smeter per %ssecond per %ssecond';
    FPluralName        : '%smeters per %ssecond per %ssecond';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, -1, -1));

{ TMeterPerHourPerSecond }

const
  MeterPerHourPerSecondUnit : TFactoredUnit = (
    FUnitOfMeasurement : MeterPerSquareSecondId;
    FSymbol            : '%sm/h/%ss';
    FName              : '%smeter per hour per %ssecond';
    FPluralName        : '%smeters per hour per %ssecond';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1);
    FFactor            : (1/3600));

{ TMeterPerCubicSecond }

const
  MeterPerCubicSecondId = 30;
  MeterPerCubicSecondUnit : TUnit = (
    FUnitOfMeasurement : MeterPerCubicSecondId;
    FSymbol            : '%sm/%ss3';
    FName              : '%smeter per cubic %ssecond';
    FPluralName        : '%smeters per cubic %ssecond';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -3));

{ TMeterPerQuarticSecond }

const
  MeterPerQuarticSecondId = 31;
  MeterPerQuarticSecondUnit : TUnit = (
    FUnitOfMeasurement : MeterPerQuarticSecondId;
    FSymbol            : '%sm/%ss4';
    FName              : '%smeter per quartic %ssecond';
    FPluralName        : '%smeters per quartic %ssecond';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -4));

{ TMeterPerQuinticSecond }

const
  MeterPerQuinticSecondId = 32;
  MeterPerQuinticSecondUnit : TUnit = (
    FUnitOfMeasurement : MeterPerQuinticSecondId;
    FSymbol            : '%sm/%ss5';
    FName              : '%smeter per quintic %ssecond';
    FPluralName        : '%smeters per quintic %ssecond';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -5));

{ TMeterPerSexticSecond }

const
  MeterPerSexticSecondId = 33;
  MeterPerSexticSecondUnit : TUnit = (
    FUnitOfMeasurement : MeterPerSexticSecondId;
    FSymbol            : '%sm/%ss6';
    FName              : '%smeter per sextic %ssecond';
    FPluralName        : '%smeters per sextic %ssecond';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -6));

{ TSquareMeterPerSquareSecond }

const
  SquareMeterPerSquareSecondId = 34;
  SquareMeterPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterPerSquareSecondId;
    FSymbol            : '%sm2/%ss2';
    FName              : 'square %smeter per square %ssecond';
    FPluralName        : 'square %smeters per square %ssecond';
    FPrefixes          : (pNone, pNone);
    FExponents         : (2, -2));

{ TJoulePerKilogram }

const
  JoulePerKilogramUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterPerSquareSecondId;
    FSymbol            : '%sJ/%sg';
    FName              : '%sjoule per %sgram';
    FPluralName        : '%sjoules per %sgram';
    FPrefixes          : (pNone, pKilo);
    FExponents         : (1, -1));

{ TGray }

const
  GrayUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterPerSquareSecondId;
    FSymbol            : '%sGy';
    FName              : '%sgray';
    FPluralName        : '%sgrays';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  Gy : TUnit absolute GrayUnit;

const
  kGy        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 34; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mGy        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 34; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miGy       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 34; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nGy        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 34; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TSievert }

const
  SievertUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterPerSquareSecondId;
    FSymbol            : '%sSv';
    FName              : '%ssievert';
    FPluralName        : '%ssieverts';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  Sv : TUnit absolute SievertUnit;

const
  kSv        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 34; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mSv        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 34; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miSv       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 34; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nSv        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 34; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TMeterSecond }

const
  MeterSecondId = 35;
  MeterSecondUnit : TUnit = (
    FUnitOfMeasurement : MeterSecondId;
    FSymbol            : '%sm.%ss';
    FName              : '%smeter %ssecond';
    FPluralName        : '%smeter %sseconds';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TKilogramMeter }

const
  KilogramMeterId = 36;
  KilogramMeterUnit : TUnit = (
    FUnitOfMeasurement : KilogramMeterId;
    FSymbol            : '%sg.%sm';
    FName              : '%sgram %smeter';
    FPluralName        : '%sgram %smeters';
    FPrefixes          : (pKilo, pNone);
    FExponents         : (1, 1));

{ TKilogramPerSecond }

const
  KilogramPerSecondId = 37;
  KilogramPerSecondUnit : TUnit = (
    FUnitOfMeasurement : KilogramPerSecondId;
    FSymbol            : '%sg/%ss';
    FName              : '%sgram per %ssecond';
    FPluralName        : '%sgrams per %ssecond';
    FPrefixes          : (pKilo, pNone);
    FExponents         : (1, -1));

{ TJoulePerSquareMeterPerHertz }

const
  JoulePerSquareMeterPerHertzUnit : TUnit = (
    FUnitOfMeasurement : KilogramPerSecondId;
    FSymbol            : '%sJ/%sm2/%sHz';
    FName              : '%sjoule per square %smeter per %shertz';
    FPluralName        : '%sjoules per square %smeter per %shertz';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, -2, -1));

{ TKilogramMeterPerSecond }

const
  KilogramMeterPerSecondId = 38;
  KilogramMeterPerSecondUnit : TUnit = (
    FUnitOfMeasurement : KilogramMeterPerSecondId;
    FSymbol            : '%sg.%sm/%ss';
    FName              : '%sgram %smeter per %ssecond';
    FPluralName        : '%sgram %smeters per %ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, 1, -1));

{ TNewtonSecond }

const
  NewtonSecondUnit : TUnit = (
    FUnitOfMeasurement : KilogramMeterPerSecondId;
    FSymbol            : '%sN.%ss';
    FName              : '%snewton %ssecond';
    FPluralName        : '%snewton %sseconds';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TSquareKilogramSquareMeterPerSquareSecond }

const
  SquareKilogramSquareMeterPerSquareSecondId = 39;
  SquareKilogramSquareMeterPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : SquareKilogramSquareMeterPerSquareSecondId;
    FSymbol            : '%sg2.%sm2/%ss2';
    FName              : 'square%sgram square%smeter per square%ssecond';
    FPluralName        : 'square%sgram square%smeters per square%ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (2, 2, -2));

{ TReciprocalSquareRootMeter }

const
  ReciprocalSquareRootMeterId = 40;
  ReciprocalSquareRootMeterUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalSquareRootMeterId;
    FSymbol            : '1/√%sm';
    FName              : 'reciprocal square root %smeter';
    FPluralName        : 'reciprocal square root %smeters';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TReciprocalMeter }

const
  ReciprocalMeterId = 41;
  ReciprocalMeterUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalMeterId;
    FSymbol            : '1/%sm';
    FName              : 'reciprocal %smeter';
    FPluralName        : 'reciprocal %smeters';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TDioptre }

const
  DioptreUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalMeterId;
    FSymbol            : 'dpt';
    FName              : '%sdioptre';
    FPluralName        : '%sdioptres';
    FPrefixes          : ();
    FExponents         : ());

{ TReciprocalSquareRootCubicMeter }

const
  ReciprocalSquareRootCubicMeterId = 42;
  ReciprocalSquareRootCubicMeterUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalSquareRootCubicMeterId;
    FSymbol            : '1/√%sm3';
    FName              : 'reciprocal square root cubic %smeter';
    FPluralName        : 'reciprocal square root cubic %smeters';
    FPrefixes          : (pNone);
    FExponents         : (-3));

{ TReciprocalSquareMeter }

const
  ReciprocalSquareMeterId = 43;
  ReciprocalSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalSquareMeterId;
    FSymbol            : '1/%sm2';
    FName              : 'reciprocal square %smeter';
    FPluralName        : 'reciprocal square %smeters';
    FPrefixes          : (pNone);
    FExponents         : (-2));

{ TReciprocalCubicMeter }

const
  ReciprocalCubicMeterId = 44;
  ReciprocalCubicMeterUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalCubicMeterId;
    FSymbol            : '1/%sm3';
    FName              : 'reciprocal cubic %smeter';
    FPluralName        : 'reciprocal cubic %smeters';
    FPrefixes          : (pNone);
    FExponents         : (-3));

{ TReciprocalQuarticMeter }

const
  ReciprocalQuarticMeterId = 45;
  ReciprocalQuarticMeterUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalQuarticMeterId;
    FSymbol            : '1/%sm4';
    FName              : 'reciprocal quartic %smeter';
    FPluralName        : 'reciprocal quartic %smeters';
    FPrefixes          : (pNone);
    FExponents         : (-4));

{ TKilogramSquareMeter }

const
  KilogramSquareMeterId = 46;
  KilogramSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : KilogramSquareMeterId;
    FSymbol            : '%sg.%sm2';
    FName              : '%sgram square %smeter';
    FPluralName        : '%sgram square %smeters';
    FPrefixes          : (pKilo, pNone);
    FExponents         : (1, 2));

{ TKilogramSquareMeterPerSecond }

const
  KilogramSquareMeterPerSecondId = 47;
  KilogramSquareMeterPerSecondUnit : TUnit = (
    FUnitOfMeasurement : KilogramSquareMeterPerSecondId;
    FSymbol            : '%sg.%sm2/%ss';
    FName              : '%sgram square %smeter per %ssecond';
    FPluralName        : '%sgram square %smeters per %ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, 2, -1));

{ TNewtonMeterSecond }

const
  NewtonMeterSecondUnit : TUnit = (
    FUnitOfMeasurement : KilogramSquareMeterPerSecondId;
    FSymbol            : '%sN.%sm.%ss';
    FName              : '%snewton %smeter %ssecond';
    FPluralName        : '%snewton %smeter %sseconds';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, 1, 1));

{ TSecondPerMeter }

const
  SecondPerMeterId = 48;
  SecondPerMeterUnit : TUnit = (
    FUnitOfMeasurement : SecondPerMeterId;
    FSymbol            : '%ss/%sm';
    FName              : '%ssecond per %smeter';
    FPluralName        : '%sseconds per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TKilogramPerMeter }

const
  KilogramPerMeterId = 49;
  KilogramPerMeterUnit : TUnit = (
    FUnitOfMeasurement : KilogramPerMeterId;
    FSymbol            : '%sg/%sm';
    FName              : '%sgram per %smeter';
    FPluralName        : '%sgrams per %smeter';
    FPrefixes          : (pKilo, pNone);
    FExponents         : (1, -1));

{ TKilogramPerSquareMeter }

const
  KilogramPerSquareMeterId = 50;
  KilogramPerSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : KilogramPerSquareMeterId;
    FSymbol            : '%sg/%sm2';
    FName              : '%sgram per square %smeter';
    FPluralName        : '%sgrams per square %smeter';
    FPrefixes          : (pKilo, pNone);
    FExponents         : (1, -2));

{ TKilogramPerCubicMeter }

const
  KilogramPerCubicMeterId = 51;
  KilogramPerCubicMeterUnit : TUnit = (
    FUnitOfMeasurement : KilogramPerCubicMeterId;
    FSymbol            : '%sg/%sm3';
    FName              : '%sgram per cubic %smeter';
    FPluralName        : '%sgrams per cubic %smeter';
    FPrefixes          : (pKilo, pNone);
    FExponents         : (1, -3));

{ TPoundPerCubicInch }

const
  PoundPerCubicInchUnit : TFactoredUnit = (
    FUnitOfMeasurement : KilogramPerCubicMeterId;
    FSymbol            : 'lb/in3';
    FName              : 'pound per cubic inch';
    FPluralName        : 'pounds per cubic inch';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (27679.9047102031));

{ TNewton }

const
  NewtonId = 52;
  NewtonUnit : TUnit = (
    FUnitOfMeasurement : NewtonId;
    FSymbol            : '%sN';
    FName              : '%snewton';
    FPluralName        : '%snewtons';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  N : TUnit absolute NewtonUnit;

const
  GN         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 52; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MN         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 52; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kN         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 52; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hN         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 52; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daN        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 52; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}

{ TPoundForce }

const
  PoundForceUnit : TFactoredUnit = (
    FUnitOfMeasurement : NewtonId;
    FSymbol            : 'lbf';
    FName              : 'pound-force';
    FPluralName        : 'pounds-force';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (4.4482216152605));

var
  lbf : TFactoredUnit absolute PoundForceUnit;

{ TKilogramMeterPerSquareSecond }

const
  KilogramMeterPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : NewtonId;
    FSymbol            : '%sg.%sm/%ss2';
    FName              : '%sgram %smeter per square %ssecond';
    FPluralName        : '%sgram %smeters per square %ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, 1, -2));

{ TNewtonRadian }

const
  NewtonRadianUnit : TUnit = (
    FUnitOfMeasurement : NewtonId;
    FSymbol            : '%sN.%srad';
    FName              : '%snewton %sradian';
    FPluralName        : '%snewton %sradians';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TSquareNewton }

const
  SquareNewtonId = 53;
  SquareNewtonUnit : TUnit = (
    FUnitOfMeasurement : SquareNewtonId;
    FSymbol            : '%sN2';
    FName              : 'square %snewton';
    FPluralName        : 'square %snewtons';
    FPrefixes          : (pNone);
    FExponents         : (2));

var
  N2 : TUnit absolute SquareNewtonUnit;

const
  GN2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 53; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MN2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 53; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kN2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 53; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hN2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 53; FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daN2       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 53; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}

{ TSquareKilogramSquareMeterPerQuarticSecond }

const
  SquareKilogramSquareMeterPerQuarticSecondUnit : TUnit = (
    FUnitOfMeasurement : SquareNewtonId;
    FSymbol            : '%sg2.%sm2/%ss4';
    FName              : 'square %sgram square %smeter per quartic %ssecond';
    FPluralName        : 'square %sgram square %smeters per quartic %ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (2, 2, -4));

{ TPascal }

const
  PascalId = 54;
  PascalUnit : TUnit = (
    FUnitOfMeasurement : PascalId;
    FSymbol            : '%sPa';
    FName              : '%spascal';
    FPluralName        : '%spascals';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  Pa : TUnit absolute PascalUnit;

const
  TPa        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 54; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GPa        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 54; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MPa        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 54; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kPa        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 54; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TNewtonPerSquareMeter }

const
  NewtonPerSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : PascalId;
    FSymbol            : '%sN/%sm2';
    FName              : '%snewton per square %smeter';
    FPluralName        : '%snewtons per square %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -2));

{ TBar }

const
  BarUnit : TFactoredUnit = (
    FUnitOfMeasurement : PascalId;
    FSymbol            : '%sbar';
    FName              : '%sbar';
    FPluralName        : '%sbars';
    FPrefixes          : (pNone);
    FExponents         : (1);
    FFactor            : (1E+05));

var
  bar : TFactoredUnit absolute BarUnit;

const
  kbar       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 54; FValue: 1E+05 * 1E+03); {$ELSE} (1E+05 * 1E+03); {$ENDIF}
  mbar       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 54; FValue: 1E+05 * 1E-03); {$ELSE} (1E+05 * 1E-03); {$ENDIF}

{ TPoundPerSquareInch }

const
  PoundPerSquareInchUnit : TFactoredUnit = (
    FUnitOfMeasurement : PascalId;
    FSymbol            : '%spsi';
    FName              : '%spound per square inch';
    FPluralName        : '%spounds per square inch';
    FPrefixes          : (pNone);
    FExponents         : (1);
    FFactor            : (6894.75729316836));

var
  psi : TFactoredUnit absolute PoundPerSquareInchUnit;

const
  kpsi       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 54; FValue: 6894.75729316836 * 1E+03); {$ELSE} (6894.75729316836 * 1E+03); {$ENDIF}

{ TJoulePerCubicMeter }

const
  JoulePerCubicMeterUnit : TUnit = (
    FUnitOfMeasurement : PascalId;
    FSymbol            : '%sJ/%sm3';
    FName              : '%sjoule per cubic %smeter';
    FPluralName        : '%sjoules per cubic %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -3));

{ TKilogramPerMeterPerSquareSecond }

const
  KilogramPerMeterPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : PascalId;
    FSymbol            : '%sg/%sm/%ss2';
    FName              : '%sgram per %smeter per square %ssecond';
    FPluralName        : '%sgrams per %smeter per square %ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, -1, -2));

{ TJoule }

const
  JouleId = 55;
  JouleUnit : TUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : '%sJ';
    FName              : '%sjoule';
    FPluralName        : '%sjoules';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  J : TUnit absolute JouleUnit;

const
  TJ         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 55; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GJ         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 55; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MJ         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 55; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kJ         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 55; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TWattHour }

const
  WattHourUnit : TFactoredUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : '%sW.h';
    FName              : '%swatt hour';
    FPluralName        : '%swatt hours';
    FPrefixes          : (pNone);
    FExponents         : (1);
    FFactor            : (3600));

{ TWattSecond }

const
  WattSecondUnit : TUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : '%sW.%ss';
    FName              : '%swatt %ssecond';
    FPluralName        : '%swatt %sseconds';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TWattPerHertz }

const
  WattPerHertzUnit : TUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : '%sW/%shz';
    FName              : '%swatt per %shertz';
    FPluralName        : '%swatts per %shertz';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TElectronvolt }

const
  ElectronvoltUnit : TFactoredUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : '%seV';
    FName              : '%selectronvolt';
    FPluralName        : '%selectronvolts';
    FPrefixes          : (pNone);
    FExponents         : (1);
    FFactor            : (1.602176634E-019));

var
  eV : TFactoredUnit absolute ElectronvoltUnit;

const
  TeV        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+12); {$ELSE} (1.602176634E-019 * 1E+12); {$ENDIF}
  GeV        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+09); {$ELSE} (1.602176634E-019 * 1E+09); {$ENDIF}
  MeV        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+06); {$ELSE} (1.602176634E-019 * 1E+06); {$ENDIF}
  keV        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+03); {$ELSE} (1.602176634E-019 * 1E+03); {$ENDIF}

{ TNewtonMeter }

const
  NewtonMeterUnit : TUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : '%sN.%sm';
    FName              : '%snewton %smeter';
    FPluralName        : '%snewton %smeters';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TPoundForceInch }

const
  PoundForceInchUnit : TFactoredUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : 'lbf.in';
    FName              : 'pound-force inch';
    FPluralName        : 'pound-force inches';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (0.112984829027617));

{ TRydberg }

const
  RydbergUnit : TFactoredUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : '%sRy';
    FName              : '%srydberg';
    FPluralName        : '%srydbergs';
    FPrefixes          : (pNone);
    FExponents         : (1);
    FFactor            : (2.1798723611035E-18));

var
  Ry : TFactoredUnit absolute RydbergUnit;

{ TCalorie }

const
  CalorieUnit : TFactoredUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : '%scal';
    FName              : '%scalorie';
    FPluralName        : '%scalories';
    FPrefixes          : (pNone);
    FExponents         : (1);
    FFactor            : (4.184));

var
  cal : TFactoredUnit absolute CalorieUnit;

const
  Mcal       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 55; FValue: 4.184 * 1E+06); {$ELSE} (4.184 * 1E+06); {$ENDIF}
  kcal       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 55; FValue: 4.184 * 1E+03); {$ELSE} (4.184 * 1E+03); {$ENDIF}

{ TKilogramSquareMeterPerSquareSecond }

const
  KilogramSquareMeterPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : '%sg.%sm2/%ss2';
    FName              : '%sgram square %smeter per square %ssecond';
    FPluralName        : '%sgram square %smeters per square %ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, 2, -2));

{ TJoulePerRadian }

const
  JoulePerRadianUnit : TUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : '%sJ/rad';
    FName              : '%sjoule per radian';
    FPluralName        : '%sjoules per radian';
    FPrefixes          : (pNone);
    FExponents         : (1));

{ TJoulePerDegree }

const
  JoulePerDegreeUnit : TFactoredUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : '%sJ/deg';
    FName              : '%sjoule per degree';
    FPluralName        : '%sjoules per degree';
    FPrefixes          : (pNone);
    FExponents         : (1);
    FFactor            : (180/Pi));

{ TNewtonMeterPerRadian }

const
  NewtonMeterPerRadianUnit : TUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : '%sN.%sm/rad';
    FName              : '%snewton %smeter per radian';
    FPluralName        : '%snewton %smeters per radian';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TNewtonMeterPerDegree }

const
  NewtonMeterPerDegreeUnit : TFactoredUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : '%sN.%sm/deg';
    FName              : '%snewton %smeter per degree';
    FPluralName        : '%snewton %smeters per degree';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1);
    FFactor            : (180/Pi));

{ TKilogramSquareMeterPerSquareSecondPerRadian }

const
  KilogramSquareMeterPerSquareSecondPerRadianUnit : TUnit = (
    FUnitOfMeasurement : JouleId;
    FSymbol            : '%sg.%sm2/%ss2/rad';
    FName              : '%sgram square %smeter per square %ssecond per radian';
    FPluralName        : '%sgram square %smeters per square %ssecond per radian';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, 2, -2));

{ TWatt }

const
  WattId = 56;
  WattUnit : TUnit = (
    FUnitOfMeasurement : WattId;
    FSymbol            : '%sW';
    FName              : '%swatt';
    FPluralName        : '%swatts';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  W : TUnit absolute WattUnit;

const
  TW         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 56; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GW         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 56; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MW         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 56; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kW         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 56; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  milliW     : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 56; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

{ TKilogramSquareMeterPerCubicSecond }

const
  KilogramSquareMeterPerCubicSecondUnit : TUnit = (
    FUnitOfMeasurement : WattId;
    FSymbol            : '%sg.%sm2/%ss3';
    FName              : '%sgram square %smeter per cubic %ssecond';
    FPluralName        : '%sgram square %smeters per cubic %ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, 2, -3));

{ TCoulomb }

const
  CoulombId = 57;
  CoulombUnit : TUnit = (
    FUnitOfMeasurement : CoulombId;
    FSymbol            : '%sC';
    FName              : '%scoulomb';
    FPluralName        : '%scoulombs';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  C : TUnit absolute CoulombUnit;

const
  kC         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 57; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hC         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 57; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daC        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 57; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}
  dC         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 57; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cC         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 57; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mC         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 57; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miC        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 57; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nC         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 57; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pC         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 57; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TAmpereHour }

const
  AmpereHourUnit : TFactoredUnit = (
    FUnitOfMeasurement : CoulombId;
    FSymbol            : '%sA.h';
    FName              : '%sampere hour';
    FPluralName        : '%sampere hours';
    FPrefixes          : (pNone);
    FExponents         : (1);
    FFactor            : (3600));

{ TAmpereSecond }

const
  AmpereSecondUnit : TUnit = (
    FUnitOfMeasurement : CoulombId;
    FSymbol            : '%sA.%ss';
    FName              : '%sampere %ssecond';
    FPluralName        : '%sampere %sseconds';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TSquareCoulomb }

const
  SquareCoulombId = 58;
  SquareCoulombUnit : TUnit = (
    FUnitOfMeasurement : SquareCoulombId;
    FSymbol            : '%sC2';
    FName              : 'square %scoulomb';
    FPluralName        : 'square %scoulombs';
    FPrefixes          : (pNone);
    FExponents         : (2));

var
  C2 : TUnit absolute SquareCoulombUnit;

const
  kC2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 58; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hC2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 58; FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daC2       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 58; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  dC2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 58; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cC2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 58; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mC2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 58; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  miC2       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 58; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nC2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 58; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  pC2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 58; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareAmpereSquareSecond }

const
  SquareAmpereSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : SquareCoulombId;
    FSymbol            : '%sA2.%ss2';
    FName              : 'square %sampere square %ssecond';
    FPluralName        : 'square %sampere square %sseconds';
    FPrefixes          : (pNone, pNone);
    FExponents         : (2, 2));

{ TCoulombMeter }

const
  CoulombMeterId = 59;
  CoulombMeterUnit : TUnit = (
    FUnitOfMeasurement : CoulombMeterId;
    FSymbol            : '%sC.%sm';
    FName              : '%scoulomb %smeter';
    FPluralName        : '%scoulomb %smeters';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TVolt }

const
  VoltId = 60;
  VoltUnit : TUnit = (
    FUnitOfMeasurement : VoltId;
    FSymbol            : '%sV';
    FName              : '%svolt';
    FPluralName        : '%svolts';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  V : TUnit absolute VoltUnit;

const
  kV         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 60; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mV         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 60; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

{ TJoulePerCoulomb }

const
  JoulePerCoulombUnit : TUnit = (
    FUnitOfMeasurement : VoltId;
    FSymbol            : '%sJ/%sC';
    FName              : '%sJoule per %scoulomb';
    FPluralName        : '%sJoules per %scoulomb';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TKilogramSquareMeterPerAmperePerCubicSecond }

const
  KilogramSquareMeterPerAmperePerCubicSecondUnit : TUnit = (
    FUnitOfMeasurement : VoltId;
    FSymbol            : '%sg.%sm2/%sA/%ss3';
    FName              : '%sgram square %smeter per %sampere per cubic %ssecond';
    FPluralName        : '%sgram square %smeters per %sampere per cubic %ssecond';
    FPrefixes          : (pKilo, pNone, pNone, pNone);
    FExponents         : (1, 2, -1, -3));

{ TSquareVolt }

const
  SquareVoltId = 61;
  SquareVoltUnit : TUnit = (
    FUnitOfMeasurement : SquareVoltId;
    FSymbol            : '%sV2';
    FName              : 'square %svolt';
    FPluralName        : 'square %svolts';
    FPrefixes          : (pNone);
    FExponents         : (2));

var
  V2 : TUnit absolute SquareVoltUnit;

const
  kV2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 61; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  mV2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 61; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}

{ TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecond }

const
  SquareKilogramQuarticMeterPerSquareAmperePerSexticSecondUnit : TUnit = (
    FUnitOfMeasurement : SquareVoltId;
    FSymbol            : '%sg2.%sm3/%sA2/%ss6';
    FName              : 'square %sgram quartic %smeter per square %sampere per sextic %ssecond';
    FPluralName        : 'square %sgram quartic %smeters per square %sampere per sextic %ssecond';
    FPrefixes          : (pKilo, pNone, pNone, pNone);
    FExponents         : (2, 3, -2, -6));

{ TFarad }

const
  FaradId = 62;
  FaradUnit : TUnit = (
    FUnitOfMeasurement : FaradId;
    FSymbol            : '%sF';
    FName              : '%sfarad';
    FPluralName        : '%sfarads';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  F : TUnit absolute FaradUnit;

const
  mF         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 62; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miF        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 62; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nF         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 62; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pF         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 62; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TCoulombPerVolt }

const
  CoulombPerVoltUnit : TUnit = (
    FUnitOfMeasurement : FaradId;
    FSymbol            : '%sC/%sV';
    FName              : '%scoulomb per %svolt';
    FPluralName        : '%scoulombs per %svolt';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TSquareAmpereQuarticSecondPerKilogramPerSquareMeter }

const
  SquareAmpereQuarticSecondPerKilogramPerSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : FaradId;
    FSymbol            : '%sA2.%ss4/%sg/%sm2';
    FName              : 'square %sampere quartic %ssecond per %sgram per square %smeter';
    FPluralName        : 'square %sampere quartic %sseconds per %sgram per square %smeter';
    FPrefixes          : (pNone, pNone, pKilo, pNone);
    FExponents         : (2, 4, -1, -2));

{ TOhm }

const
  OhmId = 63;
  OhmUnit : TUnit = (
    FUnitOfMeasurement : OhmId;
    FSymbol            : '%sΩ';
    FName              : '%sohm';
    FPluralName        : '%sohms';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  ohm : TUnit absolute OhmUnit;

const
  Gohm       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 63; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  megaohm    : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 63; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kohm       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 63; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mohm       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 63; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miohm      : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 63; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nohm       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 63; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TKilogramSquareMeterPerSquareAmperePerCubicSecond }

const
  KilogramSquareMeterPerSquareAmperePerCubicSecondUnit : TUnit = (
    FUnitOfMeasurement : OhmId;
    FSymbol            : '%sg.%sm2/%sA/%ss3';
    FName              : '%sgram square %smeter per square %sampere per cubic %ssecond';
    FPluralName        : '%sgram square %smeters per square %sampere per cubic %ssecond';
    FPrefixes          : (pKilo, pNone, pNone, pNone);
    FExponents         : (1, 2, -1, -3));

{ TSiemens }

const
  SiemensId = 64;
  SiemensUnit : TUnit = (
    FUnitOfMeasurement : SiemensId;
    FSymbol            : '%sS';
    FName              : '%ssiemens';
    FPluralName        : '%ssiemens';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  siemens : TUnit absolute SiemensUnit;

const
  millisiemens : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 64; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  microsiemens : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 64; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
   nanosiemens : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 64; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TSquareAmpereCubicSecondPerKilogramPerSquareMeter }

const
  SquareAmpereCubicSecondPerKilogramPerSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : SiemensId;
    FSymbol            : '%sA2.%ss3/%sg/%sm2';
    FName              : 'square %sampere cubic %ssecond per %sgram per square %smeter';
    FPluralName        : 'square %sampere cubic %sseconds per %sgram per square %smeter';
    FPrefixes          : (pNone, pNone, pKilo, pNone);
    FExponents         : (2, 3, -1, -2));

{ TSiemensPerMeter }

const
  SiemensPerMeterId = 65;
  SiemensPerMeterUnit : TUnit = (
    FUnitOfMeasurement : SiemensPerMeterId;
    FSymbol            : '%sS/%sm';
    FName              : '%ssiemens per %smeter';
    FPluralName        : '%ssiemens per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TTesla }

const
  TeslaId = 66;
  TeslaUnit : TUnit = (
    FUnitOfMeasurement : TeslaId;
    FSymbol            : '%sT';
    FName              : '%stesla';
    FPluralName        : '%steslas';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  T : TUnit absolute TeslaUnit;

const
  mT         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 66; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miT        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 66; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nT         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 66; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TWeberPerSquareMeter }

const
  WeberPerSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : TeslaId;
    FSymbol            : '%sWb/%m2';
    FName              : '%sweber per square %smeter';
    FPluralName        : '%swebers per square %smeter';
    FPrefixes          : (pNone);
    FExponents         : (1));

{ TKilogramPerAmperePerSquareSecond }

const
  KilogramPerAmperePerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : TeslaId;
    FSymbol            : '%sg/%sA/%ss2';
    FName              : '%sgram per %sampere per square %ssecond';
    FPluralName        : '%sgrams per %sampere per square %ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, -1, -2));

{ TWeber }

const
  WeberId = 67;
  WeberUnit : TUnit = (
    FUnitOfMeasurement : WeberId;
    FSymbol            : '%sWb';
    FName              : '%sweber';
    FPluralName        : '%swebers';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  Wb : TUnit absolute WeberUnit;

{ TKilogramSquareMeterPerAmperePerSquareSecond }

const
  KilogramSquareMeterPerAmperePerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : WeberId;
    FSymbol            : '%sg.%sm2/%sA/%ss2';
    FName              : '%sgram square %smeter per %sampere per square %ssecond';
    FPluralName        : '%sgram square %smeters per %sampere per square %ssecond';
    FPrefixes          : (pKilo, pNone, pNone, pNone);
    FExponents         : (1, 2, -1, -2));

{ THenry }

const
  HenryId = 68;
  HenryUnit : TUnit = (
    FUnitOfMeasurement : HenryId;
    FSymbol            : '%sH';
    FName              : '%shenry';
    FPluralName        : '%shenries';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  H : TUnit absolute HenryUnit;

const
  mH         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 68; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miH        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 68; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nH         : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 68; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TKilogramSquareMeterPerSquareAmperePerSquareSecond }

const
  KilogramSquareMeterPerSquareAmperePerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : HenryId;
    FSymbol            : '%sg.%sm2/%sA2/%ss2';
    FName              : '%sgram square %smeter per square %sampere per square %ssecond';
    FPluralName        : '%sgram square %smeters per square %sampere per square %ssecond';
    FPrefixes          : (pKilo, pNone, pNone, pNone);
    FExponents         : (1, 2, -2, -2));

{ TReciprocalHenry }

const
  ReciprocalHenryId = 69;
  ReciprocalHenryUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalHenryId;
    FSymbol            : '1/%sH';
    FName              : 'reciprocal %shenry';
    FPluralName        : 'reciprocal %shenries';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TLumen }

const
  LumenId = 70;
  LumenUnit : TUnit = (
    FUnitOfMeasurement : LumenId;
    FSymbol            : '%slm';
    FName              : '%slumen';
    FPluralName        : '%slumens';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  lm : TUnit absolute LumenUnit;

{ TCandelaSteradian }

const
  CandelaSteradianUnit : TUnit = (
    FUnitOfMeasurement : LumenId;
    FSymbol            : '%scd.%ssr';
    FName              : '%scandela %ssteradian';
    FPluralName        : '%scandela %ssteradians';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TLumenSecond }

const
  LumenSecondId = 71;
  LumenSecondUnit : TUnit = (
    FUnitOfMeasurement : LumenSecondId;
    FSymbol            : '%slm.%ss';
    FName              : '%slumen %ssecond';
    FPluralName        : '%slumen %sseconds';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TLumenSecondPerCubicMeter }

const
  LumenSecondPerCubicMeterId = 72;
  LumenSecondPerCubicMeterUnit : TUnit = (
    FUnitOfMeasurement : LumenSecondPerCubicMeterId;
    FSymbol            : '%slm.%ss/%sm3';
    FName              : '%slumen %ssecond per cubic meter';
    FPluralName        : '%slumen %sseconds per cubic meter';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, 1, -3));

{ TLux }

const
  LuxId = 73;
  LuxUnit : TUnit = (
    FUnitOfMeasurement : LuxId;
    FSymbol            : '%slx';
    FName              : '%slux';
    FPluralName        : '%slux';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  lx : TUnit absolute LuxUnit;

{ TCandelaSteradianPerSquareMeter }

const
  CandelaSteradianPerSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : LuxId;
    FSymbol            : '%scd.%ssr/%sm2';
    FName              : '%scandela %ssteradian per square %smeter';
    FPluralName        : '%scandela %ssteradians per square %smeter';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, 1, -2));

{ TLuxSecond }

const
  LuxSecondId = 74;
  LuxSecondUnit : TUnit = (
    FUnitOfMeasurement : LuxSecondId;
    FSymbol            : '%slx.%ss';
    FName              : '%slux %ssecond';
    FPluralName        : '%slux %sseconds';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TBequerel }

const
  BequerelUnit : TUnit = (
    FUnitOfMeasurement : HertzId;
    FSymbol            : '%sBq';
    FName              : '%sbequerel';
    FPluralName        : '%sbequerels';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  Bq : TUnit absolute BequerelUnit;

const
  kBq        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 25; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mBq        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 25; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miBq       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 25; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nBq        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 25; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pBq        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 25; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TKatal }

const
  KatalId = 75;
  KatalUnit : TUnit = (
    FUnitOfMeasurement : KatalId;
    FSymbol            : '%skat';
    FName              : '%skatal';
    FPluralName        : '%skatals';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  kat : TUnit absolute KatalUnit;

{ TMolePerSecond }

const
  MolePerSecondUnit : TUnit = (
    FUnitOfMeasurement : KatalId;
    FSymbol            : '%smol/%ss';
    FName              : '%smole per %ssecond';
    FPluralName        : '%smoles per %ssecond';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TNewtonPerCubicMeter }

const
  NewtonPerCubicMeterId = 76;
  NewtonPerCubicMeterUnit : TUnit = (
    FUnitOfMeasurement : NewtonPerCubicMeterId;
    FSymbol            : '%sN/%sm3';
    FName              : '%snewton per cubic %smeter';
    FPluralName        : '%snewtons per cubic %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -3));

{ TPascalPerMeter }

const
  PascalPerMeterUnit : TUnit = (
    FUnitOfMeasurement : NewtonPerCubicMeterId;
    FSymbol            : '%sPa/%sm';
    FName              : '%spascal per %smeter';
    FPluralName        : '%spascals per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TKilogramPerSquareMeterPerSquareSecond }

const
  KilogramPerSquareMeterPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : NewtonPerCubicMeterId;
    FSymbol            : '%sg/%sm2/%ss2';
    FName              : '%sgram per square %smeter per square %ssecond';
    FPluralName        : '%sgrams per square %smeter per square %ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, -2, -2));

{ TNewtonPerMeter }

const
  NewtonPerMeterId = 77;
  NewtonPerMeterUnit : TUnit = (
    FUnitOfMeasurement : NewtonPerMeterId;
    FSymbol            : '%sN/%sm';
    FName              : '%snewton per %smeter';
    FPluralName        : '%snewtons per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TJoulePerSquareMeter }

const
  JoulePerSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : NewtonPerMeterId;
    FSymbol            : '%sJ/%sm2';
    FName              : '%sjoule per square %smeter';
    FPluralName        : '%sjoules per square %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -2));

{ TWattPerSquareMeterPerHertz }

const
  WattPerSquareMeterPerHertzUnit : TUnit = (
    FUnitOfMeasurement : NewtonPerMeterId;
    FSymbol            : '%sW/%sm2/%sHz';
    FName              : '%swatt per square %smeter per %shertz';
    FPluralName        : '%swatts per square %smeter per %shertz';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, -2, -1));

{ TPoundForcePerInch }

const
  PoundForcePerInchUnit : TFactoredUnit = (
    FUnitOfMeasurement : NewtonPerMeterId;
    FSymbol            : 'lbf/in';
    FName              : 'pound-force per inch';
    FPluralName        : 'pounds-force per inch';
    FPrefixes          : ();
    FExponents         : ();
    FFactor            : (175.126835246476));

{ TKilogramPerSquareSecond }

const
  KilogramPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : NewtonPerMeterId;
    FSymbol            : '%sg/%ss2';
    FName              : '%sgram per square %ssecond';
    FPluralName        : '%sgrams per square %ssecond';
    FPrefixes          : (pKilo, pNone);
    FExponents         : (1, -2));

{ TCubicMeterPerSecond }

const
  CubicMeterPerSecondId = 78;
  CubicMeterPerSecondUnit : TUnit = (
    FUnitOfMeasurement : CubicMeterPerSecondId;
    FSymbol            : '%sm3/%ss';
    FName              : 'cubic %smeter per %ssecond';
    FPluralName        : 'cubic %smeters per %ssecond';
    FPrefixes          : (pNone, pNone);
    FExponents         : (3, -1));

{ TPoiseuille }

const
  PoiseuilleId = 79;
  PoiseuilleUnit : TUnit = (
    FUnitOfMeasurement : PoiseuilleId;
    FSymbol            : '%sPl';
    FName              : '%spoiseuille';
    FPluralName        : '%spoiseuilles';
    FPrefixes          : (pNone);
    FExponents         : (1));

var
  Pl : TUnit absolute PoiseuilleUnit;

const
  cPl        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 79; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mPl        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 79; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miPl       : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 79; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}

{ TPascalSecond }

const
  PascalSecondUnit : TUnit = (
    FUnitOfMeasurement : PoiseuilleId;
    FSymbol            : '%sPa.%ss';
    FName              : '%spascal %ssecond';
    FPluralName        : '%spascal %sseconds';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TKilogramPerMeterPerSecond }

const
  KilogramPerMeterPerSecondUnit : TUnit = (
    FUnitOfMeasurement : PoiseuilleId;
    FSymbol            : '%sg/%sm/%ss';
    FName              : '%sgram per %smeter per %ssecond';
    FPluralName        : '%sgrams per %smeter per %ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, -1, -1));

{ TSquareMeterPerSecond }

const
  SquareMeterPerSecondId = 80;
  SquareMeterPerSecondUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterPerSecondId;
    FSymbol            : '%sm2/%ss';
    FName              : 'square %smeter per %ssecond';
    FPluralName        : 'square %smeters per %ssecond';
    FPrefixes          : (pNone, pNone);
    FExponents         : (2, -1));

{ TKilogramPerQuarticMeter }

const
  KilogramPerQuarticMeterId = 81;
  KilogramPerQuarticMeterUnit : TUnit = (
    FUnitOfMeasurement : KilogramPerQuarticMeterId;
    FSymbol            : '%sg/%sm4';
    FName              : '%sgram per quartic %smeter';
    FPluralName        : '%sgrams per quartic %smeter';
    FPrefixes          : (pKilo, pNone);
    FExponents         : (1, -4));

{ TQuarticMeterSecond }

const
  QuarticMeterSecondId = 82;
  QuarticMeterSecondUnit : TUnit = (
    FUnitOfMeasurement : QuarticMeterSecondId;
    FSymbol            : '%sm4.%ss';
    FName              : 'quartic %smeter %ssecond';
    FPluralName        : 'quartic %smeter %sseconds';
    FPrefixes          : (pNone, pNone);
    FExponents         : (4, 1));

{ TKilogramPerQuarticMeterPerSecond }

const
  KilogramPerQuarticMeterPerSecondId = 83;
  KilogramPerQuarticMeterPerSecondUnit : TUnit = (
    FUnitOfMeasurement : KilogramPerQuarticMeterPerSecondId;
    FSymbol            : '%sg/%sm4/%ss';
    FName              : '%sgram per quartic %smeter per %ssecond';
    FPluralName        : '%sgrams per quartic %smeter per %ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, -4, -1));

{ TCubicMeterPerKilogram }

const
  CubicMeterPerKilogramId = 84;
  CubicMeterPerKilogramUnit : TUnit = (
    FUnitOfMeasurement : CubicMeterPerKilogramId;
    FSymbol            : '%sm3/%sg';
    FName              : 'cubic %smeter per %sgram';
    FPluralName        : 'cubic %smeters per %sgram';
    FPrefixes          : (pNone, pKilo);
    FExponents         : (3, -1));

{ TKilogramSquareSecond }

const
  KilogramSquareSecondId = 85;
  KilogramSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : KilogramSquareSecondId;
    FSymbol            : '%sg.%ss2';
    FName              : '%sgram square %ssecond';
    FPluralName        : '%sgram square %sseconds';
    FPrefixes          : (pKilo, pNone);
    FExponents         : (1, 2));

{ TCubicMeterPerSquareSecond }

const
  CubicMeterPerSquareSecondId = 86;
  CubicMeterPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : CubicMeterPerSquareSecondId;
    FSymbol            : '%sm3/%ss2';
    FName              : 'cubic %smeter per square %ssecond';
    FPluralName        : 'cubic %smeters per square %ssecond';
    FPrefixes          : (pNone, pNone);
    FExponents         : (3, -2));

{ TNewtonSquareMeter }

const
  NewtonSquareMeterId = 87;
  NewtonSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : NewtonSquareMeterId;
    FSymbol            : '%sN.%sm2';
    FName              : '%snewton square %smeter';
    FPluralName        : '%snewton square %smeters';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 2));

{ TKilogramCubicMeterPerSquareSecond }

const
  KilogramCubicMeterPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : NewtonSquareMeterId;
    FSymbol            : '%sg.%sm3/%ss2';
    FName              : '%sgram cubic %smeter per square %ssecond';
    FPluralName        : '%sgram cubic %smeters per square %ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, 3, -2));

{ TNewtonCubicMeter }

const
  NewtonCubicMeterId = 88;
  NewtonCubicMeterUnit : TUnit = (
    FUnitOfMeasurement : NewtonCubicMeterId;
    FSymbol            : '%sN.%sm3';
    FName              : '%snewton cubic %smeter';
    FPluralName        : '%snewton cubic %smeters';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 3));

{ TKilogramQuarticMeterPerSquareSecond }

const
  KilogramQuarticMeterPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : NewtonCubicMeterId;
    FSymbol            : '%sg.%sm4/%ss2';
    FName              : '%sgram quartic %smeter per square %ssecond';
    FPluralName        : '%sgram quartic %smeters per square %ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, 4, -2));

{ TNewtonPerSquareKilogram }

const
  NewtonPerSquareKilogramId = 89;
  NewtonPerSquareKilogramUnit : TUnit = (
    FUnitOfMeasurement : NewtonPerSquareKilogramId;
    FSymbol            : '%sN/%sg2';
    FName              : '%snewton per square %sgram';
    FPluralName        : '%snewtons per square %sgram';
    FPrefixes          : (pNone, pKilo);
    FExponents         : (1, -2));

{ TMeterPerKilogramPerSquareSecond }

const
  MeterPerKilogramPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : NewtonPerSquareKilogramId;
    FSymbol            : '%sm/%sg/%ss2';
    FName              : '%smeter per %sgram per square %ssecond';
    FPluralName        : '%smeters per %sgram per square %ssecond';
    FPrefixes          : (pNone, pKilo, pNone);
    FExponents         : (1, -1, -2));

{ TSquareKilogramPerMeter }

const
  SquareKilogramPerMeterId = 90;
  SquareKilogramPerMeterUnit : TUnit = (
    FUnitOfMeasurement : SquareKilogramPerMeterId;
    FSymbol            : '%sg2/%sm';
    FName              : 'square %sgram per %smeter';
    FPluralName        : 'square %sgrams per %smeter';
    FPrefixes          : (pKilo, pNone);
    FExponents         : (2, -1));

{ TSquareKilogramPerSquareMeter }

const
  SquareKilogramPerSquareMeterId = 91;
  SquareKilogramPerSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : SquareKilogramPerSquareMeterId;
    FSymbol            : '%sg2/%sm2';
    FName              : 'square %sgram per square %smeter';
    FPluralName        : 'square %sgrams per square %smeter';
    FPrefixes          : (pKilo, pNone);
    FExponents         : (2, -2));

{ TSquareMeterPerSquareKilogram }

const
  SquareMeterPerSquareKilogramId = 92;
  SquareMeterPerSquareKilogramUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterPerSquareKilogramId;
    FSymbol            : '%sm2/%sg2';
    FName              : 'square %smeter per square %sgram';
    FPluralName        : 'square %smeters per square %sgram';
    FPrefixes          : (pNone, pKilo);
    FExponents         : (2, -2));

{ TNewtonSquareMeterPerSquareKilogram }

const
  NewtonSquareMeterPerSquareKilogramId = 93;
  NewtonSquareMeterPerSquareKilogramUnit : TUnit = (
    FUnitOfMeasurement : NewtonSquareMeterPerSquareKilogramId;
    FSymbol            : '%sN.%sm2/%sg2';
    FName              : '%snewton square %smeter per square %sgram';
    FPluralName        : '%snewton square %smeters per square %sgram';
    FPrefixes          : (pNone, pNone, pKilo);
    FExponents         : (1, 2, -2));

{ TCubicMeterPerKilogramPerSquareSecond }

const
  CubicMeterPerKilogramPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : NewtonSquareMeterPerSquareKilogramId;
    FSymbol            : '%sm3/%sg/%ss2';
    FName              : 'cubic %smeter per %sgram per square %ssecond';
    FPluralName        : 'cubic %smeters per %sgram per square %ssecond';
    FPrefixes          : (pNone, pKilo, pNone);
    FExponents         : (3, -1, -2));

{ TReciprocalKelvin }

const
  ReciprocalKelvinId = 94;
  ReciprocalKelvinUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalKelvinId;
    FSymbol            : '1/%sK';
    FName              : 'reciprocal %skelvin';
    FPluralName        : 'reciprocal %skelvin';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TKilogramKelvin }

const
  KilogramKelvinId = 95;
  KilogramKelvinUnit : TUnit = (
    FUnitOfMeasurement : KilogramKelvinId;
    FSymbol            : '%sg.%sK';
    FName              : '%sgram %skelvin';
    FPluralName        : '%sgram %skelvins';
    FPrefixes          : (pKilo, pNone);
    FExponents         : (1, 1));

{ TJoulePerKelvin }

const
  JoulePerKelvinId = 96;
  JoulePerKelvinUnit : TUnit = (
    FUnitOfMeasurement : JoulePerKelvinId;
    FSymbol            : '%sJ/%sK';
    FName              : '%sjoule per %skelvin';
    FPluralName        : '%sjoules per %skelvin';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TKilogramSquareMeterPerSquareSecondPerKelvin }

const
  KilogramSquareMeterPerSquareSecondPerKelvinUnit : TUnit = (
    FUnitOfMeasurement : JoulePerKelvinId;
    FSymbol            : '%sg.%sm2/%ss2/%sK';
    FName              : '%sgram square %smeter per square %ssecond per %skelvin';
    FPluralName        : '%sgram square %smeters per square %ssecond per %skelvin';
    FPrefixes          : (pKilo, pNone, pNone, pNone);
    FExponents         : (1, 2, -2, -1));

{ TJoulePerKilogramPerKelvin }

const
  JoulePerKilogramPerKelvinId = 97;
  JoulePerKilogramPerKelvinUnit : TUnit = (
    FUnitOfMeasurement : JoulePerKilogramPerKelvinId;
    FSymbol            : '%sJ/%sg/%sK';
    FName              : '%sjoule per %sgram per %skelvin';
    FPluralName        : '%sjoules per %sgram per %skelvin';
    FPrefixes          : (pNone, pKilo, pNone);
    FExponents         : (1, -1, -1));

{ TSquareMeterPerSquareSecondPerKelvin }

const
  SquareMeterPerSquareSecondPerKelvinUnit : TUnit = (
    FUnitOfMeasurement : JoulePerKilogramPerKelvinId;
    FSymbol            : '%sm2/%ss2/%sK';
    FName              : 'square %smeter per square %ssecond per %skelvin';
    FPluralName        : 'square %smeters per square %ssecond per %skelvin';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (2, -2, -1));

{ TMeterKelvin }

const
  MeterKelvinId = 98;
  MeterKelvinUnit : TUnit = (
    FUnitOfMeasurement : MeterKelvinId;
    FSymbol            : '%sm.%sK';
    FName              : '%smeter %skelvin';
    FPluralName        : '%smeter %skelvins';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TKelvinPerMeter }

const
  KelvinPerMeterId = 99;
  KelvinPerMeterUnit : TUnit = (
    FUnitOfMeasurement : KelvinPerMeterId;
    FSymbol            : '%sK/%sm';
    FName              : '%skelvin per %smeter';
    FPluralName        : '%skelvins per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TWattPerMeter }

const
  WattPerMeterId = 100;
  WattPerMeterUnit : TUnit = (
    FUnitOfMeasurement : WattPerMeterId;
    FSymbol            : '%sW/%sm';
    FName              : '%swatt per %smeter';
    FPluralName        : '%swatts per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TKilogramMeterPerCubicSecond }

const
  KilogramMeterPerCubicSecondUnit : TUnit = (
    FUnitOfMeasurement : WattPerMeterId;
    FSymbol            : '%sg.%sm/%ss3';
    FName              : '%sgram %smeter per cubic %ssecond';
    FPluralName        : '%sgram %smeters per cubic %ssecond';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, 1, -3));

{ TWattPerSquareMeter }

const
  WattPerSquareMeterId = 101;
  WattPerSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : WattPerSquareMeterId;
    FSymbol            : '%sW/%sm2';
    FName              : '%swatt per square %smeter';
    FPluralName        : '%swatts per square %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -2));

{ TKilogramPerCubicSecond }

const
  KilogramPerCubicSecondUnit : TUnit = (
    FUnitOfMeasurement : WattPerSquareMeterId;
    FSymbol            : '%sg/%ss3';
    FName              : '%sgram per cubic %ssecond';
    FPluralName        : '%sgrams per cubic %ssecond';
    FPrefixes          : (pKilo, pNone);
    FExponents         : (1, -3));

{ TWattPerCubicMeter }

const
  WattPerCubicMeterId = 102;
  WattPerCubicMeterUnit : TUnit = (
    FUnitOfMeasurement : WattPerCubicMeterId;
    FSymbol            : '%sW/%sm3';
    FName              : '%swatt per cubic %smeter';
    FPluralName        : '%swatts per cubic %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -3));

{ TWattPerKelvin }

const
  WattPerKelvinId = 103;
  WattPerKelvinUnit : TUnit = (
    FUnitOfMeasurement : WattPerKelvinId;
    FSymbol            : '%sW/%sK';
    FName              : '%swatt per %skelvin';
    FPluralName        : '%swatts per %skelvin';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TKilogramSquareMeterPerCubicSecondPerKelvin }

const
  KilogramSquareMeterPerCubicSecondPerKelvinUnit : TUnit = (
    FUnitOfMeasurement : WattPerKelvinId;
    FSymbol            : '%sg.%sm2/%ss3/%sK';
    FName              : '%sgram square %smeter per cubic %ssecond per %skelvin';
    FPluralName        : '%sgram square %smeters per cubic %ssecond per %skelvin';
    FPrefixes          : (pKilo, pNone, pNone, pNone);
    FExponents         : (1, 2, -3, -1));

{ TWattPerMeterPerKelvin }

const
  WattPerMeterPerKelvinId = 104;
  WattPerMeterPerKelvinUnit : TUnit = (
    FUnitOfMeasurement : WattPerMeterPerKelvinId;
    FSymbol            : '%sW/%sm/%sK';
    FName              : '%swatt per %smeter per %skelvin';
    FPluralName        : '%swatts per %smeter per %skelvin';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, -1, -1));

{ TKilogramMeterPerCubicSecondPerKelvin }

const
  KilogramMeterPerCubicSecondPerKelvinUnit : TUnit = (
    FUnitOfMeasurement : WattPerMeterPerKelvinId;
    FSymbol            : '%sg.%sm/%ss3/%sK';
    FName              : '%sgram %smeter per cubic %ssecond per %skelvin';
    FPluralName        : '%sgram %smeters per cubic %ssecond per %skelvin';
    FPrefixes          : (pKilo, pNone, pNone, pNone);
    FExponents         : (1, 1, -3, -1));

{ TKelvinPerWatt }

const
  KelvinPerWattId = 105;
  KelvinPerWattUnit : TUnit = (
    FUnitOfMeasurement : KelvinPerWattId;
    FSymbol            : '%sK/%sW';
    FName              : '%skelvin per %swatt';
    FPluralName        : '%skelvins per %swatt';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TMeterPerWatt }

const
  MeterPerWattId = 106;
  MeterPerWattUnit : TUnit = (
    FUnitOfMeasurement : MeterPerWattId;
    FSymbol            : '%sm/%sW';
    FName              : '%smeter per %swatt';
    FPluralName        : '%smeters per %swatts';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TMeterKelvinPerWatt }

const
  MeterKelvinPerWattId = 107;
  MeterKelvinPerWattUnit : TUnit = (
    FUnitOfMeasurement : MeterKelvinPerWattId;
    FSymbol            : '%sK.%sm/%sW';
    FName              : '%skelvin %smeter per %swatt';
    FPluralName        : '%skelvin %smeters per %swatt';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, 1, -1));

{ TSquareMeterKelvin }

const
  SquareMeterKelvinId = 108;
  SquareMeterKelvinUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterKelvinId;
    FSymbol            : '%sm2.%sK';
    FName              : 'square %smeter %skelvin';
    FPluralName        : 'square %smeter %skelvins';
    FPrefixes          : (pNone, pNone);
    FExponents         : (2, 1));

{ TWattPerSquareMeterPerKelvin }

const
  WattPerSquareMeterPerKelvinId = 109;
  WattPerSquareMeterPerKelvinUnit : TUnit = (
    FUnitOfMeasurement : WattPerSquareMeterPerKelvinId;
    FSymbol            : '%sW/%sm2/%sK';
    FName              : '%swatt per square %smeter per %skelvin';
    FPluralName        : '%swatts per square %smeter per %skelvin';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, -2, -1));

{ TKilogramPerCubicSecondPerKelvin }

const
  KilogramPerCubicSecondPerKelvinUnit : TUnit = (
    FUnitOfMeasurement : WattPerSquareMeterPerKelvinId;
    FSymbol            : '%sg/%ss3/%sK';
    FName              : '%sgram per cubic %ssecond per %skelvin';
    FPluralName        : '%sgrams per cubic %ssecond per %skelvin';
    FPrefixes          : (pKilo, pNone, pNone);
    FExponents         : (1, -3, -1));

{ TSquareMeterQuarticKelvin }

const
  SquareMeterQuarticKelvinId = 110;
  SquareMeterQuarticKelvinUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterQuarticKelvinId;
    FSymbol            : '%sm2.%sK4';
    FName              : 'square %smeter quartic %skelvin';
    FPluralName        : 'square %smeter quartic %skelvins';
    FPrefixes          : (pNone, pNone);
    FExponents         : (2, 4));

{ TWattPerQuarticKelvin }

const
  WattPerQuarticKelvinId = 111;
  WattPerQuarticKelvinUnit : TUnit = (
    FUnitOfMeasurement : WattPerQuarticKelvinId;
    FSymbol            : '%sW/%sK4';
    FName              : '%swatt per quartic %skelvin';
    FPluralName        : '%swatts per quartic %skelvin';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -4));

{ TWattPerSquareMeterPerQuarticKelvin }

const
  WattPerSquareMeterPerQuarticKelvinId = 112;
  WattPerSquareMeterPerQuarticKelvinUnit : TUnit = (
    FUnitOfMeasurement : WattPerSquareMeterPerQuarticKelvinId;
    FSymbol            : '%sW/%sm2/%sK4';
    FName              : '%swatt per square %smeter per quartic %skelvin';
    FPluralName        : '%swatts per square %smeter per quartic %skelvin';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, -2, -4));

{ TJoulePerMole }

const
  JoulePerMoleId = 113;
  JoulePerMoleUnit : TUnit = (
    FUnitOfMeasurement : JoulePerMoleId;
    FSymbol            : '%sJ/%smol';
    FName              : '%sjoule per %smole';
    FPluralName        : '%sjoules per %smole';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TMoleKelvin }

const
  MoleKelvinId = 114;
  MoleKelvinUnit : TUnit = (
    FUnitOfMeasurement : MoleKelvinId;
    FSymbol            : '%smol.%sK';
    FName              : '%smole %skelvin';
    FPluralName        : '%smole %skelvins';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TJoulePerMolePerKelvin }

const
  JoulePerMolePerKelvinId = 115;
  JoulePerMolePerKelvinUnit : TUnit = (
    FUnitOfMeasurement : JoulePerMolePerKelvinId;
    FSymbol            : '%sJ/%smol/%sK';
    FName              : '%sjoule per %smole per %skelvin';
    FPluralName        : '%sjoules per %smole per %skelvin';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, -1, -1));

{ TOhmMeter }

const
  OhmMeterId = 116;
  OhmMeterUnit : TUnit = (
    FUnitOfMeasurement : OhmMeterId;
    FSymbol            : '%sΩ.%sm';
    FName              : '%sohm %smeter';
    FPluralName        : '%sohm %smeters';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TVoltPerMeter }

const
  VoltPerMeterId = 117;
  VoltPerMeterUnit : TUnit = (
    FUnitOfMeasurement : VoltPerMeterId;
    FSymbol            : '%sV/%sm';
    FName              : '%svolt per %smeter';
    FPluralName        : '%svolts per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TNewtonPerCoulomb }

const
  NewtonPerCoulombUnit : TUnit = (
    FUnitOfMeasurement : VoltPerMeterId;
    FSymbol            : '%sN/%sC';
    FName              : '%snewton per %scoulomb';
    FPluralName        : '%snewtons per %scoulomb';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TCoulombPerMeter }

const
  CoulombPerMeterId = 118;
  CoulombPerMeterUnit : TUnit = (
    FUnitOfMeasurement : CoulombPerMeterId;
    FSymbol            : '%sC/%sm';
    FName              : '%scoulomb per %smeter';
    FPluralName        : '%scoulombs per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TSquareCoulombPerMeter }

const
  SquareCoulombPerMeterId = 119;
  SquareCoulombPerMeterUnit : TUnit = (
    FUnitOfMeasurement : SquareCoulombPerMeterId;
    FSymbol            : '%sC2/%sm';
    FName              : 'square %scoulomb per %smeter';
    FPluralName        : 'square %scoulombs per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (2, -1));

{ TCoulombPerSquareMeter }

const
  CoulombPerSquareMeterId = 120;
  CoulombPerSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : CoulombPerSquareMeterId;
    FSymbol            : '%sC/%sm2';
    FName              : '%scoulomb per square %smeter';
    FPluralName        : '%scoulombs per square %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -2));

{ TSquareMeterPerSquareCoulomb }

const
  SquareMeterPerSquareCoulombId = 121;
  SquareMeterPerSquareCoulombUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterPerSquareCoulombId;
    FSymbol            : '%sm2/%sC2';
    FName              : 'square %smeter per square %scoulomb';
    FPluralName        : 'square %smeters per square %scoulomb';
    FPrefixes          : (pNone, pNone);
    FExponents         : (2, -2));

{ TNewtonPerSquareCoulomb }

const
  NewtonPerSquareCoulombId = 122;
  NewtonPerSquareCoulombUnit : TUnit = (
    FUnitOfMeasurement : NewtonPerSquareCoulombId;
    FSymbol            : '%sN/%sC2';
    FName              : '%snewton per square %scoulomb';
    FPluralName        : '%snewtons per square %scoulomb';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -2));

{ TNewtonSquareMeterPerSquareCoulomb }

const
  NewtonSquareMeterPerSquareCoulombId = 123;
  NewtonSquareMeterPerSquareCoulombUnit : TUnit = (
    FUnitOfMeasurement : NewtonSquareMeterPerSquareCoulombId;
    FSymbol            : '%sN.%sm2/%sC2';
    FName              : '%snewton square %smeter per square %scoulomb';
    FPluralName        : '%snewton square %smeters per square %scoulomb';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, 2, -2));

{ TVoltMeter }

const
  VoltMeterId = 124;
  VoltMeterUnit : TUnit = (
    FUnitOfMeasurement : VoltMeterId;
    FSymbol            : '%sV.%sm';
    FName              : '%svolt %smeter';
    FPluralName        : '%svolt %smeters';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TNewtonSquareMeterPerCoulomb }

const
  NewtonSquareMeterPerCoulombUnit : TUnit = (
    FUnitOfMeasurement : VoltMeterId;
    FSymbol            : '%sN.%sm2/%sC';
    FName              : '%snewton square %smeter per %scoulomb';
    FPluralName        : '%snewton square %smeters per %scoulomb';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, 2, -1));

{ TVoltMeterPerSecond }

const
  VoltMeterPerSecondId = 125;
  VoltMeterPerSecondUnit : TUnit = (
    FUnitOfMeasurement : VoltMeterPerSecondId;
    FSymbol            : '%sV.%sm/%ss';
    FName              : '%svolt %smeter per %ssecond';
    FPluralName        : '%svolt %smeters per %ssecond';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, 1, -1));

{ TFaradPerMeter }

const
  FaradPerMeterId = 126;
  FaradPerMeterUnit : TUnit = (
    FUnitOfMeasurement : FaradPerMeterId;
    FSymbol            : '%sF/%sm';
    FName              : '%sfarad per %smeter';
    FPluralName        : '%sfarads per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TAmperePerMeter }

const
  AmperePerMeterId = 127;
  AmperePerMeterUnit : TUnit = (
    FUnitOfMeasurement : AmperePerMeterId;
    FSymbol            : '%sA/%sm';
    FName              : '%sampere per %smeter';
    FPluralName        : '%samperes per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TMeterPerAmpere }

const
  MeterPerAmpereId = 128;
  MeterPerAmpereUnit : TUnit = (
    FUnitOfMeasurement : MeterPerAmpereId;
    FSymbol            : '%sm/%sA';
    FName              : '%smeter per %sampere';
    FPluralName        : '%smeters per %sampere';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TTeslaMeter }

const
  TeslaMeterId = 129;
  TeslaMeterUnit : TUnit = (
    FUnitOfMeasurement : TeslaMeterId;
    FSymbol            : '%sT.%sm';
    FName              : '%stesla %smeter';
    FPluralName        : '%stesla %smeters';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TNewtonPerAmpere }

const
  NewtonPerAmpereUnit : TUnit = (
    FUnitOfMeasurement : TeslaMeterId;
    FSymbol            : '%sN/%sA';
    FName              : '%snewton per %sampere';
    FPluralName        : '%snewtons per %sampere';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TTeslaPerAmpere }

const
  TeslaPerAmpereId = 130;
  TeslaPerAmpereUnit : TUnit = (
    FUnitOfMeasurement : TeslaPerAmpereId;
    FSymbol            : '%sT/%sA';
    FName              : '%stesla per %sampere';
    FPluralName        : '%steslas per %sampere';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ THenryPerMeter }

const
  HenryPerMeterId = 131;
  HenryPerMeterUnit : TUnit = (
    FUnitOfMeasurement : HenryPerMeterId;
    FSymbol            : '%sH/%sm';
    FName              : '%shenry per %smeter';
    FPluralName        : '%shenries per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TTeslaMeterPerAmpere }

const
  TeslaMeterPerAmpereUnit : TUnit = (
    FUnitOfMeasurement : HenryPerMeterId;
    FSymbol            : '%sT.%sm/%sA';
    FName              : '%stesla %smeter per %sampere';
    FPluralName        : '%stesla %smeters per %sampere';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, 1, -1));

{ TNewtonPerSquareAmpere }

const
  NewtonPerSquareAmpereUnit : TUnit = (
    FUnitOfMeasurement : HenryPerMeterId;
    FSymbol            : '%sN/%sA2';
    FName              : '%snewton per square %sampere';
    FPluralName        : '%snewtons per square %sampere';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -2));

{ TRadianPerMeter }

const
  RadianPerMeterUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalMeterId;
    FSymbol            : 'rad/%sm';
    FName              : 'radian per %smeter';
    FPluralName        : 'radians per %smeter';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TSquareKilogramPerSquareSecond }

const
  SquareKilogramPerSquareSecondId = 132;
  SquareKilogramPerSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : SquareKilogramPerSquareSecondId;
    FSymbol            : '%sg2/%ss2';
    FName              : 'square %sgram per square %ssecond';
    FPluralName        : 'square %sgrams per square %ssecond';
    FPrefixes          : (pKilo, pNone);
    FExponents         : (2, -2));

{ TSquareSecondPerSquareMeter }

const
  SquareSecondPerSquareMeterId = 133;
  SquareSecondPerSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : SquareSecondPerSquareMeterId;
    FSymbol            : '%ss2/%sm2';
    FName              : 'square %ssecond per square %smeter';
    FPluralName        : 'square %sseconds per square %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (2, -2));

{ TSquareJoule }

const
  SquareJouleId = 134;
  SquareJouleUnit : TUnit = (
    FUnitOfMeasurement : SquareJouleId;
    FSymbol            : '%sJ2';
    FName              : 'square %sjoule';
    FPluralName        : 'square %sjoules';
    FPrefixes          : (pNone);
    FExponents         : (2));

var
  J2 : TUnit absolute SquareJouleUnit;

const
  TJ2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 134; FValue: 1E+24); {$ELSE} (1E+24); {$ENDIF}
  GJ2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 134; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MJ2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 134; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kJ2        : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: 134; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}

{ TJouleSecond }

const
  JouleSecondUnit : TUnit = (
    FUnitOfMeasurement : KilogramSquareMeterPerSecondId;
    FSymbol            : '%sJ.%ss';
    FName              : '%sjoule %ssecond';
    FPluralName        : '%sjoule %sseconds';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1));

{ TJoulePerHertz }

const
  JoulePerHertzUnit : TUnit = (
    FUnitOfMeasurement : KilogramSquareMeterPerSecondId;
    FSymbol            : '%sJ/%sHz';
    FName              : '%sjoule per %shertz';
    FPluralName        : '%sjoules per %shertz';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TElectronvoltSecond }

const
  ElectronvoltSecondUnit : TFactoredUnit = (
    FUnitOfMeasurement : KilogramSquareMeterPerSecondId;
    FSymbol            : '%seV.%ss';
    FName              : '%selectronvolt %ssecond';
    FPluralName        : '%selectronvolt %sseconds';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1);
    FFactor            : (1.60217742320523E-019));

{ TElectronvoltMeterPerSpeedOfLight }

const
  ElectronvoltMeterPerSpeedOfLightUnit : TFactoredUnit = (
    FUnitOfMeasurement : KilogramSquareMeterPerSecondId;
    FSymbol            : '%seV.%sm/c';
    FName              : '%selectronvolt %smeter per speed of  light';
    FPluralName        : '%selectronvolt %smeters per speed of  light';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, 1);
    FFactor            : (1.7826619216279E-36));

{ TSquareJouleSquareSecond }

const
  SquareJouleSquareSecondId = 135;
  SquareJouleSquareSecondUnit : TUnit = (
    FUnitOfMeasurement : SquareJouleSquareSecondId;
    FSymbol            : '%sJ2.%ss2';
    FName              : 'square %sjoule square %ssecond';
    FPluralName        : 'square %sjoule square %sseconds';
    FPrefixes          : (pNone, pNone);
    FExponents         : (2, 2));

{ TCoulombPerKilogram }

const
  CoulombPerKilogramId = 136;
  CoulombPerKilogramUnit : TUnit = (
    FUnitOfMeasurement : CoulombPerKilogramId;
    FSymbol            : '%sC/%sg';
    FName              : '%scoulomb per %sgram';
    FPluralName        : '%scoulombs per %sgram';
    FPrefixes          : (pNone, pKilo);
    FExponents         : (1, -1));

{ TSquareMeterAmpere }

const
  SquareMeterAmpereId = 137;
  SquareMeterAmpereUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterAmpereId;
    FSymbol            : '%sm2.%sA';
    FName              : 'square %smeter %sampere';
    FPluralName        : 'square %smeter %samperes';
    FPrefixes          : (pNone, pNone);
    FExponents         : (2, 1));

{ TJoulePerTesla }

const
  JoulePerTeslaUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterAmpereId;
    FSymbol            : '%sJ/%sT';
    FName              : '%sjoule per %stesla';
    FPluralName        : '%sjoules per %stesla';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TLumenPerWatt }

const
  LumenPerWattId = 138;
  LumenPerWattUnit : TUnit = (
    FUnitOfMeasurement : LumenPerWattId;
    FSymbol            : '%slm/%sW';
    FName              : '%slumen per %swatt';
    FPluralName        : '%slumens per %swatt';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TReciprocalMole }

const
  ReciprocalMoleId = 139;
  ReciprocalMoleUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalMoleId;
    FSymbol            : '1/%smol';
    FName              : 'reciprocal %smole';
    FPluralName        : 'reciprocal %smoles';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TAmperePerSquareMeter }

const
  AmperePerSquareMeterId = 140;
  AmperePerSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : AmperePerSquareMeterId;
    FSymbol            : '%sA/%sm2';
    FName              : '%sampere per square %smeter';
    FPluralName        : '%samperes per square %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -2));

{ TMolePerCubicMeter }

const
  MolePerCubicMeterId = 141;
  MolePerCubicMeterUnit : TUnit = (
    FUnitOfMeasurement : MolePerCubicMeterId;
    FSymbol            : '%smol/%sm3';
    FName              : '%smole per cubic %smeter';
    FPluralName        : '%smoles per cubic %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -3));

{ TCandelaPerSquareMeter }

const
  CandelaPerSquareMeterId = 142;
  CandelaPerSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : CandelaPerSquareMeterId;
    FSymbol            : '%scd/%sm2';
    FName              : '%scandela per square %smeter';
    FPluralName        : '%scandelas per square %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -2));

{ TCoulombPerCubicMeter }

const
  CoulombPerCubicMeterId = 143;
  CoulombPerCubicMeterUnit : TUnit = (
    FUnitOfMeasurement : CoulombPerCubicMeterId;
    FSymbol            : '%sC/%sm3';
    FName              : '%scoulomb per cubic %smeter';
    FPluralName        : '%scoulombs per cubic %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -3));

{ TGrayPerSecond }

const
  GrayPerSecondId = 144;
  GrayPerSecondUnit : TUnit = (
    FUnitOfMeasurement : GrayPerSecondId;
    FSymbol            : '%sGy/%ss';
    FName              : '%sgray per %ssecond';
    FPluralName        : '%sgrays per %ssecond';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TSteradianHertz }

const
  SteradianHertzId = 145;
  SteradianHertzUnit : TUnit = (
    FUnitOfMeasurement : SteradianHertzId;
    FSymbol            : 'sr.%sHz';
    FName              : 'steradian %shertz';
    FPluralName        : 'steradian %shertz';
    FPrefixes          : (pNone);
    FExponents         : (1));

{ TMeterSteradian }

const
  MeterSteradianId = 146;
  MeterSteradianUnit : TUnit = (
    FUnitOfMeasurement : MeterSteradianId;
    FSymbol            : '%sm.sr';
    FName              : '%smeter steradian';
    FPluralName        : '%smeter steradians';
    FPrefixes          : (pNone);
    FExponents         : (1));

{ TSquareMeterSteradian }

const
  SquareMeterSteradianId = 147;
  SquareMeterSteradianUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterSteradianId;
    FSymbol            : '%sm2.sr';
    FName              : 'square %smeter steradian';
    FPluralName        : 'square %smeter steradians';
    FPrefixes          : (pNone);
    FExponents         : (2));

{ TCubicMeterSteradian }

const
  CubicMeterSteradianId = 148;
  CubicMeterSteradianUnit : TUnit = (
    FUnitOfMeasurement : CubicMeterSteradianId;
    FSymbol            : '%sm3.sr';
    FName              : 'cubic %smeter steradian';
    FPluralName        : 'cubic %smeter steradians';
    FPrefixes          : (pNone);
    FExponents         : (3));

{ TSquareMeterSteradianHertz }

const
  SquareMeterSteradianHertzId = 149;
  SquareMeterSteradianHertzUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterSteradianHertzId;
    FSymbol            : '%sm2.sr.%shertz';
    FName              : 'square %smeter steradian %shertz';
    FPluralName        : 'square %smeter steradian %shertz';
    FPrefixes          : (pNone, pNone);
    FExponents         : (2, 1));

{ TWattPerSteradian }

const
  WattPerSteradianId = 150;
  WattPerSteradianUnit : TUnit = (
    FUnitOfMeasurement : WattPerSteradianId;
    FSymbol            : '%sW/sr';
    FName              : '%swatt per steradian';
    FPluralName        : '%swatts per steradian';
    FPrefixes          : (pNone);
    FExponents         : (1));

{ TWattPerSteradianPerHertz }

const
  WattPerSteradianPerHertzId = 151;
  WattPerSteradianPerHertzUnit : TUnit = (
    FUnitOfMeasurement : WattPerSteradianPerHertzId;
    FSymbol            : '%sW/sr/%sHz';
    FName              : '%swatt per steradian per %shertz';
    FPluralName        : '%swatts per steradian per %shertz';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TWattPerMeterPerSteradian }

const
  WattPerMeterPerSteradianId = 152;
  WattPerMeterPerSteradianUnit : TUnit = (
    FUnitOfMeasurement : WattPerMeterPerSteradianId;
    FSymbol            : '%sW/sr/%sm';
    FName              : '%swatt per steradian per %smeter';
    FPluralName        : '%swatts per steradian per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TWattPerSquareMeterPerSteradian }

const
  WattPerSquareMeterPerSteradianId = 153;
  WattPerSquareMeterPerSteradianUnit : TUnit = (
    FUnitOfMeasurement : WattPerSquareMeterPerSteradianId;
    FSymbol            : '%sW/%sm2/sr';
    FName              : '%swatt per square %smeter per steradian';
    FPluralName        : '%swatts per square %smeter per steradian';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -2));

{ TWattPerCubicMeterPerSteradian }

const
  WattPerCubicMeterPerSteradianId = 154;
  WattPerCubicMeterPerSteradianUnit : TUnit = (
    FUnitOfMeasurement : WattPerCubicMeterPerSteradianId;
    FSymbol            : '%sW/%sm3/sr';
    FName              : '%swatt per cubic %smeter per steradian';
    FPluralName        : '%swatts per cubic %smeter per steradian';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -3));

{ TWattPerSquareMeterPerSteradianPerHertz }

const
  WattPerSquareMeterPerSteradianPerHertzId = 155;
  WattPerSquareMeterPerSteradianPerHertzUnit : TUnit = (
    FUnitOfMeasurement : WattPerSquareMeterPerSteradianPerHertzId;
    FSymbol            : '%sW/%sm2/sr/%sHz';
    FName              : '%swatt per square %smeter per steradian per %shertz';
    FPluralName        : '%swatts per square %smeter per steradian per %shertz';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, -2, -1));

{ TKatalPerCubicMeter }

const
  KatalPerCubicMeterId = 156;
  KatalPerCubicMeterUnit : TUnit = (
    FUnitOfMeasurement : KatalPerCubicMeterId;
    FSymbol            : '%skat/%sm3';
    FName              : '%skatal per cubic %smeter';
    FPluralName        : '%skatals per cubic %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -3));

{ TCoulombPerMole }

const
  CoulombPerMoleId = 157;
  CoulombPerMoleUnit : TUnit = (
    FUnitOfMeasurement : CoulombPerMoleId;
    FSymbol            : '%sC/%smol';
    FName              : '%scoulomb per %smole';
    FPluralName        : '%scoulombs per %smole';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TReciprocalNewton }

const
  ReciprocalNewtonId = 158;
  ReciprocalNewtonUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalNewtonId;
    FSymbol            : '1/%sN';
    FName              : 'reciprocal %snewton';
    FPluralName        : 'reciprocal %snewtons';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TReciprocalTesla }

const
  ReciprocalTeslaId = 159;
  ReciprocalTeslaUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalTeslaId;
    FSymbol            : '1/%sT';
    FName              : 'reciprocal %stesla';
    FPluralName        : 'reciprocal %steslas';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TReciprocalPascal }

const
  ReciprocalPascalId = 160;
  ReciprocalPascalUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalPascalId;
    FSymbol            : '1/%sPa';
    FName              : 'reciprocal %spascal';
    FPluralName        : 'reciprocal %spascals';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TReciprocalWeber }

const
  ReciprocalWeberId = 161;
  ReciprocalWeberUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalWeberId;
    FSymbol            : '1/%sWb';
    FName              : 'reciprocal %sweber';
    FPluralName        : 'reciprocal %swebers';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TReciprocalWatt }

const
  ReciprocalWattId = 162;
  ReciprocalWattUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalWattId;
    FSymbol            : '1/%sW';
    FName              : 'reciprocal %swatt';
    FPluralName        : 'reciprocal %swatts';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TReciprocalRadian }

const
  ReciprocalRadianUnit : TUnit = (
    FUnitOfMeasurement : ScalarId;
    FSymbol            : '1/%srad';
    FName              : 'reciprocal %sradian';
    FPluralName        : 'reciprocal %sradians';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TMeterPerVolt }

const
  MeterPerVoltId = 163;
  MeterPerVoltUnit : TUnit = (
    FUnitOfMeasurement : MeterPerVoltId;
    FSymbol            : '%sm/%sV';
    FName              : '%smeter per %svolt';
    FPluralName        : '%smeters per %svolt';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TReciprocalSteradian }

const
  ReciprocalSteradianId = 164;
  ReciprocalSteradianUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalSteradianId;
    FSymbol            : '1/sr';
    FName              : 'reciprocal steradian';
    FPluralName        : 'reciprocal steradian';
    FPrefixes          : ();
    FExponents         : ());

{ TReciprocalCubicSecond }

const
  ReciprocalCubicSecondId = 165;
  ReciprocalCubicSecondUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalCubicSecondId;
    FSymbol            : '1/%ss3';
    FName              : 'reciprocal cubic %ssecond';
    FPluralName        : 'reciprocal cubic %ssecond';
    FPrefixes          : (pNone);
    FExponents         : (-3));

{ TReciprocalQuarticSecond }

const
  ReciprocalQuarticSecondId = 166;
  ReciprocalQuarticSecondUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalQuarticSecondId;
    FSymbol            : '1/%ss4';
    FName              : 'reciprocal quartic %ssecond';
    FPluralName        : 'reciprocal quartic %ssecond';
    FPrefixes          : (pNone);
    FExponents         : (-4));

{ TReciprocalQuinticSecond }

const
  ReciprocalQuinticSecondId = 167;
  ReciprocalQuinticSecondUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalQuinticSecondId;
    FSymbol            : '1/%ss5';
    FName              : 'reciprocal quintic %ssecond';
    FPluralName        : 'reciprocal quintic %ssecond';
    FPrefixes          : (pNone);
    FExponents         : (-5));

{ TReciprocalSexticSecond }

const
  ReciprocalSexticSecondId = 168;
  ReciprocalSexticSecondUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalSexticSecondId;
    FSymbol            : '1/%ss6';
    FName              : 'reciprocal sextic %ssecond';
    FPluralName        : 'reciprocal sextic %ssecond';
    FPrefixes          : (pNone);
    FExponents         : (-6));

{ TReciprocalQuinticMeter }

const
  ReciprocalQuinticMeterId = 169;
  ReciprocalQuinticMeterUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalQuinticMeterId;
    FSymbol            : '1/%sm5';
    FName              : 'reciprocal quintic %smeter';
    FPluralName        : 'reciprocal quintic %smeter';
    FPrefixes          : (pNone);
    FExponents         : (-5));

{ TReciprocalSexticMeter }

const
  ReciprocalSexticMeterId = 170;
  ReciprocalSexticMeterUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalSexticMeterId;
    FSymbol            : '1/%sm6';
    FName              : 'reciprocal sextic %smeter';
    FPluralName        : 'reciprocal sextic %smeter';
    FPrefixes          : (pNone);
    FExponents         : (-6));

{ TReciprocalKilogram }

const
  ReciprocalKilogramId = 171;
  ReciprocalKilogramUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalKilogramId;
    FSymbol            : '1/%skg';
    FName              : 'reciprocal %skilogram';
    FPluralName        : 'reciprocal %skilogram';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TReciprocalSquareKilogram }

const
  ReciprocalSquareKilogramId = 172;
  ReciprocalSquareKilogramUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalSquareKilogramId;
    FSymbol            : '1/%skg2';
    FName              : 'reciprocal square %skilogram';
    FPluralName        : 'reciprocal square %skilogram';
    FPrefixes          : (pNone);
    FExponents         : (-2));

{ TReciprocalAmpere }

const
  ReciprocalAmpereId = 173;
  ReciprocalAmpereUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalAmpereId;
    FSymbol            : '1/%sA';
    FName              : 'reciprocal %sampere';
    FPluralName        : 'reciprocal %sampere';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TReciprocalSquareAmpere }

const
  ReciprocalSquareAmpereId = 174;
  ReciprocalSquareAmpereUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalSquareAmpereId;
    FSymbol            : '1/%sA2';
    FName              : 'reciprocal square %sampere';
    FPluralName        : 'reciprocal square %sampere';
    FPrefixes          : (pNone);
    FExponents         : (-2));

{ TReciprocalSquareKelvin }

const
  ReciprocalSquareKelvinId = 175;
  ReciprocalSquareKelvinUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalSquareKelvinId;
    FSymbol            : '1/%sK2';
    FName              : 'reciprocal square %skelvin';
    FPluralName        : 'reciprocal square %skelvin';
    FPrefixes          : (pNone);
    FExponents         : (-2));

{ TReciprocalCubicKelvin }

const
  ReciprocalCubicKelvinId = 176;
  ReciprocalCubicKelvinUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalCubicKelvinId;
    FSymbol            : '1/%sK3';
    FName              : 'reciprocal cubic %skelvin';
    FPluralName        : 'reciprocal cubic %skelvin';
    FPrefixes          : (pNone);
    FExponents         : (-3));

{ TReciprocalQuarticKelvin }

const
  ReciprocalQuarticKelvinId = 177;
  ReciprocalQuarticKelvinUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalQuarticKelvinId;
    FSymbol            : '1/%sK4';
    FName              : 'reciprocal quartic %skelvin';
    FPluralName        : 'reciprocal quartic %skelvin';
    FPrefixes          : (pNone);
    FExponents         : (-4));

{ TReciprocalCandela }

const
  ReciprocalCandelaId = 178;
  ReciprocalCandelaUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalCandelaId;
    FSymbol            : '1/%scd';
    FName              : 'reciprocal %scandela';
    FPluralName        : 'reciprocal %scandela';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TSquareSecondPerSteradian }

const
  SquareSecondPerSteradianId = 179;
  SquareSecondPerSteradianUnit : TUnit = (
    FUnitOfMeasurement : SquareSecondPerSteradianId;
    FSymbol            : '%ss2/sr';
    FName              : 'square %ssecond  per steradian';
    FPluralName        : 'square %sseconds  per steradian';
    FPrefixes          : (pNone);
    FExponents         : (2));

{ TSquareSecondPerMeter }

const
  SquareSecondPerMeterId = 180;
  SquareSecondPerMeterUnit : TUnit = (
    FUnitOfMeasurement : SquareSecondPerMeterId;
    FSymbol            : '%ss2/%sm';
    FName              : 'square %ssecond per %smeter';
    FPluralName        : 'square %sseconds per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (2, -1));

{ TCubicSecondPerMeter }

const
  CubicSecondPerMeterId = 181;
  CubicSecondPerMeterUnit : TUnit = (
    FUnitOfMeasurement : CubicSecondPerMeterId;
    FSymbol            : '%ss3/%sm';
    FName              : 'cubic %ssecond per %smeter';
    FPluralName        : 'cubic %sseconds per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (3, -1));

{ TQuarticSecondPerMeter }

const
  QuarticSecondPerMeterId = 182;
  QuarticSecondPerMeterUnit : TUnit = (
    FUnitOfMeasurement : QuarticSecondPerMeterId;
    FSymbol            : '%ss4/%sm';
    FName              : 'quartic %ssecond per %smeter';
    FPluralName        : 'quartic %sseconds per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (4, -1));

{ TQuinticSecondPerMeter }

const
  QuinticSecondPerMeterId = 183;
  QuinticSecondPerMeterUnit : TUnit = (
    FUnitOfMeasurement : QuinticSecondPerMeterId;
    FSymbol            : '%ss5/%sm';
    FName              : 'quintic %ssecond per %smeter';
    FPluralName        : 'quintic %sseconds per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (5, -1));

{ TSexticSecondPerMeter }

const
  SexticSecondPerMeterId = 184;
  SexticSecondPerMeterUnit : TUnit = (
    FUnitOfMeasurement : SexticSecondPerMeterId;
    FSymbol            : '%ss6/%sm';
    FName              : 'sextic %ssecond per %smeter';
    FPluralName        : 'sextic %sseconds per %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (6, -1));

{ TReciprocalMeterSecond }

const
  ReciprocalMeterSecondId = 185;
  ReciprocalMeterSecondUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalMeterSecondId;
    FSymbol            : '1/%sm/%ss';
    FName              : 'reciprocal %smeter %ssecond';
    FPluralName        : 'reciprocal %smeter %ssecond';
    FPrefixes          : (pNone, pNone);
    FExponents         : (-1, -1));

{ TReciprocalKilogramMeter }

const
  ReciprocalKilogramMeterId = 186;
  ReciprocalKilogramMeterUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalKilogramMeterId;
    FSymbol            : '1/%skg/%sm';
    FName              : 'reciprocal %skilogram %smeter';
    FPluralName        : 'reciprocal %skilogram %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (-1, -1));

{ TSecondPerKilogram }

const
  SecondPerKilogramId = 187;
  SecondPerKilogramUnit : TUnit = (
    FUnitOfMeasurement : SecondPerKilogramId;
    FSymbol            : '%ss/%skg';
    FName              : '%ssecond per %skilogram';
    FPluralName        : '%sseconds per %skilogram';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TSecondPerKilogramMeter }

const
  SecondPerKilogramMeterId = 188;
  SecondPerKilogramMeterUnit : TUnit = (
    FUnitOfMeasurement : SecondPerKilogramMeterId;
    FSymbol            : '%ss/%skg/%sm';
    FName              : '%ssecond per %skilogram per %smeter';
    FPluralName        : '%sseconds per %skilogram per %smeter';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, -1, -1));

{ TSquareSecondPerSquareKilogramPerSquareMeter }

const
  SquareSecondPerSquareKilogramPerSquareMeterId = 189;
  SquareSecondPerSquareKilogramPerSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : SquareSecondPerSquareKilogramPerSquareMeterId;
    FSymbol            : '%ss2/%skg2/%sm2';
    FName              : 'square %ssecond per square %skilogram per square %smeter';
    FPluralName        : 'square %sseconds per square %skilogram per square %smeter';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (2, -2, -2));

{ TSquareRootCubicMeter }

const
  SquareRootCubicMeterId = 190;
  SquareRootCubicMeterUnit : TUnit = (
    FUnitOfMeasurement : SquareRootCubicMeterId;
    FSymbol            : '√%sm3';
    FName              : 'square root cubic %smeter';
    FPluralName        : 'square root cubic %smeters';
    FPrefixes          : (pNone);
    FExponents         : (3));

{ TReciprocalKilogramSquareMeter }

const
  ReciprocalKilogramSquareMeterId = 191;
  ReciprocalKilogramSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalKilogramSquareMeterId;
    FSymbol            : '1/%skg/%sm2';
    FName              : 'reciprocal %skilogram square %smeter';
    FPluralName        : 'reciprocal %skilogram square %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (-1, -2));

{ TSecondPerKilogramSquareMeter }

const
  SecondPerKilogramSquareMeterId = 192;
  SecondPerKilogramSquareMeterUnit : TUnit = (
    FUnitOfMeasurement : SecondPerKilogramSquareMeterId;
    FSymbol            : '%ss/%skg/%sm2';
    FName              : '%ssecond per %skilogram per square %smeter';
    FPluralName        : '%sseconds per %skilogram per square %smeter';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (1, -1, -2));

{ TMeterPerKilogram }

const
  MeterPerKilogramId = 193;
  MeterPerKilogramUnit : TUnit = (
    FUnitOfMeasurement : MeterPerKilogramId;
    FSymbol            : '%sm/%skg';
    FName              : '%smeter per %skilogram';
    FPluralName        : '%smeters per %skilogram';
    FPrefixes          : (pNone, pNone);
    FExponents         : (1, -1));

{ TSquareMeterPerKilogram }

const
  SquareMeterPerKilogramId = 194;
  SquareMeterPerKilogramUnit : TUnit = (
    FUnitOfMeasurement : SquareMeterPerKilogramId;
    FSymbol            : '%sm2/%skg';
    FName              : 'square %smeter per %skilogram';
    FPluralName        : 'square %smeters per %skilogram';
    FPrefixes          : (pNone, pNone);
    FExponents         : (2, -1));

{ TReciprocalSquareNewton }

const
  ReciprocalSquareNewtonId = 195;
  ReciprocalSquareNewtonUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalSquareNewtonId;
    FSymbol            : '1/%sN2';
    FName              : 'reciprocal square %snewton';
    FPluralName        : 'reciprocal square %snewton';
    FPrefixes          : (pNone);
    FExponents         : (-2));

{ TReciprocalJoule }

const
  ReciprocalJouleId = 196;
  ReciprocalJouleUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalJouleId;
    FSymbol            : '1/%sJ';
    FName              : 'reciprocal %sjoule';
    FPluralName        : 'reciprocal %sjoule';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TReciprocalCoulomb }

const
  ReciprocalCoulombId = 197;
  ReciprocalCoulombUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalCoulombId;
    FSymbol            : '1/%sC';
    FName              : 'reciprocal %scoulomb';
    FPluralName        : 'reciprocal %scoulomb';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TReciprocalSquareCoulomb }

const
  ReciprocalSquareCoulombId = 198;
  ReciprocalSquareCoulombUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalSquareCoulombId;
    FSymbol            : '1/%sC2';
    FName              : 'reciprocal square %scoulomb';
    FPluralName        : 'reciprocal square %scoulomb';
    FPrefixes          : (pNone);
    FExponents         : (-2));

{ TReciprocalCoulombMeter }

const
  ReciprocalCoulombMeterId = 199;
  ReciprocalCoulombMeterUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalCoulombMeterId;
    FSymbol            : '1/%sC/%sm';
    FName              : 'reciprocal %scoulomb %smeter';
    FPluralName        : 'reciprocal %scoulomb %smeter';
    FPrefixes          : (pNone, pNone);
    FExponents         : (-1, -1));

{ TReciprovalVolt }

const
  ReciprovalVoltId = 200;
  ReciprovalVoltUnit : TUnit = (
    FUnitOfMeasurement : ReciprovalVoltId;
    FSymbol            : '1/%sV';
    FName              : 'reciproval %svolt';
    FPluralName        : 'reciproval %svolt';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TReciprocalSquareVolt }

const
  ReciprocalSquareVoltId = 201;
  ReciprocalSquareVoltUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalSquareVoltId;
    FSymbol            : '1/%sV2';
    FName              : 'reciprocal square %svolt';
    FPluralName        : 'reciprocal square %svolt';
    FPrefixes          : (pNone);
    FExponents         : (-2));

{ TReciprocalFarad }

const
  ReciprocalFaradId = 202;
  ReciprocalFaradUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalFaradId;
    FSymbol            : '1/%sF';
    FName              : 'reciprocal %sfarad';
    FPluralName        : 'reciprocal %sfarad';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TReciprocalLumen }

const
  ReciprocalLumenId = 203;
  ReciprocalLumenUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalLumenId;
    FSymbol            : '1/%slm';
    FName              : 'reciprocal %slumen';
    FPluralName        : 'reciprocal %slumen';
    FPrefixes          : (pNone);
    FExponents         : (-1));

{ TReciprocalLumenSecond }

const
  ReciprocalLumenSecondId = 204;
  ReciprocalLumenSecondUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalLumenSecondId;
    FSymbol            : '1/%slm/%ss';
    FName              : 'reciprocal %slumen %ssecond';
    FPluralName        : 'reciprocal %slumen %ssecond';
    FPrefixes          : (pNone, pNone);
    FExponents         : (-1, -1));

{ TCubicMeterPerLumenSecond }

const
  CubicMeterPerLumenSecondId = 205;
  CubicMeterPerLumenSecondUnit : TUnit = (
    FUnitOfMeasurement : CubicMeterPerLumenSecondId;
    FSymbol            : '%sm3/%slm/%ss';
    FName              : 'cubic %smeter per %lumen per %ssecond';
    FPluralName        : 'cubic %smeters per %lumen per %ssecond';
    FPrefixes          : (pNone, pNone, pNone);
    FExponents         : (3, -1, -1));

{ TReciprocalLux }

const
  ReciprocalLuxId = 206;
  ReciprocalLuxUnit : TUnit = (
    FUnitOfMeasurement : ReciprocalLuxId;
    FSymbol            : '1/%slx';
    FName              : 'reciprocal %slux';
    FPluralName        : 'reciprocal %slux';
    FPrefixes          : (pNone);
    FExponents         : (-1));

const

  { Mul Table }

  MulTable : array[0..206, 0..206] of longint = (
    (  0 ,  1 ,  2 ,  3 ,  4 ,  5 ,  6 ,  7 ,  8 ,  9 , 10 , 11 , 12 , 13 , 14 , 15 , 16 , 17 , 18 , 19 , 20 , 21 , 22 , 23 , 24 , 25 , 26 , 27 , 28 , 29 , 30 , 31 , 32 , 33 , 34 , 35 , 36 , 37 , 38 , 39 , 40 , 41 , 42 , 43 , 44 , 45 , 46 , 47 , 48 , 49 , 50 , 51 , 52 , 53 , 54 , 55 , 56 , 57 , 58 , 59 , 60 , 61 , 62 , 63 , 64 , 65 , 66 , 67 , 68 , 69 , 70 , 71 , 72 , 73 , 74 , 75 , 76 , 77 , 78 , 79 , 80 , 81 , 82 , 83 , 84 , 85 , 86 , 87 , 88 , 89 , 90 , 91 , 92 , 93 , 94 , 95 , 96 , 97 , 98 , 99 ,100 ,101 ,102 ,103 ,104 ,105 ,106 ,107 ,108 ,109 ,110 ,111 ,112 ,113 ,114 ,115 ,116 ,117 ,118 ,119 ,120 ,121 ,122 ,123 ,124 ,125 ,126 ,127 ,128 ,129 ,130 ,131 ,132 ,133 ,134 ,135 ,136 ,137 ,138 ,139 ,140 ,141 ,142 ,143 ,144 ,145 ,146 ,147 ,148 ,149 ,150 ,151 ,152 ,153 ,154 ,155 ,156 ,157 ,158 ,159 ,160 ,161 ,162 ,163 ,164 ,165 ,166 ,167 ,168 ,169 ,170 ,171 ,172 ,173 ,174 ,175 ,176 ,177 ,178 ,179 ,180 ,181 ,182 ,183 ,184 ,185 ,186 ,187 ,188 ,189 ,190 ,191 ,192 ,193 ,194 ,195 ,196 ,197 ,198 ,199 ,200 ,201 ,202 ,203 ,204 ,205 ,206),
    (  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 , -1 ,147 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 ,145 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 ,153 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,178 , -1 , -1 , -1),
    (  2 , -1 ,  3 ,  4 ,  5 ,  6 ,  7 , -1 , 35 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 25 ,145 ,  8 , 28 , 29 , 30 , 31 , 32 , 80 , -1 , -1 , 15 , 36 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , 46 ,180 , -1 , -1 , -1 , 38 , -1 , 79 , 47 , 55 , -1 , -1 , -1 , 67 , -1 , -1 , 68 , 62 ,126 , -1 , -1 , -1 , 64 , 71 , -1 , -1 , 74 , -1 , 23 , -1 , 37 , 11 , 49 , 10 , -1 , -1 , 81 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , 77 , 54 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 ,116 , -1 ,124 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,159 , -1 , -1 , -1 ,120 , -1 , -1 , -1 , 34 ,  1 , -1 , -1 , -1 ,147 ,151 , -1 , -1 ,155 , -1 , -1 ,141 , -1 ,106 , -1 , -1 ,200 , -1 , -1 , -1 , 26 ,165 ,166 ,167 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,181 ,182 ,183 ,184 , -1 , 41 ,188 , -1 ,158 , -1 , -1 ,192 ,196 , -1 , -1 , -1 ,162 ,173 , -1 , -1 , -1 , -1 , 63 , -1 ,203 , -1 , -1),
    (  3 , -1 ,  4 ,  5 ,  6 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 ,  0 ,  1 , 35 ,  8 , 28 , 29 , 30 , 31 , 10 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , -1 ,133 , -1 , -1 , -1 , -1 ,181 , -1 , -1 , -1 , 36 , 39 , 49 , 46 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 ,193 , -1 , -1 , -1 , 84 , -1 , -1 , -1 ,108 , -1 , -1 , 38 , 37 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 16 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,179 , 25 , 26 ,165 ,166 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,182 ,183 ,184 , -1 , -1 , 48 ,158 , -1 ,106 ,195 , -1 ,196 ,162 ,160 , -1 , -1 , -1 , -1 ,174 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1),
    (  4 , -1 ,  5 ,  6 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 ,  2 , -1 , -1 , 35 ,  8 , 28 , 29 , 30 , -1 , -1 , -1 , 85 , -1 , -1 , -1 ,181 , -1 , -1 , -1 , -1 , -1 , -1 ,182 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , 15 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 25 , 26 ,165 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,183 ,184 , -1 , -1 , -1 ,180 ,106 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  5 , -1 ,  6 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 ,  3 , -1 , -1 , -1 , 35 ,  8 , 28 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,182 , -1 , -1 , -1 , -1 , -1 , -1 ,183 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 ,  0 , 25 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,184 , -1 , -1 , -1 , -1 ,181 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  6 , -1 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  5 ,  4 , -1 , -1 , -1 , -1 , 35 ,  8 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,183 , -1 , -1 , -1 , -1 , -1 , -1 ,184 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 ,  2 ,  0 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,182 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  6 ,  5 , -1 , -1 , -1 , -1 , -1 , 35 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,184 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 ,  3 ,  2 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,183 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  8 ,146 , 35 , -1 , -1 , -1 , -1 , -1 , 10 ,190 , 11 , 12 , 13 , 14 , -1 , 36 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , 28 , 29 , -1 , 80 , 34 ,144 , -1 , -1 , -1 , 86 , -1 , 46 , 38 , 47 , -1 ,  9 ,  0 , 40 , 41 , 43 , 44 , -1 , -1 ,  2 , 15 , 49 , 50 , 55 , -1 , 77 , 87 , -1 , 59 , -1 , -1 ,124 , -1 , -1 ,116 , -1 , 64 ,129 , -1 , -1 , -1 , -1 , -1 , 74 , -1 , -1 , -1 , 54 , 52 , -1 , 37 , 78 , 51 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , 16 , 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , 56 ,100 ,101 , -1 ,103 ,107 , -1 , -1 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , 57 , 58 ,118 , -1 ,202 , -1 , -1 , -1 , 62 , 17 , -1 , 67 ,131 , 68 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 ,120 , -1 , -1 ,147 ,148 , -1 , -1 , -1 , -1 ,150 ,152 ,153 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , 30 , 31 , 32 , 33 , 45 ,169 ,193 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 ,  4 ,  5 ,  6 ,  7 , 25 ,171 , -1 ,187 , -1 , -1 ,186 ,188 ,194 , 84 , -1 ,158 , -1 , -1 ,197 ,163 , -1 ,123 , -1 , -1 , -1 , -1),
    (  9 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,190 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 40 , 41 , 42 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 10 ,147 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , 12 , 13 , 14 , -1 , -1 , 46 , -1 ,137 , -1 , -1 , -1 , -1 ,110 , -1 , -1 , 80 , 34 , -1 , 78 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 ,135 ,190 ,  8 ,  9 ,  0 , 41 , 43 , -1 , -1 , 35 , 36 , 15 , 49 , 87 ,134 , 52 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , 71 , -1 , 77 , 55 , -1 , 38 , -1 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , 16 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , 98 , -1 , 56 ,100 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , 59 , -1 , 57 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , 39 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , 24 ,118 , -1 ,149 ,148 , -1 , -1 , -1 , -1 , -1 , -1 ,150 ,152 ,151 , -1 , -1 ,160 , -1 , -1 ,159 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , 44 , 45 ,194 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 ,193 , -1 , -1 , -1 , -1 ,171 ,187 , 84 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 ,206 , -1 , -1 , -1),
    ( 11 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , 13 , 14 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 , -1 , 10 ,190 ,  8 ,  0 , 41 , -1 , -1 , -1 , 46 , 36 , 15 , 88 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 71 , -1 , -1 , -1 , 52 , 87 , -1 , 47 , -1 , 49 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , 44 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 ,194 , -1 , -1 , -1 , -1 ,193 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,205 , -1 , -1),
    ( 12 , -1 , 82 , -1 , -1 , -1 , -1 , -1 , 13 , -1 , 14 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , 10 ,  8 ,  0 , -1 , -1 , -1 , -1 , 46 , 36 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 88 , -1 , -1 , -1 , 15 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , 84 , -1 , -1 , -1 , -1 ,194 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 13 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 14 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , 11 , 10 ,  8 , -1 , -1 , 82 , -1 , -1 , 46 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , 36 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 14 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 13 , -1 , 12 , 11 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , 46 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 15 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , 36 , -1 , 46 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , -1 , -1 , 37 , 77 ,155 , 38 , 52 ,100 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , 50 , 51 , 81 , -1 , -1 , -1 , 90 , 91 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , 47 , -1 , -1 , -1 , 11 , -1 , 87 , -1 ,135 , 29 , -1 , -1 ,194 , 86 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,181 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 ,  0 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 41 ,  2 , 48 ,196 , -1 , 43 , -1 ,  8 , 10 , -1 ,133 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , 90 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , 10 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , -1 ,133 , -1 , 50 , -1 , 36 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 17 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 ,127 , -1 ,140 , -1 , -1 , -1 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , 60 , -1 , -1 , 77 , 55 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 ,100 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 ,  8 , 52 , 66 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 , 25 , -1 ,185 , 64 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 18 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 ,  0 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , 20 , 21 , 22 , -1 ,114 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , 55 , 34 , -1 , -1 , -1 , -1 , -1 , 56 ,100 , -1 ,107 , -1 , 10 ,101 , -1 , -1 , -1 , -1 , -1 ,113 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 ,175 ,176 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 20 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 21 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 94 ,175 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 21 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 20 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 ,  0 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,110 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 21 , -1 , -1 , -1 , -1 , -1 , -1 ,112 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 20 , 19 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,114 , -1 , -1 , -1 , -1 , -1 , 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,141 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 24 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,142 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,164 , -1 , -1 , -1),
    ( 25 ,145 ,  0 ,  2 ,  3 ,  4 ,  5 ,  6 , 28 , -1 , 80 , 78 , -1 , -1 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 75 , -1 , 26 ,165 , -1 , 29 , 30 , 31 , 32 , 33 , -1 ,144 ,  8 , 38 , 77 , 52 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , 47 , 55 , 41 , 79 , -1 , -1 ,100 , -1 ,102 , 56 , -1 , 17 , -1 , -1 , -1 , -1 , 64 ,202 , 69 , -1 , -1 , 60 , 63 , -1 , -1 , 70 , -1 , -1 , 73 , -1 , -1 ,101 , 86 , 54 , 34 , 83 , 12 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 ,127 , -1 ,140 , -1 , -1 , -1 ,125 , -1 , 65 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,156 , -1 , -1 , -1 , 27 , -1 ,149 , -1 , -1 , -1 ,150 , -1 , -1 , -1 ,153 , -1 , -1 ,188 ,136 , -1 , -1 ,196 , -1 , -1 ,166 ,167 ,168 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , 48 ,180 ,181 ,182 ,183 , -1 , -1 ,171 ,186 , -1 , -1 , -1 ,191 , -1 , -1 , -1 ,192 , -1 , -1 , -1 ,161 , -1 , -1 ,204 , -1 , -1 , -1),
    ( 26 , 27 , 25 ,  0 ,  2 ,  3 ,  4 ,  5 , 29 , -1 , 34 , 86 , -1 , -1 , -1 , 77 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,165 ,166 , -1 , 30 , 31 , 32 , 33 , -1 , -1 , -1 , 28 , 52 ,101 ,100 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 56 ,185 , 54 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 ,202 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 ,144 , -1 , -1 , -1 , 93 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , 43 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , -1 ,193 , -1 ,192 , -1 , -1 ,167 ,168 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 ,164 , 41 , 48 ,180 ,181 ,182 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 ,189 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 27 , -1 ,145 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 ,152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 28 , -1 ,  8 , 35 , -1 , -1 , -1 , -1 , 80 , -1 , 78 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , 30 , -1 , 34 ,144 , -1 , -1 , -1 , -1 , -1 , 10 , 47 , 52 , 55 , -1 , -1 , 25 , -1 ,185 , -1 , -1 , -1 , 87 ,  0 , 37 , 79 , -1 , 56 , -1 ,101 , -1 , -1 , -1 , -1 ,137 ,125 , -1 , -1 ,123 , -1 , 69 ,117 ,124 ,116 , -1 , -1 , -1 , 73 , -1 , -1 , -1 ,102 ,100 , -1 , 77 , 86 , -1 , 13 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 , 60 , -1 , 63 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 , -1 , -1 ,187 , -1 , -1 , -1 ,158 ,159 , -1 , 31 , 32 , 33 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 ,  3 ,  4 ,  5 ,  6 , 26 , -1 ,193 ,171 , -1 , -1 , -1 ,186 , -1 , -1 , -1 ,188 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,205),
    ( 29 , -1 , 28 ,  8 , 35 , -1 , -1 , -1 , 34 , -1 , 86 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 30 , 31 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , 55 ,100 , 56 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , 87 , -1 , 25 , 77 , 54 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 ,122 ,202 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , -1 ,194 , -1 ,188 ,136 , -1 , 32 , 33 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,  2 ,  3 ,  4 ,  5 ,165 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 30 , -1 , 29 , 28 ,  8 , 35 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 31 , 32 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , 56 , -1 , -1 , -1 , -1 ,165 , -1 , -1 , -1 , -1 , -1 , -1 , 26 ,101 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , -1 , -1 , 33 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 ,  0 ,  2 ,  3 ,  4 ,166 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 31 , -1 , 30 , 29 , 28 ,  8 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 32 , 33 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 ,166 , -1 , -1 , -1 , -1 , -1 , -1 ,165 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , 25 ,  0 ,  2 ,  3 ,167 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 32 , -1 , 31 , 30 , 29 , 28 ,  8 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 33 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,167 , -1 , -1 , -1 , -1 , -1 , -1 ,166 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,165 , 26 , 25 ,  0 ,  2 ,168 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 33 , -1 , 32 , 31 , 30 , 29 , 28 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,168 , -1 , -1 , -1 , -1 , -1 , -1 ,167 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,166 ,165 , 26 , 25 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 34 , -1 , 80 , 10 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , 87 , 56 , -1 ,134 , -1 , 29 , -1 , 26 , -1 , -1 , 88 , -1 , 28 , 52 , 77 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , 76 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 ,202 ,123 , 53 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,193 , -1 , 84 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 ,  8 , 35 , -1 , -1 , -1 , 30 , 89 , -1 , -1 ,172 , -1 , -1 , -1 , 93 , -1 , -1 ,171 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , 28 , -1 , 10 , 80 , 34 ,144 , -1 , -1 , 78 , -1 , -1 , 36 , 46 , -1 , -1 ,  2 , -1 , 48 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , 47 , -1 , 37 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 38 , 12 , 15 , 11 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 52 , 77 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 ,181 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , -1 , -1 , 86 ,146 , -1 , -1 , -1 ,148 , -1 , -1 ,151 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 , -1 , -1 , 29 , 30 , 31 , 32 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 ,  5 ,  6 ,  7 , -1 ,  0 ,187 ,160 , -1 , -1 , -1 ,188 ,158 , -1 , -1 , -1 ,106 ,128 , -1 ,173 , -1 , -1 ,116 , -1 , -1 , -1 , -1),
    ( 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , 52 , -1 , 47 , 55 , 56 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , 49 , 50 , 51 , -1 , -1 , -1 , 16 , 90 , 91 , 39 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , 88 ,135 , -1 , 34 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 ,181 , -1 , -1 ,100 , -1 , -1 , -1 , 81 , -1 ,  8 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , 37 ,  0 , 35 ,  2 ,158 , -1 , 41 , 48 , 10 , 11 , -1 ,180 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 37 , -1 , 15 , -1 , 85 , -1 , -1 , -1 , 38 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 ,101 ,153 , 52 ,100 , -1 , -1 , -1 , -1 , 56 , 36 , -1 ,132 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , 83 , -1 , 39 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , 55 , -1 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , 30 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , 57 , 35 ,120 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 ,185 ,  0 , 41 ,192 , -1 , -1 , 43 , 28 , 80 ,162 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 38 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 ,100 ,152 , 55 , 56 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , 39 , -1 , -1 , 37 , -1 , 79 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 ,132 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , 59 , -1 ,118 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , 83 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , 77 , 25 ,  8 ,  0 ,188 , -1 ,185 , 41 , 80 , 78 ,106 , 48 ,129 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , 47 , 38 ,  0 , -1 , 77 , 37 , 87 , 88 ,  3 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 40 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  9 ,  0 ,190 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , 42 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 41 , -1 , 48 ,180 ,181 ,182 ,183 ,184 ,  0 , 40 ,  8 , 10 , 11 , 12 , 13 , 49 , 90 ,127 , -1 , 99 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , -1 , 25 , 26 ,165 ,166 ,167 ,168 , 29 ,  2 , 15 , 79 , 37 , -1 , 42 , 43 , -1 , 44 , 45 ,169 , 36 , 38 , -1 , 50 , 51 , 81 , 77 , -1 , 76 , 52 ,100 ,118 ,119 , 57 ,117 , -1 ,126 , -1 , 65 , -1 , -1 ,129 ,131 , -1 , -1 , -1 , -1 , -1 , 72 , -1 , -1 , 54 , 80 , -1 , 28 , -1 , -1 , -1 ,194 , -1 , 34 , 55 , 87 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 ,101 ,102 , -1 ,104 ,109 , -1 ,162 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , -1 ,120 , -1 ,143 , -1 , -1 ,202 , 60 , -1 , -1 ,140 ,173 , 66 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 30 , -1 ,  1 ,146 ,147 , -1 ,152 , -1 ,153 ,154 , -1 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 ,170 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 ,191 ,188 ,192 , -1 ,  9 , -1 , -1 ,171 ,193 , -1 , -1 ,199 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1),
    ( 42 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 40 , 41 ,  9 ,190 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 43 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , 41 , 42 ,  0 ,  8 , 10 , 11 , 12 , 50 , 91 ,140 , -1 , -1 , -1 , -1 , -1 , -1 ,142 , -1 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , 26 , 48 , 49 , -1 , 79 ,132 , -1 , 44 , -1 , 45 ,169 ,170 , 15 , 37 , -1 , 51 , 81 , -1 , 54 , -1 , -1 , 77 ,101 ,120 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 ,130 , -1 , 73 , 74 , -1 , -1 , -1 , -1 , -1 , 76 , 28 , -1 , 25 , -1 , -1 , -1 ,193 , -1 , 29 , 52 , 55 , -1 , -1 , -1 ,172 , 89 , -1 , -1 , -1 , -1 , 99 , -1 ,102 , -1 , -1 ,109 , -1 , -1 , -1 , -1 , 94 , -1 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 ,198 , -1 ,122 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , 39 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 ,165 , -1 , -1 ,  1 ,146 ,145 ,153 ,155 ,154 , -1 , -1 , -1 , -1 , -1 , -1 ,161 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,192 , -1 , -1 , 40 , -1 , -1 ,186 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,203),
    ( 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 41 ,  0 ,  8 , 10 , 11 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,141 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , 45 , -1 ,169 ,170 , -1 , 49 , 79 , -1 , 81 , -1 , -1 , 76 , -1 , -1 , 54 ,102 ,143 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 72 , -1 , -1 , -1 ,156 , -1 , -1 , 25 , 83 ,185 , -1 , 35 , -1 ,171 , -1 , 26 , 77 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 42 , -1 , -1 ,191 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,204 , -1),
    ( 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , 43 , 41 ,  0 ,  8 , 10 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , 83 , -1 , -1 , -1 ,169 , -1 ,170 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , -1 , -1 ,  2 , -1 ,186 , -1 , -1 , 54 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , 55 ,151 , -1 , 87 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , 15 , 49 , 50 , -1 , -1 , -1 , -1 , 16 , 90 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , 39 , -1 , -1 , -1 , 91 , -1 , -1 , 13 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 , -1 , -1 , 56 , -1 , -1 , -1 , 51 , 81 , 10 ,194 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 ,  8 , -1 , 35 , -1 , -1 ,  0 ,  2 , 11 , 12 , -1 ,  3 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 47 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 56 ,150 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , 38 , -1 , 37 , 79 , -1 , -1 ,135 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , 57 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 83 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , 28 , 10 ,  8 ,187 , -1 , 25 ,  0 , 78 , -1 , -1 ,  2 , 67 , 63 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 48 , -1 ,180 ,181 ,182 ,183 ,184 , -1 ,  2 , -1 , 35 , -1 , -1 , 82 , -1 , -1 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 ,185 , -1 ,  0 , 25 , 26 ,165 ,166 ,167 , 28 ,  3 , -1 , 49 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 ,133 , -1 , -1 , -1 , 37 , -1 , -1 , 38 , 52 , -1 , -1 , -1 ,129 , -1 , -1 ,131 ,126 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , 72 , -1 , -1 , -1 , 79 , 10 , 50 ,  8 , -1 , -1 , -1 , -1 , -1 , 80 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , 54 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , 66 , -1 , -1 , -1 , -1 , -1 , 63 , 67 , 60 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 ,143 , -1 , -1 , -1 , 29 , -1 , -1 , -1 , -1 ,146 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 ,162 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 ,192 ,158 ,196 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,206 , -1),
    ( 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , 36 , 46 , -1 , -1 , -1 , 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 54 , -1 , 37 , 77 ,101 , -1 , -1 , -1 , 52 , -1 , 16 , -1 , -1 , -1 , -1 , 50 , -1 , 51 , 81 , -1 , -1 , -1 , -1 , 91 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , 38 , -1 , -1 , -1 , 10 , -1 , 55 , 39 , -1 , 26 , -1 , -1 ,193 , 34 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 ,  3 , -1 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , 41 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , 48 , -1 , -1 , -1 , 44 , -1 ,  0 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , 15 , 36 , 46 , -1 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , 79 , 54 ,102 , -1 , -1 , -1 , 77 , -1 , 90 , -1 , -1 , -1 , -1 , 51 , -1 , 81 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , 37 , -1 , -1 , -1 ,  8 , -1 , 52 , -1 , 39 , -1 , -1 , -1 ,171 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , 45 , -1 , 41 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , 49 , 15 , 36 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , 54 , -1 , 91 , -1 , -1 , -1 , -1 , 81 , -1 , -1 , -1 , -1 , 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , 79 , -1 , -1 , -1 ,  0 , -1 , 77 ,132 , -1 , -1 , -1 , -1 ,186 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 83 , 45 , -1 , -1 , -1 , -1 ,169 , -1 , 43 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 52 , -1 , 38 , 36 , -1 , -1 , -1 , -1 , 55 , -1 , 87 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , 39 , -1 , -1 , -1 , -1 , 77 , -1 , 54 , 76 , -1 , -1 , -1 , 37 ,132 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , 61 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , 10 ,127 , 48 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , 89 ,129 ,131 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , 85 , -1 , -1 ,101 , 26 , 28 , 25 ,186 , -1 , -1 ,185 , 34 , 86 ,158 , 41 ,117 ,122 , -1 ,118 ,126 , -1 , -1 , -1 , -1 , -1),
    ( 53 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , 87 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 ,100 , 26 , -1 , -1 ,101 , -1 , -1 ,  0 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 54 , -1 , 79 , 49 , -1 , -1 , -1 , -1 , 77 , -1 , 52 , 55 , 87 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , 37 ,132 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 ,100 , -1 , -1 , -1 , 34 , 90 , -1 , 53 , -1 ,166 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , 72 , -1 , -1 , -1 , -1 , -1 , -1 ,154 ,155 , -1 ,151 ,152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 ,127 ,  0 , -1 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , 26 , 29 , -1 , 44 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 55 ,151 , 47 , 46 , -1 , -1 , -1 , -1 , 87 , -1 , 88 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , 77 , 54 , 76 ,135 , -1 , 38 , -1 ,132 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , 71 ,113 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 ,137 , 11 , 17 ,  2 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , 67 , 68 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 ,100 , 29 , 80 , 28 ,171 , -1 , 26 , 25 , 86 , -1 , -1 ,  0 , 60 ,202 ,117 , 57 , 62 , 61 , -1 , -1 , -1 , -1),
    ( 56 ,150 , 55 , 47 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , 53 , -1 , -1 , -1 ,100 , -1 ,101 ,102 , -1 , -1 ,134 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 ,  8 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , 37 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , 78 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , 60 , 63 , -1 , -1 ,111 , -1 , -1 , 38 , 36 , -1 , -1 , -1 , -1 , 30 , 34 , 29 , -1 , -1 ,165 , 26 , -1 , -1 ,187 , 25 , -1 , -1 , -1 , 17 , 64 , -1 , -1 , -1 , -1 , -1),
    ( 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 ,120 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , 55 , -1 , -1 , 67 , -1 , -1 , 37 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 ,119 , -1 , -1 , -1 ,117 ,124 , 87 , -1 , -1 , -1 , 35 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,157 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 ,159 , -1 , -1 , -1 , -1 ,161 , -1 , -1 , -1 ,200 ,  0 ,197 , 41 , 62 , -1 , 60 , -1 , -1 , -1 , -1),
    ( 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , 47 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , 52 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , 64 , -1 , -1 , -1 , 62 , 57 ,  0 ,118 , -1 , -1 , 55 , -1 , -1 , -1 , -1),
    ( 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 ,118 ,120 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 58 , -1 ,119 , -1 , 60 , -1 , 88 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 ,136 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 ,  8 , -1 ,  0 , -1 , -1 ,124 , -1 , -1 , -1 , -1),
    ( 60 , -1 , 67 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , 87 , 61 , -1 , 57 , -1 , 17 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , 77 , -1 , -1 , -1 , -1 , -1 ,118 ,100 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 ,101 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113 , -1 , 80 , -1 , 25 ,173 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 ,202 , -1 ,122 ,  0 ,200 , -1 , -1 , -1 , -1 , -1),
    ( 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , 55 , -1 , 56 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , 63 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 ,202 , -1 , -1 , -1 , 60 ,  0 , -1 , -1 , -1 , -1 , -1),
    ( 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , 57 , 55 , -1 ,  2 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 ,118 , -1 , -1 , -1 , -1 , 41 ,  8 , 59 , -1 , -1 , -1 , -1 , -1 ,133 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,201 ,200 ,196 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1),
    ( 63 , -1 , 68 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , 56 , -1 , -1 , -1 , -1 , -1 , -1 ,202 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , 67 , 47 , -1 , -1 , -1 ,  2 , -1 ,  0 , 41 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , 38 , 66 , -1 , -1 , -1 , -1 , -1 , 48 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 ,174 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 ,121 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 ,162 , -1 , -1 , -1 , -1 , -1),
    ( 64 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , 58 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , 17 , 56 , -1 ,  0 , -1 , -1 ,120 , 57 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 ,127 , -1 , -1 , -1 ,187 ,185 , 28 , -1 , -1 , -1 , -1 ,163 ,118 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,201 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 ,192 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1),
    ( 65 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 ,100 , -1 , 41 , -1 , -1 ,143 ,118 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,201 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,140 , -1 , -1 , -1 ,188 , -1 , 25 , 17 , -1 , -1 , -1 ,200 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , -1 , -1 , -1),
    ( 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , 38 , -1 , -1 , -1 , -1 ,120 ,143 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , 60 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , 55 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,128 , 43 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 ,199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 , -1 ,124 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , 57 ,118 , -1 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , 88 , -1 , -1 , 77 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , 10 , -1 ,  0 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 ,173 , 63 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , 63 ,202 , -1 ,116 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 ,  3 , -1 ,  2 , 48 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 ,180 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 ,174 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 69 , -1 , 64 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 ,140 , 17 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , -1 , -1 , -1 ,171 , -1 , 29 , -1 , -1 , -1 , -1 , -1 ,127 , 43 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 ,196 , -1 , -1 , -1 , -1 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , -1),
    ( 70 , -1 , 71 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,138 , -1 , 24 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 25 , 78 , 10),
    ( 71 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 74 , 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,138 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 ,  0 , 11 , -1),
    ( 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 74 , -1 , -1 , 71 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 ,  0 , 48),
    ( 73 , -1 , 74 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,142 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 28 ,  0),
    ( 74 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 71 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 ,  8 ,  2),
    ( 75 , -1 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,156 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 76 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , 54 , -1 , 77 , 52 , 55 , 87 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 ,101 , -1 , 47 , -1 , 29 , 91 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , 31 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 ,153 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 ,140 , 41 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 77 ,155 , 37 , 15 , -1 , 85 , -1 , -1 , 52 , -1 , 55 , 87 , 88 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , 76 , -1 , -1 , 39 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , 86 , 16 , -1 , -1 ,134 , 31 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,202 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , 74 , -1 , -1 , -1 , -1 , -1 , -1 ,153 , -1 ,151 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , 17 ,  8 ,140 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , 66 ,130 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , -1 , -1 , -1 ,102 , -1 , 25 ,185 ,191 , -1 , -1 , -1 , 29 , 34 ,196 , 43 , -1 , -1 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 78 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , 87 , 88 , -1 , -1 , 80 , -1 , 28 , 25 ,185 , -1 , -1 , 10 , 47 , 38 , 37 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 ,100 , -1 , -1 , 55 , -1 , 79 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 75 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , 84 ,194 , -1 , -1 , -1 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,205 , -1 , -1 , -1),
    ( 79 , -1 , 49 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , 38 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 ,102 ,154 , 77 ,101 , -1 , -1 , -1 , -1 ,100 , 15 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , 83 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , 52 , -1 , -1 , -1 , 80 , -1 , 56 , -1 , -1 ,165 , -1 , -1 , -1 ,144 , -1 , -1 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 ,  2 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , 41 , 43 , -1 , -1 , -1 , 44 , 25 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 80 ,149 , 10 , -1 , -1 , -1 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 ,144 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , 55 , 87 , -1 , -1 , 28 , -1 , 25 ,185 , -1 , -1 , 88 ,  8 , 38 , 37 , 79 , -1 , -1 ,100 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 ,101 , 56 , -1 , 52 , -1 , -1 , 14 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , 63 ,116 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , 29 , -1 ,194 ,193 , -1 , -1 , -1 ,171 , -1 , -1 , -1 ,187 , -1 , -1 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 81 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , -1 , 50 , 49 , 15 , 36 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 83 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , 54 , -1 ,132 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,169 , -1 , -1 , -1 , -1 ,170 , -1 , 44 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 82 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , -1 , 13 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , 14 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 83 , -1 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 37 , 38 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , 76 , -1 , 15 , -1 ,185 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 45 ,169 , -1 , -1 , -1 ,170 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , 78 , -1 , -1 , -1 ,194 , -1 ,193 ,171 ,186 , 13 , -1 , -1 , 10 ,  8 ,  0 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , 86 , -1 , 80 , -1 , 41 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , 36 , 38 , 52 ,100 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,183 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,182 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , 77 ,101 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 ,  4 ,181 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 86 , -1 , 78 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , 34 , -1 , 29 , 26 , -1 , -1 , -1 , 80 , 55 , 52 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , 54 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,194 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , 55 , -1 , 52 , 77 , 54 , -1 , -1 , 47 , 39 , -1 ,132 ,134 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , 12 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , 86 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , 56 , 34 , 78 , 80 ,193 , -1 , 29 , 28 , -1 , -1 ,160 ,  8 ,124 ,123 , 60 , 59 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , 55 , 52 , 77 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 ,134 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , 13 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , -1 , 78 ,194 , -1 , 34 , 80 , -1 , -1 , -1 , 10 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 89 , -1 , -1 ,193 , -1 ,160 , -1 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , 29 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , 30 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , 26 , -1 , -1 , -1 , -1 ,166 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 31 , -1 ,165 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , 77 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 32 ,167 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,172 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , 39 , -1 , -1 , 77 , -1 , -1 ,  8 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , 51 , -1 , 15 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 90 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , 54 , -1 , -1 ,  0 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , 81 , -1 , 49 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,194 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 ,172 , -1 , -1 , -1 , -1 , -1 ,193 ,171 ,186 , 93 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 93 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , 34 , 29 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 31 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , 55 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,194 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 19 , 20 , 21 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,175 , 15 , -1 , -1 ,  8 , 41 ,104 ,109 , -1 , -1 , -1 ,162 , -1 ,106 , -1 , -1 , -1 , -1 , -1 ,115 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,176 ,177 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , 39 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 99 , -1 , -1 , -1 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , 87 , 52 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 97 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , 86 , 29 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , 99 , -1 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , 87 , 86 , -1 , 20 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , 11 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , 52 , 29 , 20 , -1 , -1 , -1 , -1 ,100 ,101 , -1 ,105 , -1 ,  8 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (100 ,152 , 52 , 38 , 36 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , 53 , -1 , -1 ,101 , -1 ,102 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 99 ,  0 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , 80 , -1 , 41 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 30 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , 15 , -1 , 85 , -1 , -1 ,165 , 29 , 26 , -1 , -1 , -1 , -1 ,144 , -1 ,188 ,185 , -1 , -1 , -1 ,127 , 65 , -1 , -1 , -1 , -1 , -1),
    (101 ,153 , 77 , 37 , 15 , -1 , 85 , -1 ,100 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,112 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , 53 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , 32 , -1 , -1 , -1 , -1 ,109 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , 99 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , 28 , -1 , 43 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,165 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 49 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , 30 ,144 ,192 , -1 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1),
    (102 ,154 , 54 , 79 , 49 , -1 , -1 , -1 ,101 , -1 ,100 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 ,144 , -1 , -1 , -1 , -1 ,167 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 ,152 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , 44 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,165 , 30 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (103 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 ,109 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,111 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 ,109 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 ,101 , -1 , -1 , -1 , -1 , -1 , 41 , 94 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 ,  2 ,187 , -1 , -1 , 99 , -1 , -1 ,  0 , 41 , -1 , -1 , -1 , -1 , 43 , -1 ,176 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,181 , -1 ,163 , -1 ,107 , -1 , -1 , -1 , -1 , -1 ,158 ,188 , -1 , -1 ,187 ,171 , -1 , -1 , -1 , -1 , -1 ,  4 ,180 ,  3 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , 38 , -1 , 35 ,  8 , -1 , -1 , -1 ,128 ,116 , -1 , -1 , -1 ,201 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 ,133 ,160 , -1 , -1 , -1 , -1 ,183 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,105 ,  0 , 41 , 43 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,193 , -1 , -1 , -1 , -1 , -1 ,146 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 , -1 ,195 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , 35 , -1 , -1 , -1 , 19 , 99 , -1 ,  8 ,  0 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , 11 ,  8 , -1 ,103 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (109 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 ,102 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (110 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (111 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,176 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,177 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (112 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (113 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,139 , -1 , -1 , -1 ,157 , -1 , -1 , -1 , -1 , -1 , -1),
    (114 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 ,  8 ,  0 , -1 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , 47 ,129 , -1 , -1 , -1 , -1 , -1 ,  2 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,202 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 ,106 , -1 , -1 , -1 , -1 , -1),
    (117 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , 60 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , 55 , -1 , -1 ,118 , -1 ,127 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , 54 , -1 , -1 , -1 , 61 , -1 ,120 ,101 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , -1 , -1 ,102 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , 28 , -1 ,185 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,199 ,122 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1),
    (118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , 58 , 52 , -1 , -1 ,129 , -1 , -1 , 79 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , 77 , -1 , -1 , -1 , -1 , -1 , 60 , 55 , 56 , -1 , -1 ,  2 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , 65 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 ,161 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , 41 ,199 , 43 ,126 , -1 ,117 , -1 , -1 , -1 , -1),
    (119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 ,  8 , 77 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , 64 , -1 , -1 , -1 , 65 , -1 , -1 , -1 ,126 ,118 , 41 ,120 , -1 , -1 , 52 , -1 , -1 , -1 , -1),
    (120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , 57 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , 77 , -1 , -1 , 66 , -1 , -1 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , 54 , -1 , -1 , -1 ,197 , -1 ,117 , 52 ,100 , -1 , -1 , 48 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 ,163 , -1 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , 43 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 ,116 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , -1 ,131 ,130 , -1 ,123 , 61 ,122 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 ,187 ,188 , -1 , -1 , -1 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,202 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 ,197 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 , -1 , -1 , -1 , -1 ,174 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,195 , -1 , -1 , -1 , -1 , -1),
    (122 , -1 , -1 ,131 , -1 , -1 , -1 , -1 ,202 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , 52 , 60 , -1 , -1 , 41 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 ,121 , -1 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , -1 , -1),
    (123 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,202 , -1 ,122 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 ,124 , 87 , -1 , -1 , -1 ,  8 , -1 , 28 , 25 , -1 , -1 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , 55 ,117 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 , -1 , -1 , -1),
    (124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 ,117 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , 88 , -1 , -1 , 59 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , 55 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , 57 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , -1 ,100 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , -1 , 28 ,128 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 ,202 ,  8 ,163 , -1 , -1 , -1 , -1 , -1),
    (125 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 , 61 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , -1 , 29 , -1 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1),
    (126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , 64 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 ,118 , 52 , -1 , 48 , -1 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 ,120 , -1 , -1 , -1 ,158 , 43 ,  0 , 57 , 17 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,201 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1),
    (127 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 ,117 , -1 , -1 , 54 , 52 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 ,  0 , 77 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 , -1 ,159 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1),
    (128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , 66 , -1 ,124 , 35 , -1 , -1 ,116 , -1 , -1 , -1 ,163 ,200 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 ,  2 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1),
    (129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , 60 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , 47 , -1 , -1 , -1 , -1 ,118 ,120 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , 79 , -1 , -1 , -1 , -1 , 61 , -1 , 77 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , 87 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 ,  8 , -1 , 41 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1),
    (130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1 ,202 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , 63 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , 63 ,202 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 ,180 , -1 , 48 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,174 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (132 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 90 , -1 , -1 , -1 , -1 , -1 , 54 , 37 , 79 , 43 , -1 , 76 , -1 , 52 , 55 ,133 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 48 , 41 ,185 , -1 , -1 , -1 ,  0 ,181 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , 49 ,132 , 51 , 15 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 81 , 50 , 35 , -1 ,  2 , -1 , -1 , -1 ,160 , -1 ,  8 , 36 , 46 ,186 , -1 , -1 , -1 ,193 , -1 , -1 , -1 , 94 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,174 , -1 ,131 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , -1 , 39 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1),
    (134 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , 56 , -1 , -1 , 10 , 55 , -1 , 61 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1),
    (135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , 10 , -1 , 55 , 47 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (136 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 ,118 ,120 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , 25 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , -1 , 69 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , 28 ,197 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 ,127 ,140 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , 11 , 87 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 ,159 , 80 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 72 , 71 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 74 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 ,196 ,160 , -1),
    (139 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113 , -1 ,157 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (140 , -1 ,120 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , 17 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , 76 , 77 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 ,102 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , 41 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (141 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,156 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (142 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 24 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,164),
    (143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 ,118 , 57 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 ,127 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , 76 , -1 , -1 , -1 ,199 , -1 , -1 , 77 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (144 , -1 , 34 , 80 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , 30 , -1 ,165 , -1 , -1 , -1 , -1 , 29 ,100 ,101 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 ,  8 , 35 , -1 , -1 , 31 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (145 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 ,152 , -1 ,154 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (146 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,147 , -1 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 ,152 ,153 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (147 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 ,152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,147 , -1 ,146 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (149 , -1 ,147 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,148 , -1 ,151 , -1 , -1 , -1 , -1 , -1 ,145 , -1 , -1 , -1 , -1 ,146 , -1 , -1 , -1 , -1 , -1 ,152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (150 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 , -1 ,153 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 ,145 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 , -1 ,148 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 ,152 , -1 ,149 , -1 , -1 , -1 , 27 ,145 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 , -1 ,153 , -1 ,154 , -1 , -1 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 , -1 ,149 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (153 , -1 ,155 , -1 , -1 , -1 , -1 , -1 ,152 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 , -1 ,152 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 , -1 , -1 ,152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 ,154 , -1 ,145 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (156 , -1 ,141 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (157 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,139 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (158 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 ,186 , -1 ,187 ,171 , -1 , -1 , -1 , -1 ,193 , -1 ,  3 , 48 ,  2 , 36 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , 35 ,162 ,133 , -1 , -1 ,  0 , 52 , 43 ,  8 , 28 ,163 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,182 ,194 , 10 , 11 ,172 , -1 , -1 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , 25 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 ,200 , 62 , -1 , -1 ,198 ,121 , -1 , -1 ,201 ,161 , -1 ,173 , -1 ,174 , 49 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 ,145 , -1 , -1 , -1 , -1 , -1 ,195 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,192 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , 59 , -1 , -1 , -1 , -1 ,161 , -1 , -1 , -1 , -1 ,163 , -1 , -1 , -1 , -1 , -1 ,127 ,137 , -1 , -1 , -1 , -1 , 80 , -1 , -1 , -1 , -1 , -1 ,  0 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , 17 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , -1 , 64 , -1 , -1 , -1 , 78 , 86 , -1 , -1 ,160 ,  8 ,173 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 ,188 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,193 , -1 , -1 ,194 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 ,158 ,196 , -1 , -1 , -1 , -1 ,  3 ,180 ,133 , 10 , 87 ,  0 , 11 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 ,138 , -1 , -1 , -1 , 41 ,  8 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , 13 , 92 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , 28 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 ,121 , -1 , -1 , -1 , -1 ,159 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,148 ,149 , -1 ,145 ,146 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (161 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 ,120 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , 17 , -1 , 64 , -1 , -1 , 25 , -1 , -1 ,197 , -1 , -1 , 43 ,  0 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 ,143 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , 65 , -1 , -1 , -1 , -1 , -1 , 28 , 29 , -1 , -1 ,158 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,192 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , 64 ,105 , -1 , -1 , -1 , -1 , -1 ,196 ,192 , -1 ,158 ,188 ,186 , -1 , -1 , -1 ,187 , -1 ,181 ,133 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 ,  3 , -1 , -1 , -1 , -1 , 48 , 37 , -1 ,  2 ,  0 , -1 , -1 , -1 ,173 , 63 , -1 ,174 ,201 , -1 , -1 , -1 , -1 , -1 ,138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,107 , -1 , 41 , 43 , 44 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,177 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,195 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,159 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 ,120 , 59 , -1 , -1 , -1 , -1 ,  8 ,124 , -1 ,128 , -1 , -1 , 48 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 ,127 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 62 , -1 ,126 , -1 ,197 , -1 , 10 , 80 , -1 , 64 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (164 ,  0 , -1 ,179 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 24 , -1 , -1 ,142 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 ,  8 , 10 , 11 , 80 , 56 , 55 ,100 ,101 ,102 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,203 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (165 , -1 , 26 , 25 ,  0 ,  2 ,  3 ,  4 , 30 , -1 ,144 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,166 ,167 , -1 , 31 , 32 , 33 , -1 , -1 , -1 , -1 , 29 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 ,168 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , 41 , 48 ,180 ,181 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (166 , -1 ,165 , 26 , 25 ,  0 ,  2 ,  3 , 31 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,167 ,168 , -1 , 32 , 33 , -1 , -1 , -1 , -1 , -1 , 30 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , 41 , 48 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (167 , -1 ,166 ,165 , 26 , 25 ,  0 ,  2 , 32 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,168 , -1 , -1 , 33 , -1 , -1 , -1 , -1 , -1 , -1 , 31 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , 41 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (168 , -1 ,167 ,166 ,165 , 26 , 25 ,  0 , 33 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 32 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (169 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 45 , -1 , 44 , 43 , 41 ,  0 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 81 , -1 , 83 , -1 , -1 ,170 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 ,191 , -1 , -1 , 76 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (170 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,169 , -1 , 45 , 44 , 43 , 41 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 81 , 83 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (171 , -1 ,187 , -1 , -1 , -1 , -1 , -1 ,193 , -1 ,194 , 84 , -1 , -1 , -1 ,  0 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , 25 , 28 , 55 , -1 ,186 , -1 ,191 , -1 , -1 , 10 , 80 ,188 , 41 , 43 , 44 , 29 , -1 , -1 , 34 ,144 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 ,185 , -1 , 45 , -1 , -1 , -1 ,  3 , 93 , 86 , -1 , -1 , 49 , 50 , -1 , -1 , -1 , 19 , 97 , -1 , -1 , -1 , 30 ,165 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , 77 ,196 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,172 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , -1 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (172 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , -1 , -1 , -1 , -1 ,171 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,193 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 ,194 , -1 , -1 ,186 ,191 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , -1 , 41 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 17 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , 67 , 60 ,  2 , -1 , 35 , 63 , -1 , -1 , -1 ,200 , -1 ,130 , 68 , -1 ,161 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 ,116 ,123 , -1 , 41 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , 10 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,174 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1),
    (174 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , 68 , 63 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (175 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 ,  0 , 19 , 20 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,176 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,177 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (176 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,175 , 94 ,  0 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,177 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,111 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (177 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,176 ,175 , 94 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,111 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (178 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,203 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (179 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,164 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , 47 , 46 , 38 , 37 , 79 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (180 , -1 ,181 ,182 ,183 ,184 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , 41 , -1 ,  2 ,  0 , 25 , 26 ,165 ,166 ,  8 ,  4 , 85 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , 50 , 36 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , 49 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , 10 , 46 , -1 ,171 , -1 , -1 , -1 ,194 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , 68 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , 90 , -1 , -1 , -1 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 ,106 ,162 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1),
    (181 , -1 ,182 ,183 ,184 , -1 , -1 , -1 ,  4 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , 48 , -1 ,  3 ,  2 ,  0 , 25 , 26 ,165 , 35 ,  5 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , 49 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 ,185 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (182 , -1 ,183 ,184 , -1 , -1 , -1 , -1 ,  5 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,181 ,180 , -1 ,  4 ,  3 ,  2 ,  0 , 25 , 26 , -1 ,  6 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , 41 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (183 , -1 ,184 , -1 , -1 , -1 , -1 , -1 ,  6 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,182 ,181 , -1 ,  5 ,  4 ,  3 ,  2 ,  0 , 25 , -1 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , 48 , 41 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (184 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,183 ,182 , -1 ,  6 ,  5 ,  4 ,  3 ,  2 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,181 ,180 , 48 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (185 , -1 , 41 , 48 ,180 ,181 ,182 ,183 , 25 , -1 , 28 , 80 , 78 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 ,165 ,166 ,167 ,168 , -1 , 30 ,  0 , 37 , 54 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , 52 , 43 , -1 , -1 , 83 ,101 , -1 , -1 ,100 , -1 ,127 , -1 , 17 , -1 , -1 , 65 ,122 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 , 34 , 76 , 29 , -1 , 11 , -1 , -1 , -1 ,144 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,202 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 31 , -1 ,145 , -1 ,149 , -1 , -1 ,152 , -1 , -1 , -1 ,154 , -1 , -1 ,192 , -1 ,187 , -1 , -1 ,161 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 ,186 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (186 , -1 ,188 ,158 ,106 , -1 , -1 , -1 ,171 , -1 ,193 ,194 , 84 , -1 , -1 , 41 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 ,187 ,  0 ,185 , 25 , 52 , -1 ,191 , -1 , -1 , -1 , -1 ,  8 , 28 ,192 , 43 , 44 , 45 , 26 , -1 , -1 , 29 , 30 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,169 , -1 , -1 , 92 ,180 , -1 , 34 , 86 , -1 , 50 , 51 , -1 , -1 , -1 , 99 , -1 , -1 , -1 , -1 ,165 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , 54 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,172 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , -1 , -1 ,193 , -1 , 89 , -1 , -1 , -1 , -1 ,160 , 35 ,  0 ,  8 , 47 , -1 ,188 , -1 ,192 , -1 , -1 , -1 , 10 ,158 , 48 , -1 , -1 , 28 , 56 ,185 , 80 , 34 ,159 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , 84 , 41 ,194 , -1 , -1 , 45 , -1 ,  4 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , 26 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 , -1 , 27 , -1 ,145 , -1 , -1 , -1 , -1 , -1 , -1 ,195 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (188 , -1 ,158 ,106 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , -1 , -1 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , 41 ,  0 , 38 , -1 ,192 , -1 , -1 , -1 , -1 , 35 ,  8 ,196 , -1 , -1 , -1 , 25 ,100 , -1 , 28 , 29 , -1 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 ,194 , 43 ,193 , -1 , -1 ,169 , -1 ,181 , -1 , 80 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 ,195 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 ,161 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 ,191 , -1 , -1 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (189 , -1 , -1 ,195 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,172 , -1 ,158 ,192 ,188 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 ,186 , 26 , -1 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,193 ,194 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 34 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (190 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 ,  9 ,  0 , 40 , 42 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (191 , -1 ,192 ,196 ,162 , -1 , -1 , -1 ,186 , -1 ,171 ,193 ,194 , 84 , -1 , 43 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 , 41 , -1 ,185 , 77 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 25 , -1 , 44 , 45 ,169 , -1 , -1 , -1 , 26 ,165 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,170 , -1 , -1 , -1 ,133 , 89 , 29 , 34 , -1 , 51 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,172 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (192 , -1 ,196 ,162 , -1 , -1 , -1 , -1 ,188 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , 48 , 43 , 41 , 37 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 ,  0 , -1 , -1 , -1 , -1 ,185 ,101 , -1 , 25 , 26 ,161 , 64 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,193 , 44 ,171 , -1 , -1 ,170 , -1 , -1 , -1 , 28 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , 56 , 47 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 ,145 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (193 , -1 , -1 ,160 , -1 , -1 , -1 , -1 ,194 , -1 , 84 , -1 , -1 , -1 , -1 ,  8 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , 10 , 28 , 80 , 87 , -1 ,171 , -1 ,186 ,191 , -1 , 11 , 78 ,187 ,  0 , 41 , 43 , 34 , -1 , 26 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , 25 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , 49 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 ,144 , 30 ,165 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , 52 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,172 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (194 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , 80 , 78 , 88 , -1 ,193 , -1 ,171 ,186 ,191 , 12 , -1 , -1 ,  8 ,  0 , 41 , 86 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , 34 , -1 , 28 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , 30 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,172 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (195 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 ,106 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 ,  0 , -1 , -1 ,187 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 ,192 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (196 , -1 ,162 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 ,160 , -1 , -1 , -1 ,133 , -1 ,161 , 69 , -1 , -1 , -1 , -1 , -1 , -1 ,192 ,191 , -1 ,188 ,186 , -1 , -1 , -1 , -1 ,171 ,106 ,180 , -1 , 48 , 15 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 ,  2 , -1 , -1 , -1 , -1 , 41 , 77 , 44 ,  0 , 25 ,200 , 62 ,163 ,197 ,202 ,201 , -1 , -1 , -1 , -1 ,173 ,174 , -1 , -1 ,138 , -1 , -1 , -1 , -1 , 45 , 43 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 ,193 ,  8 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,139 , -1 , -1 , -1 ,199 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , 55 , 46 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1),
    (197 , -1 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , 66 ,129 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , 60 , -1 ,  0 , 57 ,  8 ,202 , -1 ,200 , -1 ,161 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , 41 ,118 , 43 , -1 , -1 , -1 ,123 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , 80 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,139 , -1 ,187 , -1 ,192 , -1 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1),
    (198 , -1 , -1 ,174 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , 63 , -1 , -1 , -1 , -1 ,122 , -1 , -1 ,202 , -1 ,197 ,  0 , -1 , -1 , -1 ,196 , -1 ,192 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,199 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , 41 ,118 ,  0 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 ,120 , 44 , -1 , -1 , -1 ,202 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , 28 , -1 , -1 , -1 , -1 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 ,143 , 57 , 17 , 62 , -1 , -1 ,  0 , 60 , -1 ,173 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,157 , -1 , -1 ,128 , 41 ,126 , -1 , -1 , -1 ,199 , -1 ,  8 , 28 , -1 , 65 ,106 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 , -1 ,201 , -1 ,197 , -1 , -1 , -1 , -1),
    (201 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , -1 , -1 , 62 , 64 , -1 , -1 , -1 ,200 ,  0 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 ,195 , -1 ,158 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1),
    (202 , -1 , 63 , 68 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , 60 , 55 ,124 , -1 , -1 ,  0 , -1 , 25 ,185 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 ,197 ,196 , -1 , -1 , -1 , -1 , -1),
    (203 ,178 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,206 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,164 ,204 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,  2 , -1 , 43 , -1 , -1 , -1 , -1 ,205 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (204 , -1 ,203 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,205 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 ,  0 , 44 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (205 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,204 , -1 , -1 , -1 ,206 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , 11 ,  0 , 28 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (206 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,205 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,203 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , 48 ,  0 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1)
  );

  { Div Table }

  DivTable : array[0..206, 0..206] of longint = (
    (  0 ,164 , 25 , 26 ,165 ,166 ,167 ,168 , 41 , 40 , 43 , 44 , 45 ,169 ,170 ,171 ,172 ,173 ,174 , 94 ,175 ,176 ,177 ,139 ,178 ,  2 ,  3 ,179 , 48 ,180 ,181 ,182 ,183 ,184 ,133 ,185 ,186 ,187 ,188 ,189 ,  9 ,  8 ,190 , 10 , 11 , 12 ,191 ,192 , 28 ,193 ,194 , 84 ,158 ,195 ,160 ,196 ,162 ,197 ,198 ,199 ,200 ,201 ,202 , 64 , 63 ,116 ,159 ,161 , 69 , 68 ,203 ,204 ,205 ,206 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , 91 , -1 , 19 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 ,105 ,107 ,103 ,100 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 ,163 , -1 , -1 , -1 , -1 , -1 ,126 , -1 , -1 ,123 ,128 ,127 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , 66 , 54 , 67 , 56 ,117 ,  1 ,  4 ,  5 ,  6 ,  7 , 13 , 14 , 15 , 16 , 17 , 18 , 20 , 21 , 22 , 24 , 27 , 29 , 30 , 31 , 32 , 33 , 35 , 36 , 37 , 38 , 39 , 42 , 46 , 47 , 49 , 50 , 53 , 55 , 57 , 58 , 59 , 60 , 61 , 62 , 70 , 71 , 72 , 73),
    (  1 ,  0 ,145 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 , -1 ,147 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,178 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , 41 , 43 , 44 , -1 ,162 ,196 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  2 , -1 ,  0 , 25 , 26 ,165 ,166 ,167 , 48 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 ,  4 , -1 ,180 ,181 ,182 ,183 ,184 , -1 , -1 , 41 ,188 , -1 ,158 , -1 , -1 , 35 , -1 , -1 , -1 , 82 ,192 ,196 ,  8 , -1 , -1 , -1 ,106 , -1 , -1 ,162 , -1 ,173 , -1 , -1 , -1 , -1 , 63 , 62 , 68 , -1 , -1 ,200 , 64 , -1 , -1 ,203 , -1 , -1 ,206 , -1 , -1 , -1 , -1 ,160 ,133 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 ,118 ,163 , -1 , -1 , -1 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,179 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , 79 , -1 , 55 ,129 , -1 ,  5 ,  6 ,  7 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 ,145 , 28 , 29 , 30 , 31 , 32 , -1 , -1 , 15 , 36 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , 67 , -1 , -1 , 71 , -1 , -1 , 74),
    (  3 ,179 ,  2 ,  0 , 25 , 26 ,165 ,166 ,180 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 ,  5 , -1 ,181 ,182 ,183 ,184 , -1 , -1 , -1 , 48 ,158 , -1 ,106 ,195 , -1 , -1 , -1 , -1 , -1 , -1 ,196 ,162 , 35 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,174 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , 49 , -1 , 47 , -1 , -1 ,  6 ,  7 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , 58 , -1 , -1 , -1 , -1 ,  1 ,  8 , 28 , 29 , 30 , 31 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  4 , -1 ,  3 ,  2 ,  0 , 25 , 26 ,165 ,181 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  5 ,  6 , -1 ,182 ,183 ,184 , -1 , -1 , -1 , -1 ,180 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 ,  8 , 28 , 29 , 30 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  5 , -1 ,  4 ,  3 ,  2 ,  0 , 25 , 26 ,182 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  6 ,  7 , -1 ,183 ,184 , -1 , -1 , -1 , -1 , -1 ,181 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 ,  8 , 28 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  6 , -1 ,  5 ,  4 ,  3 ,  2 ,  0 , 25 ,183 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  7 , -1 , -1 ,184 , -1 , -1 , -1 , -1 , -1 , -1 ,182 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 ,  8 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  7 , -1 ,  6 ,  5 ,  4 ,  3 ,  2 ,  0 ,184 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,183 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  8 , -1 , 28 , 29 , 30 , 31 , 32 , 33 ,  0 ,  9 , 41 , 43 , 44 , 45 ,169 ,193 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 ,  2 ,  3 ,  4 ,  5 ,  6 ,  7 ,180 , 25 ,171 , -1 ,187 , -1 ,190 , 10 , -1 , 11 , 12 , 13 ,186 ,188 , 80 ,194 , 84 , -1 , -1 , -1 , -1 ,158 ,106 , -1 , -1 ,197 ,163 , -1 ,123 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,205 , -1 , -1 ,160 , -1 , -1 , 48 , -1 , -1 , -1 , 50 , 89 ,133 ,196 , -1 , 85 , 92 , -1 , 90 , -1 , 98 , -1 , -1 , -1 , 94 ,108 , -1 , -1 , -1 ,107 , -1 , -1 , 56 ,103 , 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 ,121 , -1 ,119 , -1 , 62 ,200 , -1 , -1 , -1 , 17 ,159 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,181 , -1 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 ,129 , 77 , -1 , -1 , 60 ,146 , -1 , -1 , -1 , -1 , 14 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 ,144 , -1 , -1 , -1 , -1 , 46 , 38 , 47 , -1 , 40 , -1 , -1 , 15 , 49 , -1 , 87 , 59 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , 74 , -1),
    (  9 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 40 ,  0 , 42 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 ,190 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 10 , -1 , 80 , 34 ,144 , -1 , -1 , -1 ,  8 ,190 ,  0 , 41 , 43 , 44 , 45 ,194 , 92 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 ,  3 , 28 ,193 , -1 , -1 , -1 , -1 , 11 , -1 , 12 , 13 , 14 ,171 ,187 , 78 , 84 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,159 , -1 , -1 ,206 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 ,  2 , -1 , -1 , -1 , 49 , -1 ,180 ,158 ,196 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 ,177 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,195 ,189 , -1 ,173 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 , -1 , -1 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , 67 , 52 , -1 , -1 ,124 ,147 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 ,137 , -1 , -1 , -1 ,110 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 ,135 ,  9 , -1 , -1 , 36 , 15 ,134 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70),
    ( 11 , -1 , 78 , 86 , -1 , -1 , -1 , -1 , 10 , -1 ,  8 ,  0 , 41 , 43 , 44 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 ,194 , -1 , -1 , -1 , -1 , 12 , -1 , 13 , 14 , -1 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,205 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , 35 , -1 ,185 , -1 , 15 , 93 ,  3 , -1 ,158 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , 55 , -1 , -1 , -1 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 ,190 , -1 , -1 , 46 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 71 , -1),
    ( 12 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , 10 ,  8 ,  0 , 41 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , 84 , -1 , -1 , -1 , -1 , 13 , -1 , 14 , -1 , -1 ,194 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , 25 , -1 , 36 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 13 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , 11 , 10 ,  8 ,  0 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 14 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , 46 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 14 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 13 , -1 , 12 , 11 , 10 ,  8 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 15 , -1 , 37 , 77 ,101 , -1 , -1 , -1 , 49 , -1 , 50 , 51 , 81 , -1 , -1 ,  0 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 41 ,  2 , 48 ,196 , -1 , 36 , -1 , 46 , -1 , -1 , 43 , -1 , 38 ,  8 , 10 , 11 ,180 , -1 , -1 ,133 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , 35 , -1 , 12 , 83 , 82 , -1 , 26 , -1 , -1 , -1 , -1 ,193 ,194 , -1 , -1 , 95 , 94 , -1 , -1 , -1 , -1 ,181 ,  4 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 ,119 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,179 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , 52 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 90 , 91 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 16 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , 90 , -1 , 91 , -1 , -1 , -1 , -1 , 15 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , 36 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 ,  8 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 ,200 , 25 , -1 ,185 , 64 , -1 , -1 , -1 , 60 ,124 , -1 , 69 , -1 , 67 , -1 , -1 , -1 , -1 , -1 ,157 , -1 ,159 ,143 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , 80 , -1 , -1 , -1 , 65 ,126 ,125 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , 43 , -1 , -1 , 10 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 75 , -1 , 77 , -1 , 55 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , 64 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 94 ,175 ,176 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 20 ,171 , -1 , -1 , 41 ,  8 ,107 , -1 , -1 , -1 , -1 , 56 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 ,139 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,114 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , 21 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 20 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 ,  0 , 94 ,175 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 21 , -1 , -1 , -1 , 99 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 21 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 20 , 19 ,  0 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 21 , 20 , 19 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,110 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 23 , -1 , 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,141 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,114 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 24 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,142 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 25 , -1 , 26 ,165 ,166 ,167 ,168 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,  2 , -1 , 41 , 48 ,180 ,181 ,182 ,183 , -1 , -1 , -1 ,171 ,186 , -1 , -1 , 28 , -1 , 80 , 78 , -1 , -1 ,191 , 29 , -1 , -1 , -1 ,188 , -1 , -1 ,192 ,196 , -1 , -1 , -1 ,161 , -1 , -1 , 69 ,202 ,123 ,136 , -1 , -1 , 63 ,204 , -1 , -1 , -1 , -1 ,139 , -1 ,187 , 44 ,193 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , 66 , -1 , -1 , 75 , -1 , -1 , -1 , -1 ,133 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 ,102 , 60 , -1 , -1 ,145 ,  3 ,  4 ,  5 ,  6 , -1 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 30 , 31 , 32 , 33 , -1 ,  8 , 38 , 77 , 52 , -1 , -1 , 47 , 55 , 79 , -1 , -1 , 56 , 17 , -1 , -1 , -1 , -1 , 64 , -1 , 70 , -1 , -1),
    ( 26 , -1 ,165 ,166 ,167 ,168 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , -1 , -1 , 25 ,  0 ,164 ,185 , 41 , 48 ,180 ,181 ,182 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , 34 , 86 , -1 , -1 , -1 , 30 , 89 , -1 , 93 ,186 ,189 ,193 ,191 ,192 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,202 , -1 , -1 , -1 , -1 , -1 , -1 ,194 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , 49 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 ,188 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,172 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 ,  2 ,  3 ,  4 ,  5 , -1 , -1 , 77 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 31 , 32 , 33 , -1 , -1 , 28 , 52 ,101 ,100 , 53 , -1 , 55 , 56 , 54 , 76 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1),
    ( 27 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 ,  1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 ,192 ,191 ,188 ,187 , -1 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 ,152 , -1 , -1 ,151 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 28 , -1 , 29 , 30 , 31 , 32 , 33 , -1 , 25 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , 35 , -1 ,  0 ,  2 ,  3 ,  4 ,  5 ,  6 , 48 , 26 , -1 ,193 ,171 , -1 , -1 , 80 , -1 , 78 , -1 , -1 , -1 ,186 , 34 , -1 , -1 , -1 ,187 , -1 , -1 ,188 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 ,205 , -1 , -1 , -1 , -1 , 43 ,194 , 41 , -1 , -1 , -1 , -1 , -1 , -1 ,192 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 ,159 , -1 , -1 , -1 , -1 , -1 , 64 ,161 ,200 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 ,129 ,199 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 ,117 ,101 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , 10 , 47 , 52 , 55 , -1 , -1 , -1 , 87 , 37 , 79 , -1 , -1 , -1 , -1 ,137 ,125 , -1 , -1 , -1 , -1 , 73 , -1),
    ( 29 , -1 , 30 , 31 , 32 , 33 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 ,  8 , -1 , 25 ,  0 ,  2 ,  3 ,  4 ,  5 , 41 ,165 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , 86 , -1 , -1 , -1 , -1 ,144 , -1 , 93 , -1 ,171 , -1 ,194 ,186 ,188 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , 84 ,193 , -1 , -1 ,185 , -1 , -1 , -1 , 76 , -1 , 43 ,191 , -1 , 15 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , 99 , -1 , 97 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , 69 , -1 ,161 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , 55 ,100 , 56 , -1 , -1 , 87 , -1 , 77 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 30 , -1 , 31 , 32 , 33 , -1 , -1 , -1 ,165 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , 28 , -1 , 26 , 25 ,  0 ,  2 ,  3 ,  4 ,185 ,166 , -1 , 89 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 ,193 ,194 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , 35 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , 56 , -1 , -1 , -1 , -1 , -1 , -1 ,101 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 31 , -1 , 32 , 33 , -1 , -1 , -1 , -1 ,166 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 30 , 29 , -1 ,165 , 26 , 25 ,  0 ,  2 ,  3 , -1 ,167 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 ,  8 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 32 , -1 , 33 , -1 , -1 , -1 , -1 , -1 ,167 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 31 , 30 , -1 ,166 ,165 , 26 , 25 ,  0 ,  2 , -1 ,168 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , 28 ,  8 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 33 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,168 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 32 , 31 , -1 ,167 ,166 ,165 , 26 , 25 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 30 , 29 , 28 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 34 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , 97 , -1 , -1 , -1 , -1 , -1 , 80 , 10 , -1 , 28 ,  8 , 35 , -1 , -1 , -1 ,  0 , 30 , 89 , -1 , -1 ,172 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , -1 ,193 , -1 , 84 ,171 ,187 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,194 ,185 , -1 , 25 , -1 , -1 , -1 , 54 , -1 , 41 ,186 ,191 , 36 , -1 , -1 ,132 , 49 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , -1 ,189 , -1 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , 87 , 56 , -1 ,134 , -1 , 88 , -1 , 52 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 35 , -1 ,  8 , 28 , 29 , 30 , 31 , 32 ,  2 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 ,  4 ,  5 ,  6 ,  7 , -1 ,181 ,  0 ,187 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 ,188 ,158 , 10 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 ,128 , -1 ,173 , -1 , -1 ,116 , -1 , -1 , -1 , -1 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 ,180 , -1 , 44 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,182 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , 37 , -1 , 87 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , 34 ,144 , -1 , -1 , -1 , -1 , 36 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 36 , -1 , 38 , 52 ,100 , -1 , -1 , -1 , 15 , -1 , 49 , 50 , 51 , 81 , -1 ,  8 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , 37 ,  0 , 35 ,  2 ,158 , -1 , 46 , -1 , -1 , -1 , -1 , 41 , 48 , 47 , 10 , 11 , 12 ,  3 , -1 , -1 ,180 ,181 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 13 , -1 , -1 , 91 , 29 , -1 ,133 , -1 , -1 ,194 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 ,160 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 16 , 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 37 , -1 , 77 ,101 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , 83 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , 54 ,185 ,  0 , 41 ,192 , -1 , 38 , -1 , 47 , -1 , -1 , -1 , 43 , 52 , 28 , 80 , 78 , 48 ,162 , 35 , -1 ,133 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , 51 ,  8 , 50 , -1 , -1 , 12 , -1 ,165 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , -1 ,187 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,179 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 ,100 , -1 , -1 , -1 , -1 , 36 , -1 ,132 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 38 , -1 , 52 ,100 , -1 , -1 , -1 , -1 , 37 , -1 , 79 , -1 , -1 , 83 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , 15 , -1 , 85 , -1 , -1 , -1 , -1 , 77 , 25 ,  8 ,  0 ,188 , -1 , 47 , -1 , -1 , -1 , -1 ,185 , 41 , 55 , 80 , 78 , -1 ,  2 ,106 , -1 , 48 ,180 ,129 , -1 , 66 , -1 , -1 , -1 ,119 , -1 , -1 , 59 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , 50 , 10 , 49 , -1 , -1 , 13 , -1 , 30 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,179 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 , 56 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 39 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , 55 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 16 , -1 , 52 , 47 , 38 ,  0 , -1 , -1 , -1 ,135 , -1 , -1 , 77 , 37 , -1 , 87 , 88 , -1 , 36 ,  3 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 90 , 49 , 50 , -1 , 86 , -1 , -1 , -1 , -1 , 96 , 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 ,134 ,133 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 40 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 42 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,  9 ,  8 ,190 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 41 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , 43 , 42 , 44 , 45 ,169 ,170 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 ,180 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 ,191 ,188 ,192 , -1 , 40 ,  0 ,  9 ,  8 , 10 , 11 , -1 , -1 , 25 ,171 ,193 ,194 ,196 , -1 , -1 , -1 , -1 ,199 , -1 , -1 , -1 , -1 ,122 , 65 , -1 , 63 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 ,160 ,158 , -1 ,187 , -1 , 84 , -1 , -1 , 81 , -1 , -1 , -1 , -1 , -1 ,172 , -1 , -1 , -1 , 99 , -1 , -1 , -1 , -1 , 94 ,162 ,106 , -1 , -1 ,105 ,104 ,101 ,109 , -1 ,107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 ,197 ,198 , -1 , -1 , 62 , -1 , -1 , -1 ,202 ,173 ,140 ,161 , -1 , 69 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , 76 ,129 ,100 , -1 , -1 ,181 ,182 ,183 ,184 , 12 , 13 , 49 , 90 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , 26 ,165 ,166 ,167 ,168 ,  2 , 15 , 79 , 37 , -1 , -1 , 36 , 38 , 50 , 51 , -1 , 52 ,118 ,119 , 57 ,117 , -1 ,126 , -1 , -1 , -1 , -1),
    ( 42 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , 40 ,  0 ,  9 ,190 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , 45 ,169 ,170 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,192 , -1 , -1 , 42 , 41 , 40 ,  0 ,  8 , 10 , -1 , -1 ,185 ,186 ,171 ,193 , -1 , -1 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 , -1 , -1 ,130 , -1 , -1 , -1 ,203 ,204 , -1 , -1 ,196 , -1 ,188 , -1 ,194 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,172 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 ,106 , -1 , -1 ,109 ,102 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,199 , -1 ,197 , -1 ,126 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , 69 , -1 ,189 , 26 , -1 , -1 , -1 , -1 , -1 , -1 ,173 , -1 ,178 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , 66 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , 12 , 50 , 91 ,140 , -1 , -1 , -1 , -1 ,142 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , 49 , -1 , 79 ,132 , -1 , 15 , 37 , 51 , 81 , -1 , 77 ,120 , -1 ,118 , -1 , -1 , -1 , 73 , 74 , -1 , -1),
    ( 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 45 , -1 ,169 ,170 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , 42 , 41 ,  0 ,  8 , -1 , -1 , -1 ,191 ,186 ,171 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,204 , -1 , -1 , -1 ,158 , -1 , -1 ,192 , -1 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,141 , -1 ,139 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , 11 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , 49 , 79 , 81 , -1 , -1 , 54 ,143 , -1 ,120 , -1 , -1 , -1 , -1 , 72 , -1 , -1),
    ( 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,169 , -1 ,170 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , 43 , 41 ,  0 , -1 , -1 , -1 , -1 ,191 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 ,171 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , 10 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , 83 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , 76 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 46 , -1 , 47 , 55 , 56 , -1 , -1 , -1 , 36 , -1 , 15 , 49 , 50 , 51 , 81 , 10 ,194 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , 38 ,  8 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,  2 , -1 , 11 , 12 , 13 , -1 , -1 , -1 ,  3 ,  4 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 14 , -1 , -1 , 90 , 34 , -1 ,180 ,133 , -1 , 84 , -1 , -1 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,179 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 16 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 47 , -1 , 55 , 56 , -1 , -1 , -1 , -1 , 38 , -1 , 37 , 79 , -1 , -1 , 83 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , 28 , 10 ,  8 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , 25 ,  0 , 87 , 78 , -1 , -1 , 35 , -1 , -1 ,  2 ,  3 , 67 , 63 ,129 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , 49 , 11 , 15 , -1 , 76 , 14 , -1 ,144 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 ,162 ,192 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 ,179 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 48 , -1 , 41 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 ,181 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , 43 ,192 ,158 ,196 , -1 , -1 ,  2 , -1 , 35 , -1 , -1 , -1 , -1 ,  0 ,187 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 ,131 , 68 ,163 , -1 , 65 , -1 , -1 , -1 ,206 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 ,169 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , 63 , -1 ,120 ,200 , -1 , 64 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , -1 , -1 , 52 , 66 , -1 ,182 ,183 ,184 , -1 , 82 , -1 , -1 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , 26 ,165 ,166 ,167 ,  3 , -1 , 49 , 15 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , 38 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , 72),
    ( 49 , -1 , 79 , 54 ,102 , -1 , -1 , -1 , 50 , -1 , 51 , 81 , -1 , -1 , -1 , 41 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , 48 , -1 , -1 , -1 , 15 , -1 , 36 , 46 , -1 , 44 , -1 , 37 ,  0 ,  8 , 10 ,133 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , -1 ,  2 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,181 ,  4 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 ,158 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 ,101 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 50 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , 51 , -1 , 81 , -1 , -1 , -1 , -1 , 43 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , 49 , -1 , 15 , 36 , 46 , 45 , -1 , 79 , 41 ,  0 ,  8 , -1 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 ,133 , -1 , 48 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,181 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 ,102 , -1 , -1 , -1 , -1 , 90 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 83 , 45 , -1 , -1 , -1 , -1 , 50 , -1 , 49 , 15 , 36 ,169 , -1 , -1 , 43 , 41 ,  0 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1 ,  8 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 ,191 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , 91 , -1 , -1 , -1 , -1 , 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 52 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , 54 , 76 , -1 , -1 , -1 , 29 , 89 ,129 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , 36 , -1 , 37 , 15 , -1 , 85 , -1 , -1 , 49 ,101 , 26 , 28 , 25 ,186 , -1 , 55 , -1 , 87 , 88 , -1 , -1 ,185 , 56 , 34 , 86 , -1 ,  0 ,158 , 10 , 41 , 48 ,117 ,122 , -1 ,118 ,126 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 ,  8 , -1 , 80 , 79 , -1 , -1 , -1 , -1 , 31 , 50 , 43 , 44 , 16 , -1 , 93 , -1 , 91 , -1 , -1 , 99 , -1 , -1 , 96 ,  2 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , 60 ,202 ,124 , -1 , 58 , -1 ,120 , -1 , 61 , 67 , -1 , 17 , -1 , 18 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , 39 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1),
    ( 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , 56 ,100 , 26 , -1 , -1 , -1 ,134 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , 52 ,  0 , 87 , 77 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 54 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 49 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , 51 , -1 , -1 ,185 , -1 , -1 , -1 , 77 , -1 , 52 , 55 , 87 , -1 , -1 ,101 , 26 , 29 , 34 , 43 , -1 ,  0 , 44 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , 41 , 83 , 25 , -1 , 86 , -1 , 78 , -1 , -1 , 81 , 45 ,169 , 91 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,141 , -1 , -1 , -1 ,120 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 ,140 , -1 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 ,113 , -1 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 55 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , 77 , 54 , 76 , -1 , -1 , 34 , -1 , 67 , 68 , 96 , -1 , -1 , -1 ,113 , -1 , 47 , 46 , -1 , 38 , 36 , -1 , -1 , -1 , -1 , 15 ,100 , 29 , 80 , 28 ,171 , -1 , 87 , -1 , 88 , -1 , -1 , 26 , 25 , -1 , 86 , -1 , -1 ,  8 , -1 , 11 ,  0 ,  2 , 60 ,202 ,117 , 57 , 62 , 61 , -1 , -1 , -1 ,137 , 17 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , 10 , 79 , 78 , 37 , -1 , -1 , -1 , -1 , -1 , 49 , 41 , 43 , -1 , 93 , -1 , -1 , 90 , -1 , 97 , 19 , 95 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 23 ,115 ,114 , -1 , 59 ,124 ,123 , -1 , -1 , -1 ,119 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,194 , -1 ,196 ,191 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,135 , -1 , -1 ,132 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1),
    ( 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 ,101 ,102 , -1 , -1 , -1 ,144 , -1 , 60 , 63 ,103 , -1 , -1 ,111 , -1 , -1 , 55 , 47 , -1 , 52 , 38 , 36 , -1 , -1 , -1 , 37 , -1 , 30 , 34 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,165 , 26 , -1 , -1 , -1 , -1 , 28 ,187 , 78 , 25 ,  0 , -1 , -1 , -1 , 17 , 64 , -1 , 18 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113 , -1 , 80 , 54 , 86 , 77 , -1 , -1 , -1 , -1 , -1 , 79 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 ,  8 , 10 , 11 , 19 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , 22 , -1 , 75 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 ,127 ,118 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 ,192 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , 53 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 57 , -1 , 17 , -1 , -1 , -1 , -1 , -1 ,118 , -1 ,120 ,143 , -1 , -1 , -1 ,136 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 ,157 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 ,159 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 ,161 , -1 , -1 , -1 , -1 ,163 , -1 , -1 ,200 , -1 ,  0 ,197 , 41 , 62 , -1 , 60 , -1 , 67 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , 10 , -1 , -1 , -1 ,126 , -1 ,124 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , 37 , -1 , 47 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 58 , -1 , -1 , 18 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , 57 ,  0 ,118 , -1 , -1 , 55 , -1 , 47 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,201 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1),
    ( 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 ,118 ,120 ,143 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 ,136 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 ,  8 , -1 ,  0 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , 11 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , 48 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 ,197 ,173 ,202 , -1 ,122 ,  0 ,200 , -1 , 17 , -1 , -1 , 80 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 ,  8 ,123 , -1 , -1 , -1 , 59 ,118 , 41 , 48 , -1 ,116 ,100 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , 87 , 61 , -1 , 57 , -1 , -1 , -1 , -1),
    ( 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 ,121 , -1 ,202 , 63 , -1 , -1 , -1 , 60 ,  0 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 ,124 , -1 , -1 , -1 , 53 , 87 , 52 ,117 ,129 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1),
    ( 62 , -1 , 64 , 69 , -1 , -1 , -1 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,201 , -1 ,200 ,196 , -1 , -1 , -1 ,  0 , -1 ,  2 , 35 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 ,158 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , 57 , 55 , -1 , -1 , -1 , -1 , -1),
    ( 63 , -1 ,202 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 ,121 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 ,198 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,174 , -1 , -1 , -1 ,173 ,162 , -1 ,  0 , -1 , -1 , -1 ,197 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 ,128 , -1 , -1 , -1 , 37 , 35 , 48 , -1 , -1 , -1 , -1 ,117 , -1 , 80 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , 47 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1),
    ( 64 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,201 ,161 ,192 , -1 , -1 , -1 , 25 , -1 ,  0 ,  8 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 ,159 , -1 , -1 , -1 , -1 , -1 , 28 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , 57 , 18 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , 56 , -1 , -1 , -1 , -1 , -1),
    ( 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , 41 ,  0 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,201 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 ,192 , -1 , -1 , -1 , -1 , -1 , -1 , 25 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 ,118 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 ,100 , -1 , -1 , -1 , -1 , -1),
    ( 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 ,199 , -1 , -1 ,129 , -1 , 67 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 ,  0 , 43 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , 48 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , 54 , 41 , 17 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 67 , -1 , 60 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 ,124 , -1 , -1 , -1 ,128 , -1 , -1 ,173 , -1 , 63 , -1 , -1 ,  2 , -1 , -1 , 57 , -1 , -1 , 10 ,  0 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , 35 ,116 , -1 , -1 , -1 , -1 , -1 , 48 ,180 , -1 , -1 , 52 ,  8 ,137 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 68 , -1 , 63 ,202 , -1 , -1 , -1 , -1 ,131 , -1 ,130 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 ,174 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 ,173 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , 15 , -1 ,180 , -1 , -1 , -1 , -1 ,129 ,128 , 10 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , 55 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1),
    ( 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , 62 , -1 , 65 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , 26 , -1 , 25 , 28 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 ,136 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 70 , 24 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , 71 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 25 , 78 , 10 , 80 , -1 , -1 , -1 , 72 , -1 , 74 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 ,147 , -1 , -1 , -1 , -1 ,142 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 71 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 74 , 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 ,  0 , 11 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 74 , -1 , -1 , 71 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 ,138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 ,  0 , 48 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 73 ,142 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 74 , -1 , -1 , 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 28 ,  0 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 74 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 71 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 ,  8 ,  2 ,  0 , -1 , -1 ,138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,156 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 ,141 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , 77 , 52 , 55 , -1 , -1 ,102 , -1 , 26 , 29 , 44 , -1 , 41 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 43 , -1 ,185 , 83 , 34 , -1 , 80 , -1 , -1 , -1 ,169 ,170 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 77 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , 76 , -1 , -1 , -1 , -1 , 26 , -1 , 66 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , 15 , -1 , 79 , 49 , -1 , -1 , -1 , -1 , 50 ,102 , -1 , 25 ,185 ,191 , -1 , 52 , -1 , 55 , 87 , 88 , -1 , -1 ,100 , 29 , 34 , 86 , 41 ,196 ,  8 , 43 , -1 , -1 , -1 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , 17 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 ,  0 , -1 , 28 , -1 , -1 , -1 , -1 , -1 ,166 , 51 , 44 , 45 , 90 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 ,  2 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 ,117 ,122 , 60 , -1 ,119 , -1 ,143 , -1 , -1 ,129 , -1 ,127 , 18 , -1 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , 85 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 78 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , 80 , -1 , 28 , 25 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , 35 , 34 , -1 , 84 ,194 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,205 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 ,  8 , -1 , -1 , -1 , 37 , -1 ,  2 ,187 ,188 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , 87 , 88 , -1 , -1 , -1 , -1 , 47 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1),
    ( 79 , -1 , 54 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 83 , -1 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , 41 , 43 , -1 , -1 , 37 , -1 , 38 , 47 , -1 , -1 , 44 , 77 , 25 , 28 , 80 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , 48 , 81 ,  0 , 51 , 78 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 ,180 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 ,188 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,179 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,154 ,101 , -1 , -1 , -1 , -1 , 15 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 80 , -1 , 34 ,144 , -1 , -1 , -1 , -1 , 28 , -1 , 25 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 ,  8 , 35 , -1 , -1 , -1 , -1 ,  2 , 29 , -1 ,194 ,193 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , -1 ,171 , 86 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , 84 ,  0 , -1 , -1 , -1 , 79 , -1 , 48 ,188 ,192 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 ,197 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 ,100 , -1 , -1 ,125 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , 55 , 87 , -1 , -1 , -1 , 88 , 38 , 37 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 81 , -1 , 83 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,169 , -1 , -1 , -1 , -1 , 51 , -1 , 50 , 49 , 15 ,170 , -1 , -1 , 44 , 43 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 ,  0 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 82 , -1 , 12 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 ,  2 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 13 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 83 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 45 ,169 , -1 , -1 , -1 , -1 , -1 , 79 , 37 , -1 ,170 , -1 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , 25 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 84 , -1 , -1 , 93 , -1 , -1 , -1 , -1 ,194 , -1 ,193 ,171 ,186 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , 78 , -1 , -1 , -1 , 13 , -1 , 10 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 85 , -1 , -1 , 15 , 37 , 77 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 ,  4 ,181 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 ,182 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  5 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,183 ,  6 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , 38 , 52 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , 29 , 26 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , 11 , -1 , 80 , 10 , -1 , -1 , -1 , -1 ,  8 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 ,194 , -1 , -1 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , 25 , -1 , 28 , -1 , -1 , -1 , 77 , -1 ,  0 ,171 ,186 , 46 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , 98 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , 52 , 77 , 54 , 76 , -1 , 86 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , 46 , -1 , -1 , -1 , -1 , 36 , 56 , 34 , 78 , 80 ,193 , -1 , 88 , -1 , -1 , -1 , -1 , 29 , 28 , -1 , -1 , -1 , -1 , 10 ,160 , 12 ,  8 , 35 ,124 ,123 , 60 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 13 , 11 , 37 , -1 , 38 , -1 ,102 , -1 ,132 , -1 , 15 ,  0 , 41 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , 98 , -1 , 96 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , 57 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , 84 , -1 ,158 ,186 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , 55 , 52 , 77 , 54 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , 86 , -1 , 78 ,194 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , 80 , -1 , -1 , -1 , -1 , 11 , -1 , 13 , 10 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 14 , 12 , 38 , -1 , 47 , -1 ,101 , -1 , -1 , -1 , 36 ,  8 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,193 , -1 , -1 ,171 ,187 , -1 , -1 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,172 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 ,  0 , -1 , -1 , 54 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,166 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , 29 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , 30 ,144 , -1 , -1 , 86 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , 15 , 36 , 46 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 ,  0 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , 90 , -1 , 16 , -1 , -1 , 81 , -1 , -1 , 49 , 15 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , 41 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,172 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , -1 , -1 , -1 , -1 ,160 , -1 , -1 ,  0 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,194 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 ,193 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , -1 , -1 ,194 , -1 , -1 , -1 , -1 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 ,171 ,172 , -1 , 10 , -1 , -1 , 52 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,175 ,176 ,177 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 ,196 ,133 , -1 , -1 , -1 , -1 , -1 ,162 ,106 , -1 ,104 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , 20 , 21 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , 49 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 96 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 ,  0 , 15 , -1 , -1 , -1 , -1 , -1 ,  2 , 35 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 ,171 ,  0 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,193 , -1 , -1 ,  0 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , -1 , -1 , 43 ,  0 ,105 ,107 , -1 , -1 , -1 ,100 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 ,102 , -1 , -1 , -1 , -1 , 30 , -1 ,117 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , 52 , 38 , -1 , 77 , 37 , 15 , -1 , 85 , -1 , 79 , -1 ,165 , 29 , 26 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , 25 ,188 , 80 ,185 , 41 , -1 , -1 , -1 ,127 , 65 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , 28 , 76 , 34 , 54 , -1 , -1 , -1 , -1 , 32 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,109 ,103 ,  0 ,  8 , 10 , 99 , 19 , -1 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 ,125 , -1 , -1 , -1 ,140 ,120 , -1 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 ,165 , -1 , -1 , -1 ,109 , -1 , -1 , -1 , -1 , -1 , 77 , 37 , -1 , 54 , 79 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 ,100 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , 30 ,144 , -1 ,185 ,192 , 28 , -1 , 43 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , 25 , -1 , 29 , 76 , -1 , -1 , -1 , -1 ,167 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , 41 ,  0 ,  8 , -1 , 99 , -1 , -1 , -1 , -1 , 19 , -1 , -1 ,177 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 , -1 ,125 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 , 15 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,112 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , 79 , -1 , 76 , -1 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 ,100 , 56 , -1 , -1 , -1 , -1 ,165 , 30 ,144 , -1 , -1 , 25 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 ,185 , -1 , 26 , -1 , -1 , -1 , 86 , -1 , -1 , 83 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,109 , 43 , 41 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , 99 , -1 , -1 , -1 ,156 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,164 , -1 ,113 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,154 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 ,109 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,111 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , 25 , 37 , -1 , -1 , -1 ,108 , -1 ,  0 ,  8 , -1 , -1 , -1 ,101 , 10 , -1 , 21 , -1 , -1 , -1 , 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,109 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 ,185 , 79 , -1 , -1 , 94 , -1 ,108 , 41 ,  0 , -1 , -1 , -1 ,102 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 ,  0 , 99 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (106 , -1 ,158 ,188 ,186 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 , -1 ,195 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,201 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 ,  8 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,181 , -1 ,163 , -1 , -1 , -1 , -1 , -1 , -1 ,187 ,171 , -1 , -1 , -1 , -1 ,  4 ,180 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , 35 , -1 , -1 , -1 ,128 ,116 , -1 , -1 , -1 , -1 , -1),
    (107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , 19 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (108 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (109 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , 43 , 41 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (110 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (111 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,177 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,176 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (112 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (113 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,139 , -1 , -1 , -1 , -1 ,157 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (114 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113 , -1 ,139 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (116 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 ,202 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 ,106 , -1 ,  8 , -1 , -1 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , 38 , -1 ,  2 ,173 , -1 , -1 , -1 , 60 , -1 , 78 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1),
    (117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 ,199 , -1 ,122 , -1 , -1 , 41 , -1 , -1 ,127 , -1 , -1 , 28 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 ,  0 ,202 , -1 ,123 , -1 , 57 ,120 , 43 , -1 , -1 , 63 ,101 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , 55 , -1 , -1 ,118 , -1 , -1 , -1 , -1),
    (118 , -1 ,127 , -1 , -1 , -1 , -1 , -1 ,120 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 ,161 , -1 , -1 , 57 , -1 , 59 , -1 , -1 , -1 , -1 , 17 ,136 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , 41 ,199 , 43 ,126 , -1 ,117 , -1 ,129 , 67 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 ,  0 ,197 ,  8 , -1 , -1 , -1 , -1 , -1 , 60 ,  2 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , -1 , -1 , 35 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , 38 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , 58 , 52 , -1 , -1 , -1 , -1 , -1 , -1),
    (119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , 64 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , 62 , -1 , -1 ,126 , -1 ,118 , 41 ,120 , -1 , -1 , 52 , -1 , 38 , 47 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 ,  0 , 59 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (120 , -1 ,140 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 , -1 , -1 , -1 ,118 , -1 , 57 , 59 , -1 , -1 , -1 ,127 , -1 ,136 , -1 , -1 , -1 ,163 , -1 , -1 , 43 , -1 , 44 , -1 , -1 , -1 , -1 , 66 ,129 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , 41 ,199 ,  0 , -1 , -1 , -1 , -1 , -1 ,117 , 48 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , -1 ,  2 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , 77 , -1 , -1 , -1 , -1 , -1 , -1),
    (121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,174 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,195 , -1 ,187 , -1 , -1 , -1 , -1 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 , -1 , -1 , -1 , -1 ,  0 ,160 ,158 , -1 , -1 , -1 , -1 , -1 , -1 ,194 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 ,116 , -1 , -1 , -1 , -1 ,131 ,130 , 61 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,202 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 ,121 , -1 , -1 , -1 , -1 , -1 ,199 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 , 54 ,  0 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , 52 , 60 , -1 , -1 , 41 , -1 , -1 , -1 , -1),
    (123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,202 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , 63 , 68 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , 28 , -1 , -1 , -1 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 ,198 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , 52 , 10 ,  0 ,197 ,173 , -1 , -1 , -1 , -1 , 86 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , 87 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1),
    (124 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , 60 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 ,123 , -1 ,202 ,  8 ,163 , -1 , -1 , -1 , -1 , 78 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 ,197 ,199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , 10 , -1 , -1 , -1 , -1 , -1 , 57 ,  0 ,  2 , -1 , -1 , 56 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , 88 , -1 , -1 , 59 , -1 , -1 , -1 , -1),
    (125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , 60 , 67 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , 86 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , -1 , -1 , -1 , -1 ,137 , 17 , 25 ,  0 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (126 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 , -1 ,201 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , 48 ,  2 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 ,196 ,163 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 ,118 , 52 , -1 , -1 , -1 , -1 , -1),
    (127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 , -1 ,159 , -1 , -1 ,185 , -1 , -1 , 65 , -1 , -1 , -1 ,117 , 60 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , 25 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 44 , -1 , -1 ,  8 , -1 , -1 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , 52 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1),
    (128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 ,163 , -1 , -1 ,160 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 ,  0 , -1 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 ,131 , 66 , -1 ,124 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1),
    (129 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 ,199 , 60 , -1 , -1 , -1 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 ,118 , -1 , -1 ,  8 , 41 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 ,  2 , 63 , -1 ,116 , -1 , -1 , -1 , -1 ,133 , -1 , 68 , 77 ,  0 , -1 , 17 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,174 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 41 , -1 ,202 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , 77 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1),
    (131 , -1 , -1 ,122 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , 63 ,121 , -1 , -1 ,174 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 ,128 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 49 ,  3 ,133 , -1 , -1 , -1 , -1 , 66 ,173 ,  8 ,  0 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , 52 , -1 , -1 , -1 , -1 , -1 ,202 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1),
    (132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , 90 , -1 , -1 , -1 , -1 , 91 , -1 , 54 , 37 , 79 , 43 , -1 , -1 , -1 , 39 , -1 ,135 , 76 , -1 , -1 , 52 , 55 , 87 , 49 ,133 , 36 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , 15 , -1 , 38 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , 51 , 81 , -1 , 29 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 53 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (133 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 ,180 , -1 ,  3 , -1 , -1 , -1 , -1 , 48 ,158 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , 62 ,126 ,195 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , 51 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 ,185 , -1 , -1 , -1 ,181 , -1 , -1 , -1 , 16 , -1 , 85 , -1 , -1 , -1 ,132 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (134 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , 87 , 10 , -1 , 55 , 47 , -1 , 61 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (135 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 ,132 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 ,  3 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,159 , -1 , -1 , -1 ,163 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,193 , -1 ,194 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,192 , -1 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , 80 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , 17 , -1 , -1 , -1 , -1 ,137 ,118 ,120 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1),
    (137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 ,127 ,140 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,159 , -1 , 80 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 ,  0 , -1 , -1 , 12 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 ,196 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 72 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 71 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (139 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113 ,157 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , 17 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , 69 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 ,159 ,161 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 ,185 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 45 , -1 , -1 ,  0 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , 77 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1),
    (141 , -1 ,156 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (142 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 24 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 ,118 , 57 , 59 , -1 , -1 ,140 , -1 , -1 ,136 , -1 , -1 ,200 , -1 , -1 , 44 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , 66 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 , -1 ,161 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , 48 ,157 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,141 , -1 , -1 , -1 , 79 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1),
    (144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 30 , -1 ,165 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , 80 , -1 , 29 , 28 ,  8 , 35 , -1 , -1 , 25 , 31 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , 26 , -1 , -1 , -1 ,102 , -1 ,185 , -1 , -1 , 38 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 ,193 ,194 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (145 , 25 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,185 , -1 , -1 , 43 ,196 ,192 ,158 , -1 ,160 ,187 , -1 , -1 ,152 , -1 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 , -1 ,155 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (146 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 , -1 , -1 , -1 , -1 , -1 ,147 , -1 ,148 , -1 , -1 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 ,  0 , 41 , 43 , 48 ,106 ,158 , -1 , -1 , -1 ,160 , -1 , -1 ,151 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (147 , 10 ,149 , -1 , -1 , -1 , -1 , -1 ,146 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 ,  0 , 41 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (148 , 11 , -1 , -1 , -1 , -1 , -1 , -1 ,147 , -1 ,146 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 ,  8 ,  0 , 35 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (149 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,147 , -1 , -1 ,146 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , 28 , 25 ,185 ,  0 , -1 ,187 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,148 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (150 , 56 , -1 , -1 , -1 , -1 , -1 , -1 ,152 , -1 ,153 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 ,147 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 ,100 ,101 ,102 , 77 ,  0 , 25 ,  8 , 10 , 11 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (151 , 55 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 ,145 , -1 , -1 , -1 , -1 ,146 , -1 ,148 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,147 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , 52 , 77 , 54 , 37 ,  2 ,  0 , 35 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (152 ,100 , -1 , -1 , -1 , -1 , -1 , -1 ,153 , -1 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 ,146 ,147 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 ,101 ,102 , -1 , 54 , 41 ,185 ,  0 ,  8 , 10 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (153 ,101 , -1 , -1 , -1 , -1 , -1 , -1 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 ,152 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 ,145 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 ,146 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 ,102 , -1 , -1 , 76 , 43 , -1 , 41 ,  0 ,  8 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (154 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 , -1 ,152 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , 44 , -1 , 43 , 41 ,  0 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (155 , 77 ,153 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,154 , -1 ,145 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 ,152 , -1 , -1 , -1 , -1 , -1 ,146 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,147 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , 54 , 76 , -1 , -1 , -1 , 43 , 48 ,  2 , 35 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (156 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,141 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (157 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,139 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113 , -1 , -1 , -1 , -1 , -1 , -1),
    (158 , -1 ,188 ,186 , -1 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 ,192 ,189 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 ,195 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , -1 ,201 , -1 , -1 ,121 , -1 ,161 , -1 , -1 , -1 , -1 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , 43 ,128 , 28 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , -1 , -1 , -1 , -1 , -1 ,  3 , 48 ,  2 , 36 , -1 , -1 , 35 ,133 , -1 , 52 ,  8 ,163 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1),
    (159 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 ,188 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,127 , 10 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , 80 , -1 , -1 , -1 , -1 , -1 , -1),
    (160 , -1 , -1 ,193 , -1 , 89 , -1 , -1 , -1 , -1 ,158 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 ,106 , -1 , -1 , -1 ,133 , -1 , -1 ,195 , -1 ,  5 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,159 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 ,205 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 ,128 ,  0 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,194 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 ,  3 ,180 , 87 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,138 , -1),
    (161 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,192 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 , -1 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , 43 , -1 ,  0 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 ,120 ,118 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , 17 , 64 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1),
    (162 , -1 ,196 ,192 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,195 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,201 ,174 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 ,203 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , 64 , -1 , -1 , -1 , -1 , -1 ,188 ,186 , -1 , -1 , -1 , -1 ,181 ,133 ,180 , -1 , -1 ,  4 ,  3 , -1 , -1 , 37 ,  2 , -1 , -1 , -1 ,173 , 63 , -1 ,138 , -1 , -1 , -1),
    (163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,200 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 ,196 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 ,201 , -1 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , 48 ,120 , 35 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 ,  8 ,124 , -1 , -1 , -1 , -1 , -1),
    (164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,203 , -1 ,179 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,206 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 24 , -1 , -1 ,142),
    (165 , -1 ,166 ,167 ,168 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , 25 , -1 , -1 ,185 , 41 , 48 ,180 ,181 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 30 , -1 ,144 , -1 , -1 , -1 , -1 , 31 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 ,171 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,  2 ,  3 ,  4 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 32 , 33 , -1 , -1 , -1 , 29 ,100 , -1 , -1 , -1 , -1 , 56 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (166 , -1 ,167 ,168 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,165 , 26 , -1 , -1 , -1 ,185 , 41 , 48 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 31 , -1 , -1 , -1 , -1 , -1 , -1 , 32 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 ,  0 ,  2 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 33 , -1 , -1 , -1 , -1 , 30 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (167 , -1 ,168 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,166 ,165 , -1 , -1 , -1 , -1 ,185 , 41 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 32 , -1 , -1 , -1 , -1 , -1 , -1 , 33 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , 25 ,  0 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 31 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (168 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,167 ,166 , -1 , -1 , -1 , -1 , -1 ,185 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 33 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,165 , 26 , 25 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 32 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (169 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,170 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 45 , -1 , 44 , 43 , 41 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , -1 ,188 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 81 , -1 , 83 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (170 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,169 , -1 , 45 , 44 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 ,192 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 81 , 83 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , -1 ,191 , -1 , -1 , -1 , -1 ,172 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,187 , -1 , -1 ,188 ,158 ,106 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 ,193 , -1 ,194 , 84 , -1 , -1 , -1 , -1 , -1 , 92 , -1 , -1 , -1 , -1 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,192 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 ,180 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 30 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 ,  8 , 25 , 28 , 55 , -1 , 10 , 80 , 41 , 43 , -1 , 34 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (172 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,193 , -1 , -1 , 34 , -1 ,194 , -1 ,186 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (173 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,174 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 ,200 , -1 , -1 , -1 ,196 ,161 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 ,158 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 ,130 , -1 , 68 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 ,  2 , -1 , 35 , 63 , -1 , -1 , -1 , -1 , -1 , -1),
    (174 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (175 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,176 ,177 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 19 , 20 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (176 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,177 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,175 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,111 , -1 , -1 , -1 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 ,  0 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (177 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,176 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,111 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,175 , 94 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (178 ,203 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , -1 , -1),
    (179 , -1 , -1 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (180 , -1 , 48 , 41 ,185 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,181 ,182 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 ,106 ,162 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,174 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , 62 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , 50 , -1 , 38 , -1 , -1 ,183 ,184 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 ,  0 , 25 , 26 ,165 ,166 ,  4 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (181 , -1 ,180 , 48 , 41 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,182 ,183 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 ,162 , -1 , -1 , -1 , -1 ,  4 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 ,184 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 ,  0 , 25 , 26 ,165 ,  5 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (182 , -1 ,181 ,180 , 48 , 41 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,183 ,184 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  5 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 ,  2 ,  0 , 25 , 26 ,  6 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (183 , -1 ,182 ,181 ,180 , 48 , 41 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,184 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  6 , -1 , -1 , -1 , -1 , -1 , -1 ,  5 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 ,  3 ,  2 ,  0 , 25 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (184 , -1 ,183 ,182 ,181 ,180 , 48 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 ,  6 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  5 ,  4 ,  3 ,  2 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , 48 , -1 , 43 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 ,186 ,191 , -1 , -1 , 25 , -1 , 28 , 80 , 78 , -1 , -1 , 26 , -1 , -1 , -1 ,192 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 ,202 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 , 45 ,171 , 44 , -1 , -1 , 84 , 83 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,161 , -1 , -1 , -1 , -1 , 64 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , 30 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 ,117 , -1 , -1 , -1 ,180 ,181 ,182 ,183 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,165 ,166 ,167 ,168 , -1 ,  0 , 37 , 54 , 77 , -1 , -1 , 38 , 52 , -1 , -1 , -1 ,100 ,127 , -1 , 17 , -1 , -1 , 65 , -1 , -1 , -1 , -1),
    (186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 ,158 , -1 ,192 ,196 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , -1 ,193 ,194 , 84 , -1 , -1 , -1 ,172 , -1 , 92 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 45 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,165 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , 30 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , 41 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,187 ,  0 ,185 , 25 , 52 , -1 ,  8 , 28 , 43 , 44 , -1 , 29 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (187 , -1 ,171 , -1 , -1 , -1 , -1 , -1 ,188 , -1 ,192 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 ,106 , -1 , -1 , -1 , -1 ,162 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,189 ,193 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,195 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,181 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 ,197 ,185 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 ,160 , 35 ,  0 ,  8 , 47 , -1 , -1 , 10 , 48 , -1 , 56 , 80 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (188 , -1 ,186 , -1 , -1 , -1 , -1 , -1 ,192 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 ,106 , -1 ,196 ,162 , -1 , -1 , -1 , -1 , -1 ,191 , -1 , -1 ,189 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,195 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 ,199 , -1 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , 41 ,  0 , 38 , -1 , 35 ,  8 , -1 , -1 ,100 , 28 , -1 , -1 ,159 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,195 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,172 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 ,192 ,188 ,  0 , -1 , -1 ,187 , -1 , -1 , 26 ,171 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (190 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  9 ,  8 , 40 , 42 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,192 ,196 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,186 , -1 ,171 ,193 ,194 , -1 , -1 , -1 , -1 ,172 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,189 , -1 , -1 , -1 , 92 , -1 , -1 ,169 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,165 , -1 , -1 ,162 , -1 , -1 , -1 , 84 , -1 , 43 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 , 41 , -1 ,185 , 77 , -1 ,  0 , 25 , 44 , 45 , -1 , 26 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (192 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,189 , -1 , -1 , -1 ,188 , -1 ,187 , -1 , -1 , -1 , -1 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,195 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , -1 ,197 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , 48 , 43 , 41 , 37 , -1 ,  2 ,  0 , -1 , -1 ,101 , 25 ,161 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (193 , -1 , -1 , 89 , -1 , -1 , -1 , -1 ,171 , -1 ,186 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 ,187 , -1 , -1 , -1 , -1 , -1 ,158 , -1 ,172 , -1 , -1 , -1 , -1 ,194 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,192 , -1 ,188 , -1 , -1 , -1 , 43 , -1 ,196 ,189 , -1 ,  3 , -1 , -1 , 49 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , 28 , 80 , 87 , -1 , 11 , 78 ,  0 , 41 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (194 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,193 , -1 ,171 ,186 ,191 , -1 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 ,172 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 , -1 ,187 , -1 , -1 , -1 , 41 , -1 ,158 , -1 ,189 , -1 , -1 , -1 , 15 ,180 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , 11 , 80 , 78 , 88 , -1 , 12 , -1 ,  8 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (195 , -1 , -1 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,201 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 , -1 ,187 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 ,106 ,  3 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1),
    (196 , -1 ,192 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,189 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 ,160 , -1 , -1 , -1 ,188 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 , -1 , -1 ,174 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,195 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 , -1 , -1 , -1 , -1 ,204 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , 44 ,173 , 25 ,199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 ,161 , 69 , -1 , -1 , -1 , -1 , -1 ,186 , -1 , -1 , -1 , -1 ,106 ,180 , -1 , 48 , 15 , -1 ,  3 ,  2 , -1 , -1 , 77 ,  0 ,200 , 62 ,163 ,197 ,202 ,201 , -1 ,138 , -1 , -1),
    (197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 ,196 , -1 , -1 ,161 , -1 , -1 ,187 ,192 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 ,121 ,120 ,163 , -1 , -1 , -1 , -1 , -1 ,185 ,188 ,136 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , 63 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , 66 ,129 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , 60 ,  0 , 57 ,  8 ,202 , -1 ,200 , -1 , -1 , -1 , -1),
    (198 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,174 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,192 , -1 , -1 , -1 , -1 ,191 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,171 ,186 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , 68 , 63 , -1 , -1 , -1 ,202 ,197 ,  0 , -1 , -1 , -1 ,196 , -1 , -1 , -1 , -1),
    (199 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,197 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,188 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 ,198 , -1 , -1 ,143 ,200 , -1 , -1 , -1 , -1 , -1 , -1 ,192 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,173 , -1 , -1 , 66 , -1 , -1 , -1 ,129 , -1 , -1 , -1 ,117 , 41 ,118 ,  0 ,122 , -1 , -1 , -1 , -1 , -1 , -1),
    (200 , -1 ,161 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,162 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,163 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 , -1 ,201 , -1 ,197 , -1 ,173 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , 65 , -1 , -1 , -1 , -1 ,136 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 ,160 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 ,143 ,  2 , 17 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , 62 , -1 , -1 ,  0 , 60 , -1 , -1 , -1 , -1 , -1),
    (201 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,196 , -1 ,162 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,158 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , -1 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 ,200 ,  0 , -1 , -1 , -1 , -1 , -1),
    (202 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , 68 , -1 , -1 ,131 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,198 , -1 , -1 , -1 , -1 ,197 ,196 , -1 , 25 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,185 , -1 , -1 , -1 , -1 , 77 ,  8 , 41 ,199 , -1 , -1 , -1 , -1 , -1 , 34 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , 60 , 55 ,124 , -1 , -1 ,  0 , -1 , -1 , -1 , -1),
    (203 , -1 ,204 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,206 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,178 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,164 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,  2 , -1 , 43),
    (204 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,203 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,205 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 ,  0 , 44 , -1),
    (205 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,204 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,206 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,203 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , 11 ,  0 , 28),
    (206 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,203 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,205 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , 48 ,  0)
  );

const
  PowerTable : array[0..206] of
    record  Square, Cubic, Quartic, Quintic, Sextic: longint; end = (
    (Square:   0; Cubic:   0; Quartic:   0; Quintic:   0; Sextic:   0),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:   3; Cubic:   4; Quartic:   5; Quintic:   6; Sextic:   7),
    (Square:   5; Cubic:   7; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:   7; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  10; Cubic:  11; Quartic:  12; Quintic:  13; Sextic:  14),
    (Square:   8; Cubic: 190; Quartic:  10; Quintic:  -1; Sextic:  11),
    (Square:  12; Cubic:  14; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  14; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  16; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  18; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  20; Cubic:  21; Quartic:  22; Quintic:  -1; Sextic:  -1),
    (Square:  22; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  26; Cubic: 165; Quartic: 166; Quintic: 167; Sextic: 168),
    (Square: 166; Cubic: 168; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  34; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 132; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  39; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  41; Cubic:  42; Quartic:  43; Quintic:  -1; Sextic:  44),
    (Square:  43; Cubic:  44; Quartic:  45; Quintic: 169; Sextic: 170),
    (Square:  44; Cubic:  -1; Quartic: 170; Quintic:  -1; Sextic:  -1),
    (Square:  45; Cubic: 170; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 170; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 135; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 133; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  91; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  53; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 134; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  58; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  61; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 175; Cubic: 176; Quartic: 177; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 195; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 168; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 172; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 174; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 177; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 189; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  11; Cubic:  -1; Quartic:  14; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  92; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 198; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 201; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1)
  );

const
  RootTable : array[0..206] of
    record  Square, Cubic, Quartic, Quintic, Sextic: longint; end = (
    (Square:   0; Cubic:   0; Quartic:   0; Quintic:   0; Sextic:   0),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:   2; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:   2; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:   3; Cubic:  -1; Quartic:   2; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:   2; Sextic:  -1),
    (Square:   4; Cubic:   3; Quartic:  -1; Quintic:  -1; Sextic:   2),
    (Square:   9; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:   8; Cubic:  -1; Quartic:   9; Quintic:  -1; Sextic:  -1),
    (Square: 190; Cubic:   8; Quartic:  -1; Quintic:  -1; Sextic:   9),
    (Square:  10; Cubic:  -1; Quartic:   8; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:   8; Sextic:  -1),
    (Square:  11; Cubic:  10; Quartic: 190; Quintic:  -1; Sextic:   8),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  15; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  17; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  19; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  19; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  20; Cubic:  -1; Quartic:  19; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  25; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  28; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  38; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  40; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  40; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  41; Cubic:  -1; Quartic:  40; Quintic:  -1; Sextic:  -1),
    (Square:  42; Cubic:  41; Quartic:  -1; Quintic:  -1; Sextic:  40),
    (Square:  43; Cubic:  -1; Quartic:  41; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  52; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  57; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  60; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  49; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 193; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  37; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  48; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  55; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  47; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  25; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  26; Cubic:  -1; Quartic:  25; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  25; Sextic:  -1),
    (Square: 165; Cubic:  26; Quartic:  -1; Quintic:  -1; Sextic:  25),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  41; Sextic:  -1),
    (Square:  44; Cubic:  43; Quartic:  42; Quintic:  -1; Sextic:  41),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 171; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 173; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  94; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  94; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 175; Cubic:  -1; Quartic:  94; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 188; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:   9; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 158; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 197; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 200; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1)
  );

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
function SameValue(const ALeft, ARight: TQuantity): boolean;

{ Constants }

const
  AvogadroConstant               : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: ReciprocalMoleId;                     FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}
  BohrMagneton                   : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: SquareMeterAmpereId;                  FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}
  BohrRadius                     : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: MeterId;                              FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}
  BoltzmannConstant              : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: JoulePerKelvinId;                     FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}
  ComptonWaveLength              : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: MeterId;                              FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}
  CoulombConstant                : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: NewtonSquareMeterPerSquareCoulombId;  FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}
  DeuteronMass                   : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}
  ElectricPermittivity           : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: FaradPerMeterId;                      FValue:     8.8541878128E-12); {$ELSE} (    8.8541878128E-12); {$ENDIF}
  ElectronMass                   : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}
  ElectronCharge                 : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: CoulombId;                            FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}
  MagneticPermeability           : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: HenryPerMeterId;                      FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}
  MolarGasConstant               : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: JoulePerMolePerKelvinId;              FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}
  NeutronMass                    : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}
  NewtonianConstantOfGravitation : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: NewtonSquareMeterPerSquareKilogramId; FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}
  PlanckConstant                 : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramSquareMeterPerSecondId;       FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}
  ProtonMass                     : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}
  RydbergConstant                : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: ReciprocalMeterId;                    FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}
  SpeedOfLight                   : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: MeterPerSecondId;                     FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}
  SquaredSpeedOfLight            : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: SquareMeterPerSquareSecondId;         FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}
  StandardAccelerationOfGravity  : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: MeterPerSquareSecondId;               FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}
  ReducedPlanckConstant          : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramSquareMeterPerSecondId;       FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}
  UnifiedAtomicMassUnit          : TQuantity = {$IFDEF ADIMDEBUG} (FUnitOfMeasurement: KilogramId;                           FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}

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

implementation

uses Math;

{ TQuantity }

{$IFDEF ADIMDEBUG}
class operator TQuantity.:=(const AValue: double): TQuantity;
begin
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := AValue;
end;

class operator TQuantity.+(const ASelf: TQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := ASelf.FValue;
end;

class operator TQuantity.-(const ASelf: TQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TQuantity.+(const ALeft, ARight: TQuantity): TQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.-(const ALeft, ARight: TQuantity): TQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.*(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity.*(const ALeft: double; const ARight: TQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := ARight.FUnitOfMeasurement;
  result.FValue:= ALeft * ARight.FValue;
end;

class operator TQuantity./(const ALeft: double; const ARight: TQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ScalarId, ARight.FUnitOfMeasurement];
  result.FValue:= ALeft / ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: double): TQuantity;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue:= ALeft.FValue * ARight;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: double): TQuantity;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue:= ALeft.FValue / ARight;
end;

class operator TQuantity.=(const ALeft, ARight: TQuantity): boolean; inline;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TQuantity.<(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('LessThan operator (<) has detected wrong unit of measurements.');

  result := ALeft.FValue < ARight.FValue;
end;

class operator TQuantity.>(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('GreaterThan operator (>) has detected wrong unit of measurements.');

  result := ALeft.FValue > ARight.FValue;
end;

class operator TQuantity.<=(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('LessThanOrEqual operator (<=) has detected wrong unit of measurements.');

  result := ALeft.FValue <= ARight.FValue;
end;

class operator TQuantity.>=(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('GreaterThanOrEqual operator (>=) has detected wrong unit of measurements.');

  result := ALeft.FValue >= ARight.FValue;
end;

class operator TQuantity.<>(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;
{$ENDIF}

// TMultivecQuantity

{$IFDEF ADIMDEBUG}
class operator TMultivecQuantity.:=(const AValue: TQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TMultivecQuantity.<>(const ALeft, ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TMultivecQuantity.<>(const ALeft: TMultivecQuantity; const ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TMultivecQuantity.<>(const ALeft: TQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TMultivecQuantity.=(const ALeft: TMultivecQuantity; const ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TMultivecQuantity.=(const ALeft: TQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TMultivecQuantity.=(const ALeft, ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TMultivecQuantity.+(const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;

  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');
end;

class operator TMultivecQuantity.+(const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;

  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');
end;

class operator TMultivecQuantity.+(const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;

  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');
end;

class operator TMultivecQuantity.-(const ASelf: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TMultivecQuantity.-(const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TMultivecQuantity.-(const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TMultivecQuantity.-(const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TMultivecQuantity.*(const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TMultivecQuantity.*(const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TMultivecQuantity.*(const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TMultivecQuantity./(const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TMultivecQuantity./(const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TMultivecQuantity./(const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TTrivecQuantity

{$IFDEF ADIMDEBUG}

class operator TTrivecQuantity.:=(const AValue: TTrivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TTrivecQuantity.<>(const ALeft, ARight: TTrivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TTrivecQuantity.<>(const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TTrivecQuantity.<>(const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TTrivecQuantity.=(const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TTrivecQuantity.=(const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TTrivecQuantity.=(const ALeft, ARight: TTrivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TTrivecQuantity.+(const ALeft, ARight: TTrivecQuantity): TTrivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivecQuantity.+(const ALeft: TTrivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivecQuantity.+(const ALeft: TQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivecQuantity.+(const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivecQuantity.+(const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivecQuantity.-(const ASelf: TTrivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TTrivecQuantity.-(const ALeft, ARight: TTrivecQuantity): TTrivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivecQuantity.-(const ALeft: TTrivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivecQuantity.-(const ALeft: TQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivecQuantity.-(const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivecQuantity.-(const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivecQuantity.*(const ALeft: TQuantity; const ARight: TTrivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivecQuantity.*(const ALeft: TTrivecQuantity; const ARight: TQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivecQuantity.*(const ALeft, ARight: TTrivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivecQuantity.*(const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivecQuantity.*(const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivecQuantity./(const ALeft, ARight: TTrivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TTrivecQuantity./(const ALeft: TTrivecQuantity; const ARight: TQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TTrivecQuantity./(const ALeft: TQuantity; const ARight: TTrivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TTrivecQuantity./(const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TTrivecQuantity./(const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TBivecQuantity

{$IFDEF ADIMDEBUG}
class operator TBivecQuantity.:=(const AValue: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TBivecQuantity.<>(const ALeft, ARight: TBivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TBivecQuantity.<>(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TBivecQuantity.<>(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TBivecQuantity.=(const ALeft, ARight: TBivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TBivecQuantity.=(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TBivecQuantity.=(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft, ARight: TBivecQuantity): TBivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TBivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.-(const ASelf: TBivecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TBivecQuantity.-(const ALeft, ARight: TBivecQuantity): TBivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TBivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TQuantity; const ARight: TBivecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TBivecQuantity; const ARight: TQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft, ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity./(const ALeft, ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TBivecQuantity; const ARight: TQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TBivecQuantity./(const ALeft: TQuantity; const ARight: TBivecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TVecQuantity

{$IFDEF ADIMDEBUG}
class operator TVecQuantity.:=(const AValue: TVecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := AValue.FUnitOfMeasurement;
  result.FValue := AValue.FValue;
end;

class operator TVecQuantity.<>(const ALeft, ARight: TVecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVecQuantity.<>(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVecQuantity.<>(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVecQuantity.=(const ALeft, ARight: TVecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVecQuantity.=(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TVecQuantity.=(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft, ARight: TVecQuantity): TVecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TVecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.-(const ASelf: TVecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TVecQuantity.-(const ALeft, ARight: TVecQuantity): TVecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TVecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TQuantity; const ARight: TVecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TVecQuantity; const ARight: TQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft, ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity./(const ALeft, ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./ (const ALeft: TVecQuantity; const ARight: TQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TVecQuantity./(const ALeft: TQuantity; const ARight: TVecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TMultivecQuantityHelper

{$IFDEF ADIMDEBUG}
function TMultivecQuantityHelper.Dual: TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Dual;
end;

function TMultivecQuantityHelper.Inverse: TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Inverse;
end;

function TMultivecQuantityHelper.Reverse: TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reverse;
end;

function TMultivecQuantityHelper.Conjugate: TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Conjugate;
end;

function TMultivecQuantityHelper.Reciprocal: TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ScalarId, FUnitOfMeasurement];
  result.FValue := FValue.Reciprocal;
end;

function TMultivecQuantityHelper.LeftReciprocal: TMultivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ScalarId, FUnitOfMeasurement];
  result.FValue := FValue.LeftReciprocal;
end;

function TMultivecQuantityHelper.Normalized: TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Normalized;
end;

function TMultivecQuantityHelper.Norm: TQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Norm;
end;

function TMultivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := FValue.SquaredNorm;
end;

function TMultivecQuantityHelper.Dot(const AVector: TVecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivecQuantityHelper.Dot(const AVector: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivecQuantityHelper.Dot(const AVector: TTrivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivecQuantityHelper.Dot(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivecQuantityHelper.Wedge(const AVector: TVecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivecQuantityHelper.Wedge(const AVector: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivecQuantityHelper.Wedge(const AVector: TTrivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivecQuantityHelper.Wedge(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivecQuantityHelper.Projection(const AVector: TVecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TMultivecQuantityHelper.Projection(const AVector: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TMultivecQuantityHelper.Projection(const AVector: TTrivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TMultivecQuantityHelper.Projection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TMultivecQuantityHelper.Rejection(const AVector: TVecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TMultivecQuantityHelper.Rejection(const AVector: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TMultivecQuantityHelper.Rejection(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TMultivecQuantityHelper.Rejection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TMultivecQuantityHelper.Reflection(const AVector: TVecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TMultivecQuantityHelper.Reflection(const AVector: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TMultivecQuantityHelper.Reflection(const AVector: TTrivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TMultivecQuantityHelper.Reflection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TMultivecQuantityHelper.Rotation(const AVector1, AVector2: TVecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TMultivecQuantityHelper.Rotation(const AVector1, AVector2: TBivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TMultivecQuantityHelper.Rotation(const AVector1, AVector2: TTrivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TMultivecQuantityHelper.Rotation(const AVector1, AVector2: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TMultivecQuantityHelper.SameValue(const AVector: TMultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TMultivecQuantityHelper.SameValue(const AVector: TTrivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TMultivecQuantityHelper.SameValue(const AVector: TBivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TMultivecQuantityHelper.SameValue(const AVector: TVecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TMultivecQuantityHelper.SameValue(const AVector: TQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TMultivecQuantityHelper.ExtractMultivector(AComponents: TMultivectorComponents): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractMultivector(AComponents);
end;

function TMultivecQuantityHelper.ExtractBivector(AComponents: TMultivectorComponents): TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractBivector(AComponents);
end;

function TMultivecQuantityHelper.ExtractVector(AComponents: TMultivectorComponents): TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractVector(AComponents);
end;

function TMultivecQuantityHelper.ExtractTrivector: TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractTrivector;
end;

function TMultivecQuantityHelper.ExtractBivector: TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractBivector;
end;

function TMultivecQuantityHelper.ExtractVector: TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractVector;
end;

function TMultivecQuantityHelper.ExtractScalar: TQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractScalar;
end;

function TMultivecQuantityHelper.IsNull: boolean;
begin
  result := FValue.SameValue(NullMultivector);
end;

function TMultivecQuantityHelper.IsScalar: boolean;
begin
  result := FValue.IsScalar;
end;

function TMultivecQuantityHelper.IsVector: boolean;
begin
  result := FValue.IsVector;
end;

function TMultivecQuantityHelper.IsBiVector: boolean;
begin
  result := FValue.IsBiVector;
end;

function TMultivecQuantityHelper.IsTrivector: boolean;
begin
  result := FValue.IsTrivector;
end;

function TMultivecQuantityHelper.IsA: string;
begin
  result := FValue.IsA;
end;
{$ENDIF}

// TTrivecQuantityHelper

{$IFDEF ADIMDEBUG}
function TTrivecQuantityHelper.Dual: TQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Dual;
end;

function TTrivecQuantityHelper.Inverse: TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Inverse;
end;

function TTrivecQuantityHelper.Reverse: TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reverse;
end;

function TTrivecQuantityHelper.Conjugate: TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Conjugate;
end;

function TTrivecQuantityHelper.Reciprocal: TTrivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ScalarId, FUnitOfMeasurement];
  result.FValue := FValue.Reciprocal;
end;

function TTrivecQuantityHelper.Normalized: TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Normalized;
end;

function TTrivecQuantityHelper.Norm: TQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Norm;
end;

function TTrivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := FValue.SquaredNorm;
end;

function TTrivecQuantityHelper.Dot(const AVector: TVecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TTrivecQuantityHelper.Dot(const AVector: TBivecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TTrivecQuantityHelper.Dot(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TTrivecQuantityHelper.Dot(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TTrivecQuantityHelper.Wedge(const AVector: TVecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TTrivecQuantityHelper.Wedge(const AVector: TBivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TTrivecQuantityHelper.Wedge(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TTrivecQuantityHelper.Wedge(const AVector: TMultivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TTrivecQuantityHelper.Projection(const AVector: TVecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TTrivecQuantityHelper.Projection(const AVector: TBivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TTrivecQuantityHelper.Projection(const AVector: TTrivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TTrivecQuantityHelper.Projection(const AVector: TMultivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TTrivecQuantityHelper.Rejection(const AVector: TVecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TTrivecQuantityHelper.Rejection(const AVector: TBivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TTrivecQuantityHelper.Rejection(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TTrivecQuantityHelper.Rejection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TTrivecQuantityHelper.Reflection(const AVector: TVecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TTrivecQuantityHelper.Reflection(const AVector: TBivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TTrivecQuantityHelper.Reflection(const AVector: TTrivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TTrivecQuantityHelper.Reflection(const AVector: TMultivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TTrivecQuantityHelper.Rotation(const AVector1, AVector2: TVecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TTrivecQuantityHelper.Rotation(const AVector1, AVector2: TBivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TTrivecQuantityHelper.Rotation(const AVector1, AVector2: TTrivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TTrivecQuantityHelper.Rotation(const AVector1, AVector2: TMultivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TTrivecQuantityHelper.SameValue(const AVector: TMultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TTrivecQuantityHelper.SameValue(const AVector: TTrivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TTrivecQuantityHelper.ToMultivector: TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TBivecQuantityHelper

{$IFDEF ADIMDEBUG}
function TBivecQuantityHelper.Dual: TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Dual;
end;

function TBivecQuantityHelper.Inverse: TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Inverse;
end;

function TBivecQuantityHelper.Conjugate: TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Conjugate;
end;

function TBivecQuantityHelper.Reverse: TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reverse;
end;

function TBivecQuantityHelper.Reciprocal: TBivecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ScalarId, FUnitOfMeasurement];
  result.FValue := FValue.Reciprocal;
end;

function TBivecQuantityHelper.Normalized: TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Normalized;
end;

function TBivecQuantityHelper.Norm: TQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Norm;
end;

function TBivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := FValue.SquaredNorm;
end;

function TBivecQuantityHelper.Dot(const AVector: TVecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivecQuantityHelper.Dot(const AVector: TBivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivecQuantityHelper.Dot(const AVector: TTrivecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivecQuantityHelper.Dot(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivecQuantityHelper.Wedge(const AVector: TVecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TBivecQuantityHelper.Wedge(const AVector: TBivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TBivecQuantityHelper.Wedge(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TBivecQuantityHelper.Wedge(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TBivecQuantityHelper.Projection(const AVector: TVecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TBivecQuantityHelper.Projection(const AVector: TBivecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TBivecQuantityHelper.Projection(const AVector: TTrivecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TBivecQuantityHelper.Projection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TBivecQuantityHelper.Rejection(const AVector: TVecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TBivecQuantityHelper.Rejection(const AVector: TBivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TBivecQuantityHelper.Rejection(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TBivecQuantityHelper.Rejection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TBivecQuantityHelper.Reflection(const AVector: TVecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TBivecQuantityHelper.Reflection(const AVector: TBivecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TBivecQuantityHelper.Reflection(const AVector: TTrivecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TBivecQuantityHelper.Reflection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TBivecQuantityHelper.Rotation(const AVector1, AVector2: TVecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TBivecQuantityHelper.Rotation(const AVector1, AVector2: TBivecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TBivecQuantityHelper.Rotation(const AVector1, AVector2: TTrivecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TBivecQuantityHelper.Rotation(const AVector1, AVector2: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TBivecQuantityHelper.SameValue(const AVector: TMultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TBivecQuantityHelper.SameValue(const AVector: TBivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TBivecQuantityHelper.ExtractBivector(AComponents: TMultivectorComponents): TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractBivector(AComponents);
end;

function TBivecQuantityHelper.ToMultivector: TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TVecQuantityHelper

{$IFDEF ADIMDEBUG}
function TVecQuantityHelper.Dual: TBivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Dual;
end;

function TVecQuantityHelper.Inverse: TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Inverse;
end;

function TVecQuantityHelper.Reverse: TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reverse;
end;

function TVecQuantityHelper.Conjugate: TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Conjugate;
end;

function TVecQuantityHelper.Reciprocal: TVecQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ScalarId, FUnitOfMeasurement];
  result.FValue := FValue.Reciprocal;
end;

function TVecQuantityHelper.Normalized: TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Normalized;
end;

function TVecQuantityHelper.Norm: TQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Norm;
end;

function TVecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := FValue.SquaredNorm;
end;

function TVecQuantityHelper.Dot(const AVector: TVecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVecQuantityHelper.Dot(const AVector: TBivecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVecQuantityHelper.Dot(const AVector: TTrivecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVecQuantityHelper.Dot(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVecQuantityHelper.Wedge(const AVector: TVecQuantity): TBivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TVecQuantityHelper.Wedge(const AVector: TBivecQuantity): TTrivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TVecQuantityHelper.Wedge(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, FUnitOfMeasurement];
  result.FValue := 0.0;
end;

function TVecQuantityHelper.Wedge(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TVecQuantityHelper.Projection(const AVector: TVecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TVecQuantityHelper.Projection(const AVector: TBivecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TVecQuantityHelper.Projection(const AVector: TTrivecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TVecQuantityHelper.Projection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TVecQuantityHelper.Rejection(const AVector: TVecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function  TVecQuantityHelper.Rejection(const AVector: TBivecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TVecQuantityHelper.Rejection(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := 0.0;
end;

function TVecQuantityHelper.Rejection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TVecQuantityHelper.Reflection(const AVector: TVecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TVecQuantityHelper.Reflection(const AVector: TBivecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TVecQuantityHelper.Reflection(const AVector: TTrivecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TVecQuantityHelper.Reflection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TVecQuantityHelper.Rotation(const AVector1, AVector2: TVecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TVecQuantityHelper.Rotation(const AVector1, AVector2: TBivecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TVecQuantityHelper.Rotation(const AVector1, AVector2: TTrivecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TVecQuantityHelper.Rotation(const AVector1, AVector2: TMultivecQuantity): TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TVecQuantityHelper.Cross(const AVector: TVecQuantity): TVecQuantity;
begin
  result.FUnitOfMeasurement := MulTable[FUnitOfMeasurement, AVector.FUnitOfMeasurement];
  result.FValue := FValue.Cross(AVector.FValue);
end;

function TVecQuantityHelper.SameValue(const AVector: TMultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TVecQuantityHelper.SameValue(const AVector: TVecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TVecQuantityHelper.ExtractVector(AComponents: TMultivectorComponents): TVecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ExtractVector(AComponents);
end;

function TVecQuantityHelper.ToMultivector: TMultivecQuantity;
begin
  result.FUnitOfMeasurement := FUnitOfMeasurement;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

{ TUnit }

class operator TUnit.*(const AQuantity: double; const ASelf: TUnit): TQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: double; const ASelf: TUnit): TQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: TVector; const ASelf: TUnit): TVecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: TVector; const ASelf: TUnit): TVecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: TBivector; const ASelf: TUnit): TBivecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: TBivector; const ASelf: TUnit): TBivecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: TTrivector; const ASelf: TUnit): TTrivecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: TTrivector; const ASelf: TUnit): TTrivecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const AQuantity: TMultivector; const ASelf: TUnit): TMultivecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: TMultivector; const ASelf: TUnit): TMultivecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

{$IFDEF ADIMDEBUG}
class operator TUnit.*(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TVecQuantity; const ASelf: TUnit): TVecQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TVecQuantity; const ASelf: TUnit): TVecQuantity; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TBivecQuantity; const ASelf: TUnit): TBivecQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TBivecQuantity; const ASelf: TUnit): TBivecQuantity; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TTrivecQuantity; const ASelf: TUnit): TTrivecQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TTrivecQuantity; const ASelf: TUnit): TTrivecQuantity; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TMultivecQuantity; const ASelf: TUnit): TMultivecQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TMultivecQuantity; const ASelf: TUnit): TMultivecQuantity; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

{$ENDIF}

{ TFactoredUnit }

class operator TFactoredUnit.*(const AQuantity: double; const ASelf: TFactoredUnit): TQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: double; const ASelf: TFactoredUnit): TQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TVector; const ASelf: TFactoredUnit): TVecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TVector; const ASelf: TFactoredUnit): TVecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TBivector; const ASelf: TFactoredUnit): TBivecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TBivector; const ASelf: TFactoredUnit): TBivecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TTrivector; const ASelf: TFactoredUnit): TTrivecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TTrivector; const ASelf: TFactoredUnit): TTrivecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TMultivector; const ASelf: TFactoredUnit): TMultivecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TMultivector; const ASelf: TFactoredUnit): TMultivecQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := DivTable[ScalarId, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

{$IFDEF ADIMDEBUG}
class operator TFactoredUnit.*(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TVecQuantity; const ASelf: TFactoredUnit): TVecQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TVecQuantity; const ASelf: TFactoredUnit): TVecQuantity; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TBivecQuantity; const ASelf: TFactoredUnit): TBivecQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TBivecQuantity; const ASelf: TFactoredUnit): TBivecQuantity; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TTrivecQuantity; const ASelf: TFactoredUnit): TTrivecQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TTrivecQuantity; const ASelf: TFactoredUnit): TTrivecQuantity; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TMultivecQuantity; const ASelf: TFactoredUnit): TMultivecQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TMultivecQuantity; const ASelf: TFactoredUnit): TMultivecQuantity; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, ASelf.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;
{$ENDIF}

{ TDegreeCelsiusUnit }

class operator TDegreeCelsiusUnit.*(const AQuantity: double; const ASelf: TDegreeCelsiusUnit): TQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := AQuantity + 273.15;
{$ELSE}
  result := AQuantity + 273.15;
{$ENDIF}
end;

{ TDegreeFahrenheitUnit }

class operator TDegreeFahrenheitUnit.*(const AQuantity: double; const ASelf: TDegreeFahrenheitUnit): TQuantity; inline;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := 5/9 * (AQuantity - 32) + 273.15;
{$ELSE}
  result := 5/9 * (AQuantity - 32) + 273.15;
{$ENDIF}
end;

{ TUnitHelper }

function TUnitHelper.GetName(const Prefixes: TPrefixes): string;
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

function TUnitHelper.GetPluralName(const Prefixes: TPrefixes): string;
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

function TUnitHelper.GetSymbol(const Prefixes: TPrefixes): string;
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

procedure TUnitHelper.Check(var AQuantity: TQuantity);
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(AQuantity.FValue) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TUnitHelper.ToVerboseString(const AQuantity: TVecQuantity): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TBivecQuantity): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TTrivecQuantity): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TMultivecQuantity): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TVecQuantity): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TBivecQuantity): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TTrivecQuantity): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TMultivecQuantity): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

{ TFactoredUnitHelper }

function TFactoredUnitHelper.GetName(const Prefixes: TPrefixes): string;
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

function TFactoredUnitHelper.GetPluralName(const Prefixes: TPrefixes): string;
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

function TFactoredUnitHelper.GetSymbol(const Prefixes: TPrefixes): string;
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

procedure TFactoredUnitHelper.Check(var AQuantity: TQuantity);
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TFactoredUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(AQuantity.FValue / FFactor) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity / FFactor) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TFactoredUnitHelper.ToString(const AQuantity: TVecQuantity): string;
var
  FactoredValue: TVector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TBivecQuantity): string;
var
  FactoredValue: TBivector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TTrivecQuantity): string;
var
  FactoredValue: TTrivector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TMultivecQuantity): string;
var
  FactoredValue: TMultivector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TVecQuantity): string;
var
  FactoredValue: TVector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TBivecQuantity): string;
var
  FactoredValue: TBivector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TTrivecQuantity): string;
var
  FactoredValue: TTrivector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TMultivecQuantity): string;
var
  FactoredValue: TMultivector;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetName(FPrefixes)
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

procedure TDegreeCelsiusUnitHelper.Check(var AQuantity: TQuantity);
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := AQuantity.FValue - 273.15;
{$ELSE}
  result := AQuantity - 273.15;
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  result := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(AQuantity.FValue - 273.15) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity - 273.15) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

procedure TDegreeFahrenheitUnitHelper.Check(var AQuantity: TQuantity);
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := 9/5 * AQuantity.FValue - 459.67;
{$ELSE}
  result := 9/5 * AQuantity - 459.67;
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  result := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(9/5 * AQuantity.FValue - 459.67) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(9/5 * AQuantity - 459.67) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement  <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  if (AQuantity.FUnitOfMeasurement <> FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> FUnitOfMeasurement) then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Square;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AQuantity.FValue, 2);
{$ELSE}
  result := IntPower(AQuantity, 2);
{$ENDIF}
end;

function CubicPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Cubic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AQuantity.FValue, 3);
{$ELSE}
  result := IntPower(AQuantity, 3);
{$ENDIF}
end;

function QuarticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Quartic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AQuantity.FValue, 4);
{$ELSE}
  result := IntPower(AQuantity, 4);
{$ENDIF}
end;

function QuinticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Quintic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AQuantity.FValue, 5);
{$ELSE}
  result := IntPower(AQuantity, 5);
{$ENDIF}
end;

function SexticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Sextic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
   result.FValue := IntPower(AQuantity.FValue, 6);
{$ELSE}
  result := IntPower(AQuantity, 6);
{$ENDIF}
end;

function SquareRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Square;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/2);
{$ELSE};
  result := Power(AQuantity, 1/2);
{$ENDIF}
end;

function CubicRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Cubic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/3);
{$ELSE}
  result := Power(AQuantity, 1/3);
{$ENDIF}
end;

function QuarticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Quartic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/4);
{$ELSE}
  result := Power(AQuantity, 1/4);
{$ENDIF}
end;

function QuinticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Quintic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/5);
{$ELSE}
  result := Power(AQuantity, 1/5);
{$ENDIF}
end;

function SexticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Sextic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/6);
{$ELSE}
  result := Power(AQuantity, 1/6);
{$ENDIF}
end;

{ Trigonometric functions }

function Cos(const AQuantity: TQuantity): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Cos routine has detected wrong units of measurements.');

  result := System.Cos(AQuantity.FValue);
{$ELSE}
  result := System.Cos(AQuantity);
{$ENDIF}
end;

function Sin(const AQuantity: TQuantity): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Sin routine has detected wrong units of measurements.');

  result := System.Sin(AQuantity.FValue);
{$ELSE}
  result := System.Sin(AQuantity);
{$ENDIF}
end;

function Tan(const AQuantity: TQuantity): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Tan routine has detected wrong units of measurements.');

  result := Math.Tan(AQuantity.FValue);
{$ELSE}
  result := Math.Tan(AQuantity);
{$ENDIF}
end;

function Cotan(const AQuantity: TQuantity): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Cotan routine has detected wrong units of measurements.');

  result := Math.Cotan(AQuantity.FValue);
{$ELSE}
  result := Math.Cotan(AQuantity);
{$ENDIF}
end;

function Secant(const AQuantity: TQuantity): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Setan routine has detected wrong units of measurements.');

  result := Math.Secant(AQuantity.FValue);
{$ELSE}
  result := Math.Secant(AQuantity);
{$ENDIF}
end;

function Cosecant(const AQuantity: TQuantity): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Cosecant routine has detected wrong units of measurements.');

  result := Math.Cosecant(AQuantity.FValue);
{$ELSE}
  result := Math.Cosecant(AQuantity);
{$ENDIF}
end;

function ArcCos(const AValue: double): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := Math.ArcCos(AValue);
{$ELSE}
  result := Math.ArcCos(AValue);
{$ENDIF}
end;

function ArcSin(const AValue: double): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := Math.ArcSin(AValue);
{$ELSE}
  result := Math.ArcSin(AValue);
{$ENDIF}
end;

function ArcTan(const AValue: double): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := System.ArcTan(AValue);
{$ELSE}
  result := System.ArcTan(AValue);
{$ENDIF}
end;

function ArcTan2(const x, y: double): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  result.FUnitOfMeasurement := ScalarId;
  result.FValue := Math.ArcTan2(x, y);
{$ELSE}
  result := Math.ArcTan2(x, y);
{$ENDIF}
end;

{ Math functions }

function Min(const ALeft, ARight: TQuantity): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Min routine has detected wrong units of measurements.');

  result.FUnitOfMeasurement := ARight.FUnitOfMeasurement;
  result.FValue := Math.Min(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.Min(ALeft, ARight);
{$ENDIF}
end;

function Max(const ALeft, ARight: TQuantity): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Max routine has detected wrong units of measurements.');

  result.FUnitOfMeasurement := ARight.FUnitOfMeasurement;
  result.FValue := Math.Max(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.Max(ALeft, ARight);
{$ENDIF}
end;

function Exp(const AQuantity: TQuantity): TQuantity;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Exp routine has detected wrong units of measurements.');

  result.FUnitOfMeasurement := ScalarId;
  result.FValue := System.Exp(AQuantity.FValue);
{$ELSE}
  result := System.Exp(AQuantity);
{$ENDIF}
end;

function Log10(const AQuantity : TQuantity) : double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Log10 routine has detected wrong units of measurements.');

  result := Math.Log10(AQuantity.FValue);
{$ELSE}
  result := Math.Log10(AQuantity);
{$ENDIF}
end;

function Log2(const AQuantity : TQuantity) : double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Log2 routine has detected wrong units of measurements.');

  result := Math.Log2(AQuantity.FValue);
{$ELSE}
  result := Math.Log2(AQuantity);
{$ENDIF}
end;

function LogN(ABase: longint; const AQuantity: TQuantity): double;
begin
{$IFDEF ADIMDEBUG}
  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  result := Math.LogN(ABase, AQuantity.FValue);
{$ELSE}
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function LogN(const ABase, AQuantity: TQuantity): double;
begin
{$IFDEF ADIMDEBUG}
  if ABase.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  if AQuantity.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  result := Math.LogN(ABase.FValue, AQuantity.FValue);
{$ELSE}
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function Power(const ABase: TQuantity; AExponent: double): double;
begin
{$IFDEF ADIMDEBUG}
  if ABase.FUnitOfMeasurement <> ScalarId then
    raise Exception.Create('Power routine has detected wrong units of measurements.');

   result := Math.Power(ABase.FValue, AExponent);
{$ELSE}
  result := Math.Power(ABase, AExponent);
{$ENDIF}
end;

{ Helper functions }

function LessThanOrEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue <= 0;
{$ELSE}
  result := AQuantity <= 0;
{$ENDIF}
end;

function LessThanZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue < 0;
{$ELSE}
  result := AQuantity < 0;
{$ENDIF}
end;

function EqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue = 0;
{$ELSE}
  result := AQuantity = 0;
{$ENDIF}
end;

function NotEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue <> 0;
{$ELSE}
  result := AQuantity <> 0;
{$ENDIF}
end;

function GreaterThanOrEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue >= 0;
{$ELSE}
  result := AQuantity >= 0;
{$ENDIF}
end;

function GreaterThanZero(const AQuantity: TQuantity): boolean;
begin
{$IFDEF ADIMDEBUG}
  result := AQuantity.FValue > 0;
{$ELSE}
  result := AQuantity > 0;
{$ENDIF}
end;

function SameValue(const ALeft, ARight: TQuantity): boolean;
begin
{$IFDEF ADIMDEBUG}
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('SameValue routine has detected wrong units of measurements.');

  result := Math.SameValue(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.SameValue(ALeft, ARight);
{$ENDIF}
end;

end.
