unit cbsUAuth.dom.Common.Identity.SystemOptions;

interface

uses
{IDE}
  System.SysUtils;

type
  TSystemOptions = record
  public
    class function AccountDisabledId: TGuid; static;
    class function ChangePasswordOnNextLoginId: TGuid; static;
    class function PasswordNeverExpires: TGuid; static;
    class function UserCannotChangeThePasswordId: TGuid; static;
  end;

implementation

class function TSystemOptions.AccountDisabledId: TGuid;
begin
  // Conta desabilitada
  Result := StringToGUID('{91A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemOptions.ChangePasswordOnNextLoginId: TGuid;
begin
  // O usuário deve alterar a senha no próximo logon
  Result := StringToGUID('{85A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemOptions.PasswordNeverExpires: TGuid;
begin
  // A senha nunca expira
  Result := StringToGUID('{8DA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemOptions.UserCannotChangeThePasswordId: TGuid;
begin
  // O usuário não pode alterar a senha
  Result := StringToGUID('{89A7433E-F36B-1410-871D-007892B87384}');
end;

end.
