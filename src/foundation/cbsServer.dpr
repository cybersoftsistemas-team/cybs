library cbsServer;

uses
  Forms,
  cbsServer.Support.ModuleManager in 'src\Support\cbsServer.Support.ModuleManager.pas',
  cbsServer.Module.Manager in 'src\Module\Manager\cbsServer.Module.Manager.pas',
  cbsServer.Contracts.Module.Manager in 'src\Contracts\Module\Manager\cbsServer.Contracts.Module.Manager.pas',
  cbsServer.Module in 'src\Module\cbsServer.Module.pas',
  cbsServer.Contracts.Module in 'src\Contracts\Module\cbsServer.Contracts.Module.pas',
  cdsServer.Support.DataSet.Extensions in 'src\Support\cdsServer.Support.DataSet.Extensions.pas',
  cbsServer.Support.RunTime in 'src\Support\cbsServer.Support.RunTime.pas',
  cbsServer.Support.Form in 'src\Support\cbsServer.Support.Form.pas',
  cbsServer.Support.Module in 'src\Support\cbsServer.Support.Module.pas',
  cbsServer.Form.BaseForm in 'src\Form\cbsServer.Form.BaseForm.pas' {frmBase: TUniForm},
  cbsServer.Form.MainForm in 'src\Form\cbsServer.Form.MainForm.pas' {frmMain: TUniForm},
  cbsServer.Module.BaseModule in 'src\Module\cbsServer.Module.BaseModule.pas' {damBase: TDataModule},
  cbsServer.Module.MainModule in 'src\Module\cbsServer.Module.MainModule.pas' {damMain: TUniGUIMainModule},
  cbsServer.Module.ServerModule in 'src\Module\cbsServer.Module.ServerModule.pas' {cbsServerModule: TUniGUIServerModule},
  cbsServer.Form.Registered in 'src\Form\cbsServer.Form.Registered.pas',
  cbsServer.Contracts.Form.Registered in 'src\Contracts\Form\cbsServer.Contracts.Form.Registered.pas',
  cbsServer.Contracts.Module.Registered in 'src\Contracts\Module\cbsServer.Contracts.Module.Registered.pas',
  cbsServer.Module.Registered in 'src\Module\cbsServer.Module.Registered.pas';

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
