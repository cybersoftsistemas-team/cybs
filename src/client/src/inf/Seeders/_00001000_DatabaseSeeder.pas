unit _00001000_DatabaseSeeder;

interface

uses
{PROJECT}
  cbsUAuth.inf.DbSeedModule,
  cbsSystem.Database.Seeders.DatabaseSeeder;

type
  TcbsUAuthDatabaseSeeder = class(TcbsDatabaseSeeder<TdamDbSeed>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TcbsUAuthDatabaseSeeder);
end;

end.
