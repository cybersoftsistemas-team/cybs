unit cbsSystem.Contracts.Config;

interface

uses
{IDE}
  System.Rtti;

type
  IConfig = interface(IUnknown)
    ['{5EF87B92-2CA3-4FF6-85A2-39E98D0CC767}']
    function Get(const APath: string; const ADefaultValue: TValue): TValue;
    procedure &Set(const APath: string; const AValue: TValue);
  end;

implementation

end.
