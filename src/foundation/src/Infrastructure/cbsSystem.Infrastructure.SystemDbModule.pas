unit cbsSystem.Infrastructure.SystemDbModule;

interface

uses
{PROJECT}
  cbsSystem.Infrastructure.BaseDbModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.ConsoleUI.Wait, FireDAC.Phys.MSSQLDef, FireDAC.Stan.StorageBin, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, System.Classes, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script;

type
  TdamSystemDb = class(TdamBaseDb);

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
