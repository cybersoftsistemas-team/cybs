unit cbsMigrations.Support.Migration;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationBuilder,
  cbsMigrations.Contracts.Migrations.Operations.ForeignKeyOperation,
  cbsMigrations.Migrations.CustomMigration,
  cbsMigrations.Migrations.MigrationContext,
  cbsMigrations.Schema.Types;

type
  ReferentialAction = cbsMigrations.Contracts.Migrations.Operations.ForeignKeyOperation.ReferentialAction;
  DriverID = cbsMigrations.Schema.Types.DriverID;
  IMigrationBuilder = cbsMigrations.Contracts.Migrations.MigrationBuilder.IMigrationBuilder;

  TMigration = class(TCustomMigration);

  MigrationType = class of TMigration;

  procedure RegisterMigration(const MigrationContextType: MigrationContextType; const AMigrationType: MigrationType);

implementation

uses
{PROJECT}
  cbsMigrations.Support.MigrationTypesRepository;

procedure RegisterMigration(const MigrationContextType: MigrationContextType; const AMigrationType: MigrationType);
begin
  MigrationTypesRepository.Register(MigrationContextType, [AMigrationType]);
end;

end.
