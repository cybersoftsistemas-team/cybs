unit cbsSystem.Support.Form;

interface

uses
{PROJECT}
  cbsSystem.Form.BaseForm;

  function GetFormRegistered: TArray<TcbsFormClass>; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; export;
  procedure RegisterFormClass(const AFormClass: TcbsFormClass);

implementation

uses
{PROJECT}
  cbsSystem.Contracts.Form.Registered,
  cbsSystem.Form.Registered;

var
  GFormRegistered: IcbsFormRegistered;

function GetFormRegistered: TArray<TcbsFormClass>;
begin
  Result := GFormRegistered.ToArray;
end;

procedure RegisterFormClass(const AFormClass: TcbsFormClass);
begin
  GFormRegistered.Add(AFormClass);
end;

initialization
begin
  GFormRegistered := TcbsFormRegistered.Create;
end;

finalization
begin
  GFormRegistered := nil;
end;

end.
