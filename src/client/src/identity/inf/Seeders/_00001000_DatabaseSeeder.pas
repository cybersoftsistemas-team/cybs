unit _00001000_DatabaseSeeder;

interface

uses
{PROJECT}
  cbsUAuth.identity.inf.Seeders.damDbIdentitySeed,
  cbsSystem.Database.Seeders.DatabaseSeeder;

type
  TcbsUAuthDatabaseIdentitySeeder = class(TcbsDatabaseSeeder<TdamDbIdentitySeed>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TcbsUAuthDatabaseIdentitySeeder);
end;

end.
