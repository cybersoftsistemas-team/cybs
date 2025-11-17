unit cbsCliSrv.UserAuthModule;

interface

uses
{PROJECT}
  cbsCliSrv.MainBaseModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, System.Classes, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TcbsCliSrvUserAuthModule = class(TcbsCliSrvMainBaseModule)
    mtbUSE: TFDMemTable;
    dsoUSE: TDataSource;
    mtbUSEId: TGuidField;
    mtbUSEName: TStringField;
    mtbUSEPassword: TStringField;
    procedure UniGUIMainModuleCreate(Sender: TObject);
  public
    procedure LoadData(const AFile, AData: string);
    procedure SaveLogonData;
  end;

implementation

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
  uniGUIApplication,
{PROJECT}
  cdsCliSrv.FDDataSet.Extensions;

const
  CST_FILENAME_LOGON = 'logon.dat';
  CST_KEY_LOGON = '{7CEDDCEE-2AAC-4BD6-8609-9580F1BFF871}';

{ TcbsCliSrvUserAuthModule }

procedure TcbsCliSrvUserAuthModule.LoadData(const AFile, AData: string);
begin
  if SameText(AFile, CST_FILENAME_LOGON) then
  begin
    mtbUSE.LoadData(CST_KEY_LOGON, AData);
    mtbUSE.Edit;
    mtbUSEPassword.Clear;
    mtbUSE.Post;
  end;
end;

procedure TcbsCliSrvUserAuthModule.SaveLogonData;
begin
  mtbUSE.SaveData(CST_KEY_LOGON, CST_FILENAME_LOGON);
end;

procedure TcbsCliSrvUserAuthModule.UniGUIMainModuleCreate(Sender: TObject);
begin
  inherited;
  mtbUSE.CreateDataSet;
end;

end.
