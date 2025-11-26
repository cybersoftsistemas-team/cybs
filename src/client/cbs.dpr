program cbs;

{$APPTYPE GUI}

{$R *.res}

uses
  cbs.api.Server in 'src\api\cbs.api.Server.pas';

begin
  ReportMemoryLeaksOnShutdown := True;
  cbsServer.Listen(8077);
end.
