unit exprts;

interface

implementation

uses
{PROJECT}
  cbsSystem.Support.Form.Repository,
  cbsSystem.Support.Module.Repository;

function GetFormTypes: IFormTypes; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
begin
  Result := FormTypeRepository.GetFormTypes;
end;

function GetModuleTypes: IModuleTypes; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
begin
  Result := ModuleTypeRepository.GetModuleTypes;
end;

exports
  GetFormTypes,
  GetModuleTypes;

end.
