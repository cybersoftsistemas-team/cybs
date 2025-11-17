unit cbsMigrations.Contracts.Migrations.Operations.CustomNumberColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ColumnOperation;

type
  ICustomNumberColumnOperation = interface(IColumnOperation)
    ['{8C2F5F9E-C39C-4FF0-AF12-C78C26E1EB4B}']
    function HasColumnType(const AColumnType: string): ICustomNumberColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): ICustomNumberColumnOperation;
    function HasSchema(const ASchema: string): ICustomNumberColumnOperation;
    function HasTable(const ATable: string): ICustomNumberColumnOperation;
    function IsOptional: ICustomNumberColumnOperation;
    function IsRequired: ICustomNumberColumnOperation;
  end;

implementation

end.
