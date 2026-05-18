unit Domain.Inf.Repositories.AccessRepository;

interface

uses
{PROJECT}
  Domain.Inf.Contracts.Repositories.AccessRepository,
  Domain.Inf.Entities,
  Shared.Inf.Repositories.Repository;

type
  TAccessRepository = class(TRepository<TAccessEntity>, IAccessRepository)
  public
    function Find(const ADomainName: string; const AUserName: string): TAccessEntity;
  end;

implementation

{ TAccessRepository }

function TAccessRepository.Find(const ADomainName: string; const AUserName: string): TAccessEntity;
begin
  Result := Session.SingleOrDefault<TAccessEntity>(
    'SELECT A.* ' +
    'FROM [domain].[accesses] A ' +
    'INNER JOIN [domain].[domains] D ' +
    ' ON D.Id = A.DomainId ' +
    'INNER JOIN [identity].[users] U ' +
    ' ON U.Id = A.UserId ' +
    'WHERE D.Name = :0 ' +
    'AND U.Name = :1 ',
    [ADomainName, AUserName]
  );
end;

initialization
begin
  RegisterRepository(IAccessRepository, TAccessRepository);
end;

end.
