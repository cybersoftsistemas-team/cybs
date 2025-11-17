unit cbsMigrations.Contracts.Migrations.Operations.AddPrimaryKeyOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.PrimaryKeyOperation;

type
  IAddPrimaryKeyOperation = interface(IPrimaryKeyOperation)
    ['{AA946A91-EEEB-4D00-B3A1-D69AD2A9C979}']
    function HasColumns(const AColumns: array of TPrimaryKeyColumn): IAddPrimaryKeyOperation;
    function HasSchema(const ASchema: string): IAddPrimaryKeyOperation;
    function HasTable(const ATable: string): IAddPrimaryKeyOperation;
  end;

implementation

end.
