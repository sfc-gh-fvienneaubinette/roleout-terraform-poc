resource snowflake_database TEST_DATABASE {
  name = "TEST_DATABASE"
  is_transient = false
}

resource snowflake_schema TEST_DATABASE__TEST_SCHEMA {
  database = snowflake_database.TEST_DATABASE.name
  name = "TEST_SCHEMA"
  is_managed = true
  is_transient = false
}