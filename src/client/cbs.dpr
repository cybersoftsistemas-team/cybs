program cbs;

{$APPTYPE GUI}

{$R *.res}

uses
  cbsSystem.Support.ProcessRunner,
  Shared.Inf.Hosting.Server in 'src\Shared\Inf\Hosting\Shared.Inf.Hosting.Server.pas',
  Shared.App.Contracts.Hosting.ApplicationHost in 'src\Shared\App\Contracts\Hosting\Shared.App.Contracts.Hosting.ApplicationHost.pas',
  System.SysUtils,
  Vcl.Dialogs;

var
  LHost: IApplicationHost;
begin
  ReportMemoryLeaksOnShutdown := True;
  try
    TProcessRunner.ExecuteAndWait('cbsDatabaseUpdater.exe', 'migrate seed');
    LHost := TServerHost.Create;
    LHost.Listen(8077);
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      Halt(1);
    end;
  end;
end.
