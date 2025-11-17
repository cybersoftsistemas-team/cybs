unit cbsMigrations.Contracts.Migrations.Operations.DropTableOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.MigrationObjectOperation;

type
  IDropTableOperation = interface(IMigrationObjectOperation)
    ['{CBADF1F9-29D8-4177-9F0B-1F2E005BF9AE}']
    function HasSchema(const ASchema: string): IDropTableOperation;
  end;

implementation

end.
