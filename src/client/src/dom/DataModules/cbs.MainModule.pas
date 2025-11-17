unit cbs.MainModule;

interface

uses
{IDE}
  cbsCliSrv.MainBaseModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Phys.MSSQLDef, FireDAC.Stan.StorageBin, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, System.Classes, Data.DB, FireDAC.Comp.Client;

type
  TcbsMainModule = class(TcbsCliSrvMainBaseModule)
    Connection: TFDConnection;
    PhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    StanStorageBinLink: TFDStanStorageBinLink;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetMainModule: TcbsMainModule;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication,
  uniGUIVars;

function GetMainModule: TcbsMainModule;
begin
  Result := TcbsMainModule(UniApplication.UniMainModule)
end;

initialization
begin
  RegisterMainModuleClass(TcbsMainModule);
end;

end.
