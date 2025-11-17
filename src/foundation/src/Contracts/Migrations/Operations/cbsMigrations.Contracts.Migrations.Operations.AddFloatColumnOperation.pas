unit cbsMigrations.Contracts.Migrations.Operations.AddFloatColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.FloatColumnOperation;

type
  IAddFloatColumnOperation = interface(IFloatColumnOperation)
    ['{0C17DB64-E76E-4B46-A48F-15398C3E935A}']
    function HasColumnType(const AColumnType: string): IAddFloatColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddFloatColumnOperation;
    function HasPrecision(const APrecision: Integer): IAddFloatColumnOperation;
    function HasSchema(const ASchema: string): IAddFloatColumnOperation;
    function HasTable(const ATable: string): IAddFloatColumnOperation;
    function IsOptional: IAddFloatColumnOperation;
    function IsRequired: IAddFloatColumnOperation;
  end;

implementation

end.
