unit cbsSystem.Support.RegisterContainer;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Container.RegisterContainer;

  function Container: IRegisterContainer;

implementation

uses
{PROJECT}
  cbsSystem.Container.RegisterContainer;

var
  InternalContainer: IRegisterContainer;

function Container: IRegisterContainer;
begin
  Result := InternalContainer;
end;

initialization
begin
  InternalContainer := TRegisterContainer.Create;
end;

finalization
begin
  InternalContainer := nil;
end;

end.
