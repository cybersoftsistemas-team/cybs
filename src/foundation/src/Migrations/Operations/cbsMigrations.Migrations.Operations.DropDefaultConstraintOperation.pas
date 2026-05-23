unit cbsMigrations.Migrations.Operations.DropDefaultConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DropDefaultConstraintOperation,
  cbsMigrations.Migrations.Operations.MigrationObjectOperation;

type
  TDropDefaultConstraintOperation = class(TMigrationObjectOperation, IDropDefaultConstraintOperation)
  private
    FColumnName: TColumnName;
    function GetColumnName: TColumnName;
    procedure HasColumn(const AColumnName: TColumnName);
  protected
    procedure DoPrepare; override;
  public
    constructor Create(const AColumnName: TColumnName);
    function HasSchema(const ASchema: string): IDropDefaultConstraintOperation;
    function HasTable(const ATable: string): IDropDefaultConstraintOperation;
    property ColumnName: TColumnName read GetColumnName;
  end;

implementation

{ TDropDefaultConstraintOperation }

constructor TDropDefaultConstraintOperation.Create(const AColumnName: TColumnName);
begin
  inherited Create;
  HasColumn(AColumnName);
end;

function TDropDefaultConstraintOperation.GetColumnName: TColumnName;
begin
  Result := FColumnName;
end;

function TDropDefaultConstraintOperation.HasSchema(const ASchema: string): IDropDefaultConstraintOperation;
begin
  SetSchema(ASchema);
  Result := Self;
end;

function TDropDefaultConstraintOperation.HasTable(const ATable: string): IDropDefaultConstraintOperation;
begin
  SetTable(ATable);
  Result := Self;
end;

procedure TDropDefaultConstraintOperation.DoPrepare;
begin
  // This method can be overwritten by inherited classes.
end;

procedure TDropDefaultConstraintOperation.HasColumn(const AColumnName: TColumnName);
begin
  FColumnName := AColumnName;
end;

end.
