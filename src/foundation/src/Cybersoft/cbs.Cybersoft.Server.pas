unit cbs.Cybersoft.Server;

interface

type
  cbsServer = class
  public
    class procedure Listen(const APort: Integer);
  end;

implementation

const
  Server = 'cbsServer.dll';

  procedure ExternalListen(const APort: Integer); external Server name 'Listen';

{ cbsServer }

class procedure cbsServer.Listen(const APort: Integer);
begin
  ExternalListen(APort);
end;

end.
