unit cbsMigrations.Contracts.Migrations.Operations.NumberColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.CustomNumberColumnOperation;

type
  INumberColumnOperation = interface(ICustomNumberColumnOperation)
    ['{F06C7C4C-2649-4E45-B58B-0703B6451428}']
    function GetPrecision: Integer;
    function HasColumnType(const AColumnType: string): INumberColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): INumberColumnOperation;
    function HasPrecision(const APrecision: Integer): INumberColumnOperation;
    function HasSchema(const ASchema: string): INumberColumnOperation;
    function HasTable(const ATable: string): INumberColumnOperation;
    function IsOptional: INumberColumnOperation;
    function IsRequired: INumberColumnOperation;
    property Precision: Integer read GetPrecision;
  end;

implementation

end.
