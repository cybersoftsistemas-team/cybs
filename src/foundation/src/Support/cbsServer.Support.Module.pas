unit cbsServer.Support.Module;

interface

uses
{PROJECT}
  cbsServer.Module.BaseModule;

  procedure RegisterModuleClass(const AModuleClass: TcbsModuleClass);

implementation

uses
{PROJECT}
  cbsServer.Contracts.Module.Registered,
  cbsServer.Module.Registered;

var
  GModuleRegistered: IcbsModuleRegistered;

function GetModuleRegistered: TArray<TcbsModuleClass>; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; export;
begin
  Result := GModuleRegistered.ToArray;
end;

procedure RegisterModuleClass(const AModuleClass: TcbsModuleClass);
begin
  GModuleRegistered.Add(AModuleClass);
end;

exports
  GetModuleRegistered;

initialization
begin
  GModuleRegistered := TcbsModuleRegistered.Create;
end;

finalization
begin
  GModuleRegistered := nil;
end;

end.
