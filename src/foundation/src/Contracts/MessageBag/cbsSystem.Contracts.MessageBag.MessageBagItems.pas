unit cbsSystem.Contracts.MessageBag.MessageBagItems;

interface

uses
{PROJECT}
  cbsSystem.Contracts.MessageBag.MessageBagItem,
  cbsSystem.Support.Types,
{SPRING}
  Spring.Collections;

type
  TParams = TForReplacements;

  IMessageBagItemsEnumerator = IEnumerator<IMessageBagItem>;

  IMessageBagItems = interface(IUnknown)
    ['{8561FD0A-E046-4D48-B4A5-04D6BC735838}']
    function Add(const AMessage: string): IMessageBagItems;
    function GetEnumerator: IMessageBagItemsEnumerator;
    function IsEmpty: Boolean;
    function Messages: string;
    procedure Clear;
  end;

  IMessageBagItemList = IList<IMessageBagItem>;

  function CreateMessageBagItemList: IMessageBagItemList;

implementation

function CreateMessageBagItemList: IMessageBagItemList;
begin
  Result := TCollections.CreateInterfaceList<IMessageBagItem>;
end;

end.

