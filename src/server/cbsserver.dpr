program cbsserver;

uses
  Forms,
  cbsserver.Main in 'src\cbsserver.Main.pas' {MainForm: TUniForm},
  cbsserver.MainModule in 'src\cbsserver.MainModule.pas' {UniMainModule: TUniGUIMainModule},
  cbsserver.ServerModule in 'src\cbsserver.ServerModule.pas' {UniServerModule: TUniGUIServerModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
end.
