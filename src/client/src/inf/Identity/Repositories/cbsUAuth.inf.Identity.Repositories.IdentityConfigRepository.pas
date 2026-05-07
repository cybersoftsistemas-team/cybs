unit cbsUAuth.inf.Identity.Repositories.IdentityConfigRepository;

interface

uses
{PROJECT}
  cbsMain.inf.Repository,
  cbsUAuth.inf.Identity.Contracts.Repositories.IdentityConfigRepository,
  cbsUAuth.inf.Identity.Entities;

type
  TIdentityConfigRepository = class(TRepository<TIdentityConfigEntity>, IIdentityConfigRepository)
  public
    function GetConfig: TIdentityConfigEntity;
  end;

implementation

uses
{SPRING}
  Spring.Persistence.Criteria.Restrictions;

{ TIdentityConfigRepository }

function TIdentityConfigRepository.GetConfig: TIdentityConfigEntity;
begin
  Result := FirstOrDefault(ICriteria.Add(Restrictions.Eq('Id', 1)).ToList);
end;

end.
