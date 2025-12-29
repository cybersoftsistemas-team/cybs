unit cbsSystem.Form.BaseForm;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Form.BaseForm,
  cbsSystem.Contracts.Module.BaseModule,
  cbsSystem.MessageBox,
{IDE}
  Data.DB, Dialogs, uniEdit, uniDateTimePicker, uniDBLookupComboBox, uniGUIForm, uniGUIClasses, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes,
  System.Actions, Vcl.ActnList, uniMainMenu;

type
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
    procedure ClearInvalid(const AControl: TUniControl);
    procedure MarkInvalid(const AControl: TUniControl; const AMessage: string);
  protected
    procedure ClearInvalids;
    function GetDataModule: IDataModule; virtual;
    procedure MessageBox(const ATitle, AMessage, ADetails: string; const AIcon: TMsgDlgType; const AButtons: TMsgDlgButtons; const ACallback: TMessageCallback = nil;
      const AWidth: Integer = 400; const AHeight: Integer = 160);
    procedure RegisterRequiredField(const AControl: TUniFormControl); overload;
    procedure RegisterRequiredField(const AControl: TUniFormControl; const AMessage: string); overload;
    procedure RegisterRequiredField(const AControl: TUniFormControl; const AMessage: string; const AArgs: array of const); overload;
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
  THackUniFormControl = class(TUniFormControl);
  THackUniDateTimePicker = class(TUniCustomDateTimePicker);

{ TfrmBase }

constructor TfrmBase.Create(AOwner: TComponent);
begin
  inherited;
  FRequiredFieldList := CreateRequiredFieldList;
end;

destructor TfrmBase.Destroy;
begin
  FRequiredFieldList := nil;
  inherited;
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

procedure TfrmBase.MarkInvalid(const AControl: TUniControl; const AMessage: string);
begin
  UniSession.AddJS(Format('%s.markInvalid(%s);', [AControl.JSName, QuotedStr(AMessage)]));
end;

procedure TfrmBase.MessageBox(const ATitle, AMessage, ADetails: string; const AIcon: TMsgDlgType; const AButtons: TMsgDlgButtons; const ACallback: TMessageCallback; const AWidth,
  AHeight: Integer);
begin
  ExecuteMessageBox(ATitle, AMessage, ADetails, AButtons, AIcon, ACallback, AWidth, AHeight);
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

procedure TfrmBase.RegisterRequiredField(const AControl: TUniFormControl);
begin
  RegisterRequiredField(AControl, 'O campo %s é de preenchimento obrigatório.', [THackUniFormControl(AControl).FieldLabel]);
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
    ClearInvalid(LRequiredField.Control);
    var LControl := LRequiredField.Control;
    if LControl is TUniCustomEdit then
    begin
      var LValue := Trim(TUniCustomEdit(LControl).Text);
      if LValue.IsEmpty then
      begin
        MarkInvalid(LControl, LRequiredField.Message);
        Result := False;
      end;
    end
    else if LControl is TUniCustomDateTimePicker then
    begin
      var LValue := THackUniDateTimePicker(LControl).DateTime;
      if LValue = 0 then
      begin
        MarkInvalid(LControl, LRequiredField.Message);
        Result := False;
      end;
    end
    else if LControl is TUniCustomDBLookupComboBox then
    begin
      var LValue := TUniCustomDBLookupComboBox(LControl).KeyValue;
      if VarIsNull(LValue) then
      begin
        MarkInvalid(LControl, LRequiredField.Message);
        Result := False;
      end;
    end;
  end;
end;

end.
