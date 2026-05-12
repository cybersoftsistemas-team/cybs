unit Shared.Inf.Hosting.Server;

interface

uses
{PROJECT}
  Shared.App.Contracts.Hosting.ApplicationHost;

type
  TServerHost = class(TInterfacedObject, IApplicationHost)
  public
    procedure Listen(const APort: Integer);
  end;

implementation

const
  ServerLib = 'cbsServer.dll';

  procedure ExternalListen(const APort: Integer); external ServerLib name 'Listen';

{ TServerHost }

procedure TServerHost.Listen(const APort: Integer);
begin
  ExternalListen(APort);
end;

end.
