unit cbsServer.Module.Registered;

interface

uses
{PROJECT}
  cbsServer.Contracts.Module.Registered,
  cbsServer.Module.BaseModule;

type
  TcbsModuleRegistered = class(TInterfacedObject, IcbsModuleRegistered)
  strict private
    FModuleClassList: IModuleClassList;
  public
    constructor Create;
    destructor Destroy; override;
    function ToArray: TArray<TcbsModuleClass>;
    procedure Add(const AModuleClass: TcbsModuleClass);
  end;

implementation

{ TcbsModuleRegistered }

constructor TcbsModuleRegistered.Create;
begin
  inherited Create;
  FModuleClassList := CreateModuleClassList;
end;

destructor TcbsModuleRegistered.Destroy;
begin
  FModuleClassList.Clear;
  FModuleClassList := nil;
  inherited;
end;

function TcbsModuleRegistered.ToArray: TArray<TcbsModuleClass>;
begin
  Result := FModuleClassList.ToArray;
end;

procedure TcbsModuleRegistered.Add(const AModuleClass: TcbsModuleClass);
begin
  if not FModuleClassList.Contains(AModuleClass) then
  begin
    FModuleClassList.Add(AModuleClass);
  end;
end;

end.
