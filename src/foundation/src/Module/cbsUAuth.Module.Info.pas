unit cbsUAuth.Module.Info;

interface

uses
{PROJECT}
  cbsServer.Module.Api;

  function GetModuleInfo: PModuleInfo; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; export;

implementation

uses
{IDE}
  System.AnsiStrings;

var
  GModuleInfo: TcbsModuleInfo;

function GetModuleInfo: PModuleInfo; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; export;
begin
  Result := @GModuleInfo;
end;

procedure InitModuleInfo;
begin
  FillChar(GModuleInfo, SizeOf(GModuleInfo), 0);
  GModuleInfo.Version.Major := 1;
  GModuleInfo.Version.Minor := 0;
  StrPCopy(GModuleInfo.Category   , 'Security.Auth');
  StrPCopy(GModuleInfo.DisplayName, 'Autenticação de usuário');
  StrPCopy(GModuleInfo.ModuleName , 'cbsUAuth' + GetModuleExtension);
end;

initialization
begin
  InitModuleInfo;
end;

end.
