unit cbsMigrations.Contracts.Migrations.MigrationCommand;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.CommandBuilder;

type
  IMigrationCommand = interface(IUnknown)
    ['{96E34F7E-F586-4CBE-8B6C-B4D265ECBAFD}']
    function GetCommandText: TCommandText;
    property CommandText: TCommandText read GetCommandText;
  end;

implementation

end.
