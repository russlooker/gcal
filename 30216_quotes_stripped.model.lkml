connection: "calendar"
explore: test {
  hidden:  yes
}
view: test  {
  derived_table: {
    sql:
      SELECT 'one two "quotes on three"' as str, 1 as num
      UNION
      SELECT 'one "quotes on two" three' as str, 2 as num
      UNION
       SELECT '"quotes on one" two three' as str, 1 as num
      ;;
  }
  dimension: string_with_quotes
  {
    type: string
    sql: ${TABLE}.str ;;
  }
  dimension: num {
    type: number
  }
  measure: count
  {
    type: count
  }
}
