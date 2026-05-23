unit cbsMigrations.Contracts.Migrations.Operations.DropDefaultConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DefaultConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.MigrationObjectOperation;

type
  TColumnName = cbsMigrations.Contracts.Migrations.Operations.DefaultConstraintOperation.TColumnName;

  IDropDefaultConstraintOperation = interface(IMigrationObjectOperation)
    ['{4EF2252F-C244-440B-8635-D093361BE107}']
    function GetColumnName: TColumnName;
    function HasSchema(const ASchema: string): IDropDefaultConstraintOperation;
    function HasTable(const ATable: string): IDropDefaultConstraintOperation;
    property ColumnName: TColumnName read GetColumnName;
  end;

implementation

end.
