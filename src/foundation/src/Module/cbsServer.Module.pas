unit cbsServer.Module;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsServer.Contracts.Module;

type
  TcbsModule = class(TInterfacedObject, IcbsModule)
  strict private
    FHandle: HMODULE;
    function GetHandle: HMODULE;
  public
    constructor Create(const AFileName: TFileName);
    destructor Destroy; override;
    property Handle: HMODULE read GetHandle;
  end;

implementation

uses
{IDE}
  System.IOUtils,
  uniGUIVars;

{ TcbsModule }

constructor TcbsModule.Create(const AFileName: TFileName);
begin
  inherited Create;
  FHandle := LoadPackage(AFileName);
  if FHandle = 0 then
  begin
    raise Exception.CreateFmt('Error loading module "%s".', [AFileName]);
  end;
end;

destructor TcbsModule.Destroy;
begin
  if FHandle <> 0 then
  begin
    UnloadPackage(FHandle);
  end;
  inherited;
end;

function TcbsModule.GetHandle: HMODULE;
begin
  Result := FHandle;
end;

end.
