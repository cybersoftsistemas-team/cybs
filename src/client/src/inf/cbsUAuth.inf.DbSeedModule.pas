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
    procedure BeforeRunSeed; override;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{PROJECT}
  cbsSystem.Support.Container,
  cbsUAuth.dom.Contracts.Services.AuthService,
  cbsUAuth.dom.Identity.Common.SystemOptions,
  cbsUAuth.dom.Identity.Common.SystemUsers;

{ TdamDbSeed }

procedure TdamDbSeed.AfterRunSeed;
begin
  inherited;
  App.Make<IAuthService>.TryCreateAdminWithTemporaryPassword;
end;

procedure TdamDbSeed.BeforeRunSeed;
begin
  inherited;
  sptSeed.Params.ParamByName('AccountDisabledId').AsGuid := TSystemOptions.AccountDisabledId;
  sptSeed.Params.ParamByName('AdministratorId').AsGuid := TSystemUsers.AdministratorId;
  sptSeed.Params.ParamByName('ChangePasswordOnNextLoginId').AsGuid := TSystemOptions.ChangePasswordOnNextLoginId;
  sptSeed.Params.ParamByName('PasswordNeverExpires').AsGuid := TSystemOptions.PasswordNeverExpires;
  sptSeed.Params.ParamByName('UserCannotChangeThePasswordId').AsGuid := TSystemOptions.UserCannotChangeThePasswordId;
end;

end.

