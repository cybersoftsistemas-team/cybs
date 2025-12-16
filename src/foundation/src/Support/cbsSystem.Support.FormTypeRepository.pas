unit cbsSystem.Support.FormTypeRepository;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Form.Repository;

type
  IFormTypes = cbsSystem.Contracts.Form.Repository.IFormTypes;

  function FormTypeRepository: IFormTypeRepository;

implementation

uses
{PROJECT}
  cbsSystem.Form.Repository;

var
  InternalFormTypeRepository: IFormTypeRepository;

function FormTypeRepository: IFormTypeRepository;
begin
  Result := InternalFormTypeRepository;
end;

initialization
begin
  InternalFormTypeRepository := TcbsFormTypeRepository.Create;
end;

finalization
begin
  InternalFormTypeRepository := nil;
end;

end.
