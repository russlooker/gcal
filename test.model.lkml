connection: "thelook"



explore: users {
  hidden: yes
}
view: users {
  sql_table_name: demo_db.users ;;

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  measure: count {
    type: count_distinct
    sql: ${age} ;;
  }
}
explore: test_ndt {}
view: test_ndt {
  derived_table: {
    sql_trigger_value: SELECT NOW() ;;
    explore_source: users {column: age {}
      column: created_at_year { field: users.created_at_year }
      filters: {
        field: users.age
        value: ">50"
      }
    }
    indexes: ["created_at_year"]
  }
  dimension: age {
    type: number
  }
  dimension: created_at_year {
    type: date_year
  }
}



#
# Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
