unit cbsMigrations.Contracts.Migrations.Operations.CustomStringColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ColumnOperation;

type
  ICustomStringColumnOperation = interface(IColumnOperation)
    ['{EDA2F982-A9C8-4ECB-AAF2-19ADD47C8917}']
    function HasColumnType(const AColumnType: string): ICustomStringColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): ICustomStringColumnOperation;
    function HasSchema(const ASchema: string): ICustomStringColumnOperation;
    function HasTable(const ATable: string): ICustomStringColumnOperation;
    function IsOptional: ICustomStringColumnOperation;
    function IsRequired: ICustomStringColumnOperation;
  end;

implementation

end.
