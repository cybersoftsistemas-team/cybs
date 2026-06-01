unit General.Dom.Common.SystemPGCDataTypes;

interface

uses
{IDE}
  System.SysUtils;

type
  TSystemPGCDataTypes = record
  public
    class function BooleanTypeId: TGuid; static;
    class function DataTypesId: TGuid; static;
    class function DateTimeTypeId: TGuid; static;
    class function DateTypeId: TGuid; static;
    class function DecimalTypeId: TGuid; static;
    class function IntegerTypeId: TGuid; static;
    class function TextTypeId: TGuid; static;
    class function TimeTypeId: TGuid; static;
  end;

implementation

{ TSystemPGCDataTypes }

class function TSystemPGCDataTypes.BooleanTypeId: TGuid;
begin
  Result := StringToGUID('{BE3F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemPGCDataTypes.DataTypesId: TGuid;
begin
  Result := StringToGUID('{B73F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemPGCDataTypes.DateTimeTypeId: TGuid;
begin
  Result := StringToGUID('{C03F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemPGCDataTypes.DateTypeId: TGuid;
begin
  Result := StringToGUID('{C23F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemPGCDataTypes.DecimalTypeId: TGuid;
begin
  Result := StringToGUID('{C33F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemPGCDataTypes.IntegerTypeId: TGuid;
begin
  Result := StringToGUID('{C83F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemPGCDataTypes.TextTypeId: TGuid;
begin
  Result := StringToGUID('{CB3F433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemPGCDataTypes.TimeTypeId: TGuid;
begin
  Result := StringToGUID('{D03F433E-F36B-1410-8E44-0015417720C6}');
end;

end.
