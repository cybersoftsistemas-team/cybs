unit cbsMigrations.Contracts.Migrations.Operations.EnsureSchemaOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.MigrationOperation;

type
  IEnsureSchemaOperation = interface(IMigrationOperation)
    ['{7F6B6060-5A14-4E2C-9D15-38363CFB66DF}']
    function GetName: string;
    property Name: string read GetName;
  end;

implementation

end.
