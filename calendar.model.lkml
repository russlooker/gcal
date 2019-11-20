connection: "faa_redshift"

# include all the views
include: "*.view"

# include all the dashboards

# include: "*.dashboard"



explore: events {
  join: attendees {
    type: left_outer
    sql_on: ${events.id} = ${attendees.event_id} ;;
    relationship: one_to_many
  }
  # join: permission_filter {
  #   type: left_outer
  #   sql_on:  ${events.id} = ${permission_filter.event_id} ;;
  #   relationship: one_to_one
  # }
  join: attendees_filter {
    type: inner
    sql_on:  ${events.id} = ${attendees_filter.event_id} ;;
    relationship: one_to_many
  }

}


explore: ts {
  join: events {
    type: left_outer
    sql_on:  ${ts.ts_minute15} = ${events.start_minute15};;
    relationship: one_to_many
  }
  join: attendees {
    type: left_outer
    sql_on: ${events.id} = ${attendees.event_id} ;;
    relationship: one_to_many
  }
  # Uncomment for obfuscation
  # join: permission_filter {
  #   type: left_outer
  #   sql_on:  ${events.id} = ${permission_filter.event_id} ;;
  #   relationship: one_to_one
  # }
  join: attendees_filter {
    type: inner
    sql_on:  ${events.id} = ${attendees_filter.event_id} ;;
    relationship: one_to_many
  }
}

explore: pdtliquidtest {}



explore: repro {}

view: repro {
  derived_table: {
    sql:
      SELECT 'arnold_palmer' as drink, 10 as price UNION ALL
      SELECT 'iced_tea', 9 UNION ALL
      SELECT 'coke__classic', 5 UNION ALL
      SELECT 'milk', 2 UNION ALL
      SELECT 'water', 0

    ;;
  }

  dimension: drink {
    type: string
    sql: ${TABLE}.drink ;;
    link: {
      label: "repro"
      url: "/dashboards/116?drink={{ _filters['repro.drink'] | url_encode }}&drink={{ value | url_encode }}"
      icon_url: "https://looker.com/favicon.ico"
    }
  }

  measure: price {
    type: sum
    sql: ${TABLE}.price ;;
  }


}
