unit cbsSystem.Form.BaseForm;

interface

uses
{IDE}
  uniGUIDialogs, uniGUIForm, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu;

type
  TcbsFormClass = class of TUniForm;

  TfrmBase = class(TUniForm)
    aclMain: TUniActionList;
    ilaMain: TUniImageListAdapter;
    nilstMain: TUniNativeImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
