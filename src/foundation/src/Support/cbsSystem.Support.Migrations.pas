unit cbsSystem.Support.Migrations;

interface

uses
{PROJECT}
  cbsMigrations.Migrations.MigrationContext,
  cbsSystem.Contracts.Migrations,
  cbsSystem.Infrastructure.BaseDbModule;

  function Migrations: IMigrations;
  procedure RegisterMigrationContextClass(const AMigrationContextType: MigrationContextType; const ADbConnectionModuleClass: TDbConnectionModuleClass);

implementation

uses
{IDE}
  System.SysUtils,
  uniGUIApplication,
{PROJECT}
  cbsSystem.Migrations,
  cbsSystem.Support.Module;

var
  GMigrations: IMigrations = nil;
  TdamDb: TDbConnectionModuleClass = nil;
  TDbContext: MigrationContextType = nil;

function Migrations: IMigrations;
begin
  Result := GMigrations;
end;

procedure ExecuteMigrations;
begin
  if not Assigned(TdamDb) or
    not Assigned(TDbContext) then
  begin
    Exit;
  end;
  var LdamDb := TdamDb.Create(UniApplication);
  try
    LdamDb.Connection.StartTransaction;
    try
      var LDbContext := TDbContext.Create;
      try
        LDbContext.Connection := LdamDb.Connection;
        LDbContext.UpdateDatabase(LdamDb.RunSeed);
      finally
        FreeAndNil(LDbContext);
      end;
      LdamDb.Connection.Commit;
    except
      LdamDb.Connection.Rollback;
      raise;
    end;
  finally
    FreeAndNil(LdamDb);
  end;
end;

procedure RegisterMigrationContextClass(const AMigrationContextType: MigrationContextType; const ADbConnectionModuleClass: TDbConnectionModuleClass);
begin
  TdamDb := ADbConnectionModuleClass;
  TDbContext := AMigrationContextType;
  RegisterModuleClass(ADbConnectionModuleClass);
end;

initialization
begin
  GMigrations := TMigrations.Create;
end;

finalization
begin
  GMigrations := nil;
end;

end.
