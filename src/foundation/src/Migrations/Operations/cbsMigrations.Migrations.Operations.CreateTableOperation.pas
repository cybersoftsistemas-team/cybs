unit cbsMigrations.Migrations.Operations.CreateTableOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.ConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.CreateTableOperation,
  cbsMigrations.Migrations.Operations.TableOperation;

type
  TCreateTableOperation = class(TTableOperation, ICreateTableOperation)
  public
    function Columns(const AColumns: array of IColumnOperation): ICreateTableOperation;
    function Constraints(const AConstraints: array of IConstraintOperation): ICreateTableOperation;
    function HasSchema(const ASchema: string): ICreateTableOperation;
  end;

implementation

{ TCreateTableOperation }

function TCreateTableOperation.Columns(const AColumns: array of IColumnOperation): ICreateTableOperation;
begin
  Result := TCreateTableOperation(inherited Columns(AColumns));
end;

function TCreateTableOperation.Constraints(const AConstraints: array of IConstraintOperation): ICreateTableOperation;
begin
  Result := TCreateTableOperation(inherited Constraints(AConstraints));
end;

function TCreateTableOperation.HasSchema(const ASchema: string): ICreateTableOperation;
begin
  Result := TCreateTableOperation(inherited HasSchema(ASchema));
end;

end.
