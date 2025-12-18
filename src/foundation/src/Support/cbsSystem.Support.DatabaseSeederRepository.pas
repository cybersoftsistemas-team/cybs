unit cbsSystem.Support.DatabaseSeederRepository;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Database.Seeders.DatabaseSeederRepository;

  function DatabaseSeederRepository: IDatabaseSeederRepository;

implementation

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeederRepository;

var
  InternalDatabaseSeederRepository: IDatabaseSeederRepository;

function DatabaseSeederRepository: IDatabaseSeederRepository;
begin
  Result := InternalDatabaseSeederRepository;
end;

initialization
begin
  InternalDatabaseSeederRepository := TcbsDatabaseSeederRepository.Create;
end;

finalization
begin
  InternalDatabaseSeederRepository := nil;
end;

end.
