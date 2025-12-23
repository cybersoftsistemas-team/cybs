unit cbsSystem.Support.DatabaseSeeder;

interface

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeeder;

  procedure RegisterDatabaseSeeder(const ADatabaseSeederType: DatabaseSeederType);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeederTypeRepository;

procedure RegisterDatabaseSeeder(const ADatabaseSeederType: DatabaseSeederType);
begin
  DatabaseSeederTypeRepository.Register(ADatabaseSeederType);
end;

end.
