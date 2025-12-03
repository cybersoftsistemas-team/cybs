unit cbsSystem.Contracts.DataStorage;

interface

type
  IcbsDataStorage = interface(IUnknown)
    ['{E33353D6-53C3-416E-AFED-A9D8CAE7FE74}']
    function Load(const AFileName: string): string;
    procedure Save(const AFileName, AData: string);
  end;

implementation

end.
