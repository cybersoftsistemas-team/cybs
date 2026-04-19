unit cbsMigrations.Migrations.Operations.AddComputedColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddComputedColumnOperation,
  cbsMigrations.Migrations.Operations.ComputedColumnOperation;

type
  TAddComputedColumnOperation = class(TComputedColumnOperation, IAddComputedColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IAddComputedColumnOperation;
    function HasSchema(const ASchema: string): IAddComputedColumnOperation;
    function HasSqlAs(const ASql: string): IAddComputedColumnOperation;
    function HasTable(const ATable: string): IAddComputedColumnOperation;
    function IsOptional: IAddComputedColumnOperation;
    function IsRequired: IAddComputedColumnOperation;
    function IsStored: IAddComputedColumnOperation;
  end;

implementation

{ TAddComputedColumnOperation }

function TAddComputedColumnOperation.HasColumnType(const AColumnType: string): IAddComputedColumnOperation;
begin
  Result := TAddComputedColumnOperation(inherited HasColumnType(AColumnType));
end;

function TAddComputedColumnOperation.HasSchema(const ASchema: string): IAddComputedColumnOperation;
begin
  Result := TAddComputedColumnOperation(inherited HasSchema(ASchema));
end;

function TAddComputedColumnOperation.HasSqlAs(const ASql: string): IAddComputedColumnOperation;
begin
  Result := TAddComputedColumnOperation(inherited HasSqlAs(ASql));
end;

function TAddComputedColumnOperation.HasTable(const ATable: string): IAddComputedColumnOperation;
begin
  Result := TAddComputedColumnOperation(inherited HasTable(ATable));
end;

function TAddComputedColumnOperation.IsOptional: IAddComputedColumnOperation;
begin
  Result := TAddComputedColumnOperation(inherited IsOptional);
end;

function TAddComputedColumnOperation.IsRequired: IAddComputedColumnOperation;
begin
  Result := TAddComputedColumnOperation(inherited IsRequired);
end;

function TAddComputedColumnOperation.IsStored: IAddComputedColumnOperation;
begin
  Result := TAddComputedColumnOperation(inherited IsStored);
end;

end.
