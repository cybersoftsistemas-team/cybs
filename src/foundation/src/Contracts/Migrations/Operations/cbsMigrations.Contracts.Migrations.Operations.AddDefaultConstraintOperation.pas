unit cbsMigrations.Contracts.Migrations.Operations.AddDefaultConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DefaultConstraintOperation;

type
  TColumnName = cbsMigrations.Contracts.Migrations.Operations.DefaultConstraintOperation.TColumnName;

  IAddDefaultConstraintOperation = interface(IDefaultConstraintOperation)
    ['{CC2243B1-1D1B-484E-BE0A-BDFE45FED7A9}']
    function HasColumn(const AColumnName: TColumnName): IAddDefaultConstraintOperation;
    function HasSchema(const ASchema: string): IAddDefaultConstraintOperation;
    function HasTable(const ATable: string): IAddDefaultConstraintOperation;
    function HasValue(const AValue: string): IAddDefaultConstraintOperation;
  end;

implementation

end.
