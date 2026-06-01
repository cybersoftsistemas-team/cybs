unit _00000005_00000001_CountryDatabaseSeeder;

interface

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeeder,
  Country.Inf.Seeders.damDbSeed;

type
  TCountryDatabaseSeeder = class(TcbsDatabaseSeeder<TdamCountryDbSeed>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TCountryDatabaseSeeder);
end;

end.
