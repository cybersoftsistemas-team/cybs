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
  System.Generics.Collections,
{PROJECT}
  cbsSystem.Contracts.Module;

function DetectCircularDependencies(const AModules: IcbsModuleManager): TCycleInfo;
var
  LInfo: TCycleInfo;
  LStack: TList<string>;
  LState: TDictionary<string, Integer>;
  LNameMap: TDictionary<string, IcbsModule>;

  function DFS(const AModuleName: string): Boolean;
  begin
    if LState[AModuleName] = 1 then
    begin
      var Arr: TArray<string>;
      var idx := LStack.IndexOf(AModuleName);
      SetLength(Arr, LStack.Count - idx);
      for var I := idx to LStack.Count - 1 do
      begin
        Arr[I - idx] := LStack[I];
      end;
      LInfo.HasCycle := True;
      LInfo.Path := Arr;
      Exit(True);
    end;
    if LState[AModuleName] = 2 then
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
  LStack := TList<string>.Create;
  LState := TDictionary<string, Integer>.Create;
  LNameMap := TDictionary<string, IcbsModule>.Create;
  try
    LInfo.HasCycle := False;
    SetLength(LInfo.Path, 0);
    for LModule in AModules do
    begin
      LNameMap.AddOrSetValue(LModule.Name, LModule);
    end;
    for LModule in AModules do
    begin
      LState.AddOrSetValue(LModule.Name, 0);
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
    LState.Free;
    LStack.Free;
    LNameMap.Free;
  end;
  Result := LInfo;
end;

end.
