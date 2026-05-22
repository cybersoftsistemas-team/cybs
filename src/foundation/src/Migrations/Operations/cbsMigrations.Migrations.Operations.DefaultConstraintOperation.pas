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
    procedure HasColumn(const AColumnName: TColumnName);
    procedure HasValue(const AValue: string);
  protected
    procedure DoPrepare; override;
  public
    constructor Create(const AName: string; const AColumnName: TColumnName; const AValue: string);
    function HasSchema(const ASchema: string): IDefaultConstraintOperation;
    function HasTable(const ATable: string): IDefaultConstraintOperation;
    property ColumnName: TColumnName read GetColumnName;
    property Value: string read GetValue;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TDefaultConstraintOperation }

constructor TDefaultConstraintOperation.Create(const AName: string; const AColumnName: TColumnName; const AValue: string);
begin
  inherited Create(AName);
  HasColumn(AColumnName);
  HasValue(AValue);
end;

function TDefaultConstraintOperation.GetColumnName: TColumnName;
begin
  Result := FColumnName;
end;

function TDefaultConstraintOperation.GetValue: string;
begin
  Result := FValue;
end;

function TDefaultConstraintOperation.HasSchema(const ASchema: string): IDefaultConstraintOperation;
begin
  Result := TDefaultConstraintOperation(inherited HasSchema(ASchema));
end;

function TDefaultConstraintOperation.HasTable(const ATable: string): IDefaultConstraintOperation;
begin
  Result := TDefaultConstraintOperation(inherited HasTable(ATable));
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

procedure TDefaultConstraintOperation.HasColumn(const AColumnName: TColumnName);
begin
  FColumnName := AColumnName;
end;

procedure TDefaultConstraintOperation.HasValue(const AValue: string);
begin
  FValue := AValue;
end;

end.
