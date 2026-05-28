unit cbsSystem.Support.ProcessRunner;

interface

type
  TProcessRunner = class
  public
    class procedure ExecuteAndWait(
      const AFileName: string;
      const AParameters: string = ''
    );
  end;

implementation

uses
{IDE}
  System.SysUtils,
  Winapi.Windows;

class procedure TProcessRunner.ExecuteAndWait(
  const AFileName: string;
  const AParameters: string
);
var
  LStartupInfo: TStartupInfo;
  LProcessInfo: TProcessInformation;
  LExitCode: Cardinal;
  LCommandLine: string;
begin
  ZeroMemory(@LStartupInfo, SizeOf(LStartupInfo));
  LStartupInfo.cb := SizeOf(LStartupInfo);
  ZeroMemory(@LProcessInfo, SizeOf(LProcessInfo));
  LCommandLine := Format(
    '"%s" %s',
    [AFileName, AParameters]
  );
  if not CreateProcess(
    nil,
    PChar(LCommandLine),
    nil,
    nil,
    False,
    0,
    nil,
    nil,
    LStartupInfo,
    LProcessInfo
  ) then
  begin
    RaiseLastOSError;
  end;
  try
    WaitForSingleObject(
      LProcessInfo.hProcess,
      INFINITE
    );
    if not GetExitCodeProcess(
      LProcessInfo.hProcess,
      LExitCode
    ) then
    begin
      RaiseLastOSError;
    end;
    if LExitCode <> 0 then
    begin
      raise Exception.CreateFmt(
        'Database updater failed with exit code %d.',
        [LExitCode]
      );
    end;
  finally
    CloseHandle(LProcessInfo.hProcess);
    CloseHandle(LProcessInfo.hThread);
  end;
end;

end.
