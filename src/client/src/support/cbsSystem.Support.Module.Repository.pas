unit cbsSystem.Support.Module.Repository;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module.Repository;

type
  IModuleTypes = cbsSystem.Contracts.Module.Repository.IModuleTypes;

  function ModuleTypeRepository: IModuleTypeRepository;

implementation

uses
{PROJECT}
  cbsSystem.Module.Repository;

var
  InternalModuleTypeRepository: IModuleTypeRepository;

function ModuleTypeRepository: IModuleTypeRepository;
begin
  Result := InternalModuleTypeRepository;
end;

initialization
begin
  InternalModuleTypeRepository := TcbsModuleTypeRepository.Create;
end;

finalization
begin
  InternalModuleTypeRepository := nil;
end;

end.
