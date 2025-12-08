unit cbsSystem.Contracts.Form.BaseForm;

interface

uses
{IDE}
  Data.DB;

type
  IForm = interface(IUnknown)
    ['{0C6BE7C9-7961-48FB-B914-12C0990F01FE}']
    procedure DataChange(Sender: TObject; Field: TField);
    procedure StateChange(Sender: TObject);
  end;

implementation

end.
