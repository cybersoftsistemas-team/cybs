unit cbsSystem.Module.Manager;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Contracts.Module.Manager;

type
  TcbsModuleManager = class(TInterfacedObject, IModuleManager)
  strict private
    LModuleList: IModuleList;
    function GetModuleExtension: string;
    function GetModuleMask: string;
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

function TcbsModuleManager.GetEnumerator: IModuleEnumerator;
begin
  Result := LModuleList.Values.GetEnumerator;
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

procedure TcbsModuleManager.LoadFromFolder(const AFolder: string);
begin
  LoadPackages(AFolder);
end;

procedure TcbsModuleManager.LoadPackage(const AFileName: TFileName);
begin
  if FileExists(AFileName) and not LModuleList.ContainsKey(AFileName) then
  begin
    LModuleList[AFileName] := TcbsModule.Create(AFileName);
  end;
end;

procedure TcbsModuleManager.LoadPackages(const AFolder: string);
begin
  if TDirectory.Exists(AFolder) then
  begin
    for var LFileName in TDirectory.GetFiles(AFolder,
      GetModuleMask, TSearchOption.soAllDirectories) do if
      (TPath.GetFileName(LFileName).CompareTo('cbsMain.bpl') > 0) and
      (TPath.GetFileName(LFileName).CompareTo('cbsMigrations.bpl') > 0) and
      (TPath.GetFileName(LFileName).CompareTo('cbsMigrationsFireDac.bpl') > 0) and
      (TPath.GetFileName(LFileName).CompareTo('cbsSystem.bpl') > 0) then
    begin
      LoadPackage(LFileName);
    end;
  end;
end;

end.
