unit Identity.UI.Forms.LoginDomainRegistrationForm;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Wizard,
  cbsSystem.Form.BaseForm,
{IDE}
  Data.DB, uniGUIBaseClasses, uniDBLookupComboBox, System.Classes, System.Actions, Vcl.ActnList, uniButton, uniBitBtn, uniPanel, uniRadioButton, uniMultiItem, uniComboBox,
  uniDBComboBox, uniDateTimePicker, uniDBDateTimePicker, uniGUIClasses, uniEdit, uniDBEdit, uniLabel, Vcl.Controls, Vcl.Forms, uniImageList, System.ImageList, Vcl.ImgList,
  uniMainMenu, uniSpeedButton, uniDBText, uniMenuButton, Vcl.Menus;

type
  TfrmDomainRegistration = class(TfrmBase)
    actBack: TAction;
    actCancel: TAction;
    actFinish: TAction;
    actNewCity: TAction;
    actNext: TAction;
    btnBack: TUniBitBtn;
    btnCancel: TUniBitBtn;
    btnFinish: TUniBitBtn;
    btnNext: TUniBitBtn;
    labInfo: TUniLabel;
    labTitle: TUniLabel;
    pnlBreak: TUniPanel;
    pnlButtons: TUniSimplePanel;
    pnlStep01: TUniContainerPanel;
    pnlStep02: TUniContainerPanel;
    pnlBreakTop: TUniPanel;
    labStep02Title: TUniLabel;
    labStep02SubTitle: TUniLabel;
    edtDomainName: TUniEdit;
    labInfo2: TUniLabel;
    procedure actBackExecute(Sender: TObject);
    procedure actFinishExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
  private
    FWizard: IWizard;
    procedure WizardOnChangeStep(const ASender: TObject; const AOldIndex: Integer; const ANewIndex: Integer);
  protected
    function GetDataModule: IDataModule; override;
  public
    procedure DataChange(Sender: TObject; Field: TField); override;
  end;

  function frmDomainRegistration: TfrmDomainRegistration;

implementation

{$R *.dfm}

uses
{IDE}
  System.UITypes,
{PROJECT}
  cbsSystem.Wizard,
  Domain.Inf.Contracts.Repositories.DomainRepository,
  Identity.UI.Data.Modules.LoginDomainsModule,
  Shared.UI.Data.Modules.MainModule;

function frmDomainRegistration: TfrmDomainRegistration;
begin
  Result := TfrmDomainRegistration(damMain.GetFormInstance(TfrmDomainRegistration));
end;

{ TfrmDomainRegistration }

function TfrmDomainRegistration.GetDataModule: IDataModule;
begin
  Result := damLoginDomains;
end;

procedure TfrmDomainRegistration.actBackExecute(Sender: TObject);
begin
  FWizard.Back;
end;

procedure TfrmDomainRegistration.actFinishExecute(Sender: TObject);
begin
  if ValidateRequiredFields then
  begin
    damLoginDomains.CreateDomain(edtDomainName.Text, TGuid.Empty);
    MessageDlg('O domínio foi criado com sucesso.', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK],
      procedure(Sender: TComponent; Result: Integer)
      begin
        ModalResult := mrOk;
      end);
  end;
end;

procedure TfrmDomainRegistration.actNextExecute(Sender: TObject);
begin
  if ValidateRequiredFields then
  begin
    FWizard.Next;
  end;
end;

procedure TfrmDomainRegistration.DataChange(Sender: TObject; Field: TField);
begin
  inherited;
end;

procedure TfrmDomainRegistration.UniFormCreate(Sender: TObject);
begin
  SetRequiredFieldMode(rfmManual);
  inherited;
  FWizard := TcbsWizard.Create
   .AddStep(pnlStep01)
   .AddStep(pnlStep02)
   .SetBackAction(actBack)
   .SetFinishAction(actFinish)
   .SetNextAction(actNext);
  FWizard.OnChangeStep := WizardOnChangeStep;
  labInfo.JSInterface.JSConfig('style', ['text-align: justify; white-space: normal;']);
end;

procedure TfrmDomainRegistration.WizardOnChangeStep(const ASender: TObject; const AOldIndex, ANewIndex: Integer);
begin
  ClearInvalids;
  if ANewIndex = 1 then
  begin
    RegisterRequiredField(edtDomainName);
    edtDomainName.SetFocus;
  end;
end;

end.

