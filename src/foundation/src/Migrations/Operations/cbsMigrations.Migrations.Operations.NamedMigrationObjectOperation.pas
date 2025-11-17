unit cbsMigrations.Migrations.Operations.NamedMigrationObjectOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.NamedMigrationObjectOperation,
  cbsMigrations.Migrations.Operations.MigrationObjectOperation;

type
  TNamedMigrationObjectOperation = class(TMigrationObjectOperation, INamedMigrationObjectOperation)
  private
    FName: string;
    function GetName: string;
  protected
    procedure DoPrepare; override;
    procedure SetName(const AValue: string);
  public
    constructor Create(const AName: string);
    property Name: string read GetName;
  end;

implementation

{ TNamedMigrationObjectOperation }

constructor TNamedMigrationObjectOperation.Create(const AName: string);
begin
  inherited Create;
  SetName(AName);
end;

procedure TNamedMigrationObjectOperation.DoPrepare;
begin
  // This method can be overwritten by inherited classes.
end;

function TNamedMigrationObjectOperation.GetName: string;
begin
  Result := FName;
end;

procedure TNamedMigrationObjectOperation.SetName(const AValue: string);
begin
  FName := AValue;
end;

end.
