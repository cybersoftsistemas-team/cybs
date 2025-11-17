unit cbsMigrations.Contracts.Migrations.Operations.AddForeignKeyOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ForeignKeyOperation;

type
  IAddForeignKeyOperation = interface(IForeignKeyOperation)
    ['{2D47C74F-8127-4CDE-B51A-FD3896FFBA78}']
    function HasColumns(const AColumns: array of TForeignKeyColumn): IAddForeignKeyOperation;
    function HasOnDelete(const Action: ReferentialAction): IAddForeignKeyOperation;
    function HasOnUpdate(const Action: ReferentialAction): IAddForeignKeyOperation;
    function HasPrincipalColumns(const AColumns: array of TForeignKeyPrincipalColumn): IAddForeignKeyOperation;
    function HasPrincipalSchema(const ASchema: string): IAddForeignKeyOperation;
    function HasPrincipalTable(const ATable: string): IAddForeignKeyOperation;
    function HasSchema(const ASchema: string): IAddForeignKeyOperation;
    function HasTable(const ATable: string): IAddForeignKeyOperation;
  end;

implementation

end.
