unit cbsMain.inf.DbModule;

interface

uses
{PROJECT}
  cbsSystem.Infrastructure.BaseDbModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Phys.MSSQLDef, FireDAC.Stan.StorageBin, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, System.Classes, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,
  System.SysUtils;

type
  TdamDb = class(TdamBaseDb)
    procedure ConnectionError(ASender, AInitiator: TObject; var AException: Exception);
  end;

  function damDb: TdamDb;

implementation

{$R *.dfm}

uses
{PROJECT}
  cbsMain.data.module.MainModule,
  cbsSystem.Support.ServerModule;

function damDb: TdamDb;
begin
  Result := TdamDb(damMain.GetModuleInstance(TdamDb));
end;

procedure TdamDb.ConnectionError(ASender, AInitiator: TObject; var AException: Exception);
begin
  ServerModule.Database.Clear;
end;

end.
