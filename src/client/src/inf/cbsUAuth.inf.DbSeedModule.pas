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
  cbsMain.dom.Common.SystemUsers,
  cbsUAuth.inf.Identity.Contracts.Repositories.IdentityUserRepository,
  cbsUAuth.app.Identity.Contracts.Services.UserTemporaryPasswordService,
  cbsUAuth.dom.Identity.Common.SystemOptions;

{ TdamDbSeed }

procedure TdamDbSeed.AfterRunSeed;
begin
  inherited;
  var LUser := App.Make<IIdentityUserRepository>.Find(TSystemUsers.AdministratorId);
  try
    if Assigned(LUser) and not LUser.PasswordExists then
    begin
      App.Make<IIdentityUserTemporaryPasswordService>.Update(
        TSystemUsers.AdministratorId,
        TSystemUsers.TemporaryPassword
      );
    end;
  finally
    FreeAndNil(LUser);
  end;
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

