unit cbsMain.inf.DbModule;

interface

uses
{PROJECT}
  cbsSystem.Infrastructure.BaseDbModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Phys.MSSQLDef, FireDAC.Stan.StorageBin, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, System.Classes, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script;

type
  TdamDb = class(TdamBaseDb);

  function damDb: TdamDb;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication;

function damDb: TdamDb;
begin
  Result := TdamDb(UniApplication.UniMainModule.GetModuleInstance(TdamDb));
end;

end.
