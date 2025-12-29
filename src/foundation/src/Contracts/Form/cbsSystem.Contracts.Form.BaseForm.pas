unit cbsSystem.Contracts.Form.BaseForm;

interface

uses
{IDE}
  Data.DB,
  uniGUIClasses,
{SPRING}
  Spring.Collections;

type
  TRequiredField = record
  strict private
    FControl: TUniControl;
    FMessage: string;
  public
    property Control: TUniControl read FControl write FControl;
    property Message: string read FMessage write FMessage;
  end;

  IForm = interface(IUnknown)
    ['{0C6BE7C9-7961-48FB-B914-12C0990F01FE}']
    procedure DataChange(Sender: TObject; Field: TField);
    procedure StateChange(Sender: TObject);
  end;

  IRequiredFieldList = IList<TRequiredField>;

  function CreateRequiredFieldList: IRequiredFieldList;

implementation

function CreateRequiredFieldList: IRequiredFieldList;
begin
  Result := TCollections.CreateList<TRequiredField>;
end;

end.
