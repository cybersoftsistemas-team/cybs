unit Domain.Inf.Contracts.Repositories.DomainRepository;

interface

uses
{PROJECT}
  Domain.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  IDomainRepository = interface(IRepository<TDomainEntity>)
    ['{943A96EE-DFBF-45FC-8E9B-C52490A6BFE6}']
    function Find(const AId: TGuid): TDomainEntity; overload;
    function Find(const AName: string): TDomainEntity; overload;
    function FindAll: IList<TDomainEntity>;
  end;

implementation

end.
