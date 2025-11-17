unit cbsMigrations.Migrations.Operations.GuidColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.GuidColumnOperation,
  cbsMigrations.Migrations.Operations.CustomStringColumnOperation;

type
  TGuidColumnOperation = class(TCustomStringColumnOperation, IGuidColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IGuidColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IGuidColumnOperation;
    function HasSchema(const ASchema: string): IGuidColumnOperation;
    function HasTable(const ATable: string): IGuidColumnOperation;
    function IsOptional: IGuidColumnOperation;
    function IsRequired: IGuidColumnOperation;
  end;

implementation

{ TGuidColumnOperation }

function TGuidColumnOperation.HasColumnType(const AColumnType: string): IGuidColumnOperation;
begin
  Result := TGuidColumnOperation(inherited HasColumnType(AColumnType));
end;

function TGuidColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IGuidColumnOperation;
begin
  Result := TGuidColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TGuidColumnOperation.HasSchema(const ASchema: string): IGuidColumnOperation;
begin
  Result := TGuidColumnOperation(inherited HasSchema(ASchema));
end;

function TGuidColumnOperation.HasTable(const ATable: string): IGuidColumnOperation;
begin
  Result := TGuidColumnOperation(inherited HasTable(ATable));
end;

function TGuidColumnOperation.IsOptional: IGuidColumnOperation;
begin
  Result := TGuidColumnOperation(inherited IsOptional);
end;

function TGuidColumnOperation.IsRequired: IGuidColumnOperation;
begin
  Result := TGuidColumnOperation(inherited IsRequired);
end;

end.
