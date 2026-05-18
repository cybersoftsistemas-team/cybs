unit _00000300_0000001_DomainDatabaseSeeder;

interface

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeeder,
  Domain.Inf.Seeders.damDbSeed;

type
  TDomainDatabaseSeeder = class(TcbsDatabaseSeeder<TdamDomainDbSeed>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TDomainDatabaseSeeder);
end;

end.
