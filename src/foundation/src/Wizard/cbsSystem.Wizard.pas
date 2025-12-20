unit cbsSystem.Wizard;

interface

uses
{IDE}
  ActnList,
  uniPanel,
{PROJECT}
  cbsSystem.Contracts.Wizard;

type
  TcbsWizard = class(TInterfacedObject, IWizard)
  private
    FActiveStepIndex: Integer;
    FBackAction: TAction;
    FFinishAction: TAction;
    FNextAction: TAction;
    FStepList: IStepList;
    function GetActiveStepIndex: Integer;
    procedure SetActiveStepIndex(const AValue: Integer);
    procedure UpdateUI;
  public
    constructor Create;
    destructor Destroy; override;
    function AddStep(const AStep: TUniContainerPanel): IWizard;
    procedure Back;
    procedure Next;
    function SetBackAction(const AAction: TAction): IWizard;
    function SetFinishAction(const AAction: TAction): IWizard;
    function SetNextAction(const AAction: TAction): IWizard;
    property ActiveStepIndex: Integer read GetActiveStepIndex write SetActiveStepIndex default 0;
  end;

implementation

{ TcbsWizard }

constructor TcbsWizard.Create;
begin
  inherited Create;
  FStepList := CreateStepList;
  FActiveStepIndex := 0;
end;

destructor TcbsWizard.Destroy;
begin
  FStepList := nil;
  inherited;
end;

function TcbsWizard.AddStep(const AStep: TUniContainerPanel): IWizard;
begin
  if Assigned(AStep) and not FStepList.Contains(AStep) then
  begin
    FStepList.Add(AStep);
    AStep.Visible := False;
  end;
  UpdateUI;
  Result := Self;
end;

procedure TcbsWizard.Back;
begin
  SetActiveStepIndex(FActiveStepIndex - 1);
end;

function TcbsWizard.GetActiveStepIndex: Integer;
begin
  Result := FActiveStepIndex;
end;

procedure TcbsWizard.Next;
begin
  SetActiveStepIndex(FActiveStepIndex + 1);
end;

procedure TcbsWizard.SetActiveStepIndex(const AValue: Integer);
begin
  if (AValue < 0) or (AValue >= FStepList.Count) then
  begin
    Exit;
  end;
  if AValue = FActiveStepIndex then
  begin
    Exit;
  end;
  FActiveStepIndex := AValue;
  UpdateUI;
end;

function TcbsWizard.SetBackAction(const AAction: TAction): IWizard;
begin
  if Assigned(AAction) then
  begin
    FBackAction := AAction;
    AAction.Enabled := False;
  end;
  SetActiveStepIndex(FActiveStepIndex);
  Result := Self;
end;

function TcbsWizard.SetFinishAction(const AAction: TAction): IWizard;
begin
  if Assigned(AAction) then
  begin
    FFinishAction := AAction;
    AAction.Enabled := False;
  end;
  UpdateUI;
  Result := Self;
end;

function TcbsWizard.SetNextAction(const AAction: TAction): IWizard;
begin
  if Assigned(AAction) then
  begin
    FNextAction := AAction;
    AAction.Enabled := False;
  end;
  UpdateUI;
  Result := Self;
end;

procedure TcbsWizard.UpdateUI;
begin
  for var I := 0 to FStepList.Count - 1 do
  begin
    FStepList[I].Visible := I = FActiveStepIndex;
  end;
  if Assigned(FBackAction) then
  begin
    FBackAction.Enabled := FActiveStepIndex > 0;
  end;
  if Assigned(FNextAction) then
  begin
    FNextAction.Enabled := (FActiveStepIndex < FStepList.Count - 1);
  end;
  if Assigned(FFinishAction) then
  begin
    FFinishAction.Enabled := FActiveStepIndex = FStepList.Count - 1;
  end;
end;

end.
