unit cbsMigrations.Schema.Builders;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Schema.Builders,
  cbsMigrations.Schema.Builder,
  cbsMigrations.Schema.Types;

type
  TBuilders = class(TInterfacedObject, IBuilders)
  private
    FBuilderList: IBuilderList;
    function GetDriver(const ADriverID: DriverID): BuilderType;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(const ADriverID: DriverID; const ABuilderType: BuilderType): IBuilders;
    property Driver[const ADriverID: DriverID]: BuilderType read GetDriver; default;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TBuilders }

constructor TBuilders.Create;
begin
  inherited Create;
  FBuilderList := CreateBuilderList;
end;

destructor TBuilders.Destroy;
begin
  FBuilderList.Clear;
  FBuilderList := nil;
  inherited;
end;

function TBuilders.Add(const ADriverID: DriverID; const ABuilderType: BuilderType): IBuilders;
begin
  FBuilderList[ADriverID] := ABuilderType;
  Result := Self;
end;

function TBuilders.GetDriver(const ADriverID: DriverID): BuilderType;
begin
  if not FBuilderList.ContainsKey(ADriverID) then
  begin
    raise Exception.Create('[Migrations][TBuilders.GetDriver] Driver ID is not defined. Set or add DriverID to your connection definition.');
  end;
  Result := FBuilderList[ADriverID];
end;

end.
