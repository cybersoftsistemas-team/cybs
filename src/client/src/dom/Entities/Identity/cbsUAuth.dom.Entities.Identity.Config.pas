unit cbsUAuth.dom.Entities.Identity.Config;

interface

uses
{PROJECT}
  cbsUAuth.dom.Contracts.Entities.Identity.Config;

type
  TIdentityConfig = class(TInterfacedObject, IIdentityConfig)
  private
    FLockoutMinutes: Integer;
    FMaxAttempts: Integer;
    FPasswordIterations: Integer;
    function GetLockoutMinutes: Integer;
    function GetMaxAttempts: Integer;
    function GetPasswordIterations: Integer;
    procedure SetLockoutMinutes(const AValue: Integer);
    procedure SetMaxAttempts(const AValue: Integer);
    procedure SetPasswordIterations(const AValue: Integer);
  public
    property LockoutMinutes: Integer read GetLockoutMinutes write SetLockoutMinutes;
    property MaxAttempts: Integer read GetMaxAttempts write SetMaxAttempts;
    property PasswordIterations: Integer read GetPasswordIterations write SetPasswordIterations;
  end;

implementation

{ TIdentityConfig }

function TIdentityConfig.GetLockoutMinutes: Integer;
begin
  Result := FLockoutMinutes;
end;

function TIdentityConfig.GetMaxAttempts: Integer;
begin
  Result := FMaxAttempts;
end;

function TIdentityConfig.GetPasswordIterations: Integer;
begin
  Result := FPasswordIterations;
end;

procedure TIdentityConfig.SetLockoutMinutes(const AValue: Integer);
begin
  FLockoutMinutes := AValue;
end;

procedure TIdentityConfig.SetMaxAttempts(const AValue: Integer);
begin
  FMaxAttempts := AValue;
end;

procedure TIdentityConfig.SetPasswordIterations(const AValue: Integer);
begin
  FPasswordIterations := AValue;
end;

end.
