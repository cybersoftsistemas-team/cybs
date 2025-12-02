unit cbsSystem.Support.MessageBox;

interface

uses
{IDE}
  Dialogs,
{PROJECT}
  cbsSystem.MessageBox;

  procedure MessageBox(const ATitle, AMessage, ADetails: string; const AIcon: TMsgDlgType; const AButtons: TMsgDlgButtons; const ACallback: TMessageCallback = nil;
    const AWidth: Integer = 400; const AHeight: Integer = 160);

implementation

procedure MessageBox(const ATitle, AMessage, ADetails: string; const AIcon: TMsgDlgType; const AButtons: TMsgDlgButtons; const ACallback: TMessageCallback;
  const AWidth, AHeight: Integer);
begin
  ExecuteMessageBox(ATitle, AMessage, ADetails, AButtons, AIcon, ACallback, AWidth, AHeight);
end;

end.
