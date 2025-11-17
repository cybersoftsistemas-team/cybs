unit cbsMigrations.Contracts.Migrations.Operations.CreateIndexOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.IndexOperation;

type
  ICreateIndexOperation = interface(IIndexOperation)
    ['{F64C9F99-31FE-4272-872A-F846E04050F2}']
    function HasColumns(const AColumns: array of TIndexColumn): ICreateIndexOperation;
    function HasDescending(const ADescending: TDescending): ICreateIndexOperation;
    function HasName(const AName: string): ICreateIndexOperation;
    function HasSchema(const ASchema: string): ICreateIndexOperation;
    function HasTable(const ATable: string): ICreateIndexOperation;
    function HasUnique(const AUnique: Boolean): ICreateIndexOperation;
  end;

implementation

end.
