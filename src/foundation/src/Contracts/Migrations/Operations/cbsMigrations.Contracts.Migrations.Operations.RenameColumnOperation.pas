unit cbsMigrations.Contracts.Migrations.Operations.RenameColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.NamedMigrationObjectOperation;

type
  IRenameColumnOperation = interface(INamedMigrationObjectOperation)
    ['{A07E2FB3-B981-45B9-B1A0-D50608671B2E}']
    function HasSchema(const ASchema: string): IRenameColumnOperation;
    function HasTable(const ATable: string): IRenameColumnOperation;
    function GetNewName: string;
    property NewName: string read GetNewName;
  end;

implementation

end.
