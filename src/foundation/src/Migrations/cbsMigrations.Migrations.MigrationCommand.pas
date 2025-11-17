unit cbsMigrations.Migrations.MigrationCommand;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.CommandBuilder,
  cbsMigrations.Contracts.Migrations.MigrationCommand;

type
  TMigrationCommand = class(TInterfacedObject, IMigrationCommand)
  private
    FCommandText: TCommandText;
    function GetCommandText: TCommandText;
  public
    constructor Create(const ACommandText: TCommandText);
    destructor Destroy; override;
    property CommandText: TCommandText read GetCommandText;
  end;

implementation

{ TMigrationCommand }

constructor TMigrationCommand.Create(const ACommandText: TCommandText);
begin
  inherited Create;
  FCommandText := ACommandText;
end;

destructor TMigrationCommand.Destroy;
begin
  FCommandText := '';
  inherited;
end;

function TMigrationCommand.GetCommandText: TCommandText;
begin
  Result := FCommandText;
end;

end.
