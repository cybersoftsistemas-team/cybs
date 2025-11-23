program cbs;

{$APPTYPE GUI}

uses
{IDE}
  System.SysUtils,
  Winapi.Windows;

type
  TStartServerProc = procedure; stdcall;

{$R *.res}

var
  LHandle: HMODULE;
  StartServer: TStartServerProc;
begin
  ReportMemoryLeaksOnShutdown := True;
  try
    LHandle := LoadLibrary('cbsCore.dll');
    try
      if LHandle = 0 then
      begin
        raise Exception.Create('Falha ao carregar cbsCore.dll');
      end;
      @StartServer := GetProcAddress(LHandle, 'StartServer');
      if not Assigned(StartServer) then
      begin
        raise Exception.Create('Método StartServer não encontrado na DLL.');
      end;
      StartServer;
    finally
      FreeLibrary(LHandle);
    end;
  except
    on E: Exception do
    begin
      MessageBox(0, PChar(E.Message), 'Erro', MB_ICONERROR);
    end;
  end;
end.
