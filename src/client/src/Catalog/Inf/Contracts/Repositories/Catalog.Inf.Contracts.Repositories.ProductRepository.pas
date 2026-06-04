unit Catalog.Inf.Contracts.Repositories.ProductRepository;

interface

uses
{PROJECT}
  Catalog.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository;

type
  IProductRepository = interface(IRepository<TProductEntity>)
    ['{B92D8466-0C4F-49B8-B11E-D0B99F9F9B44}']
    function Find(const AId: TGuid): TProductEntity; overload;
    function Find(const ACode: string): TProductEntity; overload;
  end;

implementation

end.
