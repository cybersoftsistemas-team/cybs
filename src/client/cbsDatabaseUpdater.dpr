program cbsDatabaseUpdater;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  cbsSystem.Support.Bootstrap,
  cbsSystem.Support.Container,
  Shared.Dom.DatabaseUpdater.CommandLineParser in 'src\Shared\Dom\DatabaseUpdater\Shared.Dom.DatabaseUpdater.CommandLineParser.pas',
  Shared.Inf.Contracts.Services.DatabaseUpdaterService,
  Shared.Inf.Database.Connection in 'src\Shared\Inf\Database\Shared.Inf.Database.Connection.pas' {damDb: TDataModule},
  Shared.Inf.Database.Context,
  Shared.Inf.Services.DatabaseUpdaterService;

begin
  try
    Bootstrap.ImplementSingleton<TdamDb>;
    Bootstrap.ImplementSingleton<TDbContext>;
    Bootstrap.ImplementSingleton<IDatabaseUpdaterService, TDatabaseUpdaterService>;
    Bootstrap.Initialize;
    try
      App.Make<IDatabaseUpdaterService>.Execute(TCommandLineParser.Parse);
    finally
      Bootstrap.Finalize;
    end;
    Halt(0);
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      Halt(1);
    end;
  end;
end.
