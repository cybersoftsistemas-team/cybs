program cbsserver;

uses
  Forms,
  Main in 'src\Main.pas' {MainForm: TUniForm},
  MainModule in 'src\MainModule.pas' {UniMainModule: TUniGUIMainModule},
  ServerModule in 'src\ServerModule.pas' {UniServerModule: TUniGUIServerModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
end.
