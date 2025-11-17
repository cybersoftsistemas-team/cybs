unit cbsMigrations.Migrations.Operations.AddGuidColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddGuidColumnOperation,
  cbsMigrations.Migrations.Operations.GuidColumnOperation;

type
  TAddGuidColumnOperation = class(TGuidColumnOperation, IAddGuidColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IAddGuidColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddGuidColumnOperation;
    function HasSchema(const ASchema: string): IAddGuidColumnOperation;
    function HasTable(const ATable: string): IAddGuidColumnOperation;
    function IsOptional: IAddGuidColumnOperation;
    function IsRequired: IAddGuidColumnOperation;
  end;

implementation

{ TAddGuidColumnOperation }

function TAddGuidColumnOperation.HasColumnType(const AColumnType: string): IAddGuidColumnOperation;
begin
  Result := TAddGuidColumnOperation(inherited HasColumnType(AColumnType));
end;

function TAddGuidColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IAddGuidColumnOperation;
begin
  Result := TAddGuidColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TAddGuidColumnOperation.HasSchema(const ASchema: string): IAddGuidColumnOperation;
begin
  Result := TAddGuidColumnOperation(inherited HasSchema(ASchema));
end;

function TAddGuidColumnOperation.HasTable(const ATable: string): IAddGuidColumnOperation;
begin
  Result := TAddGuidColumnOperation(inherited HasTable(ATable));
end;

function TAddGuidColumnOperation.IsOptional: IAddGuidColumnOperation;
begin
  Result := TAddGuidColumnOperation(inherited IsOptional);
end;

function TAddGuidColumnOperation.IsRequired: IAddGuidColumnOperation;
begin
  Result := TAddGuidColumnOperation(inherited IsRequired);
end;

end.
