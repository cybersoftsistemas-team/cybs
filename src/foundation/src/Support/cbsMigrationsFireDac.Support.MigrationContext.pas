unit cbsMigrationsFireDac.Support.MigrationContext;

interface

uses
{PROJECT}
  cbsMigrationsFireDac.Contracts.Support.MigrationContext,
  cbsMigrationsFireDac.Migrations.MigrationContextBase;

type
  TFDMigrationContext = class(TFDMigrationContextBase, IFDMigrationContext);

implementation

end.
