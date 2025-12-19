unit cbsSystem.Reflection;

interface

uses
{IDE}
  System.Rtti,
  System.TypInfo,
  System.SysUtils;

type
  TObjectHelper = class Helper for TObject
  public
    class function GetMethod(const AName: string): TRttiMethod; inline;
    class function GetMethods(const AName: string): TArray<TRttiMethod>; inline;
    class function GetType: TRttiType; inline;
    class function TryGetMethod(const AName: string; out AMethod: TRttiMethod): Boolean;
    class function TryGetType(out AType: TRttiType): Boolean; inline;
    function CreateObject(const AClassType: TClass): TValue; overload;
    function CreateObject(const AClassType: TClass; const AParams: array of TValue): TValue; overload;
    function CreateObject<T: class>(const AParams: array of TValue): T; overload;
    function GetGenericArguments: TArray<TRttiType>;
  end;

  TRttiMethodHelper = class Helper for TRttiMethod
  strict private
    function GetParameterCount: Integer;
  public
    property ParameterCount: Integer read GetParameterCount;
  end;

  TRttiTypeHelper = class Helper for TRttiType
  strict private
    function GetIsInterface: Boolean;
    function GetMetaclassType: TClass;
  public
    function AsGuid: TGUID;
    function GetGenericArguments: TArray<TRttiType>;
    function TryGetMethod(const AName: string; out AMethod: TRttiMethod): Boolean; overload;
    property IsInterface: Boolean read GetIsInterface;
    property MetaclassType: TClass read GetMetaclassType;
  end;

  TValueHelper = record Helper for TValue
  public
    class function AsValue(const ABuffer: Pointer; const AType: PTypeInfo): TValue; overload; static; inline;
    class function AsValue<T>(const Value: T): TValue; overload; static; inline;
    function AsGuid: TGUID;
    function IsInterface: Boolean;
  end;

  function BeginContext: TRttiContext;
  function GetInterfaceTypeInfoByGUID(const AGUID: TGUID): PTypeInfo;
  procedure EndContext(const AValue: TRttiContext);

implementation

uses
{IDE}
  System.StrUtils;

var
  InternalContextCount: Integer = 0;

function BeginContext: TRttiContext;
begin
  Result := TRttiContext.Create;
  Inc(InternalContextCount);
end;

function ExtractGenericArguments(ATypeInfo: PTypeInfo): string;
begin
  var LName := UTF8ToString(ATypeInfo.Name);
  var LIndex := Pos('<', LName);
  if LIndex > 0 then
  begin
    Exit(Copy(LName, Succ(LIndex), Length(LName) - Succ(LIndex)));
  end;
  Result := '';
end;

function FindType(const AName: string; out AType: TRttiType): Boolean;
begin
  var LContext := TRttiContext.Create;
  try
    AType := LContext.FindType(AName);
    Result := Assigned(AType);
    if not Result then
    begin
      for var LType in LContext.GetTypes do if
        AnsiSameText(LType.Name, AName) then
      begin
        AType := LType;
        Exit(True);
      end;
    end;
  finally
    LContext.Free;
  end;
end;

function GetInterfaceTypeInfoByGUID(const AGUID : TGUID) : PTypeInfo;
begin
  var LContext := TRttiContext.Create;
  try
    for var LItemType in LContext.GetTypes do if
      (LItemType is TRTTIInterfaceType) and
      IsEqualGUID(TRTTIInterfaceType(LItemType).GUID, AGUID) then
    begin
      Exit(TRTTIInterfaceType(LItemType).Handle);
    end;
    Result := nil;
  finally
    LContext.Free;
  end;
end;

procedure EndContext(const AValue: TRttiContext);
begin
  Dec(InternalContextCount);
  if 0 <= InternalContextCount then
  begin
    AValue.Free;
  end;
end;

{ TObjectHelper }

function TObjectHelper.CreateObject(const AClassType: TClass): TValue;
begin
  Result := CreateObject(AClassType, []);
end;

