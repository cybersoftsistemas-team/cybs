unit cbs.MainForm;

interface

uses
{PROJECT}
  cbsCliSrv.MainBaseForm,
{IDE}
  uniGUIBaseClasses, uniGUITypes, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu;

type
  TcbsMainForm = class(TcbsCliSrvMainBaseForm)
    procedure UniFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetMainForm: TcbsMainForm;

implementation

{$R *.dfm}

uses
{IDE}
  System.AnsiStrings,
  uniGUIApplication,
  uniGUIVars,
{PROJECT}
  cbs.MainModule;

function GetMainForm: TcbsMainForm;
begin
  Result := TcbsMainForm(GetMainModule.GetFormInstance(TcbsMainForm));
end;

procedure TcbsMainForm.UniFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
begin
  inherited;
  if EventName = 'IsElectron' then
  begin
    GetMainModule.IsElectron := SameText(Params.Values['value'], 'true');
  end;
end;

initialization
begin
  RegisterAppFormClass(TcbsMainForm);
end;

end.
