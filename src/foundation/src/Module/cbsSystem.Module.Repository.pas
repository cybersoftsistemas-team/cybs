unit cbsSystem.Module.Repository;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module.Repository;

type
  TcbsModuleTypeRepository = class(TInterfacedObject, IModuleTypeRepository)
  private
    FMainModuleType: MainModuleType;
    FModuleTypeList: IModuleTypeList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetMainModule: MainModuleType;
    function GetModuleTypes: IModuleTypes;
    procedure Register(const AModuleType: ModuleType);
    procedure RegisterMain(const AMainModuleType: MainModuleType);
  end;

implementation

{ TcbsModuleTypeRepository }

constructor TcbsModuleTypeRepository.Create;
begin
  inherited Create;
  FModuleTypeList := CreateModuleTypeList;
end;

destructor TcbsModuleTypeRepository.Destroy;
begin
  FModuleTypeList := nil;
  inherited;
end;

function TcbsModuleTypeRepository.GetMainModule: MainModuleType;
begin
  Result := FMainModuleType;
end;

function TcbsModuleTypeRepository.GetModuleTypes: IModuleTypes;
begin
  Result := FModuleTypeList;
end;

procedure TcbsModuleTypeRepository.Register(const AModuleType: ModuleType);
begin
  if Assigned(AModuleType) and
    not FModuleTypeList.Contains(AModuleType) then
  begin
    FModuleTypeList.Add(AModuleType);
  end;
end;

procedure TcbsModuleTypeRepository.RegisterMain(const AMainModuleType: MainModuleType);
begin
  FMainModuleType := AMainModuleType;
end;

end.
