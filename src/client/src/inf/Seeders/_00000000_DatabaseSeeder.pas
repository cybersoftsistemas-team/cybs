unit _00000000_DatabaseSeeder;

interface

uses
{PROJECT}
  cbsMain.inf.DbSeedModule,
  cbsSystem.Database.Seeders.DatabaseSeeder;

type
  TcbsMainDatabaseSeeder = class(TcbsDatabaseSeeder<TdamDbSeed>);

implementation

end.
