resource snowflake_warehouse TEST_WAREHOUSE {
  name = "TEST_WAREHOUSE"
  warehouse_size = "XSMALL"
  initially_suspended = true
  max_cluster_count = 1
  min_cluster_count = 1
  auto_suspend = 30
  auto_resume = true
}