unit cbsSystem.Support.Form;

interface

uses
{PROJECT}
  cbsSystem.Form.BaseForm;

  procedure RegisterFormType(const AFormType: FormType);

implementation

uses
{PROJECT}
  cbsSystem.Support.FormTypeRepository;

procedure RegisterFormType(const AFormType: FormType);
begin
  FormTypeRepository.Register(AFormType);
end;

end.
