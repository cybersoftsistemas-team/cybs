unit cbsMigrations.Support.MappedColumnTypes;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MappedColumnTypes,
  cbsMigrations.Schema.Types;

  function MappedColumnTypes: IMappedColumnTypes;

const
  ChatSupport              = [DriverID.MSSQL];
  NSupport                 = [DriverID.MSSQL];
  LengthOrPrecisionSupport = [DriverID.MSSQL];

implementation

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.BooleanColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.DateColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.DateTimeColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.FloatColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.GuidColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.IntColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.StringColumnOperation,
  cbsMigrations.Migrations.MappedColumnTypes;

var
  InternalMappedColumnTypes: IMappedColumnTypes;

function MappedColumnTypes: IMappedColumnTypes;
begin
  Result := InternalMappedColumnTypes;
end;

initialization
begin
  InternalMappedColumnTypes :=

   TMappedColumnTypes.Create

    // MSSQL
    .Register(IBooleanColumnOperation  , DriverID.MSSQL, 'BIT'              )
    .Register(IDateColumnOperation     , DriverID.MSSQL, 'DATE'             )
    .Register(IDateTimeColumnOperation , DriverID.MSSQL, 'DATETIME'         )
    .Register(IFloatColumnOperation    , DriverID.MSSQL, 'FLOAT'            )
    .Register(IGuidColumnOperation     , DriverID.MSSQL, 'UNIQUEIDENTIFIER' )
    .Register(IIntColumnOperation      , DriverID.MSSQL, 'INT'              )
    .Register(IStringColumnOperation   , DriverID.MSSQL, 'VARCHAR'          );
end;

finalization
begin
  InternalMappedColumnTypes := nil;
end;

end.
