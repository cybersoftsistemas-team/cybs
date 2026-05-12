unit Address.Inf.Contracts.Repositories.CityRepository;

interface

uses
{PROJECT}
  Address.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  ICityRepository = interface(IRepository<TCityEntity>)
    ['{CE37E470-7711-4997-8840-3EC697AF573D}']
    function Find(const AId: TGuid): TCityEntity;
    function FindByStateId(const AStateId: TGuid): IList<TCityEntity>;
  end;

implementation

end.


