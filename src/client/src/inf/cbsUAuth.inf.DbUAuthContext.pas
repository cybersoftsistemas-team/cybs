unit cbsUAuth.inf.DbUAuthContext;

interface

uses
{PROJECT}
  cbsMigrationsFireDac.Support.MigrationContext;

type
  TDbUAuthContext = class(TFDMigrationContext);

implementation

uses
{PROJECT}
  cbsSystem.Support.Migration,
  cbsUAuth.inf.DbModule;

initialization
begin
  RegisterMigrationContextType(TDbUAuthContext, TdamDb);
end;

end.
