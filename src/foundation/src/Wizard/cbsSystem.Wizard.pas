unit cbsSystem.Wizard;

interface

uses
{IDE}
  uniBitBtn,
  uniPanel,
{PROJECT}
  cbsSystem.Contracts.Wizard;

type
  TcbsWizard = class(TInterfacedObject, IWizard)
  private
    FActiveStepIndex: Integer;
    FBackButton: TUniBitBtn;
    FFinishButton: TUniBitBtn;
    FNextButton: TUniBitBtn;
    function GetActiveStepIndex: Integer;
    procedure SetActiveStepIndex(const AValue: Integer);
  public
    constructor Create;
    function AddStep(const AStep: TUniContainerPanel): IWizard;
    function SetBackButton(const AButton: TUniBitBtn): IWizard;
    function SetFinishButton(const AButton: TUniBitBtn): IWizard;
    function SetNextButton(const AButton: TUniBitBtn): IWizard;
    property ActiveStepIndex: Integer read GetActiveStepIndex write SetActiveStepIndex default 0;
  end;

implementation

{ TcbsWizard }

constructor TcbsWizard.Create;
begin
  inherited Create;
  FActiveStepIndex := 0;
end;

function TcbsWizard.AddStep(const AStep: TUniContainerPanel): IWizard;
begin
  Result := Self;
end;

function TcbsWizard.GetActiveStepIndex: Integer;
begin
  Result := FActiveStepIndex;
end;

function TcbsWizard.SetBackButton(const AButton: TUniBitBtn): IWizard;
begin
  FBackButton := AButton;
  Result := Self;
end;

function TcbsWizard.SetFinishButton(const AButton: TUniBitBtn): IWizard;
begin
  FFinishButton := AButton;
  Result := Self;
end;

function TcbsWizard.SetNextButton(const AButton: TUniBitBtn): IWizard;
begin
  FNextButton := AButton;
  Result := Self;
end;

procedure TcbsWizard.SetActiveStepIndex(const AValue: Integer);
begin
  FActiveStepIndex := AValue;
end;

end.
