unit cbsSystem.Exprts;

interface

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Exprts.FormTypeRepository,
  cbsSystem.Exprts.MigrationContextTypeRepository,
  cbsSystem.Exprts.ModuleTypeRepository,
  cbsSystem.Support.ServerModule;

function GetFormTypes: IFormTypes; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
begin
  Result := FormTypeRepository.GetFormTypes;
end;

function GetModuleTypes: IModuleTypes; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
begin
  Result := ModuleTypeRepository.GetModuleTypes;
end;

procedure ExecuteMigrations; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
begin
  var TDbContext := MigrationContextTypeRepository.GetMigrationContextType;
  if Assigned(TDbContext) then
  begin
    var LDbContext := TDbContext.Create(ServerModule.Database.ConnectionString);
    try
      LDbContext.Connection.StartTransaction;
      try
        var TdamSeed := MigrationContextTypeRepository.GetDbConnectionModuleType;
        if Assigned(TdamSeed) then
        begin
          var LdamSeed := TdamSeed.Create(nil);
          try
            LDbContext.UpdateDatabase(LdamSeed.RunSeed);
          finally
            FreeAndNil(LdamSeed);
          end;
        end
        else
          LDbContext.UpdateDatabase;
      except
        on E: Exception do
        begin
          LDbContext.Connection.Rollback;
          raise Exception.Create(E.Message);
        end;
      end;
      LDbContext.Connection.Commit;
    finally
      FreeAndNil(LDbContext);
    end;
  end;
end;

exports
  ExecuteMigrations,
  GetFormTypes,
  GetModuleTypes;

end.
