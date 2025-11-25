program cbs;

{$APPTYPE GUI}

uses
{IDE}
  cbs.Cybersoft.Server in 'src\Cybersoft\cbs.Cybersoft.Server.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  cbsServer.Listen(8077);
end.
