unit cbsMigrations.Contracts.Migrations.Operations.DateColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.CustomNumberColumnOperation;

type
  IDateColumnOperation = interface(ICustomNumberColumnOperation)
    ['{AF1CC667-B705-452A-B96C-4A3B26082D00}']
    function HasColumnType(const AColumnType: string): IDateColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IDateColumnOperation;
    function HasSchema(const ASchema: string): IDateColumnOperation;
    function HasTable(const ATable: string): IDateColumnOperation;
    function IsOptional: IDateColumnOperation;
    function IsRequired: IDateColumnOperation;
  end;

implementation

end.
