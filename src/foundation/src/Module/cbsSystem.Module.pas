unit cbsSystem.Module;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Contracts.Form.Repository,
  cbsSystem.Contracts.Module,
  cbsSystem.Contracts.Module.Repository;

type
  TcbsModule = class(TInterfacedObject, IModule)
  private
    FFormTypeList: IFormTypeList;
    FHandle: HMODULE;
    FModuleTypeList: IModuleTypeList;
    FName: string;
    FRequiredList: IRequiredList;
    function GetHandle: HMODULE;
    function GetName: string;
    function GetRequires: IRequires;
    procedure LoadFormTypes;
    procedure LoadModule(const AFileName: TFileName);
    procedure LoadModuleTypes;
    procedure ReadRequires(const AHandle: HMODULE);
    procedure SetModuleName(const AFileName: TFileName);
  public
    constructor Create(const AFileName: TFileName);
    destructor Destroy; override;
    function FormTypes: IFormTypes;
    function ModuleTypes: IModuleTypes;
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
  FFormTypeList := CreateFormTypeList;
  FModuleTypeList := CreateModuleTypeList;
  FRequiredList := CreateRequiredList;
  SetModuleName(AFileName);
  LoadModule(AFileName);
  LoadFormTypes;
  LoadModuleTypes;
  ReadRequires(FHandle);
end;

destructor TcbsModule.Destroy;
begin
  FFormTypeList := nil;
  FModuleTypeList := nil;
  FRequiredList := nil;
  if FHandle <> 0 then
  begin
    UnloadPackage(FHandle);
  end;
  inherited;
end;

function TcbsModule.FormTypes: IFormTypes;
begin
  Result := FFormTypeList;
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

function TcbsModule.ModuleTypes: IModuleTypes;
begin
  Result := FModuleTypeList;
end;

procedure TcbsModule.LoadFormTypes;
type
  TGetFormTypes = function: IFormTypes; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
begin
  var GetFormTypes: TGetFormTypes;
  @GetFormTypes := GetProcAddress(FHandle, 'GetFormTypes');
  if Assigned(@GetFormTypes) then
  begin
    FFormTypeList.AddRange(GetFormTypes());
  end;
end;

procedure TcbsModule.LoadModule(const AFileName: TFileName);
begin
  FHandle := LoadPackage(AFileName);
  if FHandle = 0 then
  begin
    raise Exception.CreateFmt('Error loading module "%s".', [AFileName]);
  end;
end;

procedure TcbsModule.LoadModuleTypes;
type
  TGetModuleTypes = function: IModuleTypes; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
begin
  var GetModuleTypes: TGetModuleTypes;
  @GetModuleTypes := GetProcAddress(FHandle, 'GetModuleTypes');
  if Assigned(@GetModuleTypes) then
  begin
    FModuleTypeList.AddRange(GetModuleTypes());
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
