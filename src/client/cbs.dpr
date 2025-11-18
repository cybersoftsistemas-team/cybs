program cbs;

uses
  Forms,
  cbs.LoginModule in 'src\dom\DataModules\cbs.LoginModule.pas' {damLogin: TUniGUIMainModule},
  cbs.MainModule in 'src\dom\DataModules\cbs.MainModule.pas' {cbsMainModule: TUniGUIMainModule},
  cbs.ServerModule in 'src\dom\DataModules\cbs.ServerModule.pas' {cbsServerModule: TUniGUIServerModule},
  cbs.LoginForm in 'src\pre\view\cbs.LoginForm.pas' {frmLogin: TUniLoginForm},
  cbs.MainForm in 'src\pre\view\cbs.MainForm.pas' {cbsMainForm: TUniForm},
  cbs.inf.Database.MigrationContext in 'src\inf\cbs.inf.Database.MigrationContext.pas',
  _2025_11_17_00000001_create_identity_schema in 'src\inf\Migrations\_2025_11_17_00000001_create_identity_schema.pas',
  cbs.DbModule in 'src\dom\DataModules\cbs.DbModule.pas' {damDb: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TcbsServerModule.Create(Application);
  Application.Run;
end.
