unit cbsSystem.Migrations.MigrationContextTypeRepository;

interface

uses
{PROJECT}
  cbsMigrationsFireDac.Migrations.MigrationContextBase,
  cbsSystem.Contracts.Migrations.MigrationContextTypeRepository,
  cbsSystem.Infrastructure.BaseDbModule;

type
  TcbsMigrationContextTypeRepository = class(TInterfacedObject, IMigrationContextTypeRepository)
  private
    FDbConnectionModuleType: DbConnectionModuleType;
    FMigrationContextType: MigrationContextType;
  public
    function GetDbConnectionModuleType: DbConnectionModuleType;
    function GetMigrationContextType: MigrationContextType;
    procedure Register(const AMigrationContextType: MigrationContextType); overload;
    procedure Register(const AMigrationContextType: MigrationContextType; const ADbConnectionModuleType: DbConnectionModuleType); overload;
  end;

implementation

{ TcbsMigrationContextTypeRepository }

function TcbsMigrationContextTypeRepository.GetDbConnectionModuleType: DbConnectionModuleType;
begin
  Result := FDbConnectionModuleType;
end;

function TcbsMigrationContextTypeRepository.GetMigrationContextType: MigrationContextType;
begin
  Result := FMigrationContextType;
end;

procedure TcbsMigrationContextTypeRepository.Register(const AMigrationContextType: MigrationContextType);
begin
  FMigrationContextType := AMigrationContextType;
end;

procedure TcbsMigrationContextTypeRepository.Register(const AMigrationContextType: MigrationContextType; const ADbConnectionModuleType: DbConnectionModuleType);
begin
  Register(AMigrationContextType);
  FDbConnectionModuleType := ADbConnectionModuleType;
end;

end.
