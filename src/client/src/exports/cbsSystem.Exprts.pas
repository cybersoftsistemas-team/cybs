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
  cbsSystem.Support.Migrations.Execute,
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
  InternalExecuteMigrations(
    MigrationContextTypeRepository.GetDbConnectionModuleType,
    MigrationContextTypeRepository.GetMigrationContextType
  );
end;

exports
  ExecuteMigrations,
  GetFormTypes,
  GetModuleTypes;

end.
