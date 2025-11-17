unit cbsMigrations.Contracts.Migrations.Operations.CheckConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ConstraintOperation;

type
  ICheckConstraintOperation = interface(IConstraintOperation)
    ['{B2719251-2BB2-42D9-ABC6-46D59CF3BF2C}']
    function GetSql: string;
    function HasSchema(const ASchema: string): ICheckConstraintOperation;
    function HasTable(const ATable: string): ICheckConstraintOperation;
    property Sql: string read GetSql;
  end;

implementation

end.
