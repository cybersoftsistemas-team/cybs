unit cbsSystem.Infrastructure.SystemDbModule;

interface

uses
{PROJECT}
  cbsSystem.Infrastructure.BaseDbModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.ConsoleUI.Wait, FireDAC.Phys.MSSQLDef, FireDAC.Stan.StorageBin, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, System.Classes, Data.DB, FireDAC.Comp.Client;

type
  TdamSystemDb = class(TdamBaseDb)
  protected
    procedure OnRunSeed; override;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdamSystemDb }

procedure TdamSystemDb.OnRunSeed;
begin
  inherited;
end;

end.
