unit cbsCliSrv.MainBaseForm;

interface

uses
{IDE}
  uniGUIForm, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList;

type
  TcbsCliSrvMainBaseForm = class(TUniForm)
    aclMain: TUniActionList;
    ilaMain: TUniImageListAdapter;
    ilstMain: TUniImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
