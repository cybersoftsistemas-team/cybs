unit cbsMigrations.Contracts.Migrations.Operations.AlterColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ColumnOperation;

type
  IAlterColumnOperation = interface(IColumnOperation)
    ['{9400BD1F-34D5-46DC-B36B-F8333EE1D00D}']
    function GetCollation: string;
    function HasCollation(const ACollation: string): IAlterColumnOperation;
    function HasColumnType(const AColumnType: string): IAlterColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAlterColumnOperation;
    function HasSchema(const ASchema: string): IAlterColumnOperation;
    function HasTable(const ATable: string): IAlterColumnOperation;
    function IsOptional: IAlterColumnOperation;
    function IsRequired: IAlterColumnOperation;
    property Collation: string read GetCollation;
  end;

implementation

end.
