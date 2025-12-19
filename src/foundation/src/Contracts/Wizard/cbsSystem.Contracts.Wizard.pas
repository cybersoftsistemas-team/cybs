unit cbsSystem.Contracts.Wizard;

interface

uses
{IDE}
  uniPanel,
  uniBitBtn;

type
  IWizard = interface(IUnknown)
    ['{F2FE4383-B715-420F-8A4B-F035B3651525}']
    function AddStep(const AStep: TUniContainerPanel): IWizard;
    function GetActiveStepIndex: Integer;
    function SetBackButton(const AButton: TUniBitBtn): IWizard;
    function SetFinishButton(const AButton: TUniBitBtn): IWizard;
    function SetNextButton(const AButton: TUniBitBtn): IWizard;
    procedure SetActiveStepIndex(const AValue: Integer);
    property ActiveStepIndex: Integer read GetActiveStepIndex write SetActiveStepIndex;
  end;

implementation

end.
