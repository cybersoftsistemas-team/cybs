unit cbsMigrations.Contracts.Migrations.Operations.ColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.NamedMigrationObjectOperation;

type
  IColumnOperation = interface(INamedMigrationObjectOperation)
    ['{1FE6E27F-B40B-46C9-B916-54E9650B9143}']
    function GetColumnType: string;
    function GetDefaultValueSql: string;
    function GetNullable: Boolean;
    function HasColumnType(const AColumnType: string): IColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IColumnOperation;
    function HasSchema(const ASchema: string): IColumnOperation;
    function HasTable(const ATable: string): IColumnOperation;
    function IsOptional: IColumnOperation;
    function IsRequired: IColumnOperation;
    property ColumnType: string read GetColumnType;
    property DefaultValueSql: string read GetDefaultValueSql;
    property Nullable: Boolean read GetNullable;
  end;

implementation

end.
