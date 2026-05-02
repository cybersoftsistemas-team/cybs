unit cbsUAuth.inf.Repositories.DataModules.Identity.damIdentityUser;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule,
  cbsUAuth.dom.Contracts.Entities.Identity.User,
{IDE}
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet;

type
  TdamIdentityUser = class(TdamBase)
    qryBNA: TFDQuery;
    qryBID: TFDQuery;
    cmdBIN: TFDCommand;
    cmdBRE: TFDCommand;
    cmdBUP: TFDCommand;
    qryBSE: TFDQuery;
    qryBSEId: TGuidField;
    qryBSEName: TWideStringField;
    qryBSEDescription: TWideMemoField;
    qryBSEChecked: TBooleanField;
    dsoBID: TDataSource;
    dsoBNA: TDataSource;
    qryBPW: TFDQuery;
    qryBPWUserId: TGuidField;
    qryBPWHash: TVarBytesField;
    qryBPWIterations: TIntegerField;
    qryBPWSalt: TVarBytesField;
  private
    function GetMappedUser(const ADataSet: TDataSet): IIdentityUser;
  public
    function GetById(const AId: TGuid): IIdentityUser;
    function GetByUserName(const AUserName: string): IIdentityUser;
    procedure IncrementFailed(const AUserId: TGuid);
    procedure ResetFailed(const AUserId: TGuid);
    procedure UpdatePassword(const AUserId: TGuid; const AHash, ASalt: TBytes; const AIterations: Integer; const AChangePasswordOnNextLogin: Boolean = False);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
{PROJECT}
  cbsMain.inf.DbModule,
  cbsSystem.Support.Container,
  cbsUAuth.dom.Common.Identity.SystemOptions,
  cbsUAuth.dom.Contracts.Entities.Identity.UserOption;

{ TdamUser }

function TdamIdentityUser.GetById(const AId: TGuid): IIdentityUser;
begin
  qryBSE.Close;
  qryBSE.MasterSource := dsoBID;
  qryBID.Close;
  qryBPW.Close;
  qryBPW.MasterSource := dsoBID;
  qryBID.ParamByName('UserId').AsGuid := AId;
  qryBID.Open;
  qryBSE.Open;
  qryBPW.Open;
  Result := GetMappedUser(qryBID);
end;

function TdamIdentityUser.GetByUserName(const AUserName: string): IIdentityUser;
begin
  qryBSE.Close;
  qryBSE.MasterSource := dsoBNA;
  qryBNA.Close;
  qryBPW.Close;
  qryBPW.MasterSource := dsoBNA;
  qryBNA.ParamByName('UserName').AsString := AUserName;
  qryBNA.Open;
  qryBSE.Open;
  qryBPW.Open;
  Result := GetMappedUser(qryBNA);
end;

function TdamIdentityUser.GetMappedUser(const ADataSet: TDataSet): IIdentityUser;
begin
  if not ADataSet.IsEmpty then
  begin
    var LSettingList: IUserSettingList := nil;
    if not qryBSE.IsEmpty then
    begin
      LSettingList := CreateUserSettingList;
      while not qryBSE.Eof do
      begin
        var LOption := App.Make<IIdentityUserOption>;
        LOption.Id := qryBSEId.AsGuid;
        LOption.Name := qryBSEName.AsString;
        LOption.Description := qryBSEDescription.AsString;
        LOption.Checked := qryBSEChecked.AsBoolean;
        LSettingList.Add(LOption);
        qryBSE.Next;
      end;
    end;
    Result := App.MakeWith<IIdentityUser>([TParam.From(LSettingList.ToArray)]);
    Result.Id := ADataSet.FieldByName('Id').AsGuid;
    Result.Name := ADataSet.FieldByName('Name').AsString;
    Result.AccessFailedCount := ADataSet.FieldByName('AccessFailedCount').AsInteger;
    Result.AccountActivated := ADataSet.FieldByName('AccountActivated').AsBoolean;
    Result.AccountBlockedOut := ADataSet.FieldByName('AccountBlockedOut').AsBoolean;
    Result.LastLoginAt := ADataSet.FieldByName('LastLoginAt').AsDateTime;
    Result.LockoutEnd := ADataSet.FieldByName('LockoutEnd').AsDateTime;
    Result.Hash := qryBPWHash.AsBytes;
    Result.Iterations := qryBPWIterations.AsInteger;
    Result.Salt := qryBPWSalt.AsBytes;
    Exit;
  end;
  Result := App.Make<IIdentityUser>;
end;

procedure TdamIdentityUser.IncrementFailed(const AUserId: TGuid);
begin
  cmdBIN.ParamByName('UserId').AsGuid := AUserId;
  cmdBIN.Prepare;
  cmdBIN.Execute;
end;

procedure TdamIdentityUser.ResetFailed(const AUserId: TGuid);
begin
  cmdBRE.ParamByName('UserId').AsGuid := AUserId;
  cmdBRE.Prepare;
  cmdBRE.Execute;
end;

procedure TdamIdentityUser.UpdatePassword(const AUserId: TGuid; const AHash, ASalt: TBytes; const AIterations: Integer; const AChangePasswordOnNextLogin: Boolean);
begin
  cmdBUP.ParamByName('UserId').AsGuid := AUserId;
  var LParamHash := cmdBUP.ParamByName('Hash');
  LParamHash.DataType := ftBlob;
  LParamHash.SetData(@AHash[0], Length(AHash));
  var LParamSalt := cmdBUP.ParamByName('Salt');
  LParamSalt.DataType := ftBlob;
  LParamSalt.SetData(@ASalt[0], Length(ASalt));
  cmdBUP.ParamByName('Iterations').AsInteger := AIterations;
  cmdBUP.ParamByName('ChangePasswordOnNextLogin').AsBoolean := AChangePasswordOnNextLogin;
  cmdBUP.ParamByName('ChangePasswordOnNextLoginId').AsGuid := TSystemOptions.ChangePasswordOnNextLoginId;
  cmdBUP.Prepare;
  cmdBUP.Execute;
end;

end.




