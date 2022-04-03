; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define AppName "Whisparr"
#define AppPublisher "Team Whisparr"
#define AppURL "https://whisparr.com/"
#define ForumsURL "https://whisparr.com/discord"
#define AppExeName "Whisparr.exe"
#define BaseVersion GetEnv('MAJORVERSION')
#define BuildNumber GetEnv('MINORVERSION')
#define BuildVersion GetEnv('WHISPARRVERSION')

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{56C1065D-3523-4025-B76D-6F73F67F7F69}
AppName={#AppName}
AppVersion={#BaseVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#ForumsURL}
AppUpdatesURL={#AppURL}
DefaultDirName={commonappdata}\Whisparr
DisableDirPage=yes
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
OutputBaseFilename=Whisparr.{#BuildVersion}.{#Runtime}
SolidCompression=yes
AppCopyright=Creative Commons 3.0 License
AllowUNCPath=False
UninstallDisplayIcon={app}\bin\Whisparr.exe
DisableReadyPage=True
CompressionThreads=2
Compression=lzma2/normal
AppContact={#ForumsURL}
VersionInfoVersion={#BaseVersion}.{#BuildNumber}
SetupLogging=yes
OutputDir=output
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopIcon"; Description: "{cm:CreateDesktopIcon}"
Name: "windowsService"; Description: "Install Windows Service (Starts when the computer starts as the LocalService user, you will need to change the user to access network shares)"; GroupDescription: "Start automatically"; Flags: exclusive
Name: "startupShortcut"; Description: "Create shortcut in Startup folder (Starts when you log into Windows)"; GroupDescription: "Start automatically"; Flags: exclusive unchecked
Name: "none"; Description: "Do not start automatically"; GroupDescription: "Start automatically"; Flags: exclusive unchecked

[Dirs]
Name: "{app}"; Permissions: users-modify

[Files]
Source: "..\_artifacts\{#Runtime}\{#Framework}\Whisparr\Whisparr.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "..\_artifacts\{#Runtime}\{#Framework}\Whisparr\*"; Excludes: "Whisparr.Update"; DestDir: "{app}\bin"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\bin\{#AppExeName}"; Parameters: "/icon"
Name: "{commondesktop}\{#AppName}"; Filename: "{app}\bin\{#AppExeName}"; Parameters: "/icon"; Tasks: desktopIcon
Name: "{userstartup}\{#AppName}"; Filename: "{app}\bin\Whisparr.exe"; WorkingDir: "{app}\bin"; Tasks: startupShortcut

[InstallDelete]
Name: "{app}\bin"; Type: filesandordirs

[Run]
Filename: "{app}\bin\Whisparr.Console.exe"; StatusMsg: "Removing previous Windows Service"; Parameters: "/u /exitimmediately"; Flags: runhidden waituntilterminated;
Filename: "{app}\bin\Whisparr.Console.exe"; Description: "Enable Access from Other Devices"; StatusMsg: "Enabling Remote access"; Parameters: "/registerurl /exitimmediately"; Flags: postinstall runascurrentuser runhidden waituntilterminated; Tasks: startupShortcut none;
Filename: "{app}\bin\Whisparr.Console.exe"; StatusMsg: "Installing Windows Service"; Parameters: "/i /exitimmediately"; Flags: runhidden waituntilterminated; Tasks: windowsService
Filename: "{app}\bin\Whisparr.exe"; Description: "Open Whisparr Web UI"; Flags: postinstall skipifsilent nowait; Tasks: windowsService;
Filename: "{app}\bin\Whisparr.exe"; Description: "Start Whisparr"; Flags: postinstall skipifsilent nowait; Tasks: startupShortcut none;

[UninstallRun]
Filename: "{app}\bin\whisparr.console.exe"; Parameters: "/u"; Flags: waituntilterminated skipifdoesntexist

[Code]
function PrepareToInstall(var NeedsRestart: Boolean): String;
var
  ResultCode: Integer;
begin
  Exec('net', 'stop whisparr', '', 0, ewWaitUntilTerminated, ResultCode)
  Exec('sc', 'delete whisparr', '', 0, ewWaitUntilTerminated, ResultCode)
end;
