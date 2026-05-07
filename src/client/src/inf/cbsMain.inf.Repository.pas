unit cbsMain.inf.Repository;

interface

uses
{IDE}
  System.Rtti,
{PROJECT}
  cbsMain.dom.Contracts.Repository,
  cbsMain.inf.Entity,
{SPRING}
  Spring.Collections,
  Spring.Persistence.Core.Session,
  Spring.Persistence.Criteria.Interfaces;

type
  TRepository<TEntity: cbsMain.inf.Entity.TEntity, constructor> = class(TInterfacedObject, IRepository<TEntity>)
  private
    FSession: TSession;
    function GetCriteria: ICriteria<TEntity>;
  protected
    function FirstOrDefault(const AList: IList<TEntity>): TEntity;
    function ToValue(const AGuid: TGuid): TValue;
    property ICriteria: Spring.Persistence.Criteria.Interfaces.ICriteria<TEntity> read GetCriteria;
    property Session: TSession read FSession;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Save(const AEntity: TEntity);
  end;

implementation

uses
{PROJECT}
  cbsSystem.Support.ServerModule;

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

function TRepository<TEntity>.FirstOrDefault(const AList: IList<TEntity>): TEntity;
begin
  if not AList.IsEmpty then
  begin
    var LEntity := AList.First;
    Exit(AList.Extract(LEntity));
  end;
  Result := nil;
end;

function TRepository<TEntity>.GetCriteria: ICriteria<TEntity>;
begin
  Result := FSession.CreateCriteria<TEntity>;
end;

procedure TRepository<TEntity>.Save(const AEntity: TEntity);
begin
  FSession.Save(AEntity);
end;

function TRepository<TEntity>.ToValue(const AGuid: TGuid): TValue;
begin
  Result := TValue.From(AGuid);
end;

end.
