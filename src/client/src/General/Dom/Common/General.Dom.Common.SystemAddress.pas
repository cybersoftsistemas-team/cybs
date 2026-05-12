unit General.Dom.Common.SystemAddress;

interface

uses
{IDE}
  System.SysUtils;

type
  TSystemAddress = record
  public
    class function AddressId: TGuid; static;
    class function BusinessId: TGuid; static;
    class function ResidentialId: TGuid; static;
    class function OtherId: TGuid; static;
  end;

implementation

{ CATEGORIAS: ENDEREÇO
  Hierarquia:
    Endereço
      ├── Comercial
      ├── Residencial
      └── Outro
}

{ TSystemAddress }

class function TSystemAddress.AddressId: TGuid;
begin
  // Endereço (Pai)
  Result := StringToGUID('{08A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemAddress.BusinessId: TGuid;
begin
  // Comercial
  Result := StringToGUID('{0AA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemAddress.ResidentialId: TGuid;
begin
  // Residencial
  Result := StringToGUID('{0DA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemAddress.OtherId: TGuid;
begin
  // Outro
  Result := StringToGUID('{10A7433E-F36B-1410-871D-007892B87384}');
end;

end.
