unit cbsSystem.Form.BaseForm;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Form.BaseForm,
  cbsSystem.Contracts.Module.BaseModule,
  cbsSystem.MessageBox,
{IDE}
  Data.DB, Dialogs, uniEdit, uniDBEdit, uniDBComboBox, uniDateTimePicker, uniDBLookupComboBox, uniGUIForm, uniGUIClasses, uniGUIBaseClasses, uniImageList, System.ImageList,
  Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu;

type
  TRequiredFieldMode = (
    rfmAutomatic,
    rfmManual,
    rfmHybrid
  );

  FormType = class of TUniForm;

  IDataModule = cbsSystem.Contracts.Module.BaseModule.IDataModule;

  TfrmBase = class(TUniForm, IForm)
    aclMain: TUniActionList;
    ilaMain: TUniImageListAdapter;
    nilstMain: TUniNativeImageList;
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
  private
    FDataModule: IDataModule;
    FRequiredFieldList: IRequiredFieldList;
    FRequiredFieldMode: TRequiredFieldMode;
    function BuildRequiredMessage(const AControl: TUniFormControl; const AField: TField): string;
    function CanValidateControl(const AControl: TUniFormControl; const AField: TField): Boolean;
    procedure ClearInvalid(const AControl: TUniControl);
    function IsAlreadyRegistered(const AControl: TUniFormControl): Boolean;
    procedure MarkInvalid(const AControl: TUniControl; const AMessage: string);
    procedure RegisterRequiredFieldsFromDataModule;
  protected
    procedure ClearInvalids;
    function GetDataModule: IDataModule; virtual;
    procedure MessageBox(const ATitle, AMessage, ADetails: string; const AIcon: TMsgDlgType; const AButtons: TMsgDlgButtons; const ACallback: TMessageCallback = nil;
      const AWidth: Integer = 400; const AHeight: Integer = 160);
    procedure RegisterRequiredField(const AControl: TUniFormControl); overload;
    procedure RegisterRequiredField(const AControl: TUniFormControl; const AMessage: string); overload;
    procedure RegisterRequiredField(const AControl: TUniFormControl; const AMessage: string; const AArgs: array of const); overload;
    procedure SetRequiredFieldMode(const AValue: TRequiredFieldMode);
    function ValidateRequiredFields: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DataChange(Sender: TObject; Field: TField); virtual;
    procedure StateChange(Sender: TObject); virtual;
  end;

implementation

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
  System.Variants;

type
  THackUniDateTimePicker = class(TUniCustomDateTimePicker);
  THackUniCustomDBLookupComboBox = class(TUniCustomDBLookupComboBox);
  THackUniCustomDBComboBox = class(TUniCustomDBComboBox);
  THackUniFormControl = class(TUniFormControl);

resourcestring
  SRequiredField = 'O campo %s é de preenchimento obrigatório.';

{ TfrmBase }

constructor TfrmBase.Create(AOwner: TComponent);
begin
  inherited;
  FRequiredFieldList := CreateRequiredFieldList;
  SetRequiredFieldMode(rfmAutomatic);
end;

destructor TfrmBase.Destroy;
begin
  FRequiredFieldList := nil;
  inherited;
end;

function TfrmBase.BuildRequiredMessage(const AControl: TUniFormControl; const AField: TField): string;
var
  LLabel: string;
begin
  if Assigned(AField) and not AField.DisplayLabel.IsEmpty then
    LLabel := AField.DisplayLabel
  else
    LLabel := THackUniFormControl(AControl).FieldLabel;
  Result := Format(SRequiredField, [LLabel]);
end;

function TfrmBase.CanValidateControl(const AControl: TUniFormControl; const AField: TField): Boolean;
begin
  Result := True;
  if not AControl.Visible then
    Exit(False);
  if AControl.ReadOnly then
    Exit(False);
  if Assigned(AField) then
  begin
    if AField.Calculated then
      Exit(False);
    if AField.FieldKind in [fkLookup, fkCalculated] then
      Exit(False);
  end;
end;

procedure TfrmBase.ClearInvalid(const AControl: TUniControl);
begin
  UniSession.AddJS(Format('%s.clearInvalid();', [AControl.JSName]));
end;

procedure TfrmBase.ClearInvalids;
begin
  for var LRequiredField in FRequiredFieldList do
  begin
    ClearInvalid(LRequiredField.Control);
  end;
  FRequiredFieldList.Clear;
end;

procedure TfrmBase.DataChange(Sender: TObject; Field: TField);
begin
  // This method can be overwritten by inherited classes.
end;

function TfrmBase.GetDataModule: IDataModule;
begin
  Result := nil;
end;

function TfrmBase.IsAlreadyRegistered(const AControl: TUniFormControl): Boolean;
begin
  Result := False;
  for var LItem in FRequiredFieldList do if
    LItem.Control = AControl then
  begin
    Exit(True);
  end;
end;

procedure TfrmBase.MarkInvalid(const AControl: TUniControl; const AMessage: string);
begin
  UniSession.AddJS(Format('%s.markInvalid(%s);', [AControl.JSName, QuotedStr(AMessage)]));
