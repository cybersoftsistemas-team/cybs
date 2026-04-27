unit cbsUAuth.dom.Contracts.Entities.Identity.Config;

interface

type
  IConfig = interface(IUnknown)
    ['{9A274BBC-DF72-435F-AB00-929ED01A4F1A}']
    function GetLockoutMinutes: Integer;
    function GetMaxAttempts: Integer;
    procedure SetLockoutMinutes(const AValue: Integer);
    procedure SetMaxAttempts(const AValue: Integer);
    property LockoutMinutes: Integer read GetLockoutMinutes write SetLockoutMinutes;
    property MaxAttempts: Integer read GetMaxAttempts write SetMaxAttempts;
  end;

implementation

end.
