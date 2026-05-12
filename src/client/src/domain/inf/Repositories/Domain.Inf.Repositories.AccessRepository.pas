unit Domain.Inf.Repositories.AccessRepository;

interface

uses
{PROJECT}
  Domain.Inf.Contracts.Repositories.AccessRepository,
  Domain.Inf.Entities,
  Shared.Inf.Repositories.Repository;

type
  TAccessRepository = class(TRepository<TAccessEntity>, IAccessRepository)
  public
    function Find(const ADomainId: TGuid; const AUserId: TGuid): TAccessEntity;
  end;

implementation

{ TAccessRepository }

function TAccessRepository.Find(const ADomainId, AUserId: TGuid): TAccessEntity;
begin
  Result := FirstOrDefault(ICriteria.Add(Restrictions.Eq('DomainId', ToValue(ADomainId))).Add(Restrictions.Eq('UserId', ToValue(AUserId))));
end;

initialization
begin
  RegisterRepository(IAccessRepository, TAccessRepository);
end;

end.
