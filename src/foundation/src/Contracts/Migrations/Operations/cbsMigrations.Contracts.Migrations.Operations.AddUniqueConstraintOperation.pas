unit cbsMigrations.Contracts.Migrations.Operations.AddUniqueConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.UniqueConstraintOperation;

type
  IAddUniqueConstraintOperation = interface(IUniqueConstraintOperation)
    ['{18018ECE-30F9-4C8B-8B56-88B4821FC9ED}']
    function HasColumns(const AColumns: array of TUniqueColumn): IAddUniqueConstraintOperation;
    function HasSchema(const ASchema: string): IAddUniqueConstraintOperation;
    function HasTable(const ATable: string): IAddUniqueConstraintOperation;
  end;

implementation

end.
