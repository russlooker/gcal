connection: "thelook"
week_start_day: tuesday

explore: test {
  label: "Testing Liquid"
  hidden: yes # IMPORTANT - keep explores hidden to avoid clutter
}


view: test  {
  derived_table: {
    sql:
      SELECT 'foo' as some_string,  as some_num
      UNION
    SELECT 'bar' as some_string, 2 as some_num
      UNION
    SELECT 'bar' as some_string, 3 as some_num
      UNION
      SELECT 'bar' as some_string, 4 as some_num
      ;;
  }

  dimension: some_string {
    type: string
  }

  dimension: some_num {
    type: number
  }

  measure: count {
    type: count
  }

  measure: average {
    type: average
    sql: ${some_num} ;;
    html: Count - {{ count._rendered_value}} <br>
      Average - {{value}};;
  }
}
