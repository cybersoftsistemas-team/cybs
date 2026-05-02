unit cbsSystem.PathTreeParser;

interface

uses
{IDE}
  System.Rtti,
{PROJECT}
  cbsSystem.Contracts.PathTree;

type
  TPathParser = record
  strict private
    FCurrentList: IMemberList;
    FEndPtr: Integer;
    FName: string;
    FOptions: TPathTokenOptions;
    FPath: TPathList;
    FPtr: Integer;
    FToken: TPathToken;
    function GetIsEof: Boolean; inline;
    function GetItem(const AName: string): TValue;
    function IsPossiblePathParser(const APath: string): Boolean;
    procedure DoNext;
    procedure Remove(const AName: string); overload;
    procedure SetItems(const AName: string; const AValue: TValue);
    procedure SetList;
    procedure SetToken;
    procedure TrySetCurrentList;
    procedure TrySetNewCurrentList;
  public
    class procedure DisposeObjects(const AList: IMemberList; const AName: string); overload; static;
    constructor Create(const APath: string; const AList: IMemberList; const AOptions: TPathTokenOptions);
    function Contains(const AName: string): Boolean;
    procedure Next;
    property IsEof: Boolean read GetIsEof;
    property Items[const AName: string]: TValue read GetItem write SetItems; default;
    property Name: string read FName;
    property Token: TPathToken read FToken;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TPathParser }

class procedure TPathParser.DisposeObjects(const AList: IMemberList; const AName: string);
begin
  if AList.ContainsKey(AName) then
  begin
    var LValue := AList[AName];
    if LValue.IsType<IMemberList> then
    begin
      for var LItem in LValue.AsType<IMemberList> do
      begin
        DisposeObjects(LValue.AsType<IMemberList>, LItem.Key);
      end;
      LValue.AsType<IMemberList>.Clear;
    end
    else if not LValue.IsEmpty and LValue.IsObject then
    begin
      var LObject := LValue.AsObject;
      FreeAndNil(LObject);
    end;
    LValue := nil;
  end;
end;

constructor TPathParser.Create(const APath: string; const AList: IMemberList; const AOptions: TPathTokenOptions);
begin
  FEndPtr := 0;
  FPtr := 1;
  if IsPossiblePathParser(APath) and (TPathTokenOption.Read in AOptions) then
  begin
    FPath := APath.Split(['.']);
    if not(Length(FPath) = 0) then
    begin
      FCurrentList := AList;
      FEndPtr := High(FPath);
      FOptions := AOptions;
      FPtr := Low(FPath);
      DoNext;
    end;
  end;
end;

function TPathParser.Contains(const AName: string): Boolean;
begin
  Result := FCurrentList.ContainsKey(AName);
end;

function TPathParser.GetIsEof: Boolean;
begin
  Result := FPtr > FEndPtr;
end;

function TPathParser.GetItem(const AName: string): TValue;
begin
  Result := FCurrentList[AName];
end;

function TPathParser.IsPossiblePathParser(const APath: string): Boolean;
begin
  var LPath := APath.ToLower;
  Result := AnsiSameStr(LPath, APath);
//  if not Result then
//  begin
//    var LMessage := FContainer.Trans('validation.module.config_path');
//    if not LMessage.Trim.IsEmpty then
//    begin
//      raise JsonResponse.MessageError(LMessage) at hgnReturnAddress;
//    end;
//  end;
end;

procedure TPathParser.DoNext;
begin
  FName := '';
  if FPtr <= FEndPtr then
  begin
    FName := FPath[FPtr];
    SetToken;
    SetList;
  end;
end;

procedure TPathParser.Next;
begin
  Inc(FPtr);
  DoNext;
end;

procedure TPathParser.Remove(const AName: string);
begin
  DisposeObjects(FCurrentList, AName);
  FCurrentList.Remove(AName);
end;

procedure TPathParser.SetItems(const AName: string; const AValue: TValue);
begin
  Remove(AName);
  FCurrentList[AName] := AValue;
end;

procedure TPathParser.SetList;
begin
  case FToken of
    TPathToken.NewList:
    begin
      TrySetCurrentList;
      TrySetNewCurrentList;
    end;
  end;
end;

procedure TPathParser.SetToken;
begin
  FToken := TPathToken.NewList;
  if FPtr >= FEndPtr then
  begin
    FToken := TPathToken.&End;
  end;
end;

procedure TPathParser.TrySetCurrentList;
begin
  if FCurrentList.ContainsKey(FName) then
  begin
    var LValue := FCurrentList[FName];
    if LValue.IsType<IMemberList> then
    begin
      FToken := TPathToken.List;
      FCurrentList := LValue.AsType<IMemberList>;
    end;
  end;
end;

procedure TPathParser.TrySetNewCurrentList;
begin
  if (FToken = TPathToken.NewList) and (TPathTokenOption.Write in FOptions) then
  begin
    Remove(FName);
    var LMembers := CreateMemberList;
    FCurrentList.Add(FName, TValue.From<IMemberList>(LMembers));
    FCurrentList := LMembers;
  end;
end;

end.
