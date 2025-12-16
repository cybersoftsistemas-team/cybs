unit cbsSystem.Support.Form;

interface

uses
{PROJECT}
  cbsSystem.Form.BaseForm;

  procedure RegisterFormType(const AFormType: FormType);
  procedure RegisterMainFormType(const AFormType: FormType);

implementation

uses
{PROJECT}
  cbsSystem.Support.FormTypeRepository;

procedure RegisterFormType(const AFormType: FormType);
begin
  FormTypeRepository.Register(AFormType);
end;

procedure RegisterMainFormType(const AFormType: FormType);
begin
  FormTypeRepository.RegisterMain(AFormType);
end;

end.
