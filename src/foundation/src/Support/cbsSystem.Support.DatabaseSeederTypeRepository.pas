unit cbsSystem.Support.DatabaseSeederTypeRepository;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Database.Seeders.DatabaseSeederTypeRepository;

  function DatabaseSeederTypeRepository: IDatabaseSeederTypeRepository;

implementation

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeederTypeRepository;

var
  InternalDatabaseSeederTypeRepository: IDatabaseSeederTypeRepository;

function DatabaseSeederTypeRepository: IDatabaseSeederTypeRepository;
begin
  Result := InternalDatabaseSeederTypeRepository;
end;

initialization
begin
  InternalDatabaseSeederTypeRepository := TcbsDatabaseSeederTypeRepository.Create;
end;

finalization
begin
  InternalDatabaseSeederTypeRepository := nil;
end;

end.
