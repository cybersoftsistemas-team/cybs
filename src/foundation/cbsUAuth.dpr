library cbsUAuth;

uses
  cbsUAuth.Module.Info in 'src\Module\cbsUAuth.Module.Info.pas',
  cbsUAuth.Contracts.Module.Api in 'src\Contracts\Module\cbsUAuth.Contracts.Module.Api.pas',
  cbsUAuth.Module.LoginModule in 'src\Module\cbsUAuth.Module.LoginModule.pas' {damLogin},
  cbsUAuth.Module.LoginForm in 'src\Module\cbsUAuth.Module.LoginForm.pas' {frmLogin: TUniLoginForm};

{$R *.res}

exports
  GetModuleInfo;

begin

end.
