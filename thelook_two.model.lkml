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
    label: "Status Name"
    group_label: "Status Name Group"
    description: "This is a description"
    link: {
      label: "Click This"
      url: "https://o.essencedigital.com/campaign/{{campaign_slug._value}}/marketbudgets/{{media_plan_id._value}}/v/published (https://o.essencedigital.com/campaign/%7B%7Bcampaign_slug._value%7D%7D/marketbudgets/%7B%7Bmedia_plan_id._value%7D%7D/v/published) "
      icon_url: "https://o.essencedigital.com/img/logo/favicon.png"
    }
    drill_fields: [olive_io.io_id,olive_commitline.device]
    tags: ["id"]
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
