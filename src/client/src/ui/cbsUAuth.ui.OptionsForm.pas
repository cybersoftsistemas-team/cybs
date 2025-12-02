unit cbsUAuth.ui.OptionsForm;

interface

uses
{PROJECT}
  cbsSystem.Form.BaseForm,
{IDE}
  Data.DB, uniGUIBaseClasses, System.Classes, System.Actions, Vcl.ActnList, uniGUIClasses, uniPanel, uniButton, uniBitBtn, uniLabel, Vcl.Controls, Vcl.Forms, uniBasicGrid,
  uniDBGrid, uniImageList, System.ImageList, Vcl.ImgList, uniMainMenu;

type
  TfrmOptions = class(TfrmBase)
    grdConn: TUniDBGrid;
    labConnList: TUniLabel;
    btnAdd: TUniBitBtn;
    btnEdit: TUniBitBtn;
    btnDel: TUniBitBtn;
    btnClear: TUniBitBtn;
    actAdd: TAction;
    actEdit: TAction;
    actDel: TAction;
    actClear: TAction;
    actClose: TAction;
    btnClose: TUniBitBtn;
    btnTestConn: TUniBitBtn;
    actTestConn: TAction;
    actSelected: TAction;
    btnSelected: TUniBitBtn;
    pnlLine01: TUniPanel;
    pnlLine02: TUniPanel;
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
  protected
    function GetDataModule: TdamBase; override;
    procedure DataChange(Sender: TObject; Field: TField); override;
  public
    procedure AddorEditConnection; overload;
    procedure AddorEditConnection(const AName, AConnectionString: string); overload;
  end;

  function frmOptions: TfrmOptions;

implementation

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
  System.UITypes,
  uniGUIApplication,
{PROJECT}
  cbsUAuth.data.module.LoginModule,
  cbsUAuth.ui.ConnEditorForm;

function frmOptions: TfrmOptions;
begin
  Result := TfrmOptions(UniApplication.UniMainModule.GetFormInstance(TfrmOptions));
end;

{ TfrmOptions }

function TfrmOptions.GetDataModule: TdamBase;
begin
  Result := damLogin;
end;

procedure TfrmOptions.actAddExecute(Sender: TObject);
begin
  AddorEditConnection;
end;

procedure TfrmOptions.actEditExecute(Sender: TObject);
begin
  AddorEditConnection(damLogin.mtbCNSName.AsString, damLogin.mtbCNSConnectionString.AsString);
end;

procedure TfrmOptions.AddorEditConnection;
begin
  AddorEditConnection('', '');
end;

procedure TfrmOptions.AddorEditConnection(const AName, AConnectionString: string);
begin
  frmConnEditor.ConnectionName := AName;
  frmConnEditor.ConnectionString := AConnectionString;
  frmConnEditor.ShowModal(
    procedure(Sender: TComponent; Result: Integer)
    begin
      if Result = mrOk then
      begin
        damLogin.mtbCNS.Edit;
        damLogin.mtbCNSName.AsString := frmConnEditor.ConnectionName;
        damLogin.mtbCNSConnectionString.AsString := frmConnEditor.ConnectionString;
        damLogin.mtbCNS.Post;
      end;
    end
  );
end;

procedure TfrmOptions.DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  actEdit.Enabled := not(damLogin.mtbCNS.State in dsEditModes) and  not damLogin.mtbCNS.IsEmpty;
  actDel.Enabled := actEdit.Enabled;
  actClear.Enabled := actEdit.Enabled;
  actTestConn.Enabled := actEdit.Enabled;
  actSelected.Enabled := actEdit.Enabled and not IsEqualGUID(damLogin.mtbCNSId.AsGuid, damLogin.mtbUSECnsId.AsGuid);
end;

end.
