unit cbsUAuth.ui.CustomerRegistrationForm;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Wizard,
  cbsSystem.Form.BaseForm,
{IDE}
  Data.DB, uniGUIBaseClasses, uniDBLookupComboBox, System.Classes, System.Actions, Vcl.ActnList, uniButton, uniBitBtn, uniPanel, uniRadioButton, uniMultiItem, uniComboBox,
  uniDBComboBox, uniDateTimePicker, uniDBDateTimePicker, uniGUIClasses, uniEdit, uniDBEdit, uniLabel, Vcl.Controls, Vcl.Forms, uniImageList, System.ImageList, Vcl.ImgList,
  uniMainMenu;

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
    cbbLegCompanyType: TUniDBLookupComboBox;
    cbbLegNationality: TUniDBComboBox;
    cbxNatCity: TUniDBLookupComboBox;
    cbxNatCountry: TUniDBLookupComboBox;
    cbxNatGender: TUniDBLookupComboBox;
    cbxNatNationality: TUniDBLookupComboBox;
    cbxNatState: TUniDBLookupComboBox;
    edtLegCRN: TUniDBEdit;
    edtLegDoingBusinessAs: TUniDBEdit;
    edtLegFoundationDate: TUniDBDateTimePicker;
    edtLegMunicipalInscription: TUniDBEdit;
    edtLegName: TUniDBEdit;
    edtLegStateInscriptionNumber: TUniDBEdit;
    edtNatBirthday: TUniDBDateTimePicker;
    edtNatFirstName: TUniDBEdit;
    edtNatIDCard: TUniDBEdit;
    edtNatLastName: TUniDBEdit;
    edtNatSSN: TUniDBEdit;
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
    UniDBComboBox2: TUniDBComboBox;
    pnlStep03: TUniContainerPanel;
    procedure actBackExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure cbxNatCityTriggerEvent(Sender: TUniCustomComboBox; AButtonId: Integer);
    procedure rbtLegalClick(Sender: TObject);
    procedure rbtNaturalClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
  private
    FWizard: IWizard;
    procedure WizardOnChangeStep(const ASender: TObject; const AOldIndex: Integer; const ANewIndex: Integer);
  protected
    function GetDataModule: IDataModule; override;
  end;

  function frmCustomerRegistration: TfrmCustomerRegistration;

implementation

{$R *.dfm}

uses
  System.SysUtils,
{PROJECT}
  cbsMain.data.module.MainModule,
  cbsSystem.Wizard,
  cbsUAuth.data.module.CustomerRegistrationModule;

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
  if ValidateRequiredFields then
  begin
    FWizard.Next;
  end;
end;

procedure TfrmCustomerRegistration.cbxNatCityTriggerEvent(Sender: TUniCustomComboBox; AButtonId: Integer);
begin
  if AButtonId = 1 then
  begin

  end;
end;

function TfrmCustomerRegistration.GetDataModule: IDataModule;
begin
  Result := damCustomerRegistration;
end;

procedure TfrmCustomerRegistration.rbtLegalClick(Sender: TObject);
begin
  ClearInvalids;
  pnlLegal.Visible := True;
  pnlNatural.Visible := False;
end;

procedure TfrmCustomerRegistration.rbtNaturalClick(Sender: TObject);
begin
  ClearInvalids;
  pnlLegal.Visible := False;
  pnlNatural.Visible := True;
  RegisterRequiredField(edtNatFirstName);
  RegisterRequiredField(edtNatLastName);
  RegisterRequiredField(edtNatBirthday);
  RegisterRequiredField(edtNatSSN);
  RegisterRequiredField(edtNatIDCard);
end;

procedure TfrmCustomerRegistration.UniFormCreate(Sender: TObject);
begin
  inherited;
  FWizard := TcbsWizard.Create
   .AddStep(pnlStep01)
   .AddStep(pnlStep02)
   .AddStep(pnlStep03)
   .SetBackAction(actBack)
   .SetFinishAction(actFinish)
   .SetNextAction(actNext);
  FWizard.OnChangeStep := WizardOnChangeStep;
end;

procedure TfrmCustomerRegistration.UniFormDestroy(Sender: TObject);
begin
  FWizard := nil;
  inherited;
end;

procedure TfrmCustomerRegistration.WizardOnChangeStep(const ASender: TObject; const AOldIndex, ANewIndex: Integer);
begin
  ClearInvalids;
  if ANewIndex = 1 then
  begin
    if rbtNatural.Checked then
    begin
      rbtNaturalClick(rbtNatural);
    end
    else if rbtLegal.Checked then
    begin
      rbtLegalClick(rbtLegal);
    end;
  end;
end;

end.
