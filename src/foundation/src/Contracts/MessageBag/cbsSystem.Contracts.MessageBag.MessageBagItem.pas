unit cbsSystem.Contracts.MessageBag.MessageBagItem;

interface

type
  IMessageBagItem = interface(IUnknown)
    ['{045F2AD5-D4F5-4BC7-A880-68236F8BCCE2}']
    function GetMessage: string;
    property Message: string read GetMessage;
  end;

implementation

end.
