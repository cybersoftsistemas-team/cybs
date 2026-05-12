unit Address.Inf.Contracts.Repositories.AddressRepository;

interface

uses
{PROJECT}
  Address.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  IAddressRepository = interface(IRepository<TAddressEntity>)
    ['{F97A0E18-432D-40BF-954E-D81451560C29}']
    function Find(const AId: TGuid): TAddressEntity; overload;
    function Find(const AZipCode: string): IList<TAddressEntity>; overload;
  end;

implementation

end.


