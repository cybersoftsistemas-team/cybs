unit Address.Inf.Contracts.Repositories.NeighborhoodRepository;

interface

uses
{PROJECT}
  Address.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  INeighborhoodRepository = interface(IRepository<TNeighborhoodEntity>)
    ['{0B59B475-CDBB-449A-97F0-6C097FF6BE8E}']
    function Find(const AId: TGuid): TNeighborhoodEntity; overload;
    function FindByCityId(const ACityId: TGuid): IList<TNeighborhoodEntity>;
  end;

implementation

end.


