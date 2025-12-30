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
    qryGENParentId: TGuidField;
    qryGENReserved: TBooleanField;
    qryLEG: TFDQuery;
    qryNAT: TFDQuery;
    qryNATBirthday: TSQLTimeStampField;
    qryNATFirstName: TWideStringField;
    qryNATGenderId: TGuidField;
    qryNATId: TGuidField;
    qryNATIDCard: TWideStringField;
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
    updLEG: TFDUpdateSQL;
    updNAT: TFDUpdateSQL;
    updCYT: TFDUpdateSQL;
    procedure qryCYTNewRecord(DataSet: TDataSet);
  protected
    procedure CloseDataSets; override;
    procedure OpenDataSets; override;
  end;

//  function damCustomerRegistration: TdamCustomerRegistration;
var
  damCustomerRegistration: TdamCustomerRegistration;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{PROJECT}
  cbsMain.data.module.MainModule,
  cbsSystem.Support.Module;

//function damCustomerRegistration: TdamCustomerRegistration;
//begin
//  Result := TdamCustomerRegistration(damMain.GetModuleInstance(TdamCustomerRegistration));
//end;

{ TdamCustomerRegistration }

procedure TdamCustomerRegistration.CloseDataSets;
begin
  inherited;
  qryGEN.Close;
  qryNTU.Close;
  qryCOU.Close;
  qrySTA.Close;
  qryCYT.Close;
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
  qryNAT.Open;
end;

procedure TdamCustomerRegistration.qryCYTNewRecord(DataSet: TDataSet);
begin
  inherited;
  SetNewGuid(qryCYTId);
end;

initialization
begin
//  RegisterModuleType(TdamCustomerRegistration);
end;

end.
