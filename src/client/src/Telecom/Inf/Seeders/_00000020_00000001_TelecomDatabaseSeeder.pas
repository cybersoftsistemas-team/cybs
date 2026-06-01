unit _00000020_00000001_TelecomDatabaseSeeder;

interface

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeeder,
  Telecom.Inf.Seeders.damDbSeed;

type
  TTelecomDatabaseSeeder = class(TcbsDatabaseSeeder<TdamTelecomDbSeed>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TTelecomDatabaseSeeder);
end;

end.
