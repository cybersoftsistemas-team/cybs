unit cbsUAuth.Contracts.Module.Api;

interface

type
  IcbsUAuthModuleApi = interface(IUnknown)
    ['{EEB07C2D-8BE9-4F82-A7DC-BE0DB822A9AB}']
    procedure ShowLoginForm;
    procedure ShowChangePasswordForm;
    procedure ShowMfaForm;
  end;

implementation

end.
