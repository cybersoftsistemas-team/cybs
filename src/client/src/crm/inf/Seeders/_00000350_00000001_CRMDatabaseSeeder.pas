unit _00000350_00000001_CRMDatabaseSeeder;

interface

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeeder,
  CRM.Inf.Seeders.damDbSeeder;

type
  TCRMDatabaseSeeder = class(TcbsDatabaseSeeder<TdamCRMDbSeeder>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TCRMDatabaseSeeder);
end;

end.
