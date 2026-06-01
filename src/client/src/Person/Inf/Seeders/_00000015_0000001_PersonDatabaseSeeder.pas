unit _00000015_0000001_PersonDatabaseSeeder;

interface

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeeder,
  Person.Inf.Seeders.damDbSeed;

type
  TPersonDatabaseSeeder = class(TcbsDatabaseSeeder<TdamPersonDbSeed>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TPersonDatabaseSeeder);
end;

end.
