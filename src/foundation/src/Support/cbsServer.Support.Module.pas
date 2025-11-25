unit cbsServer.Support.Module;

interface

uses
{PROJECT}
  cbsServer.Cybersoft.BaseModule;

  procedure RegisterModuleClass(const AModuleClass: TcbsModuleClass);

implementation

uses
{PROJECT}
  cbsServer.Contracts.Registered.Modules,
  cbsServer.Registered.Modules;

var
  GRegisteredModules: IcbsRegisteredModules;

function GetRegisteredModules: TArray<TcbsModuleClass>; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; export;
begin
  Result := GRegisteredModules.ToArray;
end;

procedure RegisterModuleClass(const AModuleClass: TcbsModuleClass);
begin
  GRegisteredModules.Add(AModuleClass);
end;

exports
  GetRegisteredModules;

initialization
begin
  GRegisteredModules := TcbsRegisteredModules.Create;
end;

finalization
begin
  GRegisteredModules := nil;
end;

end.
