unit cbsMigrations.Contracts.Migrations.Operations.AddIntColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.IntColumnOperation;

type
  IAddIntColumnOperation = interface(IIntColumnOperation)
    ['{9295B0BF-6F9F-4991-A52C-F1DE0F33C975}']
    function HasColumnType(const AColumnType: string): IAddIntColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddIntColumnOperation;
    function HasSchema(const ASchema: string): IAddIntColumnOperation;
    function HasTable(const ATable: string): IAddIntColumnOperation;
    function IsOptional: IAddIntColumnOperation;
    function IsRequired: IAddIntColumnOperation;
  end;

implementation

end.
