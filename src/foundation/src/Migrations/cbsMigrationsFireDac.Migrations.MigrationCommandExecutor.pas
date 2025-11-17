unit cbsMigrationsFireDac.Migrations.MigrationCommandExecutor;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationCommandListBuilder,
  cbsMigrations.Migrations.MigrationCommandExecutor,
  cbsMigrationsFireDac.Contracts.Migrations.MigrationCommandExecutor,
  cbsMigrationsFireDac.Contracts.Migrations.ConnectionResolver;

type
  TFDMigrationCommandExecutor = class(TMigrationCommandExecutor, IFDMigrationCommandExecutor)
  private
    function GetResolver: IFDConnectionResolver;
  protected
    property Resolver: IFDConnectionResolver read GetResolver;
  public
    constructor Create(const AResolver: IFDConnectionResolver);
    procedure ExecuteNonQuery(const AMigrationCommands: IMigrationCommands); override;
  end;

implementation

uses
  System.SysUtils,
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationCommand,
  cbsMigrationsFireDac.Migrations.ConnectionResolver;

{ TFDMigrationCommandExecutor }

constructor TFDMigrationCommandExecutor.Create(const AResolver: IFDConnectionResolver);
begin
  inherited Create(AResolver);
end;

function TFDMigrationCommandExecutor.GetResolver: IFDConnectionResolver;
begin
  Result := TFDConnectionResolver(inherited Resolver);
end;

procedure TFDMigrationCommandExecutor.ExecuteNonQuery(const AMigrationCommands: IMigrationCommands);
begin
  if not Assigned(AMigrationCommands) then
  begin
    Exit;
  end;
  AMigrationCommands.ForEach(
    procedure(const AMigrationCommand: IMigrationCommand)
    var
      LCommand: TCommand;
    begin
      LCommand := Resolver.CreateCommand;
      try
        LCommand.ExecSQL(AMigrationCommand.CommandText);
      finally
        FreeAndNil(LCommand);
      end;
    end);
end;

end.
