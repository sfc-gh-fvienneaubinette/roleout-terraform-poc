resource snowflake_role TEST_ROLE {
  name = "TEST_ROLE"
}

resource snowflake_role_grants role_test_role_grants {
  role_name = snowflake_role.TEST_ROLE.name

  enable_multiple_grants = true
  roles = [
    "SYSADMIN",
  ]
}