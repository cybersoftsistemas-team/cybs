unit cbsSystem.Module.BaseModule;

interface

uses
{IDE}
  System.Classes;

type
  TdamBase = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TdamBaseClass = class of TDataModule;

implementation

{$R *.dfm}

end.
