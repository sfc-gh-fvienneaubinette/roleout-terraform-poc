resource snowflake_role TEST_DATABASE_TEST_SCHEMA_R_AR {
  name = "TEST_DATABASE_TEST_SCHEMA_R_AR"
}

resource snowflake_role TEST_DATABASE_TEST_SCHEMA_RW_AR {
  name = "TEST_DATABASE_TEST_SCHEMA_RW_AR"
}

resource snowflake_role TEST_DATABASE_TEST_SCHEMA_FULL_AR {
  name = "TEST_DATABASE_TEST_SCHEMA_FULL_AR"
}

resource snowflake_role TEST_WAREHOUSE_U_AR {
  name = "TEST_WAREHOUSE_U_AR"
}

resource snowflake_role TEST_WAREHOUSE_UM_AR {
  name = "TEST_WAREHOUSE_UM_AR"
}

resource snowflake_role TEST_WAREHOUSE_FULL_AR {
  name = "TEST_WAREHOUSE_FULL_AR"
}

resource snowflake_database_grant grant_usage_on_test_database_database {
  database_name = snowflake_database.TEST_DATABASE.name
  privilege = "USAGE"
  roles = ["TEST_DATABASE_TEST_SCHEMA_R_AR", "TEST_DATABASE_TEST_SCHEMA_RW_AR", "TEST_DATABASE_TEST_SCHEMA_FULL_AR", "TEST_DATABASE_TEST_SCHEMA_FULL_AR"]

  with_grant_option = false
  enable_multiple_grants = true
}

resource snowflake_schema_grant grant_usage_on_test_database_test_schema_schema {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "USAGE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  depends_on = [snowflake_role_grants.role_test_database_test_schema_r_ar_grants,snowflake_role_grants.role_test_database_test_schema_rw_ar_grants,snowflake_role_grants.role_test_database_test_schema_full_ar_grants,snowflake_role_grants.role_test_database_test_schema_full_ar_grants]

  with_grant_option = false
  enable_multiple_grants = true
}

resource snowflake_schema_grant grant_ownership_on_test_database_test_schema_schema {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  depends_on = [snowflake_role_grants.role_test_database_test_schema_full_ar_grants]

  with_grant_option = false
  enable_multiple_grants = true
}

