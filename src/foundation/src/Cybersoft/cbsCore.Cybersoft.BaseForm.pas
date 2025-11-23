unit cbsCore.Cybersoft.BaseForm;

interface

uses
{IDE}
  uniGUIForm, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu;

type
  TcbsBaseForm = class(TUniForm)
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
