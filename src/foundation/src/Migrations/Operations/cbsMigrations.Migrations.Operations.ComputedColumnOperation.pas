unit cbsMigrations.Migrations.Operations.ComputedColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ComputedColumnOperation,
  cbsMigrations.Migrations.Operations.ColumnOperation;

type
  TComputedColumnOperation = class(TColumnOperation, IComputedColumnOperation)
  private
    FSql: string;
    FStored: Boolean;
    function GetSql: string;
    function GetStored: Boolean;
  public
    function HasColumnType(const AColumnType: string): IComputedColumnOperation;
    function HasSchema(const ASchema: string): IComputedColumnOperation;
    function HasSqlAs(const ASql: string): IComputedColumnOperation;
    function HasTable(const ATable: string): IComputedColumnOperation;
    function IsOptional: IComputedColumnOperation;
    function IsRequired: IComputedColumnOperation;
    function IsStored: IComputedColumnOperation;
    property Sql: string read GetSql;
    property Stored: Boolean read GetStored;
  end;

implementation

uses
  System.SysUtils;

{ TComputedColumnOperation }

function TComputedColumnOperation.GetSql: string;
begin
  Result := FSql;
end;

function TComputedColumnOperation.GetStored: Boolean;
begin
  Result := FStored;
end;

function TComputedColumnOperation.HasColumnType(const AColumnType: string): IComputedColumnOperation;
begin
  Result := TComputedColumnOperation(inherited HasColumnType(AColumnType));
end;

function TComputedColumnOperation.HasSchema(const ASchema: string): IComputedColumnOperation;
begin
  Result := TComputedColumnOperation(inherited HasSchema(ASchema));
end;

function TComputedColumnOperation.HasSqlAs(const ASql: string): IComputedColumnOperation;
begin
  FSql := ASql;
  Result := Self;
end;

function TComputedColumnOperation.HasTable(const ATable: string): IComputedColumnOperation;
begin
  Result := TComputedColumnOperation(inherited HasTable(ATable));
end;

function TComputedColumnOperation.IsOptional: IComputedColumnOperation;
begin
  Result := TComputedColumnOperation(inherited IsOptional);
end;

function TComputedColumnOperation.IsRequired: IComputedColumnOperation;
begin
  Result := TComputedColumnOperation(inherited IsRequired);
end;

function TComputedColumnOperation.IsStored: IComputedColumnOperation;
begin
  FStored := True;
  Result := Self;
end;

end.
