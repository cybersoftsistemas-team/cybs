unit cbsUAuth.ui.CityRegistrationForm;

interface

uses
{PROJECT}
  cbsSystem.Form.DialogBaseForm,
{IDE}
  uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Controls, Vcl.Forms, uniGUIClasses, uniButton,
  uniBitBtn, uniPanel, uniEdit, uniDBEdit;

type
  TfrmCityRegistration = class(TfrmDialogBase)
    edtAreaCode: TUniDBEdit;
    edtName: TUniDBEdit;
    procedure actCancelExecute(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure UniFormReady(Sender: TObject);
  protected
    function GetDataModule: IDataModule; override;
  end;

  function frmCityRegistration: TfrmCityRegistration;

implementation

{$R *.dfm}

uses
{PROJECT}
  cbsMain.data.module.MainModule,
  cbsUAuth.data.module.CustomerRegistrationModule;

function frmCityRegistration: TfrmCityRegistration;
begin
  Result := TfrmCityRegistration(damMain.GetFormInstance(TfrmCityRegistration));
end;

{ TfrmCityRegistration }

procedure TfrmCityRegistration.actCancelExecute(Sender: TObject);
begin
  damCustomerRegistration.qryCYT.Cancel;
  inherited;
end;

procedure TfrmCityRegistration.actOkExecute(Sender: TObject);
begin
  damCustomerRegistration.qryCYT.Post;
  inherited;
end;

function TfrmCityRegistration.GetDataModule: IDataModule;
begin
  Result := damCustomerRegistration;
end;

procedure TfrmCityRegistration.UniFormReady(Sender: TObject);
begin
  inherited;
  damCustomerRegistration.qryCYT.Append;
end;

end.
