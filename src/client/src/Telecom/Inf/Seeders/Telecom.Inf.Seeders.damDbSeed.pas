unit Telecom.Inf.Seeders.damDbSeed;

interface

uses
{PROJTECT}
  cbsSystem.Database.Seeders.DatabaseSeederModule,
  Telecom.Inf.Contracts.Repositories.AreaCodeRepository,
{IDE}
  FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, System.Classes, FireDAC.Stan.Intf, FireDAC.Comp.Script;

type
  TdamTelecomDbSeed = class(TDatabaseSeederModule)
  private
    FAreaCodeRepository: IAreaCodeRepository;

    procedure CreateAreaCode(
      const AAreaCode: string;
      const AStateId: TGuid
    );

  protected
    procedure OnRunSeed; override;
  public

    constructor Create(
      const AAreaCodeRepository: IAreaCodeRepository
    ); reintroduce;

  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{PROJECT}
  Address.Dom.Common.SystemState,
  cbsSystem.Support.Container,
  Telecom.Inf.Entities;

{ TdamDbTelecomSeed }

constructor TdamTelecomDbSeed.Create(
  const AAreaCodeRepository: IAreaCodeRepository
);
begin
  inherited Create(nil);
  FAreaCodeRepository := AAreaCodeRepository;
end;

procedure TdamTelecomDbSeed.CreateAreaCode(
  const AAreaCode: string;
  const AStateId: TGuid
);
begin
  var LEntity := FAreaCodeRepository.Find(AAreaCode, AStateId);
  if not Assigned(LEntity) then
  begin
    LEntity := TAreaCodeEntity.Create;
    LEntity.AreaCode := AAreaCode;
    LEntity.StateId := AStateId;
    FAreaCodeRepository.Insert(LEntity);
  end;
end;

procedure TdamTelecomDbSeed.OnRunSeed;
begin
  // ====================================
  // Região Norte
  // ====================================

  // Acre
  CreateAreaCode('68', TSystemState.AC );

  // Amapá
  CreateAreaCode('96', TSystemState.AP );

  // Amazonas
  CreateAreaCode('92', TSystemState.AM );
  CreateAreaCode('97', TSystemState.AM );

  // Pará
  CreateAreaCode('91', TSystemState.PA );
  CreateAreaCode('93', TSystemState.PA );
  CreateAreaCode('94', TSystemState.PA );

  // Rondônia
  CreateAreaCode('69', TSystemState.RO );

  // Roraima
  CreateAreaCode('95', TSystemState.RR );

  // Tocantins
  CreateAreaCode('63', TSystemState.&TO );

  // ====================================
  // Região Nordeste
  // ====================================

  // Alagoas
  CreateAreaCode('82', TSystemState.AL );

  // Bahia
  CreateAreaCode('71', TSystemState.BA );
  CreateAreaCode('73', TSystemState.BA );
  CreateAreaCode('74', TSystemState.BA );
  CreateAreaCode('75', TSystemState.BA );
  CreateAreaCode('77', TSystemState.BA );

  // Ceará
  CreateAreaCode('85', TSystemState.CE );
  CreateAreaCode('88', TSystemState.CE );

  // Maranhão
  CreateAreaCode('98', TSystemState.MA );
  CreateAreaCode('99', TSystemState.MA );

  // Paraíba
  CreateAreaCode('83', TSystemState.PB );

  // Pernambuco
  CreateAreaCode('81', TSystemState.PE );
  CreateAreaCode('87', TSystemState.PE );

  // Piauí
  CreateAreaCode('86', TSystemState.PI );
  CreateAreaCode('89', TSystemState.PI );

  // Rio Grande do Norte
  CreateAreaCode('84', TSystemState.RN );

  // Sergipe
  CreateAreaCode('79', TSystemState.SE );

  // ====================================
  // Região Centro-Oeste
  // ====================================

  // Distrito Federal
  CreateAreaCode('61', TSystemState.DF );

  // Goiás
  CreateAreaCode('62', TSystemState.GO );
  CreateAreaCode('64', TSystemState.GO );

  // Mato Grosso
  CreateAreaCode('65', TSystemState.MT );
  CreateAreaCode('66', TSystemState.MT );

  // Mato Grosso do Sul
  CreateAreaCode('67', TSystemState.MS );

  // ====================================
  // Região Sudeste
  // ====================================

  // Espírito Santo
  CreateAreaCode('27', TSystemState.ES );
  CreateAreaCode('28', TSystemState.ES );

  // Minas Gerais
  CreateAreaCode('31', TSystemState.MG );
  CreateAreaCode('32', TSystemState.MG );
  CreateAreaCode('33', TSystemState.MG );
  CreateAreaCode('34', TSystemState.MG );
  CreateAreaCode('35', TSystemState.MG );
  CreateAreaCode('37', TSystemState.MG );
  CreateAreaCode('38', TSystemState.MG );

  // Rio de Janeiro
  CreateAreaCode('21', TSystemState.RJ );
  CreateAreaCode('22', TSystemState.RJ );
  CreateAreaCode('24', TSystemState.RJ );

  // São Paulo
  CreateAreaCode('11', TSystemState.SP );
  CreateAreaCode('12', TSystemState.SP );
  CreateAreaCode('13', TSystemState.SP );
  CreateAreaCode('14', TSystemState.SP );
  CreateAreaCode('15', TSystemState.SP );
  CreateAreaCode('16', TSystemState.SP );
  CreateAreaCode('17', TSystemState.SP );
  CreateAreaCode('18', TSystemState.SP );
  CreateAreaCode('19', TSystemState.SP );

  // ====================================
  // Região Sul
  // ====================================

  // Paraná
  CreateAreaCode('41', TSystemState.PR );
  CreateAreaCode('42', TSystemState.PR );
  CreateAreaCode('43', TSystemState.PR );
  CreateAreaCode('44', TSystemState.PR );
  CreateAreaCode('45', TSystemState.PR );
  CreateAreaCode('46', TSystemState.PR );

  // Santa Catarina
  CreateAreaCode('47', TSystemState.SC );
  CreateAreaCode('48', TSystemState.SC );
  CreateAreaCode('49', TSystemState.SC );

  // Rio Grande do Sul
  CreateAreaCode('51', TSystemState.RS );
  CreateAreaCode('53', TSystemState.RS );
  CreateAreaCode('54', TSystemState.RS );
  CreateAreaCode('55', TSystemState.RS );
  inherited;
end;

end.
