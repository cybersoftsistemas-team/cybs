unit _00002000_DatabaseDomainSeeder;

interface

uses
{PROJECT}
  cbsBusiness.domain.inf.Seeders.damDbDomainSeed,
  cbsSystem.Database.Seeders.DatabaseSeeder;

type
  TcbsBusinessDatabaseDomainSeeder = class(TcbsDatabaseSeeder<TdamDbDomainSeed>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TcbsBusinessDatabaseDomainSeeder);
end;

end.
