view: attendees_filter {
  derived_table: {
    sql:
      SELECT
        DISTINCT
          event_id
        FROM
          public.attendees_d AD
        WHERE
          1=1
          AND {% condition attendees_filter.email %} AD.email {% endcondition %}
          -- AND {% condition attendees.email %} AD.email {% endcondition %}
      UNION ALL
        SELECT
          DISTINCT
          id
        FROM
          public.events_d_o EDO
        WHERE
          1=1
          AND {% condition attendees_filter.email %} EDO.pulled_from {% endcondition %}
          -- AND {% condition attendees.email %} EDO.pulled_from {% endcondition %}

      ;;
  }

  dimension:  event_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.event_id ;;
  }

  filter: email {
    label: "Email Of Person There"
    description: "Allows you to filter to the events in which someone was present without impacting the attendee list"
    type: string
    suggest_dimension: attendees.email
    view_label: "Events"
  }

}
