unit cbsMain.support.RegisterMigrations;

interface

  procedure RegisterMigrations;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext,
  cbsMigrations.Support.Migration,
  cbsSystem.Support.DatabaseSeeder,
// DbSeed...
  _00000000_DatabaseSeeder,
// Migrations...
  _2025_12_09_00000001_create_general_schema,
  _2025_12_09_00000005_create_general_categories_table,
  _2025_12_09_00000010_create_address_schema,
  _2025_12_09_00000015_create_address_countries_table,
  _2025_12_09_00000016_create_address_country_codes_table,
  _2025_12_09_00000020_create_address_states_table,
  _2025_12_09_00000021_create_address_state_codes_table,
  _2025_12_09_00000025_create_address_cities_table,
  _2025_12_09_00000026_create_address_city_codes_table,
  _2025_12_09_00000030_create_address_neighborhoods_table,
  _2025_12_09_00000035_create_address_streets_table,
  _2025_12_09_00000040_create_address_streettypes_table,
  _2025_12_09_00000045_create_address_addresses_table,
  _2025_12_09_00000050_create_person_schema,
  _2025_12_09_00000055_create_person_nationalities_table,
  _2025_12_09_00000060_create_person_persons_table,
  _2025_12_09_00000065_create_person_legals_table,
  _2025_12_09_00000070_create_person_naturals_table,
  _2025_12_09_00000075_create_person_addresses_table,
  _2025_12_09_00000080_create_person_emails_table,
  _2025_12_09_00000085_create_person_phones_table;

procedure RegisterMigrations;
begin
  // Migrations...
  RegisterMigration(TDbContext, CreateGeneralSchema);
  RegisterMigration(TDbContext, CreateGeneralCategoriesTable);
  RegisterMigration(TDbContext, CreateAddressSchema);
  RegisterMigration(TDbContext, CreateAddressCountriesTable);
  RegisterMigration(TDbContext, CreateAddressCountryCodesTable);
  RegisterMigration(TDbContext, CreateAddressStatesTable);
  RegisterMigration(TDbContext, CreateAddressStateCodesTable);
  RegisterMigration(TDbContext, CreateAddressCitiesTable);
  RegisterMigration(TDbContext, CreateAddressCityCodesTable);
  RegisterMigration(TDbContext, CreateAddressNeighborhoodsTable);
  RegisterMigration(TDbContext, CreateAddressStreetsTable);
  RegisterMigration(TDbContext, CreateAddressStreetTypesTable);
  RegisterMigration(TDbContext, CreateAddressAddressesTable);
  RegisterMigration(TDbContext, CreatePersonSchema);
  RegisterMigration(TDbContext, CreatePersonNationalitiesTable);
  RegisterMigration(TDbContext, CreatePersonPersonsTable);
  RegisterMigration(TDbContext, CreatePersonLegalsTable);
  RegisterMigration(TDbContext, CreatePersonNaturalsTable);
  RegisterMigration(TDbContext, CreatePersonAddressesTable);
  RegisterMigration(TDbContext, CreatePersonEmailsTable);
  RegisterMigration(TDbContext, CreatePersonPhonesTable);
  // DbSeed...
  RegisterDatabaseSeeder(TcbsMainDatabaseSeeder);
end;

end.
