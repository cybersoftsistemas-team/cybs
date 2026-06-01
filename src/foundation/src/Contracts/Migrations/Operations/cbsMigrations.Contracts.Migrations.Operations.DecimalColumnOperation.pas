unit cbsMigrations.Contracts.Migrations.Operations.DecimalColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.NumberColumnOperation;

type
  IDecimalColumnOperation = interface(INumberColumnOperation)
    ['{CD056DEC-DFD7-4CED-8438-A92473383EC1}']
    function GetScale: Integer;
    function HasColumnType(const AColumnType: string): IDecimalColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IDecimalColumnOperation;
    function HasPrecision(const APrecision, AScale: Integer): IDecimalColumnOperation;
    function HasSchema(const ASchema: string): IDecimalColumnOperation;
    function HasTable(const ATable: string): IDecimalColumnOperation;
    function IsOptional: IDecimalColumnOperation;
    function IsRequired: IDecimalColumnOperation;
    property Scale: Integer read GetScale;
  end;

implementation

end.
