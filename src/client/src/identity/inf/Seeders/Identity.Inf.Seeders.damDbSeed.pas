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

    procedure CreateAdminUser(
      const AId: TGuid;
      const AName: string;
      const ADescription: string
    );

    procedure CreateConfig;

    procedure CreateOption(
      const AId: TGuid;
      const AName: string;
      const ADescription: string
    );

  protected
    procedure AfterRunSeed; override;
    procedure OnRunSeed; override;
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
  Identity.Inf.Entities,
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

procedure TdamIdentityDbSeed.CreateAdminUser(
  const AId: TGuid;
  const AName: string;
  const ADescription: string
);
begin
  var LEntity := FUserRepository.Find(AId);
  if not Assigned(LEntity) then
    LEntity := TUserEntity.Create;
  LEntity.Id := AId;
  LEntity.Name := AName;
  LEntity.Description := ADescription;
  LEntity.Reserved := True;
  FUserRepository.Save(LEntity);
end;

procedure TdamIdentityDbSeed.AfterRunSeed;
begin
  var LUser := FUserRepository.Find(TSystemUsers.AdministratorId);
  try
    if Assigned(LUser) and not LUser.PasswordExists then
    begin
      FUserTemporaryPasswordService.Update(
        TSystemUsers.AdministratorId,
        TSystemUsers.TemporaryPassword
      );
    end;
  finally
    FreeAndNil(LUser);
  end;
end;

procedure TdamIdentityDbSeed.CreateConfig;
begin
  FConfigRepository.GetConfig.Free;
end;

procedure TdamIdentityDbSeed.CreateOption(const AId: TGuid; const AName, ADescription: string);
begin
  var LEntity := FOptionRepository.Find(AId);
  if not Assigned(LEntity) then
    LEntity := TOptionEntity.Create;
  LEntity.Id := AId;
  LEntity.Name := AName;
  LEntity.Description := ADescription;
  FOptionRepository.Save(LEntity);
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

