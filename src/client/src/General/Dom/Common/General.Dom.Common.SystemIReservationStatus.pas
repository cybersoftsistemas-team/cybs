unit General.Dom.Common.SystemIReservationStatus;

interface

uses
{IDE}
  System.SysUtils;

type
  TSystemIReservationStatus = record
  public
    class function ActiveTypeId: TGuid; static;
    class function CancelledTypeId: TGuid; static;
    class function ConsumedTypeId: TGuid; static;
    class function ExpiredTypeId: TGuid; static;
    class function IReservationStatusTypeId: TGuid; static;
  end;

implementation

{ TSystemIReservationStatus }

class function TSystemIReservationStatus.ActiveTypeId: TGuid;
begin
  Result := StringToGUID('{0840433e-f36b-1410-8e44-0015417720c6}');
end;

class function TSystemIReservationStatus.CancelledTypeId: TGuid;
begin
  Result := StringToGUID('{0940433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemIReservationStatus.ConsumedTypeId: TGuid;
begin
  Result := StringToGUID('{0C40433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemIReservationStatus.ExpiredTypeId: TGuid;
begin
  Result := StringToGUID('{0F40433E-F36B-1410-8E44-0015417720C6}');
end;

class function TSystemIReservationStatus.IReservationStatusTypeId: TGuid;
begin
  Result := StringToGUID('{0440433E-F36B-1410-8E44-0015417720C6}');
end;

end.
