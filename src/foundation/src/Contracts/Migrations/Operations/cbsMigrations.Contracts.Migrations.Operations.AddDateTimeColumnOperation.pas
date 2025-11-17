unit cbsMigrations.Contracts.Migrations.Operations.AddDateTimeColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DateTimeColumnOperation;

type
  IAddDateTimeColumnOperation = interface(IDateTimeColumnOperation)
    ['{B1BC5BA2-D6C3-4128-A9BB-E184FA8E2CF8}']
    function HasColumnType(const AColumnType: string): IAddDateTimeColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddDateTimeColumnOperation;
    function HasSchema(const ASchema: string): IAddDateTimeColumnOperation;
    function HasTable(const ATable: string): IAddDateTimeColumnOperation;
    function IsOptional: IAddDateTimeColumnOperation;
    function IsRequired: IAddDateTimeColumnOperation;
  end;

implementation

end.
