unit Identity.UI.Data.Modules.LoginModule;

interface

uses
{PROJECT}
  cbsSystem.Contracts.DatabaseConfig,
  cbsSystem.Module.BaseModule,
  Identity.App.Common.AuthResult,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, System.Classes, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.Async, FireDAC.DApt;

type
  TdamLogin = class(TdamBase)
    dsoCNS: TDataSource;
    dsoUSE: TDataSource;
    mtbCNS: TFDMemTable;
    mtbCNSConnectionString: TStringField;
    mtbCNSId: TGuidField;
    mtbCNSName: TStringField;
    mtbUSE: TFDMemTable;
    mtbUSEDomainName: TStringField;
    mtbUSEName: TStringField;
    mtbUSEPassword: TStringField;
    mtbUSERememberYourLoginCredentials: TBooleanField;
    procedure mtbCNSAfterDelete(DataSet: TDataSet);
    procedure mtbCNSAfterOpen(DataSet: TDataSet);
    procedure mtbCNSAfterPost(DataSet: TDataSet);
    procedure mtbCNSBeforeDelete(DataSet: TDataSet);
    procedure mtbCNSNewRecord(DataSet: TDataSet);
    procedure UniGUIMainModuleCreate(Sender: TObject);
  private
    FDatabaseConfig: IDatabaseConfig;
    procedure SaveOptions;
    procedure TryClearUserCredentials;
  public
    function AuthenticateUser(const AUserName, APassword: string): TUserAuthResult;
    procedure ClearUserPassword;
    procedure LoadData(const AFile, AData: string);
    procedure mtbCNSEmptyDataSet;
    procedure SaveLogonData;
    procedure SetDomain(const AName: string);
  end;

  function damLogin: TdamLogin;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{IDE}
  System.Math,
  System.SysUtils,
{PROJECT}
  cbsSystem.Contracts.DataStorage,
  cbsSystem.Support.Container,
  cbsSystem.Support.DataSet.Extensions,
  Identity.App.Common.UserAuthError,
  Identity.App.Contracts.Services.UserAuthService,
  Identity.Dom.Exceptions.UserAuthError,
  Shared.UI.Data.Modules.MainModule;

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

function TdamLogin.AuthenticateUser(const AUserName, APassword: string): TUserAuthResult;
begin
  Result := App.Make<IUserAuthService>.Authenticate(
    mtbUSEName.AsString,
    mtbUSEPassword.AsString
  );
  var LUser := Result.Value;
  if not Result.IsSuccess then
  begin
    TryClearUserCredentials;
    mtbUSEPassword.FocusControl;
    try
      case Result.Error of
        aeAccountLocked:
          raise Exception.CreateFmt(UserAuthErrorToMessage(aeAccountLocked), [Ceil((LUser.LockoutEnd.Value - Now) * 24 * 60)]);
        else
          raise Exception.Create(UserAuthErrorToMessage(Result.Error));
      end;
    finally
      FreeAndNil(LUser);
    end;
  end;
end;

procedure TdamLogin.ClearUserPassword;
begin
  mtbUSE.Edit;
  mtbUSEPassword.Clear;
  mtbUSE.Post;
end;

procedure TdamLogin.LoadData(const AFile, AData: string);
begin
  if SameText(AFile, CST_FILENAME_LOGON) then
  begin
    mtbUSE.LoadData(CST_KEY_LOGON, AData);
    TryClearUserCredentials;
  end;
end;

procedure TdamLogin.mtbCNSAfterDelete(DataSet: TDataSet);
begin
  SaveOptions;
end;

procedure TdamLogin.mtbCNSAfterOpen(DataSet: TDataSet);
begin
  mtbCNS.LoadData(CST_KEY_OPTIONS, App.Make<IDataStorage>.Load(CST_FILENAME_OPTIONS));
end;

procedure TdamLogin.mtbCNSAfterPost(DataSet: TDataSet);
begin
  SaveOptions;
  if IsEqualGUID(mtbCNSId.AsGuid, FDatabaseConfig.Id) and
    not SameText(mtbCNSConnectionString.AsString, FDatabaseConfig.ConnectionString) then
  begin
    FDatabaseConfig.Clear;
  end;
end;

procedure TdamLogin.mtbCNSBeforeDelete(DataSet: TDataSet);
begin
  if IsEqualGUID(mtbCNSId.AsGuid, FDatabaseConfig.Id) then
  begin
    FDatabaseConfig.Clear;
  end;
end;

procedure TdamLogin.mtbCNSEmptyDataSet;
begin
  mtbCNS.EmptyDataSet;
  SaveOptions;
  FDatabaseConfig.Clear;
end;

procedure TdamLogin.mtbCNSNewRecord(DataSet: TDataSet);
begin
  mtbCNSId.AsGuid := TGuid.NewGuid;
end;

procedure TdamLogin.SaveLogonData;
begin
  mtbUSE.SaveData(CST_KEY_LOGON, CST_FILENAME_LOGON);
end;

procedure TdamLogin.SaveOptions;
begin
  mtbCNS.SaveData(CST_KEY_OPTIONS, CST_FILENAME_OPTIONS, csmServerSide);
end;

procedure TdamLogin.SetDomain(const AName: string);
begin
  mtbUSE.Edit;
  mtbUSEDomainName.AsString := AName;
  mtbUSE.Post;
end;

procedure TdamLogin.TryClearUserCredentials;
begin
  if not mtbUSERememberYourLoginCredentials.AsBoolean then
  begin
    mtbUSE.Edit;
    mtbUSEName.Clear;
    mtbUSEDomainName.Clear;
    mtbUSE.Post;
  end;
  ClearUserPassword;
end;

procedure TdamLogin.UniGUIMainModuleCreate(Sender: TObject);
begin
  inherited;
  FDatabaseConfig := App.Make<IDatabaseConfig>;
  mtbUSE.CreateDataSet;
  mtbCNS.CreateDataSet;
end;

initialization
begin
  RegisterModuleType(TdamLogin);
end;

end.
