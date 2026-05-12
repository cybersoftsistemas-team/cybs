unit Address.Inf.Repositories.NeighborhoodRepository;

interface

uses
{PROJECT}
  Address.Inf.Contracts.Repositories.NeighborhoodRepository,
  Address.Inf.Entities,
  Shared.Inf.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  TNeighborhoodRepository = class(TRepository<TNeighborhoodEntity>, INeighborhoodRepository)
  public
    function Find(const AId: TGuid): TNeighborhoodEntity;
    function FindByCityId(const ACityId: TGuid): IList<TNeighborhoodEntity>;
  end;

implementation

{ TNeighborhoodRepository }

function TNeighborhoodRepository.Find(const AId: TGuid): TNeighborhoodEntity;
begin
  Result := inherited Find(AId);
end;

function TNeighborhoodRepository.FindByCityId(const ACityId: TGuid): IList<TNeighborhoodEntity>;
begin
  Result := ICriteria.Add(Restrictions.Eq('CityId', ToValue(ACityId))).ToList;
end;

initialization
begin
  RegisterRepository(INeighborhoodRepository, TNeighborhoodRepository);
end;

end.



