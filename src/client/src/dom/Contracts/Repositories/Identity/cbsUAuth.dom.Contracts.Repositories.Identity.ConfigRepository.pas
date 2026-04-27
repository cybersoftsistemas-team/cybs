unit cbsUAuth.dom.Contracts.Repositories.Identity.ConfigRepository;

interface

type
  IConfigRepository = interface(IUnknown)
    ['{25C301E6-C154-4FE3-A605-3C83B456719A}']
    function GetLockoutMinutes: Integer;
    function GetMaxAttempts: Integer;
    procedure SetLockoutMinutes(const AValue: Integer);
    procedure SetMaxAttempts(const AValue: Integer);
    procedure Save;
    property LockoutMinutes: Integer read GetLockoutMinutes write SetLockoutMinutes;
    property MaxAttempts: Integer read GetMaxAttempts write SetMaxAttempts;
  end;

implementation

end.
