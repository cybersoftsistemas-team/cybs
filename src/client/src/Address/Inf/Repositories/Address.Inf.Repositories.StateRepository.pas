unit Address.Inf.Repositories.StateRepository;

interface

uses
{PROJECT}
  Address.Inf.Contracts.Repositories.StateRepository,
  Address.Inf.Entities,
  Shared.Inf.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  TStateRepository = class(TRepository<TStateEntity>, IStateRepository)
  public
    function Find(const AId: TGuid): TStateEntity; overload;
    function FindByCountryId(const ACountryId: TGuid): IList<TStateEntity>;
  end;

implementation

{ TStateRepository }

function TStateRepository.Find(const AId: TGuid): TStateEntity;
begin
  Result := inherited Find(AId);
end;

function TStateRepository.FindByCountryId(const ACountryId: TGuid): IList<TStateEntity>;
begin
  Result := ICriteria.Add(Restrictions.Eq('CountryId', ToValue(ACountryId))).ToList;
end;

initialization
begin
  RegisterRepository(IStateRepository, TStateRepository);
end;

end.



