unit cbsMigrations.Contracts.Migrations.Operations.StringColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.LengthColumnOperation;

type
  IStringColumnOperation = interface(ILengthColumnOperation)
    ['{B03042A1-7F83-4AD9-B25A-D3C9EC8D4854}']
    function GetCollation: string;
    function GetFixedLength: Boolean;
    function GetMaxLength: Boolean;
    function GetUnicode: Boolean;
    function HasCollation(const ACollation: string): IStringColumnOperation;
    function HasColumnType(const AColumnType: string): IStringColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IStringColumnOperation;
    function HasMaxLength(const ALength: Integer): IStringColumnOperation;
    function HasSchema(const ASchema: string): IStringColumnOperation;
    function HasTable(const ATable: string): IStringColumnOperation;
    function HasUnicode(const AUnicode: Boolean): IStringColumnOperation;
    function IsFixedLength: IStringColumnOperation;
    function IsMaxLength: IStringColumnOperation;
    function IsOptional: IStringColumnOperation;
    function IsRequired: IStringColumnOperation;
    function IsVariableLength: IStringColumnOperation;
    property Collation: string read GetCollation;
    property FixedLength: Boolean read GetFixedLength;
    property MaxLength: Boolean read GetMaxLength;
    property Unicode: Boolean read GetUnicode;
  end;

implementation

end.
