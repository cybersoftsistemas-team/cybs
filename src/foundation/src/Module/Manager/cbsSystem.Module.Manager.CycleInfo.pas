unit cbsSystem.Module.Manager.CycleInfo;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module.Manager;

type
  TCycleInfo = packed record
    HasCycle: Boolean;
    Path: TArray<string>;
  end;

  function DetectCircularDependencies(const AModules: IcbsModuleManager): TCycleInfo;

implementation

uses
{PROJECT}
  cbsSystem.Contracts.Module,
{SPRING}
  Spring.Collections;

type
  INameMapList = IDictionary<string, IcbsModule>;
  IStackList = IList<string>;
  IStateList = IDictionary<string, Integer>;

function DetectCircularDependencies(const AModules: IcbsModuleManager): TCycleInfo;
var
  LInfo: TCycleInfo;
  LNameMap: INameMapList;
  LStack: IStackList;
  LState: IStateList;

  function DFS(const AModuleName: string): Boolean;
  var
    LStatus: Integer;
  begin
    if not LState.TryGetValue(AModuleName, LStatus) then
    begin
      LStatus := 0;
    end;
    if LStatus = 1 then
    begin
      var LArr: TArray<string>;
      var LIdx := LStack.IndexOf(AModuleName);
      SetLength(LArr, LStack.Count - LIdx);
      for var I := LIdx to LStack.Count - 1 do
      begin
        LArr[I - LIdx] := LStack[I];
      end;
      LInfo.HasCycle := True;
      LInfo.Path := LArr;
      Exit(True);
    end;
    if LStatus = 2 then
    begin
      Exit(False);
    end;
    LState[AModuleName] := 1;
    LStack.Add(AModuleName);
    var LModule: IcbsModule;
    if not LNameMap.TryGetValue(AModuleName, LModule) then
    begin
      LStack.Delete(LStack.Count - 1);
      LState[AModuleName] := 2;
      Exit(False);
    end;
    for var Req in LModule.Requires do if
      DFS(Req) then
    begin
      Exit(True);
    end;
    LState[AModuleName] := 2;
    LStack.Delete(LStack.Count - 1);
    Result := False;
  end;

var
  LModule: IcbsModule;
begin
  LNameMap := TCollections.CreateDictionary<string, IcbsModule>;
  LStack := TCollections.CreateList<string>;
  LState := TCollections.CreateDictionary<string, Integer>;
  try
    LInfo.HasCycle := False;
    SetLength(LInfo.Path, 0);
    for LModule in AModules do
    begin
      LNameMap[LModule.Name] := LModule;
    end;
    for LModule in AModules do
    begin
      LState[LModule.Name] := 0;
    end;
    for LModule in AModules do
    begin
      if LInfo.HasCycle then
      begin
        Break;
      end
      else if LState[LModule.Name] = 0 then
      begin
        DFS(LModule.Name);
      end;
    end;
  finally
    LNameMap := nil;
    LStack := nil;
    LState := nil;
  end;
  Result := LInfo;
end;

end.
