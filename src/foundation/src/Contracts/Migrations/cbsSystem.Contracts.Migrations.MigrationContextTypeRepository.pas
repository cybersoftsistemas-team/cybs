unit cbsSystem.Contracts.Migrations.MigrationContextTypeRepository;

interface

uses
{PROJECT}
  cbsMigrationsFireDac.Migrations.MigrationContextBase,
  cbsSystem.Infrastructure.BaseDbModule;

type
  IMigrationContextTypeRepository = interface(IUnknown)
    ['{E65177FB-D37C-4424-BAB0-5AD0C9CC86D0}']
    function GetDbConnectionModuleType: DbConnectionModuleType;
    function GetMigrationContextType: MigrationContextType;
    procedure Register(const AMigrationContextType: MigrationContextType); overload;
    procedure Register(const AMigrationContextType: MigrationContextType; const ADbConnectionModuleType: DbConnectionModuleType); overload;
  end;

implementation

end.
