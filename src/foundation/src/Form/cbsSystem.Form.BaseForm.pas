unit cbsSystem.Form.BaseForm;

interface

uses
{PROJECT}
  cbsSystem.MessageBox,
  cbsSystem.Module.BaseModule,
{IDE}
  Data.DB, Dialogs, uniGUIDialogs, uniGUIForm, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu;

type
  TcbsFormClass = class of TUniForm;

  TdamBase = cbsSystem.Module.BaseModule.TdamBase;

  TfrmBase = class(TUniForm)
    aclMain: TUniActionList;
    ilaMain: TUniImageListAdapter;
    nilstMain: TUniNativeImageList;
    procedure UniFormCreate(Sender: TObject);
  private
    FDataModule: TdamBase;
    FOwnDataModule: Boolean;
  protected
    function GetDataModule: TdamBase; virtual;
    procedure DataChange(Sender: TObject; Field: TField); virtual;
    procedure MessageBox(const ATitle, AMessage, ADetails: string; const AIcon: TMsgDlgType; const AButtons: TMsgDlgButtons; const ACallback: TMessageCallback = nil;
      const AWidth: Integer = 400; const AHeight: Integer = 160);
  public
    property DataModule: TdamBase read FDataModule;
  end;

implementation

{$R *.dfm}

{ TfrmBase }

function TfrmBase.GetDataModule: TdamBase;
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

procedure TfrmBase.UniFormCreate(Sender: TObject);
begin
  FOwnDataModule := False;
  FDataModule := GetDataModule;
  if Assigned(FDataModule) then
  begin
    FDataModule.OnDataChange := DataChange;
    FOwnDataModule := True;
  end;
end;

end.
