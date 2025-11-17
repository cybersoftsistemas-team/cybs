unit cbsMigrations.Contracts.Migrations.Operations.AddBooleanColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.BooleanColumnOperation;

type
  IAddBooleanColumnOperation = interface(IBooleanColumnOperation)
    ['{3097C68F-A106-44D9-B025-F6D7CB385FE4}']
    function HasColumnType(const AColumnType: string): IAddBooleanColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddBooleanColumnOperation;
    function HasSchema(const ASchema: string): IAddBooleanColumnOperation;
    function HasTable(const ATable: string): IAddBooleanColumnOperation;
    function IsOptional: IAddBooleanColumnOperation;
    function IsRequired: IAddBooleanColumnOperation;
  end;

implementation

end.
