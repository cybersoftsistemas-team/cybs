unit cbsUAuth.ui.DomainsForm;

interface

uses
{PROJECT}
  cbsSystem.Form.DialogBaseForm,
{IDE}
  uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Controls, Vcl.Forms, uniGUIClasses, uniButton,
  uniBitBtn, uniLabel, uniBasicGrid, uniDBGrid, uniDBTreeGrid;

type
  TfrmDomains = class(TfrmDialogBase)
    grdDomains: TUniDBTreeGrid;
    labDomains: TUniLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmDomains: TfrmDomains;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication;

function frmDomains: TfrmDomains;
begin
  Result := TfrmDomains(UniApplication.UniMainModule.GetFormInstance(TfrmDomains));
end;

end.
