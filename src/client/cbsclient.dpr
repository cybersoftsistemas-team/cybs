program cbsclient;

uses
  Forms,
  cbsclient.Main in 'src\cbsclient.Main.pas' {MainForm: TUniForm},
  cbsclient.MainModule in 'src\cbsclient.MainModule.pas' {UniMainModule: TUniGUIMainModule},
  cbsclient.ServerModule in 'src\cbsclient.ServerModule.pas' {ServerModule: TUniGUIServerModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TServerModule.Create(Application);
  Application.Run;
end.
