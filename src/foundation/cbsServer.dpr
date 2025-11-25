library cbsServer;

{$APPTYPE GUI}

uses
  Forms,
  cbsServer.Cybersoft.BaseForm in 'src\Cybersoft\cbsServer.Cybersoft.BaseForm.pas' {cbsBaseForm: TUniForm},
  cbsServer.Cybersoft.MainForm in 'src\Cybersoft\cbsServer.Cybersoft.MainForm.pas' {cbsMainForm: TUniForm},
  cbsServer.Cybersoft.MainModule in 'src\Cybersoft\cbsServer.Cybersoft.MainModule.pas' {cbsMainModule: TUniGUIMainModule},
  cbsServer.Cybersoft.ServerModule in 'src\Cybersoft\cbsServer.Cybersoft.ServerModule.pas' {cbsServerModule: TUniGUIServerModule},
  cbsServer.Support.ModuleManager in 'src\Support\cbsServer.Support.ModuleManager.pas',
  cbsServer.ModuleManager in 'src\Module\Manager\cbsServer.ModuleManager.pas',
  cbsServer.Contracts.ModuleManager in 'src\Contracts\Module\Manager\cbsServer.Contracts.ModuleManager.pas',
  cbsServer.Module in 'src\Module\cbsServer.Module.pas',
  cbsServer.Contracts.Module in 'src\Contracts\Module\cbsServer.Contracts.Module.pas',
  cbsServer.Module.Api in 'src\Module\cbsServer.Module.Api.pas',
  cbsServer.Cybersoft.BaseModule in 'src\Cybersoft\cbsServer.Cybersoft.BaseModule.pas' {cbsBaseModule: TDataModule},
  cdsServer.Support.FDDataSet.Extensions in 'src\Support\cdsServer.Support.FDDataSet.Extensions.pas',
  cbsServer.Support.RunTime in 'src\Support\cbsServer.Support.RunTime.pas';

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
