unit cbs.DbModule;

interface

uses
{PROJECT}
  cbsCliSrv.MainBaseModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Phys.MSSQLDef, FireDAC.Stan.StorageBin, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, System.Classes, Data.DB, FireDAC.Comp.Client;

type
  TdamDb = class(TcbsCliSrvMainBaseModule)
    Connection: TFDConnection;
    PhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    StanStorageBinLink: TFDStanStorageBinLink;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function damDb: TdamDb;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIVars,
{PROJECT}
  cbs.MainModule;

function damDb: TdamDb;
begin
  Result := TdamDb(GetMainModule.GetModuleInstance(TdamDb));
end;

initialization
begin
  RegisterModuleClass(TdamDb);
end;

end.
