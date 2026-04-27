unit cbsUAuth.ui.Data.Modules.LoginModule;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, System.Classes, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.Async, FireDAC.DApt;

type
  TdamLogin = class(TdamBase)
    dsoCMR: TDataSource;
    dsoCNS: TDataSource;
    dsoUSE: TDataSource;
    mtbCNS: TFDMemTable;
    mtbCNSConnectionString: TStringField;
    mtbCNSId: TGuidField;
    mtbCNSName: TStringField;
    mtbUSE: TFDMemTable;
    mtbUSEDomainId: TGuidField;
    mtbUSEDomainName: TStringField;
    mtbUSEId: TGuidField;
    mtbUSEName: TStringField;
    mtbUSEPassword: TStringField;
    qryCMR: TFDQuery;
    qryCMRClientId: TGuidField;
    qryCMRCreatedAt: TSQLTimeStampField;
    qryCMRCustomerId: TGuidField;
    qryCMRId: TIntegerField;
    procedure mtbCNSAfterDelete(DataSet: TDataSet);
    procedure mtbCNSAfterOpen(DataSet: TDataSet);
    procedure mtbCNSAfterPost(DataSet: TDataSet);
    procedure mtbCNSBeforeDelete(DataSet: TDataSet);
    procedure mtbCNSNewRecord(DataSet: TDataSet);
    procedure mtbUSENewRecord(DataSet: TDataSet);
    procedure UniGUIMainModuleCreate(Sender: TObject);
  private
    procedure SaveOptions;
  public
    function AuthenticateUser(const AUserName, APassword: string; out AError: string): Boolean;
    function ExistsRegisteredCustomer: Boolean;
    procedure LoadData(const AFile, AData: string);
    procedure mtbCNSEmptyDataSet;
    procedure SaveLogonData;
    procedure SetDomain(const AId: TGuid; const AName: string);
  end;

  function damLogin: TdamLogin;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{IDE}

  System.SysUtils,
{PROJECT}
  cbsMain.ui.Data.Modules.MainModule,
  cbsSystem.Support.DataSet.Extensions,
  cbsSystem.Support.Module,
  cbsSystem.Support.ServerModule,
  cbsUAuth.app.Services.AuthService,
  cbsUAuth.dom.Contracts.Services.AuthService;

const
  CST_FILENAME_LOGON   = 'logon.dat';
  CST_FILENAME_OPTIONS = 'options.dat';
  CST_KEY_LOGON        = '{7CEDDCEE-2AAC-4BD6-8609-9580F1BFF871}';
  CST_KEY_OPTIONS      = '{680A7754-FF49-4D05-AD11-35F7910AC2E1}';

function damLogin: TdamLogin;
begin
  Result := TdamLogin(damMain.GetModuleInstance(TdamLogin));
end;

{ TdamLogin }

function TdamLogin.AuthenticateUser(const AUserName, APassword: string; out AError: string): Boolean;
begin
  var LAuth: IAuthService := TAuthService.Create;
  try
    Result := LAuth.Authenticate(mtbUSEName.AsString, mtbUSEPassword.AsString, AError);
  finally
    LAuth := nil;
  end;
end;

function TdamLogin.ExistsRegisteredCustomer: Boolean;
begin
  Result := not ServerModule.Database.Id.IsEmpty;
  if Result then
  begin
    qryCMR.Close;
    try
      qryCMR.Open;
      Result := not qryCMR.IsEmpty;
    except
      Result := False;
    end;
  end;
end;

procedure TdamLogin.LoadData(const AFile, AData: string);
begin
  if SameText(AFile, CST_FILENAME_LOGON) then
  begin
    mtbUSE.LoadData(CST_KEY_LOGON, AData);
    mtbUSE.Edit;
    mtbUSEPassword.Clear;
    mtbUSE.Post;
  end;
end;

procedure TdamLogin.mtbCNSAfterDelete(DataSet: TDataSet);
begin
  SaveOptions;
end;

procedure TdamLogin.mtbCNSAfterOpen(DataSet: TDataSet);
begin
  mtbCNS.LoadData(CST_KEY_OPTIONS, ServerModule.DataStorage.Load(CST_FILENAME_OPTIONS));
end;

procedure TdamLogin.mtbCNSAfterPost(DataSet: TDataSet);
begin
  SaveOptions;
  if IsEqualGUID(damLogin.mtbCNSId.AsGuid, ServerModule.Database.Id) and
    not SameText(damLogin.mtbCNSConnectionString.AsString, ServerModule.Database.ConnectionString) then
  begin
    ServerModule.Database.Clear;
  end;
end;

procedure TdamLogin.mtbCNSBeforeDelete(DataSet: TDataSet);
begin
  if IsEqualGUID(damLogin.mtbCNSId.AsGuid, ServerModule.Database.Id) then
  begin
    ServerModule.Database.Clear;
  end;
end;

procedure TdamLogin.mtbCNSEmptyDataSet;
begin
  mtbCNS.EmptyDataSet;
  SaveOptions;
  ServerModule.Database.Clear;
end;

procedure TdamLogin.mtbCNSNewRecord(DataSet: TDataSet);
begin
  mtbCNSId.AsGuid := TGuid.NewGuid;
end;

procedure TdamLogin.mtbUSENewRecord(DataSet: TDataSet);
begin
  mtbUSEId.AsGuid := TGuid.NewGuid;
end;

procedure TdamLogin.SaveLogonData;
begin
  mtbUSE.SaveData(CST_KEY_LOGON, CST_FILENAME_LOGON);
end;

procedure TdamLogin.SaveOptions;
begin
  mtbCNS.SaveData(CST_KEY_OPTIONS, CST_FILENAME_OPTIONS, csmServerSide);
end;

procedure TdamLogin.SetDomain(const AId: TGuid; const AName: string);
begin
  mtbUSE.Edit;
  mtbUSEDomainId.AsGuid := AId;
  mtbUSEDomainName.AsString := AName;
  mtbUSE.Post;
end;

procedure TdamLogin.UniGUIMainModuleCreate(Sender: TObject);
begin
  inherited;
  mtbUSE.CreateDataSet;
  mtbCNS.CreateDataSet;
end;

initialization
begin
  RegisterModuleType(TdamLogin);
end;

end.
