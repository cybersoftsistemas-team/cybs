unit cbsSystem.Support.Migration;

interface

uses
{PROJECT}
  cbsMigrationsFireDac.Migrations.MigrationContextBase,
  cbsSystem.Infrastructure.BaseDbModule;

  procedure RegisterMigrationContextType(const AMigrationContextType: MigrationContextType; const ADbConnectionModuleType: DbConnectionModuleType = nil);

implementation

uses
{PROJECT}
  cbsSystem.Exprts.MigrationContextTypeRepository,
  cbsSystem.Support.Module;

procedure RegisterMigrationContextType(const AMigrationContextType: MigrationContextType; const ADbConnectionModuleType: DbConnectionModuleType);
begin
  MigrationContextTypeRepository.Register(AMigrationContextType, ADbConnectionModuleType);
  RegisterModuleType(ADbConnectionModuleType);
end;

end.
