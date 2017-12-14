connection: "thelook"

explore: orders_other {
  from: orders
  hidden: yes
}


view: orders {
  sql_table_name: demo_db.orders ;;


  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: created_at {
    type: string
    sql: ${TABLE}.created_at ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    link: {
      label: "Click This"
      url: "https://google.com/{{user_id._value}}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  set: detail {
    fields: [id, created_at, user_id, status]
  }
}
# # Select the views that should be a part of this model,
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
