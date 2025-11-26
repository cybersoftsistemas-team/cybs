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
    mtbUSE: TFDMemTable;
    dsoUSE: TDataSource;
    mtbUSEId: TGuidField;
    mtbUSEName: TStringField;
    mtbUSEPassword: TStringField;
    procedure UniGUIMainModuleCreate(Sender: TObject);
    procedure mtbUSENewRecord(DataSet: TDataSet);
  public
    procedure LoadData(const AFile, AData: string);
    procedure SaveLogonData;
  end;

var
  damLogin: TdamLogin;

implementation

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Support.DataSet.Extensions,
  cbsSystem.Support.Module;

const
  CST_FILENAME_LOGON = 'logon.dat';
  CST_KEY_LOGON      = '{7CEDDCEE-2AAC-4BD6-8609-9580F1BFF871}';

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

procedure TdamLogin.mtbUSENewRecord(DataSet: TDataSet);
begin
  inherited;
  mtbUSEId.AsGuid := TGuid.NewGuid;
end;

procedure TdamLogin.SaveLogonData;
begin
  mtbUSE.SaveData(CST_KEY_LOGON, CST_FILENAME_LOGON);
end;

procedure TdamLogin.UniGUIMainModuleCreate(Sender: TObject);
begin
  inherited;
  damLogin := Self;
  mtbUSE.CreateDataSet;
end;

initialization
begin
  RegisterModuleClass(TdamLogin);
end;

end.
