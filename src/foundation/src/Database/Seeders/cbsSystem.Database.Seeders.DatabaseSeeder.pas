unit cbsSystem.Database.Seeders.DatabaseSeeder;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Database.Seeders.DatabaseSeeder,
  cbsSystem.Database.Seeders.DatabaseSeederModule;

type
  TcbsDatabaseSeeder = class(TInterfacedObject, IDatabaseSeeder)
  strict private
    TDbSeeder: DatabaseSeederModuleType;
  strict protected
    constructor Create(const ADatabaseSeederModuleType: DatabaseSeederModuleType);
    procedure OnRun; virtual;
  public
    procedure Run;
  end;

  DatabaseSeederType = class of TcbsDatabaseSeeder;

  TcbsDatabaseSeeder<T: TDatabaseSeederModule> = class(TcbsDatabaseSeeder, IDatabaseSeeder<T>)
  public
    constructor Create;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TcbsDatabaseSeeder }

constructor TcbsDatabaseSeeder.Create(const ADatabaseSeederModuleType: DatabaseSeederModuleType);
begin
  inherited Create;
  TDbSeeder := ADatabaseSeederModuleType;
end;

procedure TcbsDatabaseSeeder.OnRun;
begin
  if Assigned(TDbSeeder) then
  begin
    var LDbSeeder := TDbSeeder.Create(nil);
    try
      LDbSeeder.RunSeed;
    finally
      FreeAndNil(LDbSeeder);
    end;
  end;
end;

procedure TcbsDatabaseSeeder.Run;
begin
  OnRun;
end;

{ TcbsDatabaseSeeder<T> }

constructor TcbsDatabaseSeeder<T>.Create;
begin
  inherited Create(T);
end;

end.
