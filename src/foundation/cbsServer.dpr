library cbsServer;

uses
  Forms,
  cbsServer.Module.ServerModule in 'src\Module\cbsServer.Module.ServerModule.pas' {cbsServerModule: TUniGUIServerModule},
  cbsServer.Database in 'src\Database\cbsServer.Database.pas';

{$R *.res}

procedure Listen(const APort: Integer); stdcall; export;
begin
  Application.Initialize;
  TcbsServerModule.Create(Application);
  Application.Run;
end;

exports
  Listen;

begin

end.
