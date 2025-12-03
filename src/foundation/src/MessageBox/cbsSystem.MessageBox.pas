unit cbsSystem.MessageBox;

interface

uses
{IDE}
  Dialogs, uniButton, uniGUIForm, uniGUIBaseClasses, uniLabel, uniImage, uniGUIClasses, uniMemo, Vcl.Controls, Vcl.Forms, uniPanel, uniImageList, System.ImageList, Vcl.ImgList,
  System.Classes, System.Actions, Vcl.ActnList, uniMainMenu;

type
  TMessageCallback = reference to procedure(const AResult: Integer);

  TfrmMessageBox = class(TUniForm)
    pnlButtons: TUniContainerPanel;
    unmText: TUniMemo;
    imgIcon: TUniImage;
    labCaption: TUniLabel;
  private
    FCallback: TMessageCallback;
    procedure ButtonClick(Sender: TObject);
    procedure CopyClick(Sender: TObject);
    procedure LoadIcon(const AIcon: TMsgDlgType);
  end;

  procedure ExecuteMessageBox(const ATitle, AMessage, ADetails: string; const AButtons: TMsgDlgButtons; const AIcon: TMsgDlgType; const ACallback: TMessageCallback;
    const AWidth, AHeight: Integer);

implementation

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
  uniGUIApplication,
{PROJECT}
  cbsSystem.Support.ServerModule;

function ButtonCaption(const ABtn: TMsgDlgBtn): string;
begin
  case ABtn of
    mbCancel:    Result := 'Cancelar';
    mbYes:       Result := 'Sim';
    mbNo:        Result := 'Não';
    mbAbort:     Result := 'Abortar';
    mbRetry:     Result := 'Tentar novamente';
    mbIgnore:    Result := 'Ignorar';
    mbAll:       Result := 'Todos';
    mbNoToAll:   Result := 'Não para todos';
    mbYesToAll:  Result := 'Sim para todos';
    mbHelp:      Result := 'Ajuda';
  else
    Result := 'OK';
  end;
end;

function ButtonResult(const ABtn: TMsgDlgBtn): Integer;
begin
  case ABtn of
    mbOK:        Result := mrOK;
    mbCancel:    Result := mrCancel;
    mbYes:       Result := mrYes;
    mbNo:        Result := mrNo;
    mbAbort:     Result := mrAbort;
    mbRetry:     Result := mrRetry;
    mbIgnore:    Result := mrIgnore;
    mbAll:       Result := mrAll;
    mbNoToAll:   Result := mrNoToAll;
    mbYesToAll:  Result := mrYesToAll;
  else
    Result := mrNone;
  end;
end;

procedure ExecuteMessageBox(const ATitle, AMessage, ADetails: string; const AButtons: TMsgDlgButtons; const AIcon: TMsgDlgType; const ACallback: TMessageCallback;
  const AWidth, AHeight: Integer);
begin
  var frmMessageBox := TfrmMessageBox.Create(UniApplication);

  frmMessageBox.Caption := ATitle;
  frmMessageBox.labCaption.Caption := AMessage;
  frmMessageBox.unmText.Text := ADetails;
  frmMessageBox.FCallback := ACallback;
  frmMessageBox.Width := AWidth;
  frmMessageBox.Height := AHeight;

  frmMessageBox.LoadIcon(AIcon);

  var btnCopy := TUniButton.Create(frmMessageBox);
  btnCopy.Parent := frmMessageBox.pnlButtons;
  btnCopy.Caption := 'Copiar';
  btnCopy.Margins.SetBounds(0, 0, 6, 0);
  btnCopy.OnClick := frmMessageBox.CopyClick;
  btnCopy.AlignWithMargins := True;
  btnCopy.Align := alLeft;

  for var LMButton in AButtons do
  begin
    var LButton := TUniButton.Create(frmMessageBox);
    LButton.Parent := frmMessageBox.pnlButtons;
    LButton.Caption := ButtonCaption(LMButton);
    LButton.Tag := ButtonResult(LMButton);
    LButton.Margins.SetBounds(6, 0, 0, 0);
    LButton.OnClick := frmMessageBox.ButtonClick;
    LButton.AlignWithMargins := True;
    LButton.Align := alRight;
  end;

  frmMessageBox.ShowModal;
end;

{ TfrmMessageBox }

procedure TfrmMessageBox.ButtonClick(Sender: TObject);
begin
  var LBtn := TUniButton(Sender);
  if Assigned(FCallback) then
  begin
    FCallback(LBtn.Tag);
  end;
  Close;
end;

procedure TfrmMessageBox.CopyClick(Sender: TObject);
begin
  UniSession.AddJS('navigator.clipboard.writeText(' +
    QuotedStr(string(unmText.Text).Replace(#13#10, '\n')) +
  ');');
end;

procedure TfrmMessageBox.LoadIcon(const AIcon: TMsgDlgType);
begin
  case AIcon of
    mtInformation:
      imgIcon.ImageIndex := 0;
    mtWarning:
      imgIcon.ImageIndex := 1;
    mtError:
      imgIcon.ImageIndex := 2;
    mtConfirmation,
    mtCustom:
      imgIcon.ImageIndex := 3;
  end;
end;

end.
