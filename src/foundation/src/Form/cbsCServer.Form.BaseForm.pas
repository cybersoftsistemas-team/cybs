unit cbsCServer.Form.BaseForm;

interface

uses
{IDE}
  uniGUIForm, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu;

type
  TfrmBase = class(TUniForm)
    aclMain: TUniActionList;
    ilaMain: TUniImageListAdapter;
    nilstMain: TUniNativeImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TcbsFormClass = class of TUniForm;

implementation

{$R *.dfm}

end.
