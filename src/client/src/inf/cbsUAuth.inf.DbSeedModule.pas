unit cbsUAuth.inf.DbSeedModule;

interface

uses
{PROJTECT}
  cbsSystem.Database.Seeders.DatabaseSeederModule,
{IDE}
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Stan.Intf, FireDAC.Comp.Script;

type
  TdamDbSeed = class(TDatabaseSeederModule)
  protected
    procedure AfterRunSeed; override;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{PROJECT}
  cbsUAuth.dom.Contracts.Services.AuthService,
  cbsUAuth.app.Services.AuthService;

{ TdamDbSeed }

procedure TdamDbSeed.AfterRunSeed;
begin
  inherited;
  var LAuth: IAuthService := TAuthService.Create;
  try
    LAuth.TryCreateAdminWithTemporaryPassword('Administrador', 'Admin@123');
  finally
    LAuth := nil;
  end;
end;

end.
