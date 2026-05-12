unit Address.Inf.Repositories.CityRepository;

interface

uses
{PROJECT}
  Address.Inf.Contracts.Repositories.CityRepository,
  Address.Inf.Entities,
  Shared.Inf.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  TCityRepository = class(TRepository<TCityEntity>, ICityRepository)
  public
    function Find(const AId: TGuid): TCityEntity;
    function FindByStateId(const AStateId: TGuid): IList<TCityEntity>;
  end;

implementation

{ TCityRepository }

function TCityRepository.Find(const AId: TGuid): TCityEntity;
begin
  Result := inherited Find(AId);
end;

function TCityRepository.FindByStateId(const AStateId: TGuid): IList<TCityEntity>;
begin
  Result := ICriteria.Add(Restrictions.Eq('StateId', ToValue(AStateId))).ToList;
end;

initialization
begin
  RegisterRepository(ICityRepository, TCityRepository);
end;

end.



