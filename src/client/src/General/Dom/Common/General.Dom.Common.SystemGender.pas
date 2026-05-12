unit General.Dom.Common.SystemGender;

interface

uses
{IDE}
  System.SysUtils;

type
  TSystemGender = record
  public
    class function FemaleId: TGuid; static;
    class function GenderId: TGuid; static;
    class function MaleId: TGuid; static;
  end;

implementation

{ CATEGORIAS: GÊNERO
  Hierarquia:
    Gênero
        ├── Feminino
        └── Masculino
}

{ TSystemGender }

class function TSystemGender.FemaleId: TGuid;
begin
  // Feminino
  Result := StringToGUID('{3CA7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemGender.GenderId: TGuid;
begin
  // Gênero
  Result := StringToGUID('{34A7433E-F36B-1410-871D-007892B87384}');
end;

class function TSystemGender.MaleId: TGuid;
begin
  // Masculino
  Result := StringToGUID('{40A7433E-F36B-1410-871D-007892B87384}');
end;

end.
