unit cbsUAuth.data.module.CustomerRegistrationModule;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, System.Classes, Data.DB, FireDAC.Comp.DataSet;

type
  TdamCustomerRegistration = class(TdamBase)
    dsoCOU: TDataSource;
    dsoCYT: TDataSource;
    dsoGEN: TDataSource;
    dsoLEG: TDataSource;
    dsoNAT: TDataSource;
    dsoNTU: TDataSource;
    dsoSTA: TDataSource;
    qryCOU: TFDQuery;
    qryCOUAreaCode: TIntegerField;
    qryCOUId: TGuidField;
    qryCOUName: TWideStringField;
    qryCYT: TFDQuery;
    qryCYTAreaCode: TIntegerField;
    qryCYTId: TGuidField;
    qryCYTName: TWideStringField;
    qryCYTStateId: TGuidField;
    qryGEN: TFDQuery;
    qryGENId: TGuidField;
    qryGENName: TWideStringField;
    qryLEG: TFDQuery;
    qryLEGCompanyTypeId: TGuidField;
    qryLEGCRN: TWideStringField;
    qryLEGDoingBusinessAs: TWideStringField;
    qryLEGFoundationDate: TSQLTimeStampField;
    qryLEGId: TGuidField;
    qryLEGMunicipalInscriptionNumber: TWideStringField;
    qryLEGName: TWideStringField;
    qryLEGNationalityId: TGuidField;
    qryLEGStateId: TGuidField;
    qryLEGStateInscriptionNumber: TWideStringField;
    qryNAT: TFDQuery;
    qryNATBirthday: TSQLTimeStampField;
    qryNATFirstName: TWideStringField;
    qryNATGenderId: TGuidField;
    qryNATId: TGuidField;
    qryNATLastName: TWideStringField;
    qryNATNationalityId: TGuidField;
    qryNATPlaceOfBirthId: TGuidField;
    qryNATSSN: TWideStringField;
    qryNTU: TFDQuery;
    qryNTUCountryId: TGuidField;
    qryNTUId: TGuidField;
    qryNTUName: TWideStringField;
    qrySTA: TFDQuery;
    qrySTAAcronym: TWideStringField;
    qrySTACountryId: TGuidField;
    qrySTAId: TGuidField;
    qrySTAName: TWideStringField;
    updCYT: TFDUpdateSQL;
    updLEG: TFDUpdateSQL;
    updNAT: TFDUpdateSQL;
    qryCTP: TFDQuery;
    qryCTPId: TGuidField;
    qryCTPName: TWideStringField;
    dsoCTP: TDataSource;
    qryNTY: TFDQuery;
    dsoNTY: TDataSource;
    qryNTYId: TGuidField;
    qryNTYName: TWideStringField;
    qryNTYCountryId: TGuidField;
    qrySTE: TFDQuery;
    dsoSTE: TDataSource;
    qrySTEId: TGuidField;
    qrySTEName: TWideStringField;
    procedure qryCYTNewRecord(DataSet: TDataSet);
    procedure qryLEGNewRecord(DataSet: TDataSet);
    procedure qryNATNewRecord(DataSet: TDataSet);
  protected
    procedure CloseDataSets; override;
    procedure OpenDataSets; override;
  end;

var
  damCustomerRegistration: TdamCustomerRegistration;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{PROJECT}
  cbsMain.data.module.MainModule,
  cbsSystem.Support.Module;

{ TdamCustomerRegistration }

procedure TdamCustomerRegistration.CloseDataSets;
begin
  inherited;
  qryGEN.Close;
  qryNTU.Close;
  qryCOU.Close;
  qrySTA.Close;
  qryCYT.Close;
  qryCTP.Close;
  qryNTY.Close;
  qrySTE.Close;
  qryLEG.Close;
  qryNAT.Close;
end;

procedure TdamCustomerRegistration.OpenDataSets;
begin
  inherited;
  qryGEN.Open;
  qryNTU.Open;
  qryCOU.Open;
  qrySTA.Open;
  qryCYT.Open;
  qryCTP.Open;
  qryNTY.Open;
  qrySTE.Open;
  qryLEG.Open;
  qryNAT.Open;
end;

procedure TdamCustomerRegistration.qryCYTNewRecord(DataSet: TDataSet);
begin
  inherited;
  SetNewGuid(qryCYTId);
end;

procedure TdamCustomerRegistration.qryLEGNewRecord(DataSet: TDataSet);
begin
  inherited;
  SetNewGuid(qryLEGId);
end;

procedure TdamCustomerRegistration.qryNATNewRecord(DataSet: TDataSet);
begin
  inherited;
  SetNewGuid(qryNATId);
end;

end.
