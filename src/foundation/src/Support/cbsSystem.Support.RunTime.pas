unit cbsSystem.Support.RunTime;

interface

type
  RunTime = class
  private
    class var FIsElectron: Boolean;
    class function GetIsClientRunningInServer: Boolean; static;
  public
    class property IsElectron: Boolean read FIsElectron write FIsElectron;
    class property IsClientRunningInServer: Boolean read GetIsClientRunningInServer;
  end;

implementation

uses
{IDE}
  IdStack,
  System.SysUtils,
  uniGUIApplication;

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
  Result := False;
  for var LIP in GetLocalAddresses do if
    SameText(LIP, UniSession.RemoteIP) then
  begin
    Exit(True);
  end;
end;

end.
