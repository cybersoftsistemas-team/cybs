unit cbsMigrations.Contracts.Migrations.Operations.NamedMigrationObjectOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.MigrationObjectOperation;

type
  INamedMigrationObjectOperation = interface(IMigrationObjectOperation)
    ['{5956209D-79AD-48DB-B728-D62360469264}']
    function GetName: string;
    property Name: string read GetName;
  end;

implementation

end.
