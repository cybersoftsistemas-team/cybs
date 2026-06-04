unit _00000045_00000001_CatalogDatabaseSeeder;

interface

uses
{PROJECT}
  Catalog.Inf.Seeders.damDbSeed,
  cbsSystem.Database.Seeders.DatabaseSeeder;

type
  TCatalogDatabaseSeeder = class(TcbsDatabaseSeeder<TdamCatalogDbSeed>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TCatalogDatabaseSeeder);
end;

end.
