unit cbsMigrations.Migrations.Operations.DropSchemaOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DropSchemaOperation,
  cbsMigrations.Migrations.Operations.MigrationOperation;

type
  TDropSchemaOperation = class(TMigrationOperation, IDropSchemaOperation)
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

{ TDropSchemaOperation }

constructor TDropSchemaOperation.Create(const AName: string);
begin
  inherited Create;
  FName := AName;
end;

function TDropSchemaOperation.GetName: string;
begin
  Result := FName;
end;

procedure TDropSchemaOperation.DoPrepare;
begin
  // This method can be overwritten by inherited classes.
end;

end.
