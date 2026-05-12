unit Country.Inf.Contracts.Repositories.NationalityRepository;

interface

uses
{PROJECT}
  Country.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository;

type
  INationalityRepository = interface(IRepository<TNationalityEntity>)
    ['{A25377C1-259C-4A07-868E-82EEFE4E8396}']
    function Find(const AId: TGuid): TNationalityEntity; overload;
    function Find(const AName: string): TNationalityEntity; overload;
  end;

implementation

end.
