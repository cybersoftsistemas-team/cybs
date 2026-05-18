unit Shared.UI.Forms.MainForm;

interface

uses
{PROJECT}
  cbsSystem.Form.BaseForm,
{IDE}
  uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Controls, Vcl.Forms, uniGUIClasses, uniStatusBar,
  uniPanel, uniPageControl;

type
  TfrmMain = class(TfrmBase)
    stbMain: TUniStatusBar;
    pnlMain: TUniContainerPanel;
    pclMain: TUniPageControl;
    UniTabSheet1: TUniTabSheet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
{PROJECT}
  Shared.UI.Data.Modules.MainModule;

function frmMain: TfrmMain;
begin
  Result := TfrmMain(damMain.GetFormInstance(TfrmMain));
end;

end.
