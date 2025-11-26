unit cbsCServer.Support.Module;

interface

uses
{PROJECT}
  cbsCServer.Module.BaseModule;

  function GetModuleRegistered: TArray<TdamBaseClass>; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; export;
  procedure RegisterModuleClass(const AModuleClass: TdamBaseClass);

implementation

uses
{PROJECT}
  cbsCServer.Contracts.Module.Registered,
  cbsCServer.Module.Registered;

var
  GModuleRegistered: IcbsModuleRegistered;

function GetModuleRegistered: TArray<TdamBaseClass>;
begin
  Result := GModuleRegistered.ToArray;
end;

procedure RegisterModuleClass(const AModuleClass: TdamBaseClass);
begin
  GModuleRegistered.Add(AModuleClass);
end;

initialization
begin
  GModuleRegistered := TcbsModuleRegistered.Create;
end;

finalization
begin
  GModuleRegistered := nil;
end;

end.
