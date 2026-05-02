unit cbsUAuth.dom.Entities.Identity.UserOption;

interface

uses
{PROJECT}
  cbsUAuth.dom.Contracts.Entities.Identity.UserOption;

type
  TIdentityUserOption = class(TInterfacedObject, IIdentityUserOption)
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

{ TIdentityUserOption }

function TIdentityUserOption.GetChecked: Boolean;
begin
  Result := FChecked;
end;

function TIdentityUserOption.GetDescription: string;
begin
  Result := FDescription;
end;

function TIdentityUserOption.GetId: TGuid;
begin
  Result := FId;
end;

function TIdentityUserOption.GetName: string;
begin
  Result := FName;
end;

procedure TIdentityUserOption.SetChecked(const AValue: Boolean);
begin
  FChecked := AValue;
end;

procedure TIdentityUserOption.SetDescription(const AValue: string);
begin
  FDescription := AValue;
end;

procedure TIdentityUserOption.SetId(const AValue: TGuid);
begin
  FId := AValue;
end;

procedure TIdentityUserOption.SetName(const AValue: string);
begin
  FName := AValue;
end;

end.
