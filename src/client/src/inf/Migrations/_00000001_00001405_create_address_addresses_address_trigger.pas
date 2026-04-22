unit _00000001_00001405_create_address_addresses_address_trigger;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressAddressesAddressTrigger = class(TMigration)
  private
    const TableName = 'addresses';
    const SchemaName = 'address';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressAddressesAddressTrigger }

procedure CreateAddressAddressesAddressTrigger.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.Sql(
  'CREATE TRIGGER ' + SchemaName + '_' + TableName + '_Address_trigger ' +
  'ON ' + SchemaName + '.' + TableName + '                             ' +
  'AFTER INSERT, UPDATE                                                ' +
  'AS                                                                  ' +
  'BEGIN                                                               ' +
  '  SET NOCOUNT ON;                                                   ' +
  '  UPDATE a                                                          ' +
  '  SET Address = CONCAT_WS('', '',                                   ' +
  '      CONCAT_WS('' '', stt.Name, str.Name),                         ' +
  '      CONCAT_WS('' - '',                                            ' +
  '          NULLIF(a.Number, ''''),                                   ' +
  '          nbh.Name                                                  ' +
  '      ),                                                            ' +
  '      CONCAT_WS('' - '',                                            ' +
  '          cty.Name,                                                 ' +
  '          COALESCE(NULLIF(st.Acronym, ''''), st.Name)               ' +
  '      ),                                                            ' +
  '      CASE                                                          ' +
  '          WHEN a.ZipCode IS NOT NULL AND LEN(a.ZipCode) = 8         ' +
  '          THEN CONCAT(LEFT(a.ZipCode,5), ''-'', RIGHT(a.ZipCode,3)) ' +
  '      END,                                                          ' +
  '      c.Name                                                        ' +
  '  )                                                                 ' +
  '  FROM ' + SchemaName + '.' + TableName + ' a                       ' +
  '  JOIN inserted i ON i.Id = a.Id                                    ' +
  '  JOIN address.streettypes stt ON stt.Id = a.StreetTypeId           ' +
  '  JOIN address.streets str ON str.Id = a.StreetId                   ' +
  '  JOIN address.neighborhoods nbh ON nbh.Id = a.NeighborhoodId       ' +
  '  JOIN address.cities cty ON cty.Id = nbh.CityId                    ' +
  '  JOIN address.states st ON st.Id = cty.StateId                     ' +
  '  JOIN country.countries c ON c.Id = st.CountryId                   ' +
  '  WHERE UPDATE(StreetTypeId)                                        ' +
  '     OR UPDATE(StreetId)                                            ' +
  '     OR UPDATE(Number)                                              ' +
  '     OR UPDATE(NeighborhoodId)                                      ' +
  '     OR UPDATE(ZipCode);                                            ' +
  'END;                                                                ' );
end;

end.
