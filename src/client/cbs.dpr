program cbs;

uses
  Forms,
  cbs.LoginModule in 'src\dom\DataModules\cbs.LoginModule.pas' {damLogin: TUniGUIMainModule},
  cbs.MainModule in 'src\dom\DataModules\cbs.MainModule.pas' {cbsMainModule: TUniGUIMainModule},
  cbs.ServerModule in 'src\dom\DataModules\cbs.ServerModule.pas' {cbsServerModule: TUniGUIServerModule},
  cbs.LoginForm in 'src\pre\view\cbs.LoginForm.pas' {frmLogin: TUniLoginForm},
  cbs.MainForm in 'src\pre\view\cbs.MainForm.pas' {cbsMainForm: TUniForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TcbsServerModule.Create(Application);
  Application.Run;
end.
