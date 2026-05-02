unit cbsSystem.Contracts.Container;

interface

uses
{IDE}
  System.Rtti,
  System.TypInfo;

type
  TParam = TValue;
  TParams = array of TParam;
  TResult = TParam;

  IContainer = interface(IUnknown)
    ['{9313664A-9731-48A0-99A3-D997D04358CD}']
    procedure Make(var AResult; AServiceType: PTypeInfo);
    procedure MakeWith(var AResult; AServiceType: PTypeInfo; const AParams: TParams);
    procedure Release(const AInstance: IInterface); overload;
    procedure Release(const AInstance: TObject); overload;
  end;

implementation

end.
