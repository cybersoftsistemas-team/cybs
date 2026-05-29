unit Identity.UI.Forms.LoginOptionsForm;

interface

uses
{PROJECT}
  cbsSystem.Contracts.DatabaseConfig,
  cbsSystem.Form.BaseForm,
{IDE}
  Data.DB, FireDAC.Comp.Client, uniGUITypes, uniGUIBaseClasses, System.Classes, System.Actions, Vcl.ActnList, uniGUIClasses, uniPanel, uniButton, uniBitBtn, uniLabel, Vcl.Controls,
  Vcl.Forms, uniBasicGrid, uniDBGrid, uniImageList, System.ImageList, Vcl.ImgList, uniMainMenu, uniScreenMask;

type
  TfrmLoginOptions = class(TfrmBase)
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
    procedure UniFormCreate(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actSelectedExecute(Sender: TObject);
    procedure actTestConnExecute(Sender: TObject);
    procedure grdConnDblClick(Sender: TObject);
    procedure grdConnDrawColumnCell(Sender: TObject; ACol, ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
  protected
    FDatabaseConfig: IDatabaseConfig;
    function GetDataModule: IDataModule; override;
    function GetTestConnection: TFDCustomConnection;
    procedure TestConnection;
  public
    procedure AddOrEditConnection; overload;
    procedure AddOrEditConnection(const AName, AConnectionString: string); overload;
    procedure DataChange(Sender: TObject; Field: TField); override;
  end;

  function frmLoginOptions: TfrmLoginOptions;

implementation

{$R *.dfm}

uses
{IDE}
  FireDAC.Stan.Util,
  System.SysUtils,
  System.UITypes,
{PROJECT}
  cbsSystem.Support.Container,
  Identity.UI.Data.Modules.LoginModule,
  Identity.UI.Forms.LoginOptionsConnEditorForm,
  Shared.Inf.Contracts.Services.DatabaseUpdaterService,
  Shared.UI.Data.Modules.MainModule;

function frmLoginOptions: TfrmLoginOptions;
begin
  Result := TfrmLoginOptions(damMain.GetFormInstance(TfrmLoginOptions));
end;

{ TfrmOptions }

function TfrmLoginOptions.GetDataModule: IDataModule;
begin
  Result := damLogin;
end;

function TfrmLoginOptions.GetTestConnection: TFDCustomConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.ConnectionString := damLogin.mtbCNSConnectionString.AsString;
end;

procedure TfrmLoginOptions.actAddExecute(Sender: TObject);
begin
  AddOrEditConnection;
end;

procedure TfrmLoginOptions.actClearExecute(Sender: TObject);
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

procedure TfrmLoginOptions.actDelExecute(Sender: TObject);
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

procedure TfrmLoginOptions.actEditExecute(Sender: TObject);
begin
  AddOrEditConnection(damLogin.mtbCNSName.AsString, damLogin.mtbCNSConnectionString.AsString);
end;

procedure TfrmLoginOptions.actSelectedExecute(Sender: TObject);
begin
  try
    TestConnection;
    try
      FDatabaseConfig.Id := damLogin.mtbCNSId.AsGuid;
      FDatabaseConfig.ConnectionName := damLogin.mtbCNSName.AsString;
      FDatabaseConfig.ConnectionString := damLogin.mtbCNSConnectionString.AsString;
      FDatabaseConfig.ApplyUpdates;
    except
      on E: Exception do
      begin
        FDatabaseConfig.CancelUpdate;
        raise Exception.Create(E.Message);
      end;
    end;
    App.Make<IDatabaseUpdaterService>.Execute([RunMigrations, RunSeeds]);
  except
    on E: Exception do
    begin
      MessageBox('Erro', 'Erro ao selecionar o banco de dados.', E.Message, mtError, [mbOK]);
    end;
  end;
end;

procedure TfrmLoginOptions.actTestConnExecute(Sender: TObject);
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

procedure TfrmLoginOptions.AddOrEditConnection;
begin
  AddOrEditConnection('','');
end;

procedure TfrmLoginOptions.AddOrEditConnection(const AName, AConnectionString: string);
begin
  frmLoginOptionsConnEditor.ConnectionName := AName;
  frmLoginOptionsConnEditor.ConnectionString := AConnectionString;
  frmLoginOptionsConnEditor.ShowModal(
    procedure(Sender: TComponent; Result: Integer)
    begin
      if not (Result = mrOk) then
        Exit;
      if AName.Trim.IsEmpty and
        AConnectionString.Trim.IsEmpty then
      begin
        damLogin.mtbCNS.Append;
      end
      else
        damLogin.mtbCNS.Edit;
      damLogin.mtbCNSName.AsString := frmLoginOptionsConnEditor.ConnectionName;
      damLogin.mtbCNSConnectionString.AsString := frmLoginOptionsConnEditor.ConnectionString;
      damLogin.mtbCNS.Post;
    end
  );
end;

procedure TfrmLoginOptions.DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  actEdit.Enabled := not(damLogin.mtbCNS.State in dsEditModes) and  not damLogin.mtbCNS.IsEmpty;
  actDel.Enabled := actEdit.Enabled;
  actClear.Enabled := actEdit.Enabled;
  actTestConn.Enabled := actEdit.Enabled;
  actSelected.Enabled := actEdit.Enabled and not IsEqualGUID(damLogin.mtbCNSId.AsGuid, FDatabaseConfig.Id);
end;

procedure TfrmLoginOptions.grdConnDblClick(Sender: TObject);
begin
  if not damLogin.mtbCNS.IsEmpty then
  begin
    actEdit.Execute;
  end;
end;

procedure TfrmLoginOptions.grdConnDrawColumnCell(Sender: TObject; ACol, ARow:
    Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  var LId1 := FDatabaseConfig.Id;
  var LId2 := grdConn.DataSource.DataSet.FieldByName('Id').AsGuid;
  Attribs.Font.Style := if IsEqualGUID(LId1, LId2) then Attribs.Font.Style + [TFontStyle.fsBold] else Attribs.Font.Style - [TFontStyle.fsBold];
end;

procedure TfrmLoginOptions.TestConnection;
begin
  var LConn := GetTestConnection;
  try
    LConn.Close;
    LConn.Open;
  finally
    FDFreeAndNil(LConn);
  end;
end;

procedure TfrmLoginOptions.UniFormCreate(Sender: TObject);
begin
  inherited;
  FDatabaseConfig := App.Make<IDatabaseConfig>;
end;

end.


