unit cbsMigrations.Migrations.MappedColumnType;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MappedColumnType,
  cbsMigrations.Schema.Types;

type
  TMappedColumnType = class(TInterfacedObject, IMappedColumnType)
  private
    FColumnType: TGUID;
    FDbType: TDbType;
    FDriverID: DriverID;
    function GetColumnType: TGUID;
    function GetDbType: TDbType;
    function GetDriverID: DriverID;
  public
    constructor Create(const AColumnType: TGUID; const ADriverID: DriverID; const ADbType: TDbType);
    property ColumnType: TGUID read GetColumnType;
    property DbType: TDbType read GetDbType;
    property DriverID: DriverID read GetDriverID;
  end;

implementation

{ TMappedColumnType }

constructor TMappedColumnType.Create(const AColumnType: TGUID; const ADriverID: DriverID; const ADbType: TDbType);
begin
  inherited Create;
  FColumnType := AColumnType;
  FDbType := ADbType;
  FDriverID := ADriverID;
end;

function TMappedColumnType.GetColumnType: TGUID;
begin
  Result := FColumnType;
end;

function TMappedColumnType.GetDbType: TDbType;
begin
  Result := FDbType;
end;

function TMappedColumnType.GetDriverID: DriverID;
begin
  Result := FDriverID;
end;

end.
