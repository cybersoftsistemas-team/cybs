unit cbsSystem.Database.Seeders.DatabaseSeederModule;

interface

uses
{IDE}
  System.Classes, FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Stan.Intf, FireDAC.Comp.Script;

type
  TDatabaseSeederModule = class(TDataModule)
    sptSeed: TFDScript;
  protected
    procedure AfterRunSeed; virtual;
    procedure BeforeRunSeed; virtual;
    procedure OnRunSeed; virtual;
  public
    procedure RunSeed;
  end;

  DatabaseSeederModuleType = class of TDatabaseSeederModule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdamDatabaseSeeder }

procedure TDatabaseSeederModule.AfterRunSeed;
begin
  // This method can be overwritten by inherited classes.
end;

procedure TDatabaseSeederModule.BeforeRunSeed;
begin
  // This method can be overwritten by inherited classes.
  if not sptSeed.IsEmpty then
  begin
    sptSeed.ValidateAll;
  end;
end;

procedure TDatabaseSeederModule.OnRunSeed;
begin
  // This method can be overwritten by inherited classes.
  if not sptSeed.IsEmpty then
  begin
    sptSeed.ExecuteAll;
  end;
end;

procedure TDatabaseSeederModule.RunSeed;
begin
  BeforeRunSeed;
  OnRunSeed;
  AfterRunSeed;
end;

end.
