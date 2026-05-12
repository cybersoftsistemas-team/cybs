unit Address.Dom.Common.SystemState;

interface

type
  TSystemState = record
  public
    class function AC: TGuid; static;
    class function AL: TGuid; static;
    class function AP: TGuid; static;
    class function AM: TGuid; static;
    class function BA: TGuid; static;
    class function CE: TGuid; static;
    class function DF: TGuid; static;
    class function ES: TGuid; static;
    class function GO: TGuid; static;
    class function MA: TGuid; static;
    class function MT: TGuid; static;
    class function MS: TGuid; static;
    class function MG: TGuid; static;
    class function PA: TGuid; static;
    class function PB: TGuid; static;
    class function PR: TGuid; static;
    class function PE: TGuid; static;
    class function PI: TGuid; static;
    class function RJ: TGuid; static;
    class function RN: TGuid; static;
    class function RS: TGuid; static;
    class function RO: TGuid; static;
    class function RR: TGuid; static;
    class function SC: TGuid; static;
    class function SP: TGuid; static;
    class function SE: TGuid; static;
    class function &TO: TGuid; static;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TSystemState }

class function TSystemState.AC: TGuid;
begin
  Result := StringToGUID('{49A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.AL: TGuid;
begin
  Result := StringToGUID('{4CA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.AM: TGuid;
begin
  Result := StringToGUID('{4FA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.AP: TGuid;
begin
  Result := StringToGUID('{52A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.BA: TGuid;
begin
  Result := StringToGUID('{54A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.CE: TGuid;
begin
  Result := StringToGUID('{56A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.DF: TGuid;
begin
  Result := StringToGUID('{58A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.ES: TGuid;
begin
  Result := StringToGUID('{5AA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.GO: TGuid;
begin
  Result := StringToGUID('{5CA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.MA: TGuid;
begin
  Result := StringToGUID('{5EA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.MG: TGuid;
begin
  Result := StringToGUID('{60A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.MS: TGuid;
begin
  Result := StringToGUID('{62A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.MT: TGuid;
begin
  Result := StringToGUID('{64A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.PA: TGuid;
begin
  Result := StringToGUID('{66A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.PB: TGuid;
begin
  Result := StringToGUID('{68A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.PE: TGuid;
begin
  Result := StringToGUID('{6AA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.PI: TGuid;
begin
  Result := StringToGUID('{6CA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.PR: TGuid;
begin
  Result := StringToGUID('{6EA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.RJ: TGuid;
begin
  Result := StringToGUID('{70A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.RN: TGuid;
begin
  Result := StringToGUID('{72A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.RO: TGuid;
begin
  Result := StringToGUID('{74A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.RR: TGuid;
begin
  Result := StringToGUID('{76A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.RS: TGuid;
begin
  Result := StringToGUID('{78A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.SC: TGuid;
begin
  Result := StringToGUID('{7AA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.SE: TGuid;
begin
  Result := StringToGUID('{7CA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.SP: TGuid;
begin
  Result := StringToGUID('{7EA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemState.&TO: TGuid;
begin
  Result := StringToGUID('{80A7433E-F36B-1410-871D-007892B87384}');
end;

end.
