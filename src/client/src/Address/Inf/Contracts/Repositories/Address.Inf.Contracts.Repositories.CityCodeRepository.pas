unit Address.Inf.Contracts.Repositories.CityCodeRepository;

interface

uses
{PROJECT}
  Address.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  ICityCodeRepository = interface(IRepository<TCityCodeEntity>)
    ['{F831BA45-095D-459B-BC40-72CBA2AE722E}']
    function Find(const ACodeType: string; const ACode: string): TCityCodeEntity; overload;
    function Find(const ACodeType: string; const ACityId: TGuid): TCityCodeEntity; overload;
    function FindByCityId(const ACityId: TGuid): IList<TCityCodeEntity>;
  end;

implementation

end.


