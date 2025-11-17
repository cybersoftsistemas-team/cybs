unit cbsMigrations.Contracts.Migrations.Operations.DropSchemaOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.MigrationOperation;

type
  IDropSchemaOperation = interface(IMigrationOperation)
    ['{E4DE8DC2-D7E9-4FE3-A3BA-67AC68AAAEAD}']
    function GetName: string;
    property Name: string read GetName;
  end;

implementation

end.
