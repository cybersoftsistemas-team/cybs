unit Telecom.Inf.Contracts.Repositories.AreaCodeRepository;

interface

uses
{PROJECT}
  Shared.Inf.Contracts.Repositories.Repository,
  Telecom.Inf.Entities,
{SPRING}
  Spring.Collections;

type
  IAreaCodeRepository = interface(IRepository<TAreaCodeEntity>)
    ['{A4F93EE6-1602-4377-B42A-B353E4B8E908}']
    function Find(const AId: TGuid): TAreaCodeEntity; overload;
    function Find(const AAreaCode: string; const AStateId: TGuid): TAreaCodeEntity; overload;
    function FindByStateId(const AStateId: TGuid): IList<TAreaCodeEntity>;
  end;

implementation

end.
