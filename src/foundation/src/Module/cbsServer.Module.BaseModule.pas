unit cbsServer.Module.BaseModule;

interface

uses
{IDE}
  Classes;

type
  TdamBase = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TcbsModuleClass = class of TDataModule;

implementation

{$R *.dfm}

end.
