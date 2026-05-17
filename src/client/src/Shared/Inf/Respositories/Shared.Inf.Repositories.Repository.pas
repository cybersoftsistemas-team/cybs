unit Shared.Inf.Repositories.Repository;

interface

uses
{IDE}
  System.Rtti,
{PROJECT}
  Shared.Inf.Contracts.Repositories.Repository,
  Shared.Inf.Entities.Entity,
{SPRING}
  Spring.Collections,
  Spring.Data.ObjectDataSet,
  Spring.Persistence.Core.Session,
  Spring.Persistence.Criteria.Interfaces,
  Spring.Persistence.Criteria.Properties,
  Spring.Persistence.Criteria.Restrictions;

type
  TObjectDataSet = Spring.Data.ObjectDataSet.TObjectDataSet;
  IProperty = Spring.Persistence.Criteria.Interfaces.IProperty;
  TProperty = Spring.Persistence.Criteria.Properties.TProperty;
  Restrictions = Spring.Persistence.Criteria.Restrictions.Restrictions;

  TRepository = class(TInterfacedObject);
  RepositoryType = class of TRepository;

  TRepository<TEntity: Shared.Inf.Entities.Entity.TEntity, constructor> = class(TRepository, IRepository<TEntity>)
  private
    FSession: TSession;
    function GetCriteria: ICriteria<TEntity>;
  protected
    function CreateObjectDataSet: TObjectDataSet;
    function Find(const AId: TGuid): TEntity; overload;
    function Find(const AName: string): TEntity; overload;
    function FirstOrDefault(const ACriteria: ICriteria<TEntity>): TEntity;
    function ToValue(const AGuid: TGuid): TValue;
    property ICriteria: ICriteria<TEntity> read GetCriteria;
    property Session: TSession read FSession;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Insert(const AEntity: TEntity);
    procedure Save(const AEntity: TEntity);
    procedure Update(const AEntity: TEntity);
  end;

  procedure RegisterRepository(const AInterface: TGuid; const ARepositoryType: RepositoryType);

implementation

uses
{PROJECT}
  cbsSystem.Support.Container.RegisterType,
  cbsSystem.Support.ServerModule,
{SPRING}
  Spring.Persistence.Mapping.Attributes;

procedure RegisterRepository(const AInterface: TGuid; const ARepositoryType: RepositoryType);
begin
  BindIf(AInterface, ARepositoryType);
end;

{ TRepository<TEntity> }

constructor TRepository<TEntity>.Create;
begin
  inherited Create;
  FSession := ServerModule.Database.Persistence.Session;
end;

destructor TRepository<TEntity>.Destroy;
begin
  FSession := nil;
  inherited;
end;

function TRepository<TEntity>.CreateObjectDataSet: TObjectDataSet;
begin
  Result := TObjectDataSet.Create(nil);
  Result.ColumnAttributeClass := ColumnAttribute;
end;

function TRepository<TEntity>.Find(const AId: TGuid): TEntity;
begin
  Result := FSession.FindOne<TEntity>(ToValue(AId));
end;

function TRepository<TEntity>.Find(const AName: string): TEntity;
begin
  Result := FirstOrDefault(ICriteria.Add(Restrictions.Eq('Name', AName)));
end;

function TRepository<TEntity>.FirstOrDefault(const ACriteria: ICriteria<TEntity>): TEntity;
begin
  var List := ACriteria.ToList;
  Result := List.Extract(List.FirstOrDefault);
end;

function TRepository<TEntity>.GetCriteria: ICriteria<TEntity>;
begin
  Result := FSession.CreateCriteria<TEntity>;
end;

procedure TRepository<TEntity>.Insert(const AEntity: TEntity);
begin
  FSession.Insert(AEntity);
end;

procedure TRepository<TEntity>.Save(const AEntity: TEntity);
begin
  FSession.Save(AEntity);
end;

function TRepository<TEntity>.ToValue(const AGuid: TGuid): TValue;
begin
  Result := TValue.From(AGuid);
end;

procedure TRepository<TEntity>.Update(const AEntity: TEntity);
begin
  FSession.Update(AEntity);
end;

end.
