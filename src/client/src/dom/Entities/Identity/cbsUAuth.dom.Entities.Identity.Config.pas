unit cbsUAuth.dom.Entities.Identity.Config;

interface

uses
{PROJECT}
  cbsUAuth.dom.Contracts.Entities.Identity.Config;

type
  TConfig = class(TInterfacedObject, IConfig)
  private
    FLockoutMinutes: Integer;
    FMaxAttempts: Integer;
    function GetLockoutMinutes: Integer;
    function GetMaxAttempts: Integer;
    procedure SetLockoutMinutes(const AValue: Integer);
    procedure SetMaxAttempts(const AValue: Integer);
  public
    property LockoutMinutes: Integer read GetLockoutMinutes write SetLockoutMinutes;
    property MaxAttempts: Integer read GetMaxAttempts write SetMaxAttempts;
  end;

implementation

{ TConfig }

function TConfig.GetLockoutMinutes: Integer;
begin
  Result := FLockoutMinutes;
end;

function TConfig.GetMaxAttempts: Integer;
begin
  Result := FMaxAttempts;
end;

procedure TConfig.SetLockoutMinutes(const AValue: Integer);
begin
  FLockoutMinutes := AValue;
end;

procedure TConfig.SetMaxAttempts(const AValue: Integer);
begin
  FMaxAttempts := AValue;
end;

end.
