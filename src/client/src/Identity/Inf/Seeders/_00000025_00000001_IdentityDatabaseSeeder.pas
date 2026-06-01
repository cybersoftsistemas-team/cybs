unit _00000025_00000001_IdentityDatabaseSeeder;

interface

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeeder,
  Identity.Inf.Seeders.damDbSeed;

type
  TIdentityDatabaseSeeder = class(TcbsDatabaseSeeder<TdamIdentityDbSeed>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TIdentityDatabaseSeeder);
end;

end.