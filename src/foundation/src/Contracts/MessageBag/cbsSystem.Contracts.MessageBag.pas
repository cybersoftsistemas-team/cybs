unit cbsSystem.Contracts.MessageBag;

interface

uses
{PROJECT}
  cbsSystem.Contracts.MessageBag.MessageBagItems,
{SPRING}
  Spring.Collections;

type
  TParams = cbsSystem.Contracts.MessageBag.MessageBagItems.TParams;

  TMessageBagValue = TPair<string, IMessageBagItems>;
  IMessageBagEnumerator = IEnumerator<TMessageBagValue>;
  IMessageBags = TArray<TMessageBagValue>;

  IMessageBag = interface(IUnknown)
    ['{5A4FB0FF-B753-48F8-8ABD-CB5AB0786204}']
    function Add(const AKey, AMessage: string): IMessageBag; overload;
    function Add(const AKey, AMessage: string; const AParams: TParams): IMessageBag; overload;
    function GetEnumerator: IMessageBagEnumerator;
    function GetItem(const AKey: string): IMessageBagItems;
    function Has(const AKey: string): Boolean;
    function IsEmpty: Boolean;
    function Messages: string;
    procedure AddRange(const AValues: IMessageBag);
    procedure Clear;
    property Items[const AKey: string]: IMessageBagItems read GetItem; default;
  end;

  IMessageBagList = IDictionary<string, IMessageBagItems>;

  function CreateMessageBagList: IMessageBagList;

implementation

function CreateMessageBagList: IMessageBagList;
begin
  Result := TCollections.CreateDictionary<string, IMessageBagItems>;
end;

end.

