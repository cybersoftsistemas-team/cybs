unit _00000350_00000001_CRMDatabaseSeeder;

interface

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeeder,
  CRM.Inf.Seeders.damDbSeed;

type
  TCRMDatabaseSeeder = class(TcbsDatabaseSeeder<TdamCRMDbSeed>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TCRMDatabaseSeeder);
end;

end.
