library cbsUAuth;

uses
  cbsUAuth.Module.ExportMethods in 'src\Module\cbsUAuth.Module.ExportMethods.pas',
  cbsUAuth.Contracts.Module.Api in 'src\Contracts\Module\cbsUAuth.Contracts.Module.Api.pas',
  cbsUAuth.LoginModule in 'src\Module\cbsUAuth.LoginModule.pas' {damLogin};

{$R *.res}

exports
  GetModuleInfo;

begin

end.
