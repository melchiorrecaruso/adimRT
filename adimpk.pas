{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit adimpk;

{$warn 5023 off : no warning about unused units}
interface

uses
  ADim, ADimC, ADimCL3, ADimVEC, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('adimpk', @Register);
end.
