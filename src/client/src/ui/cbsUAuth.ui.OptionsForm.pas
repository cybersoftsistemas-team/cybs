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
    procedure actEditExecute(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AddorEditConnection; overload;
    procedure AddorEditConnection(const AName, AConnectionString: string); overload;
  end;

  function frmOptions: TfrmOptions;

implementation

{$R *.dfm}

uses
{IDE}
  System.UITypes,
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
  AddorEditConnection;
end;

procedure TfrmOptions.actEditExecute(Sender: TObject);
begin
  AddorEditConnection(damLogin.mtbCNSName.AsString, damLogin.mtbCNSConnectionString.AsString);
end;

procedure TfrmOptions.AddorEditConnection;
begin
  AddorEditConnection('', '');
end;

procedure TfrmOptions.AddorEditConnection(const AName, AConnectionString: string);
begin
  frmConnEditor.ConnectionName := AName;
  frmConnEditor.ConnectionString := AConnectionString;
  frmConnEditor.ShowModal(
    procedure(Sender: TComponent; Result: Integer)
    begin
      if Result = mrOk then
      begin
        damLogin.mtbCNS.Edit;
        damLogin.mtbCNSName.AsString := frmConnEditor.ConnectionName;
        damLogin.mtbCNSConnectionString.AsString := frmConnEditor.ConnectionString;
        damLogin.mtbCNS.Post;
      end;
    end
  );
end;

end.
