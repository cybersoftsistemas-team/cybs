unit cbsUAuth.inf.Identity.Contracts.Repositories.IdentityConfigRepository;

interface

uses
{PROJECT}
  cbsMain.dom.Contracts.Repository,
  cbsUAuth.inf.Identity.Entities;

type
  IIdentityConfigRepository = interface(IRepository<TIdentityConfigEntity>)
    ['{FC25CDE5-D2D0-4529-8BFD-1970CAEC9357}']
    function GetConfig: TIdentityConfigEntity;
  end;

implementation

end.
