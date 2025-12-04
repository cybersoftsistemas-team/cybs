unit cbsSystem.Module.Manager;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module,
  cbsSystem.Contracts.Module.Manager,
{SPRING}
  Spring.Collections;

type
  TcbsModuleManager = class(TInterfacedObject, IcbsModuleManager)
  strict private
    LModuleList: IModuleList;
    function GetModuleExtension: string;
    function GetModuleMask: string;
  public
    constructor Create;
    destructor Destroy; override;
    function GetEnumerator: IEnumerator<IcbsModule>;
    procedure LoadFromFolder(const AFolder: string);
  end;

implementation

uses
{IDE}
  System.IOUtils,
  System.SysUtils,
{PROJECT}
  cbsSystem.Module;

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

function TcbsModuleManager.GetEnumerator: IEnumerator<IcbsModule>;
begin
  Result := LModuleList.GetEnumerator;
end;

function TcbsModuleManager.GetModuleExtension: string;
begin
{$IFDEF MSWINDOWS}
  Result := 'cbs*.bpl';
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
  Result := '*' + GetModuleExtension;
end;

procedure TcbsModuleManager.LoadFromFolder(const AFolder: string);
begin
  if not TDirectory.Exists(AFolder) then
  begin
    Exit;
  end;
  var LMask := GetModuleMask;
  var LFiles := TDirectory.GetFiles(
    AFolder,
    LMask,
    TSearchOption.soTopDirectoryOnly
  );
  for var LFile in LFiles do
  begin
    var LModule := TcbsModule.Create(LFile);
    LModuleList.Add(LModule);
  end;
end;

end.
