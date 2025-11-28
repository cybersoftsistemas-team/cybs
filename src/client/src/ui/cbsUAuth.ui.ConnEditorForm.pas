unit cbsUAuth.ui.ConnEditorForm;

interface

uses
{PROJECT}
  cbsSystem.Form.BaseForm,
{IDE}
  uniGUITypes, uniGUIBaseClasses, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, uniGUIClasses,
  uniBasicGrid, uniDBGrid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Classes, System.Actions, Vcl.ActnList, uniButton, uniBitBtn, uniLabel, Vcl.Imaging.pngimage,
  Vcl.Controls, Vcl.Forms, uniImage, uniImageList, System.ImageList, Vcl.ImgList, uniMainMenu;

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
    procedure actOkExecute(Sender: TObject);
    procedure grdParamsDrawColumnCell(Sender: TObject; ACol, ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
    procedure grdParamsSelectionChange(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
  private
    FConnection: TFDCustomConnection;
    FConnectionString: string;
    FDataChange: Boolean;
    FDefaults: TStrings;
    FDriverID: String;
    FEdited: TStrings;
    FResults: TStrings;
    function IsDriverKnown(const ADrvID: String; out ADrvMeta: IFDPhysDriverMetadata): Boolean;
    procedure FillParamGrids;
    procedure FillConnParams(const AParams: TStrings);
    procedure FillParamValues(const AAsIs: Boolean);
    procedure GetDriverParams(const ADrvID: String; AStrs: TStrings);
    procedure OverrideBy(AThis, AByThat: TStrings);
    procedure SetConnectionParams(const AConnection: TFDCustomConnection);
    procedure SetConnectionString(const AValue: string);
  public
    property ConnectionString: string read FConnectionString write SetConnectionString;
  end;

  function frmConnEditor: TfrmConnEditor;

implementation

{$R *.dfm}

uses
{IDE}
  FireDAC.Stan.Util,
  System.SysUtils,
  System.UITypes,
  System.Variants,
  uniGUIApplication;

const
  DriverID = 'MSSQL';

function frmConnEditor: TfrmConnEditor;
begin
  Result := TfrmConnEditor(UniApplication.UniMainModule.GetFormInstance(TfrmConnEditor));
end;

{ TfrmConnEditor }

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

procedure TfrmConnEditor.actOkExecute(Sender: TObject);
begin
  SetConnectionParams(FConnection);
  FConnectionString := FConnection.ResultConnectionDef.BuildString();
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
  var LDataSet := grdParams.DataSource.DataSet;
  var LCurrentColumn := grdParams.Columns[grdParams.CurrCol];
  if SameText(LCurrentColumn.FieldName, 'Value') then
  begin
    LCurrentColumn.ReadOnly := if LDataSet.RecNo = 1 then True else False;
  end;
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
  FDFree(FConnection);
  FDFreeAndNil(FDefaults);
  FDFreeAndNil(FResults);
  FDFreeAndNil(FEdited);
  inherited;
end;

end.
