library cbsCore;

uses
{IDE}
  Forms,
  cbsCore.Cybersoft.BaseForm in 'src\Cybersoft\cbsCore.Cybersoft.BaseForm.pas' {cbsBaseForm: TUniForm},
  cbsCore.Cybersoft.MainForm in 'src\Cybersoft\cbsCore.Cybersoft.MainForm.pas' {cbsMainForm: TUniForm},
  cbsCore.Cybersoft.MainModule in 'src\Cybersoft\cbsCore.Cybersoft.MainModule.pas' {cbsMainModule: TUniGUIMainModule},
  cbsCore.Cybersoft.ServerModule in 'src\Cybersoft\cbsCore.Cybersoft.ServerModule.pas' {cbsServerModule: TUniGUIServerModule};

{$R *.res}

procedure StartServer; stdcall;
begin
  Application.Initialize;
  TcbsServerModule.Create(Application);
  Application.Run;
end;

exports
  StartServer;

begin

end.
