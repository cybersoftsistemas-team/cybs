unit cbsSystem.MessageBag;

interface

uses
{PROJECT}
  cbsSystem.Contracts.MessageBag,
  cbsSystem.Contracts.MessageBag.MessageBagItems;

type
  TMessageBag = class(TInterfacedObject, IMessageBag)
  private
    FMessageBagList: IMessageBagList;
    function GetItem(const AKey: string): IMessageBagItems;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(const AKey, AMessage: string): IMessageBag; overload;
    function Add(const AKey, AMessage: string; const AParams: TParams): IMessageBag; overload;
    function GetEnumerator: IMessageBagEnumerator;
    function Has(const AKey: string): Boolean;
    function IsEmpty: Boolean;
    function Messages: string;
    procedure AddRange(const AValues: IMessageBag);
    procedure Clear;
    property Items[const AKey: string]: IMessageBagItems read GetItem; default;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.MessageBag.MessageBagItems,
  cbsSystem.Support.ServerModule;

{ TMessageBag }

constructor TMessageBag.Create;
begin
  inherited Create;
  FMessageBagList := CreateMessageBagList;
end;

destructor TMessageBag.Destroy;
begin
  FMessageBagList.Clear;
  FMessageBagList := nil;
  inherited;
end;

function TMessageBag.Add(const AKey, AMessage: string): IMessageBag;
begin
  Result := Add(AKey, AMessage, []);
end;

function TMessageBag.Add(const AKey, AMessage: string; const AParams: TParams): IMessageBag;
begin
  var LHas := Has(AKey);
  var LItems: IMessageBagItems := nil;
  if LHas then
  begin
    LItems := FMessageBagList[AKey];
  end;
  if not Assigned(LItems) then
  begin
    LItems := TMessageBagItems.Create;
  end;
  LItems.Add(ServerModule.Trans(AMessage, AParams, AMessage));
  if not LHas then
  begin
    FMessageBagList[AKey] := LItems;
  end;
  Result := Self;
end;

function TMessageBag.GetEnumerator: IMessageBagEnumerator;
begin
  Result := FMessageBagList.GetEnumerator;
end;

function TMessageBag.GetItem(const AKey: string): IMessageBagItems;
begin
  if Has(AKey) then
  begin
    Exit(FMessageBagList[AKey]);
  end;
  Result := nil;
end;

function TMessageBag.Has(const AKey: string): Boolean;
begin
  Result := FMessageBagList.ContainsKey(AKey);
end;

function TMessageBag.IsEmpty: Boolean;
begin
  Result := FMessageBagList.IsEmpty;
end;

function TMessageBag.Messages: string;
begin
  Result := '';
  for var LMessageBag in FMessageBagList do
  begin
    Result := Concat(Result, LMessageBag.Value.Messages);
  end;
end;

procedure TMessageBag.AddRange(const AValues: IMessageBag);
begin
  for var LMessages in AValues do
  begin
    for var LItem in LMessages.Value do
    begin
      Add(LMessages.Key, LItem.Message);
    end;
  end;
end;

procedure TMessageBag.Clear;
begin
  for var LMessageBag in FMessageBagList do
  begin
    LMessageBag.Value.Clear;
  end;
end;

end.
