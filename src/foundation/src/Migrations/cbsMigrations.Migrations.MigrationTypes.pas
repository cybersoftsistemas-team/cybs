unit cbsMigrations.Migrations.MigrationTypes;

interface

uses
{IDE}
  System.TypInfo,
{PROJECT}
  cbsMigrations.Support.Migration,
{SPRING}
  Spring.Collections;

type
  MigrationTypes = TArray<MigrationType>;

  IMigrationTypes = IEnumerable<MigrationType>;
  IMigrationTypeList = IList<MigrationType>;
  IMigrationContextTypeList = IDictionary<PTypeInfo, IMigrationTypeList>;

  function CreateMigrationContextTypeList: IMigrationContextTypeList;
  function CreateMigrationTypeList: IMigrationTypeList;

implementation

function CreateMigrationContextTypeList: IMigrationContextTypeList;
begin
  Result := TCollections.CreateDictionary<PTypeInfo, IMigrationTypeList>;
end;

function CreateMigrationTypeList: IMigrationTypeList;
begin
  Result := TCollections.CreateList<MigrationType>;
end;

end.

