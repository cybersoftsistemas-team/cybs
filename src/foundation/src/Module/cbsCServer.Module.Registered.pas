unit cbsCServer.Module.Registered;

interface

uses
{PROJECT}
  cbsCServer.Contracts.Module.Registered,
  cbsCServer.Module.BaseModule;

type
  TcbsModuleRegistered = class(TInterfacedObject, IcbsModuleRegistered)
  strict private
    FModuleClassList: IModuleClassList;
  public
    constructor Create;
    destructor Destroy; override;
    function ToArray: TArray<TdamBaseClass>;
    procedure Add(const AModuleClass: TdamBaseClass);
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

function TcbsModuleRegistered.ToArray: TArray<TdamBaseClass>;
begin
  Result := FModuleClassList.ToArray;
end;

procedure TcbsModuleRegistered.Add(const AModuleClass: TdamBaseClass);
begin
  if not FModuleClassList.Contains(AModuleClass) then
  begin
    FModuleClassList.Add(AModuleClass);
  end;
end;

end.
