unit Identity.Inf.Contracts.Repositories.OptionRepository;

interface

uses
{PROJECT}
  Identity.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository;

type
  IOptionRepository = interface(IRepository<TOptionEntity>)
    ['{75B0B03F-2206-456E-BE8C-87DF9BC9037E}']
    function Find(const AId: TGuid): TOptionEntity;
  end;

implementation

end.
