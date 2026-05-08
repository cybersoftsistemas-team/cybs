unit _00002001_DatabaseCrmSeeder;

interface

uses
{PROJECT}
  cbsBusiness.crm.inf.Seeders.damDbCrmSeed,
  cbsSystem.Database.Seeders.DatabaseSeeder;

type
  TcbsBusinessDatabaseCrmSeeder = class(TcbsDatabaseSeeder<TdamDbCrmSeed>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TcbsBusinessDatabaseCrmSeeder);
end;

end.
