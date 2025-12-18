unit cbsSystem.Infrastructure.BaseDbModule;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Phys.MSSQLDef, FireDAC.Stan.StorageBin, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, System.Classes, Data.DB, FireDAC.Comp.Client,
  FireDAC.ConsoleUI.Wait;

type
  TdamBaseDb = class(TdamBase)
    Connection: TFDConnection;
    PhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    StanStorageBinLink: TFDStanStorageBinLink;
    procedure ConnectionBeforeConnect(Sender: TObject);
  end;

  DbConnectionModuleType = class of TdamBaseDb;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{PROJECT}
  cbsSystem.Support.ServerModule;

{ TdamBaseDb }

procedure TdamBaseDb.ConnectionBeforeConnect(Sender: TObject);
begin
  Connection.ConnectionString := ServerModule.Database.ConnectionString;
end;

end.
