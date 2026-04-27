unit cbsUAuth.dom.Contracts.Services.AuthService;

interface

type
  IAuthService = interface(IUnknown)
    ['{5226C4F7-E276-45C5-A16D-8D98763E50FA}']
    function Authenticate(const AUserName, APassword: string; out AError: string): Boolean;
    function ChangePassword(const AUserId: TGuid; const ACurrentPassword, ANewPassword: string): Boolean;
    procedure TryCreateAdminWithTemporaryPassword(const AUserName, ATempPassword: string);
  end;

implementation

end.
