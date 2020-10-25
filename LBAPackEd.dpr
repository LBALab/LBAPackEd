//******************************************************************************
// LBA Package Editor - editing hqr, ile, obl, vox packages from
//                      Little Big Adventure 1 & 2
//
// This is main program file.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
//
// This source code is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This source code is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License (License.txt) for more details.
//******************************************************************************

program LBAPackEd;

uses
  Forms,
  ExtCtrls,
  Windows,
  Controls,
  SysUtils,
  LBAPackEd1 in 'LBAPackEd1.pas' {Form1},
  About in 'About.pas' {Form2},
  files in 'files.pas',
  Settings in 'Settings.pas' {fSettings},
  DePack in 'DePack.pas',
  ExtractDlg in 'ExtractDlg.pas' {fExtract},
  Info in 'Info.pas',
  Tools in 'Tools.pas' {ToolsForm},
  Dialog in 'Dialog.pas' {DialogForm},
  ProgBar in 'ProgBar.pas' {ProgBarForm},
  CompMods in '..\libs\CompMods.pas',
  Hint in 'Hint.pas' {HintForm};

{$R Icons.res}
{$R *.res}

begin
  Application.Initialize;  
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TToolsForm, ToolsForm);
  Application.CreateForm(TDialogForm, DialogForm);
  Application.CreateForm(TProgBarForm, ProgBarForm);
  Application.HintHidePause:=60000;
  Application.ShowHint:=True;
  //Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TfSettings, fSettings);
  Application.CreateForm(TfExtract, fExtract);
  LoadSettings;

  RefreshDirs;
  //SetAssociations; //it caused problems on Vista

  if ParamCount=0 then begin
   try
    If fSettings.cbOpenLast.Checked and (LastProjectPath<>'') then
     OpenProject(LastProjectPath);
   except
   end;
  end
  else
   try
    OpenParam(ParamStr(1));
   except
   end;

  UpdateComponents; 
  Application.Run;
end.
