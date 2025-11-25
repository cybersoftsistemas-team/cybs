unit cbsServer.Support.Form;

interface

uses
{PROJECT}
  cbsServer.Cybersoft.BaseForm;

  procedure RegisterFormClass(const AFormClass: TcbsFormClass);

implementation

uses
{PROJECT}
  cbsServer.Contracts.Registered.Forms,
  cbsServer.Registered.Forms;

var
  GRegisteredForms: IcbsRegisteredForms;

function GetRegisteredForms: TArray<TcbsFormClass>; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; export;
begin
  Result := GRegisteredForms.ToArray;
end;

procedure RegisterFormClass(const AFormClass: TcbsFormClass);
begin
  GRegisteredForms.Add(AFormClass);
end;

exports
  GetRegisteredForms;

initialization
begin
  GRegisteredForms := TcbsRegisteredForms.Create;
end;

finalization
begin
  GRegisteredForms := nil;
end;

end.
