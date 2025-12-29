unit cbsSystem.Contracts.Wizard;

interface

uses
{IDE}
  ActnList,
  uniPanel,
{PROJECT}
  Spring.Collections;

type
  TChangeStepEvent = procedure(const ASender: TObject; const AOldIndex: Integer; const ANewIndex: Integer) of object;

  IWizard = interface(IUnknown)
    ['{F2FE4383-B715-420F-8A4B-F035B3651525}']
    function AddStep(const AStep: TUniContainerPanel): IWizard;
    procedure Back;
    function GetActiveStepIndex: Integer;
    function GetOnChangeStep: TChangeStepEvent;
    procedure Next;
    procedure SetActiveStepIndex(const AValue: Integer);
    function SetBackAction(const Action: TAction): IWizard;
    function SetFinishAction(const Action: TAction): IWizard;
    function SetNextAction(const Action: TAction): IWizard;
    procedure SetOnChangeStep(const AValue: TChangeStepEvent);
    property ActiveStepIndex: Integer read GetActiveStepIndex write SetActiveStepIndex;
    property OnChangeStep: TChangeStepEvent read GetOnChangeStep write SetOnChangeStep;
  end;

  IStepList = IList<TUniContainerPanel>;

  function CreateStepList: IStepList;

implementation

function CreateStepList: IStepList;
begin
  Result := TCollections.CreateList<TUniContainerPanel>;
end;

end.
