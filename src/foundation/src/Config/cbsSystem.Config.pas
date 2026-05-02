unit cbsSystem.Config;

interface

uses
{IDE}
  System.Rtti,
{PROJECT}
  cbsSystem.Contracts.Config,
  cbsSystem.PathTree;

type
  TConfig = class(TPathTree, IConfig)
  public
    function Get(const APath: string; const ADefaultValue: TValue): TValue;
    procedure &Set(const APath: string; const AValue: TValue);
  end;

implementation

{ TConfig }

function TConfig.Get(const APath: string; const ADefaultValue: TValue): TValue;
begin
  Result := inherited Get(APath, ADefaultValue);
end;

procedure TConfig.&Set(const APath: string; const AValue: TValue);
begin
  inherited &Set(APath, AValue);
end;

end.
