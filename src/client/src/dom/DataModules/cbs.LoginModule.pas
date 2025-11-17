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
  uniGUIVars,
{PROJECT}
  cbs.MainModule;

function damLogin: TdamLogin;
begin
  Result := TdamLogin(GetMainModule.GetModuleInstance(TdamLogin));
end;

initialization
begin
  RegisterModuleClass(TdamLogin);
end;

end.
