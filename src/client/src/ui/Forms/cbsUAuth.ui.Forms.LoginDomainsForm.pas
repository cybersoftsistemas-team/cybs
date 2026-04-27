unit cbsUAuth.ui.Forms.LoginDomainsForm;

interface

uses
{PROJECT}
  cbsSystem.Form.DialogBaseForm,
{IDE}
  Data.DB, uniGUIBaseClasses, uniGUIClasses, UniGUIAbstractClasses, uniTreeView, uniLabel, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions,
  Vcl.ActnList, uniMainMenu, uniPanel, Vcl.Controls, Vcl.Forms, uniButton, uniBitBtn;

type
  TfrmLoginDomains = class(TfrmDialogBase)
    labDomains: TUniLabel;
    trvDomains: TUniTreeView;
    procedure actOkExecute(Sender: TObject);
    procedure trvDomainsChange(Sender: TObject; Node: TUniTreeNode);
    procedure UniFormCreate(Sender: TObject);
  private
    FDomainId: TGuid;
    FDomainName: string;
    procedure BuildTreeView(const ATreeView: TUniTreeView; const ADataSet: TDataSet);
  public
    property DomainId: TGuid read FDomainId;
    property DomainName: string read FDomainName;
  end;

  function frmLoginDomains: TfrmLoginDomains;

implementation

{$R *.dfm}

uses
{PROJECT}
  cbsMain.ui.Data.Modules.MainModule,
  cbsUAuth.ui.Data.Modules.LoginDomainsModule,
{SPRING}
  Spring.Collections;

function frmLoginDomains: TfrmLoginDomains;
begin
  Result := TfrmLoginDomains(damMain.GetFormInstance(TfrmLoginDomains));
end;

{ TfrmLoginDomains }

procedure TfrmLoginDomains.actOkExecute(Sender: TObject);
begin
  inherited;
  var LNode := trvDomains.Selected;
  if Assigned(LNode) and Assigned(LNode.Data) then
  begin
    FDomainId := PGUID(LNode.Data)^;
    FDomainName := LNode.Text;
    Exit;
  end;
  FDomainName := '';
  FDomainId := TGUID.Empty;
end;

procedure TfrmLoginDomains.BuildTreeView(const ATreeView: TUniTreeView; const ADataSet: TDataSet);
type
  INodeList = IDictionary<TGUID, TUniTreeNode>;

  function CreateNodeList: INodeList;
  begin
    Result := TCollections.CreateDictionary<TGUID, TUniTreeNode>;
  end;

begin
  var LNodeList := CreateNodeList;
  try
    ADataSet.DisableControls;
    try
      ATreeView.Items.Clear;
      ATreeView.BeginUpdate;
      try
        ADataSet.First;
        while not ADataSet.Eof do
        begin
          var LParentId := ADataSet.FieldByName('ParentId').AsGuid;
          var LParentNode: TUniTreeNode := nil;
          LNodeList.TryGetValue(LParentId, LParentNode);
          var LNode := ATreeView.Items.AddChild(LParentNode, ADataSet.FieldByName('Name').AsString);
          LNode.ImageIndex := if Assigned(LParentNode) then 1 else 0;
          LNode.SelectedIndex := if Assigned(LParentNode) then 1 else 0;
          LNode.Data := AllocMem(SizeOf(TGUID));
          var LId := ADataSet.FieldByName('Id').AsGuid;
          PGUID(LNode.Data)^ := LId;
          LNodeList.Add(LId, LNode);
          ADataSet.Next;
        end;
      finally
        ATreeView.EndUpdate;
      end;
    finally
      ADataSet.EnableControls;
    end;
  finally
    LNodeList := nil;
  end;
end;

procedure TfrmLoginDomains.trvDomainsChange(Sender: TObject; Node: TUniTreeNode);
begin
  actOk.Enabled := Assigned(trvDomains.Selected);
end;

procedure TfrmLoginDomains.UniFormCreate(Sender: TObject);
begin
  inherited;
  BuildTreeView(trvDomains, damLoginDomains.qryDOM);
end;

end.

