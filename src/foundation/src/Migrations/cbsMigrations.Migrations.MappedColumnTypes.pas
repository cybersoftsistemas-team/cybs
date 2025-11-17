unit cbsMigrations.Migrations.MappedColumnTypes;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MappedColumnTypes,
  cbsMigrations.Schema.Types;

type
  TMappedColumnTypes = class(TInterfacedObject, IMappedColumnTypes)
  private
    FMappedColumnTypeList: IMappedColumnTypeList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetDbType(const AColumnOperation: IInterface; const ADriverID: DriverID): string;
    function Register(const AColumnType: TGUID; const ADriverID: DriverID; const ADbType: TDbType): TMappedColumnTypes;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsMigrations.Contracts.Migrations.MappedColumnType,
  cbsMigrations.Migrations.MappedColumnType;

{ TMappedColumnTypes }

constructor TMappedColumnTypes.Create;
begin
  inherited Create;
  FMappedColumnTypeList := CreateMappedColumnTypeList;
end;

destructor TMappedColumnTypes.Destroy;
begin
  FMappedColumnTypeList.Clear;
  FMappedColumnTypeList := nil;
  inherited;
end;

function TMappedColumnTypes.GetDbType(const AColumnOperation: IInterface; const ADriverID: DriverID): string;
var
  LMappedColumnType: IMappedColumnType;
begin
  LMappedColumnType :=
    FMappedColumnTypeList.FirstOrDefault(
      function(const AMapped: IMappedColumnType): Boolean
      begin
        Result := Supports(AColumnOperation, AMapped.ColumnType) and
          (AMapped.DriverID = ADriverID);
      end);
  if Assigned(LMappedColumnType) then
  begin
    Exit(LMappedColumnType.DbType);
  end;
  Result := '';
end;

function TMappedColumnTypes.Register(const AColumnType: TGUID; const ADriverID: DriverID;
  const ADbType: TDbType): TMappedColumnTypes;
var
  LMappedColumnType: IMappedColumnType;
begin
  LMappedColumnType := TMappedColumnType.Create(AColumnType, ADriverID, ADbType);
  if not FMappedColumnTypeList.Contains(LMappedColumnType,
    function(const ALeft, ARight: IMappedColumnType): Boolean
    begin
      Result := IsEqualGUID(ALeft.ColumnType, ARight.ColumnType) and
        (ALeft.DriverID = ARight.DriverID) and (ALeft.DbType = ARight.DbType);
    end
  ) then
  begin
    FMappedColumnTypeList.Add(TMappedColumnType.Create(AColumnType, ADriverID, ADBType));
  end;
  Result := Self;
end;

end.
