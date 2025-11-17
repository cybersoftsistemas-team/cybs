unit cbsMigrations.Migrations.Operations.CreateIndexOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.CreateIndexOperation,
  cbsMigrations.Contracts.Migrations.Operations.IndexOperation,
  cbsMigrations.Migrations.Operations.IndexOperation;

type
  TCreateIndexOperation = class(TIndexOperation, ICreateIndexOperation)
  public
    function HasColumns(const AColumns: array of TIndexColumn): ICreateIndexOperation;
    function HasDescending(const ADescending: TDescending): ICreateIndexOperation;
    function HasName(const AName: string): ICreateIndexOperation;
    function HasSchema(const ASchema: string): ICreateIndexOperation;
    function HasTable(const ATable: string): ICreateIndexOperation;
    function HasUnique(const AUnique: Boolean): ICreateIndexOperation;
  end;

implementation

{ TCreateIndexOperation }

function TCreateIndexOperation.HasColumns(const AColumns: array of TIndexColumn): ICreateIndexOperation;
begin
  Result := TCreateIndexOperation(inherited HasColumns(AColumns));
end;

function TCreateIndexOperation.HasDescending(const ADescending: TDescending): ICreateIndexOperation;
begin
  Result := TCreateIndexOperation(inherited HasDescending(ADescending));
end;

function TCreateIndexOperation.HasName(const AName: string): ICreateIndexOperation;
begin
  Result := TCreateIndexOperation(inherited HasName(AName));
end;

function TCreateIndexOperation.HasSchema(const ASchema: string): ICreateIndexOperation;
begin
  Result := TCreateIndexOperation(inherited HasSchema(ASchema));
end;

function TCreateIndexOperation.HasTable(const ATable: string): ICreateIndexOperation;
begin
  Result := TCreateIndexOperation(inherited HasTable(ATable));
end;

function TCreateIndexOperation.HasUnique(const AUnique: Boolean): ICreateIndexOperation;
begin
  Result := TCreateIndexOperation(inherited HasUnique(AUnique));
end;

end.
