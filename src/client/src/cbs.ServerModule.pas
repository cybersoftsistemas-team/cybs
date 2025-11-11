unit cbs.ServerModule;

interface

uses
{PROJECT}
  cbsCliSrv.ServerBaseModule,
{IDE}
  System.SysUtils;

type
  TcbsServerModule = class(TcbsCliSrvBaseModule)
  protected
    procedure FirstInit; override;
  end;

function cbsServerModule: TcbsServerModule;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIVars;

function cbsServerModule: TcbsServerModule;
begin
  Result := TcbsServerModule(UniGUIServerInstance);
end;

{ TcbsServerModule }

procedure TcbsServerModule.FirstInit;
begin
  InitServerModule(Self);
end;

initialization
begin
  RegisterServerModuleClass(TcbsServerModule);
end;

end.
