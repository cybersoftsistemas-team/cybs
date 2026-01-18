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
  _00000001_00000001_create_general_schema,
  _00000001_00000100_create_general_categories_table,
  _00000001_00000200_create_country_schema,
  _00000001_00000300_create_country_countries_table,
  _00000001_00000400_create_country_codes_table,
  _00000001_00000500_create_country_nationalities_table,
  _00000001_00000600_create_address_schema,
  _00000001_00000700_create_address_states_table,
  _00000001_00000800_create_address_state_codes_table,
  _00000001_00000900_create_address_cities_table,
  _00000001_00001000_create_address_city_codes_table,
  _00000001_00001100_create_address_neighborhoods_table,
  _00000001_00001200_create_address_streets_table,
  _00000001_00001300_create_address_streettypes_table,
  _00000001_00001400_create_address_addresses_table,
  _00000001_00001500_create_person_schema,
  _00000001_00001600_create_person_persons_table,
  _00000001_00001700_create_person_legals_table,
  _00000001_00001800_create_person_naturals_table,
  _00000001_00001900_create_person_addresses_table,
  _00000001_00002000_create_person_emails_table,
  _00000001_00002100_create_person_phones_table;

procedure RegisterMigrations;
begin
  // Migrations...
  RegisterMigration(TDbContext, CreateGeneralSchema);
  RegisterMigration(TDbContext, CreateGeneralCategoriesTable);
  RegisterMigration(TDbContext, CreateCountrySchema);
  RegisterMigration(TDbContext, CreatecountryCountriesTable);
  RegisterMigration(TDbContext, CreateCountryCodesTable);
  RegisterMigration(TDbContext, CreateCountryNationalitiesTable);
  RegisterMigration(TDbContext, CreateAddressSchema);
  RegisterMigration(TDbContext, CreateAddressStatesTable);
  RegisterMigration(TDbContext, CreateAddressStateCodesTable);
  RegisterMigration(TDbContext, CreateAddressCitiesTable);
  RegisterMigration(TDbContext, CreateAddressCityCodesTable);
  RegisterMigration(TDbContext, CreateAddressNeighborhoodsTable);
  RegisterMigration(TDbContext, CreateAddressStreetsTable);
  RegisterMigration(TDbContext, CreateAddressStreetTypesTable);
  RegisterMigration(TDbContext, CreateAddressAddressesTable);
  RegisterMigration(TDbContext, CreatePersonSchema);
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
