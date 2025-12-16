unit cbsSystem.Exprts.MigrationContextTypeRepository;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Migrations.MigrationContextTypeRepository;

  function MigrationContextTypeRepository: IMigrationContextTypeRepository;

implementation

uses
{PROJECT}
  cbsSystem.Migrations.MigrationContextTypeRepository;

var
  InternalMigrationContextTypeRepository: IMigrationContextTypeRepository;

function MigrationContextTypeRepository: IMigrationContextTypeRepository;
begin
  Result := InternalMigrationContextTypeRepository;
end;

initialization
begin
  InternalMigrationContextTypeRepository := TcbsMigrationContextTypeRepository.Create;
end;

finalization
begin
  InternalMigrationContextTypeRepository := nil;
end;

end.
