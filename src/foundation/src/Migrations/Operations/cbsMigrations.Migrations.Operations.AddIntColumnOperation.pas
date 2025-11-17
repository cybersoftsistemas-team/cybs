unit cbsMigrations.Migrations.Operations.AddIntColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddIntColumnOperation,
  cbsMigrations.Migrations.Operations.IntColumnOperation;

type
  TAddIntColumnOperation = class(TIntColumnOperation, IAddIntColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IAddIntColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddIntColumnOperation;
    function HasSchema(const ASchema: string): IAddIntColumnOperation;
    function HasTable(const ATable: string): IAddIntColumnOperation;
    function IsOptional: IAddIntColumnOperation;
    function IsRequired: IAddIntColumnOperation;
  end;

implementation

{ TAddIntColumnOperation }

function TAddIntColumnOperation.HasColumnType(const AColumnType: string): IAddIntColumnOperation;
begin
  Result := TAddIntColumnOperation(inherited HasColumnType(AColumnType));
end;

function TAddIntColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IAddIntColumnOperation;
begin
  Result := TAddIntColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TAddIntColumnOperation.HasSchema(const ASchema: string): IAddIntColumnOperation;
begin
  Result := TAddIntColumnOperation(inherited HasSchema(ASchema));
end;

function TAddIntColumnOperation.HasTable(const ATable: string): IAddIntColumnOperation;
begin
  Result := TAddIntColumnOperation(inherited HasTable(ATable));
end;

function TAddIntColumnOperation.IsOptional: IAddIntColumnOperation;
begin
  Result := TAddIntColumnOperation(inherited IsOptional);
end;

function TAddIntColumnOperation.IsRequired: IAddIntColumnOperation;
begin
  Result := TAddIntColumnOperation(inherited IsRequired);
end;

end.