function TObjectHelper.CreateObject(const AClassType: TClass; const AParams: array of TValue): TValue;
begin
  var LContext := TRttiContext.Create;
  try
    for var LMethod in LContext.GetType(AClassType).GetMethods do if
      LMethod.IsConstructor and (LMethod.ParameterCount = Length(AParams)) then
    begin
      Exit(LMethod.Invoke(AClassType, AParams));
    end;
    Result := nil;
  finally
    LContext.Free;
  end;
end;

function TObjectHelper.CreateObject<T>(const AParams: array of TValue): T;
begin
  Result := CreateObject(TypeInfo(T), AParams).AsType<T>;
end;

function TObjectHelper.GetGenericArguments: TArray<TRttiType>;
var
  LType: TRttiType;
begin
  if TryGetType(LType) then
  begin
    Exit(LType.GetGenericArguments);
  end;
  Result := nil;
end;

class function TObjectHelper.GetMethod(const AName: string): TRttiMethod;
var
  LType: TRttiType;
begin
  if TryGetType(LType) then
  begin
    Exit(LType.GetMethod(AName));
  end;
  Result := nil;
end;

class function TObjectHelper.GetMethods(const AName: string): TArray<TRttiMethod>;
var
  LType: TRttiType;
begin
  if TryGetType(LType) then
  begin
    Exit(LType.GetMethods(AName));
  end;
  Result := [];
end;

class function TObjectHelper.GetType: TRttiType;
begin
  TryGetType(Result);
end;

class function TObjectHelper.TryGetMethod(const AName: string; out AMethod: TRttiMethod): Boolean;
begin
  AMethod := GetMethod(AName);
  Result := Assigned(AMethod);
end;

class function TObjectHelper.TryGetType(out AType: TRttiType): Boolean;
begin
  if not Assigned(Self) then
  begin
    Exit(False);
  end;
  var LContext := TRttiContext.Create;
  try
    AType := LContext.GetType(Self.ClassInfo);
    Result := Assigned(AType);
  finally
    LContext.Free;
  end;
end;

{ TRttiMethodHelper }

function TRttiMethodHelper.GetParameterCount: Integer;
begin
  Result := Length(GetParameters);
end;

{ TRttiTypeHelper }

function TRttiTypeHelper.AsGuid: TGUID;
begin
  Result := TRttiInterfaceType(Self).GUID;
end;

function TRttiTypeHelper.GetGenericArguments: TArray<TRttiType>;
begin
  var LParams := SplitString(ExtractGenericArguments(Handle), ',');
  if 0 < Length(LParams) then
  begin
    SetLength(Result, Length(LParams));
    for var LIndex := 0 to Pred(Length(LParams)) do
    begin
      FindType(LParams[LIndex], Result[LIndex]);
    end;
  end
  else if Assigned(BaseType) then
  begin
    Result := BaseType.GetGenericArguments;
  end;
end;

function TRttiTypeHelper.GetIsInterface: Boolean;
begin
    Result := Self is TRttiInterfaceType;
end;

function TRttiTypeHelper.GetMetaclassType: TClass;
begin
  Result := AsInstance.MetaclassType;
end;

function TRttiTypeHelper.TryGetMethod(const AName: string; out AMethod: TRttiMethod): Boolean;
begin
  AMethod := GetMethod(AName);
  Result := Assigned(AMethod);
end;

{ TValueHelper }

function TValueHelper.AsGuid: TGUID;
begin
  var LContext := TRttiContext.Create;
  try
    Result := LContext.GetType(Self.TypeInfo).AsGuid;
  finally
    LContext.Free;
  end;
end;

function TValueHelper.IsInterface: Boolean;
begin
  Result := Assigned(TypeInfo) and (TypeInfo.Kind = tkInterface);
end;

class function TValueHelper.AsValue(const ABuffer: Pointer; const AType: PTypeInfo): TValue;
begin
  Make(ABuffer, AType, Result);
end;

class function TValueHelper.AsValue<T>(const Value: T): TValue;
begin
  Make<T>(Value, Result);
end;

end.
