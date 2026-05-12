unit Address.Inf.Seeders.damDbSeed;

interface

uses
{PROJTECT}
  Address.Inf.Contracts.Repositories.StateCodeRepository,
  Address.Inf.Contracts.Repositories.StateRepository,
  cbsSystem.Database.Seeders.DatabaseSeederModule,
{IDE}
  FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, System.Classes, FireDAC.Stan.Intf, FireDAC.Comp.Script;

type
  TdamAddressDbSeed = class(TDatabaseSeederModule)
  private
    FStateCodeRepository: IStateCodeRepository;
    FStateRepository: IStateRepository;

    procedure CreateState(
      const AId: TGuid;
      const AName: string;
      const AAcronym: string;
      const ACountryId: TGuid
    );

    procedure CreateStateCode(
      const ACodeType: string;
      const ACode: string;
      const AStateId: TGuid
    );

  protected
    procedure OnRunSeed; override;
  public

    constructor Create(
      const AStateCodeRepository: IStateCodeRepository;
      const AStateRepository: IStateRepository
    ); reintroduce;

  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
{PROJECT}
  Address.Dom.Common.SystemState,
  Address.Inf.Entities,
  cbsSystem.Support.Container,
  Country.Dom.Common.SystemCountry;

{ TdamAddressDbSeed }

constructor TdamAddressDbSeed.Create(
  const AStateCodeRepository: IStateCodeRepository;
  const AStateRepository: IStateRepository
);
begin
  inherited Create(nil);
  FStateCodeRepository := AStateCodeRepository;
  FStateRepository := AStateRepository;
end;

procedure TdamAddressDbSeed.CreateState(
  const AId: TGuid;
  const AName: string;
  const AAcronym: string;
  const ACountryId: TGuid
);
begin
  var LEntity := FStateRepository.Find(AId);
  if not Assigned(LEntity) then
    LEntity := TStateEntity.Create;
  LEntity.Id := AId;
  LEntity.Name := AName;
  LEntity.Acronym := AAcronym;
  LEntity.CountryId := ACountryId;
  FStateRepository.Save(LEntity);
end;

procedure TdamAddressDbSeed.CreateStateCode(
  const ACodeType, ACode: string;
  const AStateId: TGuid
);
begin
  var LEntity := FStateCodeRepository.Find(ACodeType, ACode);
  if not Assigned(LEntity) then
  begin
    LEntity := TStateCodeEntity.Create;
    LEntity.CodeType := ACodeType;
    LEntity.Code := ACode;
    LEntity.StateId := AStateId;
    FStateCodeRepository.Insert(LEntity);
  end;
end;

