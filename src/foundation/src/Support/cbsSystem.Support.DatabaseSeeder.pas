unit cbsSystem.Support.DatabaseSeeder;

interface

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeeder;

  procedure RegisterDatabaseSeeder(const ADatabaseSeederType: DatabaseSeederType);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeederRepository;

procedure RegisterDatabaseSeeder(const ADatabaseSeederType: DatabaseSeederType);
begin
  DatabaseSeederRepository.Register(ADatabaseSeederType);
end;

end.
