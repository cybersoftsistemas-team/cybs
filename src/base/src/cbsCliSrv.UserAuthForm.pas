unit cbsCliSrv.UserAuthForm;

interface

uses
{IDE}
  uniGUITypes, uniGUIForm, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Imaging.pngimage,
  uniImage, uniSpeedButton, uniButton, uniBitBtn, uniGUIClasses, uniEdit, uniDBEdit, uniLabel, uniPanel, Vcl.Controls, Vcl.Forms;

type
  TcbsCliSrvUserAuthForm = class(TUniLoginForm)
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
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    nilstMain: TUniNativeImageList;
    UniImage1: TUniImage;
    procedure actConnectExecute(Sender: TObject);
    procedure UniLoginFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsCliSrv.RunTime,
  cbsCliSrv.UserAuthModule;

procedure TcbsCliSrvUserAuthForm.actConnectExecute(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TcbsCliSrvUserAuthForm.UniLoginFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
begin
  if EventName = 'IsElectron' then
  begin
    RunTime.IsElectron := SameText(Params.Values['value'], 'true');
  end;
end;

end.
