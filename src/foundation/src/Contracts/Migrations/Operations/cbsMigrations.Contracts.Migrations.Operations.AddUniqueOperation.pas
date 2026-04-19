unit cbsMigrations.Contracts.Migrations.Operations.AddUniqueOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.UniqueConstraintOperation,
  cbsMigrations.Migrations.Operations.IncludeColumn;

type
  IAddUniqueOperation = interface(IUniqueConstraintOperation)
    ['{18018ECE-30F9-4C8B-8B56-88B4821FC9ED}']
    function GetDescending: TDescending;
    function HasColumn(const AColumnName: TUniqueColumn): IAddUniqueOperation;
    function HasColumns(const AColumns: array of TUniqueColumn): IAddUniqueOperation;
    function HasDescending(const ADescending: TDescending): IAddUniqueOperation;
    function HasInclude(const AColumns: array of TIncludeColumn): IAddUniqueOperation;
    function HasSchema(const ASchema: string): IAddUniqueOperation;
    function HasTable(const ATable: string): IAddUniqueOperation;
    function IncludeColumns: IIncludeColumns;
    property Descending: TDescending read GetDescending;
  end;

implementation

end.
