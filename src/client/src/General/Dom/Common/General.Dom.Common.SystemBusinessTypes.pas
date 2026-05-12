unit General.Dom.Common.SystemBusinessTypes;

interface

uses
{IDE}
  System.SysUtils;

type
  TSystemBusinessTypes = record
  public
    class function BusinessTypeId: TGuid; static;
    class function PublicId: TGuid; static;
    class function PrivateId: TGuid; static;
  end;

implementation

{ CATEGORIAS: TIPOS DE EMPRESA
  Hierarquia:
    Tipos de Empresa
        ├── Pública
        └── Privada
}

{ TSystemBusinessTypes }

class function TSystemBusinessTypes.BusinessTypeId: TGuid;
begin
  // Tipos de Empresa
  Result := StringToGUID('{2CA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemBusinessTypes.PublicId: TGuid;
begin
  // Pública
  Result := StringToGUID('{2EA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemBusinessTypes.PrivateId: TGuid;
begin
  // Privada
  Result := StringToGUID('{30A7433E-F36B-1410-871D-007892B87384}');
end;

end.
