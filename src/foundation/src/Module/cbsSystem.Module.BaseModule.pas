unit cbsSystem.Module.BaseModule;

interface

uses
{IDE}
  Data.DB, System.Classes, System.SysUtils;

type
  TdamBase = class(TDataModule)
    procedure CpfOrCnpfGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure CpfOrCnpfSetText(Sender: TField; const Text: string);
    procedure DataSetBeforePost(DataSet: TDataSet);
    procedure dsoDataChange(Sender: TObject; Field: TField);
    procedure dsoStateChange(Sender: TObject);
    procedure SetZeroToTheLeft(Sender: TField; var Text: string; DisplayText: Boolean);
  private
    FCpfOrCnpfDBFieldDisplayText: Boolean;
    FOnStateChange: TNotifyEvent;
    FOnDataChange: TDataChangeEvent;
    procedure CheckRequiredFields(const ADataSet: TDataSet);
    procedure DoOnDataChange(Sender: TObject; Field: TField); virtual;
    procedure DoOnStateChange(Sender: TObject); virtual;
    procedure SetOnDataChange(const Value: TDataChangeEvent);
  protected
    procedure SetOnDataChangeEvent; virtual;
  public
    property CpfOrCnpfDBFieldDisplayText: Boolean read FCpfOrCnpfDBFieldDisplayText write FCpfOrCnpfDBFieldDisplayText;
    property OnDataChange: TDataChangeEvent read FOnDataChange write SetOnDataChange;
    property OnStateChange: TNotifyEvent read FOnStateChange write FOnStateChange;
  end;

  TdamBaseClass = class of TDataModule;

implementation

{$R *.dfm}

uses
{IDE}
  cbsSystem.Support.Utils;

{ TdamBase }

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

procedure TdamBase.DataSetBeforePost(DataSet: TDataSet);
begin
  CheckRequiredFields(DataSet);
end;

procedure TdamBase.DoOnDataChange(Sender: TObject; Field: TField);
begin
  // This method can be overwritten by inherited classes.
end;

procedure TdamBase.DoOnStateChange(Sender: TObject);
begin
  // This method can be overwritten by inherited classes.
end;

procedure TdamBase.dsoDataChange(Sender: TObject; Field: TField);
begin
  if Assigned(FOnDataChange) then
  begin
    DoOnDataChange(Sender, Field);
    FOnDataChange(Sender, Field);
  end;
end;

procedure TdamBase.dsoStateChange(Sender: TObject);
begin
  if Assigned(FOnStateChange) then
  begin
    DoOnStateChange(Sender);
    FOnStateChange(Sender);
  end;
end;

procedure TdamBase.SetOnDataChange(const Value: TDataChangeEvent);
begin
  FOnDataChange := Value;
  SetOnDataChangeEvent;
end;

procedure TdamBase.SetOnDataChangeEvent;
begin
  // This method can be overwritten by inherited classes.
end;

procedure TdamBase.SetZeroToTheLeft(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsInteger > 0 then
  begin
    Text := Format('%3.3d',[Sender.AsInteger]);
  end;
end;

end.
