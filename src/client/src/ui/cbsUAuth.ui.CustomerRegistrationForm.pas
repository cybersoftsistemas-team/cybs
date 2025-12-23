unit cbsUAuth.ui.CustomerRegistrationForm;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Wizard,
  cbsSystem.Form.BaseForm,
{IDE}
  uniGUIBaseClasses, uniGUIClasses, uniRadioButton, System.Classes, System.Actions, Vcl.ActnList, uniPanel, uniLabel, uniButton, uniBitBtn, Vcl.Controls, Vcl.Forms, uniImageList,
  System.ImageList, Vcl.ImgList, uniMainMenu, uniEdit, uniDBEdit, uniDateTimePicker, uniDBDateTimePicker, uniMultiItem, uniComboBox, uniDBComboBox, uniFieldSet;

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
    cbxGender: TUniDBComboBox;
    cbxNatCity: TUniDBComboBox;
    cbxNatCountry: TUniDBComboBox;
    cbxNationality: TUniDBComboBox;
    cbxNatState: TUniDBComboBox;
    edtBirthday: TUniDBDateTimePicker;
    edtFirstName: TUniDBEdit;
    edtIDCard: TUniDBEdit;
    edtLastName: TUniDBEdit;
    edtSSN: TUniDBEdit;
    labInfo: TUniLabel;
    labPlaceOfBirthId: TUniLabel;
    labStep02SubTitle: TUniLabel;
    labStep02Title: TUniLabel;
    labTitle: TUniLabel;
    pnlBreak: TUniPanel;
    pnlBreakLeft: TUniPanel;
    pnlBreakTop: TUniPanel;
    pnlButtons: TUniSimplePanel;
    pnlLegal: TUniContainerPanel;
    pnlNatural: TUniContainerPanel;
    pnlStep01: TUniContainerPanel;
    pnlStep02: TUniContainerPanel;
    rbtLegal: TUniRadioButton;
    rbtNatural: TUniRadioButton;
    procedure actBackExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure rbtLegalClick(Sender: TObject);
    procedure rbtNaturalClick(Sender: TObject);
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

procedure TfrmCustomerRegistration.rbtLegalClick(Sender: TObject);
begin
  pnlLegal.Visible := True;
  pnlNatural.Visible := False;
end;

procedure TfrmCustomerRegistration.rbtNaturalClick(Sender: TObject);
begin
  pnlLegal.Visible := False;
  pnlNatural.Visible := True;
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
