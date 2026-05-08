unit cbsMain.dom.Common.SystemUsers;

interface

uses
{IDE}
  System.SysUtils;

type
  TSystemUsers = record
  public
    class function AdministratorId: TGuid; static;
    class function TemporaryPassword: string; static;
  end;

implementation

class function TSystemUsers.AdministratorId: TGuid;
begin
  Result := StringToGUID('{92A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemUsers.TemporaryPassword: string;
begin
  Result := 'Admin@123';
end;

end.
