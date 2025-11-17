unit cbsMigrations.Contracts.Migrations.Operations.AddStringColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.StringColumnOperation;

type
  IAddStringColumnOperation = interface(IStringColumnOperation)
    ['{CEC91D4A-0D7A-40E4-AA96-97D6F2E15A95}']
    function HasColumnType(const AColumnType: string): IAddStringColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddStringColumnOperation;
    function HasMaxLength(const ALength: Integer): IAddStringColumnOperation;
    function HasSchema(const ASchema: string): IAddStringColumnOperation;
    function HasTable(const ATable: string): IAddStringColumnOperation;
    function HasUnicode(const AUnicode: Boolean): IAddStringColumnOperation;
    function IsFixedLength: IAddStringColumnOperation;
    function IsMaxLength: IAddStringColumnOperation;
    function IsOptional: IAddStringColumnOperation;
    function IsRequired: IAddStringColumnOperation;
    function IsVariableLength: IAddStringColumnOperation;
  end;

implementation

end.
