view: attendees {
  sql_table_name: public.attendees_d ;;

  dimension: accepted {
    type: string
    sql: ${TABLE}.accepted ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.comment ;;
  }

  dimension: email {
    type: string
    skip_drill_filter: yes
    sql: ${TABLE}.email ;;
  }

  dimension: event_id {
    type: number
    hidden: yes
    sql: ${TABLE}.event_id ;;
  }

  dimension:  pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${event_id} || ${email} ;;
  }

  dimension: optional {
    type: yesno
    sql: ${TABLE}.optional ;;
  }

  dimension: organizer {
    type: yesno
    sql: ${TABLE}.organizer ;;
  }

  dimension: resource {
    type: yesno
    sql: ${TABLE}.resource ;;
  }

  measure: count {
    type: count_distinct
    sql: ${email} ;;
    drill_fields: [email,accepted, comment,optional,organizer,resource]
  }
}
