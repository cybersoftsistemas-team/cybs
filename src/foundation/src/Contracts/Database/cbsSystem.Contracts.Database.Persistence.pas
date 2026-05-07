unit cbsSystem.Contracts.Database.Persistence;

interface

uses
{SPRING}
  Spring.Persistence.Core.Session;

type
  IPersistence = interface(IUnknown)
    ['{3DECD1A1-8623-43C6-8B7D-EA160EA7FECE}']
    function GetSession: TSession;
    property Session: TSession read GetSession;
  end;

implementation

end.
