unit Shared.Core.Bootstrap;

interface

uses
{SPRING}
  Spring.Container.Core;

type
  TBootstrap = class
  private
    class procedure LoadSystemModules; static;
    class procedure RegisterContainerTypes; static;
  public
    class procedure Finalize; static;
    class procedure Implement<TAbstract: IInterface; TConcret: class>; overload; static;
    class procedure Implement<TConcret: class>; overload; static;
    class procedure Implement<TConcret: class>(const ADelegate: TActivatorDelegate<TConcret>); overload; static;
    class procedure ImplementSingleton<TAbstract: IInterface; TConcret: class>; overload; static;
    class procedure ImplementSingleton<TConcret: class>; overload; static;
    class procedure ImplementSingleton<TConcret: class>(const ADelegate: TActivatorDelegate<TConcret>); overload; static;
    class procedure Initialize; static;
  end;

implementation

uses
{IDE}
  FireDAC.Comp.Client,
  System.SysUtils,
{PROJECT}
  cbsSystem.Contracts.DatabaseConfig,
  cbsSystem.Contracts.Database.Seeders.DatabaseSeeder,
  cbsSystem.Contracts.DataStorage,
  cbsSystem.Contracts.MessageBag,
  cbsSystem.Contracts.Translation.Translator,
  cbsSystem.Contracts.Validation.Rules.PasswordPolicy,
  cbsSystem.DatabaseConfig,
  cbsSystem.DataStorage,
  cbsSystem.MessageBag,
  cbsSystem.Support.Container,
  cbsSystem.Support.DatabaseSeederTypeRepository,
  cbsSystem.Support.ModuleManager,
  cbsSystem.Support.RegisterContainer,
  cbsSystem.Support.Translations,
  cbsSystem.Translation.Translator,
  cbsSystem.Validation.Rules.PasswordPolicy,
  Shared.Inf.Contracts.Services.DatabaseUpdaterService,
  Shared.Inf.Database.Connection,
  Shared.Inf.Database.Context,
  Shared.Inf.Services.DatabaseUpdaterService,
{SPRING}
  Spring.Container,
  Spring.Persistence.Adapters.FireDAC,
  Spring.Persistence.Core.Session;

{ TBootstrap }

class procedure TBootstrap.Finalize;
begin
  CleanupGlobalContainer;
end;

class procedure TBootstrap.Implement<TAbstract, TConcret>;
begin
  GlobalContainer.RegisterType<TConcret>.Implements<TAbstract>;
end;

class procedure TBootstrap.Implement<TConcret>(const ADelegate: TActivatorDelegate<TConcret>);
begin
  GlobalContainer.RegisterType<TConcret>(ADelegate);
end;

class procedure TBootstrap.Implement<TConcret>;
begin
  GlobalContainer.RegisterType<TConcret>(TConcret.QualifiedClassName);
end;

class procedure TBootstrap.ImplementSingleton<TAbstract, TConcret>;
begin
  GlobalContainer.RegisterType<TConcret>.Implements<TAbstract>.AsSingleton;
end;

class procedure TBootstrap.ImplementSingleton<TConcret>(const ADelegate: TActivatorDelegate<TConcret>);
begin
  GlobalContainer.RegisterType<TConcret>(ADelegate).AsSingleton;
end;

class procedure TBootstrap.ImplementSingleton<TConcret>;
begin
  GlobalContainer.RegisterType<TConcret>(TConcret.QualifiedClassName).AsSingleton;
end;

class procedure TBootstrap.Initialize;
begin
  LoadSystemModules;
  RegisterContainerTypes;
end;

class procedure TBootstrap.LoadSystemModules;
begin
  ModuleManager.LoadFromFolder(ExtractFilePath(ParamStr(0)));
end;

class procedure TBootstrap.RegisterContainerTypes;
begin
  for var LItem in Container do
  begin
    var LShared := LItem.Value.Value;
    var LRegisterType := GlobalContainer.RegisterType(LItem.Key,
      if Assigned(LItem.Value.Key) then LItem.Value.Key else LItem.Key);
    if Assigned(LRegisterType) and LShared then
    begin
      LRegisterType.AsSingleton;
    end;
  end;
  for var LDbSeederType in DatabaseSeederTypeRepository do
  begin
    GlobalContainer.RegisterType(LDbSeederType.ClassInfo).Implements<IDatabaseSeeder>(LDbSeederType.QualifiedClassName);
  end;
  Implement<TSession>(
    function: TSession
    begin
      Result := TSession.Create(TFireDACConnectionAdapter.Create(App.Make<TdamDb>.Connection));
    end
  );
  Implement<IPasswordPolicy, PasswordPolicy>;
  Implement<IMessageBag, TMessageBag>;
  ImplementSingleton<TdamDb>;
  ImplementSingleton<TDbContext>;
  ImplementSingleton<IDatabaseUpdaterService, TDatabaseUpdaterService>;
  ImplementSingleton<IDatabaseConfig, TDatabaseConfig>;
  ImplementSingleton<IDataStorage, TDataStorage>;
  ImplementSingleton<ITranslator, TTranslator>;
  GlobalContainer.Build;
end;

end.
