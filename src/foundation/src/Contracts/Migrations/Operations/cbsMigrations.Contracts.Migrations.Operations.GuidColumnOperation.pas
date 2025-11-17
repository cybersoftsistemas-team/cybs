unit cbsMigrations.Contracts.Migrations.Operations.GuidColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.CustomStringColumnOperation;

type
  IGuidColumnOperation = interface(ICustomStringColumnOperation)
    ['{EAD3A33F-E73B-4E4C-9204-C7E236129740}']
    function HasColumnType(const AColumnType: string): IGuidColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IGuidColumnOperation;
    function HasSchema(const ASchema: string): IGuidColumnOperation;
    function HasTable(const ATable: string): IGuidColumnOperation;
    function IsOptional: IGuidColumnOperation;
    function IsRequired: IGuidColumnOperation;
  end;

implementation

end.
