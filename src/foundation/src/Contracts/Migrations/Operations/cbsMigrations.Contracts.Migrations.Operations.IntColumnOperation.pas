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
    function HasSchema(const ASchema: string): IIntColumnOperation;
    function HasTable(const ATable: string): IIntColumnOperation;
    function IsOptional: IIntColumnOperation;
    function IsRequired: IIntColumnOperation;
  end;

implementation

end.
