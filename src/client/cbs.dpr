program cbs;

uses
  Forms,
  cbs.MainForm in 'src\cbs.MainForm.pas' {cbsMainForm: TUniForm},
  cbs.MainModule in 'src\cbs.MainModule.pas' {cbsMainModule: TUniGUIMainModule},
  cbs.ServerModule in 'src\cbs.ServerModule.pas' {cbsServerModule: TUniGUIServerModule},
  cbs.UserAuthenticationForm in 'src\cbs.UserAuthenticationForm.pas' {cbsUserAuthenticationForm: TUniLoginForm},
  cbs.UserAuthenticationModule in 'src\cbs.UserAuthenticationModule.pas' {cbsUserAuthenticationModule: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TcbsServerModule.Create(Application);
  Application.Run;
end.
