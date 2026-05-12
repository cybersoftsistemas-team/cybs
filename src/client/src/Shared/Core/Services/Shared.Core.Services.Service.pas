unit Shared.Core.Services.Service;

interface

uses
{PROJECT}
  Shared.Core.Contracts.Services.Service;

type
  TService = class(TInterfacedObject, IService);

  ServiceType = class of TService;

  procedure RegisterService(const AInterface: TGuid; const AServiceType: ServiceType);

implementation

uses
{PROJECT}
  cbsSystem.Support.Container.RegisterType;

procedure RegisterService(const AInterface: TGuid; const AServiceType: ServiceType);
begin
  BindIf(AInterface, AServiceType);
end;

end.