module "TEST_DATABASE__TEST_SCHEMA_grant_SELECT_on_current_tables" {
  source = "./modules/snowflake-grant-all-current-tables"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "SELECT"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_table_grant grant_select_on_future_test_database_test_database__test_schema_tables {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "SELECT"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_INSERT_on_current_tables" {
  source = "./modules/snowflake-grant-all-current-tables"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "INSERT"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

module "TEST_DATABASE__TEST_SCHEMA_grant_UPDATE_on_current_tables" {
  source = "./modules/snowflake-grant-all-current-tables"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "UPDATE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

module "TEST_DATABASE__TEST_SCHEMA_grant_DELETE_on_current_tables" {
  source = "./modules/snowflake-grant-all-current-tables"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "DELETE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

module "TEST_DATABASE__TEST_SCHEMA_grant_REFERENCES_on_current_tables" {
  source = "./modules/snowflake-grant-all-current-tables"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "REFERENCES"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_table_grant grant_insert_on_future_test_database_test_database__test_schema_tables {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "INSERT"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

resource snowflake_table_grant grant_update_on_future_test_database_test_database__test_schema_tables {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "UPDATE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

resource snowflake_table_grant grant_delete_on_future_test_database_test_database__test_schema_tables {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "DELETE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

resource snowflake_table_grant grant_references_on_future_test_database_test_database__test_schema_tables {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "REFERENCES"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_OWNERSHIP_on_current_tables" {
  source = "./modules/snowflake-grant-all-current-tables"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_table_grant grant_ownership_on_future_test_database_test_database__test_schema_tables {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_SELECT_on_current_views" {
  source = "./modules/snowflake-grant-all-current-views"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "SELECT"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_view_grant grant_select_on_future_test_database_test_database__test_schema_views {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "SELECT"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_OWNERSHIP_on_current_views" {
  source = "./modules/snowflake-grant-all-current-views"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_view_grant grant_ownership_on_future_test_database_test_database__test_schema_views {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_USAGE_on_current_sequences" {
  source = "./modules/snowflake-grant-all-current-sequences"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "USAGE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_sequence_grant grant_usage_on_future_test_database_test_database__test_schema_sequences {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "USAGE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_OWNERSHIP_on_current_sequences" {
  source = "./modules/snowflake-grant-all-current-sequences"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_sequence_grant grant_ownership_on_future_test_database_test_database__test_schema_sequences {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_USAGE_on_current_stages" {
  source = "./modules/snowflake-grant-all-current-stages"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "USAGE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

module "TEST_DATABASE__TEST_SCHEMA_grant_READ_on_current_stages" {
  source = "./modules/snowflake-grant-all-current-stages"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "READ"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_stage_grant grant_usage_on_future_test_database_test_database__test_schema_stages {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "USAGE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

resource snowflake_stage_grant grant_read_on_future_test_database_test_database__test_schema_stages {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "READ"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

resource snowflake_stage_grant grant_write_on_future_test_database_test_database__test_schema_stages {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "WRITE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_stage_grant.grant_usage_on_future_test_database_test_database__test_schema_stages, snowflake_stage_grant.grant_read_on_future_test_database_test_database__test_schema_stages]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_WRITE_on_current_stages" {
  source = "./modules/snowflake-grant-all-current-stages"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "WRITE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

module "TEST_DATABASE__TEST_SCHEMA_grant_OWNERSHIP_on_current_stages" {
  source = "./modules/snowflake-grant-all-current-stages"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_stage_grant grant_ownership_on_future_test_database_test_database__test_schema_stages {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_USAGE_on_current_file-formats" {
  source = "./modules/snowflake-grant-all-current-file-formats"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "USAGE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_file_format_grant grant_usage_on_future_test_database_test_database__test_schema_file_formats {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "USAGE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_OWNERSHIP_on_current_file-formats" {
  source = "./modules/snowflake-grant-all-current-file-formats"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_file_format_grant grant_ownership_on_future_test_database_test_database__test_schema_file_formats {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_SELECT_on_current_streams" {
  source = "./modules/snowflake-grant-all-current-streams"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "SELECT"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_stream_grant grant_select_on_future_test_database_test_database__test_schema_streams {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "SELECT"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_OWNERSHIP_on_current_streams" {
  source = "./modules/snowflake-grant-all-current-streams"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_stream_grant grant_ownership_on_future_test_database_test_database__test_schema_streams {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_USAGE_on_current_procedures" {
  source = "./modules/snowflake-grant-all-current-procedures"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "USAGE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_procedure_grant grant_usage_on_future_test_database_test_database__test_schema_procedures {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "USAGE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_OWNERSHIP_on_current_procedures" {
  source = "./modules/snowflake-grant-all-current-procedures"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_procedure_grant grant_ownership_on_future_test_database_test_database__test_schema_procedures {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_USAGE_on_current_functions" {
  source = "./modules/snowflake-grant-all-current-functions"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "USAGE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_function_grant grant_usage_on_future_test_database_test_database__test_schema_functions {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "USAGE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_OWNERSHIP_on_current_functions" {
  source = "./modules/snowflake-grant-all-current-functions"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_function_grant grant_ownership_on_future_test_database_test_database__test_schema_functions {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "OWNERSHIP"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

module "TEST_DATABASE__TEST_SCHEMA_grant_MONITOR_on_current_tasks" {
  source = "./modules/snowflake-grant-all-current-tasks"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "MONITOR"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

module "TEST_DATABASE__TEST_SCHEMA_grant_OPERATE_on_current_tasks" {
  source = "./modules/snowflake-grant-all-current-tasks"
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name
  privilege = "OPERATE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]
  enable_multiple_grants = true
}

resource snowflake_task_grant grant_monitor_on_future_test_database_test_database__test_schema_tasks {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "MONITOR"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

resource snowflake_task_grant grant_operate_on_future_test_database_test_database__test_schema_tasks {
  database_name = snowflake_database.TEST_DATABASE.name
  schema_name = snowflake_schema.TEST_DATABASE__TEST_SCHEMA.name

  privilege = "OPERATE"
  roles = [snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name, snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name]

  on_future = true
  with_grant_option = false
  enable_multiple_grants = true
  depends_on = [snowflake_schema_grant.grant_ownership_on_test_database_test_schema_schema]
}

resource snowflake_warehouse_grant grant_usage_on_warehouse_test_warehouse {
  warehouse_name = snowflake_warehouse.TEST_WAREHOUSE.name
  privilege = "USAGE"

  roles = [snowflake_role.TEST_WAREHOUSE_U_AR.name, snowflake_role.TEST_WAREHOUSE_UM_AR.name]

  with_grant_option = false
  enable_multiple_grants = true
}

resource snowflake_warehouse_grant grant_monitor_on_warehouse_test_warehouse {
  warehouse_name = snowflake_warehouse.TEST_WAREHOUSE.name
  privilege = "MONITOR"

  roles = [snowflake_role.TEST_WAREHOUSE_UM_AR.name]

  with_grant_option = false
  enable_multiple_grants = true
}

resource snowflake_warehouse_grant grant_ownership_on_warehouse_test_warehouse {
  warehouse_name = snowflake_warehouse.TEST_WAREHOUSE.name
  privilege = "OWNERSHIP"

  roles = [snowflake_role.TEST_WAREHOUSE_FULL_AR.name]

  with_grant_option = false
  enable_multiple_grants = true
}

resource snowflake_role_grants role_test_database_test_schema_r_ar_grants {
  role_name = snowflake_role.TEST_DATABASE_TEST_SCHEMA_R_AR.name

  enable_multiple_grants = true
  roles = [
    "SYSADMIN",
  ]
}

resource snowflake_role_grants role_test_database_test_schema_rw_ar_grants {
  role_name = snowflake_role.TEST_DATABASE_TEST_SCHEMA_RW_AR.name

  enable_multiple_grants = true
  roles = [
    "SYSADMIN",
    snowflake_role.TEST_ROLE.name,
  ]
}

resource snowflake_role_grants role_test_database_test_schema_full_ar_grants {
  role_name = snowflake_role.TEST_DATABASE_TEST_SCHEMA_FULL_AR.name

  enable_multiple_grants = true
  roles = [
    "SYSADMIN",
  ]
}

resource snowflake_role_grants role_test_warehouse_u_ar_grants {
  role_name = snowflake_role.TEST_WAREHOUSE_U_AR.name

  enable_multiple_grants = true
  roles = [
    "SYSADMIN",
    snowflake_role.TEST_ROLE.name,
  ]
}

resource snowflake_role_grants role_test_warehouse_um_ar_grants {
  role_name = snowflake_role.TEST_WAREHOUSE_UM_AR.name

  enable_multiple_grants = true
  roles = [
    "SYSADMIN",
  ]
}

resource snowflake_role_grants role_test_warehouse_full_ar_grants {
  role_name = snowflake_role.TEST_WAREHOUSE_FULL_AR.name

  enable_multiple_grants = true
  roles = [
    "SYSADMIN",
  ]
}