unit cbsMigrations.Migrations.Operations.DefaultConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DefaultConstraintOperation,
  cbsMigrations.Migrations.Operations.ConstraintOperation;

type
  TDefaultConstraintOperation = class(TConstraintOperation, IDefaultConstraintOperation)
  private
    FColumnName: TColumnName;
    FValue: string;
    function GetColumnName: TColumnName;
    function GetValue: string;
  protected
    procedure DoPrepare; override;
  public
    function HasColumn(const AColumnName: TColumnName): IDefaultConstraintOperation;
    function HasSchema(const ASchema: string): IDefaultConstraintOperation;
    function HasTable(const ATable: string): IDefaultConstraintOperation;
    function HasValue(const AValue: string): IDefaultConstraintOperation;
    property ColumnName: TColumnName read GetColumnName;
    property Value: string read GetValue;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TDefaultConstraintOperation }

function TDefaultConstraintOperation.GetColumnName: TColumnName;
begin
  Result := FColumnName;
end;

function TDefaultConstraintOperation.GetValue: string;
begin
  Result := FValue;
end;

function TDefaultConstraintOperation.HasColumn(const AColumnName: TColumnName): IDefaultConstraintOperation;
begin
  FColumnName := AColumnName;
  Result := Self;
end;

function TDefaultConstraintOperation.HasSchema(const ASchema: string): IDefaultConstraintOperation;
begin
  Result := TDefaultConstraintOperation(inherited HasSchema(ASchema));
end;

function TDefaultConstraintOperation.HasTable(const ATable: string): IDefaultConstraintOperation;
begin
  Result := TDefaultConstraintOperation(inherited HasTable(ATable));
end;

function TDefaultConstraintOperation.HasValue(const AValue: string): IDefaultConstraintOperation;
begin
  FValue := AValue;
  Result := Self;
end;

procedure TDefaultConstraintOperation.DoPrepare;
begin
  if not Table.Trim.IsEmpty and
    not FColumnName.Trim.IsEmpty and
    Name.Trim.IsEmpty then
  begin
    SetName(Format('%s_%s_default', [QualifiedTableName('_'), FColumnName]));
  end;
end;

end.
