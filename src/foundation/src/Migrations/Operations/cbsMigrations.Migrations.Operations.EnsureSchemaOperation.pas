unit cbsMigrations.Migrations.Operations.EnsureSchemaOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.EnsureSchemaOperation,
  cbsMigrations.Migrations.Operations.MigrationOperation;

type
  TEnsureSchemaOperation = class(TMigrationOperation, IEnsureSchemaOperation)
  private
    FName: string;
    function GetName: string;
  protected
    procedure DoPrepare; override;
  public
    constructor Create(const AName: string);
    property Name: string read GetName;
  end;

implementation

{ TEnsureSchemaOperation }

constructor TEnsureSchemaOperation.Create(const AName: string);
begin
  inherited Create;
  FName := AName;
end;

function TEnsureSchemaOperation.GetName: string;
begin
  Result := FName;
end;

procedure TEnsureSchemaOperation.DoPrepare;
begin
  // This method can be overwritten by inherited classes.
end;

end.
