unit cbsSystem.Module.Manager;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Contracts.Module.Manager;

type
  TcbsModuleManager = class(TInterfacedObject, IcbsModuleManager)
  strict private
    LModuleList: IModuleList;
    function GetModuleExtension: string;
    function GetModuleMask: string;
    procedure CheckPacketCycles;
    procedure LoadPackage(const AFileName: TFileName);
    procedure LoadPackages(const AFolder: string);
  public
    constructor Create;
    destructor Destroy; override;
    function GetEnumerator: IModuleEnumerator;
    procedure LoadFromFolder(const AFolder: string);
  end;

implementation

uses
{IDE}
  System.IOUtils,
{PROJECT}
  cbsSystem.Module,
  cbsSystem.Module.Manager.CycleInfo;

{ TcbsModuleManager }

constructor TcbsModuleManager.Create;
begin
  inherited Create;
  LModuleList := CreateModuleList;
end;

destructor TcbsModuleManager.Destroy;
begin
  LModuleList.Clear;
  LModuleList := nil;
  inherited;
end;

function TcbsModuleManager.GetEnumerator: IModuleEnumerator;
begin
  Result := LModuleList.GetEnumerator;
end;

function TcbsModuleManager.GetModuleExtension: string;
begin
{$IFDEF MSWINDOWS}
  Result := '.bpl';
{$ELSEIF Defined(MACOS)}
  Result := '.dylib';
{$ELSEIF Defined(LINUX)}
  Result := '.so';
{$ELSE}
  Result := ''; // Caso improvável
{$ENDIF}
end;

function TcbsModuleManager.GetModuleMask: string;
begin
  Result := 'cbs*' + GetModuleExtension;
end;

procedure TcbsModuleManager.CheckPacketCycles;
begin
  var LCycle := DetectCircularDependencies(Self);
end;

procedure TcbsModuleManager.LoadFromFolder(const AFolder: string);
begin
  LoadPackage(TPath.Combine(ExtractFilePath(ParamStr(0)), 'cbsSystem' + GetModuleExtension));
  LoadPackages(AFolder);
  CheckPacketCycles;
end;

procedure TcbsModuleManager.LoadPackage(const AFileName: TFileName);
begin
  if FileExists(AFileName) then
  begin
    LModuleList.Add(TcbsModule.Create(AFileName));
  end;
end;

procedure TcbsModuleManager.LoadPackages(const AFolder: string);
begin
  if TDirectory.Exists(AFolder) then
  begin
    for var LFileName in TDirectory.GetFiles(AFolder,
      GetModuleMask, TSearchOption.soAllDirectories) do
    begin
      LModuleList.Add(TcbsModule.Create(LFileName));
    end;
  end;
end;

end.
