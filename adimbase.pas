unit ADimBase;

{
  Description: ADimBase unit.

  Copyright (C) 2025 Melchiorre Caruso <melchiorrecaruso@gmail.com>

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
}

{$H+}{$J-}
{$modeswitch advancedrecords}

interface

type
  TComplex = record
  private
    FRe, FIm: double;
  public
    function Re: double;
    function Im: double;
    function Dual: TComplex;
    function Reciprocal: TComplex;
    function Norm: double;
    function SquaredNorm: double;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;

    class operator :=(const AValue: double): TComplex; inline;
    class operator +(const AValue: TComplex): TComplex; inline;
    class operator +(const ALeft, ARight: TComplex): TComplex; inline;

    class operator -(const AValue: TComplex): TComplex; inline;
    class operator -(const ALeft, ARight: TComplex): TComplex; inline;

    class operator *(const ALeft, ARight: TComplex): TComplex; inline;
    class operator *(const ALeft: double; const ARight: TComplex): TComplex; inline;
    class operator *(const ALeft: TComplex; const ARight: double): TComplex; inline;

    class operator /(const ALeft, ARight: TComplex): TComplex; inline;
    class operator /(const ALeft: double; const ARight: TComplex): TComplex; inline;
    class operator /(const ALeft: TComplex; const ARight: double): TComplex; inline;

    class operator =(const ALeft, ARight: TComplex): boolean; inline;
    class operator <>(const ALeft, ARight: TComplex): boolean; inline;
  end;

  TImaginaryUnit = record
    class operator *(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
  end;


type
  TVector = record
  private
    Fm1,
    Fm2,
    Fm3: double;
  public

  end;

  TVersor1 = record
  public
    class operator *(const ALeft: double; const ARight: TVersor1): TVector;
  end;

  TVersor2 = record
  public
    class operator *(const ALeft: double; const ARight: TVersor2): TVector;
  end;

  TVersor3 = record
  public
    class operator *(const ALeft: double; const ARight: TVersor3): TVector;
  end;


var
  Img: TImaginaryUnit;


implementation

uses
  Math, SysUtils;

function TComplex.Re: double;
begin
  result := FRe;
end;

function TComplex.Im: double;
begin
  result := FIm;
end;

function TComplex.Dual: TComplex;
begin
  result.FRe :=  FRe;
  result.FIm := -FIm;
end;

function TComplex.Reciprocal: TComplex;
begin
  result := Self / SquaredNorm;
end;

function TComplex.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TComplex.SquaredNorm: double;
begin
  result := sqr(FRe) + sqr(FIm);
end;

function TComplex.ToString: string;
begin
  if FIm < 0.0 then
    result := Format('%s -i%s', [FloatToStr(FRe), FloatToStr(FIm)])
  else
    result := Format('%s +i%s', [FloatToStr(FRe), FloatToStr(FIm)]);
end;

function TComplex.ToString(APrecision, ADigits: integer): string;
begin
  if FIm < 0.0 then
    result := Format('%s -i%s', [
      FloatToStrF(FRe, ffGeneral, APrecision, ADigits) ,
      FloatToStrF(FIm, ffGeneral, APrecision, ADigits)])
  else
    result := Format('%s +i%s', [
      FloatToStrF(FRe, ffGeneral, APrecision, ADigits) ,
      FloatToStrF(FIm, ffGeneral, APrecision, ADigits)])
end;

class operator TComplex.:= (const AValue: double): TComplex;
begin
  result.FRe := AValue;
  result.FIm := 0;
end;

class operator TComplex.+(const AValue: TComplex): TComplex;
begin
  result.FRe := AValue.FRe;
  result.FIm := AValue.FIm;
end;

class operator TComplex.-(const AValue: TComplex): TComplex;
begin
  result.FRe := -AValue.FRe;
  result.FIm := -AValue.FIm;
end;

class operator TComplex.+(const ALeft, ARight: TComplex): TComplex;
begin
  result.FRe := ALeft.FRe + ARight.FRe;
  result.FIm := ALeft.FIm + ARight.FIm; 
end;

class operator TComplex.-(const ALeft, ARight: TComplex): TComplex;
begin
  result.FRe := ALeft.FRe - ARight.FRe;
  result.FIm := ALeft.FIm - ARight.FIm;
end;

class operator TComplex.*(const ALeft, ARight: TComplex): TComplex;
begin
  result.FRe := ALeft.FRe * ARight.FRe - ALeft.FIm * ARight.FIm;
  result.FIm := ALeft.FRe * ARight.FIm + ALeft.FIm * ARight.FRe;
end;

class operator TComplex.*(const ALeft: double; const ARight: TComplex): TComplex; inline;
begin
  result.FRe := ALeft * ARight.FRe;
  result.FIm := ALeft * ARight.FIm;
end;

class operator TComplex.*(const ALeft: TComplex; const ARight: double): TComplex; inline;
begin
  result.FRe := ALeft.FRe / ARight;
  result.FIm := ALeft.FIm / ARight;
end;

class operator TComplex./(const ALeft, ARight: TComplex): TComplex;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TComplex./(const ALeft: double; const ARight: TComplex): TComplex; inline;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TComplex./(const ALeft: TComplex; const ARight: double): TComplex; inline;
begin
  result.FRe := ALeft.FRe / ARight;
  result.FIm := ALeft.FIm / ARight;
end;

class operator TComplex.=(const ALeft, ARight: TComplex): boolean;
begin
  result := SameValue(ALeft.FRe, ARight.FRe) and 
            SameValue(ALeft.FIm, ARight.FIm);
end;

class operator TComplex.<>(const ALeft, ARight: TComplex): boolean;
begin
  result := (not SameValue(ALeft.FRe, ARight.FRe)) or 
            (not SameValue(ALeft.FIm, ARight.FIm));
end;

class operator TImaginaryUnit.*(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
begin
  result.FRe := 0;
  result.FIm := ALeft;
end;

class operator TVersor1.*(const ALeft: double; const ARight: TVersor1): TVector;
begin
  result.Fm1 := ALeft;
  result.Fm2 := 0;
  result.Fm3 := 0;
end;

class operator TVersor2.*(const ALeft: double; const ARight: TVersor2): TVector;
begin
  result.Fm1 := 0;
  result.Fm2 := ALeft;
  result.Fm3 := 0;
end;

class operator TVersor3.*(const ALeft: double; const ARight: TVersor3): TVector;
begin
  result.Fm1 := 0;
  result.Fm2 := 0;
  result.Fm3 := ALeft;
end;

end.
