unit _00000300_0000001_DomainDatabaseSeeder;

interface

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeeder,
  Domain.Inf.Seeders.damDbSeeder;

type
  TDomainDatabaseSeeder = class(TcbsDatabaseSeeder<TdamDomainDbSeeder>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TDomainDatabaseSeeder);
end;

end.
