[Setup]
AppName=ReverseWordsApp
AppVersion=1.0
DefaultDirName={pf}\ReverseWordsApp
DefaultGroupName=Reverse Words App
UninstallDisplayIcon={app}\main.exe
OutputDir=Output
OutputBaseFilename=ReverseWordsSetup
Compression=lzma2
SolidCompression=yes
SetupIconFile=icon.ico
WizardStyle=modern

[Files]
Source: "dist\main.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "icon.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "python-installer.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Icons]
Name: "{group}\Reverse Words App"; Filename: "{app}\main.exe"; WorkingDir: "{app}"
Name: "{commondesktop}\Reverse Words App"; Filename: "{app}\main.exe"; WorkingDir: "{app}"

[Run]
Filename: "{app}\main.exe"; Description: "Launch Reverse Words App"; Flags: postinstall nowait shellexec runhidden skipifsilent

Filename: "{tmp}\python-installer.exe"; Parameters: "/quiet InstallAllUsers=1 PrependPath=1"; Description: "Installing"; Flags: runhidden waituntilterminated skipifdoesntexist; StatusMsg: "Almost there batata..."


[UninstallRun]

[Code]
function IsPythonInstalled(): Boolean;
var
  ExitCode: Integer;
begin
  Exec(ExpandConstant('{cmd}'), '/c python --version', '', SW_HIDE, ewWaitUntilTerminated, ExitCode);
    Result := (ExitCode = 0);
end;
procedure InitializeWizard();
var
  ErrorCode: Integer;
begin
  if not IsPythonInstalled() then
  begin
    if MsgBox('This application requires Python. Would you like to install Python now? check add to path when u are installing python', mbConfirmation, MB_YESNO) = IDYES then
    begin
      if not ShellExec('', ExpandConstant('{tmp}\python-installer.exe'), '/quiet InstallAllUsers=1 PrependPath=1', '', SW_SHOW, ewNoWait, ErrorCode) then
      begin
        MsgBox('Failed to launch Python installer: ' + SysErrorMessage(ErrorCode), mbError, MB_OK);
      end;
    end
    else
    begin
      MsgBox('Python is required to run this application. The installation will now exit.', mbError, MB_OK);
      WizardForm.Close;
    end;
  end;
end;
