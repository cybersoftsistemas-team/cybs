unit General.Dom.Common.SystemPhones;

interface

uses
{IDE}
  System.SysUtils;

type
  TSystemPhones = record
  public
    class function AssistantId: TGuid; static;
    class function BusinessId: TGuid; static;
    class function MobileId: TGuid; static;
    class function Mobile2Id: TGuid; static;
    class function PhonesId: TGuid; static;
  end;

implementation

{ CATEGORIAS: TELEFONES
  Hierarquia:
  Telefones
     ├── Assistente
     ├── Celular
     ├── Celular 2
     └── Comercial
}

{ TSystemPhones }

class function TSystemPhones.AssistantId: TGuid;
begin
  // Assistente
  Result := StringToGUID('{1DA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemPhones.BusinessId: TGuid;
begin
  // Comercial
  Result := StringToGUID('{29A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemPhones.Mobile2Id: TGuid;
begin
  // Celular 2
  Result := StringToGUID('{25A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemPhones.MobileId: TGuid;
begin
  // Celular
  Result := StringToGUID('{21A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemPhones.PhonesId: TGuid;
begin
  // Telefones
  Result := StringToGUID('{15A7433E-F36B-1410-871D-007892B87384}');
end;

end.
