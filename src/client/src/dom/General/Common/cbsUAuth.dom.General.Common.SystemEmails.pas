unit cbsUAuth.dom.General.Common.SystemEmails;

interface

uses
{IDE}
  System.SysUtils;

type
  TSystemEmails = record
  public
    class function ElsEmailsIdId: TGuid; static;
    class function ElsEmailIdId: TGuid; static;
    class function ElsEmail2IdId: TGuid; static;
    class function ElsOtherIdId: TGuid; static;
  end;

implementation

class function TSystemEmails.ElsEmailsIdId: TGuid;
begin
  // Emails (Pai)
  Result := StringToGUID('{FCA6433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemEmails.ElsEmailIdId: TGuid;
begin
  // Email
  Result := StringToGUID('{FEA6433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemEmails.ElsEmail2IdId: TGuid;
begin
  // Email 2
  Result := StringToGUID('{01A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemEmails.ElsOtherIdId: TGuid;
begin
  // Outro
  Result := StringToGUID('{02A7433E-F36B-1410-871D-007892B87384}');
end;

end.
