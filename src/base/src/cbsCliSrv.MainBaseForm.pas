unit cbsCliSrv.MainBaseForm;

interface

uses
{IDE}
  uniGUIForm, uniImageList, System.Classes, uniMainMenu, uniGUIBaseClasses, System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList;

type
  TcbsCliSrvMainBaseForm = class(TUniForm)
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
