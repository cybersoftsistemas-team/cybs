unit cbsSystem.Module.BaseModule;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Form.BaseForm,
  cbsSystem.Contracts.Module.BaseModule,
{IDE}
  Data.DB, System.Classes, System.SysUtils;

type
  TdamBase = class(TDataModule, IDataModule)
    procedure CpfOrCnpfGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure CpfOrCnpfSetText(Sender: TField; const Text: string);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataSetBeforePost(DataSet: TDataSet);
    procedure dsoDataChange(Sender: TObject; Field: TField);
    procedure dsoStateChange(Sender: TObject);
    procedure SetZeroToTheLeft(Sender: TField; var Text: string; DisplayText: Boolean);
  private
    FCpfOrCnpfDBFieldDisplayText: Boolean;
    FFormListenerList: IFormListenerList;
    procedure CheckRequiredFields(const ADataSet: TDataSet);
  protected
    procedure CloseDataSets; virtual;
    procedure DoDataChange(Sender: TObject; Field: TField); virtual;
    procedure DoStateChange(Sender: TObject); virtual;
    procedure OpenDataSets; virtual;
    procedure SetNewGuid(const AField: TGuidField);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddFormListener(const AForm: IForm);
    procedure RemoveFormListener(const AForm: IForm);
    property CpfOrCnpfDBFieldDisplayText: Boolean read FCpfOrCnpfDBFieldDisplayText write FCpfOrCnpfDBFieldDisplayText;
  end;

  ModuleType = class of TDataModule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{IDE}
  cbsSystem.Support.Utils;

{ TdamBase }

constructor TdamBase.Create(AOwner: TComponent);
begin
  inherited;
  FFormListenerList := CreateFormListenerList;
end;

destructor TdamBase.Destroy;
begin
  FFormListenerList := nil;
  inherited;
end;

procedure TdamBase.AddFormListener(const AForm: IForm);
begin
  FFormListenerList.Add(AForm);
end;

procedure TdamBase.CheckRequiredFields(const ADataSet: TDataSet);
begin
  for var I := 0 to ADataSet.Fields.Count - 1 do if
    ADataSet.Fields[I].Required and not ADataSet.Fields[I].ReadOnly and
    (ADataSet.Fields[I].FieldKind = fkData) and ADataSet.Fields[I].IsNull then
  begin
    ADataSet.Fields[I].FocusControl;
    DatabaseErrorFmt('O campo ''%s'' é de preenchimento obrigatório.', [ADataSet.Fields[I].DisplayName]);
  end;
end;

procedure TdamBase.CloseDataSets;
begin
  // This method can be overwritten by inherited classes.
end;

procedure TdamBase.CpfOrCnpfGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not FCpfOrCnpfDBFieldDisplayText then
  begin
    Text := Sender.AsString;
  end
  else
    Text := GetCpfOrCnpfMask(GetOnlyNumbers(Sender.AsString));
end;

procedure TdamBase.CpfOrCnpfSetText(Sender: TField; const Text: string);
begin
  Sender.AsString := GetOnlyNumbers(Text);
end;

procedure TdamBase.DataModuleCreate(Sender: TObject);
begin
  CloseDataSets;
  OpenDataSets;
end;

procedure TdamBase.DataSetBeforePost(DataSet: TDataSet);
begin
  CheckRequiredFields(DataSet);
end;

procedure TdamBase.DoDataChange(Sender: TObject; Field: TField);
begin
  // This method can be overwritten by inherited classes.
end;

procedure TdamBase.DoStateChange(Sender: TObject);
begin
  // This method can be overwritten by inherited classes.
end;

procedure TdamBase.dsoDataChange(Sender: TObject; Field: TField);
begin
  for var LForm in FFormListenerList do
  begin
    LForm.DataChange(Sender, Field);
  end;
  DoDataChange(Sender, Field);
end;

procedure TdamBase.dsoStateChange(Sender: TObject);
begin
  for var LForm in FFormListenerList do
  begin
    LForm.StateChange(Sender);
  end;
  DoStateChange(Sender);
end;

procedure TdamBase.OpenDataSets;
begin
  // This method can be overwritten by inherited classes.
end;

procedure TdamBase.RemoveFormListener(const AForm: IForm);
begin
  FFormListenerList.Remove(AForm);
end;

procedure TdamBase.SetNewGuid(const AField: TGuidField);
begin
  if Assigned(AField.DataSet) and (AField.DataSet.State in dsEditModes) then
  begin
    AField.AsGuid := TGuid.NewGuid;
  end;
end;

procedure TdamBase.SetZeroToTheLeft(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsInteger > 0 then
  begin
    Text := Format('%3.3d',[Sender.AsInteger]);
  end;
end;

end.
