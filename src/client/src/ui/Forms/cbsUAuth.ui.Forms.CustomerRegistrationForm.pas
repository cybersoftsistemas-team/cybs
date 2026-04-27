unit cbsUAuth.ui.Forms.CustomerRegistrationForm;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Wizard,
  cbsSystem.Form.BaseForm,
  cbsUAuth.ui.Data.Modules.CustomerRegistrationModule,
{IDE}
  Data.DB, uniGUIBaseClasses, uniDBLookupComboBox, System.Classes, System.Actions, Vcl.ActnList, uniButton, uniBitBtn, uniPanel, uniRadioButton, uniMultiItem, uniComboBox,
  uniDBComboBox, uniDateTimePicker, uniDBDateTimePicker, uniGUIClasses, uniEdit, uniDBEdit, uniLabel, Vcl.Controls, Vcl.Forms, uniImageList, System.ImageList, Vcl.ImgList,
  uniMainMenu, uniSpeedButton, uniDBText, uniMenuButton, Vcl.Menus;

type
  TfrmCustomerRegistration = class(TfrmBase)
    actBack: TAction;
    actCancel: TAction;
    actFinish: TAction;
    actNewCity: TAction;
    actNext: TAction;
    btnBack: TUniBitBtn;
    btnCancel: TUniBitBtn;
    btnFinish: TUniBitBtn;
    btnNewCity: TUniSpeedButton;
    btnNext: TUniBitBtn;
    cbxLegCompanyTypeId: TUniDBLookupComboBox;
    cbxLegNationalityId: TUniDBLookupComboBox;
    cbxLegStateId: TUniDBLookupComboBox;
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
    edtNatLastName: TUniDBEdit;
    edtNatSSN: TUniDBEdit;
    labClientID2: TUniLabel;
    labClientID: TUniLabel;
    labInfo: TUniLabel;
    labNatBirthday: TUniLabel;
    labNatFirstName: TUniLabel;
    labNatGender2: TUniLabel;
    labNatGender: TUniLabel;
    labNatLastName: TUniLabel;
    labNatNationality2: TUniLabel;
    labNatNationality: TUniLabel;
    labNatPlaceOfBirthId2: TUniLabel;
    labNatPlaceOfBirthId: TUniLabel;
    labNatSSN2: TUniLabel;
    labNatSSN: TUniLabel;
    labPlaceOfBirthId: TUniLabel;
    labStep02SubTitle: TUniLabel;
    labStep02Title: TUniLabel;
    labStep03SubTitle: TUniLabel;
    labStep03Title: TUniLabel;
    labTipo2: TUniLabel;
    labTipo: TUniLabel;
    labTitle: TUniLabel;
    pnlBreak: TUniPanel;
    pnlBreakLeft: TUniPanel;
    pnlBreakTop2: TUniPanel;
    pnlBreakTop: TUniPanel;
    pnlButtons: TUniSimplePanel;
    pnlLegal: TUniContainerPanel;
    pnlNatLabel: TUniContainerPanel;
    pnlNatural: TUniContainerPanel;
    pnlStep01: TUniContainerPanel;
    pnlStep02: TUniContainerPanel;
    pnlStep03: TUniContainerPanel;
    rbtLegal: TUniRadioButton;
    rbtNatural: TUniRadioButton;
    txtNatBirthday: TUniDBText;
    txtNatFirstName: TUniDBText;
    txtNatLastName: TUniDBText;
    edtEmail: TUniDBEdit;
    procedure actBackExecute(Sender: TObject);
    procedure actNewCityExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure rbtLegalClick(Sender: TObject);
    procedure rbtNaturalClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
  private
    FWizard: IWizard;
    procedure WizardOnChangeStep(const ASender: TObject; const AOldIndex: Integer; const ANewIndex: Integer);
  protected
    function GetDataModule: IDataModule; override;
  public
    procedure DataChange(Sender: TObject; Field: TField); override;
  end;

  function frmCustomerRegistration: TfrmCustomerRegistration;

implementation

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
  System.Variants,
{PROJECT}
  cbsMain.ui.Data.Modules.MainModule,
  cbsSystem.Support.Utils,
  cbsSystem.Wizard,
  cbsUAuth.ui.Forms.CityRegistrationForm;

function frmCustomerRegistration: TfrmCustomerRegistration;
begin
  Result := TfrmCustomerRegistration(damMain.GetFormInstance(TfrmCustomerRegistration));
end;

{ TfrmCustomerRegistration }

function TfrmCustomerRegistration.GetDataModule: IDataModule;
begin
  if not Assigned(damCustomerRegistration) then
    damCustomerRegistration := TdamCustomerRegistration.Create(nil);
  Result := damCustomerRegistration;
end;

procedure TfrmCustomerRegistration.actBackExecute(Sender: TObject);
begin
  FWizard.Back;
end;

procedure TfrmCustomerRegistration.actNewCityExecute(Sender: TObject);
begin
  frmCityRegistration.ShowModal;
end;

procedure TfrmCustomerRegistration.actNextExecute(Sender: TObject);
begin
  if ValidateRequiredFields then
  begin
    FWizard.Next;
  end;
end;

procedure TfrmCustomerRegistration.DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  cbxNatState.Enabled := not VarIsNull(cbxNatCountry.KeyValue);
  actNewCity.Enabled := not VarIsNull(cbxNatState.KeyValue);
end;

procedure TfrmCustomerRegistration.rbtLegalClick(Sender: TObject);
begin
  ClearInvalids;
  pnlLegal.Visible := True;
  pnlNatural.Visible := False;
  RegisterRequiredField(edtLegName);
  RegisterRequiredField(edtLegDoingBusinessAs);
  RegisterRequiredField(edtLegFoundationDate);
  RegisterRequiredField(edtLegCRN);
  RegisterRequiredField(cbxLegCompanyTypeId);
  RegisterRequiredField(cbxLegNationalityId);
  RegisterRequiredField(cbxLegStateId);
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
  RegisterRequiredField(cbxNatGender);
  RegisterRequiredField(cbxNatNationality);
  RegisterRequiredField(cbxNatCountry);
  RegisterRequiredField(cbxNatState);
  RegisterRequiredField(cbxNatCity);
end;

procedure TfrmCustomerRegistration.UniFormCreate(Sender: TObject);
begin
  SetRequiredFieldMode(rfmManual);
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
  FreeAndNil(damCustomerRegistration);
end;

procedure TfrmCustomerRegistration.WizardOnChangeStep(const ASender: TObject; const AOldIndex, ANewIndex: Integer);
begin
  ClearInvalids;
  pnlNatLabel.Visible := False;
  labTipo2.Caption := '';
  labNatSSN2.Caption := '';
  labNatGender2.Caption := '';
  labNatNationality2.Caption := '';
  labNatPlaceOfBirthId2.Caption := '';
  labClientID2.Caption := '';
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
  end
  else if ANewIndex = 2 then
  begin
    if rbtNatural.Checked then
    begin
      labTipo2.Caption := rbtNatural.Caption;
      labNatSSN2.Caption := GetCpfOrCnpfMask(GetOnlyNumbers(damCustomerRegistration.qryNATSSN.AsString));
      labNatGender2.Caption := cbxNatGender.Text;
      labNatNationality2.Caption := cbxNatNationality.Text;
      labNatPlaceOfBirthId2.Caption := cbxNatCity.Text;
      pnlNatLabel.Visible := True;
    end
    else if rbtLegal.Checked then
    begin
      labTipo2.Caption := rbtLegal.Caption;
    end;
  end;
end;

end.

