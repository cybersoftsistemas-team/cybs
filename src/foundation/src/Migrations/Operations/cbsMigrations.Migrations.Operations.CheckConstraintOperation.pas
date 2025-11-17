unit cbsMigrations.Migrations.Operations.CheckConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.CheckConstraintOperation,
  cbsMigrations.Migrations.Operations.ConstraintOperation;

type
  TCheckConstraintOperation = class(TConstraintOperation, ICheckConstraintOperation)
  private
    FSql: string;
    function GetSql: string;
  protected
    procedure DoPrepare; override;
  public
    constructor Create(const AName, ASql: string);
    function HasSchema(const ASchema: string): ICheckConstraintOperation;
    function HasTable(const ATable: string): ICheckConstraintOperation;
    property Sql: string read GetSql;
  end;

implementation

{ TCheckConstraintOperation }

constructor TCheckConstraintOperation.Create(const AName, ASql: string);
begin
  inherited Create(AName);
  FSql := ASql;
end;

function TCheckConstraintOperation.GetSql: string;
begin
  Result := FSql;
end;

function TCheckConstraintOperation.HasSchema(const ASchema: string): ICheckConstraintOperation;
begin
  Result := TCheckConstraintOperation(inherited HasSchema(ASchema));
end;

function TCheckConstraintOperation.HasTable(const ATable: string): ICheckConstraintOperation;
begin
  Result := TCheckConstraintOperation(inherited HasTable(ATable));
end;

procedure TCheckConstraintOperation.DoPrepare;
begin
  // This method can be overwritten by inherited classes.
end;

end.
