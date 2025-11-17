unit cbsMigrations.Contracts.Migrations.Operations.FloatColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.NumberColumnOperation;

type
  IFloatColumnOperation = interface(INumberColumnOperation)
    ['{DF718167-4BC6-42EE-AA4A-199AE1B28CF3}']
    function HasColumnType(const AColumnType: string): IFloatColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IFloatColumnOperation;
    function HasPrecision(const APrecision: Integer): IFloatColumnOperation;
    function HasSchema(const ASchema: string): IFloatColumnOperation;
    function HasTable(const ATable: string): IFloatColumnOperation;
    function IsOptional: IFloatColumnOperation;
    function IsRequired: IFloatColumnOperation;
  end;

implementation

end.
