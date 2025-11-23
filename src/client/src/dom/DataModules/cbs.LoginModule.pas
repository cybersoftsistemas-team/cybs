unit cbs.LoginModule;

interface

uses
{PROJECT}
  cbsCliSrv.UserAuthModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, System.Classes, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL;

type
  TdamLogin = class(TcbsCliSrvUserAuthModule)
    procedure mtbUSENewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function damLogin: TdamLogin;

implementation

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
  uniGUIVars,
{PROJECT}
  cbs.MainModule;

function damLogin: TdamLogin;
begin
  Result := TdamLogin(GetMainModule.GetModuleInstance(TdamLogin));
end;

procedure TdamLogin.mtbUSENewRecord(DataSet: TDataSet);
begin
  inherited;
  mtbUSEId.AsGuid := TGuid.NewGuid;
end;

initialization
begin
  RegisterModuleClass(TdamLogin);
end;

end.
