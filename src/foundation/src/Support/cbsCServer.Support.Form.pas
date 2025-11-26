unit cbsCServer.Support.Form;

interface

uses
{PROJECT}
  cbsCServer.Form.BaseForm;

  function GetFormRegistered: TArray<TcbsFormClass>; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; export;
  procedure RegisterFormClass(const AFormClass: TcbsFormClass);

implementation

uses
{PROJECT}
  cbsCServer.Contracts.Form.Registered,
  cbsCServer.Form.Registered;

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
