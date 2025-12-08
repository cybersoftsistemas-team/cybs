unit cbsSystem.Module.Repository;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module.Repository;

type
  TcbsModuleTypeRepository = class(TInterfacedObject, IModuleTypeRepository)
  private
    FModuleTypeList: IModuleTypeList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetModuleTypes: IModuleTypes;
    procedure Register(const AModuleType: ModuleType);
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
  if not FModuleTypeList.Contains(AModuleType) then
  begin
    FModuleTypeList.Add(AModuleType);
  end;
end;

end.
