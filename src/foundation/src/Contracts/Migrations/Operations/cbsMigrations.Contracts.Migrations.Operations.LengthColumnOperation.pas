unit cbsMigrations.Contracts.Migrations.Operations.LengthColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.CustomStringColumnOperation;

type
  ILengthColumnOperation = interface(ICustomStringColumnOperation)
    ['{B80B347B-836B-4A16-9E59-EE8A55DB6472}']
    function GetLength: Integer;
    function HasColumnType(const AColumnType: string): ILengthColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): ILengthColumnOperation;
    function HasMaxLength(const ALength: Integer): ILengthColumnOperation;
    function HasSchema(const ASchema: string): ILengthColumnOperation;
    function HasTable(const ATable: string): ILengthColumnOperation;
    function IsOptional: ILengthColumnOperation;
    function IsRequired: ILengthColumnOperation;
    property Length: Integer read GetLength;
  end;

implementation

end.
