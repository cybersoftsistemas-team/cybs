unit cbsUAuth.inf.Repositories.Identity.Data.Modules.damIdentityConfig;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule,
  cbsUAuth.dom.Contracts.Entities.Identity.Config,
{IDE}
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdamIdentityConfig = class(TdamBase)
    qryCON: TFDQuery;
  private
    function GetMappedConfig(const ADataSet: TDataSet): IConfig;
  public
    function GetConfig: IConfig;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
{PROJECT}
  cbsMain.inf.DbModule,
  cbsUAuth.dom.Entities.Identity.Config;

function TdamIdentityConfig.GetConfig: IConfig;
begin
  qryCON.Close;
  qryCON.Open;
  Result := GetMappedConfig(qryCON);
end;

function TdamIdentityConfig.GetMappedConfig(const ADataSet: TDataSet): IConfig;
begin
   if not ADataSet.IsEmpty then
  begin
    Result := TConfig.Create;
    Result.LockoutMinutes := ADataSet.FieldByName('LockoutMinutes').AsInteger;
    Result.MaxAttempts := ADataSet.FieldByName('MaxAttempts').AsInteger;
    Exit;
  end;
  Result := TConfig.Create;
end;

end.
