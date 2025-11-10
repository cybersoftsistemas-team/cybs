unit cbsclient.ServerModule;

interface

uses
{IDE}
  uniGUIServer;

type
  TServerModule = class(TUniGUIServerModule)
    procedure UniGUIServerModuleCreate(Sender: TObject);
  protected
    procedure FirstInit; override;
  end;

function GetServerModule: TServerModule;

implementation

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
  uniGUIVars,
  VCL.Dialogs,
  Winapi.ShellAPI;

function GetServerModule: TServerModule;
begin
  Result := TServerModule(UniGUIServerInstance);
end;

procedure ExploreWeb(page: PChar);
begin
  var ReturnValue := ShellExecute(0, 'Open', page, nil, nil, 1);
  if ReturnValue <= 32 then
  begin
    case ReturnValue of
      0: Showmessage('Sem memória');
      2: Showmessage('Arquivo não encontrado');
      3: Showmessage('Diretório não encontrado');
      11: Showmessage('Arquivo corrompido ou inválido');
    else
      Showmessage(PChar('Erro nº '+ IntTostr(ReturnValue)+'Na execução do aplicativo'));
    end;
  end;
end;

{ TServerModule }

procedure TServerModule.FirstInit;
begin
  InitServerModule(Self);
end;

procedure TServerModule.UniGUIServerModuleCreate(Sender: TObject);
begin
  ExploreWeb('http://localhost:8077');
end;

initialization
begin
  RegisterServerModuleClass(TServerModule);
end;

end.
