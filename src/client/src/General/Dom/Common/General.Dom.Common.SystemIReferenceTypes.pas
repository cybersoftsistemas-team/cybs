unit General.Dom.Common.SystemIReferenceTypes;

interface

uses
{IDE}
  System.SysUtils;

type
  TSystemIReferenceTypes = record
  public
    class function IAdjustmentTypeId: TGuid; static;
    class function IReferenceTypesId: TGuid; static;
    class function ProductionOrderTypeId: TGuid; static;
    class function PurchaseOrderTypeId: TGuid; static;
    class function TransferOrderTypeId: TGuid; static;
    class function SalesOrderTypeId: TGuid; static;
  end;

implementation

{ TSystemIReferenceTypes }

class function TSystemIReferenceTypes.IAdjustmentTypeId: TGuid;
begin
  Result := StringToGUID('{F43F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemIReferenceTypes.IReferenceTypesId: TGuid;
begin
  Result := StringToGUID('{ED3F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemIReferenceTypes.ProductionOrderTypeId: TGuid;
begin
  Result := StringToGUID('{F63F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemIReferenceTypes.PurchaseOrderTypeId: TGuid;
begin
  Result := StringToGUID('{FC3F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemIReferenceTypes.SalesOrderTypeId: TGuid;
begin
  Result := StringToGUID('{0040433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemIReferenceTypes.TransferOrderTypeId: TGuid;
begin
  Result := StringToGUID('{F83F433E-F36B-1410-8E44-0015417720C6}');
end;

end.
