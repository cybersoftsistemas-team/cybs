unit cbsUAuth.inf.DbModule;

interface

uses
{PROJECT}
  cbsSystem.Infrastructure.BaseDbModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Phys.MSSQLDef, FireDAC.Stan.StorageBin, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, System.Classes, Data.DB, FireDAC.Comp.Client;

type
  TdamDb = class(TdamBaseDb)
  protected
    procedure OnRunSeed; override;
  end;

  function damDb: TdamDb;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication,
{PROJECT}
  cbsSystem.Support.Migrations,
  cbsUAuth.inf.DbUAuthContext;

function damDb: TdamDb;
begin
  Result := TdamDb(UniApplication.UniMainModule.GetModuleInstance(TdamDb));
end;

{ TdamDb }

procedure TdamDb.OnRunSeed;
begin
  inherited;
end;

end.
