unit cbsServer.Registered.Modules;

interface

uses
{PROJECT}
  cbsServer.Contracts.Registered.Modules,
  cbsServer.Cybersoft.BaseModule;

type
  TcbsRegisteredModules = class(TInterfacedObject, IcbsRegisteredModules)
  strict private
    FModuleClassList: IModuleClassList;
  public
    constructor Create;
    destructor Destroy; override;
    function ToArray: TArray<TcbsModuleClass>;
    procedure Add(const AModuleClass: TcbsModuleClass);
  end;

implementation

{ TcbsRegisteredModules }

constructor TcbsRegisteredModules.Create;
begin
  inherited Create;
  FModuleClassList := CreateModuleClassList;
end;

destructor TcbsRegisteredModules.Destroy;
begin
  FModuleClassList.Clear;
  FModuleClassList := nil;
  inherited;
end;

function TcbsRegisteredModules.ToArray: TArray<TcbsModuleClass>;
begin
  Result := FModuleClassList.ToArray;
end;

procedure TcbsRegisteredModules.Add(const AModuleClass: TcbsModuleClass);
begin
  if not FModuleClassList.Contains(AModuleClass) then
  begin
    FModuleClassList.Add(AModuleClass);
  end;
end;

end.