procedure TdamAddressDbSeed.OnRunSeed;
begin
  // ==================================================================================
  // States
  // ==================================================================================

  // Brasil
  CreateState(TSystemState.AC, 'Acre'                , 'AC', TSystemCountry.BrazilId );
  CreateState(TSystemState.AL, 'Alagoas'             , 'AL', TSystemCountry.BrazilId );
  CreateState(TSystemState.AP, 'Amapá'               , 'AP', TSystemCountry.BrazilId );
  CreateState(TSystemState.AM, 'Amazonas'            , 'AM', TSystemCountry.BrazilId );
  CreateState(TSystemState.BA, 'Bahia'               , 'BA', TSystemCountry.BrazilId );
  CreateState(TSystemState.CE, 'Ceará'               , 'CE', TSystemCountry.BrazilId );
  CreateState(TSystemState.DF, 'Distrito Federal'    , 'DF', TSystemCountry.BrazilId );
  CreateState(TSystemState.ES, 'Espírito Santo'      , 'ES', TSystemCountry.BrazilId );
  CreateState(TSystemState.GO, 'Goiás'               , 'GO', TSystemCountry.BrazilId );
  CreateState(TSystemState.MA, 'Maranhão'            , 'MA', TSystemCountry.BrazilId );
  CreateState(TSystemState.MT, 'Mato Grosso'         , 'MT', TSystemCountry.BrazilId );
  CreateState(TSystemState.MS, 'Mato Grosso do Sul'  , 'MS', TSystemCountry.BrazilId );
  CreateState(TSystemState.MG, 'Minas Gerais'        , 'MG', TSystemCountry.BrazilId );
  CreateState(TSystemState.PA, 'Pará'                , 'PA', TSystemCountry.BrazilId );
  CreateState(TSystemState.PB, 'Paraíba'             , 'PB', TSystemCountry.BrazilId );
  CreateState(TSystemState.PR, 'Paraná'              , 'PR', TSystemCountry.BrazilId );
  CreateState(TSystemState.PE, 'Pernambuco'          , 'PE', TSystemCountry.BrazilId );
  CreateState(TSystemState.PI, 'Piauí'               , 'PI', TSystemCountry.BrazilId );
  CreateState(TSystemState.RJ, 'Rio de Janeiro'      , 'RJ', TSystemCountry.BrazilId );
  CreateState(TSystemState.RN, 'Rio Grande do Norte' , 'RN', TSystemCountry.BrazilId );
  CreateState(TSystemState.RS, 'Rio Grande do Sul'   , 'RS', TSystemCountry.BrazilId );
  CreateState(TSystemState.RO, 'Rondônia'            , 'RO', TSystemCountry.BrazilId );
  CreateState(TSystemState.RR, 'Roraima'             , 'RR', TSystemCountry.BrazilId );
  CreateState(TSystemState.SC, 'Santa Catarina'      , 'SC', TSystemCountry.BrazilId );
  CreateState(TSystemState.SP, 'São Paulo'           , 'SP', TSystemCountry.BrazilId );
  CreateState(TSystemState.SE, 'Sergipe'             , 'SE', TSystemCountry.BrazilId );
  CreateState(TSystemState.&TO, 'Tocantins'          , 'TO', TSystemCountry.BrazilId );

  // =======================================================
  // State codes
  // =======================================================

  // Acre
  CreateStateCode('IBGE'      , '12'    , TSystemState.AC );
  CreateStateCode('ISO2'      , 'AC'    , TSystemState.AC );
  CreateStateCode('ISO3166-2' , 'BR-AC' , TSystemState.AC );
  // Alagoas
  CreateStateCode('IBGE'      , '27'    , TSystemState.AL );
  CreateStateCode('ISO2'      , 'AL'    , TSystemState.AL );
  CreateStateCode('ISO3166-2' , 'BR-AL' , TSystemState.AL );
  // Amapá
  CreateStateCode('IBGE'      , '16'    , TSystemState.AP );
  CreateStateCode('ISO2'      , 'AP'    , TSystemState.AP );
  CreateStateCode('ISO3166-2' , 'BR-AP' , TSystemState.AP );
  // Amazonas
  CreateStateCode('IBGE'      , '13'    , TSystemState.AM );
  CreateStateCode('ISO2'      , 'AM'    , TSystemState.AM );
  CreateStateCode('ISO3166-2' , 'BR-AM' , TSystemState.AM );
  // Bahia
  CreateStateCode('IBGE'      , '29'    , TSystemState.BA );
  CreateStateCode('ISO2'      , 'BA'    , TSystemState.BA );
  CreateStateCode('ISO3166-2' , 'BR-BA' , TSystemState.BA );
  // Ceará
  CreateStateCode('IBGE'      , '23'    , TSystemState.CE );
  CreateStateCode('ISO2'      , 'CE'    , TSystemState.CE );
  CreateStateCode('ISO3166-2' , 'BR-CE' , TSystemState.CE );
  // Distrito Federal
  CreateStateCode('IBGE'      , '53'    , TSystemState.DF );
  CreateStateCode('ISO2'      , 'DF'    , TSystemState.DF );
  CreateStateCode('ISO3166-2' , 'BR-DF' , TSystemState.DF );
  // Espírito Santo
  CreateStateCode('IBGE'      , '32'    , TSystemState.ES );
  CreateStateCode('ISO2'      , 'ES'    , TSystemState.ES );
  CreateStateCode('ISO3166-2' , 'BR-ES' , TSystemState.ES );
  // Goiás
  CreateStateCode('IBGE'      , '52'    , TSystemState.GO );
  CreateStateCode('ISO2'      , 'GO'    , TSystemState.GO );
  CreateStateCode('ISO3166-2' , 'BR-GO' , TSystemState.GO );
  // Maranhão
  CreateStateCode('IBGE'      , '21'    , TSystemState.MA );
  CreateStateCode('ISO2'      , 'MA'    , TSystemState.MA );
  CreateStateCode('ISO3166-2' , 'BR-MA' , TSystemState.MA );
  // Mato Grosso
  CreateStateCode('IBGE'      , '51'    , TSystemState.MT );
  CreateStateCode('ISO2'      , 'MT'    , TSystemState.MT );
  CreateStateCode('ISO3166-2' , 'BR-MT' , TSystemState.MT );
  // Mato Grosso do Sul
  CreateStateCode('IBGE'      , '50'    , TSystemState.MS );
  CreateStateCode('ISO2'      , 'MS'    , TSystemState.MS );
  CreateStateCode('ISO3166-2' , 'BR-MS' , TSystemState.MS );
  // Minas Gerais
  CreateStateCode('IBGE'      , '31'    , TSystemState.MG );
  CreateStateCode('ISO2'      , 'MG'    , TSystemState.MG );
  CreateStateCode('ISO3166-2' , 'BR-MG' , TSystemState.MG );
  // Pará
  CreateStateCode('IBGE'      , '15'    , TSystemState.PA );
  CreateStateCode('ISO2'      , 'PA'    , TSystemState.PA );
  CreateStateCode('ISO3166-2' , 'BR-PA' , TSystemState.PA );
  // Paraíba
  CreateStateCode('IBGE'      , '25'    , TSystemState.PB );
  CreateStateCode('ISO2'      , 'PB'    , TSystemState.PB );
  CreateStateCode('ISO3166-2' , 'BR-PB' , TSystemState.PB );
  // Paraná
  CreateStateCode('IBGE'      , '41'    , TSystemState.PR );
  CreateStateCode('ISO2'      , 'PR'    , TSystemState.PR );
  CreateStateCode('ISO3166-2' , 'BR-PR' , TSystemState.PR );
  // Pernambuco
  CreateStateCode('IBGE'      , '26'    , TSystemState.PE );
  CreateStateCode('ISO2'      , 'PE'    , TSystemState.PE );
  CreateStateCode('ISO3166-2' , 'BR-PE' , TSystemState.PE );
  // Piauí
  CreateStateCode('IBGE'      , '22'    , TSystemState.PI );
  CreateStateCode('ISO2'      , 'PI'    , TSystemState.PI );
  CreateStateCode('ISO3166-2' , 'BR-PI' , TSystemState.PI );
  // Rio de Janeiro
  CreateStateCode('IBGE'      , '33'    , TSystemState.RJ );
  CreateStateCode('ISO2'      , 'RJ'    , TSystemState.RJ );
  CreateStateCode('ISO3166-2' , 'BR-RJ' , TSystemState.RJ );
  // Rio Grande do Norte
  CreateStateCode('IBGE'      , '24'    , TSystemState.RN );
  CreateStateCode('ISO2'      , 'RN'    , TSystemState.RN );
  CreateStateCode('ISO3166-2' , 'BR-RN' , TSystemState.RN );
  // Rio Grande do Sul
  CreateStateCode('IBGE'      , '43'    , TSystemState.RS );
  CreateStateCode('ISO2'      , 'RS'    , TSystemState.RS );
  CreateStateCode('ISO3166-2' , 'BR-RS' , TSystemState.RS );
  // Rondônia
  CreateStateCode('IBGE'      , '11'    , TSystemState.RO );
  CreateStateCode('ISO2'      , 'RO'    , TSystemState.RO );
  CreateStateCode('ISO3166-2' , 'BR-RO' , TSystemState.RO );
  // Roraima
  CreateStateCode('IBGE'      , '14'    , TSystemState.RR );
  CreateStateCode('ISO2'      , 'RR'    , TSystemState.RR );
  CreateStateCode('ISO3166-2' , 'BR-RR' , TSystemState.RR );
  // Santa Catarina
  CreateStateCode('IBGE'      , '42'    , TSystemState.SC );
  CreateStateCode('ISO2'      , 'SC'    , TSystemState.SC );
  CreateStateCode('ISO3166-2' , 'BR-SC' , TSystemState.SC );
  // São Paulo
  CreateStateCode('IBGE'      , '35'    , TSystemState.SP );
  CreateStateCode('ISO2'      , 'SP'    , TSystemState.SP );
  CreateStateCode('ISO3166-2' , 'BR-SP' , TSystemState.SP );
  // Sergipe
  CreateStateCode('IBGE'      , '28'    , TSystemState.SE );
  CreateStateCode('ISO2'      , 'SE'    , TSystemState.SE );
  CreateStateCode('ISO3166-2' , 'BR-SE' , TSystemState.SE );
  // Tocantins
  CreateStateCode('IBGE'      , '17'    , TSystemState.&TO);
  CreateStateCode('ISO2'      , 'TO'    , TSystemState.&TO);
  CreateStateCode('ISO3166-2' , 'BR-TO' , TSystemState.&TO);
  inherited;
end;

end.
