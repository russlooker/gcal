connection: "thelook"

explore: test {
}

view: test  {
  derived_table: {
    sql:
      SELECT 'foo' as some_string, CURRENT_TIMESTAMP() as date_field
      UNION
      SELECT 'bar' as some_string, CURRENT_TIMESTAMP() as date_field
      UNION
      SELECT 'bar' as some_string, CURRENT_TIMESTAMP() as date_field
      UNION
      SELECT 'bar' as some_string, CURRENT_TIMESTAMP() as date_field
      ;;
  }

  dimension: some_string {}

  filter: some_filter {type: string}

  dimension: yesno_templated_filter {type: yesno  sql: {% condition some_filter %} ${some_string} {% endcondition %} ;;}

  measure: filtered_measure {type: count
    filters: {field: yesno_templated_filter  value: "yes"}}

}
