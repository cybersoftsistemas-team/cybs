unit cbsMigrations.Migrations.Operations.IntColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.IntColumnOperation,
  cbsMigrations.Migrations.Operations.CustomNumberColumnOperation;

type
  TIntColumnOperation = class(TCustomNumberColumnOperation, IIntColumnOperation)
  private
    FIncrement: Integer;
    FIsIncrement: Boolean;
    FSeed: Integer;
  public
    function HasColumnType(const AColumnType: string): IIntColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IIntColumnOperation;
    function HasIncrement(const ASeed: Integer = 1; const AIncrement: Integer = 1): IIntColumnOperation;
    function HasSchema(const ASchema: string): IIntColumnOperation;
    function HasTable(const ATable: string): IIntColumnOperation;
    function Increment: Integer;
    function IsIncrement: Boolean;
    function IsOptional: IIntColumnOperation;
    function IsRequired: IIntColumnOperation;
    function Seed: Integer;
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

function TIntColumnOperation.HasIncrement(const ASeed, AIncrement: Integer): IIntColumnOperation;
begin
  FIncrement := AIncrement;
  FIsIncrement := True;
  FSeed := ASeed;
  Result := Self;
end;

function TIntColumnOperation.HasSchema(const ASchema: string): IIntColumnOperation;
begin
  Result := TIntColumnOperation(inherited HasSchema(ASchema));
end;

function TIntColumnOperation.HasTable(const ATable: string): IIntColumnOperation;
begin
  Result := TIntColumnOperation(inherited HasTable(ATable));
end;

function TIntColumnOperation.Increment: Integer;
begin
  Result := FIncrement;
end;

function TIntColumnOperation.IsIncrement: Boolean;
begin
  Result := FIsIncrement;
end;

function TIntColumnOperation.IsOptional: IIntColumnOperation;
begin
  Result := TIntColumnOperation(inherited IsOptional);
end;

function TIntColumnOperation.IsRequired: IIntColumnOperation;
begin
  Result := TIntColumnOperation(inherited IsRequired);
end;

function TIntColumnOperation.Seed: Integer;
begin
  Result := FSeed;
end;

end.
