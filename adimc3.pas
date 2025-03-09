unit adimc3;

{$mode ObjFPC}{$H+}

interface

uses
  ADim;

const
  NullComplex: TComplex = (FRe: 0; fIm: 0);

  NullC2Matrix : TC2Matrix =
    (fm11: (fRe: 0; fIm:0); fm12: (fRe: 0; fIm:0);
     fm21: (fRe: 0; fIm:0); fm22: (fRe: 0; fIm:0));
  NullC3Matrix : TC3Matrix =
    (fm11: (fRe: 0; fIm:0); fm12: (fRe: 0; fIm:0); fm13: (fRe: 0; fIm:0);
     fm21: (fRe: 0; fIm:0); fm22: (fRe: 0; fIm:0); fm23: (fRe: 0; fIm:0);
     fm31: (fRe: 0; fIm:0); fm32: (fRe: 0; fIm:0); fm33: (fRe: 0; fIm:0));

var
  img: TImaginaryUnit;

implementation


end.

