unit Address.Inf.Contracts.Repositories.StreetTypeRepository;

interface

uses
{PROJECT}
  Address.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository;

type
  IStreetTypeRepository = interface(IRepository<TStreetTypeEntity>)
    ['{26A1C0ED-C344-4868-BB7A-ACAE57EFA295}']
    function Find(const AId: TGuid): TStreetTypeEntity; overload;
    function Find(const AName: string): TStreetTypeEntity; overload;
  end;

implementation

end.


