connection: "jax-azure-adventureworks"

explore: leading_zero_dt {}


view: leading_zero_dt {
  derived_table: {
    sql: SELECT CAST('01234' as varchar) as some_string
    UNION SELECT CAST('12345' as varchar) as some_string;;
  }

  dimension: some_string {
    type: string
  }
}
