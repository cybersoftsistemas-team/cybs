unit cbsMigrations.Contracts.Migrations.Operations.ComputedColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ColumnOperation;

type
  IComputedColumnOperation = interface(IColumnOperation)
    ['{E7BA061A-1674-4C19-8E81-494814B5ADBC}']
    function GetSql: string;
    function GetStored: Boolean;
    function HasColumnType(const AColumnType: string): IComputedColumnOperation;
    function HasSchema(const ASchema: string): IComputedColumnOperation;
    function HasSqlAs(const ASql: string): IComputedColumnOperation;
    function HasTable(const ATable: string): IComputedColumnOperation;
    function IsOptional: IComputedColumnOperation;
    function IsRequired: IComputedColumnOperation;
    function IsStored: IComputedColumnOperation;
    property Sql: string read GetSql;
    property Stored: Boolean read GetStored;
  end;

implementation

end.
