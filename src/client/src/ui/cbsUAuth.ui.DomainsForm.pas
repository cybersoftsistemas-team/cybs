unit cbsUAuth.ui.DomainsForm;

interface

uses
{PROJECT}
  cbsSystem.Form.DialogBaseForm,
{IDE}
  Data.DB, uniGUIBaseClasses, uniLabel, uniGUIClasses, uniBasicGrid, uniDBGrid, uniDBTreeGrid, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions,
  Vcl.ActnList, uniMainMenu, Vcl.Controls, Vcl.Forms, uniButton, uniBitBtn;

type
  TfrmDomains = class(TfrmDialogBase)
    grdDomains: TUniDBTreeGrid;
    labDomains: TUniLabel;
  protected
    function GetDataModule: IDataModule; override;
  public
    procedure DataChange(Sender: TObject; Field: TField); override;
  end;

  function frmDomains: TfrmDomains;

implementation

{$R *.dfm}

uses
{PROJECT}
  cbsMain.data.module.MainModule,
  cbsUAuth.data.module.LoginModule;

function frmDomains: TfrmDomains;
begin
  Result := TfrmDomains(damMain.GetFormInstance(TfrmDomains));
end;

{ TfrmDomains }

function TfrmDomains.GetDataModule: IDataModule;
begin
  Result := damLogin;
end;

procedure TfrmDomains.DataChange(Sender: TObject; Field: TField);
begin
  inherited;
end;

end.
