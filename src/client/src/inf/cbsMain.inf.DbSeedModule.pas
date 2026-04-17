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
  sptSeed.Params.ParamByName('CountryId').AsGuid := StringToGUID('{46A7433E-F36B-1410-871D-007892B87384}');
end;

end.
