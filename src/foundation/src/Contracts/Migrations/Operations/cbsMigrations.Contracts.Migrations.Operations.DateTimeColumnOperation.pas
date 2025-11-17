unit cbsMigrations.Contracts.Migrations.Operations.DateTimeColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.CustomNumberColumnOperation;

type
  IDateTimeColumnOperation = interface(ICustomNumberColumnOperation)
    ['{8257EC33-B528-41C2-892F-31D6FF7BE1B8}']
    function HasColumnType(const AColumnType: string): IDateTimeColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IDateTimeColumnOperation;
    function HasSchema(const ASchema: string): IDateTimeColumnOperation;
    function HasTable(const ATable: string): IDateTimeColumnOperation;
    function IsOptional: IDateTimeColumnOperation;
    function IsRequired: IDateTimeColumnOperation;
  end;

implementation

end.
