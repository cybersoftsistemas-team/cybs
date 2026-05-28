unit cbsSystem.Support.Bootstrap;

interface

type
  Bootstrap = class
  private
    class procedure LoadSystemModules; static;
    class procedure RegisterContainerTypes; static;
  public
    class procedure Finalize; static;
    class procedure Implement<TAbstract: IInterface; TConcret: class>; overload; static;
    class procedure Implement<TConcret: class>; overload; static;
    class procedure ImplementSingleton<TAbstract: IInterface; TConcret: class>; overload; static;
    class procedure ImplementSingleton<TConcret: class>; overload; static;
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
  cbsSystem.Support.DatabaseSeederTypeRepository,
  cbsSystem.Support.ModuleManager,
  cbsSystem.Support.RegisterContainer,
  cbsSystem.Support.Translations,
  cbsSystem.Translation.Translator,
  cbsSystem.Validation.Rules.PasswordPolicy,
{SPRING}
  Spring.Container;

{ Bootstrap }

class procedure Bootstrap.Finalize;
begin
  CleanupGlobalContainer;
end;

class procedure Bootstrap.Implement<TAbstract, TConcret>;
begin
  GlobalContainer.RegisterType<TConcret>.Implements<TAbstract>;
end;

class procedure Bootstrap.Implement<TConcret>;
begin
  GlobalContainer.RegisterType<TConcret>(TConcret.QualifiedClassName);
end;

class procedure Bootstrap.ImplementSingleton<TAbstract, TConcret>;
begin
  GlobalContainer.RegisterType<TConcret>.Implements<TAbstract>.AsSingleton;
end;

class procedure Bootstrap.ImplementSingleton<TConcret>;
begin
  GlobalContainer.RegisterType<TConcret>(TConcret.QualifiedClassName).AsSingleton;
end;

class procedure Bootstrap.Initialize;
begin
  LoadSystemModules;
  RegisterContainerTypes;
end;

class procedure Bootstrap.LoadSystemModules;
begin
  ModuleManager.LoadFromFolder(ExtractFilePath(ParamStr(0)));
end;

class procedure Bootstrap.RegisterContainerTypes;
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
  GlobalContainer.RegisterType<PasswordPolicy>.Implements<IPasswordPolicy>;
  GlobalContainer.RegisterType<TDatabaseConfig>.Implements<IDatabaseConfig>;
  GlobalContainer.RegisterType<TDataStorage>.Implements<IDataStorage>;
  GlobalContainer.RegisterType<TMessageBag>.Implements<IMessageBag>;
  GlobalContainer.RegisterType<TTranslator>.Implements<ITranslator>.AsSingleton;
  GlobalContainer.Build;
end;

end.
