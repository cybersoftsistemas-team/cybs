unit cbsMigrations.Schema.Types;

interface

type
{$SCOPEDENUMS ON}
  DriverID = (None, MSSQL);
{$SCOPEDENUMS OFF}

  TypeOfString = type string;
  TDbType = TypeOfString;
  TSchema = TypeOfString;
  TTable = TypeOfString;

  DriverIDExtensions = record Helper for DriverID
  public
    function ToString: string;
  end;

  function AsDriverID(const AValue: string; const AReturnFirstWhenNotFound: Boolean = True): DriverID;

implementation

uses
{IDE}
  System.Math,
  System.Rtti;

function AsDriverID(const AValue: string; const AReturnFirstWhenNotFound: Boolean = True): DriverID;
var
  LValue: ShortInt;
begin
  LValue := ShortInt(TRttiEnumerationType.GetValue<DriverID>(AValue));
  if AReturnFirstWhenNotFound then
  begin
    LValue := Max(LValue, 0);
  end;
  Result := DriverID(LValue);
end;

{ DriverIDExtensions }

function DriverIDExtensions.ToString: string;
begin
  Result := TRttiEnumerationType.GetName(Self);
end;

end.
