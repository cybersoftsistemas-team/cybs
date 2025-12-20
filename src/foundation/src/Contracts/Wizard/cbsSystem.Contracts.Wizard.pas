unit cbsSystem.Contracts.Wizard;

interface

uses
{IDE}
  ActnList,
  uniPanel,
{PROJECT}
  Spring.Collections;

type
  IWizard = interface(IUnknown)
    ['{F2FE4383-B715-420F-8A4B-F035B3651525}']
    function AddStep(const AStep: TUniContainerPanel): IWizard;
    function GetActiveStepIndex: Integer;
    function SetBackAction(const Action: TAction): IWizard;
    function SetFinishAction(const Action: TAction): IWizard;
    function SetNextAction(const Action: TAction): IWizard;
    procedure Back;
    procedure Next;
    procedure SetActiveStepIndex(const AValue: Integer);
    property ActiveStepIndex: Integer read GetActiveStepIndex write SetActiveStepIndex;
  end;

  IStepList = IList<TUniContainerPanel>;

  function CreateStepList: IStepList;

implementation

function CreateStepList: IStepList;
begin
  Result := TCollections.CreateList<TUniContainerPanel>;
end;

end.
