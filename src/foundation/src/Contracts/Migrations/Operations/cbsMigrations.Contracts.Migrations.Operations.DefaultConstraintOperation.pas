unit cbsMigrations.Contracts.Migrations.Operations.DefaultConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ConstraintOperation;

type
  TColumnName = string;

  IDefaultConstraintOperation = interface(IConstraintOperation)
    ['{772DBFC9-710E-4B4A-9B8F-B64633A651DA}']
    function GetColumnName: TColumnName;
    function GetValue: string;
    function HasSchema(const ASchema: string): IDefaultConstraintOperation;
    function HasTable(const ATable: string): IDefaultConstraintOperation;
    property ColumnName: TColumnName read GetColumnName;
    property Value: string read GetValue;
  end;

implementation

end.
