unit cbsSystem.Contracts.Container.RegisterContainer;

interface

uses
{IDE}
  System.TypInfo,
{SPRING}
  Spring.Collections;

type
  TConcrete = TPair<PTypeInfo, Boolean>;

  IContainerItem = TPair<PTypeInfo, TConcrete>;
  IContainerEnumerator = IEnumerator<IContainerItem>;

  IRegisterContainer = interface(IUnknown)
    ['{81254F82-C138-4F63-87E1-52BC19029055}']
    function Bound(const abstract: TGuid): Boolean; overload;
    function Bound(const AConcrete: TClass): Boolean; overload;
    function GetEnumerator: IContainerEnumerator;
    procedure Bind(const abstract: TGuid; const AConcrete: TClass; const AShared: Boolean = False); overload;
    procedure Bind(const AConcrete: TClass; const AShared: Boolean = False); overload;
    procedure BindIf(const abstract: TGuid; const AConcrete: TClass; const AShared: Boolean); overload;
    procedure BindIf(const AConcrete: TClass; const AShared: Boolean = False); overload;
    procedure Singleton(const abstract: TGuid; const AConcrete: TClass); overload;
    procedure Singleton(const AConcrete: TClass); overload;
    procedure SingletonIf(const abstract: TGuid; const AConcrete: TClass); overload;
    procedure SingletonIf(const AConcrete: TClass); overload;
  end;

  IContainerList = IDictionary<PTypeInfo, TConcrete>;

  function CreateContainerList: IContainerList;

implementation

function CreateContainerList: IContainerList;
begin
  Result := TCollections.CreateDictionary<PTypeInfo, TConcrete>;
end;

end.
