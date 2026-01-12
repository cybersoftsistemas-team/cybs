unit cbsMigrations.Contracts.Migrations.Operations.IntColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.CustomNumberColumnOperation;

type
  IIntColumnOperation = interface(ICustomNumberColumnOperation)
    ['{5B5E7767-6CBB-46C5-93DC-88C3A6535834}']
    function HasColumnType(const AColumnType: string): IIntColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IIntColumnOperation;
    function HasIncrement(const ASeed: Integer = 1; const AIncrement: Integer = 1): IIntColumnOperation;
    function HasSchema(const ASchema: string): IIntColumnOperation;
    function HasTable(const ATable: string): IIntColumnOperation;
    function Increment: Integer;
    function IsIncrement: Boolean;
    function IsOptional: IIntColumnOperation;
    function IsRequired: IIntColumnOperation;
    function Seed: Integer;
  end;

implementation

end.
