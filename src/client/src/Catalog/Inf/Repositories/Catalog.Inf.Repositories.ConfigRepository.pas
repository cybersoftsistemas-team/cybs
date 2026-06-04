unit Catalog.Inf.Repositories.ConfigRepository;

interface

uses
{PROJECT}
  Catalog.Inf.Contracts.Repositories.ConfigRepository,
  Catalog.Inf.Entities,
  Shared.Inf.Repositories.Repository;

type
  TConfigRepository = class(TRepository<TConfigEntity>, IConfigRepository)
  public
    function GetConfig: TConfigEntity;
  end;

implementation

{ TConfigRepository }

function TConfigRepository.GetConfig: TConfigEntity;
begin
  Result := FirstOrDefault(ICriteria.Add(Restrictions.Eq('Id', 1)));
  if not Assigned(Result) then
  begin
    Result := TConfigEntity.Create;
    Result.Id := 1;
    Session.Insert(Result);
    Result := GetConfig;
  end;
end;

initialization
begin
  RegisterRepository(IConfigRepository, TConfigRepository);
end;

end.
