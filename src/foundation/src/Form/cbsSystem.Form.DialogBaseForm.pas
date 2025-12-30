unit cbsSystem.Form.DialogBaseForm;

interface

uses
{PROJECT}
  cbsSystem.Form.BaseForm,
{IDE}
  uniGUIBaseClasses, System.Classes, System.Actions, Vcl.ActnList, Vcl.Controls, Vcl.Forms, uniGUIClasses, uniButton, uniBitBtn, uniImageList, System.ImageList, Vcl.ImgList,
  uniMainMenu, uniPanel;

type
  TRequiredFieldMode = cbsSystem.Form.BaseForm.TRequiredFieldMode;
  IDataModule = cbsSystem.Form.BaseForm.IDataModule;

  TfrmDialogBase = class(TfrmBase)
    btnOk: TUniBitBtn;
    btnCancel: TUniBitBtn;
    actOk: TAction;
    actCancel: TAction;
    pnlBreak: TUniPanel;
    procedure actOkExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmDialogBase.actOkExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
