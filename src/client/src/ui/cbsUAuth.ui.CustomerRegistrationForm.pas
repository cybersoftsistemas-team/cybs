unit cbsUAuth.ui.CustomerRegistrationForm;

interface

uses
{PROJECT}
  cbsSystem.Form.BaseForm,
{IDE}
  uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Controls, Vcl.Forms, uniGUIClasses, uniButton,
  uniBitBtn, uniPanel;

type
  TfrmCustomerRegistration = class(TfrmBase)
    actBack: TAction;
    actCancel: TAction;
    actFinish: TAction;
    actNext: TAction;
    btnBack: TUniBitBtn;
    btnCancel: TUniBitBtn;
    btnFinish: TUniBitBtn;
    btnNext: TUniBitBtn;
    pnlLine02: TUniPanel;
  end;

  function frmCustomerRegistration: TfrmCustomerRegistration;

implementation

{$R *.dfm}

uses
{PROJECT}
  cbsMain.data.module.MainModule,
  cbsUAuth.data.module.CustomerRegistrationModule;

function frmCustomerRegistration: TfrmCustomerRegistration;
begin
  Result := TfrmCustomerRegistration(damMain.GetFormInstance(TfrmCustomerRegistration));
end;

end.
