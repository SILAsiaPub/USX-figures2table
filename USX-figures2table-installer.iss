; -- Example1.iss --
; Demonstrates copying 3 files and creating an icon.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
OutputBaseFilename=USX-figures2table
AppName=figures2table
AppVersion=0.2
DefaultDirName=C:\programs\figures2table
DisableDirPage=true
DefaultGroupName=Publishing
UninstallDisplayIcon={app}\u.ico
Compression=lzma2
SolidCompression=yes


[Files]
Source: "transform.hta"; DestDir: "{app}"
Source: "run.cmd"; DestDir: "{app}"
Source: "*.ico"; DestDir: "{app}"
Source: "Readme.md"; DestDir: "{app}"
Source: "*.txt"; DestDir: "{app}"
Source: "*.xslt"; DestDir: "{app}"
Source: "LICENSE"; DestDir: "{app}"
Source: "tools\jre-8u141-windows-x64.exe"; DestDir: "{tmp}"; DestName: "JREInstall.exe"; Check: IsWin64; Flags: deleteafterinstall
;Source: "jre-8u11-windows-i586.exe"; DestDir: "{tmp}"; DestName: "JREInstall.exe"; Check: (NOT IsWin64) AND InstallJava(); Flags: deleteafterinstall
Source: "tools\UNZIP.EXE"; DestDir: "{tmp}"; Flags: deleteafterinstall
Source: "tools\SaxonHE9-8-0-3J.zip"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Icons]
Name: "{group}\USX Figures to table"; Filename: "{app}\transform.hta"; IconFilename: "{app}\transform.ico"
Name: "{group}\Uninstall USX Figures to table"; Filename: "{uninstallexe}"; IconFilename: "{app}\u.ico"


[Run]
Filename: "{tmp}\UNZIP.EXE"; Parameters: "{tmp}\SaxonHE9-8-0-3J.zip -d {app}\saxon"
Filename: "{tmp}\jre-8u141-windows-x64.exe"; Parameters: "/s"; Flags: nowait postinstall runhidden runascurrentuser; Check: InstallJava() ;

[Code]
procedure DecodeVersion(verstr: String; var verint: array of Integer);
var
  i,p: Integer; s: string;
begin
  { initialize array }
  verint := [0,0,0,0];
  i := 0;
  while ((Length(verstr) > 0) and (i < 4)) do
  begin
    p := pos ('.', verstr);
    if p > 0 then
    begin
      if p = 1 then s:= '0' else s:= Copy (verstr, 1, p - 1);
      verint[i] := StrToInt(s);
      i := i + 1;
      verstr := Copy (verstr, p+1, Length(verstr));
    end
    else
    begin
      verint[i] := StrToInt (verstr);
      verstr := '';
    end;
  end;
end;


function CompareVersion (ver1, ver2: String) : Integer;
var
  verint1, verint2: array of Integer;
  i: integer;
begin
  SetArrayLength (verint1, 4);
  DecodeVersion (ver1, verint1);

  SetArrayLength (verint2, 4);
  DecodeVersion (ver2, verint2);

  Result := 0; i := 0;
  while ((Result = 0) and ( i < 4 )) do
  begin
    if verint1[i] > verint2[i] then
      Result := 1
    else
      if verint1[i] < verint2[i] then
        Result := -1
      else
        Result := 0;
    i := i + 1;
  end;
end;

function InstallJava() : Boolean;
var
  JVer: String;
  InstallJ: Boolean;
begin
  RegQueryStringValue(
    HKLM, 'SOFTWARE\JavaSoft\Java Runtime Environment', 'CurrentVersion', JVer);
  InstallJ := true;
  if Length( JVer ) > 0 then
  begin
    if CompareVersion(JVer, '1.8') >= 0 then
    begin
      InstallJ := false;
    end;
  end;
  Result := InstallJ;
end;

