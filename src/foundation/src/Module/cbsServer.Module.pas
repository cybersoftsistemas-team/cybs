unit cbsServer.Module;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsServer.Contracts.Module,
  cbsServer.Module.Api;

type
  TcbsModule = class(TInterfacedObject, IcbsModule)
  strict private
    FHandle: HMODULE;
    FInfo: TcbsModuleInfo;
    function GetHandle: HMODULE;
    function GetInfo: TcbsModuleInfo;
  public
    constructor Create(const AFileName: TFileName);
    destructor Destroy; override;
    property Handle: HMODULE read GetHandle;
    property Info: TcbsModuleInfo read GetInfo;
  end;

implementation

uses
{IDE}
  System.IOUtils,
  uniGUIVars,
{$IFDEF MSWINDOWS}
  Winapi.Windows
{$ELSEIF Defined(POSIX)}
  Posix.Dlfcn
{$ENDIF};

{ TcbsModule }

constructor TcbsModule.Create(const AFileName: TFileName);
begin
  inherited Create;
{$IFDEF MSWINDOWS}
  FHandle := LoadLibrary(PChar(AFileName));
{$ELSEIF Defined(POSIX)}
  FHandle := THandle(dlopen(PAnsiChar(AnsiString(AFileName)), RTLD_NOW));
{$ENDIF}
  if FHandle = 0 then
  begin
{$IFDEF MSWINDOWS}
    raise Exception.CreateFmt('Error loading module "%s".', [AFileName]);
{$ELSEIF Defined(POSIX)}
    raise Exception.CreateFmt('Error loading module "%s": %s', [AFileName, dlerror]);
{$ENDIF}
  end;
  var GetModuleInfo: TGetModuleInfo;
  FillChar(FInfo, SizeOf(FInfo), 0);
  @GetModuleInfo := GetProcAddress(FHandle, 'GetModuleInfo');
  if Assigned(@GetModuleInfo) then
  begin
    var PInfo := GetModuleInfo();
    if PInfo <> nil then
    begin
      FInfo := PInfo^;
    end;
  end;
  var GetRegisteredForms: TGetRegisteredForms;
  @GetRegisteredForms := GetProcAddress(FHandle, 'GetRegisteredForms');
  if Assigned(@GetRegisteredForms) then
  begin
    for var LFormClass in GetRegisteredForms() do
    begin
      RegisterAppFormClass(LFormClass);
    end;
  end;
  var GetRegisteredModules: TGetRegisteredModules;
  @GetRegisteredModules := GetProcAddress(FHandle, 'GetRegisteredModules');
  if Assigned(@GetRegisteredModules) then
  begin
    for var LModuleClass in GetRegisteredModules() do
    begin
      RegisterModuleClass(LModuleClass);
    end;
  end;
end;

destructor TcbsModule.Destroy;
begin
  if FHandle <> 0 then
  begin
{$IFDEF MSWINDOWS}
    FreeLibrary(FHandle);
{$ELSEIF Defined(POSIX)}
    dlclose(FHandle);
{$ENDIF}
  end;
  inherited;
end;

function TcbsModule.GetHandle: HMODULE;
begin
  Result := FHandle;
end;

function TcbsModule.GetInfo: TcbsModuleInfo;
begin
  Result := FInfo;
end;

end.
