connection: "thelook"

# include: "*.view.lkml"         # include all views in this project
# include: "*.dashboard.lookml"  # include all dashboards in this project
explore: date_ua {
  hidden: yes
}
view: date_ua {
  derived_table: {
    sql: SELECT created_at, COUNT(*) as thing FROM demo_db.orders
        WHERE created_at >= {% date_end created_at_date %} AND created_at >= {% date_start created_at_date %}
        GROUP BY 1;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: thing {
    type: number
    sql: ${TABLE}.thing ;;
  }
}
