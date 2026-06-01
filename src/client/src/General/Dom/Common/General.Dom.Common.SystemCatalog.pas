unit General.Dom.Common.SystemCatalog;

interface

type
  TSystemCatalog = record
  public
    class function CatalogTypeId: TGuid; static;
    class function ProductTypeId: TGuid; static;
    class function ServiceTypeId: TGuid; static;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TSystemCatalog }

class function TSystemCatalog.CatalogTypeId: TGuid;
begin
  Result := StringToGUID('{CE57433E-F36B-1410-8E43-0015417720C6}');
end;

class function TSystemCatalog.ProductTypeId: TGuid;
begin
  Result := StringToGUID('{D457433E-F36B-1410-8E43-0015417720C6}');
end;

class function TSystemCatalog.ServiceTypeId: TGuid;
begin
  Result := StringToGUID('{D657433E-F36B-1410-8E43-0015417720C6}');
end;

end.
