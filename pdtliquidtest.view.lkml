view: pdtliquidtest {
  derived_table: {
    sql: select * from public.attendees_d where {% parameter pdt_param %} > 10 ;;
    indexes: ["event_id"]
    sql_trigger_value: select current_date ;;
  }

  parameter: pdt_param {
    type: number
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.comment ;;
  }

  dimension: email {
    type: string
    #skip_drill_filter: yes
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

  dimension: is_external {
    type: yesno
    sql: ${email} !~* '.*looker.*' ;;
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

  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: pdtliquidtest {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
