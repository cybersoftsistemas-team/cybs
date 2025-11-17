unit cbsMigrations.Contracts.Migrations.CommandBuilder;

interface

type
  TCommandText = string;

  ICommandBuilder = interface(IUnknown)
    ['{55660F8E-8CB3-41A6-8C9D-BB0276859861}']
    function CommandTextLength: Integer;
    function Append(const AValue: string): ICommandBuilder;
    function AppendLine: ICommandBuilder; overload;
    function AppendLine(const AValue: string): ICommandBuilder; overload;
    function Build: TCommandText;
  end;

implementation

end.