end;

procedure TfrmBase.MessageBox(const ATitle, AMessage, ADetails: string; const AIcon: TMsgDlgType; const AButtons: TMsgDlgButtons; const ACallback: TMessageCallback; const AWidth,
  AHeight: Integer);
begin
  ExecuteMessageBox(ATitle, AMessage, ADetails, AButtons, AIcon, ACallback, AWidth, AHeight);
end;

procedure TfrmBase.RegisterRequiredField(const AControl: TUniFormControl);
begin
  RegisterRequiredField(AControl, SRequiredField, [THackUniFormControl(AControl).FieldLabel]);
end;

procedure TfrmBase.RegisterRequiredField(const AControl: TUniFormControl; const AMessage: string);
var
  LRequiredField: TRequiredField;
begin
  LRequiredField.Control := AControl;
  LRequiredField.Message := AMessage;
  FRequiredFieldList.Add(LRequiredField);
end;

procedure TfrmBase.RegisterRequiredField(const AControl: TUniFormControl; const AMessage: string; const AArgs: array of const);
begin
  RegisterRequiredField(AControl, Format(AMessage, AArgs));
end;

procedure TfrmBase.RegisterRequiredFieldsFromDataModule;
var
  I: Integer;
  C: TComponent;
  LDataSource: TDataSource;
  LDataField: string;
  LField: TField;
  LControl: TUniFormControl;
begin
  if not Assigned(FDataModule) then
    Exit;

  for I := 0 to ComponentCount - 1 do
  begin
    C := Components[I];

    if not (C is TUniFormControl) then
      Continue;

    LControl := TUniFormControl(C);

    // Override manual
    if LControl.Tag < 0 then
      Continue;

    LDataField  := '';

    if C is TUniDBEdit then
    begin
      LDataSource := TUniDBEdit(C).DataSource;
      LDataField  := TUniDBEdit(C).DataField;
    end
    else if C is TUniCustomDBLookupComboBox then
    begin
      LDataSource := THackUniCustomDBLookupComboBox(C).DataSource;
      LDataField  := THackUniCustomDBLookupComboBox(C).DataField;
    end
    else if C is TUniCustomDBComboBox then
    begin
      LDataSource := THackUniCustomDBComboBox(C).DataSource;
      LDataField  := THackUniCustomDBComboBox(C).DataField;
    end
    else
      Continue;

    if not Assigned(LDataSource) or not Assigned(LDataSource.DataSet) or LDataField.IsEmpty then
      Continue;

    LField := LDataSource.DataSet.FindField(LDataField);
    if not Assigned(LField) then
      Continue;

    // Decide se é obrigatório
    if not (LField.Required or (LControl.Tag > 0)) then
      Continue;

    if not CanValidateControl(LControl, LField) then
      Continue;

    if IsAlreadyRegistered(LControl) then
      Continue;

    RegisterRequiredField(
      LControl,
      BuildRequiredMessage(LControl, LField)
    );
  end;
end;

procedure TfrmBase.SetRequiredFieldMode(const AValue: TRequiredFieldMode);
begin
  FRequiredFieldMode := AValue;
end;

procedure TfrmBase.StateChange(Sender: TObject);
begin
  // This method can be overwritten by inherited classes.
end;

procedure TfrmBase.UniFormCreate(Sender: TObject);
begin
  FDataModule := GetDataModule;
  if Assigned(FDataModule) then
  begin
    FDataModule.AddFormListener(Self);
    case FRequiredFieldMode of
      rfmAutomatic, rfmHybrid:
        RegisterRequiredFieldsFromDataModule;
    end;
  end;
end;

procedure TfrmBase.UniFormDestroy(Sender: TObject);
begin
  if Assigned(FDataModule) then
  begin
    FDataModule.RemoveFormListener(Self);
  end;
end;

function TfrmBase.ValidateRequiredFields: Boolean;
begin
  Result := True;
  for var LRequiredField in FRequiredFieldList do
  begin
    var LControl := LRequiredField.Control;
    var LMessage := LRequiredField.Message;
    ClearInvalid(LControl);
    if LControl is TUniCustomEdit then
    begin
      var LValue := Trim(TUniCustomEdit(LControl).Text);
      if LValue.IsEmpty then
      begin
        MarkInvalid(LControl, LMessage);
        Result := False;
      end;
    end
    else if LControl is TUniCustomDateTimePicker then
    begin
      var LValue := THackUniDateTimePicker(LControl).DateTime;
      if LValue = 0 then
      begin
        MarkInvalid(LControl, LMessage);
        Result := False;
      end;
    end
    else if LControl is TUniCustomDBLookupComboBox then
    begin
      var LValue := TUniCustomDBLookupComboBox(LControl).KeyValue;
      if VarIsEmpty(LValue) or VarIsNull(LValue) then
      begin
        MarkInvalid(LControl, LMessage);
        Result := False;
      end;
    end;
  end;
end;

end.
