unit cbsMigrations.Contracts.Migrations.MigrationTypesRepository;

interface

uses
{PROJECT}
  cbsMigrations.Migrations.MigrationContext,
  cbsMigrations.Migrations.MigrationTypes;

type
  IMigrationTypesRepository = interface(IUnknown)
    ['{DB1281E2-89DC-4024-ADCE-54560EFF830F}']
    function GetMigrationTypes(const AMigrationContext: TMigrationContext): IMigrationTypes;
    procedure Register(const AMigrationContextType: MigrationContextType; const AMigrationTypes: MigrationTypes);
  end;

implementation

end.
