unit cbsMigrationsFireDac.Contracts.Migrations.DatabaseMigrationRepository;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.DatabaseMigrationRepository;

type
  TMigrationName = cbsMigrations.Contracts.Migrations.DatabaseMigrationRepository.TMigrationName;

  IFDDatabaseMigrationRepository = interface(IDatabaseMigrationRepository)
    ['{F9B4F509-8475-474B-9A90-9CFD64C2E54E}']
  end;

implementation

end.

