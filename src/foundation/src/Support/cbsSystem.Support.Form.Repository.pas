unit cbsSystem.Support.Form.Repository;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Form.Repository;

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
