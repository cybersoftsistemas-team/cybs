unit cbsMigrations.Contracts.Migrations.Operations.AddComputedColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ComputedColumnOperation;

type
  IAddComputedColumnOperation = interface(IComputedColumnOperation)
    ['{5417B354-7994-4290-94F2-AFDC4ADEF2AE}']
    function HasColumnType(const AColumnType: string): IAddComputedColumnOperation;
    function HasSchema(const ASchema: string): IAddComputedColumnOperation;
    function HasSqlAs(const ASql: string): IAddComputedColumnOperation;
    function HasTable(const ATable: string): IAddComputedColumnOperation;
    function IsOptional: IAddComputedColumnOperation;
    function IsRequired: IAddComputedColumnOperation;
    function IsStored: IAddComputedColumnOperation;
  end;

implementation

end.
