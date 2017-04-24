view: attendees_filter {
  derived_table: {
    sql:
      SELECT
        DISTINCT
          event_id
        FROM
          public.attendees_d AD
        WHERE
          -- { % condition attendees_filter.email % } AD.email { % endcondition % }
          {% condition attendees.email %} AD.email {% endcondition %}
      ;;
  }

  dimension:  event_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.event_id ;;
  }

  filter: email {
    hidden: yes
    type: string
    suggest_dimension: attendees.email
    view_label: "Attendees"
  }

}
