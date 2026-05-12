program cbs;

{$APPTYPE GUI}

{$R *.res}

uses
  Shared.Inf.Hosting.Server in 'src\Shared\Inf\Hosting\Shared.Inf.Hosting.Server.pas',
  Shared.App.Contracts.Hosting.ApplicationHost in 'src\Shared\App\Contracts\Hosting\Shared.App.Contracts.Hosting.ApplicationHost.pas';

var
  Host: IApplicationHost;
begin
  ReportMemoryLeaksOnShutdown := True;
  Host := TServerHost.Create;
  Host.Listen(8077);
end.
