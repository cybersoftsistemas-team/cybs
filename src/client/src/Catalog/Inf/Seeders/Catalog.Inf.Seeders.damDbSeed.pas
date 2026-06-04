unit Catalog.Inf.Seeders.damDbSeed;

interface

uses
{PROJTECT}
  Catalog.Inf.Contracts.Repositories.ConfigRepository,
  cbsSystem.Database.Seeders.DatabaseSeederModule,
{SPRING}
  Spring.Container.Common,
{IDE}
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Stan.Intf, FireDAC.Comp.Script;

type
  TdamCatalogDbSeed = class(TDatabaseSeederModule)
  private
    [Inject] FConfigRepository: IConfigRepository;
  protected
    procedure OnRunSeed; override;
    property ConfigRepository: IConfigRepository read FConfigRepository;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{PROJECT}
  Catalog.Inf.Seeders.damDbSeed.Extensions;

{ damDbCatalogSeed }

procedure TdamCatalogDbSeed.OnRunSeed;
begin
  // Configurações padrões
  CreateConfig;
end;

end.

