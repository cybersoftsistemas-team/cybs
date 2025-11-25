unit cbsServer.Cybersoft.BaseModule;

interface

uses
{IDE}
  Classes;

type
  TcbsBaseModule = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TcbsModuleClass = class of TDataModule;

implementation

{$R *.dfm}

end.
