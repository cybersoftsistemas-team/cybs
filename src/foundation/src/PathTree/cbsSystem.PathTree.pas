unit cbsSystem.PathTree;

interface

uses
{IDE}
  System.Rtti,
{PROJECT}
  cbsSystem.Contracts.PathTree;

type
  TPathTree = class(TInterfacedObject, IPathTree)
  private
    FMembers: IMemberList;
    function InternalGet(const AMembers: IMemberList; const APath: string; const ADefaultValue: TValue): TValue;
    procedure DisposeObjects;
    procedure InternalSet(const AMembers: IMemberList; const APath: string; const AValue: TValue);
  protected
    function Get(const APath: string; const ADefaultValue: TValue): TValue; overload;
    procedure &Set(const APath: string; const AValue: TValue); overload;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
{PROJECT}
  cbsSystem.PathTreeParser;

{ TPathTree }

constructor TPathTree.Create;
begin
  inherited Create;
  FMembers := CreateMemberList;
end;

destructor TPathTree.Destroy;
begin
  DisposeObjects;
  FMembers := nil;
  inherited;
end;

function TPathTree.Get(const APath: string; const ADefaultValue: TValue): TValue;
begin
  Result := InternalGet(FMembers, APath, ADefaultValue);
end;

function TPathTree.InternalGet(const AMembers: IMemberList; const APath: string; const ADefaultValue: TValue): TValue;
begin
  var LParser := TPathParser.Create(APath, AMembers, [TPathTokenOption.Read]);
  while not LParser.IsEof do
  begin
    if LParser.Token = TPathToken.&End then
    begin
      if LParser.Contains(LParser.Name) then
      begin
        Exit(LParser[LParser.Name]);
      end;
      Break;
    end;
    LParser.Next;
  end;
  Result := ADefaultValue;
end;

procedure TPathTree.DisposeObjects;
begin
  for var LItem in FMembers do
  begin
    TPathParser.DisposeObjects(FMembers, LItem.Key);
  end;
  FMembers.Clear;
end;

procedure TPathTree.InternalSet(const AMembers: IMemberList; const APath: string; const AValue: TValue);
begin
  var LParser := TPathParser.Create(APath, AMembers, [TPathTokenOption.Read, TPathTokenOption.Write]);
  while not LParser.IsEof do
  begin
    if LParser.Token = TPathToken.&End then
    begin
      LParser[LParser.Name] := AValue;
    end;
    LParser.Next;
  end;
end;

procedure TPathTree.&Set(const APath: string; const AValue: TValue);
begin
  InternalSet(FMembers, APath, AValue);
end;

end.
