unit cbsMigrations.Contracts.Migrations.Operations.AddDecimalColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DecimalColumnOperation;

type
  IAddDecimalColumnOperation = interface(IDecimalColumnOperation)
    ['{97CE9F4C-8E87-4AE0-BB97-668088F2A55C}']
    function HasColumnType(const AColumnType: string): IAddDecimalColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddDecimalColumnOperation;
    function HasPrecision(const APrecision, AScale: Integer): IAddDecimalColumnOperation;
    function HasSchema(const ASchema: string): IAddDecimalColumnOperation;
    function HasTable(const ATable: string): IAddDecimalColumnOperation;
    function IsOptional: IAddDecimalColumnOperation;
    function IsRequired: IAddDecimalColumnOperation;
  end;

implementation

end.
