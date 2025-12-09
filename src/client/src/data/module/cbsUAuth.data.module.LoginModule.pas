unit cbsUAuth.data.module.LoginModule;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, System.Classes, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdamLogin = class(TdamBase)
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
    procedure LoadData(const AFile, AData: string);
    procedure mtbCNSEmptyDataSet;
    procedure SaveLogonData;
  end;

  function damLogin: TdamLogin;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
  uniGUIApplication,
{PROJECT}
  cbsSystem.Support.DataSet.Extensions,
  cbsSystem.Support.Module,
  cbsSystem.Support.ServerModule;

const
  CST_FILENAME_LOGON   = 'logon.dat';
  CST_FILENAME_OPTIONS = 'options.dat';
  CST_KEY_LOGON        = '{7CEDDCEE-2AAC-4BD6-8609-9580F1BFF871}';
  CST_KEY_OPTIONS      = '{680A7754-FF49-4D05-AD11-35F7910AC2E1}';

function damLogin: TdamLogin;
begin
  Result := TdamLogin(UniApplication.UniMainModule.GetModuleInstance(TdamLogin));
end;

{ TdamLogin }

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
