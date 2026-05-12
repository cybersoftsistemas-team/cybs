unit _00000000_00000001_GeneralDatabaseSeeder;

interface

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeeder,
  General.Inf.Seeders.damDbSeed;

type
  TGeneralDatabaseSeeder = class(TcbsDatabaseSeeder<TdamGeneralDbSeed>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TGeneralDatabaseSeeder);
end;

end.
