unit cbsSystem.Module;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Contracts.Module;

type
  TcbsModule = class(TInterfacedObject, IModule)
  private
    FHandle: HMODULE;
    FName: string;
    FRequiredList: IRequiredList;
    function GetHandle: HMODULE;
    function GetName: string;
    function GetRequires: IRequires;
    procedure LoadModule(const AFileName: TFileName);
    procedure ReadRequires(const AHandle: HMODULE);
    procedure SetModuleName(const AFileName: TFileName);
  public
    constructor Create(const AFileName: TFileName);
    destructor Destroy; override;
    property Handle: HMODULE read GetHandle;
    property Name: string read GetName;
    property Requires: IRequires read GetRequires;
  end;

implementation

uses
{IDE}
{$IFDEF MSWINDOWS}
  Winapi.Windows
{$ELSEIF Defined(POSIX)}
  Posix.Dlfcn
{$ENDIF};

type
  TCollectContext = packed record
  public
    Requires: IRequiredList;
  end;

  PCollectContext = ^TCollectContext;

procedure SetPackageInfo(const Name: string; NameType: TNameType; Flags: Byte; Param: Pointer);
begin
  if (NameType = ntRequiresPackage) and Name.ToLower.StartsWith('cbs') then
  begin
    PCollectContext(Param).Requires.Add(ChangeFileExt(Name, ''));
  end;
end;

{ TcbsModule }

constructor TcbsModule.Create(const AFileName: TFileName);
begin
  inherited Create;
  FRequiredList := CreateRequiredList;
  SetModuleName(AFileName);
  LoadModule(AFileName);
  ReadRequires(FHandle);
end;

destructor TcbsModule.Destroy;
begin
  FRequiredList := nil;
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

function TcbsModule.GetName: string;
begin
  Result := FName;
end;

function TcbsModule.GetRequires: IRequires;
begin
  Result := FRequiredList;
end;

procedure TcbsModule.LoadModule(const AFileName: TFileName);
begin
  FHandle := LoadPackage(AFileName);
  if FHandle = 0 then
  begin
    raise Exception.CreateFmt('Error loading module "%s".', [AFileName]);
  end;
end;

procedure TcbsModule.ReadRequires(const AHandle: HMODULE);
var
  LContext: TCollectContext;
begin
  var LFlags := 0;
  FRequiredList.Clear;
  LContext.Requires := FRequiredList;
  GetPackageInfo(AHandle, @LContext, LFlags, SetPackageInfo);
end;

procedure TcbsModule.SetModuleName(const AFileName: TFileName);
begin
  FName := ChangeFileExt(ExtractFileName(AFileName), '');
end;

end.
