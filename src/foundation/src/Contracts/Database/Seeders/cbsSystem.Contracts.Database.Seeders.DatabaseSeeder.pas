unit cbsSystem.Contracts.Database.Seeders.DatabaseSeeder;

interface

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeederModule;

type
  IDatabaseSeeder = interface(IUnknown)
    ['{14E4B114-87F4-4C60-B287-313802A600AE}']
    procedure Run;
  end;

  IDatabaseSeeder<T: TDatabaseSeederModule> = interface(IDatabaseSeeder)
    ['{4A9A72CE-47BE-4BA7-A674-ABABB289AFD2}']
  end;

implementation

end.
