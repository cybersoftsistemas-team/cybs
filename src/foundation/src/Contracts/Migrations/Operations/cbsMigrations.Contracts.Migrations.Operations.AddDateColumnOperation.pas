unit cbsMigrations.Contracts.Migrations.Operations.AddDateColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DateColumnOperation;

type
  IAddDateColumnOperation = interface(IDateColumnOperation)
    ['{E54E3EE9-C642-4A01-9234-1745CC0C98E0}']
    function HasColumnType(const AColumnType: string): IAddDateColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddDateColumnOperation;
    function HasSchema(const ASchema: string): IAddDateColumnOperation;
    function HasTable(const ATable: string): IAddDateColumnOperation;
    function IsOptional: IAddDateColumnOperation;
    function IsRequired: IAddDateColumnOperation;
  end;

implementation

end.
