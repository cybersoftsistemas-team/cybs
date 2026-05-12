unit cbsMain.general.dom.Common.SystemEmails;

interface

uses
{IDE}
  System.SysUtils;

type
  TSystemEmails = record
  public
    class function EmailsId: TGuid; static;
    class function EmailId: TGuid; static;
    class function Email2Id: TGuid; static;
    class function OtherId: TGuid; static;
  end;

implementation

class function TSystemEmails.EmailsId: TGuid;
begin
  // Emails (Pai)
  Result := StringToGUID('{FCA6433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemEmails.EmailId: TGuid;
begin
  // Email
  Result := StringToGUID('{FEA6433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemEmails.Email2Id: TGuid;
begin
  // Email 2
  Result := StringToGUID('{01A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemEmails.OtherId: TGuid;
begin
  // Outro
  Result := StringToGUID('{02A7433E-F36B-1410-871D-007892B87384}');
end;

end.
