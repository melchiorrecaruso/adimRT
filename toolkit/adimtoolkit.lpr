{
  Description: ADimPas project.

  Copyright (C) 2023-2025 Melchiorre Caruso <melchiorrecaruso@gmail.com>

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

program adimtoolkit;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Classes,
  SysUtils,
  ToolKitUnit
  {$IFNDEF TOOLKIT_CLI},
  Interfaces,
  Forms,
  MainFrm,
  InsertForm, Common
  {$ENDIF};

{$IFNDEF TOOLKIT_CLI}
{$R *.res}
{$ENDIF}

const
  ExitGenerationError = 1;
  ExitInvalidArguments = 2;

procedure WriteUsage;
begin
  WriteLn('ADimPas Toolkit command-line generator');
  WriteLn('');
  WriteLn('Usage:');
  WriteLn('  adimtoolkit --generate [--input <skeleton.csv>] [--output-dir <directory>]');
  WriteLn('  adimtoolkit --help');
  WriteLn('');
  WriteLn('Defaults:');
  WriteLn('  input       = skeleton.csv in the current directory');
  WriteLn('  output-dir  = the directory containing the input CSV file');
  WriteLn('');
  WriteLn('The input directory must also contain skeleton.pas and skeletonres.pas.');
  WriteLn('The generated files are adim.pas and adimres.pas.');
end;

function ReadOptionValue(var AIndex: integer; const AOption: string): string;
begin
  if AIndex >= ParamCount then
    raise EArgumentException.CreateFmt('Missing value for %s.', [AOption]);
  Inc(AIndex);
  result := ParamStr(AIndex);
end;

procedure GenerateUnits;
var
  LIndex: integer;
  LInputFile: string;
  LInputDirectory: string;
  LOutputDirectory: string;
  LBuilder: TToolKitBuilder;
  LList: TToolKitList;
begin
  LInputFile := ExpandFileName('skeleton.csv');
  LOutputDirectory := '';

  LIndex := 2;
  while LIndex <= ParamCount do
  begin
    if CompareText(ParamStr(LIndex), '--input') = 0 then
      LInputFile := ExpandFileName(ReadOptionValue(LIndex, '--input'))
    else if CompareText(ParamStr(LIndex), '--output-dir') = 0 then
      LOutputDirectory := ExpandFileName(ReadOptionValue(LIndex, '--output-dir'))
    else
      raise EArgumentException.CreateFmt('Unknown option: %s.', [ParamStr(LIndex)]);
    Inc(LIndex);
  end;

  if not FileExists(LInputFile) then
    raise EFOpenError.CreateFmt('Input CSV file not found: %s', [LInputFile]);

  LInputDirectory := ExtractFileDir(LInputFile);
  if LOutputDirectory = '' then
    LOutputDirectory := LInputDirectory;

  if not FileExists(IncludeTrailingPathDelimiter(LInputDirectory) + 'skeleton.pas') then
    raise EFOpenError.CreateFmt('Template file not found: %s',
      [IncludeTrailingPathDelimiter(LInputDirectory) + 'skeleton.pas']);
  if not FileExists(IncludeTrailingPathDelimiter(LInputDirectory) + 'skeletonres.pas') then
    raise EFOpenError.CreateFmt('Resource template not found: %s',
      [IncludeTrailingPathDelimiter(LInputDirectory) + 'skeletonres.pas']);

  if not DirectoryExists(LOutputDirectory) then
    if not ForceDirectories(LOutputDirectory) then
      raise EFCreateError.CreateFmt('Cannot create output directory: %s',
        [LOutputDirectory]);

  LList := TToolKitList.Create;
  try
    LList.LoadFromFile(LInputFile);
    LBuilder := TToolKitBuilder.Create(LList,
      IncludeTrailingPathDelimiter(LInputDirectory) + 'skeleton.pas',
      IncludeTrailingPathDelimiter(LInputDirectory) + 'skeletonres.pas');
    try
      LBuilder.Build;

      LBuilder.Document.SaveToFile(
        IncludeTrailingPathDelimiter(LOutputDirectory) + 'adim.pas');
      LBuilder.Resources.SaveToFile(
        IncludeTrailingPathDelimiter(LOutputDirectory) + 'adimres.pas');
    finally
      LBuilder.Free;
    end;
  finally
    LList.Free;
  end;

  WriteLn('Generated ', IncludeTrailingPathDelimiter(LOutputDirectory) + 'adim.pas');
  WriteLn('Generated ', IncludeTrailingPathDelimiter(LOutputDirectory) + 'adimres.pas');
end;

function HandleCommandLine: boolean;
begin
  result := ParamCount > 0;
  if not result then Exit;

  if (CompareText(ParamStr(1), '--help') = 0) or
     (CompareText(ParamStr(1), '-h') = 0) then
  begin
    WriteUsage;
    Exit;
  end;

  if CompareText(ParamStr(1), '--generate') = 0 then
  begin
    GenerateUnits;
    Exit;
  end;

  {$IFNDEF TOOLKIT_CLI}
  result := False;
  {$ELSE}
  raise EArgumentException.CreateFmt('Unknown command: %s.', [ParamStr(1)]);
  {$ENDIF}
end;

begin
  Randomize;
  DefaultFormatSettings.DecimalSeparator  := '.';
  DefaultFormatSettings.ThousandSeparator := ',';

  try
    if HandleCommandLine then Halt(0);
    {$IFDEF TOOLKIT_CLI}
    WriteUsage;
    Halt(ExitInvalidArguments);
    {$ENDIF}
  except
    on E: EArgumentException do
    begin
      WriteLn(StdErr, 'Error: ', E.Message);
      WriteLn(StdErr, 'Use --help to show command-line usage.');
      Halt(ExitInvalidArguments);
    end;
    on E: Exception do
    begin
      WriteLn(StdErr, 'Error: ', E.Message);
      Halt(ExitGenerationError);
    end;
  end;

  {$IFNDEF TOOLKIT_CLI}
  RequireDerivedFormResource:=True;
  Application.Title:='ADimPas Toolkit';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInsertFrm, InsertFrm);
  Application.Run;
  {$ENDIF}
end.

