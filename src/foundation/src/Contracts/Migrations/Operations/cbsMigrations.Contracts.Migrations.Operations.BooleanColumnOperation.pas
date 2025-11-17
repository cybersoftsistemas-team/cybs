unit cbsMigrations.Contracts.Migrations.Operations.BooleanColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.CustomNumberColumnOperation;

type
  IBooleanColumnOperation = interface(ICustomNumberColumnOperation)
    ['{7B8DFA93-0F2C-4D11-A4E0-93FC773236D4}']
    function HasColumnType(const AColumnType: string): IBooleanColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IBooleanColumnOperation;
    function HasSchema(const ASchema: string): IBooleanColumnOperation;
    function HasTable(const ATable: string): IBooleanColumnOperation;
    function IsOptional: IBooleanColumnOperation;
    function IsRequired: IBooleanColumnOperation;
  end;

implementation

end.
