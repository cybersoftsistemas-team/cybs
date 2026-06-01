unit General.Dom.Common.SystemMeasureTypes;

interface

type
  TSystemMeasureTypes = record
  public
    class function AreaId: TGuid; static;
    class function CountId: TGuid; static;
    class function LengthId: TGuid; static;
    class function MeasureTypeId: TGuid; static;
    class function TimeId: TGuid; static;
    class function VolumeId: TGuid; static;
    class function WeightId: TGuid; static;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TSystemMeasureTypes }

class function TSystemMeasureTypes.AreaId: TGuid;
begin
  Result := StringToGUID('{DA57433E-F36B-1410-8E43-0015417720C6}');
end;

class function TSystemMeasureTypes.CountId: TGuid;
begin
  Result := StringToGUID('{DC57433E-F36B-1410-8E43-0015417720C6}');
end;

class function TSystemMeasureTypes.LengthId: TGuid;
begin
  Result := StringToGUID('{DD57433E-F36B-1410-8E43-0015417720C6}');
end;

class function TSystemMeasureTypes.MeasureTypeId: TGuid;
begin
  Result := StringToGUID('{E457433E-F36B-1410-8E43-0015417720C6}');
end;

class function TSystemMeasureTypes.TimeId: TGuid;
begin
  Result := StringToGUID('{E357433E-F36B-1410-8E43-0015417720C6}');
end;

class function TSystemMeasureTypes.VolumeId: TGuid;
begin
  Result := StringToGUID('{E857433E-F36B-1410-8E43-0015417720C6}');
end;

class function TSystemMeasureTypes.WeightId: TGuid;
begin
  Result := StringToGUID('{EC57433E-F36B-1410-8E43-0015417720C6}');
end;

end.
