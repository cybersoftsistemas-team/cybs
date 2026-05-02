unit cbsUAuth.inf.Repositories.Identity.ConfigRepository;

interface

uses
{PROJECT}
  cbsUAuth.dom.Contracts.Entities.Identity.Config,
  cbsUAuth.dom.Contracts.Repositories.Identity.ConfigRepository;

type
  TIdentityConfigRepository = class(TInterfacedObject, IIdentityConfigRepository)
  private
    FConfig: IIdentityConfig;
    function GetLockoutMinutes: Integer;
    function GetMaxAttempts: Integer;
    function GetPasswordIterations: Integer;
    procedure LoadData;
    procedure SetLockoutMinutes(const AValue: Integer);
    procedure SetMaxAttempts(const AValue: Integer);
    procedure SetPasswordIterations(const AValue: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    property LockoutMinutes: Integer read GetLockoutMinutes write SetLockoutMinutes;
    property MaxAttempts: Integer read GetMaxAttempts write SetMaxAttempts;
    property PasswordIterations: Integer read GetPasswordIterations write SetPasswordIterations;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Support.Container,
  cbsUAuth.inf.Repositories.DataModules.Identity.damIdentityConfig;

{ TIdentityConfigRepository }

constructor TIdentityConfigRepository.Create;
begin
  inherited Create;
  FConfig := App.Make<IIdentityConfig>;
  LoadData;
end;

destructor TIdentityConfigRepository.Destroy;
begin
  App.Release(FConfig);
  inherited;
end;

function TIdentityConfigRepository.GetLockoutMinutes: Integer;
begin
  Result := FConfig.LockoutMinutes;
end;

function TIdentityConfigRepository.GetMaxAttempts: Integer;
begin
  Result := FConfig.MaxAttempts;
end;

function TIdentityConfigRepository.GetPasswordIterations: Integer;
begin
  Result := FConfig.PasswordIterations;
end;

procedure TIdentityConfigRepository.LoadData;
begin
  var LDataModule := App.Make<TdamIdentityConfig>;
  try
    FConfig := LDataModule.GetConfig;
  finally
    App.Release(LDataModule);
  end;
end;

procedure TIdentityConfigRepository.SetLockoutMinutes(const AValue: Integer);
begin
  FConfig.LockoutMinutes := AValue;
end;

procedure TIdentityConfigRepository.SetMaxAttempts(const AValue: Integer);
begin
  FConfig.MaxAttempts := AValue;
end;

procedure TIdentityConfigRepository.SetPasswordIterations(const AValue: Integer);
begin
  FConfig.PasswordIterations := AValue;
end;

end.
