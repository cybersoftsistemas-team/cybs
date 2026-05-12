unit Address.Inf.Contracts.Repositories.StateRepository;

interface

uses
{PROJECT}
  Address.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  IStateRepository = interface(IRepository<TStateEntity>)
    ['{3829A521-EDFF-4A67-8C50-47328290D951}']
    function Find(const AId: TGuid): TStateEntity; overload;
    function FindByCountryId(const ACountryId: TGuid): IList<TStateEntity>;
  end;

implementation

end.


