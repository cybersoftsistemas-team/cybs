unit cbsSystem.MessageBag.MessageBagItems;

interface

uses
{PROJECT}
  cbsSystem.Contracts.MessageBag.MessageBagItems;

type
  TMessageBagItems = class(TInterfacedObject, IMessageBagItems)
  private
    FMessageBagItemList: IMessageBagItemList;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(const AMessage: string): IMessageBagItems;
    function GetEnumerator: IMessageBagItemsEnumerator;
    function IsEmpty: Boolean;
    function Messages: string;
    procedure Clear;
  end;

implementation

uses
{PROJECT}
  cbsSystem.MessageBag.MessageBagItem;

{ TMessageBagItems }

constructor TMessageBagItems.Create;
begin
  inherited Create;
  FMessageBagItemList := CreateMessageBagItemList;
end;

destructor TMessageBagItems.Destroy;
begin
  FMessageBagItemList.Clear;
  FMessageBagItemList := nil;
  inherited;
end;

function TMessageBagItems.Add(const AMessage: string): IMessageBagItems;
begin
  FMessageBagItemList.Add(TMessageBagItem.Create(AMessage));
  Result := Self;
end;

function TMessageBagItems.GetEnumerator: IMessageBagItemsEnumerator;
begin
  Result := FMessageBagItemList.GetEnumerator;
end;

function TMessageBagItems.IsEmpty: Boolean;
begin
  Result := FMessageBagItemList.IsEmpty;
end;

function TMessageBagItems.Messages: string;
begin
  Result := '';
  for var LMessageBagItem in FMessageBagItemList do
  begin
    Result := Concat(Result, LMessageBagItem.Message, #13);
  end;
end;

procedure TMessageBagItems.Clear;
begin
  FMessageBagItemList.Clear;
end;

end.
