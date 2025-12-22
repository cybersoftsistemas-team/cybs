unit cbsUAuth.ui.CustomerRegistrationForm;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Wizard,
  cbsSystem.Form.BaseForm,
{IDE}
  uniGUIBaseClasses, uniGUIClasses, uniRadioButton, System.Classes, System.Actions, Vcl.ActnList, uniPanel, uniLabel, uniButton, uniBitBtn, Vcl.Controls, Vcl.Forms, uniImageList,
  System.ImageList, Vcl.ImgList, uniMainMenu, uniEdit, uniDBEdit, uniDateTimePicker, uniDBDateTimePicker;

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
    labInfo: TUniLabel;
    labTitle: TUniLabel;
    pnlBreak: TUniPanel;
    pnlBreakLeft: TUniPanel;
    pnlBreakTop: TUniPanel;
    pnlButtons: TUniSimplePanel;
    pnlStep01: TUniContainerPanel;
    pnlStep02: TUniContainerPanel;
    rbtLegal: TUniRadioButton;
    rbtNatural: TUniRadioButton;
    labStep02Title: TUniLabel;
    labStep02SubTitle: TUniLabel;
    UniContainerPanel1: TUniContainerPanel;
    edtFirstName: TUniDBEdit;
    edtLastName: TUniDBEdit;
    edtBirthday: TUniDBDateTimePicker;
    edtSSN: TUniDBEdit;
    edtIDCard: TUniDBEdit;
    procedure actBackExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
  private
    FWizard: IWizard;
  end;

  function frmCustomerRegistration: TfrmCustomerRegistration;

implementation

{$R *.dfm}

uses
{PROJECT}
  cbsMain.data.module.MainModule,
  cbsSystem.Wizard;

function frmCustomerRegistration: TfrmCustomerRegistration;
begin
  Result := TfrmCustomerRegistration(damMain.GetFormInstance(TfrmCustomerRegistration));
end;

procedure TfrmCustomerRegistration.actBackExecute(Sender: TObject);
begin
  FWizard.Back;
end;

procedure TfrmCustomerRegistration.actNextExecute(Sender: TObject);
begin
  FWizard.Next;
end;

procedure TfrmCustomerRegistration.UniFormCreate(Sender: TObject);
begin
  inherited;
  FWizard := TcbsWizard.Create
   // Buttons...
   .SetBackAction(actBack)
   .SetFinishAction(actFinish)
   .SetNextAction(actNext)
   // Steps...
   .AddStep(pnlStep01)
   .AddStep(pnlStep02);
end;

procedure TfrmCustomerRegistration.UniFormDestroy(Sender: TObject);
begin
  FWizard := nil;
  inherited;
end;

end.
