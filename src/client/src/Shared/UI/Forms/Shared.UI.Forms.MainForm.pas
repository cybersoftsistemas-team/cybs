unit Shared.UI.Forms.MainForm;

interface

uses
{PROJECT}
  cbsSystem.Form.BaseForm,
{IDE}
  uniGUIBaseClasses, uniImageList, uniGUIClasses, uniTreeView, uniTreeMenu, uniPanel, uniPageControl, Vcl.Controls, Vcl.Forms, System.ImageList, Vcl.ImgList, System.Classes,
  System.Actions, Vcl.ActnList, uniMainMenu, uniSplitter, Vcl.Menus;

type
  TfrmMain = class(TfrmBase)
    pclMain: TUniPageControl;
    tbsMain: TUniTabSheet;
    trmMain: TUniTreeMenu;
    sptMain: TUniSplitter;
    mimMain: TUniMenuItems;
    mimMain1: TUniMenuItem;
    Produtos1: TUniMenuItem;
    Servios1: TUniMenuItem;
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
