unit _00000100_00000001_AddressDatabaseSeeder;

interface

uses
{PROJECT}
  Address.Inf.Seeders.damDbSeed,
  cbsSystem.Database.Seeders.DatabaseSeeder;

type
  TAddressDatabaseSeeder = class(TcbsDatabaseSeeder<TdamAddressDbSeed>);

implementation

uses
{PROJECT}
  cbsSystem.Support.DatabaseSeeder;

initialization
begin
  RegisterDatabaseSeeder(TAddressDatabaseSeeder);
end;

end.
