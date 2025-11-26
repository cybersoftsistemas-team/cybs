unit cbsCServer.Module;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsCServer.Contracts.Module,
  cbsCServer.Form.BaseForm,
  cbsCServer.Module.BaseModule;

type
  TcbsModule = class(TInterfacedObject, IcbsModule)
  strict private
    type
      TGetFormRegistered = function: TArray<TcbsFormClass>; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
      TGetModuleRegistered = function: TArray<TdamBaseClass>; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  strict private
    FDataModuleList: IDataModuleList;
    FFormTypeList: IFormTypeList;
    FHandle: HMODULE;
    function GetHandle: HMODULE;
  public
    constructor Create(const AFileName: TFileName);
    destructor Destroy; override;
    function DataModuleTypes: TArray<TdamBaseClass>;
    function FormTypes: TArray<TcbsFormClass>;
    property Handle: HMODULE read GetHandle;
  end;

implementation

uses
{IDE}
{$IFDEF MSWINDOWS}
  Winapi.Windows
{$ELSEIF Defined(POSIX)}
  Posix.Dlfcn
{$ENDIF};

{ TcbsModule }

constructor TcbsModule.Create(const AFileName: TFileName);
begin
  inherited Create;
  FDataModuleList := CreateDataModuleList;
  FFormTypeList := CreateFormTypeList;
  FHandle := LoadPackage(AFileName);
  if FHandle = 0 then
  begin
    raise Exception.CreateFmt('Error loading module "%s".', [AFileName]);
  end;
  var GetFormRegistered: TGetFormRegistered;
  @GetFormRegistered := GetProcAddress(FHandle, 'GetFormRegistered');
  if Assigned(@GetFormRegistered) then
  begin
    FFormTypeList.AddRange(GetFormRegistered());
  end;
  var GetModuleRegistered: TGetModuleRegistered;
  @GetModuleRegistered := GetProcAddress(FHandle, 'GetModuleRegistered');
  if Assigned(@GetModuleRegistered) then
  begin
    FDataModuleList.AddRange(GetModuleRegistered());
  end;
end;

destructor TcbsModule.Destroy;
begin
  FDataModuleList.Clear;
  FFormTypeList.Clear;
  FDataModuleList := nil;
  FFormTypeList := nil;
  if FHandle <> 0 then
  begin
    UnloadPackage(FHandle);
  end;
  inherited;
end;

function TcbsModule.DataModuleTypes: TArray<TdamBaseClass>;
begin
  Result := FDataModuleList.ToArray;
end;

function TcbsModule.FormTypes: TArray<TcbsFormClass>;
begin
  Result := FFormTypeList.ToArray;
end;

function TcbsModule.GetHandle: HMODULE;
begin
  Result := FHandle;
end;

end.
