unit cbsMigrations.Contracts.Migrations.Operations.AddCheckConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.CheckConstraintOperation;

type
  IAddCheckConstraintOperation = interface(ICheckConstraintOperation)
    ['{8251F5EB-677D-4895-B507-2C9F947DCE32}']
    function HasSchema(const ASchema: string): IAddCheckConstraintOperation;
    function HasTable(const ATable: string): IAddCheckConstraintOperation;
  end;

implementation

end.

