unit Shared.Dom.DatabaseUpdater.CommandLineParser;

interface

uses
{PROJECT}
  Shared.Inf.Contracts.Services.DatabaseUpdaterService;

type
  TCommandLineParser = class
  public
    class function Parse: TDatabaseUpdateCommands;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TCommandLineParser }

class function TCommandLineParser.Parse: TDatabaseUpdateCommands;
begin
  Result := [];
  for var I := 1 to ParamCount do
  begin
    var LParam := ParamStr(I).ToLower;
    if LParam = 'migrate' then
      Result := Result + [RunMigrations]
    else if LParam = 'seed' then
      Result := Result + [RunSeeds];
  end;
end;

end.

