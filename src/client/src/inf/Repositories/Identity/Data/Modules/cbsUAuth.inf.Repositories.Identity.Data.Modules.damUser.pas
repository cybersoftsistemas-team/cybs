unit cbsUAuth.inf.Repositories.Identity.Data.Modules.damUser;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule,
  cbsUAuth.dom.Contracts.Entities.Identity.User,
{IDE}
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet;

type
  TdamUser = class(TdamBase)
    qryBNA: TFDQuery;
    qryBID: TFDQuery;
    cmdBIN: TFDCommand;
    cmdBRE: TFDCommand;
    cmdBLU: TFDCommand;
    cmdBUP: TFDCommand;
    qryBSE: TFDQuery;
    qryBSEId: TGuidField;
    qryBSEName: TWideStringField;
    qryBSEDescription: TWideMemoField;
    qryBSEChecked: TBooleanField;
    dsoBID: TDataSource;
    dsoBNA: TDataSource;
  private
    function GetMappedUser(const ADataSet: TDataSet): IUser;
  public
    function GetById(const AId: TGuid): IUser;
    function GetByUserName(const AUserName: string): IUser;
    procedure IncrementFailed(const AUserId: TGuid);
    procedure LockUser(const AUserId: TGuid);
    procedure ResetFailed(const AUserId: TGuid);
    procedure UpdatePassword(const AUserId: TGuid; const AHash, ASalt: TBytes);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
{PROJECT}
  cbsMain.inf.DbModule,
  cbsUAuth.dom.Contracts.Entities.Identity.UserOption,
  cbsUAuth.dom.Entities.Identity.User,
  cbsUAuth.dom.Entities.Identity.UserOption;

{ TdamUser }

function TdamUser.GetById(const AId: TGuid): IUser;
begin
  qryBSE.Close;
  qryBSE.MasterSource := dsoBID;
  qryBID.Close;
  qryBID.ParamByName('UserId').AsGuid := AId;
  qryBID.Open;
  qryBSE.Open;
  Result := GetMappedUser(qryBID);
end;

function TdamUser.GetByUserName(const AUserName: string): IUser;
begin
  qryBSE.Close;
  qryBSE.MasterSource := dsoBNA;
  qryBNA.Close;
  qryBNA.ParamByName('UserName').AsString := AUserName;
  qryBNA.Open;
  qryBSE.Open;
  Result := GetMappedUser(qryBNA);
end;

function TdamUser.GetMappedUser(const ADataSet: TDataSet): IUser;
begin
  if not ADataSet.IsEmpty then
  begin
    var LSettingList: IUserSettingList := nil;
    if not qryBSE.IsEmpty then
    begin
      LSettingList := CreateUserSettingList;
      while not qryBSE.Eof do
      begin
        var LOption := TUserOption.Create;
        LOption.Id := qryBSEId.AsGuid;
        LOption.Name := qryBSEName.AsString;
        LOption.Description := qryBSEDescription.AsString;
        LOption.Checked := qryBSEChecked.AsBoolean;
        LSettingList.Add(LOption);
        qryBSE.Next;
      end;
    end;
    Result := TUser.Create(LSettingList);
    Result.Id := ADataSet.FieldByName('Id').AsGuid;
    Result.Name := ADataSet.FieldByName('Name').AsString;
    Result.AccessFailedCount := ADataSet.FieldByName('AccessFailedCount').AsInteger;
    Result.AccountActivated := ADataSet.FieldByName('AccountActivated').AsBoolean;
    Result.AccountBlockedOut := ADataSet.FieldByName('AccountBlockedOut').AsBoolean;
    Result.LastLoginAt := ADataSet.FieldByName('LastLoginAt').AsDateTime;
    Result.LockoutEnd := ADataSet.FieldByName('LockoutEnd').AsDateTime;
    Result.Hash := ADataSet.FieldByName('PasswordHash').AsBytes;
    Result.Iterations := ADataSet.FieldByName('PasswordIterations').AsInteger;
    Result.Salt := ADataSet.FieldByName('PasswordSalt').AsBytes;
    Exit;
  end;
  Result := TUser.Create;
end;

procedure TdamUser.IncrementFailed(const AUserId: TGuid);
begin
  cmdBIN.ParamByName('UserId').AsGuid := AUserId;
  cmdBIN.Prepare;
  cmdBIN.Execute;
end;

procedure TdamUser.LockUser(const AUserId: TGuid);
begin
  cmdBLU.ParamByName('UserId').AsGuid := AUserId;
  cmdBLU.Prepare;
  cmdBLU.Execute;
end;

procedure TdamUser.ResetFailed(const AUserId: TGuid);
begin
  cmdBRE.ParamByName('UserId').AsGuid := AUserId;
  cmdBRE.Prepare;
  cmdBRE.Execute;
end;

procedure TdamUser.UpdatePassword(const AUserId: TGuid; const AHash, ASalt: TBytes);
begin
  cmdBUP.ParamByName('UserId').AsGuid := AUserId;
  var LParamHash := cmdBUP.ParamByName('Hash');
  LParamHash.DataType := ftBlob;
  LParamHash.SetData(@AHash[0], Length(AHash));
  var LParamSalt := cmdBUP.ParamByName('Salt');
  LParamSalt.DataType := ftBlob;
  LParamSalt.SetData(@ASalt[0], Length(ASalt));
  cmdBUP.Prepare;
  cmdBUP.Execute;
end;

end.


