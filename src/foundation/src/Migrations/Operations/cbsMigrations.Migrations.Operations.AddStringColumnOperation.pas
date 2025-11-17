unit cbsMigrations.Migrations.Operations.AddStringColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddStringColumnOperation,
  cbsMigrations.Migrations.Operations.StringColumnOperation;

type
  TAddStringColumnOperation = class(TStringColumnOperation, IAddStringColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IAddStringColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddStringColumnOperation;
    function HasMaxLength(const ALength: Integer): IAddStringColumnOperation;
    function HasSchema(const ASchema: string): IAddStringColumnOperation;
    function HasTable(const ATable: string): IAddStringColumnOperation;
    function HasUnicode(const AUnicode: Boolean): IAddStringColumnOperation;
    function IsFixedLength: IAddStringColumnOperation;
    function IsMaxLength: IAddStringColumnOperation;
    function IsOptional: IAddStringColumnOperation;
    function IsRequired: IAddStringColumnOperation;
    function IsVariableLength: IAddStringColumnOperation;
  end;

implementation

{ TAddStringColumnOperation }

function TAddStringColumnOperation.HasColumnType(const AColumnType: string): IAddStringColumnOperation;
begin
  Result := TAddStringColumnOperation(inherited HasColumnType(AColumnType));
end;

function TAddStringColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IAddStringColumnOperation;
begin
  Result := TAddStringColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TAddStringColumnOperation.HasMaxLength(const ALength: Integer): IAddStringColumnOperation;
begin
  Result := TAddStringColumnOperation(inherited HasMaxLength(ALength));
end;

function TAddStringColumnOperation.HasSchema(const ASchema: string): IAddStringColumnOperation;
begin
  Result := TAddStringColumnOperation(inherited HasSchema(ASchema));
end;

function TAddStringColumnOperation.HasTable(const ATable: string): IAddStringColumnOperation;
begin
  Result := TAddStringColumnOperation(inherited HasTable(ATable));
end;

function TAddStringColumnOperation.HasUnicode(const AUnicode: Boolean): IAddStringColumnOperation;
begin
  Result := TAddStringColumnOperation(inherited HasUnicode(AUnicode));
end;

function TAddStringColumnOperation.IsFixedLength: IAddStringColumnOperation;
begin
  Result := TAddStringColumnOperation(inherited IsFixedLength);
end;

function TAddStringColumnOperation.IsMaxLength: IAddStringColumnOperation;
begin
  Result := TAddStringColumnOperation(inherited IsMaxLength);
end;

function TAddStringColumnOperation.IsOptional: IAddStringColumnOperation;
begin
  Result := TAddStringColumnOperation(inherited IsOptional);
end;

function TAddStringColumnOperation.IsRequired: IAddStringColumnOperation;
begin
  Result := TAddStringColumnOperation(inherited IsRequired);
end;

function TAddStringColumnOperation.IsVariableLength: IAddStringColumnOperation;
begin
  Result := TAddStringColumnOperation(inherited IsVariableLength);
end;

end.
