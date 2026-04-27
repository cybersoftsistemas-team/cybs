unit cbsUAuth.dom.Entities.Identity.UserOption;

interface

uses
{PROJECT}
  cbsUAuth.dom.Contracts.Entities.Identity.UserOption;

type
  TUserOption = class(TInterfacedObject, IUserOption)
  private
    FId: TGuid;
    FName: string;
    FDescription: string;
    FChecked: Boolean;
    function GetId: TGuid;
    function GetName: string;
    function GetDescription: string;
    function GetChecked: Boolean;
    procedure SetId(const AValue: TGuid);
    procedure SetName(const AValue: string);
    procedure SetDescription(const AValue: string);
    procedure SetChecked(const AValue: Boolean);
  public
    property Id: TGuid read GetId write SetId;
    property Name: string read GetName write SetName;
    property Description: string read GetDescription write SetDescription;
    property Checked: Boolean read GetChecked write SetChecked;
  end;

implementation

{ TUserOption }

function TUserOption.GetChecked: Boolean;
begin
  Result := FChecked;
end;

function TUserOption.GetDescription: string;
begin
  Result := FDescription;
end;

function TUserOption.GetId: TGuid;
begin
  Result := FId;
end;

function TUserOption.GetName: string;
begin
  Result := FName;
end;

procedure TUserOption.SetChecked(const AValue: Boolean);
begin
  FChecked := AValue;
end;

procedure TUserOption.SetDescription(const AValue: string);
begin
  FDescription := AValue;
end;

procedure TUserOption.SetId(const AValue: TGuid);
begin
  FId := AValue;
end;

procedure TUserOption.SetName(const AValue: string);
begin
  FName := AValue;
end;

end.
