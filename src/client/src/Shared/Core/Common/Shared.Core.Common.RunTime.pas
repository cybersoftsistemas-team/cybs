unit Shared.Core.Common.RunTime;

interface

type
  RunTime = class
  private
    class function GetIsClientRunningInServer: Boolean; static;
    class function GetIsElectron: Boolean; static;
  public
    class property IsElectron: Boolean read GetIsElectron;
    class property IsClientRunningInServer: Boolean read GetIsClientRunningInServer;
  end;

implementation

uses
{IDE}
  IdStack,
  System.SysUtils,
  uniGUIApplication,
{PROJECT}
  Shared.UI.Data.Modules.MainModule;

function GetLocalAddresses: TArray<string>;
begin
  TIdStack.IncUsage;
  try
    Result := GStack.LocalAddresses.ToStringArray + ['127.0.0.1', '::1'];
  finally
    TIdStack.DecUsage;
  end;
end;

{ RunTime }

class function RunTime.GetIsClientRunningInServer: Boolean;
begin
  for var LIP in GetLocalAddresses do if
    SameText(LIP, UniSession.RemoteIP) then
  begin
    Exit(True);
  end;
  Result := False;
end;

class function RunTime.GetIsElectron: Boolean;
begin
  Result := damMain.IsElectron;
end;

end.
