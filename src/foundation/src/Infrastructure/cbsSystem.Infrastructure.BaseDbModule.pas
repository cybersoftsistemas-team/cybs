unit cbsSystem.Infrastructure.BaseDbModule;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Phys.MSSQLDef, FireDAC.Stan.StorageBin, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, System.Classes, Data.DB, FireDAC.Comp.Client;

type
  TdamBaseDb = class(TdamBase)
    Connection: TFDConnection;
    PhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    StanStorageBinLink: TFDStanStorageBinLink;
    procedure ConnectionBeforeConnect(Sender: TObject);
  protected
    procedure AfterRunSeed; virtual;
    procedure BeforeRunSeed; virtual;
    procedure OnRunSeed; virtual;
  public
    procedure RunSeed;
  end;

  TDbConnectionModuleClass = class of TdamBaseDb;

implementation

{$R *.dfm}

uses
{PROJECT}
  cbsSystem.Support.ServerModule;

{ TdamBaseDb }

procedure TdamBaseDb.AfterRunSeed;
begin
  // This method can be overwritten by inherited classes.
end;

procedure TdamBaseDb.BeforeRunSeed;
begin
  // This method can be overwritten by inherited classes.
end;

procedure TdamBaseDb.ConnectionBeforeConnect(Sender: TObject);
begin
  Connection.ConnectionString := ServerModule.Database.ConnectionString;
end;

procedure TdamBaseDb.OnRunSeed;
begin
  // This method can be overwritten by inherited classes.
end;

procedure TdamBaseDb.RunSeed;
begin
  BeforeRunSeed;
  OnRunSeed;
  AfterRunSeed;
end;

end.
