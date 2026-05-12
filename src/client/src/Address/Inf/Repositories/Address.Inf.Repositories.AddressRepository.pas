unit Address.Inf.Repositories.AddressRepository;

interface

uses
{PROJECT}
  Address.Inf.Contracts.Repositories.AddressRepository,
  Address.Inf.Entities,
  Shared.Inf.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  TAddressRepository = class(TRepository<TAddressEntity>, IAddressRepository)
  public
    function Find(const AId: TGuid): TAddressEntity; overload;
    function Find(const AZipCode: string): IList<TAddressEntity>; overload;
  end;

implementation

{ TAddressRepository }

function TAddressRepository.Find(const AId: TGuid): TAddressEntity;
begin
  Result := inherited Find(AId);
end;

function TAddressRepository.Find(const AZipCode: string): IList<TAddressEntity>;
begin
  Result := ICriteria.Add(Restrictions.Eq('ZipCode', AZipCode)).ToList;
end;

initialization
begin
  RegisterRepository(IAddressRepository, TAddressRepository);
end;

end.



