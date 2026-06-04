unit Catalog.Inf.Contracts.Repositories.ConfigRepository;

interface

uses
{PROJECT}
  Catalog.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository;

type
  IConfigRepository = interface(IRepository<TConfigEntity>)
    ['{B997FB53-559C-4E62-A7F9-D8308BB2F032}']
    function GetConfig: TConfigEntity;
  end;

implementation

end.
