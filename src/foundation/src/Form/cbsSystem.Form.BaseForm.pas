unit cbsSystem.Form.BaseForm;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Form.BaseForm,
  cbsSystem.Contracts.Module.BaseModule,
  cbsSystem.MessageBox,
  cbsSystem.Module.BaseModule,
{IDE}
  Data.DB, Dialogs, uniGUIDialogs, uniGUIForm, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu;

type
  FormType = class of TUniForm;

  IDataModule = cbsSystem.Contracts.Module.BaseModule.IDataModule;

  TfrmBase = class(TUniForm, IForm)
    aclMain: TUniActionList;
    ilaMain: TUniImageListAdapter;
    nilstMain: TUniNativeImageList;
    procedure UniFormDestroy(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
  private
    FDataModule: IDataModule;
  protected
    function GetDataModule: IDataModule; virtual;
    procedure MessageBox(const ATitle, AMessage, ADetails: string; const AIcon: TMsgDlgType; const AButtons: TMsgDlgButtons; const ACallback: TMessageCallback = nil;
      const AWidth: Integer = 400; const AHeight: Integer = 160);
  public
    procedure DataChange(Sender: TObject; Field: TField); virtual;
    procedure StateChange(Sender: TObject); virtual;
  end;

implementation

{$R *.dfm}

{ TfrmBase }

function TfrmBase.GetDataModule: IDataModule;
begin
  Result := nil;
end;

procedure TfrmBase.MessageBox(const ATitle, AMessage, ADetails: string; const AIcon: TMsgDlgType; const AButtons: TMsgDlgButtons; const ACallback: TMessageCallback; const AWidth,
  AHeight: Integer);
begin
  ExecuteMessageBox(ATitle, AMessage, ADetails, AButtons, AIcon, ACallback, AWidth, AHeight);
end;

procedure TfrmBase.DataChange(Sender: TObject; Field: TField);
begin
  // This method can be overwritten by inherited classes.
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

end.
