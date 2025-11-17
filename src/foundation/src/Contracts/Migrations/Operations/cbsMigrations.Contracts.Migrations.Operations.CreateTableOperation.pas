unit cbsMigrations.Contracts.Migrations.Operations.CreateTableOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.ConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.TableOperation;

type
  ICreateTableOperation = interface(ITableOperation)
    ['{89A0E3F9-8928-43D7-94CC-3ABA6EDEC436}']
    function Columns: ITableColumns; overload;
    function Columns(const AColumns: array of IColumnOperation): ICreateTableOperation; overload;
    function Constraints: ITableConstraints; overload;
    function Constraints(const AConstraints: array of IConstraintOperation): ICreateTableOperation; overload;
    function HasSchema(const ASchema: string): ICreateTableOperation;
  end;

implementation

end.
