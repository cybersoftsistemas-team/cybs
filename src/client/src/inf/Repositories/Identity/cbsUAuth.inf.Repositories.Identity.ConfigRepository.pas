unit cbsUAuth.inf.Repositories.Identity.ConfigRepository;

interface

uses
{PROJECT}
  cbsUAuth.dom.Contracts.Entities.Identity.Config,
  cbsUAuth.dom.Contracts.Repositories.Identity.ConfigRepository;

type
  TConfigRepository = class(TInterfacedObject, IConfigRepository)
  private
    FConfig: IConfig;
    function GetLockoutMinutes: Integer;
    function GetMaxAttempts: Integer;
    procedure Load;
    procedure SetLockoutMinutes(const AValue: Integer);
    procedure SetMaxAttempts(const AValue: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Save;
    property LockoutMinutes: Integer read GetLockoutMinutes write SetLockoutMinutes;
    property MaxAttempts: Integer read GetMaxAttempts write SetMaxAttempts;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsUAuth.dom.Entities.Identity.Config,
  cbsUAuth.inf.Repositories.Identity.Data.Modules.damIdentityConfig;

{ TConfigRepository }

constructor TConfigRepository.Create;
begin
  inherited Create;
  Load;
end;

destructor TConfigRepository.Destroy;
begin
  FConfig := nil;
  inherited;
end;

function TConfigRepository.GetLockoutMinutes: Integer;
begin
  Result := FConfig.LockoutMinutes;
end;

function TConfigRepository.GetMaxAttempts: Integer;
begin
  Result := FConfig.MaxAttempts;
end;

procedure TConfigRepository.Load;
begin
  var Ldam := TdamIdentityConfig.Create(nil);
  try
    FConfig := Ldam.GetConfig;
  finally
    FreeAndNil(Ldam);
  end;
end;

procedure TConfigRepository.Save;
begin

end;

procedure TConfigRepository.SetLockoutMinutes(const AValue: Integer);
begin
  FConfig.LockoutMinutes := AValue;
end;

procedure TConfigRepository.SetMaxAttempts(const AValue: Integer);
begin
  FConfig.MaxAttempts := AValue;
end;

end.
