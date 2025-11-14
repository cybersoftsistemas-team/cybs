unit cbsCliSrv.MainBaseModule;

interface

uses
{IDE}
  uniGUIMainModule;

type
  TcbsCliSrvMainBaseModule = class(TUniGUIMainModule)
  private
    FIsElectron: Boolean;
  public
    property IsElectron: Boolean read FIsElectron write FIsElectron;
  end;

implementation

{$R *.dfm}

end.
