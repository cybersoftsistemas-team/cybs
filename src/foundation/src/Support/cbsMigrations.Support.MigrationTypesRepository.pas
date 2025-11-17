unit cbsMigrations.Support.MigrationTypesRepository;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationTypesRepository;

  function MigrationTypesRepository: IMigrationTypesRepository;

implementation

uses
{PROJECT}
  cbsMigrations.Migrations.MigrationTypesRepository;

var
  InternalMigrationTypesRepository: IMigrationTypesRepository;

function MigrationTypesRepository: IMigrationTypesRepository;
begin
  Result := InternalMigrationTypesRepository;
end;

initialization
begin
  InternalMigrationTypesRepository := TMigrationTypesRepository.Create;
end;

finalization
begin
  InternalMigrationTypesRepository := nil;
end;

end.
