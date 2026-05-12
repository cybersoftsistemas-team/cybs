unit Country.Dom.Common.SystemCountry;

interface

uses
{IDE}
  System.SysUtils;

type
  TSystemCountry = record
  public
    class function BrazilId: TGuid; static;
  end;

implementation

{ TSystemCountry }

class function TSystemCountry.BrazilId: TGuid;
begin
  // Brasil
  Result := StringToGUID('{46A7433E-F36B-1410-871D-007892B87384}');
end;

end.
