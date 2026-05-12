unit Identity.Inf.Seeders.damDbSeed;

interface

uses
{PROJTECT}
  cbsSystem.Database.Seeders.DatabaseSeederModule,
  Identity.App.Contracts.Services.UserTemporaryPasswordService,
  Identity.Inf.Contracts.Repositories.ConfigRepository,
  Identity.Inf.Contracts.Repositories.OptionRepository,
  Identity.Inf.Contracts.Repositories.UserRepository,
{IDE}
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Stan.Intf, FireDAC.Comp.Script;

type
  TdamIdentityDbSeed = class(TDatabaseSeederModule)
  private
    FConfigRepository: IConfigRepository;
    FOptionRepository: IOptionRepository;
    FUserRepository: IUserRepository;
    FUserTemporaryPasswordService: IUserTemporaryPasswordService;
  protected
    procedure AfterRunSeed; override;
    procedure OnRunSeed; override;
    property ConfigRepository: IConfigRepository read FConfigRepository;
    property OptionRepository: IOptionRepository read FOptionRepository;
    property UserRepository: IUserRepository read FUserRepository;
    property UserTemporaryPasswordService: IUserTemporaryPasswordService read FUserTemporaryPasswordService;
  public
    constructor Create(
      const AConfigRepository: IConfigRepository;
      const AOptionRepository: IOptionRepository;
      const AUserRepository: IUserRepository;
      const AUserTemporaryPasswordService: IUserTemporaryPasswordService
    ); reintroduce;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{PROJECT}
  Identity.Dom.Common.SystemOptions,
  Identity.Inf.Seeders.damDbSeed.Extensions,
  Shared.Core.Common.SystemUsers;

{ damDbIdentitySeed }

constructor TdamIdentityDbSeed.Create(
  const AConfigRepository: IConfigRepository;
  const AOptionRepository: IOptionRepository;
  const AUserRepository: IUserRepository;
  const AUserTemporaryPasswordService: IUserTemporaryPasswordService
);
begin
  inherited Create(nil);
  FConfigRepository := AConfigRepository;
  FOptionRepository := AOptionRepository;
  FUserRepository := AUserRepository;
  FUserTemporaryPasswordService := AUserTemporaryPasswordService;
end;

procedure TdamIdentityDbSeed.AfterRunSeed;
begin
  CreateUserTemporaryPassword(TSystemUsers.AdministratorId, TSystemUsers.TemporaryPassword);
end;

procedure TdamIdentityDbSeed.OnRunSeed;
begin
  // Configurações padrões
  CreateConfig;
  // Opções de conta de usuários
  CreateOption(TSystemOptions.AccountDisabledId, 'Conta desabilitada', 'Impede que um usuário faça logon com a conta selecionada. Muitos administradores usam contas desabilitadas como modelos para contas de usuário comuns.');
  CreateOption(TSystemOptions.ChangePasswordOnNextLoginId  , 'O usuário deve alterar a senha no próximo logon', 'Força um usuário a alterar a senha na próxima vez que fizer logon na rede. Use esta opção quando deseja garantir que o usuário será a única pessoa a conhecer a senha.');
  CreateOption(TSystemOptions.PasswordNeverExpires, 'A senha nunca expira', 'Impede que uma senha do usuário expire. É recomendável que as contas de Serviço tenham esta opção habilitada e usem senhas de alto nível.');
  CreateOption(TSystemOptions.UserCannotChangeThePasswordId, 'O usuário não pode alterar a senha', 'Impede que os usuários alterem suas senhas. Use esta opção quando desejar manter o controle sobre uma conta de usuário, como uma conta de convidado ou temporária.');
  // Usuário administrador
  CreateAdminUser(TSystemUsers.AdministratorId, 'Administrador', 'Conta interna para a administração de sistemas/domínios.');
end;

end.

