unit Identity.UI.Data.Modules.LoginDomainsModule;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule,
  Domain.Inf.Contracts.Repositories.AccessRepository,
  Domain.Inf.Contracts.Repositories.DomainRepository,
{IDE}
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdamLoginDomains = class(TdamBase)
    mtbDOM: TFDMemTable;
    mtbDOMId: TGuidField;
    mtbDOMName: TWideStringField;
    mtbDOMParentId: TGuidField;
    procedure DataModuleCreate(Sender: TObject);
  private
    FAccessRepository: IAccessRepository;
    FDomainRepository: IDomainRepository;
    function GetExistsRegisteredDomain: Boolean;
    procedure Refresh;
  public
    function ExistsAccess(const ADomainName: string; const AUserName: string): Boolean;
    function ExistsDomain(const ADomainName: string): Boolean;
    procedure CreateDomain(const ADomainName: string; const AParentId: TGuid);
    property ExistsRegisteredDomain: Boolean read GetExistsRegisteredDomain;
  end;

  function damLoginDomains: TdamLoginDomains;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses
  System.SysUtils,
{PROJECT}
  cbsSystem.Contracts.DatabaseConfig,
  cbsSystem.Support.Container,
  Domain.Inf.Entities,
  Shared.UI.Data.Modules.MainModule;

{$R *.dfm}

function damLoginDomains: TdamLoginDomains;
begin
  Result := TdamLoginDomains(damMain.GetModuleInstance(TdamLoginDomains));
end;

{ TdamLoginDomains }

function TdamLoginDomains.ExistsAccess(const ADomainName: string; const AUserName: string): Boolean;
begin
  var LEntity := FAccessRepository.Find(ADomainName, AUserName);
  Result := Assigned(LEntity);
  if Result then
    LEntity.Free;
end;

function TdamLoginDomains.ExistsDomain(const ADomainName: string): Boolean;
begin
  var LEntity := FDomainRepository.Find(ADomainName);
  Result := Assigned(LEntity);
  if Result then
    LEntity.Free;
end;

function TdamLoginDomains.GetExistsRegisteredDomain: Boolean;
begin
  Refresh;
  Result := not mtbDOM.IsEmpty;
end;

procedure TdamLoginDomains.CreateDomain(const ADomainName: string; const AParentId: TGuid);
begin
  var LEntity := FDomainRepository.Find(ADomainName);
  if not Assigned(LEntity) then
  begin
    LEntity := TDomainEntity.Create;
    LEntity.Name := ADomainName;
    LEntity.Reserved := False;
    if not AParentId.IsEmpty then
      LEntity.ParentId := AParentId;
    FDomainRepository.Insert(LEntity);
    LEntity.Free;
  end;
end;

procedure TdamLoginDomains.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FAccessRepository := App.Make<IAccessRepository>;
  FDomainRepository := App.Make<IDomainRepository>;
  Refresh;
end;

procedure TdamLoginDomains.Refresh;
begin
  mtbDOM.Close;
  if App.Make<IDatabaseConfig>.Exists then
    mtbDOM.CreateAndCopyDataSet(FDomainRepository.GetAll);
end;

initialization
begin
  RegisterModuleType(TdamLoginDomains);
end;

end.
