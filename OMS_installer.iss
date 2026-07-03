; Inno Setup Script — Hospital OMS Installer
; Created by Karim Abdelaziz — 00201029927276
; Build with Inno Setup (https://jrsoftware.org/isinfo.php)

#define MyAppName "Obstetrics Management System — Hospital"
#define MyAppVersion "2.0.0"
#define MyAppPublisher "Karim Abdelaziz"
#define MyAppURL "https://github.com/karimali900/healthcare"
#define MyAppExeName "OMS.exe"
#define MyAppAssocName "OMS Database"
#define MyAppAssocExt ".db"

[Setup]
AppId={{E7F1B2C3-4D5E-6F7A-8B9C-0D1E2F3A4B5C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
DefaultDirName={autopf}\OMS Hospital
DefaultGroupName="OMS Hospital"
DisableProgramGroupPage=yes
OutputDir=installer
OutputBaseFilename=OMS_Hospital_Setup_v{#MyAppVersion}
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
SetupIconFile=data\logos\default.jpg
UninstallDisplayIcon={app}\OMS.exe

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "arabic"; MessagesFile: "compiler:Languages\Arabic.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop shortcut"; GroupDescription: "Additional icons:"

[Files]
Source: "dist\OMS.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "start.bat"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"
Name: "{autoprograms}\OMS Hospital\Data Folder"; Filename: "{app}\data"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; WorkingDir: "{app}"

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch {#MyAppName}"; Flags: nowait postinstall skipifsilent

[UninstallRun]
Filename: "{cmd}"; Parameters: "/c taskkill /IM OMS.exe /F /T"; Flags: runhidden

[Code]
function InitializeSetup: Boolean;
begin
  if not FileExists(ExpandConstant('{src}\dist\OMS.exe')) then
  begin
    MsgBox('OMS.exe not found!' + #13#10 +
           'Please run build.bat first to compile the executable.', mbError, MB_OK);
    Result := False;
  end
  else
    Result := True;
end;
