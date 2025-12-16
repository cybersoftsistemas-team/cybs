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
    actAdd: TAction;
    actClear: TAction;
    actClose: TAction;
    actDel: TAction;
    actEdit: TAction;
    actSelected: TAction;
    actTestConn: TAction;
    btnAdd: TUniBitBtn;
    btnClear: TUniBitBtn;
    btnClose: TUniBitBtn;
    btnDel: TUniBitBtn;
    btnEdit: TUniBitBtn;
    btnSelected: TUniBitBtn;
    btnTestConn: TUniBitBtn;
    grdConn: TUniDBGrid;
    labConnList: TUniLabel;
    pnlLine01: TUniPanel;
    pnlLine02: TUniPanel;
    usmSelected: TUniScreenMask;
    usmTestConnection: TUniScreenMask;
    procedure actAddExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actSelectedExecute(Sender: TObject);
    procedure actTestConnExecute(Sender: TObject);
    procedure grdConnDblClick(Sender: TObject);
    procedure grdConnDrawColumnCell(Sender: TObject; ACol, ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
  protected
    function GetDataModule: IDataModule; override;
    function GetTestConnection: TFDCustomConnection;
    procedure TestConnection;
  public
    procedure AddorEditConnection; overload;
    procedure AddorEditConnection(const AName, AConnectionString: string); overload;
    procedure DataChange(Sender: TObject; Field: TField); override;
  end;

  function frmOptions: TfrmOptions;

implementation

{$R *.dfm}

uses
{IDE}
  FireDAC.Stan.Util,
  System.SysUtils,
  System.UITypes,
{PROJECT}
  cbsMain.data.module.MainModule,
  cbsSystem.Support.DataSet.Extensions,
  cbsSystem.Support.ServerModule,
  cbsUAuth.data.module.LoginModule,
  cbsUAuth.ui.ConnEditorForm;

function frmOptions: TfrmOptions;
begin
  Result := TfrmOptions(damMain.GetFormInstance(TfrmOptions));
end;

{ TfrmOptions }

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
        damLogin.mtbCNSEmptyDataSet;
      end;
    end);
end;

procedure TfrmOptions.actDelExecute(Sender: TObject);
begin
  MessageDlg(Format('Tem certeza de que deseja excluir a conexão ''%s''?',
    [damLogin.mtbCNSName.AsString]), mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    procedure(Sender: TComponent; Result: Integer)
    begin
      if Result = mrYes then
      begin
        damLogin.mtbCNS.Delete;
      end;
    end);
end;

procedure TfrmOptions.actEditExecute(Sender: TObject);
begin
  AddorEditConnection(damLogin.mtbCNSName.AsString, damLogin.mtbCNSConnectionString.AsString);
end;

procedure TfrmOptions.actSelectedExecute(Sender: TObject);
begin
  var LDatabase := ServerModule.Database;
  LDatabase.BeginUpdate;
  try
    TestConnection;
    var LRecNo := damLogin.mtbCNS.RecNo;
    try
      LDatabase.Id := damLogin.mtbCNSId.AsGuid;
      LDatabase.ConnectionName := damLogin.mtbCNSName.AsString;
      LDatabase.ConnectionString := damLogin.mtbCNSConnectionString.AsString;
      LDatabase.ExecuteMigrations;
      LDatabase.EndUpdate;
      damLogin.mtbCNS.Refresh;
    finally
      damLogin.mtbCNS.RecNo := LRecNo;
    end;
  except
    on E: Exception do
    begin
      LDatabase.CancelUpdate;
      MessageBox('Erro', 'Erro ao selecionar o banco de dados.', E.Message, mtError, [mbOK]);
    end;
  end;
end;

procedure TfrmOptions.actTestConnExecute(Sender: TObject);
begin
  try
    TestConnection;
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
        if AName.Trim.IsEmpty and
          AConnectionString.Trim.IsEmpty then
        begin
          damLogin.mtbCNS.Append;
        end
        else
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
  actSelected.Enabled := actEdit.Enabled and not IsEqualGUID(damLogin.mtbCNSId.AsGuid, ServerModule.Database.Id);
end;

function TfrmOptions.GetDataModule: IDataModule;
begin
  Result := damLogin;
end;

function TfrmOptions.GetTestConnection: TFDCustomConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.ConnectionString := damLogin.mtbCNSConnectionString.AsString;
end;

procedure TfrmOptions.grdConnDblClick(Sender: TObject);
begin
  if not damLogin.mtbCNS.IsEmpty then
  begin
    actEdit.Execute;
  end;
end;

procedure TfrmOptions.grdConnDrawColumnCell(Sender: TObject; ACol, ARow:
    Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  if IsEqualGUID(
    grdConn.DataSource.DataSet.FieldByName('Id').AsGuid,
    ServerModule.Database.Id
  ) then
  begin
    Attribs.Font.Style := Attribs.Font.Style + [TFontStyle.fsBold];
  end
  else
    Attribs.Font.Style := Attribs.Font.Style - [TFontStyle.fsBold];
end;

procedure TfrmOptions.TestConnection;
begin
  var LConn := GetTestConnection;
  try
    LConn.Close;
    LConn.Open;
  finally
    FDFreeAndNil(LConn);
  end;
end;

end.
