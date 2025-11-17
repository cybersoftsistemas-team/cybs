unit cbsMigrations.Migrations.Operations.DropTableOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DropTableOperation,
  cbsMigrations.Migrations.Operations.MigrationObjectOperation;

type
  TDropTableOperation = class(TMigrationObjectOperation, IDropTableOperation)
  protected
    procedure DoPrepare; override;
  public
    constructor Create(const ATable: string);
    function HasSchema(const ASchema: string): IDropTableOperation;
  end;

implementation

{ TDropTableOperation }

constructor TDropTableOperation.Create(const ATable: string);
begin
  inherited Create;
  SetTable(ATable);
end;

function TDropTableOperation.HasSchema(const ASchema: string): IDropTableOperation;
begin
  SetSchema(ASchema);
  Result := Self;
end;

procedure TDropTableOperation.DoPrepare;
begin
  // This method can be overwritten by inherited classes.
end;

end.
