unit cbsUAuth.ui.OptionsForm;

interface

uses
{PROJECT}
  cbsSystem.Form.BaseForm,
{IDE}
  Data.DB, FireDAC.Comp.Client, uniGUITypes, uniGUIBaseClasses, System.Classes, System.Actions, Vcl.ActnList, uniGUIClasses, uniPanel, uniButton, uniBitBtn, uniLabel, Vcl.Controls,
  Vcl.Forms, uniBasicGrid, uniDBGrid, uniImageList, System.ImageList, Vcl.ImgList, uniMainMenu, uniScreenMask;

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
    usmTestConnection: TUniScreenMask;
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actTestConnExecute(Sender: TObject);
  protected
    function GetDataModule: TdamBase; override;
    function GetTestConnection: TFDCustomConnection;
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
  FireDAC.Stan.Util,
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

function TfrmOptions.GetTestConnection: TFDCustomConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.ConnectionString := damLogin.mtbCNSConnectionString.AsString;
end;

procedure TfrmOptions.actAddExecute(Sender: TObject);
begin
  AddorEditConnection;
end;

procedure TfrmOptions.actClearExecute(Sender: TObject);
begin
  MessageDlg('Tem certeza de que deseja excluir todas as conexões?',
    mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    procedure(Sender: TComponent; Result: Integer)
    begin
      if Result = mrYes then
      begin
        damLogin.mtbCNS.EmptyDataSet;
        damLogin.mtbCNSName.FocusControl;
      end;
    end);
end;

procedure TfrmOptions.actDelExecute(Sender: TObject);
begin
  MessageDlg(Format('Tem certeza de que deseja excluir a conexão ''%s''?', [damLogin.mtbCNSName.AsString]),
    mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    procedure(Sender: TComponent; Result: Integer)
    begin
      if Result = mrYes then
      begin
        damLogin.mtbCNS.Delete;
        damLogin.mtbCNSName.FocusControl;
      end;
    end);
end;

procedure TfrmOptions.actEditExecute(Sender: TObject);
begin
  AddorEditConnection(damLogin.mtbCNSName.AsString, damLogin.mtbCNSConnectionString.AsString);
end;

procedure TfrmOptions.actTestConnExecute(Sender: TObject);
begin
  try
    var LConn := GetTestConnection;
    try
      LConn.Close;
      LConn.Open;
    finally
      FDFreeAndNil(LConn);
    end;
    ShowMessage('Conexão estabelecida com sucesso.');
  except
    on E: Exception do
    begin
      MessageBox('Erro', 'Erro ao se conectar com o banco de dados.', E.Message, mtError, [mbOK]);
    end;
  end;
end;

procedure TfrmOptions.AddorEditConnection;
begin
  AddorEditConnection('','');
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
        damLogin.mtbCNSName.FocusControl;
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
