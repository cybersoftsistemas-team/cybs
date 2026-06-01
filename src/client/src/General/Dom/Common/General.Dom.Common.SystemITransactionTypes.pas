unit General.Dom.Common.SystemITransactionTypes;

interface

uses
{IDE}
  System.SysUtils;

type
  TSystemITransTypes = record
  public
    class function AdjustmentTypeId: TGuid; static;
    class function InventoryTypeId: TGuid; static;
    class function ITransTypesId: TGuid; static;
    class function ProductionInTypeId: TGuid; static;
    class function ProductionOutTypeId: TGuid; static;
    class function PurchaseTypeId: TGuid; static;
    class function SaleTypeId: TGuid; static;
    class function TransferInTypeId: TGuid; static;
    class function TransferOutTypeId: TGuid; static;
  end;

implementation

{ TSystemITransTypes }

class function TSystemITransTypes.AdjustmentTypeId: TGuid;
begin
  Result := StringToGUID('{D93F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemITransTypes.InventoryTypeId: TGuid;
begin
  Result := StringToGUID('{DE3F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemITransTypes.ITransTypesId: TGuid;
begin
  Result := StringToGUID('{D23F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemITransTypes.ProductionInTypeId: TGuid;
begin
  Result := StringToGUID('{E43F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemITransTypes.ProductionOutTypeId: TGuid;
begin
  Result := StringToGUID('{E73F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemITransTypes.PurchaseTypeId: TGuid;
begin
  Result := StringToGUID('{DD3F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemITransTypes.SaleTypeId: TGuid;
begin
  Result := StringToGUID('{EC3F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemITransTypes.TransferInTypeId: TGuid;
begin
  Result := StringToGUID('{E33F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemITransTypes.TransferOutTypeId: TGuid;
begin
  Result := StringToGUID('{E63F433E-F36B-1410-8E44-0015417720C6}');
end;

end.
