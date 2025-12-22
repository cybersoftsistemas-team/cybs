unit cbsMain.inf.DbSeedModule;

interface

uses
{PROJTECT}
  cbsSystem.Database.Seeders.DatabaseSeederModule,
{IDE}
  FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, System.Classes, FireDAC.Stan.Intf, FireDAC.Comp.Script;

type
  TdamDbSeed = class(TDatabaseSeederModule)
  protected
    procedure BeforeRunSeed; override;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{IDE}
  System.SysUtils;

{ TdamDbSeed }

procedure TdamDbSeed.BeforeRunSeed;
begin
  inherited;
  sptSeed.Params.ParamByName('CountryId').AsGuid := StringToGUID('{9F6E6D3A-1F5A-4C8C-9C9E-55B55E55B555}');
end;

end.
