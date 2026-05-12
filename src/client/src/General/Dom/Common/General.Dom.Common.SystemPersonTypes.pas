unit General.Dom.Common.SystemPersonTypes;

interface

uses
{IDE}
  System.SysUtils;

type
  TSystemPersonTypes = record
  public
    class function PersonTypeId: TGuid; static;
    class function NaturalId: TGuid; static;
    class function LegalId: TGuid; static;
  end;

implementation

{ CATEGORIAS: TIPOS DE PESSOAS
  Hierarquia:
    Tipos de Pessoa
        ├── Física
        └── Jurídica
}

{ TSystemPersonTypes }

class function TSystemPersonTypes.PersonTypeId: TGuid;
begin
  // Tipos de Pessoa
  Result := StringToGUID('{68DF423E-F36B-1410-8E3A-0015417720C6}');
end;

class function TSystemPersonTypes.NaturalId: TGuid;
begin
  // Física
  Result := StringToGUID('{69DF423E-F36B-1410-8E3A-0015417720C6}');
end;

class function TSystemPersonTypes.LegalId: TGuid;
begin
  // Jurídica
  Result := StringToGUID('{6BDF423E-F36B-1410-8E3A-0015417720C6}');
end;

end.
