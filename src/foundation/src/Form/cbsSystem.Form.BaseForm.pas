unit cbsSystem.Form.BaseForm;

interface

uses
  cbsSystem.Module.BaseModule,
{IDE}
  Data.DB, uniGUIDialogs, uniGUIForm, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu;

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
