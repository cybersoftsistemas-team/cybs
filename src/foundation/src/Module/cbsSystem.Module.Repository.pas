unit cbsSystem.Module.Repository;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module.Repository;

type
  TcbsModuleTypeRepository = class(TInterfacedObject, IModuleTypeRepository)
  private
    FMainModule: ModuleType;
    FModuleTypeList: IModuleTypeList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetModuleTypes: IModuleTypes;
    procedure Register(const AModuleType: ModuleType);
    procedure RegisterMain(const AModuleType: ModuleType);
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

procedure TcbsModuleTypeRepository.RegisterMain(const AModuleType: ModuleType);
begin
  FMainModule := AModuleType;
end;

end.
