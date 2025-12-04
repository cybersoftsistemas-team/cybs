unit cbsSystem.Module;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Contracts.Module,
  cbsSystem.Form.BaseForm,
  cbsSystem.Module.BaseModule;

type
  TcbsModule = class(TInterfacedObject, IcbsModule)
  strict private
    type
      TGetFormRegistered = function: TArray<TcbsFormClass>; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
      TGetModuleRegistered = function: TArray<TdamBaseClass>; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  private
    FDataModuleList: IDataModuleList;
    FFormTypeList: IFormTypeList;
    FHandle: HMODULE;
    FName: string;
    FRequiredList: IRequiredList;
    function GetDataModuleTypes: IDataModuleTypes;
    function GetFormTypes: IFormTypes;
    function GetHandle: HMODULE;
    function GetName: string;
    function GetRequires: IRequires;
    procedure LoadFormRegistered;
    procedure LoadModule(const AFileName: TFileName);
    procedure LoadModuleRegistered;
    procedure ReadRequires(const AHandle: HMODULE);
    procedure SetModuleName(const AFileName: TFileName);
  public
    constructor Create(const AFileName: TFileName);
    destructor Destroy; override;
    property DataModuleTypes: IDataModuleTypes read GetDataModuleTypes;
    property FormTypes: IFormTypes read GetFormTypes;
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
  FDataModuleList := CreateDataModuleList;
  FFormTypeList := CreateFormTypeList;
  FRequiredList := CreateRequiredList;
  SetModuleName(AFileName);
  LoadModule(AFileName);
  LoadFormRegistered;
  LoadModuleRegistered;
  ReadRequires(FHandle);
end;

destructor TcbsModule.Destroy;
begin
  FDataModuleList.Clear;
  FFormTypeList.Clear;
  FRequiredList.Clear;
  FDataModuleList := nil;
  FFormTypeList := nil;
  FRequiredList := nil;
  if FHandle <> 0 then
  begin
    UnloadPackage(FHandle);
  end;
  inherited;
end;

function TcbsModule.GetDataModuleTypes: IDataModuleTypes;
begin
  Result := FDataModuleList;
end;

function TcbsModule.GetFormTypes: IFormTypes;
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

procedure TcbsModule.LoadFormRegistered;
begin
  var GetFormRegistered: TGetFormRegistered;
  @GetFormRegistered := GetProcAddress(FHandle, 'GetFormRegistered');
  if Assigned(@GetFormRegistered) then
  begin
    FFormTypeList.AddRange(GetFormRegistered());
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

procedure TcbsModule.LoadModuleRegistered;
begin
  var GetModuleRegistered: TGetModuleRegistered;
  @GetModuleRegistered := GetProcAddress(FHandle, 'GetModuleRegistered');
  if Assigned(@GetModuleRegistered) then
  begin
    FDataModuleList.AddRange(GetModuleRegistered());
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
