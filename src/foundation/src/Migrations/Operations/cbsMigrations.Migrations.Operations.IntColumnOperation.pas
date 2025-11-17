unit cbsMigrations.Migrations.Operations.IntColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.IntColumnOperation,
  cbsMigrations.Migrations.Operations.CustomNumberColumnOperation;

type
  TIntColumnOperation = class(TCustomNumberColumnOperation, IIntColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IIntColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IIntColumnOperation;
    function HasSchema(const ASchema: string): IIntColumnOperation;
    function HasTable(const ATable: string): IIntColumnOperation;
    function IsOptional: IIntColumnOperation;
    function IsRequired: IIntColumnOperation;
  end;

implementation

{ TIntColumnOperation }

function TIntColumnOperation.HasColumnType(const AColumnType: string): IIntColumnOperation;
begin
  Result := TIntColumnOperation(inherited HasColumnType(AColumnType));
end;

function TIntColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IIntColumnOperation;
begin
  Result := TIntColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TIntColumnOperation.HasSchema(const ASchema: string): IIntColumnOperation;
begin
  Result := TIntColumnOperation(inherited HasSchema(ASchema));
end;

function TIntColumnOperation.HasTable(const ATable: string): IIntColumnOperation;
begin
  Result := TIntColumnOperation(inherited HasTable(ATable));
end;

function TIntColumnOperation.IsOptional: IIntColumnOperation;
begin
  Result := TIntColumnOperation(inherited IsOptional);
end;

function TIntColumnOperation.IsRequired: IIntColumnOperation;
begin
  Result := TIntColumnOperation(inherited IsRequired);
end;

end.
