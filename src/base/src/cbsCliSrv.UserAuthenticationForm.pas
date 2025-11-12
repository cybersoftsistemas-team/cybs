unit cbsCliSrv.UserAuthenticationForm;

interface

uses
{IDE}
  uniGUIForm, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Imaging.pngimage, uniImage,
  uniSpeedButton, uniButton, uniBitBtn, uniEdit, uniDBEdit, uniGUIClasses, uniMultiItem, uniComboBox, uniDBComboBox, uniDBLookupComboBox, uniLabel, uniPanel, Vcl.Controls,
  Vcl.Forms;

type
  TcbsCliSrvUserAuthenticationForm = class(TUniLoginForm)
    aclMain: TUniActionList;
    ilaMain: TUniImageListAdapter;
    actConnect: TAction;
    actDomains: TAction;
    actOptions: TAction;
    pnlAuthenticate: TUniPanel;
    pnlHeader: TUniSimplePanel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    UniLabel6: TUniLabel;
    pnlBody: TUniSimplePanel;
    edtUserName: TUniDBEdit;
    edtPassword: TUniDBEdit;
    edtDomainName: TUniDBEdit;
    btnConnect: TUniBitBtn;
    btnDomains: TUniSpeedButton;
    pnlFooter: TUniSimplePanel;
    UniImage1: TUniImage;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    nilstMain: TUniNativeImageList;
    pnlTitlebar: TUniContainerPanel;
    nilstTitlebar: TUniNativeImageList;
    pnlTitlebarBtns: TUniSimplePanel;
    btnWindowsClose: TUniSpeedButton;
    btnWindowsMinimize: TUniSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
