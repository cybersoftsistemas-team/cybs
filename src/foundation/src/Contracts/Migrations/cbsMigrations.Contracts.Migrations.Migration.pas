unit cbsMigrations.Contracts.Migrations.Migration;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationBase,
  cbsMigrations.Contracts.Migrations.MigrationBuilder,
  cbsMigrations.Contracts.Migrations.Operations.MigrationOperation,
{SPRING}
  Spring.Collections;

type
  TBuildOperantionEvent = reference to procedure(const ASchema: IMigrationBuilder);

  IReadOnlyList = IReadOnlyCollection<IMigrationOperation>;

  IDownOperations = IReadOnlyList;
  IUpOperations = IReadOnlyList;

  IMigration = interface(IMigrationBase)
    ['{787232A6-319E-4B1D-B621-0E8341530673}']
    function DownOperations: IDownOperations;
    function UpOperations: IUpOperations;
  end;

  IOperationList = IList<IMigrationOperation>;

  IDownOperationList = IOperationList;
  IUpOperationList = IOperationList;

  function CreateDownOperationList: IDownOperationList;
  function CreateUpOperationList: IUpOperationList;

implementation

function CreateDownOperationList: IDownOperationList;
begin
  Result := TCollections.CreateInterfaceList<IMigrationOperation>;
end;

function CreateUpOperationList: IUpOperationList;
begin
  Result := TCollections.CreateInterfaceList<IMigrationOperation>;
end;

end.
