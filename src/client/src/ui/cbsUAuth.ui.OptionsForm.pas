unit cbsUAuth.ui.OptionsForm;

interface

uses
{PROJECT}
  cbsSystem.Form.BaseForm,
{IDE}
  uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Controls, Vcl.Forms, uniGUIClasses, uniBasicGrid,
  uniDBGrid, uniLabel, uniButton, uniBitBtn, uniPanel;

type
  TfrmOptions = class(TfrmBase)
    grdConn: TUniDBGrid;
    labConnList: TUniLabel;
    btnAdd: TUniBitBtn;
    btnEdit: TUniBitBtn;
    btnDel: TUniBitBtn;
    btnClear: TUniBitBtn;
    actAdd: TAction;
    actEdit: TAction;
    actDel: TAction;
    actClear: TAction;
    actClose: TAction;
    btnClose: TUniBitBtn;
    btnTestConn: TUniBitBtn;
    actTestConn: TAction;
    actSelected: TAction;
    btnSelected: TUniBitBtn;
    pnlLine01: TUniPanel;
    pnlLine02: TUniPanel;
    procedure actAddExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function frmOptions: TfrmOptions;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication,
{PROJECT}
  cbsUAuth.data.module.LoginModule,
  cbsUAuth.ui.ConnEditorForm;

function frmOptions: TfrmOptions;
begin
  Result := TfrmOptions(UniApplication.UniMainModule.GetFormInstance(TfrmOptions));
end;

procedure TfrmOptions.actAddExecute(Sender: TObject);
begin
  frmConnEditor.ConnectionString := damLogin.mtbCNSConnectionString.AsString;
  frmConnEditor.ShowModal;
end;

end.
