unit cbsSystem.Contracts.Module.Main;

interface

type
  IMainModule = interface(IUnknown)
    ['{D4606EE0-8E0F-4513-BCB8-A6989D3A0988}']
    function GetIsElectron: Boolean;
    procedure SetIsElectron(const AValue: Boolean);
    property IsElectron: Boolean read GetIsElectron write SetIsElectron;
  end;

implementation

end.
