unit cbsSystem.Container.RegisterContainer;

interface

uses
{IDE}
  System.TypInfo,
{PROJECT}
  cbsSystem.Contracts.Container.RegisterContainer;

type
  TRegisterContainer = class(TInterfacedObject, IRegisterContainer)
  private
    FContainerList: IContainerList;
    procedure Bind(const abstract: PTypeInfo; const AConcrete: PTypeInfo; const AShared: Boolean); overload;
  public
    constructor Create;
    destructor Destroy; override;
    function Bound(const abstract: TGuid): Boolean; overload;
    function Bound(const AConcrete: TClass): Boolean; overload;
    function GetEnumerator: IContainerEnumerator;
    procedure Bind(const abstract: TGuid; const AConcrete: TClass; const AShared: Boolean = False); overload;
    procedure Bind(const AConcrete: TClass; const AShared: Boolean = False); overload;
    procedure BindIf(const abstract: TGuid; const AConcrete: TClass; const AShared: Boolean); overload;
    procedure BindIf(const AConcrete: TClass; const AShared: Boolean = False); overload;
    procedure Singleton(const abstract: TGuid; const AConcrete: TClass); overload;
    procedure Singleton(const AConcrete: TClass); overload;
    procedure SingletonIf(const abstract: TGuid; const AConcrete: TClass); overload;
    procedure SingletonIf(const AConcrete: TClass); overload;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Support.Utils;

{ TRegisterContainer }

constructor TRegisterContainer.Create;
begin
  inherited Create;
  FContainerList := CreateContainerList;
end;

destructor TRegisterContainer.Destroy;
begin
  FContainerList.Clear;
  FContainerList := nil;
  inherited;
end;

function TRegisterContainer.Bound(const abstract: TGuid): Boolean;
begin
  Result := FContainerList.ContainsKey(GetTypInfo(abstract));
end;

function TRegisterContainer.Bound(const AConcrete: TClass): Boolean;
begin
  Result := FContainerList.ContainsKey(AConcrete.ClassInfo);
end;

function TRegisterContainer.GetEnumerator: IContainerEnumerator;
begin
  Result := FContainerList.GetEnumerator;
end;

procedure TRegisterContainer.Bind(const abstract, AConcrete: PTypeInfo; const AShared: Boolean);
begin
  if Assigned(abstract) then
  begin
    FContainerList[abstract] := TConcrete.Create(AConcrete, AShared);
    Exit;
  end;
  FContainerList[AConcrete] := TConcrete.Create(nil, AShared);
end;

procedure TRegisterContainer.Bind(const abstract: TGuid; const AConcrete: TClass; const AShared: Boolean);
begin
  if Supports(AConcrete, abstract) then
  begin
    Bind(GetTypInfo(abstract), AConcrete.ClassInfo, AShared);
  end;
end;

procedure TRegisterContainer.Bind(const AConcrete: TClass; const AShared: Boolean);
begin
  Bind(nil, AConcrete.ClassInfo, AShared);
end;

procedure TRegisterContainer.BindIf(const abstract: TGuid; const AConcrete: TClass; const AShared: Boolean);
begin
  if not Bound(abstract) then
  begin
    Bind(abstract, AConcrete, AShared);
  end;
end;

procedure TRegisterContainer.BindIf(const AConcrete: TClass; const AShared: Boolean);
begin
  if not Bound(AConcrete) then
  begin
    Bind(AConcrete, AShared);
  end;
end;

procedure TRegisterContainer.Singleton(const abstract: TGuid; const AConcrete: TClass);
begin
  Bind(abstract, AConcrete, True);
end;

procedure TRegisterContainer.Singleton(const AConcrete: TClass);
begin
  Bind(AConcrete, True);
end;

procedure TRegisterContainer.SingletonIf(const abstract: TGuid; const AConcrete: TClass);
begin
  if not Bound(abstract) then
  begin
    Singleton(abstract, AConcrete);
  end;
end;

procedure TRegisterContainer.SingletonIf(const AConcrete: TClass);
begin
  if not Bound(AConcrete) then
  begin
    Singleton(AConcrete);
  end;
end;

end.
