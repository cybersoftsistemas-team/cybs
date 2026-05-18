unit Domain.Inf.Contracts.Repositories.AccessRepository;

interface

uses
{PROJECT}
  Domain.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository;

type
  IAccessRepository = interface(IRepository<TAccessEntity>)
    ['{9CAFCCF9-1B54-4A0A-8C06-74F7AC6BFC2C}']
    function Find(const ADomainName: string; const AUserName: string): TAccessEntity;
  end;

implementation

end.
