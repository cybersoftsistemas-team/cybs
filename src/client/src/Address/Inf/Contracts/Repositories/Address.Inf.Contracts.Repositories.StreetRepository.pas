unit Address.Inf.Contracts.Repositories.StreetRepository;

interface

uses
{PROJECT}
  Address.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository;

type
  IStreetRepository = interface(IRepository<TStreetEntity>)
    ['{03D5C3AF-BDE6-459D-9010-B83C050E9655}']
    function Find(const AId: TGuid): TStreetEntity; overload;
    function Find(const AName: string): TStreetEntity; overload;
  end;

implementation

end.


