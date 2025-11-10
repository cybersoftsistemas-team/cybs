unit cbsclient.Main;

interface

uses
{PROJECT}
  cbsCliSrv.MainBaseForm,
{IDE}
  uniButton, uniBitBtn, uniGUIClasses, uniEdit, uniDBEdit, uniPanel, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses, uniImageList, System.Actions, Vcl.ActnList,
  uniMainMenu, System.ImageList, Vcl.ImgList, uniSpeedButton, uniLabel, uniMultiItem, uniComboBox, uniDBComboBox, uniDBLookupComboBox, Vcl.Imaging.pngimage, uniImage;

type
  TMainForm = class(TMainBaseForm)
    pnlAuthenticate: TUniPanel;
    pnlHeader: TUniSimplePanel;
    pnlBody: TUniSimplePanel;
    pnlFooter: TUniSimplePanel;
    edtUserName: TUniDBEdit;
    edtPassword: TUniDBEdit;
    edtDomainName: TUniDBEdit;
    btnOptions: TUniBitBtn;
    btnConnect: TUniBitBtn;
    actConnect: TAction;
    actOptions: TAction;
    btnDomains: TUniSpeedButton;
    actDomains: TAction;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    UniLabel6: TUniLabel;
    cbbServerName: TUniDBLookupComboBox;
    UniImage1: TUniImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetMainForm: TMainForm;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication,
  uniGUIVars,
{PROJECT}
  cbsclient.MainModule;

function GetMainForm: TMainForm;
begin
  Result := TMainForm(GetMainModule.GetFormInstance(TMainForm));
end;

initialization
begin
  RegisterAppFormClass(TMainForm);
end;

end.
