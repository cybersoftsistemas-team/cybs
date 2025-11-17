unit cbsMigrations.Contracts.Migrations.Operations.AddGuidColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.GuidColumnOperation;

type
  IAddGuidColumnOperation = interface(IGuidColumnOperation)
    ['{E2611545-AE65-4AB3-ABF2-37D45158412C}']
    function HasColumnType(const AColumnType: string): IAddGuidColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddGuidColumnOperation;
    function HasSchema(const ASchema: string): IAddGuidColumnOperation;
    function HasTable(const ATable: string): IAddGuidColumnOperation;
    function IsOptional: IAddGuidColumnOperation;
    function IsRequired: IAddGuidColumnOperation;
  end;

implementation

end.
