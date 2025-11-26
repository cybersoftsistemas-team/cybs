unit cbsServer.Support.Form;

interface

uses
{PROJECT}
  cbsServer.Form.BaseForm;

  procedure RegisterFormClass(const AFormClass: TcbsFormClass);

implementation

uses
{PROJECT}
  cbsServer.Contracts.Form.Registered,
  cbsServer.Form.Registered;

var
  GFormRegistered: IcbsFormRegistered;

function GetFormRegistered: TArray<TcbsFormClass>; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; export;
begin
  Result := GFormRegistered.ToArray;
end;

procedure RegisterFormClass(const AFormClass: TcbsFormClass);
begin
  GFormRegistered.Add(AFormClass);
end;

exports
  GetFormRegistered;

initialization
begin
  GFormRegistered := TcbsFormRegistered.Create;
end;

finalization
begin
  GFormRegistered := nil;
end;

end.
