library cbsServer;

uses
  Forms,
  cbsServer.Form.MainForm in 'src\Form\cbsServer.Form.MainForm.pas' {frmMain: TUniForm},
  cbsServer.Module.MainModule in 'src\Module\cbsServer.Module.MainModule.pas' {damMain: TUniGUIMainModule},
  cbsServer.Module.ServerModule in 'src\Module\cbsServer.Module.ServerModule.pas' {cbsServerModule: TUniGUIServerModule};

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
