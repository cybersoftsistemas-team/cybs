unit cbsUAuth.ui.ConnEditorForm;

interface

uses
{PROJECT}
  cbsSystem.Form.BaseForm,
{IDE}
  uniGUITypes, uniGUIBaseClasses, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, uniMultiItem,
  uniComboBox, uniDBComboBox, uniGUIClasses, uniPanel, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Classes, System.Actions, Vcl.ActnList, uniButton, uniBitBtn,
  uniLabel, Vcl.Imaging.pngimage, uniImage, Vcl.Controls, Vcl.Forms, uniBasicGrid, uniDBGrid, uniImageList, System.ImageList, Vcl.ImgList, uniMainMenu, uniEdit, uniDBEdit,
  uniScreenMask;

type
  TfrmConnEditor = class(TfrmBase)
    imgDb: TUniImage;
    labInfo: TUniLabel;
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    actOk: TAction;
    actCancel: TAction;
    mtbPRM: TFDMemTable;
    mtbPRMParam: TStringField;
    mtbPRMValue: TStringField;
    mtbPRMDefault: TStringField;
    dsoPRM: TDataSource;
    actTestConn: TAction;
    actDefaults: TAction;
    btnTestConn: TUniBitBtn;
    btnDefaults: TUniBitBtn;
    grdParams: TUniDBGrid;
    mtbPRMParamType: TStringField;
    pnlValue: TUniPanel;
    cbxCombo: TUniDBComboBox;
    edtConnectionName: TUniEdit;
    pnlLine02: TUniPanel;
    usmTestConnection: TUniScreenMask;
    procedure actDefaultsExecute(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure actTestConnExecute(Sender: TObject);
    procedure cbxComboSelect(Sender: TObject);
    procedure grdParamsAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure grdParamsDrawColumnCell(Sender: TObject; ACol, ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
    procedure grdParamsSelectionChange(Sender: TObject);
    procedure mtbPRMAfterPost(DataSet: TDataSet);
    procedure mtbPRMAfterScroll(DataSet: TDataSet);
    procedure UniFormDestroy(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure dsoPRMDataChange(Sender: TObject; Field: TField);
    procedure edtConnectionNameChange(Sender: TObject);
  private
    FConnection: TFDCustomConnection;
    FConnectionString: string;
    FDataChange: Boolean;
    FDefaults: TStrings;
    FDriverID: String;
    FEdited: TStrings;
    FResults: TStrings;
    function GetConnectionName: string;
    function GetTempConnection: TFDCustomConnection;
    function IsDriverKnown(const ADrvID: String; out ADrvMeta: IFDPhysDriverMetadata): Boolean;
    procedure BeforeOk;
    procedure FillParamGrids;
    procedure FillConnParams(const AParams: TStrings);
    procedure FillParamValues(const AAsIs: Boolean);
    procedure GetDriverParams(const ADrvID: String; AStrs: TStrings);
    procedure OverrideBy(AThis, AByThat: TStrings);
    procedure PostDataSet;
    procedure PostEdited;
    procedure ResetConnectionDef;
    procedure SetConnectionParams(const AConnection: TFDCustomConnection);
    procedure SetConnectionName(const AValue: string);
    procedure SetConnectionString(const AValue: string);
  public
    property ConnectionName: string read GetConnectionName write SetConnectionName;
    property ConnectionString: string read FConnectionString write SetConnectionString;
  end;

  function frmConnEditor: TfrmConnEditor;

implementation

{$R *.dfm}

uses
{IDE}
  FireDAC.Stan.Util,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants,
{PROJECT}
  cbsMain.data.module.MainModule,
{SPRING}
  Spring.Collections;

const
  DriverID = 'MSSQL';

function frmConnEditor: TfrmConnEditor;
begin
  Result := TfrmConnEditor(damMain.GetFormInstance(TfrmConnEditor));
end;

function GUIxSetupEditor(AItems: TStrings; const AType: String): Integer;
const
  S_True = 'True';
  S_False = 'False';
  S_Yes = 'Yes';
  S_No = 'No';
var
  I: Integer;
begin
  Result := 1;
  if AType = '@L' then
  begin
    AItems.BeginUpdate;
    try
      AItems.Clear;
      AItems.Add(S_True);
      AItems.Add(S_False);
    finally
      AItems.EndUpdate;
    end;
  end
  else if AType = '@Y' then
  begin
    AItems.BeginUpdate;
    try
      AItems.Clear;
      AItems.Add(S_Yes);
      AItems.Add(S_No);
    finally
      AItems.EndUpdate;
    end;
  end
  else if AType = '@I' then
  begin
    Result := 0;
  end
  else if (AType = '') or (AType = '@S') or (AType = '@P') then
  begin
    Result := 0;
  end
  else if Copy(AType, 1, 2) = '@F' then
  begin
//    AFileEdt.Text := '';
//    AOpenDlg.Filter := Copy(AType, 4, MAXINT) + '|All Files|*.*';
//    AOpenDlg.FilterIndex := 0;
    Result := 2;
  end
  else
  begin
    I := 1;
    AItems.BeginUpdate;
    try
      AItems.Clear;
      while I <= Length(AType) do
      begin
        AItems.Add(FDExtractFieldName(AType, I));
      end;
    finally
      AItems.EndUpdate;
    end;
  end;
end;

{ TfrmConnEditor }

function TfrmConnEditor.GetConnectionName: string;
begin
  Result := string(edtConnectionName.Text).Trim;
end;

function TfrmConnEditor.IsDriverKnown(const ADrvID: String; out ADrvMeta: IFDPhysDriverMetadata): Boolean;
begin
  var LManMeta: IFDPhysManagerMetadata;
  FDPhysManager.CreateMetadata(LManMeta);
  for var I := 0 to LManMeta.DriverCount - 1 do if
    CompareText(LManMeta.DriverID[I], ADrvID) = 0 then
  begin
    LManMeta.CreateDriverMetadata(ADrvID, ADrvMeta);
    Exit(True);
  end;
  Result := False;
end;

procedure TfrmConnEditor.actDefaultsExecute(Sender: TObject);
begin
  ResetConnectionDef;
end;

procedure TfrmConnEditor.actOkExecute(Sender: TObject);
begin
  BeforeOk;
  SetConnectionParams(FConnection);
  FConnectionString := FConnection.ResultConnectionDef.BuildString();
  ModalResult := mrOk;
end;

procedure TfrmConnEditor.actTestConnExecute(Sender: TObject);
begin
  try
    var LConn := GetTempConnection;
    try
      LConn.Close;
      LConn.Open;
      ShowMessage('Conexão estabelecida com sucesso.');
    finally
      FDFreeAndNil(LConn);
    end;
  except
    on E: Exception do
    begin
      MessageBox('Erro', 'Erro ao se conectar com o banco de dados.', E.Message, mtError, [mbOK]);
      Abort;
    end;
  end;
end;

procedure TfrmConnEditor.BeforeOk;
type
  IParamList = IDictionary<string, string>;
begin
  if SameText(GetConnectionName, '') then
  begin
    MessageDlg(Format('Digite o %s.', [edtConnectionName.FieldLabel]), mtInformation, [mbOK]);
    Abort;
  end;
  var LParamList := TCollections.CreateDictionary<string, string>;
  try
    mtbPRM.DisableControls;
    try
      LParamList.Add('Database' , 'Digite o nome do banco de dados.');
      LParamList.Add('User_Name', 'Digite o nome de usuário.');
      LParamList.Add('Password' , 'Digite a senha de usuário.');
      LParamList.Add('Server'   , 'Digite o nome ou o IP do servidor.');
      for var LParam in LParamList do if
        mtbPRM.LocateEx(mtbPRMParam.FieldName, LParam.Key, [lxoCaseInsensitive]) and
        mtbPRMValue.AsString.Trim.IsEmpty then
      begin
        MessageDlg(Format('[%s][%s] ' + LParam.Value, [mtbPRMParam.DisplayName, LParam.Key]), mtInformation, [mbOK]);
        Abort;
      end;
    finally
      mtbPRM.EnableControls;
    end;
  finally
    LParamList.Clear;
    LParamList := nil;
  end;
  PostDataSet;
end;

procedure TfrmConnEditor.cbxComboSelect(Sender: TObject);
begin
  pnlValue.Visible := False;
end;

procedure TfrmConnEditor.dsoPRMDataChange(Sender: TObject; Field: TField);
begin
  edtConnectionNameChange(Sender);
end;

procedure TfrmConnEditor.edtConnectionNameChange(Sender: TObject);
begin
  actOk.Enabled := not string(edtConnectionName.Text).Trim.IsEmpty;
  actTestConn.Enabled := actOk.Enabled;
end;

procedure TfrmConnEditor.FillConnParams(const AParams: TStrings);
begin
  AParams.Clear;
  if FConnection <> nil then
    AParams.SetStrings(FEdited)
  else
  begin
    for var I := 0 to FEdited.Count - 1 do
    begin
      var LKey := FEdited.Names[I];
      var LVal := FEdited.Values[LKey];
      var LChanged := False;
      var LRecNo := mtbPRM.RecNo;
      mtbPRM.DisableControls;
      try
        mtbPRM.First;
        while not mtbPRM.Eof do
        begin
          if AnsiCompareText(mtbPRMParam.AsString, LKey) = 0 then
          begin
            LChanged := True;
            Break;
          end;
          mtbPRM.Next;
        end;
      finally
        mtbPRM.RecNo := LRecNo;
        mtbPRM.EnableControls;
      end;
      if LChanged then
      begin
        LChanged := FDefaults.Values[LKey] <> LVal;
      end;
      if LChanged then
      begin
        AParams.Add(LKey + '=' + LVal);
      end;
    end;
  end;
end;

procedure TfrmConnEditor.FillParamGrids;
begin
  var LDrvMeta: IFDPhysDriverMetadata;
  if IsDriverKnown(FDriverID, LDrvMeta) then
  begin
    var LTab := LDrvMeta.GetConnParams(FResults);
    FDataChange := False;
    mtbPRM.DisableControls;
    try
      mtbPRM.EmptyDataSet;
      for var I := 0 to LTab.Rows.Count - 1 do
      begin
        mtbPRM.Append;
        mtbPRMParam.AsString := LTab.Rows[I].GetData('Name');
        mtbPRMValue.AsString := FResults.Values[LTab.Rows[I].GetData('Name')];
        mtbPRMDefault.AsString := LTab.Rows[I].GetData('DefVal');
        mtbPRMParamType.AsString := LTab.Rows[i].GetData('Type');
        mtbPRM.Post;
      end;
      mtbPRM.First;
    finally
      FDFree(LTab);
      mtbPRM.EnableControls;
      FDataChange := True;
    end;
  end;
end;

procedure TfrmConnEditor.FillParamValues(const AAsIs: Boolean);
begin
  var LStrs := TFDStringList.Create;
  try
    FDefaults.Clear;
    if FDriverID <> '' then
    begin
      GetDriverParams(FDriverID, FDefaults);
    end;
    FResults.SetStrings(FDefaults);
    FResults.Values['Name'] := FDriverID;
    if not AAsIs then
    begin
      OverrideBy(FResults, FEdited);
    end;
  finally
    FDFree(LStrs);
  end;
end;

procedure TfrmConnEditor.GetDriverParams(const ADrvID: String; AStrs: TStrings);
begin
  var LDrvMeta: IFDPhysDriverMetadata;
  if IsDriverKnown(ADrvID, LDrvMeta) then
  begin
    var LTab := LDrvMeta.GetConnParams(AStrs);
    try
      for var I := 0 to LTab.Rows.Count - 1 do
      begin
        AStrs.Add(LTab.Rows[I].GetData('Name') + '=' + LTab.Rows[I].GetData('DefVal'));
      end;
    finally
      FDFree(LTab);
    end;
  end;
end;

function TfrmConnEditor.GetTempConnection: TFDCustomConnection;
begin
  Result := TFDConnection.Create(nil);
  if Assigned(FConnection) then
  begin
    Result.Name := FConnection.Name;
  end;
  SetConnectionParams(Result);
  if (FConnection <> nil) and FConnection.Temporary then
  begin
    Result.Params.Pooled := False;
  end;
end;

procedure TfrmConnEditor.grdParamsAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
begin
  if EventName = 'beforeedit' then
  begin
    var LDataSet := grdParams.DataSource.DataSet;
    if not SameText(LDataSet.FieldByName('Param').AsString, 'server') then
    begin
      pnlValue.Title := Format('Parâmetro: %s', [LDataSet.FieldByName('Param').AsString]);
      var LResultIndex := GUIxSetupEditor(cbxCombo.Items, LDataSet.FieldByName('ParamType').AsString);
      pnlValue.Visible := LResultIndex = 1;
      if pnlValue.Visible then
      begin
        grdParams.CancelEditing;
      end;
    end;
  end;
end;

procedure TfrmConnEditor.grdParamsDrawColumnCell(Sender: TObject; ACol, ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  if (ARow = 0) or ((ARow > 0) and (ACol = 2)) then
  begin
    Attribs.Font.Color := $A0A0A0;
    Attribs.Font.Style := [TFontStyle.fsItalic];
  end
  else if (ACol = 1) and (ARow > 0) then
  begin
    var LDS := grdParams.DataSource.DataSet;
    var LKey := LDS.FieldByName('Param').AsString;
    var LValue := LDS.FieldByName('Value').AsString;
    if FDefaults.Values[LKey] <> LValue then
    begin
      Attribs.Color := $E1FFFF;
    end;
    Attribs.Font.Color := $CC6600;
  end;
end;

procedure TfrmConnEditor.grdParamsSelectionChange(Sender: TObject);
begin
  var LCurrentColumn := grdParams.Columns[grdParams.CurrCol];
  pnlValue.Visible := False;
  if not SameText(LCurrentColumn.FieldName, 'Value') then
  begin
    Exit;
  end;
  var LDataSet := grdParams.DataSource.DataSet;
  LCurrentColumn.ReadOnly := LDataSet.RecNo = 1;
end;

procedure TfrmConnEditor.mtbPRMAfterPost(DataSet: TDataSet);
begin
  PostEdited;
end;

procedure TfrmConnEditor.mtbPRMAfterScroll(DataSet: TDataSet);
begin
  pnlValue.Visible := False;
end;

procedure TfrmConnEditor.OverrideBy(AThis, AByThat: TStrings);
begin
  for var I := 0 to AByThat.Count - 1 do
  begin
    var LKey := AByThat.Names[I];
    var LValue := AByThat.Values[LKey];
    AThis.Values[LKey] := LValue;
  end;
end;

procedure TfrmConnEditor.PostDataSet;
begin
  if mtbPRM.State in dsEditModes then
  begin
    mtbPRM.Post;
  end;
end;

procedure TfrmConnEditor.PostEdited;
begin
  PostDataSet;
  if FDataChange then
  begin
    var I := FEdited.IndexOfName(mtbPRMParam.AsString);
    if I = -1 then
    begin
      I := FEdited.Add('');
    end;
    FEdited[I] := mtbPRMParam.AsString + '=' + mtbPRMValue.AsString;
  end;
end;

procedure TfrmConnEditor.ResetConnectionDef;
begin
  FEdited.Clear;
  FillParamValues(True);
  FillParamGrids;
  grdParams.Refresh;
end;

procedure TfrmConnEditor.SetConnectionName(const AValue: string);
begin
  edtConnectionName.Text := AValue;
end;

procedure TfrmConnEditor.SetConnectionParams(const AConnection: TFDCustomConnection);
begin
  AConnection.Close;
  FillConnParams(AConnection.Params);
  AConnection.DriverName := FDriverID;
end;

procedure TfrmConnEditor.SetConnectionString(const AValue: string);
begin
  FConnectionString := AValue;
  FConnection.ResultConnectionDef.ParseString(AValue);
  FConnection.DriverName := DriverID;
  FDriverID := FConnection.DriverName;
  FEdited.SetStrings(FConnection.Params);
  FillParamValues(False);
  FillParamGrids;
end;

procedure TfrmConnEditor.UniFormCreate(Sender: TObject);
begin
  inherited;
  FDefaults := TFDStringList.Create;
  FEdited := TFDStringList.Create;
  FResults := TFDStringList.Create;
  mtbPRM.CreateDataSet;
  FConnection := TFDCustomConnection.Create(nil);
  FConnection.Temporary := True;
end;

procedure TfrmConnEditor.UniFormDestroy(Sender: TObject);
begin
  FDFreeAndNil(FConnection);
  FDFreeAndNil(FDefaults);
  FDFreeAndNil(FResults);
  inherited;
end;

end.
