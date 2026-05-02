unit cbsSystem.MessageBag.MessageBagItem;

interface

uses
{PROJECT}
  cbsSystem.Contracts.MessageBag.MessageBagItem;

type
  TMessageBagItem = class(TInterfacedObject, IMessageBagItem)
  private
    FMessage: string;
    function GetMessage: string;
  public
    constructor Create(const AMessage: string);
    property Message: string read GetMessage;
  end;

implementation

{ TMessageBagItem }

constructor TMessageBagItem.Create(const AMessage: string);
begin
  inherited Create;
  FMessage := AMessage;
end;

function TMessageBagItem.GetMessage: string;
begin
  Result := FMessage;
end;

end.

