unit cbsMigrations.Migrations.Operations.RenameColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.RenameColumnOperation,
  cbsMigrations.Migrations.Operations.NamedMigrationObjectOperation;

type
  TRenameColumnOperation = class(TNamedMigrationObjectOperation, IRenameColumnOperation)
  private
    FNewName: string;
    function GetNewName: string;
  public
    constructor Create(const AName, ANewName: string);
    function HasSchema(const ASchema: string): IRenameColumnOperation;
    function HasTable(const ATable: string): IRenameColumnOperation;
    property NewName: string read GetNewName;
  end;

implementation

{ TRenameColumnOperation }

constructor TRenameColumnOperation.Create(const AName, ANewName: string);
begin
  inherited Create(AName);
  FNewName := ANewName;
end;

function TRenameColumnOperation.GetNewName: string;
begin
  Result := FNewName;
end;

function TRenameColumnOperation.HasSchema(const ASchema: string): IRenameColumnOperation;
begin
  HasSchema(ASchema);
  Result := Self;
end;

function TRenameColumnOperation.HasTable(const ATable: string): IRenameColumnOperation;
begin
  SetTable(ATable);
  Result := Self;
end;

end.
